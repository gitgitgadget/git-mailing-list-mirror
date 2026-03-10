Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A196321445
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773162570; cv=pass; b=ZlUu8yAMGBeADB61U2W6La4QNk84/UIvTK5hAJ5hPU8OsqNkrfobO0cwTF+NVS77buzQYybzWK36U3MNKis5kZWsduxjPOY6hcVDHjeWcBHTH88RO+3yXs8PtM7ik9HMuSUmBvbnrL/pNrRz6o1kaszdQyDNSDEmdyah63Bqnbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773162570; c=relaxed/simple;
	bh=op4mRHvFdTkibkEy0zZafAZdXLBwqgPigVwQKcB4x7k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8GBi24I3QApB4Y6PGTKjZgQeKqR4Z3c6ddI90ijgX7xJQT2SULjaEIXmROXOoqf6jK9IpGMFbeHeC677kuv8jRbH1OFox9Ba+fyjPdWtPtcABMndsTBuC4os4WAc/4SpnEBP+6R6+ccRI9YEhNMB1mhjbraage1cditDEBo0aI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AybtIeC1; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AybtIeC1"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94e578a0fa5so3693707241.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 10:09:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773162568; cv=none;
        d=google.com; s=arc-20240605;
        b=lgKMYueklOxqphW5gIiphvAyIzZp9tQeEQo8FeFKRsEf3V/I2eWI7ZBhdtyqDbpDrj
         tOLAx3RMxAE2jscuDLFhtOr0sy/GkNmcIh5vUE9tvvCtQfxMcRNalpSmhvQwZrseePO/
         NoVirH/xQP5+3obKYvdpmV+Dl/8qjan10Zq5JKk4/tQ+lo906rXentu6NGhMWLjVozj0
         RiYduUwAjsINJlt0H1nE7961cXtky2IiXfl6g8ahYhDgqCr/QlJAzdo0OdrWd8Poe5Cy
         a5Sse1WsIcKwy90bJ2pz8TGmkF/t5pGSAJRQ1vHG6jtj6h9vpvb963f6W4tTFXcrx7AO
         YWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=CrGsIbpNBvZwtleXZPGJAd1AcvLJjnshz06d0V8IH+Q=;
        fh=CJGYMKLwAOfjfNdLN8124M4dhjIbsvlUnz0Bn4pvkUk=;
        b=dB26s2ZficRFg7fCeXGuMYhLMCM/1zhSjE0et4rK4vPmRhVtFTMYHD5dH9uKl5DNsX
         ji9bgD3cSL/cvCx0ESq2JY8xhnI/90ZOJcjo/YIlYzKplEV6eDkKv/47pqiOjwc1AgUt
         JfFDxDnMR5cXLPfT6U15dt39i5Eq8/Aru62f9swlX0gYAuJAaKG2CLluf6BqD2rOAIRt
         +XwDLUG17YbEJ0wVH8XeRjKMs73VBLy+gnk3thpRIGv/7nC/PxhhJqG0WXBzcAH4oP/2
         JHOymHTxTfvoGlTu0Ycb9+Hu5n6HJRI4/+ha8BBASF2qFuzuz1a7OHf394yIfqqTIxKg
         bnfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773162568; x=1773767368; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrGsIbpNBvZwtleXZPGJAd1AcvLJjnshz06d0V8IH+Q=;
        b=AybtIeC1b5FtFRky3f5fIM5qWbTUKbydK+BSTffiSbFJgGOED3Z9cUYPnJzMxt1VgV
         eFVjFbVfbRsZkwKdFYzAfLYVJhFMjIz3OossTggGVf8rmYtXVOP351/1BIvEQT21BVUT
         aNKoucTZDY28e0k/1+AMA8I6lgmCupRBsTER9KPUaKdorBtAOwh6XtqdzDBWsQfzIq3w
         p8/pwtO4A8ztSbVesWY2bE2UZAM/rpzTbFboAGUwCBj+s2tJsXMKWDVLu8UQvnwY6S2J
         8xkvSgi50Ct2DcPwq55LZiamiqR2auc7c0IqEYl467CuFZRB4e+zSl7hzNmzFsM7EKf+
         E8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773162568; x=1773767368;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrGsIbpNBvZwtleXZPGJAd1AcvLJjnshz06d0V8IH+Q=;
        b=qIrCa0xh+ITV7cYlQPwoSy6BTJ8ejOyhoEAyhKPb2II3gR7Ba6g1XwZTE1PktnPWU8
         insczaCA2U3wuCrv7cCAHwewNO5Gc6SJkFfmZPKS84n0syn68kWlnm7GtF3ujv19Gifq
         r2aCVeciCSyhX0g12pHGJibbGk70NIuCv8zJXILCfUawC2UqqNB94I5zDhLBKkmlS41Z
         s/AeHEYyLjscH4R9nnqJxtLKLRZ14eM6V5A1CgLO12A1aNIMx4prpABupScLVqqcrkk/
         MdN9oytmXLvUC0pSge2/D86SRNqyBJp6KkhtVjF+B0CPljpv8AQYwGClH2fYn+a3ZJx4
         BS2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUv775pZOva7dXrsqKb3ZcHQWGX8Dm3+WgvKxuwy42X8Ez+j0H9g7OwoK2v+GcPNlG+YY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym5z4m1Ksi4MwfeBjGCO0fW1t3hO3G0xj/mJbSF/rhOBsLfQIx
	npYemadAS0r5ehvCdzMQbLU0+mTghVTQOzt3E5d4eeEBzoATgk4+f08OKMo1n5LtK2An/z/e6Cn
	7VWrPLfw+VumG+nK/Agpiqcvv8rq7R7+LqTrM
X-Gm-Gg: ATEYQzx/ckgFgKzcb99FgXF7WQGg/pt5903Hogr8MauGNxB1kZlzBKEoFakGJUSdMQs
	qPG9ak8ThN8TiahYJkAzqEUEnkABHi6liz3N/Zw9m4XT6u1SkamVnuaY0+DsDsyWdWd8YFNNuWz
	WCs0mPxZFX5yCSK7Pe2Dpz/Twvh6nOJhb9gZb2L/kff0LXMvm4MMayHtJI7il833Op911XKvGkQ
	CXtQ4fk9/7X581YzdZmR7pyYQ5XFAetCJLUtntVo65NqZJpN3+QaufbAVq6YEVEbzAqhYd5oXei
	jrgCl1mKCbxx2lH2JKSbtnGRru6PxgDKwpG2C9icgw==
X-Received: by 2002:a05:6102:38cf:b0:5f5:76ed:f1db with SMTP id
 ada2fe7eead31-5ffe5b7d7bamr6734985137.0.1773162567872; Tue, 10 Mar 2026
 10:09:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 10:09:25 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Mar 2026 10:09:25 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqeclrwrz4.fsf@gitster.g>
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
 <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com>
 <CAOLa=ZRfaSR2CisUrW0gLf_45KQj1wQZ70F4PZ5XcwWZ--+HhQ@mail.gmail.com>
 <CAOAgETMmLKcz2CWqfKCJeoTCfACMXz7M0d2g_zO5M53tnGqQuA@mail.gmail.com> <xmqqeclrwrz4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Mar 2026 10:09:25 -0700
X-Gm-Features: AaiRm53_gRDOkpXQGNiym2_0cQVxj4-ILHc-8HKNtZjAJXhUX025ERFWqe7NFgk
Message-ID: <CAOLa=ZQu1hyiwMpBxJ=0PhNCf6LQqBt3F3=kycDv9cZST_JTNw@mail.gmail.com>
Subject: Re: [PATCH v2] advice: add stashBeforeCheckout advice for dirty
 branch switches
To: Junio C Hamano <gitster@pobox.com>, Arsh Srivastava <arshsrivastava00@gmail.com>
Cc: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000fcdaf1064cae9412"

--000000000000fcdaf1064cae9412
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Arsh Srivastava <arshsrivastava00@gmail.com> writes:
>
>> Subject: Re: [GSOC] advice: add stashBeforeCheckout advice for dirty
>> branch switches
>>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> Doesn't 'ADVICE_COMMIT_BEFORE_MERGE' already do this?
>>> So won't this simply be duplicating the same message?
>>
>> Thank you for the detailed review. You are correct, the existing message
>> ...
>> I will rework the patch in that direction and send a v4.
>>
>> Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
>
> Just a comment by a bystander, but it confuses me quite a lot to see
> in-body "Subject:" and "Sign-off" in a message that is *not* a patch
> at all.  What are you signing off with this signature?

Tangentially, I know that b4 adds a "Sign-off" to the cover message.

--000000000000fcdaf1064cae9412
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8355a010fcc229d0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1td1VFTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mekVVREFDRWRXdXowa3MvNUxpZHFUR1lLNXY0WlcvNApwK3FVYXJISjVS
SXViejdZR3lERlF4T0N4aTRBVkJGRW90WHFYTzIxSVhSeU92Y0NrV24wdEREbzJTcXByUy9GCnlv
V3paN1dINk9TTE9OY1VIN1FyOVViSlN6bjJTdUxkcVJpR3V5S1NEbzhVOGZ3dUVRTzZ4QXdzcy94
SVdYdWcKcGgvUnZZeFk4WENoM1ZpNzRTKy85ZkFvQ3QxYWdWV2RzajdQU21PYzA4KzVPejhlZDFT
b01VeGVPYnRZRXdZOQo4MXRvalIyZjBqNkJNQUZPRlNNVEJSandmVndKZ29qb3l2SmVVZjVqMjBn
emFGN0hkZFdoY3NIVSsvZ3VieG8zCmtvUE5iY3g1Sm1GUEljaU4vYm9Xb2hKUGlhenltTFN3cFI5
ajNQaGNYODh4SGE4VUNjSWRtSjdQSW5LWDVFOUQKNjg4cmpBV09ZZGE1bEhDREQwU0hnT3grbFRM
OWFxK3RYZS8yOHlsN2Z5RUN2b0RKSTVkWVdadW5EZHJyVlBkegppeWo4ZlJ6eEYwUlhkcWZlQnoz
bnRJczdQSU11NkZCTG5BRTZTUzkzTnVmSldTckNLYlZrWTNIbTFCbGVlRURJCjJoNnQrN0dhNFpL
b0o5MnRwdU9jK2dIQ0VwcXVsNld4aVBwM1JnMD0KPW5ZRkcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fcdaf1064cae9412--
