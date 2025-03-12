Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185BCA31
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809778; cv=none; b=OeUwrBqvCzO0tyKz7oqKkZ8KzqfsgTZqT1HAJT89XG5b3ohZzp7oMw7KnluHq0v6+/+fbJ8WpykmbUJ3KkTp3ZMXTeBZqLEy6MG4WnixCfDDkXBw4+MQM4RHRKE6kZ8Ae6LwAE9GTEwEiDNeKmcNgIsnb0s/IekmQoYRiASlbD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809778; c=relaxed/simple;
	bh=r2UB7XVblTTHx0KU4+fR7EWt7Crsb3OCWc/xiNqGcvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cV+R1hHE4r/yxcWaOFkG1lCXyiS2oGCaPLpQDd+XWR6W/BBIurnKeUzYQ8onfKNOUMX7c3TeZPxTACLq9XWjP5PQ+EcSu2aawCGxfFodLtkZeELIea4Tt1uRocezWQdxtu2p+sysgm41gIDdKmDQsH4Z0UXkROL2PKRCKVrqCGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cV3T3B6S; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cV3T3B6S"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6feb229b716so2088017b3.3
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 13:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741809776; x=1742414576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bNmoJgIrcLvNZEnZ+fBkXNdubneZIwuUoQduaVmXxy4=;
        b=cV3T3B6SNlPdmy7T1tx44Me6te2viV5h/qiX7f9HNBJXxozIT/s72h8S2SDX1HhXXm
         Ejq7JfDoMcqBoxH4EzqHr0Cyy4N9R0gi8+2oRMO9eq1DCWr6dVYgPVe/3ozpzEH8EvYY
         0LlVwItyN5MEcOOQf/lK/Y05dgOei8GP425CxabL++lGimDf8Xhr1Fyp4ZugQoBEFBml
         XGyJHVLmv1/myFTNFP7pMDRjPzVqM1c72MGrzVOvk0VWFqAebUx5k8T1iphQGJNtrixi
         533DUjl361NqzAsSJQDZqSwGbzXig/hblgmF1eEPx8NJ4ceWzPNynKxpCJQHuXBLY098
         dKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809776; x=1742414576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNmoJgIrcLvNZEnZ+fBkXNdubneZIwuUoQduaVmXxy4=;
        b=KbulXouwGbhlTOYJBNonO6bXaTUB6WedsjG4yWPKhrGRezuqvem+SJzUhgOoGca+W2
         VHp/XqrOiFYuUwhmAluWLyJDYtznk4M+Kx254OLvOp6ZKeFJ2Tmek2UAdxO8N3C0DuvI
         L+CpJhFaH7vUeZN/TrkN3+lx6wgqCCyuEKOwfCgn9be3MqlC7L7TxJZTwp1QC+WBSv34
         AYOGHyZgEnTgbiJ5NLgDt4mPYlPFouXzDshWxIe9h6Zk5FriUdpHOxOKjxWlXjiWULag
         mU5v6jd0I57AGU8fMNGbP1MwJckl31atVr9x1VuPGQfXIhPHu99Anaqq6pBr1Uu4LJB+
         nkJA==
X-Forwarded-Encrypted: i=1; AJvYcCXV79tEhOnfo2AUBlt7ALfwEgqQz94xr1Dazmr7cwS1TwpXU6tsjQtbb450oqGjgprpQ14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvIyna5Bq1RE0+o/1FPIw4egekSsMDi1enXm4k64YiVj/Wex3a
	kTtnYUjiEf+y5REETyuWiOl0mDH5VbgY3bo1kp+LpfBsdxFJj3iVmKilU0gkTo4=
X-Gm-Gg: ASbGncvYlNmFLduPIZHBRb08wBz7plzSIor0UdE2KkOZFDl/D+ZSBQgpSjtUFyCufPu
	fPUlL3DFRtCYDn5qGVC4TXd2nF0y4Ll9GGLMvh3ibnI5Ln6Dov8RXJSRc6dZr74es8R7IwJ2ZCb
	F/CvEEiA9xvuzVhDZQIeVDXD2vArBcl1PyLGr4pnOb0Uerd++zQh45bG/WRddyONp13ME9DDOYP
	SRSiW3em5ljR7vxdlsliQ32OgzkWGiixsDszUPLIBpCWdt18J056Q3+E6ZVpl6BumtzV2hF7G0t
	20jqTYLEJ+1jBWcDpZtntbw/nYAWXtbbTzyrXsNKKC8pcKt6dFiq/6SQf3AUKjscdOq1BrXk8i1
	8+nsbPuQKNjOR3h63
X-Google-Smtp-Source: AGHT+IF9TE32SB4gRp6neoPV6K9qVj3SAiMo5H/xfwquUyfrF5g8w8NldP+2sIrLDUCUecRhQpp8Mw==
X-Received: by 2002:a05:690c:6813:b0:6f9:af1f:53a4 with SMTP id 00721157ae682-6febf3ae047mr337213167b3.32.1741809776006;
        Wed, 12 Mar 2025 13:02:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6feb2a8aa70sm32889817b3.61.2025.03.12.13.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:02:55 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:02:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] merge-ort: allow rename detection to be disabled
Message-ID: <Z9Hobtp+9esKkY/O@nand.local>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
 <4292b22723f759c3e0f84ac1000992187a9c7f7c.1741362522.git.gitgitgadget@gmail.com>
 <Z9FAix-VKGte8UKk@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9FAix-VKGte8UKk@pks.im>

On Wed, Mar 12, 2025 at 09:06:35AM +0100, Patrick Steinhardt wrote:
> On Fri, Mar 07, 2025 at 03:48:41PM +0000, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > When merge-ort was written, I did not at first allow rename detection to
> > be disabled, because I suspected that most folks disabling rename
> > detection were doing so solely for performance reasons.  Since I put a
> > lot of working into providing dramatic speedups for rename detection
> > performance as used by the merge machinery, I wanted to know if there
> > were still real world repositories where rename detection was
> > problematic from a performance perspective.  We have had years now to
> > collect such information, and while we never received one, waiting
> > longer with the option disabled seems unlikely to help surface such
> > issues at this point.  Also, there has been at least one request to
> > allow rename detection to be disabled for behavioral rather than
> > performance reasons, so let's start heeding the config and command line
> > settings.
>
> It might be nice to provide a link to that request for more context.

I don't know if a link exists; I suspect the request referred to here is
an email that Johannes Schindelin wrote to Elijah privately).

But I am almost certain that the behavior requested here is to disable
rename detection to match the behavior of GitHub's prior use of libgit2
to perform merges, where we also had rename detection disabled (for
reasons that are unclear to me, but Peff might know).

> > diff --git a/merge-ort.c b/merge-ort.c
> > index b4ff24403a1..a6960b6a1b4 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -3448,6 +3448,11 @@ static int detect_and_process_renames(struct merge_options *opt)
> >
> >  	if (!possible_renames(renames))
> >  		goto cleanup;
> > +	if (opt->detect_renames == 0) {

    if (!opt->detect_renames)

?

> > +		renames->redo_after_renames = 0;
> > +		renames->cached_pairs_valid_side = 0;
> > +		goto cleanup;
> > +	}
> >
> >  	trace2_region_enter("merge", "regular renames", opt->repo);
> >  	detection_run |= detect_regular_renames(opt, MERGE_SIDE1);
>
> Do we want to add a test that demonstrates that the option works as
> expected?

Yeah, having a test here would be nice.

Thanks,
Taylor
