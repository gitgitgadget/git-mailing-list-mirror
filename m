Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88AC22306
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="dj0k+wSm"
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DF4E4
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:12:27 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-66d24ccc6f2so1418936d6.0
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698779546; x=1699384346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j970HtbbnF0zWbHI7Nheu/lB6FtH9Usta+hoNiQ63Ag=;
        b=dj0k+wSm4d7WjTvN41umPeG4Y0ypAh1TXwkMn4QSZwG1X3lZONgTHLtYWaZWBzsFVo
         z3cKdFlUNGsQg2KHasZ33i5KDmgP5rqaG4Fg2ZGaBWMXYRLnZ0L0o/NBNyMCsRgLOkTm
         r6YM/W4qGv1QYDnCK2uU1vFNntBr23P82dXpd5G/EnnqWyIrD9eWSW/O0Vgjk4WZKs+y
         M6NkaygkNZOh6E5yJSi+vQ4iLntAPiHpzcpL5gIUpuKIvImRgmpygIBb4b63GvB8W9O0
         QSwP0pzi1SeJtaCfbLbFzZaydTKOD7cP++kbA+iFFI9X1TOpPtb5MiobsAEXmfiksRRb
         cMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698779546; x=1699384346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j970HtbbnF0zWbHI7Nheu/lB6FtH9Usta+hoNiQ63Ag=;
        b=QwhrDuiGqQ2pdlS2bh1R0Y2EDmIWS/5cWUfY/OoQ9GiQGADRfIEnIKnA5HtvSOvdD5
         CiDywTDcksj6ZgDbjCTEbXl2E36v/A/YJzMNHP6QUCUxlEgUXy8lmup9bfZyyaJ9eUmq
         3iKiE7j3wspxOgEs1uds60NTy1TjIHm69qUOFyx1wwjOxcFfzD1GXDztKDhkZ0luzhq+
         QvlWT71vg45EPRQ4HMwqE0T5nyejchkEOIeuHz3YjRJgrlDlZ8eWbG+SbJf89SUaa46+
         ZOdbfv0Pf2UpSD6XUiFMFa3OyB+GlqROSx02VjZQYREUBWavuWp2+GpFkb0TqS6JSb5m
         1fSg==
X-Gm-Message-State: AOJu0Yz7BRvuVwODcpHpvLJ5WZFu+aQ/odX6S+v1Tq74NP0qhtfr9yr3
	OU9fL8Q63ZnKsplggVaPaUqXjYKnzdbUyekgUCCQiQ==
X-Google-Smtp-Source: AGHT+IGVYX0AAbQIDjMwwAvfIHGWq1yI0Na7CliSsuEU/iOhyIeyht7gtD6WckCfonIR9jOJNd0OuQ==
X-Received: by 2002:ad4:5109:0:b0:66c:eef9:4154 with SMTP id g9-20020ad45109000000b0066ceef94154mr1043479qvp.23.1698779546364;
        Tue, 31 Oct 2023 12:12:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ev9-20020a0562140a8900b00670e0f71ff7sm783503qvb.90.2023.10.31.12.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 12:12:26 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:12:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] ci: add GitLab CI definition
Message-ID: <ZUFRmRf7bN7U4afW@nand.local>
References: <cover.1698305961.git.ps@pks.im>
 <ZT/P5Bl9lD9V6ID9@nand.local>
 <ZUCw1B6oQaDWKx3O@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUCw1B6oQaDWKx3O@tanuki>

On Tue, Oct 31, 2023 at 08:46:28AM +0100, Patrick Steinhardt wrote:
> On Mon, Oct 30, 2023 at 11:46:44AM -0400, Taylor Blau wrote:
> > On Thu, Oct 26, 2023 at 09:59:59AM +0200, Patrick Steinhardt wrote:
> > > And this is exactly what this patch series does: it adds GitLab-specific
> > > knowledge to our CI scripts and adds a CI definition that builds on top
> > > of those scripts. This is rather straight forward, as the scripts
> > > already know to discern Azure Pipelines and GitHub Actions, and adding
> > > a third item to this list feels quite natural. And by building on top of
> > > the preexisting infra, the actual ".gitlab-ci.yml" is really quite
> > > small.
> > >
> > > I acknowledge that the Git project may not be willing to fully support
> > > GitLab CI, and that's fine with me. If we want to further stress that
> > > point then I'd also be perfectly happy to move the definitions into the
> > > "contrib/" directory -- it would still be a huge win for our workflow.
> > > In any case, I'm happy to keep on maintaining the intgeration with
> > > GitLab CI, and if things break I'll do my best to fix them fast.
> >
> > I don't have any strong opinions here, but my preference would probably
> > be to keep any GitLab-specific CI configuration limited to "contrib", if
> > it lands in the tree at all.
>
> As mentioned, I would not mind at all if we wanted to instead carry this
> as part of "contrib/".

I think my concern with having it in Junio's tree at all is that it
gives the impression that this is being maintained indefinitely. There
is definitely some cruft in contrib that we should probably get rid of.

But since this is coming from an organization that sponsors work on the
Git project, I think that my concerns there are somewhat more relaxed.
I'm not worried about this going unmaintained, so I have no objection to
having it live in contrib.

> Yup, that's a valid concern. As mentioned, this patch series does not
> have the intent to make GitLab CI a second authoritative CI platform.
> GitHub Actions should remain the source of truth of whether a pipeline
> passes or not. Most importantly, I do not want to require the maintainer
> to now watch both pipelines on GitHub and GitLab. This might be another
> indicator that the pipeline should rather be in "contrib/", so that
> people don't start to treat it as authoritative.

Yeah, I agree with everything you said here.

> > My other concern is that we're doubling the cost of any new changes to
> > our CI definition. Perhaps this is more of an academic concern, but I
> > think my fear would be that one or the other would fall behind on in
> > implementation leading to further divergence between the two.
> >
> > I think having the new CI definition live in "contrib" somewhat
> > addresses the "which CI is authoritative?" problem, but that it doesn't
> > address the "we have two of these" problem.
>
> I do see that this requires us to be a bit more careful with future
> changes to our CI definitions. But I think the additional work that this
> creates is really very limited. Except for the `.gitlab-ci.yml`, there
> are only 54 lines specific to GitLab in our CI scripts now, which I
> think should be rather manageable.

Agreed.

> I also think that it is sensible to ensure that our CI scripts are as
> agnostic to the CI platform as possible, as it ensures that we continue
> to be agile here in the future if we are ever forced to switch due to
> whatever reason. In the best case, our CI scripts would allow a user to
> also easily run the tests locally via e.g. Docker. We're not there yet,
> but this patch series is a good step into that direction already.

Agreed there as well.

> Last but not least, I actually think that having multiple supported CI
> platforms also has the benefit that people can more readily set it up
> for themselves. In theory, this has the potential to broaden the set of
> people willing to contribute to our `ci/` scripts, which would in the
> end also benefit GitHub Actions.
>
> In my opinion, this benefit is demonstrated by this patch series
> already: besides all the changes that aim to prepare for GitLab CI,
> there are also patches that deduplicate code and improve test coverage
> for Alpine Linux. These changes likely wouldn't have happened if it
> wasn't for the GitLab CI.

Yeah, I appreciate your careful and patient explanation here. I think
that my concerns here are resolved.

Thanks,
Taylor
