Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161E439B97E
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 07:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717072; cv=pass; b=bK1IcH+1W10a81/Hd8i/SclsuC2IiEEEVKhVaN11iKaNlgvH9QN/W6K0bFFqsrgwOt2cBuvIOnp2p0NDb1AM8Gvp34NKrg2yq+jtLVHoo3XklHQwJj5JaYrANfw5QiSmHP+2CpUwrolTBE8nU2RpOJnpIKt8BPsNsIdYU0+PvoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717072; c=relaxed/simple;
	bh=Fe8TSRf0Gev+AadNGY2SRRqkZLTLTxMj3ODsTgdSU2A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=b969+ZY1ivP6seYtpdULylMLZL42CyTGuwX7hS1nDaYSZSovx/gfOasE5QCMHLEbRKmpM1U86/3Qfc2Jm3VFMSbkpdhA22SnMZmp0hjh256jm+EL/7ePUB1oVAn5a7xXuJYMNPMdipNsbd+yr276eUOdbg/KtIuEvv03N/LrbEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qx/wAa3U; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qx/wAa3U"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7387ac7d28cso191180137.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 00:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782717070; cv=none;
        d=google.com; s=arc-20260327;
        b=Yv3knucFsPuFwl8+UaaEtK9sM8YJM5KzoinwtC52HVnoUizkfZfNb4QBpG6+ebWQu1
         H45Sgs6c3f5F8pyAg2Rx7/0xjstYjr9EIAFM+9PapcesAhJVe3esFMOqMDGGnduZol5Z
         3WrfRCX8z6jxmgfAvW9Jgtsd27YGQ4d309ErTqKq9vonUsqEEYG8OtmDuHbov5bSjYPE
         7QOehTBfaGdnidAHFt4FALRq+fMejSsLGfo1sciVqwXykBN0PQH56ft7qna8InpfCx5F
         Nr6JKwPRH0mNm2rjLfBBKOS5758kb7wkvrGuYjJlQrBKLFuNPNsLaAbXX7COHrTIMwv0
         sAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=hTmUZwdkwJO25SwADrDneHtv4wzwJXBypxzalNstcVM=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=SBcC4VooWxpu3mdjyEmXa8jnIoOJmZwJdpGNXEe2lufT+rmL0TjEJNDXxym6PSdbuu
         EjkugYgmekKIHsCEciFnvcbBw9NiP993ZBPeW6qegnpxjzyYLePSzcoi/u4ymDCj3zMY
         twjHOh5HgX24JKOkZCbPBQR/Kh31gl5zpzSjZ3cCZoFX0Al3b+SiPkjfiq+Obbx8ySAQ
         0/t/LSklMHBE6cirB9eqg+d2oLvwHIBvEjMswTwEX70QlE8BrvRL8SX+luZJjzxGQNxQ
         7pW4VIuII6yiYpoPfgDpbLMRU3tpso1pgAixstcw151EjxROpzS/4NNNYWGhMelOyy13
         ErjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782717070; x=1783321870; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hTmUZwdkwJO25SwADrDneHtv4wzwJXBypxzalNstcVM=;
        b=Qx/wAa3U4ytRiU1JR66/wjXaVLUwZvllHZReHHt1COs/FLNPIMGzIjPZiH930xY5ga
         DoYvLWpQu5Jrx11Q2CYpHRUA3MNyiGQEmpVjHIbStbPjA3NcwmCl5UYgrU9D9B/LmK0+
         nWw636iZ6df/+BAcFFOMutgpNqEtU/jIbqgYvWG0m2kXCHPiFch00hUM5EPMeffANZRs
         BQ70w/QMnz5owZ7TWG2yguv8/z4UgR6tS02oun9Dyn/Ssbxt5TVjvp+5glHtTUahfMyU
         jfjSCp5nv4CtFoQcOXuxX43tm1YrOs4Mq8z0K2imqOw0zJjx+dgXBT5+PK4GlXxf86/p
         y2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782717070; x=1783321870;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hTmUZwdkwJO25SwADrDneHtv4wzwJXBypxzalNstcVM=;
        b=hYy2F9auZy6JQB6vIPmTS25TNz6a04rrZ8JEJoH7jZGZKsoEBggPAEJE0ZWCi7scba
         A0i4C8CoNEU6m+lk2eLWdsa6lYBl8TFwOajw9MlVb5U/QjSfAItuxN1t+KOX63aTZavN
         9qnARNRCvDjkNqjzGBKXtf3ih0pC+MOEHSDP+mVaqUe1a94ppNCDBF6KGl7JJSoREK9D
         CrFn3XyhxagmQxvGQosalvjoEHZvujfhS3WIZhe4X4T0cqbDl/WIselE0yAz52YYJyzA
         JFb9BsdmketRIDATlOEqtvDNQA9KKDQI8dOFPxRt13Q8PjaFh61i156lj5oYjeRsIu6J
         SYbA==
X-Gm-Message-State: AOJu0YzTzKhQcQsHTe1hHGyA5RoI/3ajUownoo8nPoyUX4BKRFNOjf99
	aelH1/kIyhhINyDYn+5UJC4OCUH21+mUwX784A2XXEJW2uPniUFRe9Bb8sFOyJULfxDnKiO0zkh
	wbBoO9WecrGMSDwuU3QENmY80oMM95Wr4rdLG+9A=
X-Gm-Gg: AfdE7clLw6RjZeDRfHPWqhmCqHoOu++SkKBV8X6SO3s9HZt03Dxz3LWC9JgRyFqpXk6
	3ydbDqjFaDiMx9UTIba701ZEOTN8sAg3BYlO7bJwg5KVlKUGFHL2A2hCbG6NupCpKMM++PrAHo/
	jfP+qn/sQQdFreuq4dvXlpbwaOPzYEAnRZLTCpwcSpfFAi44cdjfQ9XOITD1EElgd3qhnOBA6Uy
	NpqLRyA+67TboVHeKHf2gkz5hAgsLKoElYjFlb8pe3XFRWWDxZnhrnyDhVjAdbI66JO75AbBNFc
	VCpo1w==
X-Received: by 2002:a05:6102:3e83:b0:728:f34d:f410 with SMTP id
 ada2fe7eead31-7343464c372mr6497727137.7.1782717069960; Mon, 29 Jun 2026
 00:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Wei Hu <weihu.math@gmail.com>
Date: Mon, 29 Jun 2026 15:10:42 +0800
X-Gm-Features: AVVi8CdE04uQCGSUsQFYnZO3hT86vuSP9pUlkQB_dSC7CX_IgmiWZweFWnARe1A
Message-ID: <CACLXMtCSzW9BY7idqB1yGa87MeG0Y2FN5Ho2hRXuPJ_qswE27Q@mail.gmail.com>
Subject: receive-pack hangs on zero-object push into promisor-shaped repository
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b0c41f06555f2999"

--000000000000b0c41f06555f2999
Content-Type: multipart/alternative; boundary="000000000000b0c41e06555f2997"

--000000000000b0c41e06555f2997
Content-Type: text/plain; charset="UTF-8"

Hello,

I found a reproducible hang in `git receive-pack` when pushing a ref update
that sends zero objects into a repository that has promisor remote
configuration and `.promisor` pack sidecar files.

The same zero-object ref update returns normally when the receiving
repository
is a normal non-bare repository or a bare repository. It also returns
normally
if I remove either the promisor remote config or the `.promisor` sidecar
files
from the receiving repository.

Check the attached script to reproduce the bug.

Environment:

  git version 2.54.0
  cpu: x86_64
  no commit associated with this build
  sizeof-long: 8
  sizeof-size_t: 8
  shell-path: /bin/sh
  rust: disabled
  gettext: enabled
  libcurl: 8.5.0
  zlib: 1.3
  SHA-1: SHA1_DC
  SHA-256: SHA256_BLK
  default-ref-format: files
  default-hash: sha1

  OS: Ubuntu 24.04.4 LTS (Noble Numbat)

--000000000000b0c41e06555f2997
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>I found a reproducible hang in `git receive-=
pack` when pushing a ref update<br>that sends zero objects into a repositor=
y that has promisor remote<br>configuration and `.promisor` pack sidecar fi=
les.<br><br>The same zero-object ref update returns normally when the recei=
ving repository<br>is a normal non-bare repository or a bare repository. It=
 also returns normally<br>if I remove either the promisor remote config or =
the `.promisor` sidecar files<br>from the receiving repository.<div><br></d=
iv><div>Check the attached script to reproduce the bug.<br><br>Environment:=
<br><br>=C2=A0 git version 2.54.0<br>=C2=A0 cpu: x86_64<br>=C2=A0 no commit=
 associated with this build<br>=C2=A0 sizeof-long: 8<br>=C2=A0 sizeof-size_=
t: 8<br>=C2=A0 shell-path: /bin/sh<br>=C2=A0 rust: disabled<br>=C2=A0 gette=
xt: enabled<br>=C2=A0 libcurl: 8.5.0<br>=C2=A0 zlib: 1.3<br>=C2=A0 SHA-1: S=
HA1_DC<br>=C2=A0 SHA-256: SHA256_BLK<br>=C2=A0 default-ref-format: files<br=
>=C2=A0 default-hash: sha1<br><br>=C2=A0 OS: Ubuntu 24.04.4 LTS (Noble Numb=
at)<br><div><br></div></div></div>

--000000000000b0c41e06555f2997--
--000000000000b0c41f06555f2999
Content-Type: text/x-sh; charset="US-ASCII"; name="git-promisor-zero-object-push-repro.sh"
Content-Disposition: attachment; 
	filename="git-promisor-zero-object-push-repro.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_mqyvoj3p0>
X-Attachment-Id: f_mqyvoj3p0

IyEvYmluL3NoCnNldCAtZXUKCkdJVD0ke0dJVDotZ2l0fQpST09UPSQobWt0ZW1wIC1kICIke1RN
UERJUjotL3RtcH0vZ2l0LXByb21pc29yLXB1c2gtaGFuZy5YWFhYWFgiKQpTUkM9JFJPT1Qvc3Jj
CkRTVD0kUk9PVC9kc3QKVVBTVFJFQU09JFJPT1QvdXBzdHJlYW0uZ2l0ClRSQUNFPSRST09UL3Ry
YWNlLmxvZwoKZWNobyAicm9vdDogJFJPT1QiCmVjaG8gImdpdDogJCgkR0lUIC0tdmVyc2lvbiki
CgokR0lUIGluaXQgLXEgIiRTUkMiCiRHSVQgLUMgIiRTUkMiIGNvbmZpZyB1c2VyLm5hbWUgUmVw
cm8KJEdJVCAtQyAiJFNSQyIgY29uZmlnIHVzZXIuZW1haWwgcmVwcm9AZXhhbXBsZS5pbnZhbGlk
CgpwcmludGYgQSA+IiRTUkMvZmlsZSIKJEdJVCAtQyAiJFNSQyIgYWRkIGZpbGUKJEdJVCAtQyAi
JFNSQyIgY29tbWl0IC1xIC1tIEEKJEdJVCAtQyAiJFNSQyIgYnJhbmNoIHRvcGljCk9MRD0kKCRH
SVQgLUMgIiRTUkMiIHJldi1wYXJzZSB0b3BpYykKCnByaW50ZiBCID4iJFNSQy9maWxlIgokR0lU
IC1DICIkU1JDIiBjb21taXQgLXEgLWFtIEIKJEdJVCAtQyAiJFNSQyIgYnJhbmNoIC1NIG1haW4K
TkVXPSQoJEdJVCAtQyAiJFNSQyIgcmV2LXBhcnNlIG1haW4pCgokR0lUIGNsb25lIC1xIC0tYmFy
ZSAiJFNSQyIgIiRVUFNUUkVBTSIKJEdJVCBpbml0IC1xICIkRFNUIgokR0lUIC1DICIkRFNUIiBj
b25maWcgcmVjZWl2ZS5kZW55Y3VycmVudGJyYW5jaCB1cGRhdGVJbnN0ZWFkCiRHSVQgLUMgIiRT
UkMiIHB1c2ggLXEgIiREU1QiIG1haW46bWFpbiB0b3BpYzp0b3BpYwokR0lUIC1DICIkRFNUIiBj
aGVja291dCAtcSBtYWluCgokR0lUIC1DICIkRFNUIiBjb25maWcgcmVtb3RlLm9yaWdpbi51cmwg
ImZpbGU6Ly8kVVBTVFJFQU0iCiRHSVQgLUMgIiREU1QiIGNvbmZpZyByZW1vdGUub3JpZ2luLnBy
b21pc29yIHRydWUKJEdJVCAtQyAiJERTVCIgY29uZmlnIHJlbW90ZS5vcmlnaW4ucGFydGlhbGNs
b25lZmlsdGVyIGJsb2I6bm9uZQokR0lUIC1DICIkRFNUIiBnYyAtcQpmb3IgcGFjayBpbiAiJERT
VCIvLmdpdC9vYmplY3RzL3BhY2svKi5wYWNrCmRvCgk6ID4iJHtwYWNrJS5wYWNrfS5wcm9taXNv
ciIKZG9uZQoKJEdJVCAtQyAiJERTVCIgdXBkYXRlLXJlZiByZWZzL2hlYWRzL3RvcGljICIkT0xE
IgoKc3RhdHVzPTAKdGltZW91dCAtLWtpbGwtYWZ0ZXI9MnMgOCBcCgllbnYgR0lUX1RSQUNFPTEg
R0lUX1RSQUNFX1BBQ0tFVD0xIFwKCSRHSVQgLUMgIiRTUkMiIHB1c2ggLS1wb3JjZWxhaW4gIiRE
U1QiIEhFQUQ6dG9waWMgXAoJPiIkVFJBQ0UiIDI+JjEgfHwgc3RhdHVzPSQ/CgpBRlRFUj0kKCRH
SVQgLUMgIiREU1QiIHJldi1wYXJzZSByZWZzL2hlYWRzL3RvcGljKQpaRVJPX1BBQ0s9bm8KZ3Jl
cCAtcSAtLSAnLS1wYWNrX2hlYWRlcj0yLDAnICIkVFJBQ0UiICYmIFpFUk9fUEFDSz15ZXMKCmVj
aG8gIm9sZDogJE9MRCIKZWNobyAibmV3OiAkTkVXIgplY2hvICJhZnRlcjogJEFGVEVSIgplY2hv
ICJwdXNoIHN0YXR1czogJHN0YXR1cyIKZWNobyAiemVyby1vYmplY3QgcGFjayBvYnNlcnZlZDog
JFpFUk9fUEFDSyIKZWNobyAidHJhY2U6ICRUUkFDRSIKCmlmIHRlc3QgIiRzdGF0dXMiID0gMTI0
ICYmIHRlc3QgIiRBRlRFUiIgPSAiJE9MRCIgJiYgdGVzdCAiJFpFUk9fUEFDSyIgPSB5ZXMKdGhl
bgoJZWNobyAiQlVHIFJFUFJPRFVDRUQiCglleGl0IDAKZmkKCmVjaG8gIkJVRyBOT1QgUkVQUk9E
VUNFRCIKZXhpdCAxCg==
--000000000000b0c41f06555f2999--
