Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446163BB13B
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 05:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783489457; cv=none; b=s5eVtNiVQLachHMB8TQiOoHTHN7putZUWWbhiK/5vuYyedM8zMMaT8G6SK51XyXIKPB52kKVwcyu/zLWqTHGQYkM1pEnivI2fTs8MlnaE+sM3+kt6txg4+2dn93nopSeA+G1ZWryvlPhiF93o+LfwGLOeNv8NPh/29Y47ptcTDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783489457; c=relaxed/simple;
	bh=J1OC5B31tVa6phvhi45X+bY9o748GgFChLSH/NeSGw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3tJNBNydOV45d+gcXEGSW2EQo+9OPU6I3/iR09mPgLUazWcCvyjSGgsYQysomBATWoMwFb4a6eXy0gV+DRVhu69rXkzcZK0aHjtMUSLpd8l8vzyAN4Najfrwp/CEuZJAc+eNPoScu113476voCv8H3MhIXFdrHyVGgAhKKRNc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=pwJu7qqk; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="pwJu7qqk"
Date: Wed, 8 Jul 2026 13:43:51 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1783489452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XtFaTeUssgf6gAbL0PvXpikX3jfMCbRoz6Gm3B7nCZc=;
	b=pwJu7qqkw8Bcbq/WbRphpRO2SegwEEva8HapEF+MITHIL+osN/thK+SqqbEU/aXA9W7b3L
	tPDhnaDAfMTmh6lz0Uvyse1R7jIc75DmYxmJlU8wlj9AvMT925Ha1xcOu6RqV+i6Pm9HGw
	YZQq0Dffl2hjPC4gcBUdAJuMG8ga2Z26ifXghRf8O3P4k4nM0LvENPrjo3pXqxVEivq5nZ
	/ATg1kvYarZQ07uRv3jQIfpQatHDwY8gRdmsbrt8/S5U5UgPYbZhKYgaM5UGuCFZhH6Nvm
	+eP5OC/A1KyKEjm4EQr8+w+fdc39UXBQp2OWu+pFaEBmt0WAaYXyt6NrKA2GPg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] SubmittingPatches: abandoning a series
Message-ID: <ak3jl3vu_P8eBXa-@wyuan.org>
References: <CAC2QwmJ8Z7hZHk9SofRsprvAR3B=UXUkeyy7i4uofRi-xEymow@mail.gmail.com>
 <xmqqechew0ap.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqechew0ap.fsf@gitster.g>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 07, 2026 at 09:52:14PM -0700, Junio C Hamano wrote:
> Michael Montalbo <mmontalbo@gmail.com> writes:
> [...]
> > Finally, maybe a rule of thumb as to how old a topic a topic should get
> > before a "staleness" update is provided would be helpful, or maybe that
> > is too contextually dependent / would potentially introduce some
> > unwanted scheduling contract?
> >
> > Overall, I think the explicit guidance is helpful.
> 
> I've been working on streamlining my workflow to manage the "What's
> cooking" report, and writing down guidelines with concrete numbers.
> 
>  * When the discussion seems to reach rough consensus that the
>    latest round looks good for 'next', the topic is immediately
>    marked as "Will merge to 'next'?" in my draft copy (note: I do
>    not want to spam the list with "What's cooking" too often, but it
>    is the document I work from, and it is updated multiple times a
>    day).
> 
>  * After no negative opinions are seen on a topic in "Will merge to
>    'next'?" state for about 36 hours, the topic is marked as "Will
>    merge to 'next'".  I will merge such topics during the next
>    integration cycle (note: I can only have up to two integration
>    cycles per day due to time constraints).
> 
>  * Imagine that a topic was last updated more than 4 weeks ago.  If
>    there are review comments on the topic that are left unanswered
>    by the author for more than a week, and if nothing happens in the
>    discussion thread other than inquiry on the current status, the
>    topic is marked as "stalled".  I will try to notice and ping a
>    stalled topic once or twice, but after that I may discard such a
>    topic (which by the way I really hate having to decide to do so).
> 
>  * After a topic is merged to 'next', if nothing negative that needs
>    fixing is discovered for 7 calendar days, the topic is merged to
>    'master'.  I may shorten this depending on how complex the topic
>    is.
> 
> There may be more, but these are what I can think of offhand.

Integrating the above parts into the document seems like a good idea.

btw, do we need to synchronize MyFirstContribution simultaneously?

Quoting Patrick's words [1]:

Overall it's a bit on the annoying side that we have to always make sure
to update both SubmittingPatches and MyFirstContribution in tandem.
Makes me wonder whether they are mostly redundant and whether it would
make sense to eventually merge them.

Thanks,
Weijie

[1] https://lore.kernel.org/git/ai_7Wh7hrD8PZozg@pks.im/
