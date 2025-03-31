Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF09D210F65
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743430675; cv=none; b=Tw9E0atxX7nFDvPJmtI9T5tGWWuwvYgC0WF1eixKSMJtGF9HTStcSDR+hnh/Dr4TY8VmjxP0ZBfjNUINZyG8kX+Vbypf+1emEbplDUh1REW5matkX8g45Ww/zpJQj6ivx6y4B5gf5Mxoqeq1nqy3Tz3c7iAiAiVme/hmxGPt37s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743430675; c=relaxed/simple;
	bh=arpS8N4o35rh95HiMJXPNQRNjczbgCdnQ9xO4lgO50Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRE5Q/+gHvckpAdeXKZgwZR/B8wjkKz6U/TFLA20EYFaLeyXG2hpF2+IYlB7UZSnTy1dVqPfytcxifKAHRBDMrXiOAdtnIZ74fr3oaNXg+WQ5gb1G1Xj76OZiTyWOj7KgLuZBjApChjosp+eApFCxUmp6O03CV5HkZ1IU1dm3bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmyp5AdQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmyp5AdQ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223fb0f619dso85391575ad.1
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743430673; x=1744035473; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nskUr3+wpmajGVI7y+Xif1nCESUoYO0uhfjJ7QgRLLg=;
        b=fmyp5AdQFSS2NC49U1icWhmkQ2+CvgXmXUpbQ3wBGIcRFZGGlJmPK73gBbJwph8kOz
         SQHhhTq/cSJKoKnUMfDC0BUNucNc1vWCf9peSWpHfLVut+mPGBfdcF+OeXA2u4H4UR5x
         asi29Fh40H0X+jDvJC5NeqzKW6Q5OHnriar55yLP0x01XPF+iwqwJt//PC9RqY0+uajG
         cC6VLxGmTsvDHqBeV1AWqSkrw/YZw2dki09Q0YseWjmpVpR08xz/FLHhg2oTAriEvSz0
         2N9TALwBTsk4lIF4SMae/OZo805gHl2najlwz5/NGq9DaWYKuzGHH4tROYR8dciQvC0C
         KqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743430673; x=1744035473;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nskUr3+wpmajGVI7y+Xif1nCESUoYO0uhfjJ7QgRLLg=;
        b=ClD4Djfa0/wvRH4n05/eCkSOw47eYDrXO2MdKq5lD8sIOEcL9XNzu/i5XeBA86r4bd
         +vVOhmHWG6WL+vXZtlymacl/uahySe6siqPdtBbzUdM8mjrHO59jSI5Mh6tHiP+rgHO1
         vH9866kqSgR7eqkTEjTH6YCWrAKMIHXuK8M/l+/PSSLVJLreTqW+n76ulWaIQ4o8Obga
         8U6ndX14qIb3zAkQCAdQLX6aKnlvhaCbxZQuYiYbVMKeAhGvc08zWXXndrbLG++jI+ii
         wJVl9UAdCAYulps4UB7bLxpbjkldKO8Fi2VigTWgTOvi9ujCTYg+D5Jw4B7xr1CpwcrS
         ev3Q==
X-Gm-Message-State: AOJu0YwjdtJ70CjeJL9EQP+AweGCPEYZDGXy5S8XctruroMretu05OTJ
	PxSapxTMcq9tBLMQ6Hc8b5tDFXumocFYohVQjXKe7DeU7gxQ+rUM
X-Gm-Gg: ASbGncvS0MQAtS86wAOA74KYr0v2Yt9KNahvhZD2d+qGWTehW6YnVoGzums4CvjhWAu
	MIlLLFeIoaGq1WCCwcoYbsXL/7xgAzFmSrKVLTaF3IYUmHp6OETsrTpEVzpYQo5efA21fDDTEjg
	GOE1Rcov3nhcjj3Dgs0F5mK6LpGiHZuEL8pSZmHDpk/Zov4vMgYth2ZzyNMtNg28aLV7r4OxhuH
	1Mlq5Br8XqUgyZQAmmZ0/lC5ZNP/slzDFbBgBo84G0wPzvaYGe7K70UBfIG1Gtjk9vXqwLCn3Iv
	Rh4efqQKAJhxi0Wyhnhhyp8/mXXQmxOOd+Mapn0J
X-Google-Smtp-Source: AGHT+IHTqM55EGeYG8dlx1NIxQ4VlCO+OEe36wj7DaL0ZzbWWvQ+ZFnP4rtvUZzfv1gin/LtuaLW7A==
X-Received: by 2002:a17:903:2f85:b0:223:501c:7576 with SMTP id d9443c01a7336-2292f95d080mr147242805ad.12.1743430672786;
        Mon, 31 Mar 2025 07:17:52 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291eee20fesm69761105ad.82.2025.03.31.07.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 07:17:51 -0700 (PDT)
Date: Mon, 31 Mar 2025 22:17:58 +0800
From: shejialuo <shejialuo@gmail.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com,
	christian.couder@gmail.com, shyamthakkar001@gmail.com
Subject: Re: [GSOC] [PROPOSAL V1]: =?utf-8?Q?Refact?=
 =?utf-8?Q?oring_in_order_to_reduce_Git=E2=80=99s?= global state
Message-ID: <Z-qkFmc9xJXXTzut@ArchLinux>
References: <20250326052602.265989-1-ayu.chandekar@gmail.com>
 <Z-ae2l6fkurPNuPe@ArchLinux>
 <CAE7as+b8qZFEcaH9eJcQnuhZOSW+hfAMiPUBXNPj9x1L7rcXVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE7as+b8qZFEcaH9eJcQnuhZOSW+hfAMiPUBXNPj9x1L7rcXVg@mail.gmail.com>

On Sat, Mar 29, 2025 at 03:24:05PM +0530, Ayush Chandekar wrote:

[snip]

> > > One key challenge is determining which variables should be part of
> > > `repo_settings` and which should remain separate. While working on the patch to
> > > refactor access to `core.attributesfile`, I received feedback from Junio that not
> > > all global variables should be blindly moved into the `repo_settings` struct.
> > > This reinforced the need to carefully assess which variables belong in `repo_settings`
> > > and which should be handled differently.
> > >
> >
> > Yes, this is correct. I somehow think whether we should put this
> > paragraph into Pre-GSoC part? I think that you have found this when
> > adding a patch to remove one global variable. And thus by communicating
> > with the community, you have further understood that the requirement and
> > the detail of this project.
> 
> Yep, since I encountered this while working on the patch, it fits well
> in the Pre-GSoC section.
> Moving it there would better show how I learned more about the
> project's scope through
> community feedback.
> 

Yes, this is my intention. This represents your ability where you
interact with the community and get feedback. And this is what we want
to see.

> >
> > And in your plan, you should just say that we need to do this. Would
> > this be better?
> >
> So, I should remove all the categorization stuff and just say that I
> would focus on
> each variable, discuss in the community whether it should belong in the struct
> repo_settings/repo or not while sending patches?

I think you should put the categorization stuff into after-GSoC part.
Well, I don't think you could focus on _each_ variable. This is
impossible for you to talk about the way for _each_ variable. I somehow
think that you could just write the proposal about how to handle one or
two global variables.

You already touch one setting "core.attributesfile" right? You may just
elaborate more in the proposal.

> I felt that keeping it general might seem vague, but that's the nature
> of the project. Every variable
> is unique and would need a different approach and outlining the
> approach of each variable
> in the proposal is not very feasible, as these decisions need to
> happen collaboratively through
> discussions in the community.
> 

Yes, so you could firstly give how you want to handle the global
variables from top. And give some concrete examples to demonstrate your
idea.

> Should I still mention that once the project is complete, we could
> consider structuring related
> stuff if the community sees value in it.
> 

You could, mention this in after GSoC part.

> > > This plan is flexible and may be refined through multiple iterations as I receive
> > > feedback from the community and reviewers.
> > >
> > > Timeline:
> > > ---------
> > >
> > > Pre-GSOC:
> > > (Until 8 May)
> > > -     Explore the codebase more, focusing on environment-related code paths.
> > > -     Document how each global variable is used and how it can be moved to
> > >       repository settings.
> > > -     Study Git’s Coding Guidelines and the Pro Git Book to align with best practices.
> > >
> > > ----------
> > >
> > > Community Bonding:
> > > (May 8 - June 1)
> > > -     Engage with mentors to discuss different environment variables, their
> > >       dependencies, and the best approach for refactoring.
> > > -     Finalize an implementation plan based on discussions.
> > > -     Since I will be on summer vacation, I can start coding early and make progress
> > >       on the project.
> > >
> > > ----------
> > >
> > > Coding Period:
> > > (June 2 - August 25)
> > > -     Refactor global variables, replacing them with repository-scoped
> > >       configurations.
> > > -     Modify function signatures to pass `struct repository` explicitly instead
> > >       of relying on `the_repository`.
> > > -     Categorize variables into specialized structs to improve modularity and
> > >       maintainability.
> >
> > As I have said, this is a high-risk task. Categorization needs many
> > iterations. And we may do this after GSoC.
> 
> Yep, will update that.
> 
> Thanks for your review, again:)
> 
> Ayush

Thanks,
Jialuo
