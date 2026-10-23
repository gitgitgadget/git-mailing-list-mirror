Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792763629;
	b=rIvv+NQzgyEzs4ljttK7l1E2VTDaPzP3uViUL1vqNuLKM0fWtRcnpBcjSyN8a/xIry4V
	 k9dlPbEYOJscBre6wH5LV6H3r6qnm9W3EhP9zazkxtSB/BF8kxbgNswJyljIQMNN7n7uw
	 jdGZlL1U+OVjJNmxyQ+Jiskn4hlTD+bRzUjQ/7TU4N9LqVBzvxiGBRHnYKjqDT9lRXMFY
	 RSgEkXqmjca2k/OKVIKogazUqyFrsvgiNHeGB3Kq7y4F4/9kt7r9Wyl3hTZX6qRWEy2Rs
	 6RwXFpEtngKaXmsAJx2ym25HPEi79chomy6tVInKukNxK2ryjCQB/g04ZSZgIfv6G9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=pnG2RcVGNhpHBzN6nYHBmRZj6WRnn0pqu03aUo6S9cQ=;
	b=eyHO8/eAQ5ph+Xp3mh6QLp9e8d2g29VvpRYIT4VEYb2QzzLzQbnB0XsZ2o25VWFFgEgZ
	 KDixDx3HAMMatbD8FxRSHmldfwWuxz1q2qeNJrK1F3iYxLjJQta6w4U2gjc44mKkEwNjs
	 SoImv2j67y8jGE2uLtIs7loHSKkaTB8PY6p8KkODBKO9wId4kP+2JEr3Oz/Y1PFMMKg+j
	 7VFyt61OrUTl26D+cEyp3Q0LiNnQGaVXgwcFXO83ZIcpX7fNgoLuNQm9ufYOP0iXqMP5w
	 UMbvx0E3FdF+LvLNyjtSBzq5PKpI3BjIRs/EVeIj7cXMUyKoTa/KYmXqgmHjPIHP7cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a+59HQDV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237E4606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 237E4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a+59HQDV
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6ac76a02368so1174228a12.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 06:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792763627; cv=none;
        d=google.com; s=arc-20260327;
        b=of6BAvgI1IVkAZj5bb1cnfiFjUov4F8J9yVyPxGw6cWu9hQAHXj9GUbliv7WiQxpQK
         7g4Q0JcChC57vy8ybNK14VIhtRvgni2tyPm1WYc/04Fs1pcT5zUP4k+AkAg6l02u7wTJ
         f3InBHjvNRTxbb+xCTTzEt9L5F0qdKlAvU3FJyltv61ScFn1VdJClbLBZUAwG4Wzbr1L
         dBuItBsZRWZSLBHKOuLrnSfI3Kec9VdYDX1uiwhmmT64E7daapVuYgl9cXIWMcm1cHBS
         ZCB3rfERoRxMHt0XNa9NSk2VBip8jrH7EgKkVucFyYSBZMRblCE7HMLpvr5lKGvfd/ra
         VlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=pnG2RcVGNhpHBzN6nYHBmRZj6WRnn0pqu03aUo6S9cQ=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=SNMQlY+iWDN/XDs7ZROPHAsr7LS1j09FdtVgtIcsMji+h6hbLAAJ4D3v/GBWVBxT2g
         CrUd15YYXjOPHojJ8MT2nC4Ik8JQHNp2Oe9xSnsTBGPF8MffV901illvh6VSbSFXGbHl
         0Z9/tmIe4ieZPUrpR+eUWhMGmE4/kYxvsJ0f6EoVysSviqFC/dA3/4M4X9OIfVl5fa/c
         fLznkgo3inE4cuoYSOGVTxJK+jp2nxO8GNB8v7gdT67OeQLsFa0vmnMzzlmF9a/rA5Z/
         KDjEVHU6F0zaMIk4fVFF/0LfhM017VWNQSpM7lHrI87s2Zyt0SJ61TmTtq8y5NZtvxTM
         eK+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792763627; x=1793368427; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pnG2RcVGNhpHBzN6nYHBmRZj6WRnn0pqu03aUo6S9cQ=;
        b=a+59HQDV8w+tBJhkZCjVmHJ5FpHK8+i3PPS1phOqHAIDNHBjp5jOWs+PSwcuiEpiqf
         ZDFnPZ/RvgWoRAwpR3/6I1WKAL5RH6l/y1uUATiylR4ggVk5Dbwa3jH0Y+TLDwZ6b5yC
         dNt2wmyl7ok7cDUunlsOCFUUGujrXy3KRRDCZQyqLysUN7dC4UDIzNF9IYcHNBwvPPNq
         QValdIEOPU6Xp2rdbviickk9Uv4rZSRsQlz6xyxopZjEdv43xE6NCCZKsb4q5lBYXNTw
         7YlZuLnvE4vItao6RY83I7ZGugw33+QWyWEP06GSm9apb0UfQhxE3IkBoJXkQ9ot7gCJ
         s1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792763627; x=1793368427;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pnG2RcVGNhpHBzN6nYHBmRZj6WRnn0pqu03aUo6S9cQ=;
        b=TGOT1YQIvZ475mbTSeC8fw5lt8mLxOsKqunMa1sXoAgjOX5K6NTVCoTABgDjZIALdG
         qWz96eMW+oNxc1m2oAqEnZpWhuvhFzHmoaDqhiuCZ+FcDvsONaQFfFnfxEzczZmf3/Km
         CehkM7QXQCihf3ZnUqb89XXiBAclQ92AKDivT4DxLpWuBwoBPNNPcQLm3Z5uT6TH+24g
         OM1rgH3zuoHUL8WWKz18f/8baN6lcusuNpbPxO21+LOuYq9F03W0vCpmcOF+66Lsic8l
         4c2iYa4C+ZJm0JgIkuCaUWXpjSmpLLFpCLKS8eI2uGvP77ICuFTaL1VtYOanSvaKf6Ue
         TkUQ==
X-Gm-Message-State: AFq9FYIWSkCz2dxPTEgNUMyQhaCscX3wsj0MfDzrpv46Uuc793DMxdUt
	vhY2Xtd81AJ2YQu09QU6syWUWEVuXrvKPKuNjh7VLEV75TkFqFHVm/vUmHrC1Sx6Lh84XW4VO9G
	BTkix3bmkYsRt22y3/Icgx7uVF/o58cO8JL1t
X-Gm-Gg: AYBFou06VWT9bfWgrlJEQUD9pA62V52N1fAiD4J8vImjJ/8UM5SXXGDQ+M1M8fGUpH7
	8ykRtEpKlnC6t+R8HMxZ4rlPgSGZaETTVbCYiwSvauXLT+1QKBwF7Q+L7uV8V609FsR/r003X1K
	TGMhrUbcFXKKgNZXirTqB5D0Uf3AhKzk/hdHdOOCQ5fAYWRKXr9U5bwPddvHd6Sejh649uBi7PP
	HPQaDnMrx7duOnttIcONeKeqzw+F3rmG67/qOtH7AzsRpiEVlSLnHS0RLaDFv5CL7KLx05NuAVj
	x0Ke7be2pZj3PycmL5ndc8rGlE1sOsbgKjMUXHZMTrfSzX6yHF1KsHzdAp/r8AhkRzxLH6qN50Z
	Rpvdz7NuDNmkQzpKkGnMweP1yjfrOApS95rop
X-Received: by 2002:a05:6402:4407:b0:6b1:eeef:3765 with SMTP id
 4fb4d7f45d1cf-6b432bf12camr4018174a12.17.1792763627303; Fri, 23 Oct 2026
 06:53:47 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?Q?Hannes_Brandst=C3=A4tter=2DM=C3=BCller?= <hannes.mueller@gmail.com>
Date: Fri, 23 Oct 2026 15:53:30 +0200
X-Gm-Features: AclHuK_A18p2u5eTzFJZiRqMveoFn7tYdkBLqvrk_kdj13oU4FbgfPTQ2nDW9G8
Message-ID: <CANuH12niCO_tU+=dikanZ9Wf30NFsz4jpnZBXW6OyeQfD26jtg@mail.gmail.com>
Subject: [BUG] git apply: pure rename followed by edit fails with core.fileMode=false
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000002c3d90065e824fc3"

--0000000000002c3d90065e824fc3
Content-Type: text/plain; charset="UTF-8"

Hi Git developers,

I would like to report a possible regression in git apply and ask
for your help with a fix.

With core.fileMode=false, applying a patch series containing a pure
rename followed by an edit to the renamed file fails with:

    error: renamed: wrong type

I encountered this while checking a series generated by
git format-patch. Here is a small reproduction, to run in a temporary
directory with a Git author identity configured:

    git init -q repro && cd repro
    git config core.fileMode false
    printf 'a\nb\nc\n' >file
    git add file && git commit -q -m base
    git mv file renamed && git commit -q -m rename
    sed s/b/B/ renamed >tmp && mv tmp renamed
    git commit -q -a -m edit
    git format-patch --stdout HEAD~2 >series.patch
    git checkout -q HEAD~2
    git apply --check series.patch

I expected the check to succeed, since the series renames the file
and then edits it. Instead, it reports the error above. Applying the
patches separately succeeds, as does checking the combined series
with core.fileMode=true.

Our testing reproduced the failure with Git for Windows 2.55.0,
source-built v2.45.0, and master at 7e34d8174
(2.56.0.236.g7e34d8174). Source-built v2.44.0 and Ubuntu's Git 2.34.1
did not show the problem.

The behavior appears related to 0482c32c33 ("apply: ignore working
tree filemode when !core.filemode, 2023-12-26"), although we have not
confirmed that with a bisect.

Our reading of check_preimage() suggests that the pure rename has
no mode information, leaving previous->new_mode as zero. The later
edit then uses that zero mode and fails the file-type comparison.

The attached patch is a tentative fix, with a regression test. It
falls back to patch->old_mode when previous->new_mode is zero.
I am not familiar enough with this code to be confident that this
is the right approach, so I would appreciate a review of both the
diagnosis and the proposed change.

With this change, our tests passed for both a regular file and an
executable file, without a mode warning. The new regression test
failed without the fix and passed with it. The t41* and t42* tests
also completed with 1,524 passed, no failures, and 12 known
breakages.

Could someone please take a look and help get an appropriate fix
upstream? If I have misunderstood the expected behavior or missed
an existing fix, I would appreciate being pointed in the right
direction.

Thank you for your time and for maintaining Git.

Best regards,
Hannes

--0000000000002c3d90065e824fc3
Content-Type: text/plain; charset="US-ASCII"; name="git-apply-pure-rename-upstream.patch"
Content-Disposition: attachment; 
	filename="git-apply-pure-rename-upstream.patch"
Content-Transfer-Encoding: base64
Content-ID: <>
X-Attachment-Id: 

ZGlmZiAtLWdpdCBhL2FwcGx5LmMgYi9hcHBseS5jCmluZGV4IGEwYjcxMTljNi4uZWNkNDg5Mzkx
IDEwMDY0NAotLS0gYS9hcHBseS5jCisrKyBiL2FwcGx5LmMKQEAgLTM4NzMsNiArMzg3MywxMyBA
QCBzdGF0aWMgaW50IGNoZWNrX3ByZWltYWdlKHN0cnVjdCBhcHBseV9zdGF0ZSAqc3RhdGUsCiAJ
CXJldHVybiBlcnJvcihfKCJwYXRoICVzIGhhcyBiZWVuIHJlbmFtZWQvZGVsZXRlZCIpLCBvbGRf
bmFtZSk7CiAJaWYgKHByZXZpb3VzKSB7CiAJCXN0X21vZGUgPSBwcmV2aW91cy0+bmV3X21vZGU7
CisJCS8qCisJCSAqIFdpdGhvdXQgY29yZS5maWxlTW9kZSBhIHB1cmUgcmVuYW1lIG1heSBub3Qg
a25vdyBpdHMgbW9kZQorCQkgKiAoc2VlIGJlbG93KTsgdGFrZSB0aGUgb25lIHRoaXMgcGF0Y2gg
ZXhwZWN0cywgYXMgd2UgZG8gZm9yCisJCSAqIGEgcGF0aCByZWFkIGZyb20gdGhlIHdvcmtpbmcg
dHJlZS4KKwkJICovCisJCWlmICghc3RfbW9kZSkKKwkJCXN0X21vZGUgPSBwYXRjaC0+b2xkX21v
ZGU7CiAJfSBlbHNlIGlmICghc3RhdGUtPmNhY2hlZCkgewogCQlzdGF0X3JldCA9IGxzdGF0KG9s
ZF9uYW1lLCBzdCk7CiAJCWlmIChzdGF0X3JldCAmJiBlcnJubyAhPSBFTk9FTlQpCmRpZmYgLS1n
aXQgYS90L3Q0MTI5LWFwcGx5LXNhbWVtb2RlLnNoIGIvdC90NDEyOS1hcHBseS1zYW1lbW9kZS5z
aAppbmRleCAxZDYzMTdiZDcuLjQ1ZGVlNzE3YSAxMDA3NTUKLS0tIGEvdC90NDEyOS1hcHBseS1z
YW1lbW9kZS5zaAorKysgYi90L3Q0MTI5LWFwcGx5LXNhbWVtb2RlLnNoCkBAIC00MTIsNCArNDEy
LDI3IEBAIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgUE9TSVhQRVJNICdwYXRjaCBtb2RlIGZvciBtb2Rl
IGNoYW5nZSBpcyBjYW5vbmljYWxpemVkJyAnCiAJdGVzdF9ncmVwICJeLXJ3eHJ3eHJ3eCIgd29y
a3RyZWUKICcKCit0ZXN0X2V4cGVjdF9zdWNjZXNzICdhcHBseSBhIHB1cmUgcmVuYW1lIGZvbGxv
d2VkIGJ5IGFuIGVkaXQgd2l0aCBjb3JlLmZpbGVNb2RlPWZhbHNlJyAnCisJdGVzdF93aGVuX2Zp
bmlzaGVkICJybSAtcmYgcmVuYW1lLXRoZW4tZWRpdCBzZXJpZXMucGF0Y2giICYmCisJZ2l0IGlu
aXQgcmVuYW1lLXRoZW4tZWRpdCAmJgorCSgKKwkJY2QgcmVuYW1lLXRoZW4tZWRpdCAmJgorCQln
aXQgY29uZmlnIGNvcmUuZmlsZU1vZGUgZmFsc2UgJiYKKwkJdGVzdF93cml0ZV9saW5lcyBhIGIg
YyA+ZmlsZSAmJgorCQlnaXQgYWRkIGZpbGUgJiYKKwkJdGVzdF90aWNrICYmIGdpdCBjb21taXQg
LW0gYmFzZSAmJgorCQlnaXQgbXYgZmlsZSByZW5hbWVkICYmCisJCXRlc3RfdGljayAmJiBnaXQg
Y29tbWl0IC1tIHJlbmFtZSAmJgorCQl0ZXN0X3dyaXRlX2xpbmVzIGEgQiBjID5yZW5hbWVkICYm
CisJCXRlc3RfdGljayAmJiBnaXQgY29tbWl0IC1hIC1tIGVkaXQgJiYKKwkJZ2l0IGZvcm1hdC1w
YXRjaCAtLXN0ZG91dCBIRUFEfjIgPi4uL3Nlcmllcy5wYXRjaCAmJgorCQlnaXQgY2hlY2tvdXQg
SEVBRH4yICYmCisJCWdpdCBhcHBseSAtLWNoZWNrIC4uL3Nlcmllcy5wYXRjaCAmJgorCQlnaXQg
YXBwbHkgLi4vc2VyaWVzLnBhdGNoICYmCisJCXRlc3Rfd3JpdGVfbGluZXMgYSBCIGMgPmV4cGVj
dCAmJgorCQl0ZXN0X2NtcCBleHBlY3QgcmVuYW1lZCAmJgorCQl0ZXN0X3BhdGhfaXNfbWlzc2lu
ZyBmaWxlCisJKQorJworCiB0ZXN0X2RvbmUK
--0000000000002c3d90065e824fc3--
