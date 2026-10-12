Received: from mail-vs2-f4.google.com (mail-vs2-f4.google.com [74.125.227.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00DE4AC156
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833735; cv=pass; b=TYs/5+kdOQxu+l1A6bdh7iBL7wALEVyVsgRCaPFBqIS4KQQwqvBNCWq92tcsJX2YKPNP+o0i3iwltIhNTGB4Ew6ezH8wokRLkybGSFAVRZkkcb26s1nkS1NH+5DBJmRy0NerZsoJMOgFBJ6GHtaHChnmOiGrghC6YDosyQ+b2P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833735; c=relaxed/simple;
	bh=z8ryKs5px7xsHkWyrWodvVADBdYtfRhemJ9/uSjlTEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thhBRHCaKp+6v0YIlNUt4ABlrlpqRulZTCrTacV1yucsZbZcZa4Md7UhkdV6nZr8v1Qtp3iiIWzZgvPVHVHiWRKZ6I30x/qtS6VCQG7fTsiqqkjC/e4sX/7HP6Z8k5Vsq9Gxad2nGNLcIHyR91DBGumlr11UCtxj/uAoY8RG7hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbIsy6B6; arc=pass smtp.client-ip=74.125.227.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbIsy6B6"
Received: by mail-vs2-f4.google.com with SMTP id ada2fe7eead31-7c1103e81c6so320093137.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 12:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791833733; cv=none;
        d=google.com; s=arc-20260327;
        b=qTb9XO7j4QG0MkHKylLJzs7Yg9tRhoD3++clol6ocq6DQtBY8W0m/V7kLmUFinyAM8
         Y1pFqS5s985/zxWqF5v9E6Ea2JUuMIFqPXCn8GkPqBEvFQZw/AlveoimqRoF+yEfj1PX
         sZGocVTliLCA128F4+wbFLUD0P0YAsT99l/WeyjSIog25l6SMWg7SVCNapqSJplTzeRo
         dXzrOaK2TpfX+nxJx265UKhdxHenaCxYLTcr4ENVKYsNIVZUTnDWZPEbGCqSHAKRqheN
         9zTHarr01gJeVbRsg+LbMGExKZ/JOh7X6rRKx/Fh2VLY0Q5wYhZufQVnscMRMZcWeP7h
         jclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WBZkJH/9AzE/0pgqyWQG3oqCJ0IZhHZGvPDIhEjcuHU=;
        fh=VV3oqeA/wKg8E/MQlaee9LdKyybTp/4JbgI2GUt/VRg=;
        b=A9GFi5HfijNKkl/hMk++pQJXlLXw1dGLbEj9m+ta28deer6iJF4YjU3Me6dKiWFytF
         8YyI85G9EC+umKqPfAZ9olUUZg+wPu1toUT1QtZChI0GZwj/DWLOl4HRp837ymR/BKFp
         w03r24WF4cRSwx77x/XJCnD+gzuCH0uv7YQX+DH8YqsGm3g9kkqd6r3U6/v/94rAloQu
         2tXmV/fesRBO5iKbrGxNUWsExdCZGP+cpKcD6jvzIXbBX6DVx+x9Dzhm6OCULWRBxKBv
         z8waSIPYhg5KiuI2xXe8YVhEjq0h/U02NgkQ1sc1Qz6QOejzHagxPy7iNgPcjuGQSMaC
         REAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791833733; x=1792438533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WBZkJH/9AzE/0pgqyWQG3oqCJ0IZhHZGvPDIhEjcuHU=;
        b=UbIsy6B6YFlrjGky08sNfulXT9KXn8w5/T1b1UPIau5MPVBooxsKdzn5GYNvE1wTEA
         HrplpmSvXNuzPGK+0QEelX+cZApnfpxWht9r9J1pgwu8HAxa63mS23XtQkSAZu6bxyrB
         37QGltP723b6HbJVztQBCPbkLeuz9zK/mIXTYx5H5dfZCrPP/iac9UK/vPOaNXhshSxx
         Di2hqAdBHTkYIfsPKDwCrjVvFFc1osxtqA9R6LT7UcDXvo9LkvmV9zkL9pVU9naEzRpI
         NnwraiyVB5+79eGTTTJZ+tH/RE9UcsPB7linrgEbTUDhTpoNWbu4kaJafnznIw9DUcPK
         NX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791833733; x=1792438533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WBZkJH/9AzE/0pgqyWQG3oqCJ0IZhHZGvPDIhEjcuHU=;
        b=Z3fnK+wVHg4J45iJJu6jALIfaeJEDJVDHl60OJ5p4A/hM5rbP7Y4WTKaxeFHvaOJc1
         STkwGc8sriO4LDkC8wo7kTHc9RsCmezIuCsv5Epcq2ytmKWzq4PFJVVe4DSdHRLVwKBX
         C8pRo2Bp9CyIHtnWvLjF0QWjxDR3dkvFeMac2QMyIfkCxntMBaeE6d/u89rXXDrsoJ/C
         2Z6Oj1zgeGGFRagrtVlGEQEdugYuy6I1xG8jIEbFMTVMIwsAqZBRObMJg2wDfn8xxFYN
         yvSIbTYM7J8jflMwvOXnMpAp90AmDXoZDc8GKQ3Ol9UcZ4BY3IPYOmlAZaa3OvBdcjNU
         1hMQ==
X-Gm-Message-State: AFq9FYJsH4++F+vDQABAPbTxiV8gC0NnMvV/NcdFWeYjpGsiXQMZ4+l8
	HW6U67A3K+SGLh3LvyjzzsZw0qYeOSDluRezQAtfs11ZvWFx96d8DmC8ji9oV1rMDRsvDAlBT1g
	o3XZwie9W5eF/GJnWg9x3Epe3Xjp6snRt3GEkPBb9Aw==
X-Gm-Gg: AYBFou136scliKOr/zT0GVM2KJUKmMiqVnki6riN2qRNiech1W7StKuqSQQBN+7It0i
	f4oLk3uIBKj+7dj1B0PXTzdbckJxLnkkTn5fTdD7kr8MyZzO4Rr4Q6OInzqRhaQwfLZYSOP4dac
	o/RWKJmkrpCOcNFqLm7pFVeRFwZButZCQ5KifCBtXB8illrL6dFCaUDp0qrz8myvf5Sd7jBoHWs
	WraoIQEWYU3orzK40B9pNwuD7lM2uu7+vL5QrGRGjEDdl+avXf9Un20fYEcwXB4iyEtNtL/nXS1
	OpRrxGoo/QP9ioWmoN8UGy5fsReZEMA04ZVUluA9rC5FqzBoONVGyDzbVXpzJY8dGQQykmONN8z
	6dPauGvGZCHY=
X-Received: by 2002:a05:6102:6c7:b0:7be:37d8:1567 with SMTP id
 ada2fe7eead31-7cb37250478mr2664461137.10.1791833732671; Mon, 12 Oct 2026
 12:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKA8Uu30SPCV9uAtn2K_0sVrD=FEt7DzdgYUWfwtbh019xK0MQ@mail.gmail.com>
 <CAPSxiM8Xjysm7XbXEmtkMkaFnOcb2wWY5-YRUKd4tGsx=DodUw@mail.gmail.com>
In-Reply-To: <CAPSxiM8Xjysm7XbXEmtkMkaFnOcb2wWY5-YRUKd4tGsx=DodUw@mail.gmail.com>
From: Joy <cryptocurrencydiva@gmail.com>
Date: Mon, 12 Oct 2026 20:35:02 +0100
X-Gm-Features: AclHuK-tRojYMnwMe5jCU9c9Mj54DQ42t6cHQHGsG7vgpjCmVOuaVBKcFgBMvU8
Message-ID: <CAKA8Uu3d_SuB=USUdoY2Tz+oySAotr1WdvMbpdQ7ejQ+dWyrUA@mail.gmail.com>
Subject: Re: [Outreachy] Introduction: Joy Gundu, applying for "Reduce Git's
 global state" project
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you!

On Mon, Oct 12, 2026 at 7:07=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> > Hello everyone,
> >
> Hello Joy,
> >  My name is Joy Gundu, and I'm applying to the December 2026 Outreachy
> > internship with the Git project, "Reduce Git's global state to enable
> > Git's libification".
> >
> Thanks for your interested in contributing to the Git project.
> >  I'm based in Abuja, Nigeria. I'm a software engineer specializing in
> > Frontend Development (e.g., React/TypeScript and APIs), and I'm
> > learning C through this project.
> >
> >  So far, I have built Git from source and run some of the tests, and
> > I've started looking at how global variables were handled in past
> > patches.
> Good.
> >  I plan to work on a microproject once chosen and will send a patch to
> > the list soon. I'd welcome any advice on how to approach it. Thank
> > you,
> >
> Go through this links if you have not already done so:
>
> https://git.github.io/General-Microproject-Information/
> https://git.github.io/Hacking-Git/
> https://git-scm.com/docs/MyFirstContribution
> > Joy Gundu
> >
> Thanks.
> Usman.
