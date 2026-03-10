Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69E1B6D1A
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165387; cv=pass; b=u0yHAZxStT7Mia4sE5CxkDY8V8lDUp+zS/zxFee0drQgu9J1Xp03Ro0ZaNAt1TTRZFWNL9eteLKvm++90NCUGmqiBZdg1WPtnP6AqGp+49mzIVdPjpzYsf0nGztfp8j4c7CNR783k6n69w5IgPkNGy2aS7uIZvgbtPeU10tjXT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165387; c=relaxed/simple;
	bh=/gXKzergW5mM6WHF5oyvxB0w+4OLByS6xk50CpvrUck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R36WlInyOi3JkxXgEUQzi/uj0ZEHP/8j25Ki8zn1CWy6QNF5CZGG+sX0MPVHGQA0czJECHKa2QNr7GRFiuo5E6D8Wmj+Ye21yPskACV3r1qPW0Fn31vi+ecWwssEQprl8xZSOP4hnomz2GYXMcD2bfX1A/zgNrkvgILzqSrj8BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ke9p3sTW; arc=pass smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke9p3sTW"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94e82e5b262so1003365241.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 10:56:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773165385; cv=none;
        d=google.com; s=arc-20240605;
        b=AlwmXDYtG4V4WUJEjvtAvzOq3mLhePIE//sweI4ihkzFdBTKDit31Pv8v5u/lOW1zZ
         E8GmCSOwubBfXwCHyfv7HQAF9xdHj3+ywsHTX8gjE59Fvgl5RV2+mvMZPfUB/um0S4dp
         NkeO+HD1+SZfjYIdT9bamYSEPaMTI7BEUyjmlo9/cMsemXJ5rz0N4iwFwKqUvFilfFRB
         Uq13Q8HV19Qs1WTHSYn111fQZdJ1c4/a1sFZVyq9FBOLIllD+UeOxltY7l7nUGvmZAz9
         YlSs8k//ByzwF6a9VqrYiOstuwPBQDiaXGioId2e5YcvwFzlHUgWdal+1RyLG7g8qPUr
         zQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RgGOMyuTcBr5/rqh8qIlbPh3x6A+xe1xzsiaEFd9y60=;
        fh=h1S0J9ltbYVwSGQriB1924sGxm0pvoO6gRkeyF6wmb8=;
        b=Jk6oPC3dUCH2yvgJYbbNIG1aQHXCb6GHWHamIgHjtLaFe2ktcsTiZD308xVrgianha
         LiOE1/Ft65WZg+OxGjFSdm7FgSXzUckn0J0iqSWkVel/MjRsDYyS7PuiRJN5Jmfk++jB
         D/SVomqqFYsujEX0eDJDsMtFUWQF7f4C579vXUthDvcruOA/ce1XS1/V4DPJKXcXJjtc
         ZQ0he/E9NYqQ5IkF1vQuRWaRGkFd0Y/pVTT2mUPl45/aZDgzbbMEP0m6Gqxep8WxD/Uv
         y7toZMHRRXXsD1n042GMoNVBpq4I3vCmf/HB2lkHsWWOk3WaZSOViig7NvlgM9wnZQQK
         DXYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773165385; x=1773770185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RgGOMyuTcBr5/rqh8qIlbPh3x6A+xe1xzsiaEFd9y60=;
        b=ke9p3sTWAckHAPQ0fveBfM5bBWCOdvwqQm0107ccB5c0MQxTo2TZm+9nnqCkEoXREd
         AUhdYV4wIaeECPHnuVgTQSUS/4jNfTqt+5HEWsvgv3B8Y5Rsj6tfSej7qg9ksaKI8wml
         gGiGGQIv4k+KnZTRcz5/3FqAihlhTlPliy57Ep8QdEer4jJUSSzNP8glPw44OQOtWGMf
         eoazoedxlTb3j8I/WdnKHE4D/voJnhnuyKtNAx/xc+lGKG7OhHf5EhpIyIuH5soRR11E
         aSXFIo4seg0q+oeeVHBSKsKLsSXNq+U/s7Bt815BBScwAqwmFUjxUax2T2l2BV8fEeGp
         ZJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773165385; x=1773770185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgGOMyuTcBr5/rqh8qIlbPh3x6A+xe1xzsiaEFd9y60=;
        b=YApyklVYPekHqD5bugCOdKSZI73fna61LAyLzb/2owXTOsYwPIQIjVgs1XjgimZS6U
         bFzZG6neSSB1rKJrHuoXzi7bRec/hDwZXGw43x/XA5+CT//Xiskm85eYFZLROJt2OoIk
         7Q7tLGvnqLnBDabgQVTVry1lWIfjyEa8UvAb5OFCbXfVAlQvCNWw9FK8xct/XVYdzSMT
         hVEjZfIdRGJIn7+goIDKdrNOthxXeTHc2qQBlPw5JB0vCdwpV2rNDQjMvc2IRmyxrI+v
         teqIB3ZONfXS9vOaDLloRr9NpUtIlG1L4DH4lEmcwRFp/NB1hw12APM0wG3zQrNFOpgH
         kCDg==
X-Forwarded-Encrypted: i=1; AJvYcCXM7E8/0fPs/fWzR5jnqQ4K0K5H/qncH4uniLfQX4WsrachbF6WkMOS6ogOXAHFHaXUl20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9vHx54PPcDa/F0MkL9ROkA7uIURv7B+HRZf9x/NmwnFFNnVnJ
	XVOXjhM/vkZAELuIC4riJ7srHJBUFNsmELhW8Bk0B4HVwfwL52qqy775jyPs7FS+0dhjGjklwEE
	zY4hBHdUnkTvKlyaSHwqCzyCBhX+MBEM=
X-Gm-Gg: ATEYQzxAhixXRWHu59BZCp8gnRIS51m5Cnh/nL11XlFQeC9IVnps6G0cNZTXqlKlFgV
	Ph5E9hrBIJe7J8ZmZ/dhUGnKqB2xjeL6zo8TvisUBdReFnZ8SFhkxoOQY345bLvvXIbIuxS4N23
	EBLazZwUdoOjpd0mvUBp871c4TC6U31wBitAKxDd2PkvOjTp2/IEwkDwN3ekhfckP3Ck/nnTd9e
	6ecGNRjUsnIXGI9yOUUElKX7/3TieRLuaUYyy/lkIDoOiqxm961mf/Md841Nr1zgsZrO893FqSE
	cfVcAoqcAk+bqpNDP/zcgPmhmuW20ax0sUzHDdWp/YqaLepGXGUMWjPdJkS6YuR3L4Jofh39eAW
	pU1khvU5RJO3btuMFpEA=
X-Received: by 2002:a05:6102:3583:b0:5ff:17bd:9e83 with SMTP id
 ada2fe7eead31-5ffe5f567f0mr5276969137.14.1773165385302; Tue, 10 Mar 2026
 10:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
 <pull.2233.v2.git.git.1773140364525.gitgitgadget@gmail.com>
 <CAOLa=ZRfaSR2CisUrW0gLf_45KQj1wQZ70F4PZ5XcwWZ--+HhQ@mail.gmail.com>
 <CAOAgETMmLKcz2CWqfKCJeoTCfACMXz7M0d2g_zO5M53tnGqQuA@mail.gmail.com> <xmqqeclrwrz4.fsf@gitster.g>
In-Reply-To: <xmqqeclrwrz4.fsf@gitster.g>
From: Arsh Srivastava <arshsrivastava00@gmail.com>
Date: Tue, 10 Mar 2026 23:26:13 +0530
X-Gm-Features: AaiRm51iQx-cKdK-HuYYz0Bd4Y2-AsHHxY9wVYbE8TiYHeCeTRN8uQn_mr8wGVg
Message-ID: <CAOAgETMjppTDG9jkV=zR+CVsEXwpVZ1peu3SbPZY9fNaKKmEMg@mail.gmail.com>
Subject: Re: [PATCH v2] advice: add stashBeforeCheckout advice for dirty
 branch switches
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, 
	Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes

>Sign-off and Subject in body confuses

I thought writing sign-off was a necessity for my mail to be accepted

On Tue, 10 Mar 2026 at 22:18, Junio C Hamano <gitster@pobox.com> wrote:
>
> Arsh Srivastava <arshsrivastava00@gmail.com> writes:
>
> > Subject: Re: [GSOC] advice: add stashBeforeCheckout advice for dirty
> > branch switches
> >
> > Karthik Nayak <karthik.188@gmail.com> writes:
> >
> >> Doesn't 'ADVICE_COMMIT_BEFORE_MERGE' already do this?
> >> So won't this simply be duplicating the same message?
> >
> > Thank you for the detailed review. You are correct, the existing message
> > ...
> > I will rework the patch in that direction and send a v4.
> >
> > Signed-off-by: Arsh Srivastava <arshsrivastava00@gmail.com>
>
> Just a comment by a bystander, but it confuses me quite a lot to see
> in-body "Subject:" and "Sign-off" in a message that is *not* a patch
> at all.  What are you signing off with this signature?
