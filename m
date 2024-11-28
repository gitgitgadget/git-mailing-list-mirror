Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14679823D1
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732816949; cv=none; b=PBECyjgFEOHmdQEnpCdRCfP9c9dPF6gcf7ictklkrB/IfatPRo4hTF9ajPm1qfWgt8mjzsKytDNWKn9ZvHtrMKdHJjwh5pPWTcWrqjrqHpKmCYIyr8l307RFC9AeLMQQqUQhZZSVc2KyTajqIS2KaciaTS4eSU9ME3l7TP9scf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732816949; c=relaxed/simple;
	bh=6e/evaAjKpeJ9fC3uY1FwbJXIoS/ywZXZk9Ud+zVrvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUz2+kPVhtm0X8bqMuJx2CoIzsddvTs4ecNJMCn4LJxlutVSPutKF560n49JkdnBvA/AAM7CBQjP5a1Kfa37zHzwHE9qQNikhl2Qa8koqd3Fay1Yb9+5+veoZTp8B3ahHA1m8D6UEsfWXx39voN4BybftA539Bn3mPhR7irMKt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6d4254fcff3so1698476d6.1
        for <git@vger.kernel.org>; Thu, 28 Nov 2024 10:02:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732816945; x=1733421745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQWY0GsOi5xnIVBGsOozFvdtiiakBdCzrxnZXcObAJU=;
        b=mnPdtSvgrI9I2eqyK1NIRnZ+SEVvCgVOdCocQvtuwWg+Rs6ADJ2n7B7yHEf8ThtGQl
         azK7L6FexEODl2JaPcQnimzdFPcz3avhRNdhMvjUvejZi7XBIZhj95CtLVDGeB/rIrcQ
         dNgK7tG5ND7Mbe5TE3k/+6oGcnndZ/u+eY/cAicQdLl0fIN/KxRg+rxUR0FbAu+10W9B
         FcWTfu9rKRB422CzrdG/sFERNnte+cM9/yO0uUNYIJASxesbpGQE8dDsDyl+A2KamaBD
         JQ9SF3M81ORNNo8pTLCPLJ84ZZZuZdoCd2yqRizSE9xhkoL7R7hrGV7owx6/FBrhSNRh
         B9fA==
X-Gm-Message-State: AOJu0YxX4TBZioUi63HzoAkSrREiFsZ9dAxeXCmyhZqWy5PDqPsb79IT
	aYOGWQWfdAazgFbCuIwKWWLyFqZ3IYlIsbMlXo8b3Sj3Rc8+zGjFysZZ1vUvkgaP6xMr1Fhq1l4
	tIU1Wpio8jIXPVHUds34Pac5n+Aeq0Q==
X-Gm-Gg: ASbGnctuhgY+MnodxadVNon5z15RVQ5rEN8wnvldDhdbkmyWAMbZClF6B6MguwUUi+6
	ShMFT02KgbT44OWkAozoD7HnfXYAthQ==
X-Google-Smtp-Source: AGHT+IGdXueHWiifnBvtMuNJiUFMAB832VTt3g/yhQkVY+k83OFhLtrIJWWmj1YNZctswdWUOkMIbNMrZrx7XOYay+o=
X-Received: by 2002:a05:6214:194a:b0:6c3:69f9:fb5b with SMTP id
 6a1803df08f44-6d864bf9239mr49093306d6.0.1732816944647; Thu, 28 Nov 2024
 10:02:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1730787532-3757-mlmmj-5e7be4fc@vger.kernel.org>
 <CAL2+Mivva3AFR4of0-2d48YDDMbHiNVsUmCzhezHfe+h9faEvQ@mail.gmail.com>
 <CAPig+cTVfNW4AFJKyGbRcy0_YJEJGcNYNx57USyp4zz1g9fSeQ@mail.gmail.com> <f03edd8b-d863-4307-95d5-84f36b4e8349@gmail.com>
In-Reply-To: <f03edd8b-d863-4307-95d5-84f36b4e8349@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 28 Nov 2024 13:02:12 -0500
Message-ID: <CAPig+cRLO0Vw_da61fZWygyEC88X6-2OXtDe1WKs55QnBtPnBA@mail.gmail.com>
Subject: Re: HTML message rejected: Re: git rebase exec make -C in worktree
 confuses repo root dir
To: Git List <git@vger.kernel.org>
Cc: phillip.wood@dunelm.org.uk, David Moberg <kaddkaka@gmail.com>, 
	Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>, david.moberg@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[reincluding mailing list; David dropped the discussion off the
mailing list only because he couldn't get his email client to send
plain text, not because the conversation was intentionally private]

On Thu, Nov 28, 2024 at 10:07=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
> On 28/11/2024 07:36, Eric Sunshine wrote:
> > On Wed, Nov 27, 2024 at 11:04=E2=80=AFPM David Moberg <kaddkaka@gmail.c=
om> wrote:
> >>> To: Elijah Newren <newren@gmail.com>
> >>>> My commit merely pointed out that long before that commit came along=
,
> >>>> if GIT_DIR is set but GIT_WORK_TREE is not, then the working tree is
> >>>> assumed to be ".".  As such, a command like the above where
> >>>> `--show-toplevel` is run with just GIT_DIR set (to anything) will
> >>>> merely expand "." and show you that path.
> >>>>
> >>>> If you are going to be having subprocesses that depend upon the git
> >>>> directory and the git working tree, I think there are two options:
> >>>>    * Set GIT_WORK_TREE in addition to GIT_DIR (as my patch does in c=
ertain cases)
> >>>>    * Stop setting GIT_DIR if you're not going to set GIT_WORK_TREE
> >>>>
> >>>> The second point is a bit harder since setup.c automatically sets
> >>>> GIT_DIR for you in various cases, so if you want to go that route it
> >>>> really means you'd have to actively unset GIT_DIR in those cases.
> >>>> But, you'd have to be careful since you only want to unset it when
> >>>> setup_discovered_git_dir() sets it for you, not when the user who
> >>>> invoked your command had manually set GIT_DIR.  So, there is a littl=
e
> >>>> bit of a pickle here...
> >>>
> >>> So, what is the way forward? Is the option of setting GIT_WORK_TREE m=
ore robust?
> >>
> >> Hi, sorry for posting this on the side but I only have Gmail on androi=
d which doesn't allow text only emails (I think).
> >>
> >> Is there any work ongoing on this item? I think I lost the conversatio=
n and/or fell out of it.
> >
> > The conversation ended at [1]. As far as I know, nobody is working on i=
t.
> >
> > I think Phillip did a good job in [1] of summarizing the two paths
> > toward a possible fix. Unfortunately, both paths will probably require
> > a good deal of spelunking through the code and the history to
> > understand why the logic is the way it is, and (importantly) how to
> > craft a solution which won't break existing legitimate use-cases.
>
> I think the solution of always setting GIT_WORK_TREE and GIT_DIR is
> probably the most practical. Even if we find a way to not set GIT_DIR
> when git is run from a linked worktree I think we will still run into
> problems when core.worktree is set as that also appears to result in
> GIT_DIR being set without GIT_WORK_TREE.
>
> > So, it's not necessarily a small task, and whoever digs into it (if
> > anyone volunteers) will likely need to devote a good deal of time and
> > effort to it. (My Git time is severely limited these days, so that
> > person is unlikely to be me.)
>
> In principle I'm interested in fixing this but in practice I'm unlikely
> to have time to work on it until the end of Outreachy in March. If
> someone else wants to take a look at it in the meantime I'll definitely
> try and make time to answer questions and review patches
>
> Best Wishes
>
> Phillip
>
> > [1]: https://lore.kernel.org/git/743043bf-60b7-4ed7-8cf2-4f3f972968a6@g=
mail.com/
