Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1F32DC349
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095792; cv=pass; b=Ce5jXbBCc658Q3ksJ9wP5QtfdZd5bl80Vc/BFaqoAuuSHLzPDmQJ8n9GxjUhcHBwjcvQNQc886dSeBt87gNz/ZhMOBRssO6aVRuqrHMqN1QLAiJW2SMuDSQV7BXBDe6obAda4tBZlgwGi20Oe8SNINX4lG1Um3a4kV6CH+3euvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095792; c=relaxed/simple;
	bh=DsdGZxZHKbg4LmOcAaucGl7Cn45yiQ1R7xRyRJrJEKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5Ilanv2rKuSOvEOayAfR59/9k/x+h/9hcFuGezHQUk4b3TEz8+AMef1TwD5hJ1EOkgqYtlkK5atgti2oIHuoAaquMxEXk6c+0Cxsf6SyqLiMAmGV72Xa0z9KeGbaXptCve+m8uouKKdcvQ+Eh5qKMPEnRwO2zyj9WbXtIsC8bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+plIvAm; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+plIvAm"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12448c4d404so1189717c88.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 07:29:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769095783; cv=none;
        d=google.com; s=arc-20240605;
        b=dtLrl12yeA9mpG5ddwPNg258YGANFQU09Axhp466c/HnLyife8ccGuyygrT59GyAqB
         9EMBQI8ec9WD+7v3sA8L6L8u/sQzczLE07Gj+4QLQBpHS7jJhRgBFsvgbDGng9nbSMRY
         Mp5j6NuxrnhWdTQoSYUpcsoAtXFtDnMSXQpYX2foxB2bOKnJo7TEIBE7BVFsyWUTQyNN
         7NmnMr32/7ZhkjoayRVDjxQ4ZZklp0HEY0XJHS3FiQ4Kc+Yr8xHmttRtbmAT473iENQe
         Yr6ldliCiaPWrLf1JPYwscn/jkoCGsgBVRTtB27VDhQH5s4e6Q4v1oetWnRityYMPtT0
         2sbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7V5ySvnh+GRNKfyuBbA7GiNj0PJRA/im5k5WXNH8Bck=;
        fh=SUtS5Uxcs1MaW7qAkYHaLrxMI/luGLAfuRKahcKGaig=;
        b=KpMX2lrHQtdYw1QqVjhgU3hhtMj9ZQlQAKWv06sGO0qxWmjQJ4IzzjJRU/fSJhhmLi
         CGhIH5u1evLDRFdulKMXQdcleu9MGoqwc7IesFwe+GPH8EYE+nUs01fbrrMn8H+afWQt
         ZpeHZ/4zAhPDcSjb91qaW0ndFM1uH2Z8vBZz9LtVDqQZf4n8Rf8rTdIGUyVLYuGJT6MV
         yLX3xQwekYjkyILYqZ3qlRMfPs11vB3+y2yZS9zDu+lmG5ut6yQMK2k07kuwpX8opkRb
         jQjSxEmkrqeN8CLXm1yM4+5ktt+5oI/h7NRBbiPskNfBka8AtzrSMei4sOyFI65zy/zs
         2+oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769095783; x=1769700583; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7V5ySvnh+GRNKfyuBbA7GiNj0PJRA/im5k5WXNH8Bck=;
        b=T+plIvAmX9tbnUglsByL4CLy6mB6TMALgaNuE4ArFoZ2MImQrceu6eRF7cWGyKKQ6z
         i8zXTlV3UZ+wfssUdE4h57G1FSnuYfgkQ5ID0Vkun2cvmuW8kSCXWU7GijOqJzUw2VXN
         0ALss3sRGJiDK2OuZl/c9dMNIYBnlOOYgv6nazCYBwWQf1dWEcdwSMDiv41FHjaVA5dm
         whmQ0b9qBVltZBT6CHtv4fJnMETHBA94w3Nu480xUJbQFiYXY0v/Yk0Sf3F7QcHJPICP
         J3rrgiEkXSw48IDxA0HzM/FMcXAkv3yEKiZ8YOL778WLkxj8hPrkpjZ/gHUHSZkHO0HX
         86PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769095783; x=1769700583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7V5ySvnh+GRNKfyuBbA7GiNj0PJRA/im5k5WXNH8Bck=;
        b=jo0MqAfvZH+hmBi8rmI74t7GMwt6UoiF+TDRlXJQlW4fl9Jr2Hgd9fdTfcn4BkzFkZ
         oXV2iiNKyMTQfGsK8LE2oW7bgGplgYO6mZY7UjrgQKmeZCeJ2MLc6NYCNEIAdj/19DBE
         GAkfZJ0NvkFm/lPIgUIf+eRj8GPNPILx96Z/hLxjJH4PrSOVSMU33Qc6gCYV7meWXxqV
         SgmuFYrUl78PnQ60eDuMUrSn9ApXb+sJ+iw9VDMyoeeNzpfaktjuJsVdUjBgM8v2TGwu
         DyU9uHtaxtuH2kaiCgVUPbxgqzZv//aOEz9fKfrZXpdMLgViHEQHlVUqdbLUopFbtTpn
         sqOQ==
X-Gm-Message-State: AOJu0YwNOaaDyNwyfuSXcZaTF3aOsTmDoLucynFhw1RHfCaKNetmKu2U
	zioNbkEZxzr+RzrLGhjmSx9QKnIusDi9WKyrMJBTk4tm40DFsw1J37qjVMmi+fN3dzUI9vgo1Fs
	rDpQqxGzQZILgCkeC35vDDg8L6D2k7Bs=
X-Gm-Gg: AZuq6aKWS1GCAoFAI0eMJxeRTmprUkmpM9AcJZaNUiKnqINLBv2JSJr7oUdyQa6z6Q2
	uDdTM89DWxjhG4DbxiigfolVf8vHx1Ik5TSoyjCSqmql8OAJcg2KxZKHFoTrBAEvzyFdsIcKl0R
	MyUowshm7LvOUMElpB/5CSTD40mfiSD9NGJxnh2JDDLlXrbwlGJmBN+IJfl4NdfVduafW0gjY9F
	IqZ4Ucvagl4gZJxeE9PRdl/WW6qIzTqhC7kOuzydm6VF7iFdLKpn4U3Jf5N3IsrBm9SlmKjfZk=
X-Received: by 2002:a05:7022:4582:b0:11b:95fe:bee3 with SMTP id
 a92af1059eb24-1246aabf3f6mr7103725c88.37.1769095782940; Thu, 22 Jan 2026
 07:29:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768681947.git.belkid98@gmail.com> <9a411db9f8f9df37c7a5f100d97c8d5ff5f6ba97.1768681947.git.belkid98@gmail.com>
 <56ac85bc-8e12-4cb9-ba22-db021c473110@gmail.com>
In-Reply-To: <56ac85bc-8e12-4cb9-ba22-db021c473110@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Thu, 22 Jan 2026 16:29:43 +0100
X-Gm-Features: AZwV_QhmBEGzPmsARTCpNruHu_x4cqqUgrjx0URvFuuWCf506tanaXQiBp53saM
Message-ID: <CAD=f0L_VP3jN-_B9-iyEd6WPURHFBvOUJgy4HPUv0vSp29P+Qw@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 3/3] environment: move "branch.autoSetupMerge"
 into `struct repo_config_values`
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com, 
	karthik.188@gmail.com, Toon Claes <toon@iotcl.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Jan 2026 at 15:41, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Olamide
>
> On 17/01/2026 20:59, Olamide Caleb Bello wrote:
> > The config value `brach.autoSetupMerge` is parsed in
> > `git_default_branch_config()` and stored in the global variable
> > `git_branch_track`. This global variable can cause unexpected behaviours
> > when multiple Git repos run in the the same process.
> >
> > Move this value into `struct repo_config_values` to retain current
> > behaviours while achieving repository scoped access.
>
> Same comment as the previous patch about repository scoped access.

Okay thank you

>
> > diff --git a/environment.h b/environment.h
> > index 3b5ff7094a..bfcdffe836 100644
> > --- a/environment.h
> > +++ b/environment.h
> > @@ -2,6 +2,7 @@
> >   #define ENVIRONMENT_H
> >
> >   #include "repo-settings.h"
> > +#include "branch.h"
> >
> >   /* Double-check local_repo_env below if you add to this list. */
> >   #define GIT_DIR_ENVIRONMENT "GIT_DIR"
> > @@ -89,6 +90,9 @@ struct repo_config_values {
> >       /* core config values */
> >       char *attributes_file_path;
> >       int sparse_checkout;
> > +
> > +     /* branch config values */
> > +     enum branch_track git_branch_track;
>
> We could probably drop the "git_" prefix now that it is not a global
> variable.

Alright thank you for the review.
>
> Thanks
>
> Phillip
>
