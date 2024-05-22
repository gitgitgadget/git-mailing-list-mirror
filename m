Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219A141987
	for <git@vger.kernel.org>; Wed, 22 May 2024 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716403969; cv=none; b=EV6CDxhaAntnK3s+WZwV+Zv298zUxA7hXjZtdCERneyHl7pkO3i3Z2rSpcjUKOqne4aZ5MbXO311q56GoZ20Y+gmcv0yc621mGYX6bjidsv0Sh4P1sIB5wDYS+uZj4ujRvN1bh99WqRDHRUwdn69XzF9lVaQKp9S90cInKAlHa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716403969; c=relaxed/simple;
	bh=7lmOPUEOtX1amflnrtQbHI0es93FzlluOTfgbSsv4bs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ey34J/qDD8cwO0xjiBDH742e+cJQHwW4/+nr6l1RBlfH6U5nU/HeQxUdQlZi0NcgHcZXRxwhYOBSTg8hySjG2fEHUL8Q0YLgldANrbi07ULGguZNHeYNA3k7HVA7LknoRxBGzO3LSGpq2iq5JV7Jjqk3m4u2DX7VaDGgxCc1xWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=IjJc09lY; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="IjJc09lY"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1716403963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmZY4obVf5BL3kqJ0OZ9NDAXTvhQN8L1Uv14T+Ltoi0=;
	b=IjJc09lYpVz7vLdz7/y02Do8Y/yuKQPZJ85g4n4dAGnBasXETCs/PmYf7rWsOPM7y4dDpI
	MhiHq9YywPZ6k3k3ykb6LdT1mwBePoNoZy0Eg3zi1Q6LGS3UFrhxzvquABQWWj4PpIP0OU
	C1WM2xP3lgHpPmiaoeCVHkeI/3OMLiUM4H0qP/mg4sIN+QZY0KFXWLZvhA7tluftNLIBsY
	Kex/Zw4LvxX0MVjv5V9/fudXqYaOYamlIDGdhg8sIZxgP+lnJ6PGJBUxD6qZSILQxAxTp+
	X+hcTIw5FwyheVYM+MojJeD2+bUz6TOjM4qxbFbw0uLr6W5Viafmg+80FZE4XA==
Date: Wed, 22 May 2024 20:52:43 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Rub=C3=A9n_Justo?=
 <rjusto@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: note that interactive.singleKey is disabled by
 default
In-Reply-To: <xmqq34q966qq.fsf@gitster.g>
References: <3141fe9f7328a97bf3818748421f6ae929120626.1716363167.git.dsimic@manjaro.org>
 <xmqq34q966qq.fsf@gitster.g>
Message-ID: <54c318f42ce63f0575ea48f3dc1e8361@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-05-22 20:28, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> diff --git a/Documentation/config/interactive.txt 
>> b/Documentation/config/interactive.txt
>> index 5cc26555f19a..067496d77cea 100644
>> --- a/Documentation/config/interactive.txt
>> +++ b/Documentation/config/interactive.txt
>> @@ -5,6 +5,7 @@ interactive.singleKey::
>>  	linkgit:git-add[1], linkgit:git-checkout[1],
>>  	linkgit:git-restore[1], linkgit:git-commit[1],
>>  	linkgit:git-reset[1], and linkgit:git-stash[1].
>> +	This is disabled by default.
> 
> Hmph, an optional configuration is optional because the lack of it
> means the feature behind it does not trigger.
> 
> While it makes tons of sense to mention what the default is when
> there are more than true or false choices (e.g. "defaults to never,
> among possible choices never/local/remote/always"), or if it
> defaults to true and the knob is to opt out of it, it feels like it
> adds unnecesary noise to say "defaults to off" for a configuration
> that is clearly a Boolean.
> 
> So I dunno.

Let's have a look at a rather suitable (and to me, a bit inspiring)
excerpt from the git-config(1) man page:

   interactive.singleKey
      In interactive commands, allow the user to provide one-letter
      input with a single key (i.e., without hitting enter).
      Currently this is used by the --patch mode of git-add(1),
      git-checkout(1), git-restore(1), git-commit(1), git-reset(1),
      and git-stash(1). Note that this setting is silently ignored
      if portable keystroke input is not available; requires the
      Perl module Term::ReadKey.

   [...]

   log.abbrevCommit
      If true, makes git-log(1), git-show(1), and git-whatchanged(1)
      assume --abbrev-commit. You may override this option with
      --no-abbrev-commit.

With this in mind, I think that rewording the opening sentence for
the description of interactive.singleKey like this would make sense:

   interactive.singleKey
      If true, allow the user to provide one-letter input with a
      single key (i.e., without hitting Enter key) in interactive
      commands.
      [...]

Thoughts?  It would be more consistent and a bit more clear, without
putting too much stress on the actual default value.
