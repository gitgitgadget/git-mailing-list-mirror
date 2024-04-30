Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134133398E
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479264; cv=none; b=UtTz/Ch0dU+xaB+7KTd4mM5Fr1Xk3nxS7akeHjihl1dNZeIIQeI52ByhIB9hTQcqQvQzSU7x5ufgLCrMoz80PvKDN87m98QxsG7kYHcDeuY3ql2D7VZrX1A2ZHwtmyrhZtv4RZpbffx2Ker2x5vUzcELtiZBy7EhSR+F+6EewM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479264; c=relaxed/simple;
	bh=9lPXmwNUWbRQROS9/QcbWZHUG/P7jgmjSjwhu1P6SCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGm3glIXxdCLtTo6fJCb6rnuaaf1C5YWV8RzUtNCed2dmW4RqTxyH4rOpmuFtbYOlOMEdhh41MWO+6qQzkp2Nn0VnLzWGBN/Eau/iTTfUHgYu0DLnXiVpseLYllb4ZAmPaGSdUXlFvZUKVQSWjTRsjbL0TtMMY+TZKY1pEGR7Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wcQgyRyV; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wcQgyRyV"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78f02298dc6so474454485a.1
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 05:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714479262; x=1715084062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9lPXmwNUWbRQROS9/QcbWZHUG/P7jgmjSjwhu1P6SCQ=;
        b=wcQgyRyVcSzwLZ1cWgrfjoMreTEBMy0iCwREOyN0niZcOKNtN5UCfGWmw7cayeUKTO
         NXvPbCj5k82q4Dws+wn/w1ukYDxHrLW7Gv2O0uGdrTju/LsLph6MkFcHirs8jmEBS7MM
         JqtYwdKc/gNDUBbA0BHK9DSWaOU3QFBfdEz+w+C+GpfLmvMZblRSfJijgTrQfsNkal55
         VIxtcuDp6Z3Qw4cD98X/QQewc3BO7z8M0VJ/iUHWNgEBGrprrzTJSJzTp8FFAlw07D4v
         XxaY5Muy2WYqeY4pMspuTcOO/dtSayzCxM1m6Ia5LVKym1KZ+ZAV/2f32ITgtjxzewzl
         nadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714479262; x=1715084062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lPXmwNUWbRQROS9/QcbWZHUG/P7jgmjSjwhu1P6SCQ=;
        b=DTNXNtWYTnHl4DL7hxsmoOgNf1ewY7eud1s/PBVzHJcv8Gsh6Hjf2gHsd8JgpDs4aQ
         MhK3R7m+h8ssoJVk+p7swZW/A9D1xzq5+uyq/WUKFmL7/H8CWQvSRW0SpbaWL29rTGxx
         AchJZFKG5oSQ76TwwmXMbCf+Nl5YO4arh09FStHHKV36p2FWKf0AaawVCwcVNt03ESUi
         NF94laQBGREcTCNWCEJHlWH3JJfIIy3cVq9+P05MVoRcXPMiRzex59fqViIYl/IlTQns
         HPrEUGY9PqZfSZY8lp6YjK/3BeTNsWfV09yrmHtMLqdpHQgGXlyUw+3Mg3iYlgX//6tZ
         1blQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxP7hYutNl+FSlGUgLahhflX4jyvxaLOOANEelBUzQ1pCeWpP9x6aKSEFOQhq7KOCNa+a7H56GDAr9vCQXUL2gZ3P+
X-Gm-Message-State: AOJu0YxVcLlBzr7BwNVYV+50VCW25uYgLCZA/8S+8Jd8/0LjrdV3g36/
	zSQ0PzewsKsLuJdjdM5hn9E0jZJf54SE9Ohna+8Fs8/+hoGYP+RKNHoaIhU39JbeQKegmonghy8
	hQIs=
X-Google-Smtp-Source: AGHT+IE70jbM9R6yS7PwPUGnADvPbMkZFS53x00+09aj3JaB2jDVmwWNYggQIAfnjVmdl411BkCPgg==
X-Received: by 2002:a05:620a:4481:b0:790:96e8:5bfa with SMTP id x1-20020a05620a448100b0079096e85bfamr4477591qkp.4.1714479261855;
        Tue, 30 Apr 2024 05:14:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a8-20020a05620a124800b0078f28a08785sm10212820qkl.88.2024.04.30.05.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:14:21 -0700 (PDT)
Date: Tue, 30 Apr 2024 08:14:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] gitlab-ci: add whitespace error check
Message-ID: <ZjDgm602Zry2inpa@nand.local>
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240430003323.6210-3-jltobler@gmail.com>
 <ZjB77nSMou0ssu-V@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZjB77nSMou0ssu-V@tanuki>

On Tue, Apr 30, 2024 at 07:04:46AM +0200, Patrick Steinhardt wrote:
> On Mon, Apr 29, 2024 at 07:33:23PM -0500, Justin Tobler wrote:
> > To check for whitespace errors introduced by a set of changes, there is
> > the `.github/workflows/check-whitespace.yml` GitHub action. This script
> > executes `git log --check` over a range containing the new commits and
> > parses the output to generate a markdown formatted artifact that
> > summarizes detected errors with GitHub links to the affected commits and
> > blobs.
> >
> > Since this script is rather specific to GitHub actions, a more general
> > and simple `ci/check-whitespace.sh` is added instead that functions the
> > same, but does not generate the markdown file for the action summary.
> > From this, a new GitLab CI job is added to support the whitespace error
> > check.
>
> I still wonder whether we can unify these. Yes, the GitHub thing is
> quite specific. But ultimately, what it does is to generate a proper
> summary of where exactly the whitespaces issues are, which is something
> that your version doesn't do. It's useful though for consumers of a
> failed CI job to know exactly which commit has the issue.
>
> So can't we pull out the logic into a script, refactor it such that it
> knows to print both GitHub- and GitLab-style URLs, and then also print
> the summary in GitLab CI?

This was my feeling as well when I read the cover letter. I don't think
we should either (a) have to remove functionality from the GitHub
specific version of this job, or (b) have to maintain two different but
highly similar implementations of the same job.

It seems more reasonable that we'd do some third option, which is what
Patrick suggests.

Thanks,
Taylor
