Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163762DE6F2
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552960; cv=none; b=IYFbYJD0RqKuZq1+nfjjAoNTFCNaDKWiePPKX5dNhxL3Q4JNHyAuiNQmkWSebLoQSHLLKWVu4aL2P9L1a2iat5FxTJuXAeqSGiNjW3GZCKAL1EvLxMTvZuE7NRnWG1DOskhfG3Tvkx6DAv2GD3R91QCx4gbkBtiqLsmk1h1icco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552960; c=relaxed/simple;
	bh=CHQDyUXiNgeITHooFXLtFvM3RIgxujDK7Gc+7zy1Mi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfyZoUuilrlWSZcbQH2KSnsKih1S9smh9e8SoMk+9JAJN5H7hmTwuZX9askb0k/AN7Fd8Xr0PPWdBgyFFK5ARC3wYt6M5QukhevzTisEKslPs4igHHQJab3qmupghxQPyzaxLBfrQBdGMITQcp+PAUev153q3skAKFAt/wOoTkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YH2qmVBn; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH2qmVBn"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c2d72582cso7042218a12.1
        for <git@vger.kernel.org>; Mon, 27 Oct 2025 01:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761552957; x=1762157757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHQDyUXiNgeITHooFXLtFvM3RIgxujDK7Gc+7zy1Mi0=;
        b=YH2qmVBnAspCnQ7G0k3+bLZtVzmwQ4+C+qJ4KicfNK5wPV3quJGMUD1nud4VjwATU8
         TH/AsDND3c5IjU7f4X5Ez8VjIGjSXhFbF05tD3m7WCrUaD08IWjZxVZuj+5yN1L8rhw3
         JYbaG7IoQcJFv+9QMr4OZgYvFBzN0WslC9n7kmaX5TJFJr2v51BZsSFladb1TFILuorw
         KadiSg0k/6Io1hgL3E9KEIuJIEiFo4qkFqSCPGlGvfSYrxTN+LuytWTLYeJ8R6STWYeL
         kIZxNQedcejrbmLvlhEDvEbldo50SoNYuPEAv4nHGLJi8V3RWLoOH/R+SES3jl6w86PQ
         li1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761552957; x=1762157757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHQDyUXiNgeITHooFXLtFvM3RIgxujDK7Gc+7zy1Mi0=;
        b=d0L/Ilw5ksY7lxl3mjPYwkurvkTJ9WHGBSG6bw8odTGBsmwGUZWDGpGFIuCETxRkS5
         YGers9u9id96OdAE4M3HLLC+P1wF6bc2bAAkfVi4Isw1B9gSbAcX0cQzflOuhguUeyuY
         vBrfp7vfVcrZ4Qr0BhGfe1dlBoZ7btvmZMlq5ZiBoFehbVfPLCOvSxe8hHBxAMAKfEj6
         QZ/wfsMogWoMfm7dM8oTI5t9NGv7shoaNXVaj2MYOX00mPl7pFNi0X3W33GoQaREYFXJ
         3Yb22/b/1w4US+CPK1xYltPJTlVyLGeHR4Wlt09lzJrs2qrm6LO/aRtO1SYOKXmUb2jg
         KSgQ==
X-Gm-Message-State: AOJu0YyrXsxmWjrOHP8uKNsAtWFQUUeq7XhDdnbYj41eT1zrgFVlH3Oz
	RdEtc1Ommh1nCHYKe2KZa+S8NP1/uGfnF3lg8Tn9TpbDMUgOswiXm7zMh9ffGxtivq3loTc+ZOq
	C7fCICZPU+uLSLNgnK56YJ5I1CWYgfDg=
X-Gm-Gg: ASbGncvJbmVvfJW0d0qdMJdmb2LI8rl92KHyCtyGWyKL+8kxSJTJd5ljz8y6VLljNq+
	MLmdxSjBF8kcKc1K7A4eOj8DUkb+BUTvlQpQ4F6C0xUvYt2zAS4LhJGPNgsIEjKraFtmA4WeRbN
	03WZXA3iLHNWkdYr3JHTlpJgF/aBzz0eInxNr7UmXeNaNCrgWbvxLozBVXtDk5+nHDSIUpd+A6K
	4BQHH800Nl4QjJOpBIR1VQjn3qGn8CxVUDftvMlkbNBLl0s8UpCHWyJKPDQ
X-Google-Smtp-Source: AGHT+IGTDWb30r6e9vUUnLsrRKi9GSIisiMYxMUHenFl11p9eS8BFU2v+GkERtXDqwoj8SFgexMz7MEugAzT/pq2SPc=
X-Received: by 2002:a05:6402:2681:b0:63b:ed6b:54b2 with SMTP id
 4fb4d7f45d1cf-63c1f64f396mr33855457a12.9.1761552957279; Mon, 27 Oct 2025
 01:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD=f0L-Pr9MtQ1=Wrm3tybZFWKDUtDpVcOahoFUgdVcGKJm7Vg@mail.gmail.com>
In-Reply-To: <CAD=f0L-Pr9MtQ1=Wrm3tybZFWKDUtDpVcOahoFUgdVcGKJm7Vg@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 27 Oct 2025 09:15:45 +0100
X-Gm-Features: AWmQ_bl03A02_an4RzbP5zKmjz9gRgvEPWXspT4lzolJyAYxHGZG03_vf9iahq8
Message-ID: <CAP8UFD39hqkcy3WeOdS3Z_N8t5kMTipmE6-N_MwR6PhozZLfXg@mail.gmail.com>
Subject: Re: [Outrechy][RFC] Request for final application guides
To: Bello Olamide <belkid98@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 27, 2025 at 7:09=E2=80=AFAM Bello Olamide <belkid98@gmail.com> =
wrote:
>
> Hello, I hope you all are doing well.
> I'd like to appreciate everyone including Christian, Junio,
> Usman and Kristoffer for the guides and assistance during
> this contribution phase.
> The deadline for the final application is in exactly a week's time.
> I'd like to know if there is any new information on how to submit
> the final application as the Outreachy page requires us to record
> a contribution by submitting a link to the contribution and also
> submit a final application to the project.

There is no new information. Most of the interesting information
should already be on Outreachy's website and on:

https://git.github.io/General-Application-Information/

I would suggest fully reading that page again. You might find ideas
about things you could add to your application.

> While going through the mailing list for previous final applications,
> I came across this thread
> https://lore.kernel.org/git/CAPSxiM-kf8U=3Dvzp5MoD3tUuOtnNjcCgPhLdriyeQo5=
CGf=3DEhyQ@mail.gmail.com/

Patrick's suggestions are great

> where the main points regarding my questions were answered as follows.
> 1. We should use the link to the microprojects for the patch reviews as t=
he
> contribution link.
> 2. We should specify the current status of the patch, 'master' or 'next'

Yeah, it's nice if you can give the object ID of the merge commits for
patches that are merged into 'master' too. For those that aren't
merged into 'master', the branch name (like it appears in Junio's
"What's cooking from git.git ..." emails) is interesting.

> 3. Send the final application to the mailing list for review which should
> include an explanation of the project we want to tackle, links to the
> microprojects and a rough estimate of the project timeline.

It's important to send the application soon, so we have time to review
it and iterate on it (like for patches that are sent to the mailing
list).

> Is there any other information we should know of or this is good enough?

I see that Usman just replied and gave good suggestions too. So I
think you definitely have enough good material to help you prepare a
good application.

Thanks.
