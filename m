Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BCB3DABFE
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369653; cv=none; b=H+sSMMcBG8zdwqwphNvy7b+Ro5ihGxTFBZE3Gk7PvRGv+egUIwyWfNTBTUde1ZdhEuHke4W0EfmUMrsVCewsc+02r4NX/U2I8dgQgSDVqP87OtvN3ZGaguTrfHErOvHaxLovWQQoIOcsPeOhZV4G+f30uzuiwukmTffn9Kl1KuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369653; c=relaxed/simple;
	bh=KDXdo3+VeaDK5H01XH3kUKOe/5cXRUeqUy+8p2Q/BiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9rzTsrpIWQt2NIKp/+ZBFl1TIz0RKmJXC2EFYaiGze0Dj/CdjJfpyg+xVyWCTQ+6pKQbGBC64IdHeq/qP36R4UCO+8I8tplah79zEpEiXyZw2mkuWqJTTeq7jR5606nLfKwlGhHc/VOQwZ/FD3Hh7BMwAMUXVU55c5+RAo49ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=VKXMlgwC; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="VKXMlgwC"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:d5de:3293:133e:f31a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 5AC196039A;
	Mon, 25 Mar 2024 13:27:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711369640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aXKtfdGKYCEkspoMCdpoDCoh3gmbXsfYv3R8HXZKaMI=;
	b=VKXMlgwCwqZhW2rFF39vhD6QVfzatSKwCgqBhu/eBuINmfFVgM46YQalaVXwLlj7yuLIuX
	Kz81bdb6j/paf3kOPZJ3NquJwWuLgD7lH2XUdd4X+QuNa+qqu6tHir/MAPt41RqM33GeVf
	F2xl1G6nOdWbBUGD8ffVme6M9cX1CWYUWdedQUNpGH7RHIj0s9q2/R7xfmOGI/z++PowC6
	Qkhu8R0Rfgd8yG4nsdOVloZVGxMrv4qDky3MG8ny40Y3DJovKITPjiyp76LydXCdDuMzNU
	eMIT8jUbFmrl8BIgmexLyD6ia7x9+e9XfEraZHHd7urlSZ76hIdLpY9MyD0nLg==
Date: Mon, 25 Mar 2024 13:27:14 +0100
From: Max Gautier <mg@max.gautier.name>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/6] maintenance: use packaged systemd units
Message-ID: <ZgFtorXnGPm45oO0@framework>
References: <20240322221327.12204-1-mg@max.gautier.name>
 <80580cc5-0285-43d2-ac51-71dce16f0028@gmail.com>
 <ZgE2pFt-pXurYnKU@framework>
 <03513931-7070-4430-bfae-aa039f73d74b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03513931-7070-4430-bfae-aa039f73d74b@gmail.com>

On Mon, Mar 25, 2024 at 10:06:29AM +0000, phillip.wood123@gmail.com wrote:
> Hi Max
> 
> On 25/03/2024 08:32, Max Gautier wrote:
> > On Sun, Mar 24, 2024 at 02:54:58PM +0000, Phillip Wood wrote:
> > > Hi Max
> > > 
> > > On 22/03/2024 22:11, Max Gautier wrote:
> > > > * Distribute the systemd timers used by the `git maintenance start` with
> > > >     the systemd scheduler as part of git, rather than writing them in
> > > >     $XDG_CONFIG_HOME.
> > > > 
> > > > This allows users to override the units if they wish, and is more
> > > > in-line with the usual practices of distribution for systemd units.
> > > 
> > > Thanks for suggesting this, I think this is a useful change, but the
> > > implementation could be improved.
> > > 
> > > > We also move away from using the random minute, and instead rely on
> > > > systemd features to achieve the same goal (see patch 2). This allows us
> > > > to go back to using unit templating for the timers. This is also a
> > > > prerequisite to have static unit files.
> > > > 
> > > > Note that even if we really need more specific OnCalendar= settings for
> > > > each timer, we should still do it that way, but instead distribute
> > > > override alongside the template, for instance for weekly:
> > > > 
> > > > /usr/lib/systemd-user/git-maintenance@daily.timer.d/override.conf:
> > > > [Timer]
> > > > OnCalendar=<daily specific calendar spec>
> > > 
> > > We should definitely do that. Using systemd's random delay does not prevent
> > > the different maintenance jobs from running concurrently as one job may be
> > > started before a previous job has finished. It is important to only have one
> > > job running at a time because the first thing "git maintenance run" does is
> > > to try and acquire a lock file so if the hourly job is running when the
> > > daily jobs tries to start the daily job will not be run.
> > 
> > Thinking about that, it occurs to me that the current scheme does not
> > prevent concurrent execution either: the timers all use Persistent=true,
> > which means they can fire concurrently on machine boot, if two or more
> > would have been triggered during the time the machine was powered off
> > (or just the user logged out, since it's a user unit).
> 
> Interesting, I wonder if the other schedulers suffer from the same problem.

From what I can find (didn't dig much):
- cron does not have the problem, because it will just miss the timers
  if the machine was powered off. Not really better ^
  - anacron though is another implementation of cron which apparently
    support that semantic and is the default on ubuntu [1]
    I can't find if there is something to avoid the same problem that
    Persitent=true imply
- same goes for launchctl (Effect of Sleeping and Powering Off at the
  bottom of the page [2])
- for schtasks it's apparently possible to have a similar mechanism than
  Persistent [3]. There is a policy apparently to handle multiples
  instances [4] but I'm not completely sure whether or not theses
  instances can have different parameters.
  It's currently defined that way for the schtasks scheduler:
  "<MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>\n". I
  don't think it would prevent parallel execution between the different
  schedule though, it seems to me they are different tasks.

[1]: https://serverfault.com/a/52338
[2]: https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/ScheduledJobs.html
[3]: https://learn.microsoft.com/en-us/troubleshoot/windows-server/system-management-components/scheduled-task-not-run-upon-reboot-machine-off
[4]: https://learn.microsoft.com/en-us/windows/win32/taskschd/tasksettings-multipleinstances

> 
> > So maybe there should be a more robust mechanism to avoid concurrent
> > execution ? I assume from what you say above the lock is acquired in a
> > non-blocking way. Could going to a blocking one be a solution ?
> 
> It is possible to wait on a lock file but I'd be worried about building up
> an endless queue of processes if the process holding the lock file crashed
> leaving it in place without anyway to automatically remove it.
> 

At least with systemd we have some mechanisms to deal with that.
- systemd timers don't touch an already running unit, so that won't
  trigger a new hourly or daily if the previous one is still running.
- for the automatically removing it, we could:
  - use XDG_RUNTIME_DIR ("%t" in systemd units) which is removed on
    logout
  - optionally add a tmpfiles fragments to delete locks which are really
    too old (tmpfiles won't delete files on which a lock is taken)
  - I thought about using a common RuntimeDirectory (see systemd.exec),
    but this is not possible due to [5]


[5]: https://github.com/systemd/systemd/issues/5394

> I don't think we need to solve that problem as part of this patch series but
> we should take care not to make it worse. Long term we may be better
> scheduling a single job and have "git maintenance run" decide which jobs to
> run based on the last time it run, rather than trying to schedule different
> jobs with the os scheduler.
> 
> > > As the daily job is
> > > a superset of the hourly job and the weekly job is a superset of the daily
> > > job so it does not make sense to run more than one job per hour.
> > 
> > Is that set in stone, or could they perform disjoint set of tasks
> > instead ?
> 
> All of the schedulers are set up to run a single job each hour, I don't see
> why we'd start running disjoint sets of tasks in the different jobs.

I was wondering if running distinct tasks would allow overlapping
execution, or if the different tasks are not safe to run concurrently
anyway. I'm not familiar enough with them and the git internals to tell.

Another option if the tasks set was distinct for each service instance
would be to use dependencies and ordering directives like this:
weekly.service
```
[Unit]
Requires=daily.service
After=daily.service

[Service]
ExecStart=<run only weekly stuff>
```

daily.service
```
[Unit]
Requires=hourly.service
After=hourly.service

[Service]
ExecStart=<run only daily stuff>
```

hourly.service
```
[Service]
ExecStart=<run only hourly stuff>
```

That would avoid concurrent execution I think.

-- 
Max Gautier
