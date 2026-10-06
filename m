Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBB93D9549
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791320346; cv=pass; b=YHPr07QQB9YMC66/ICj6v36W1nEwRlz/BeKmU9VfithyynJjVmhOCsutUs0vSOsaQ2TiNpT52cmLQFz3myPX4we820Hx31XqXg+1XKZ+ROzha+1rZ57n+n60og+BrdrGscBw7NvoFXWUnxNDtavFlm2LwjFJcqDXyC0dx8dHh58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791320346; c=relaxed/simple;
	bh=LrYRA/5xAKk90m093Jd3R46Fi1oIbkZ+6mO/6jbHzAc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghNigwyb5pgOLeKYF5Me4jn1uQVPV7gV1Vp5vzLvVDhdqQEA+vA9ZqAzMx0mHJGKBsfrAhaiOBeBI+j5/6x6wLuAaNhA0fDP+v7wtMFMKNI6Kx/d8anQOrkjOiHPR9l53QRcoUIPq4dccsRhtzUDEgUPQ8k/DK6RLJrTgZ2O82o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/BRugUB; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/BRugUB"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-98c67e94e53so1637963241.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 13:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791320344; cv=none;
        d=google.com; s=arc-20260327;
        b=kmrk1xowRsbFAW84CPeJKu7cWgKmwkslj8qQqDAebZLaiD1zv9vAbO0lDkBrujPHnk
         kEYM86HcqNUCRDvau+Sc6Zm8Bschm4c0Zco1w1T6gVNgZHMRchUoSWtW7Hfs406T7C3x
         /3Nw0J3Sfyatl1x8TIiz523PNRjXI68C6u7tJBOaF0/bMZ/Swej+nd/y0Bn1c238NHSA
         /oPAaazTD8L+Cvnv02x/TPXqY/hrib6qoADIWlyayFNV+eU3y+EI6kqOXtkA3p3onIHc
         aqMbc8E1W16NJRsoobCL887XN4Aar/LEGrh11SASzjHUgE9S4tDE0Hh+HFU2P3bOu2tQ
         XR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=LrYRA/5xAKk90m093Jd3R46Fi1oIbkZ+6mO/6jbHzAc=;
        fh=wxGwwQXQkZG1AaZeBH/FkLcUwxXdnKot1Es7cuJoyrw=;
        b=Nd7n6AcQOwAzc/IwoxgVtmozCpMkTs/hUpAuy/M5rKBOqoDuaIzbtA/f3d4C5lGZdH
         spaVv7q5rj9ayf3AkQZB/MFntM8Z+yu3mBj8Sszqjtfo7ajZeAowbcWQN5bCDWOA71e1
         Q/cXZ89a7AFafiXP+OLxz/42t+xGvV3L1NVlpmrkUWp9cLs5xdyFUHjI7HIJcGqMVacI
         52T83J12eb+DKzKpv06jfsraUTy5mVnaCmI9BnJjqW/EKwASyfgZEhd+mUJ9+XW51pF3
         y2/ngECg2I52sJ0kwdZtbcxezGr7oWsh40OzhsG6iLVMC8toekR78u4Neiuz+6q6CLN6
         gNnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791320344; x=1791925144; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LrYRA/5xAKk90m093Jd3R46Fi1oIbkZ+6mO/6jbHzAc=;
        b=s/BRugUBuvRifU4ZrYpX3ILX9iMTSgz1sXHh8WpuMpZkpXprHnC8ItN8quxExsFVHG
         RkvIcvTAOVpv85nq0VoSbMBFs0e0BfIr3M9czu0wGS8MV3orbC00Q7ivKYS6U3/CPxbC
         0apCziANkiNJvZnx2xmLp8mFDmh/RDBIwWww2aghuQ/dmSDQaoytARgabN0pBn+VLaBK
         wEBKOBlzLjk6W1/ArlV7Ayek5066jb6B3BxE9k8yC+YnQ4L3ksktB95oqmdaDDr0d/5i
         aJ+1DwRH0v3dVZ90BgWPBfZTylJsEbWDbpfnx0PdXJlv1PmalqDesH5FyK823+TB4jeK
         v3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791320344; x=1791925144;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LrYRA/5xAKk90m093Jd3R46Fi1oIbkZ+6mO/6jbHzAc=;
        b=KCsVLMu4BgMxs2MQnRtcELNMctJAg3Fz2d3YQaaYHI/jVno4htveheVeUOSyzG6buE
         t1pHrDYt42YvlLVF4+2fNKC65XI6XqzhQykdqLAwM1nWRyR3dt6oY4HBIJQClQY3YySD
         fqcA8SFex8Ptx9e3q7Zh9XU3lYslo6UAyqhAA41NXwRiKX/VMLi/pbTJVtBOVBcL/Z8Z
         jvPrrEd39Ui0/MZawnKM9wnnstqVf/K+CtRdi6JPE8ApqpsgndEV9w1v+k/NDdIeMHrW
         D0l7a0JjMuIGHtAGbmOwJLrUH768i0YLoTglS+CtHQjI09lMvyPuBl46kNnuIUrbQe5D
         rn5A==
X-Gm-Message-State: AFq9FYJrjqst0hz3+jl8UfM6XDc02ggES1EdDUJvRuPUFt7Q5iMazu8R
	p0sBS+EKTmYgfEe/7lhLmMyczIPzeOu2nlD5TZ+q1BOoOAzNyggKKgHQP3Yrw9UWXXPFokCHPKq
	7+PBXa4SBUePOgDm+931fn13EahiILKo=
X-Gm-Gg: AYBFou3gSs6gmcoc3ZTMhIX05Z0HTaVG8N7DIZj/TInwYlrn/gkfnckgjXwjlAkPfGW
	3Jsv/eKN1gkCkE+hBsKV1T4U1GpH4BOUm95FWyTOc1Jy1Y5+TEgNIQo7gIhH64crdWn8/V+qJu0
	h2+VlB/5EL5LCjzAfZGE/AX58Vue21HtxuwGxQpMRJnBoChBVCqlmGwk72eyZ5rZGGqlRfhRV4z
	wRZfB0ZUu4WVUlVI++VC1A6qsTFMixaSa/dzEGsz1hJomDITn4XsBtyGQyAXehv0bTX295nAOgq
	s9kwOIDaprr+L/GSS0ZcDwjjy/dmAkEu501qK+NWPLPij+BXQopFZBs+UyBHJAbZOU11MCiOS7C
	RMG6BeQ0bBSRJhZI92UU3MVqL/OfKI1FKAjQ5IYf7z8fNEnWFK5z8318b
X-Received: by 2002:a05:6102:e0a:b0:7c4:613b:2e22 with SMTP id
 ada2fe7eead31-7ca38ca0471mr1779137.10.1791320343863; Tue, 06 Oct 2026
 13:59:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 16:59:02 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 16:59:02 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqtsmyer8r.fsf@gitster.g>
References: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
 <20261006-kn-speedup-packed-refs-v3-1-a1c76b1df9e0@gmail.com> <xmqqtsmyer8r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Oct 2026 16:59:02 -0400
X-Gm-Features: AclHuK-Me7gfyJGyq7I2V1J3H5TdBFhjQ7hzUZRyrpP8xXv2np7Y9gRpuQ7Urw8
Message-ID: <CAOLa=ZQx=xWMjLuTekA0xFS4_WophOcVKGU4K-P3QE=+X_2F-Q@mail.gmail.com>
Subject: Re: [PATCH v3] packed-refs: use `fwrite()` when passing refs verbatim
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, toon@iotcl.com
Content-Type: multipart/mixed; boundary="000000000000c68825065d3244d5"

--000000000000c68825065d3244d5
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> With this, any sanitation which was happening as a side effect of
>> reformatting is now lost. But that was never the job of this section of
>> the code, since the main intention is to simply rewrite the remaining
>> refs post deletion of the selective few.
>
> Miniscule nit, but isn't that sanitization, not sanitation?

Yikes. Yes. Embarrassing

--000000000000c68825065d3244d5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 22c6b67729bda4a8_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yRllSUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMEp2Qy85WUhJalMzTll2R3NzcWFpWUhyWC9yL04wWAo4TFpIZWNRWVdE
YzhweDJDQkltUUFXVHozWWprQnhMdDRzODN3QTFUVURTSHNOZUp1ZUxSZTBFTWRQRkFFQ0JJCnI0
b050QnNzdjBTT2tGMWNZdFg4TVRicHd2cGR6cjdlUXNjakwrS0cwb1pxcUNCeDRUN2xjUSs4cDJQ
NEoyelQKUCt5UnJrQ2xGaFhDNVFLcHV2NEpmbjJEaTBzVzUwTStRaU4vbnJ5NHdvTGFDRHBYQUFR
M1k3ODlVRmFBNGhhbgpndmNOZHVNeWNXdzRHbE13NU9uUEFKN3pEaGFObUdCc3dyTlRhYjlRZ3h3
a3lCQWl2ZVpyQzVpVHhEQjZYRVFFCkRlcTRnSlpSdUpOVU95c21SVXd6UmZXVVlWQy84WC9vTTNZ
U2U2QXNmbXF3MTBUTUJkNUVkdHc1dW1LTkE1bC8KT2J6bEJmVkFnWDZkL2FlTkRKSDNGZ1pFYkht
K1Z0ZmFWZmVJUGowZ0dtM1NMNmZGNzZVOU0rV1lZVkcwRUljdApyRTkwNWZxcFUwZzFtN1VtTmdC
ZE9WNFQzMGc4QVVUNzRaamM5ZHhxR29DV3hTcUF1S3BkOU5QdWkyeVA2dml4CnlVdERHanVJdVdN
NFFSd0x1QTRkQzdHWVRJSXhZK3Z1R3Y0NUdyUT0KPUx4ZnkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c68825065d3244d5--
