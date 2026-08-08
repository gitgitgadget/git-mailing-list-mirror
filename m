Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6472F39C7
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786210323; cv=none; b=FG3mknV8i1hQde1YdBTKH9eSEHFtvsI1SS+tX2O/kG0vBV+0dbVXbnxVhJLYvHYZS8SbqeEHFHr5T+9mmnaBQDYe+88IQg3UnuDfpUqy7wcDBhLpYANSFIOc7NthMt1NZlr6Yu3qqgtnIy6NS2GMJAJ6EMDpdFQqGw/T+iF6rco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786210323; c=relaxed/simple;
	bh=tzIZHd3GlGTqqv64CLWUh8xfR9amcnRicWU/xuDNzo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n93y4gFdjMUHZTBHoVcYtqUq14pMpKqx6IpJ1CZB+jcDJvvh3gJjRx7ONqhEVrCxog5dG2uwIzJeN5syEKYxhZer8g6LKCz8rO9VdV2HBZxGRACkyjMawPjNp93mabuNTMi/L/gxTtb/Bv3ircK7rpHv7oOM5jpkjfZ0sJ+AVpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiaIDMS/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiaIDMS/"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2022323c37so67697666b.0
        for <git@vger.kernel.org>; Sat, 08 Aug 2026 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786210320; x=1786815120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9aNLElRTdCbJJpCk/R7Ba0sXVk03CQAfGG1PwLjxNhw=;
        b=QiaIDMS/dgq2hXsZkg0yErd7P39jyWyyt+Z/5YnLdaf5w7QPrEYpi2zQGugI8RS7cZ
         VFzRQtj8iEZknYLMa2blcwrawb+DiyAckljWcjWU5xrwL8buwcvLkjN7K2PsbTDwZ3n9
         NIq8dd5QYfVDUsFG6ikXU35xdDWkzK33BUrevVP5ST6ifFaq7GOlSe5JQdfUBjTFar99
         G1G9UvI/vS+kaGQXsHf1NBCTyCblcAp6OxeJ/EZn1lQMKV9vSzi5Fkpwhs63JxQ1CFNY
         iqN5z9Cvb0Hpm2czEvS4w8on/5tgHGwFHwkwkkq29EVG8MzbQah/qskcgaxtRz5+BTGv
         QQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786210320; x=1786815120;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9aNLElRTdCbJJpCk/R7Ba0sXVk03CQAfGG1PwLjxNhw=;
        b=U3uLfZA9JTOmm8nNTN6bphcbJNUwnLTT9aPophNgPhUE1BCT1pu/eeLVCaMT2rYmet
         hnY5GiQ1ydHx2axt24rYw+n7i+uMRgAuW9y1SejmYsyDhK6NBe53+V5RYi0UuZvFKG90
         PJjoRG8TBfOyKkbKFOAZBua40nsyDJlZpnsFnr1yYTlq079qsS2cq7YotRStxmmA3XUP
         OKeAC+CG1ll19j8QbBk3rmS4qO97FdMX81+Ye3YG2XtKeODGbt3JQs7MmNNmmrQJfGR9
         qQnSGTpSYz3/NoiueMm3FD8XxqrJyuZjja/0JMZzIuWieRROF9HNDIEpYS14ZbtTUBsx
         K+MQ==
X-Gm-Message-State: AOJu0YwzJXL8o5KfEU7Y20v4SBbY5r/lFR5KuBMqKObF+jTt90jRHRFm
	t9akbN7QUa+b0LiyIxIakxbGyQKDJbtVHBzcY92xJX1nCKrpwdl/o7gWPr2M4w==
X-Gm-Gg: AR+sD10SRwgYcgQp6XwYKMVnLUmG+I7799qyiVQE19ynvJ8kxH/MesP+IxE8TgieJzl
	oORtRUVnzx3hyRi6nV0QjKF1tt008jDPBUDaD3xZpzA3hy/wMlMc6JPyUJaimQCXkjO68P3XEPW
	lPppYHnzgvUwN7N3z6X4kzz36fFRYob8a6x/qDpGWKUYN4+uKAFtWbSf6yTjlwB1yGG4dAB9/pu
	qMZ12GP2mGSXHLJtzsIj6CyDUPRKbvmuBm2yYfKJdtlf2n4fFXGHVRj0MRb4b6Ms1Vn6AX5+dLv
	PIeV6xL5vhZHdkoKPaGSCPYu3BUByAjOaURUb5rjuAsqOKN5/2Xj9eEF0NBZwiicQvWZ8DzvTDT
	tPGE3WtICGmg6Z7sVuFfjBdzMTIWlyDaL+1dxpPxbXV4auLAeXyVD4wRaY1DtAQNgZ2V9vgmZyK
	ogXRRRc4Y09xE5Czrw+W1jpgGApDitcwxolD+iaEOhLkwf7N6ddJqxDFT7hinqt6OIZ5amnnH8J
	6oDvGpFgBI85GKTBdQC
X-Received: by 2002:a17:907:9623:b0:c12:e178:9e68 with SMTP id a640c23a62f3a-c2073364351mr836713866b.19.1786210319581;
        Sat, 08 Aug 2026 10:31:59 -0700 (PDT)
Received: from localhost (84-236-109-190.pool.digikabel.hu. [84.236.109.190])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1e7d48f8dsm1911539a12.17.2026.08.08.10.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 10:31:58 -0700 (PDT)
Date: Sat, 8 Aug 2026 19:31:57 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, tnyman@openai.com, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] ci: bump ubuntu image version for static-analysis job
Message-ID: <andoDRDn5RvgNHrl@szeder.dev>
References: <20260726083254.GA3528497@coredump.intra.peff.net>
 <20260726083905.GB3529069@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260726083905.GB3529069@coredump.intra.peff.net>

On Sun, Jul 26, 2026 at 04:39:05AM -0400, Jeff King wrote:
> We recently ran into a case[1] where old versions of coccinelle ran very
> slowly, but newer ones are fine. The version we use in GitHub's CI was
> the old slow version, leading to timeouts of the static-analysis job.
> 
> We get the old version because we ask for the ubuntu-22.04 image. That
> has coccinelle 1.1.1, but the "fast" improvement is in coccinelle 1.3.0,
> specifically their 58619b8fe (break up envs for e1 & e2, 2024-08-18).

I've built Docker images of various Coccinelle versions [1] years ago,
and seeing this issue I've updated those images with more recent base
image and Coccinelle versions.

Using these to run 'make coccicheck' on 630cf86933, i.e. 'seen' on or
around 2026-07-14, which contained a024a5818c (branch: add
--delete-merged <branch>, 2026-07-14) with those problematic loop
counter variables I got the following results:

  - 1.1.1: 1437.78user 56.66system 2:10.29elapsed 1146%CPU (0avgtext+0avgdata 223896maxresident)k

  - 1.2.0: ctrl-c after 2.5h.  The bulk of the work was done in about
           10 minutes, but processing 'builtin/branch.c' seemed to
           hang forever.

  - 1.3.1: 6532.81user 106.75system 9:35.04elapsed 1154%CPU (0avgtext+0avgdata 635592maxresident)k

So my Coccinelle 1.1.1 didn't hang, moreover, it was about 4.5 times
faster than 1.3.1.  I got similar runtime differences between 1.1.1
and 1.3.1 when checking e.g. v2.55.0 or current master; in these cases
1.2.0 didn't hang, but took about the same time as 1.3.1.

Am I doing something wrong?   Or is everyone else is doing something
wrong? :)

[1] https://hub.docker.com/r/szeder/coccinelle/tags


On a somewhat related note, for a while now we've been unnecessarily
installing all the dependencies of the "build and test" jobs
(compiler, build systems, apache, p4, jgit, etc.) for the various
static analysis and the 'documentation' CI jobs as well.

I think this is because 707d2f2fe8 (CI: use "$runs_on_pool", not
"$jobname" to select packages & config, 2021-11-23) started installing
all those dependencies for jobs using 'ubuntu-latest', including the
'documentation' job as well, though this side-effect was not mentioned
in the commit message.  The 'StaticAnalysis' and 'sparse' jobs were
not affected at the time, because they were using a specific Ubuntu
version, but then 0178420b9c (github-actions: run gcc-8 on
ubuntu-20.04 image, 2022-11-25) came along and changed the pattern
matching $runs_on_pool from 'ubuntu-latest' to 'ubuntu-*'.


