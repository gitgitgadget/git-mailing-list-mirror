Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BDA39FE5
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729150776; cv=none; b=U1zSsWHUzh2tpdDPFWwKFmrTZKEQzXSUXUiRWMj2dpayDn43SGfyZAC/IZJs1WfBL+anoVBxN2PJjDz/MsnsfRB9FLsAACb/6yOTNQEcJvnQjRalBZp1h+TEOZvj3+TSJ3I58erPu2suOPUoNeakhTq4kqx/3ID0ddu9xb7Q4jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729150776; c=relaxed/simple;
	bh=acu0zo6haAYRMyHVEVUIdMa2c/X1CFTWr5Zjl0POBjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXJg5AjRY7MrBxWvkyBh8L0wSTrg8hTN2frQofTcnEyLOUhlszHNWDLLbpMGk3FtWOKPyNHsLo4XqRtfsjAZVWeZZHJBVRTandv4vi0kaho+VTCdYRnCjZVjMYY8u++cWO2n3MNV4U1lXCX3ZVX9rVH0gXIZdlqcLb1rXAXvu1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkzjOkzY; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkzjOkzY"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e314136467so5857447b3.0
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 00:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729150771; x=1729755571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Jl7KRBCLlh7Y/yMsJJKbZMClc8sJggCXpuOv5+LuHU=;
        b=ZkzjOkzYuKXgKgn9bdtdgb1qYVodAxcNjWx1vfpHcvpectp+i0LLYLO9ghwZoIzHSW
         daqGneINKtZF2cb61LZt6rxw0PdSMR3beAVkrEP+FQIqqJ87sa+71YXIGCi0rklUpSjF
         ydbuBNZjPqUTHHJIKlb0bUj7ZUYsjwsM858Aq3mPsHsmLkF0mDZe3Dxi6S9JLFjnSMfa
         IIjsOEUBXHQRUHjEMnyNk8xL7oXkBJmboQplZdXu12wD/q99RQ2+PeAa1Fm0sqGxbZRY
         Yiz428aJdGseAnqqKn6hkzFf1v3dtUdavl7F9n1fDPY5UzIUobqUc8MUuUHMsj8/GTak
         89uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729150771; x=1729755571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Jl7KRBCLlh7Y/yMsJJKbZMClc8sJggCXpuOv5+LuHU=;
        b=uHbut4f0fkseraH0V5V0kC1vo6azY335hSU3RIFd0klMvV/WJ+rs944ajGWFcNbUnt
         rfFaQrx5ST7saNpntL/J3felZCuzeAGbxcrbKEVcWN/zxs6OHIcf+YRCWPAbQzyuL/ze
         Lu5qzMnbrQzlfa7TXQ5yzNIN3W+8HvBPx2HZd+wYA8HoXg3NxZsU2Wd90gvBkX/FkLbv
         l49Q0nI9wXoMRfw1a7rwMlgoD1fzInw/SL7zbciVwNzB4W5AKjcBB8Gdnd0VR+B8gO3q
         LvOjHes0hc9kSTQIBmzHB6GMmFr++3Xhs9cHfcl+jdFcdeNYSnYaznExQs7Us3QZ+eO2
         zTMg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ2mxV2Sb5h/bbTu/SK8IwA2lisT+D8/NwnrsyawijHORzkIO+9DYnsw9j6NmZT3fblsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Gk7M3IfktXByDQj1Z7MYJW8mPg+KLDsnZleg7gO7Jw8eZ4oM
	qEQPALATMRCk6D6NozM+3p/E5BuuF/OoZu/5ubMKdA+f2KIHVJ1TnI51OAdgMxbq9o+MrRWcGJ3
	51AH0pfs5UMKyyx70MunxTZ8alNBtZ/0MEmOlQeKU
X-Google-Smtp-Source: AGHT+IHda5TWQ1ETKCwupN19E59E9RgghSLIDbK+XassQDHUyucNf1MdO9SdlkERMloQr1qqGLgOQE3UydprM8s1FUA=
X-Received: by 2002:a05:690c:480b:b0:664:74cd:5548 with SMTP id
 00721157ae682-6e5a3d2d313mr20559237b3.1.1729150771291; Thu, 17 Oct 2024
 00:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGedMtfng3eqH7DY=2cnBPdrEWyPpJmEFwW5vBH3ruz=b=ym8w@mail.gmail.com>
 <Zw978QPS0jQMOm6I@pks.im> <CAGedMtfo2RhrPv5BC3ci6tW0XW9ZG73yMD-_sJqe+oR4Gb_dvg@mail.gmail.com>
 <Zw9-YYpbu9hMQQ7y@pks.im>
In-Reply-To: <Zw9-YYpbu9hMQQ7y@pks.im>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Thu, 17 Oct 2024 08:39:19 +0100
Message-ID: <CAGedMtd_BbtV6n7C6HV2VsYQ_aCfEuK3LPfFk6jAMd72apfwvw@mail.gmail.com>
Subject: [Outreachy] Internship Applicant (Contribution Phase)
To: Patrick Steinhardt <ps@pks.im>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello everyone,

My name is Seyi Kuforiji, and I am an Outreachy applicant. I have read
the following documents;
 - https://git.github.io/General-Microproject-Information/,
  - https://git.github.io/General-Application-Information/
  - https://git.github.io/SoC-2024-Microprojects/

I want to get started on modernizing the test script:
t/t7011-skip-worktree-reading.sh using the specifications discussed on
this thread: https://lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_b7V8Hg@mail.gmail.com/.

Before I proceed, is anyone currently working on this test script? Is
this a good first start, @Patrick Steinhardt and
@phillip.wood@dunelm.org.uk?

On Wed, 16 Oct 2024 at 09:50, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Wed, Oct 16, 2024 at 09:46:04AM +0100, Seyi Chamber wrote:
> > My Apologies Patrick. There's a second mentor on the Git project
> > contribution page, I mixed it up :(
>
> No worries! I basically assumed that this is what happened, even though
> I was confused by you mentioning MolEvolvR and not Git ;) For the future
> it would probably be preferable to send the emails to the both of us via
> Cc such that we don't answer to you twice. I've done that now.
>
> > Yes, I want to contribute to the Git project and would love your input on
> > how to get started.
>
> The first step is to do a microproject in Git to demonstrate your
> ability to adapt to the workflow of the Git project. You can refer to
> the following links to learn about how these are supposed to work:
>
>   - https://git.github.io/General-Microproject-Information/,
>   - https://git.github.io/General-Application-Information/
>   - https://git.github.io/SoC-2024-Microprojects/
>
> Let us know in case you have further questions! If so, I'd recommend to
> also put the Git mailing list into Cc with an "[Outreachy]" tag in your
> mail's subject so that other people can chime in, as well.
>
> Thanks!
>
> Patrick
>
> > Best Regards,
> >
> > Seyi Kuforiji.
> >
> > On Wed, 16 Oct 2024 at 09:40, Patrick Steinhardt <ps@pks.im> wrote:
> >
> > > On Wed, Oct 16, 2024 at 08:52:24AM +0100, Seyi Chamber wrote:
> > > > Hi Philip,
> > > >
> > > > My name is Seyi Kuforiji. I would love to contribute to MolEvolvR. I am
> > > > skilled in programming languages like C, Python, and other programming
> > > > tools.
> > > >
> > > > I want to join the public channel for ease of communication and would
> > > love
> > > > a pointer on how to get started.
> > > >
> > > > Thanks in advance for your help.
> > >
> > > I guess there must be some confusion here. I'm neither Philip, nor do I
> > > know what MolEvolvR is. I _am_ an Outreachy mentor in the Git project
> > > though, so if that was your goal you've got the right address. :)
> > >
> > > Patrick
> > >
