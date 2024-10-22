Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E28319B3EE
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729601673; cv=none; b=e0wOPNywmcYQoL5/J3QGzYOVB5A9vxltefMyAPVioyQc+29K7hRWzR0RalJw9jSbD3Bniq6LFdYaidAjfGF+VmsqDqORLoFFLkVQUh6JxxOgdvuhc11rSv7uzaVy0AWrmNX1JbXPChzRVq9epyTCE+eMMZ8VfXhQqVT+R1Xg+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729601673; c=relaxed/simple;
	bh=jLp1cOdwCU/9he2+/pzs+1mjDLkJr9MDcrUM1FyXWmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKtTMAo8QeVplC6Nh3y+3lwOXXZEdB0mY6sMnNOu2iqbep5XkcKdPiKL/u/Ts0glrZisgd3nBIrq+eOZ+EhOTrEzSFS09clt3qQRJ6nPWB1T7pDaO9VnXLYnRk2+BDPT+LFXAYDTRVgESv3XfgHBXmxZG3wy/7STPLIIO/yd2mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReqxHbJa; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReqxHbJa"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-50d3d4d2ad3so1825883e0c.0
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 05:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729601670; x=1730206470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x68EEWf5bZ1GgZ8F5ljRbwiq17gUxx9B1zL0bDXwpRU=;
        b=ReqxHbJaed02twt0XQT9rh17jKnwsyKSvoTass912yOQ2CSSYpLB1MAMfcBZ6m5r56
         LtHtjBhxnfZvY+72Y7KwM06Mhn9a/8Wg3AdJ99lAKBDJkYjDG8ZBxvnTSF2nro6tJ1a/
         bnqq1AN/hitAqRvVfzbJjyaKi+FGjFPUfVTSrDg05V24Xxcg6uqHr3RIG1JDT87GkGwC
         IsZORa+y8zMbMi/0j2gRLN8tQgHYYY0rTFkOkd745ZFfkKWq2A87jfCeHItka1mnsZNF
         o0R6sJ47hEs6MiA0Y8X+H4TFAJ7fFUfJKGEJTHrusi5PqJd2F1+GpcnB8TvoDerJQ0kd
         cRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729601670; x=1730206470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x68EEWf5bZ1GgZ8F5ljRbwiq17gUxx9B1zL0bDXwpRU=;
        b=YXb1FaTPZkoSdJl3An8KUmLHsSzrm46X5HT6TKJjQyHA7rioEcVVWKYY6t8QXXTAp9
         x0IzTE+c1LPY9RmPd8rN6UFB/HYLmUWpkiDyRYomtYXS0OxKGNH0vaFpObGFCdX4sqAa
         wqI92Q2S3hBcjDzpQ4RegAmT0I4nEJqL+CzpErM0qWdl0OvSAZD1HC47JVTGWuQ5JGpt
         RR+uXqYQCwRB9+/lUH+rdj/RsgqEXT24yg8q3u/4GfU0cJ4Siud7DH6VZ9DSeyxew3AN
         c0iOh239AD06sG0VbxFcU7QVXcjaHqjFpOZDGFRex9mTHd1Zl+QHKGlLCdxobIR93bED
         X9Fg==
X-Gm-Message-State: AOJu0YxnKmMWW2Y6ORUfTXMMj8xEKMTrvka7vHvb5M8Gu6pCCRc3hDUw
	zYs67Kd5ukP7g0aoJ4I1ulgsvMFKhVN88kVNmTvkGdD3vAhnpacB21eyry8YpTIcireElodnfG8
	vEbTCphMEWp2T8YNCptF0mXfA3dg=
X-Google-Smtp-Source: AGHT+IH51CDhaB4A22yjrFpfxZOdfezYlwuFWrvvKyJkKfZBqGYEuyLoEeLMNFwmNBN1I4riiUU1wu8zLa7QZc8Wb9k=
X-Received: by 2002:a05:6122:a20:b0:50d:bfb2:4f2f with SMTP id
 71dfb90a1353d-50dda165e77mr10596604e0c.2.1729601670116; Tue, 22 Oct 2024
 05:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSxiM-kf8U=vzp5MoD3tUuOtnNjcCgPhLdriyeQo5CGf=EhyQ@mail.gmail.com>
 <ZxeWDTFHpHmVePdF@pks.im>
In-Reply-To: <ZxeWDTFHpHmVePdF@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 22 Oct 2024 12:54:18 +0000
Message-ID: <CAPSxiM9WQMFu+qTgR9LPk9erVUFgPU5tqRBobTomOJhm-hiLAw@mail.gmail.com>
Subject: Re: [Outreachy][RFC]: Final Applications expectations.
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 12:10=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Tue, Oct 22, 2024 at 11:45:14AM +0000, Usman Akinyemi wrote:
> > Hello,
> >
> > I hope you're doing well. As the deadline for the final Outreachy
> > application is approaching (Oct 29), I had a few questions regarding
> > submitting the final application, specifically for Git projects:
> >
> > Is there a specific way we should record our contributions? For
> > example, should we include a link to the public mailing list
> > discussion of a patch?
>
> Yes. In order to make it as easy as possible for us mentors I'd suggest
> to provide a link to every patch series you have sent to the mailing
> list in the context of Outreachy. It would also help us if you included
> the current status, e.g. whether it has been merged to `master` or
> `next`, as well as the commit ID with which things have been merged.
>
> > Are there any community-specific questions or expectations we should
> > be aware of?
>
> We outline the details that should be included in your application at
> [1]. The most important things are:
>
>   - Your self-presentation.
>
>   - An explanation of the project you want to tackle as well as a
>     rough timeline of how you want to tackle it.
>
>   - Links to the microprojects / other projects you have done during the
>     initial Outreachy phase.
>
> It is encouraged that you send the proposal/application to the Git
> mailing list so that we can provide feedback on it, which also allows
> you to iterate on it before the deadline. You can search our mailing
> list for examples -- most of the recent proposals in the context of GSoC
> for example had a "[GSOC][PROPOSAL]" tag.
>
> [1]: https://git.github.io/General-Application-Information/
>
> > How should we go about detailing the project timeline in our applicatio=
n?
>
> We only expect a very rough timeline here. It should give you enough
> ramp-up time to learn about the code area you'll be working in and then
> give a rough idea for how things will be progressing. I'd recommend to
> not be overeager -- it is fine if things take time, and Git is not the
> fastest-moving project. Also, account for the time it will take you to
> get knowledgeable in the area.
>
> Of course, that timeline isn't binding at all. It rather serves as a
> demonstration to us that you understand the project and what subtasks it
> can be split into.
>
> > Is there anything specific that mentors are looking for in the final
> > application that we should take note of?
>
> It would be nice if you mentioned anything that could conflict with the
> internship up front. This includes things like you picking up a new job
> during the internship, which may limit the time you have available to
> work on projects.
>
> Anything else should be mentioned in the link provided above, I guess.
>
> > Thank you for your time and guidance!
>
> Thanks, and please let me know in case you have further questions!
>
> Patrick
Hi Patrick, thanks for your reply. As you may know, Outreachy has a
kind of form for submitting applications (they have some set of
questions someone has to provide answers to)not like GSOC where the
applicants do not fill any form for their proposal application. I am
guessing someone should add something  like self-presentation in
answer to one of the questions as there is not really any question
asking about someone personally. I think what is near to it is about
previous experience.
Also, anything about applying to two projects ?

I will start working on my final application to get enough feedback.

Thank you.
