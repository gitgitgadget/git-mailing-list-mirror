Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D786F517
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403640; cv=none; b=sr+QZVb5TQsJQBv9wGQg5vMq3LMK3i6WCY+viznpGDf3fDBjtdXGxGxD+n/P/0DRYGtULHwCcCNMqr4Hw9BHiA4CsVd+oz3JC/eAZvVOCwscKcGOAhO2W2YQhwlTfwHKbLIkc+oqSdYiVzAdoDwl3Ku01J6hLqJSXmzWA6GzEfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403640; c=relaxed/simple;
	bh=OzZV31oe50bLq52OwB3DU4+dQtxk8we4oNzyUdq0hTo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fzDBnCn276yxapjzFw2lQPq9fx15T6OOi6O0Z3O5guYRifpqX6FlWGVhINX83FK4/VqEDOkzj9e0tzCA3nBNiN1E6dR5LaMYrAqkxSdv5aanJY/8nNzmjt07IQvobukn1mSuR/25t2+fpINhQLjrAqfh0R0q5UTc+h79XTnKo+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Y8j2FEwc; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Y8j2FEwc"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711403635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qJcatthCjjw96L//iETONaTTj9xJzqXZMJBUZZ6N1PI=;
	b=Y8j2FEwcsbbfjGJQEiKWmpMPZfjh7DyjOAJGXS7yGFzcCzMVVO2JnZ0rnnxGEU9avmLIkb
	7iihl8KVhFsOTUzc0COzXx26d7nCcYDPH17KoZ/mOh4n4rLGGavFhg+GQBjYvN3dnpUtj2
	EmIAK6wj3+9WommVLUTfXl2O5FtTTK91atL1OoyABD7jiUX62bDChtrGHxSzK+Hj6x3Ei+
	sOCaGHjS9VT4SevvwDAHTtwNm/Qf6JcjvgkSAd3mB4wP7JrpFAJlKiwRPg0rTi5bh45dqB
	3KdA0czq+1kCWXREtmueSgtigXEMHnNkZI85nqlLUoKOKZn3u15jJA4jtNoXEg==
Date: Mon, 25 Mar 2024 22:53:55 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Junio C Hamano <gitster@pobox.com>, Chris Torek <chris.torek@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>, Karthik Nayak
 <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] Support diff.wordDiff config
In-Reply-To: <6e035003-0c08-4e44-811c-27d2cebe9fa8@schinagl.nl>
References: <a7be415d-5005-4fa7-9b2e-1974b7439a81@schinagl.nl>
 <20240302095751.123138-1-karthik.188@gmail.com> <xmqqedcszhty.fsf@gitster.g>
 <CAOLa=ZR6tN8eQhByaUobj3kS9wwYegsOQNT8cjZYA-YATJJt7w@mail.gmail.com>
 <34bb249d-4a4d-4cc7-b737-bb18398341d0@app.fastmail.com>
 <CAPx1GveaNR9ooWqE1VkAuFg5NO4Lwzx7bj-W1mWeHRg-rcg6+w@mail.gmail.com>
 <xmqqle6zw6om.fsf@gitster.g>
 <6e035003-0c08-4e44-811c-27d2cebe9fa8@schinagl.nl>
Message-ID: <91f0848b917a15873a7b75b380619126@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-03-22 23:08, Olliver Schinagl wrote:
> On 03-03-2024 18:45, Junio C Hamano wrote:
>> Chris Torek <chris.torek@gmail.com> writes:
>> 
>>> This tension is relieved somewhat when there *are* separate
>>> plumbing commands, such as `git diff-index` and `git diff-tree`
>>> and so on, or `git rev-list` vs `git log`. Unfortunately there
>>> are some commands, including `git log` itself, that have options
>>> that are missing from the roughly-equivalent plumbing command,
>>> and there are commands (such as `git stash` and `git status`)
>>> that either do not have, or at one time lacked, plumbing command
>>> equivalents or options.
>> 
>> Yup.  It is my pet peeve that more and more contributors got lazy
>> and tweaked only Porcelain commands, without bothering to improve
>> plumbing commands to match, while adding more features during the
>> last decade.  Unfortunately there is no easy remedy after such sins
>> have been committed.  Once people start using `git log` in their
>> scripts, it is way too late to tell them to update their scripts to
>> use `git log --porcelain`.  The fact that you need to tell them is
>> an admission that you already broke their scripts.
>> 
> To avoid this request from dieing quietly, I will ask (complain)
> again. Who's the client for. How important is the human UX?
> 
> Even introducing a new cli, 'git-cli-for-humans' it will be abused
> again for sure. So what's a good way forward? Personally, as I
> mentioned before, it's in the docs to not script around non-plumbing
> commands, which gives an opening to the admission. And why is
> admitting things a bad thing, when it improves things for the human?
> Even if it hurts.
> 
> One could argue 'git3 will break things! Human and machine control is
> split. Use --porcelain (or plumbing commands) in your scripts or
> expect breakage from time to time. You have been warned!'
> 
> We do in the end want progress, do we not? :)

Maybe, but just maybe, a possible solution for introducing such new
configuration options could be introduce a new category of configuration
options, which could be set in the user's git configuration only?

That way, a repository enabling some troublesome configuration option
wouldn't cause the user's scripts to break.
