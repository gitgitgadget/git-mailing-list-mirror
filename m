Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF0537D13F
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052593; cv=pass; b=j73G5Z64G0zwWEM7gm2qBSIiKG6qW7/EqEkY8uJGt97/MiXoOWqHZEZzFA4dCJMo8aDU3ys0NhFXpecvXJLeVBVQ5UH/wqFRgOBKkYXHuxSGqSWM62KuHAEikL+5Io+fm8Uq3VCl7/emjvCCYccU7OsvVsbUrw5W7MLZBoWMRZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052593; c=relaxed/simple;
	bh=pCaMXpcfGnVd0tYrh/zb+Fp8KllEe54/kx8O7cx12DQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eiB9dMbeKMkBBPJMXjIfh+rqiLTcp3IlysPLgYSpAd0PsBwosTrstI59/7g90ahPYhkHqUBoEWFgpwKFL5TywYDrO56Hz3ja6HGYYEJm6ccGYwGfZTUWk2P5J0AR7rjmIih7jAQv+1e9fg72156emurKLDcLKKNj0/Uux7n027M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJ1JaAQV; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ1JaAQV"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5ffe16290e2so774987137.3
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 03:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773052591; cv=none;
        d=google.com; s=arc-20240605;
        b=cEk5Ep9jBNZS0WkWY2M8QgiJ59s4AmcfsFfV9JiULExJ2H5P2nVW5oK7X9IhPKvgDd
         F4ug3nwKGxlT1kt+6WvZUs9A7xan38xTlwd2pKbeDEQYg11QHE7/7lIUI2BMd6GsMAHj
         Vmqi35MrCcbfQxVW1eUNHxXP8hSxcASoAQuXDTKrC87IZrFII533Rd5Ceg92ujWsVDHn
         7PBsCOXArK11impFfqkR4+85NvgB65cbsQrRj+HUmESnSsMoyvy2stkRX0Hg4a0bG7Ss
         mZwuGZWfqMECzIAiVHVvUKBTfKZ5jQhgO+G23lR+9aKUhvxNL+pOVg51WcuFhClXZEU4
         ZDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=pCaMXpcfGnVd0tYrh/zb+Fp8KllEe54/kx8O7cx12DQ=;
        fh=0uM7nKecaE7ayDu1++pXobtAisu7dfSmX1qMNcfwy6s=;
        b=K7y1AHVOEax3biwQbNN6PcnCmETiQ5gObHIwhr0GiwLpOB4B0B2VvgoSlot7t7PaDv
         kwDkGjQCieVkreeIqAi/6QlyVRgwjB0LL+GtNcfRQhDKF1CJwPSLwno59vB9JwYrLkTo
         JGVQvo9N2vYQ22dHGdeeoTe3qx77jm/+f0aJTaZrmliooXpw4kpd59n0puaOnoU1ddJC
         f8o+cTgE5cdeTlo9dYOK8zkYpm4KwqFXR7urAoVXFJf57+3Cdavcs15RBKTfsQQKkuZg
         nab5HU0sSttEfCAsRtktBMR9kWAKszDTTfT/6CbyuIstQzrv8o8u569TTgD3u6UqZffP
         UkTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773052591; x=1773657391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pCaMXpcfGnVd0tYrh/zb+Fp8KllEe54/kx8O7cx12DQ=;
        b=IJ1JaAQV68lDgKy3vuYmOEkuLcGn5Moib6Ax85uk5RBwWXBZaktd9f4EpoqFgzuEjg
         T0l9GAvDNj8erE1GOwG3Fvc5X0mmNFzmdI0FupJgrLdtnxCPSMHgobBCIUnhviOoDEJW
         UQmSBhL5oz38HVPL6RP5u1FH3HbVYK1lPTAe2zrXP2plhWHtisdqRzoGquNSTUb2Vrjz
         z8cPBfZYAimFAB3lMOxvSJYZ4JXYwoh3KmgMbLQo0UCy8S2T4fecT2j22plRUIAPPBaI
         tqZTL54f+xqP+Z5We+vtdEIGCEEmh5o+v4xt7dPnenBLfWBWRo6FBTP++XaFMYBFTyta
         DaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773052591; x=1773657391;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCaMXpcfGnVd0tYrh/zb+Fp8KllEe54/kx8O7cx12DQ=;
        b=uPJCni66DPFnRD4scN4XAZqpQYO87sUDCLnwEm3mrF+3RNxp5vtY3izADmanVFHFIm
         /CXmnjGRBmD2Ly92uV8vPgey5sdjY/4swpkxaI5M+otgGy7Uo7qmfqlp6XAWFW+fV4zd
         yUPxl8aEYycHGYvUyeoTTDsfbvR9JXV7vXjPCJ0NRckPLxBUt2I4Ino7KK3EUD8DpLBu
         0ECdAXs3/gm6L1fYUNuuqozlXyHGJ3AKyg/hmU/7KoHeK4iG61GDjmMjBivHCxDmH8Yu
         f2H+fCqBwR0lA06MfIGMap0cHHh7q1yNmnmul5GVis/ybYkWMCnMWX8Xl7lSsa7IAoIc
         WMiw==
X-Forwarded-Encrypted: i=1; AJvYcCWz0Unlq/EVYCTWtwIoavLFOOut4aSgDnhRsVhskL9VJHek6lU0RQopJz1whYx3+A4+VW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfdJFivZS3Qmcjfc2bZPKXuuVdwxZLK5m7rAveatFRkR42OWP
	tfvqeaTXGE7jW+dXWszAAinTFAPdv0tSin2EkGOvSI7mg/gwzNaB4EYXQ61DD0828PHNpYVuHZ3
	ti1ehH2XYCUokRCt2I+L0ctLunzJh15lMh8Sb
X-Gm-Gg: ATEYQzyC02ZjKP8ZeeTYYmyxUFe+buXRZmLQScYWM20Ynk+kYbUa5jyLqHflhBmL5EE
	lVk4a73KMP4hnjRfTA2JjBh7WPeB0fgfRqANgI1sShcfwU50E+tNQ0UBEopqoPteePXEp+saX2v
	KwHvMsLik5+wDZpDG5QgZyBydh/Wu76YGCAm91h/H/l6HnU7XFWAwPhkBg1fEMEtXLlFBUpLFNf
	AiHF8/ltRlqZPJ92Mpu9Adj5o6p/yFi04NknYhh5Fvyf0VmHO2zNrjLJ+gNXjeS7Jp0lDAeNmdy
	H/Z0AGb03Z5KQH2vvwy5X9tspHkr9bBnppDZN/u+Fw==
X-Received: by 2002:a05:6102:1624:b0:5fe:13bc:f13a with SMTP id
 ada2fe7eead31-5ffe631fd3fmr4092269137.36.1773052590698; Mon, 09 Mar 2026
 03:36:30 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Mar 2026 05:36:29 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Mar 2026 05:36:29 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aaRzdeg2BkAKa-4J@fedora>
References: <20260301105228.1738388-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260301105228.1738388-2-shreyanshpaliwalcmsmn@gmail.com>
 <aaQzlE2lsq4WfFxt@fedora> <8e657184-ee0b-453a-9f2d-a98080d3582e@gmail.com> <aaRzdeg2BkAKa-4J@fedora>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Mar 2026 05:36:29 -0500
X-Gm-Features: AaiRm51AXsTpIk5WpwkVIve04ewj-Gsx7d2abmSvFafZnqPyA3E8Kuos0871xiE
Message-ID: <CAOLa=ZR1_OMnVNKeiZiWDLBBXCtxNveKCgjjTFQAYYCCjqbZ0Q@mail.gmail.com>
Subject: Re: [GSOC][PATCH 1/2] editor: make editor_program local to editor.c
To: =?UTF-8?Q?Burak_Kaan_Kara=C3=A7ay?= <bkkaracay@gmail.com>, 
	phillip.wood@dunelm.org.uk
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org, gitster@pobox.com, 
	christian.couder@gmail.com, jltobler@gmail.com, ayu.chandekar@gmail.com, 
	siddharthasthana31@gmail.com, lucasseikioshiro@gmail.com
Content-Type: multipart/mixed; boundary="000000000000d661b7064c94f93c"

--000000000000d661b7064c94f93c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Burak Kaan Kara=C3=A7ay <bkkaracay@gmail.com> writes:

> On Sun, Mar 01, 2026 at 04:22:38PM +0000, Phillip Wood wrote:
>>>While moving the global variable from 'environment.c' to 'editor.c'
>>>doesn't cause any behavior change, it still relies on global state.
>>
>>That's true, but does it really make sense for this config setting
>>per-repository? Why would I want to use different editors for
>>different repositories in the same process?
>>
>>Thanks
>>
>>Phillip
>
> In practical sense, yes, it's true. Users generally don't use different
> editors for different repositories. For repository dependent settings
> .editorconfig mostly cover all scenarios.
>
> However, as far as I know git doesn't have a system-wide only
> configuration settings. These changes mostly serve to libification
> process of git. If we leave 'core.editor' setting as a global variable
> and user tries to interact with multiple repositories that have
> different editor configurations using our libified git, it can mix up
> the configs of two repositories.
>
> If we really want to keep these variables independent from repositories,
> we should probably prohibit 'core.editor' setting in local repository
> configs. Otherwise, leaving it global seems like a weird behavioral
> choice.
>
> Thanks,
> Burak Kaan Kara=C3=A7ay

I do agree with the point you're making, true isolation for libification
would indeed require that this variable is not a global variable.

But, while libification is the destination, steps in that direction
should be welcome, and I think one step is to simply localize the global
variables.

Also bloating up `struct repository` without much thought might not be a
good decision either.

--000000000000d661b7064c94f93c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5a040dd75c078afe_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tdW9xd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3VJQy80L29VWEUrYlo0cWVYOVZrb2s4bEhYQ3daaAo4N3c1bHd1VkVE
WHZkZXFxWThjZmhsMTVWMEtUSnBVRUVJcXE0aU1ueVhtbFZmMkNlUG9OQVhrMzhucDd3VXlwCmJZ
SkNxaXdkYzVWYks4R3J5bk92RzF5U29yWHF6c2ZRSEcyamp3bkt5VUczRlVrd1ZneTNJa3c4Unl5
dE5xU2cKbDk4a2k0NEtWU29BMUtaWTY0VElWajJuR3RJSmFVRm9rcm9panpuY3YrSVpkVGpYVmxn
bEZ1ZWNDdHRpUW5oSAorak1QU1M3SmYzc0NWalplQnhQTnJpVmdzQ3NGS2RERmRIZXBvQ1c5M0Nl
YlV5OGtSZUQvSWtSMmI3UWFZOUdnCjZTZ0RxcEJkMjRGZDdqQ3p5RWVBZGdnQVRFNHJiRUYyUnMv
WXNiWURCc3FlR1lFbWdEVjdhbFI1djl4QjdkZWQKekNpR0pyeFVsRElaenhIVXBQNjY1WWkzZjZt
TWtBdk93Y2FjMlhPQnJVdVpkcjU1M0ZNK2draDNkQW5TdG42Vgp3Y3ljWmsvRFFteExudC9WTHYw
YWJPNHpOOFRua2NHZmJpbmM5eUtLelowZWRqS0kyNXQ1WFdCZmZZSjdLZ3FlCkNIVmJTWUVYaHYv
T21Dd3huTS9WSEhhMmNtaHpEazlrNmxJTHNPZz0KPUVyR0cKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d661b7064c94f93c--
