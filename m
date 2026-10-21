Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792593463;
	b=RkHkWj+Rk/EMSCLn6oIHnfd0MYFL1Bucc6JjxP+RCXQCuJh5rHmf+3FXfy2DZLYwo8RD
	 OB9vXgKgycaOr0jIA2ICoAfwZ/JWPU4ceFOTIR5016yQxxxNrfP8pz3y1Au7KzXl4RcdI
	 PsnJFwHEWWmt84NnVlHwU9JKbLh/DCMPxXKfSxhqSkSO4KkyDIEc79rA1zvsW2iIYlgH4
	 7owiNErZd1wswyrj8u8rEJTg/392O+Vh+cyxXUY5y2Hzc4/LsdHsCfEt1/ygsNArpJwqx
	 +u4T6PhpmmC0UvPtJ/8Y1PQs7LCaPqOq8bk1WbrMBVDj/FmG8HqM+UJtauygLmUzcZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=pBUcUnS754Mx9p0eXwNzGW017XwtScrn96pfRA4Unzk=;
	b=h1dTYM07AwkjdPVjzWK3e0iNKo4GfM3wn/6scVzcv8Uh3ZbnfaATPHEdw2fYPkbFSMUo
	 UII0jD7Ohk1/4RV3qzPXemPyfmpCjrhZZhkG1PusAJI2dksg1uoL7U4AfYeNferwQ9dSP
	 JL41ZMsGN1vSt48iezI+LStygpVaxWgnFKYxnh9YCAwksA6ubgIOcRsAv2ODFQ+G/vIh7
	 /oI6rMuc9d1t/N5S7uDRwDXrWVcRW2bmCMUPqRbqAXtfQ9IoJAezuGkWceSzbDEctyOL6
	 kfvnN2yGL1FGE9vLPoa2ijMy8dovBTdKOy5coG1QGaZk6bQe+9qKXd0nqloBGi+4uNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hr+XMgEq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CEF606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 14:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42CEF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hr+XMgEq
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8ab395abf79so7640047b3.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792593462; cv=none;
        d=google.com; s=arc-20260327;
        b=gLoDRSTfY5Y0D49a9gNQI0lda7iLrRGbqZW1gLNEwSvwKsv9B4xpBJSVKQZiaHln8B
         zx6UK88RynK8wHAX9h8J1xa8yL8S4NDVhgxLZOcLmKVWBRFRHqrJvlhj4Uk66mcYPeY2
         buALZA6nG1Xv99xXtrM0OPiGXteSMcJxlQKF0b+y65zznB1cz1sdDyxMc4c5bMH0IBfF
         7a5DhUgBAM/xNCjuSvRU/ALKfi/11VdVP9mfRkXnlbHPuvHxm1G9DK6cvbgGUSjc53Zo
         WdlTgXEavJ32W1HAN2T/v233FTGMsAiPwb4kbxX9ca4NRRbXTgXdAX/EpYojGZq7D81E
         WK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pBUcUnS754Mx9p0eXwNzGW017XwtScrn96pfRA4Unzk=;
        fh=/j+vG27rf687elonHcL0kgOXGizcEL1Ld9TZlUvLLDs=;
        b=NYUsyYaMTmlzftAF0arlSrD8nV1LgnAtGwzlx1mrY3DSrI4s03A9/v/XvlFr6ESFTM
         +FvyaJodW72TYNppwJ9PzKGV3X7ptHgX9guVFePeTBVjSdvGi5R8B7TbgmKUpSzCCh3D
         6lY1eKEX04V6+ZTbpSFvugSVLMteJP+0Mhg3TKq4r3c4aVsfO0dwxSQz+tml4t+jXoeE
         FEMHFWCdAjKUI8lJIQGoOKg2elYXQ7KoCYmjci0Oh78S6kK/0V/2mONjjqt/w4U8p0xT
         +uq9m1dL7c+ieoSlZVgQRKHbVFJMYuMiqBXovTOr5QLpSUV8FtZ+8ksanFJIPoHlmL9j
         tO4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792593462; x=1793198262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pBUcUnS754Mx9p0eXwNzGW017XwtScrn96pfRA4Unzk=;
        b=hr+XMgEqqE8HiMI+Vs3Iuh49WW+ABE1rmRXhagYFO6LsD2VeccSDRDGOS/u+KLY9gn
         LZj4v38nOiXgE7DDi+bLB7spJzfbQj3jUsqjliXB3fXjUw+nYBywvjNuBhK7iuKJ4nfJ
         NyXSSTYFTK/gjgvmAAFcLpjAdcTCB4x+WMMGU57qRnSuMvdkSHK7454cGDdR+UYzY14A
         qfq96ij1LDbD8xNpeqbHTeX92UU9z/OwyRXljHdfqZ+PekopReOUGbCRa9/okxG8zZ1p
         xCMhLLzJz01YlY8OBAXa2y7jwVlooHwL0hvrGsF6bsbW4L0Jyx6Pcm3m6QtWb5Vpmasf
         VVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792593462; x=1793198262;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pBUcUnS754Mx9p0eXwNzGW017XwtScrn96pfRA4Unzk=;
        b=BJ5MAYXVQATg/pB/reohLznboz3uXrUvMbRpuvDIe8cqUDcAjPBZBEpAt9q98augKY
         TZpaX/ibM3Na3NBf273zwRahHDhZIDFqTWwz6sFic1MjKz/PKvqCNSnoy5ns9slflEJu
         SXoTOwR7Zr2CfY9mTu2weZf9qPIZeCaRQAkzqtK60mjF5XFSNfgpUvpUx2ZCDcXcDP6X
         NZwQ91SivIYKCtB7Obac6lpu/rVdByJX90DZEZe0qHesR4CmBT0KHgmqWnZcOOMN3lzj
         Eh98DajGmcst/9HPI/sBUfyZucncL8PCtK7Rq5aEge/qfQOJtMrdeuw5O/FvCP+oj88F
         rvsg==
X-Gm-Message-State: AFq9FYLmgXTHWPwfNn5s++a8mFmR7NOVz5DZRHk+mplm7M4m4692eSMF
	DHaZsJG3kJE3SBsCKDzuvx9yDu5wHbA5vfVBOhU28VctQcMLj0lGaRW+wJYGcBVe+6NGVRKFkXT
	GsgQWjTzTNkdcx1EWUm97K1rrV0MaaHE=
X-Gm-Gg: AYBFou34qkwLAqmqsAUUkFs1TiEq1q/oO3iCmMkgCriSKHcs0YkIDUa/0/mt9pchZSt
	zYvihftZqhqyN5yjBNT9d3uueRn4JJVPc79e/bfAQEOloq+DgtpP2TLqQJrizuutIhPlYr/Qf+l
	jpt66NgwRThdYy6hYruuQ9looHQo7apNEbCIyb7Oqz6SszyBl9RjQ1G16izKwQ4IB4e3aH0nhaB
	NP0EeGnFJnStkaiRKl8JYFEjfkv+iXtURUfcYhHDBp2Vo0RJN/BsF3VuESnXitduUmJXbdwkd5s
	zEBXYub8x+PAkt3IXc4uE9eMXn5IWFGoyw6s7wGDs0q+IvS1sDFVfQo4fiFpWOsSJVZeMeeqXrC
	UmqJQwj0khMA5qH6ZVjbwzzLfOoyyJMpn38zYeg1IPam+dliUQs5J6P3DIMlFz5XO0r3j6A==
X-Received: by 2002:a05:690c:6612:b0:886:70a9:3ad2 with SMTP id
 00721157ae682-8b133c97934mr13082547b3.15.1792593462349; Wed, 21 Oct 2026
 07:37:42 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAPki72GYsid5DqaP8urq-gVrNEvMZM+sXUaNjir-VXc+qokMfw@mail.gmail.com>
In-Reply-To: <CAPki72GYsid5DqaP8urq-gVrNEvMZM+sXUaNjir-VXc+qokMfw@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Wed, 21 Oct 2026 15:37:29 +0100
X-Gm-Features: AclHuK8z_5AGV1yOGYM3EyhsOO7XEvXRs3zhrizaGAtII7yNmkFYErngciquTJE
Message-ID: <CAPSxiM9_7LWD6_L5Wsh9LV60FwQxxgLgOSaHQ4QfraZ1PjjV5w@mail.gmail.com>
Subject: Re: [Outreachy] Git command argument parsing micro-project
To: Azuama Odinaka Maximus <azuama69@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 2:22=E2=80=AFPM Azuama Odinaka Maximus
<azuama69@gmail.com> wrote:
>
> Hello Git community,
>
> My name is Azuama Odinaka Maximus, and I am an Outreachy applicant
> interested in the project =E2=80=9CImprove how command arguments and opti=
ons
> are scanned and parsed.=E2=80=9D
Hello Azuama, Welcome to the Git project.
>
> I am a beginner in C and am learning to contribute to Git by studying
> its codebase, reproducing issues, and writing tests.
Thanks for your interest in the Git project.
>
> I have prepared a small patch for builtin/rev-list.c to prevent the
> early option scan from interpreting the argument to --grep as another
> option. I also added a regression test in t/t6022-rev-list-missing.sh.
> The relevant test suite passes locally.
>
> I would appreciate feedback on whether this is an appropriate
> micro-project contribution and whether the fix should be improved to
> handle this class of argument-parsing issues more generally.
It is a good microproject. Since you already said, you worked on something
already, send for review and for microproject. We can then see if
there is a follow up.
>
> Thank you for your time and for supporting Outreachy applicants.
>
> Best regards,
> Azuama Odinaka Maximus
Thanks.
Usman.
>
