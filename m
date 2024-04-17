Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA87FBD2
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351174; cv=none; b=Oeqql+RiSpIuEY26eq0k+eSpZpt5JTVs8/fsn9/BZDIrtNhVbpBClReU8kUfNdlKOalNZV8P8yHgXeAT8qDwRJ1Uc+4uQXgPK/236rJ4sUsxjEX7e/yRKk92G1OzjXY5F8EnO9IQvGq16Vi222838ja7md9ui/y0KLCWTyNDCvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351174; c=relaxed/simple;
	bh=QZxSfYt7XWYagqiTL0bAy7kYuzebnsIbuIo1cgoQcU8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Np+DNyvKdWUTPR7PF54Ludid1UdCxpNlHKRfI7IYwRd2euG5am5lB++WRpOlH0PkJwWYqpqiPLkTJGKfbNz5bASLxXjWZLC9VSje/jUyZnq0us4t+Norml1XjMrxDkK/hLhH60HH2aOnLUTC9a/APol6oGouxKzHcnodmV5ZZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=fEQVzlNB; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="fEQVzlNB"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713351168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/t1VSGNRSw7h2ba3I6vUehNcqsAw9UFBMDeMeM+SyX8=;
	b=fEQVzlNBvM1db12SXjFd6IX48zk73emygMlj5LArfKADFNY7GAKoe3gLftH2QSglpWWxZd
	3LUNFyUYbj6qSVIf+LxbMBtO74pn7sw7VzwRrjG2y0DNmPT41zN05DxDJ6sQs9Vg5nFHzB
	V6DCy9gzBTpa3pXEazFezq+BR9ghTwbplXL3T3t9txpBRNu2efE6w3AUK+n0LcZMoFmASH
	G7Uv4JAOHIOJQP5fqAICOYul2cOPXAJCLXJ/OAOny+NF+bbxKAc0CccOrnkNNYTYQrbYga
	JJ6LNvXS+w9OKFL4g7tPW3V6CupftEm/ydMKVdvvmMUs7/hVK16GtnMGl9O9NA==
Date: Wed, 17 Apr 2024 12:52:48 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding "RESEND"
 to patch subjects
In-Reply-To: <154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com>
References: <cover.1713324598.git.dsimic@manjaro.org>
 <1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
 <154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com>
Message-ID: <1f31004bd8445e1e4717817638d5509a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Phillip,

On 2024-04-17 12:02, Phillip Wood wrote:
> On 17/04/2024 04:32, Dragan Simic wrote:
>> Add --resend as the new command-line option for "git format-patch" 
>> that adds
>> "RESEND" as a (sub)suffix to the patch subject prefix, eventually 
>> producing
>> "[PATCH RESEND]" as the default patch subject prefix.
>> 
>> "[PATCH RESEND]" is a patch subject prefix commonly used on mailing 
>> lists
>> for patches resent to a mailing list after they had attracted no 
>> attention
>> for some time, usually for a couple of weeks.  As such, this subject 
>> prefix
>> deserves adding --resend as a new shorthand option to "git 
>> format-patch".
> 
> Playing devil's advocate for a minute, is this really common enough to
> justify a new option when the user can use "--subject-prefix='PATCH
> RESEND'" instead?

Based on my experience, "[PATCH RESEND]" is roughly as commonly
used as "[PATCH RFC]".  In other words, it obviously isn't used
as much as the good, old plain "[PATCH]", but it is used.

We should also take the overall usability into account, if you
agree.  Just like with "--rfc", typing "--resend" is much easier
and quicker than typing "--subject-prefix='PATCH RESEND'", which
is a lot.  Defining an alias can help, of course, but that isn't
always a convenient solution.
