Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC1A225AC
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 15:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707060555; cv=none; b=lrF0U8ivBNKXLh5qWe9KRc3op+C/bdB1HmpiNj0G1JP6l6Qh7hhMbOWrMAVr8DLahQU3gdU688VkmW5QkHod5yvsnYhnbiKHcvWjVNAPkGMKMRYGx15VJ9REqKxUFRX4imNzLn35szWacUUAPEucgoQAgo4N+7SkgXBI24hocx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707060555; c=relaxed/simple;
	bh=PrG4yjTONL6A1xbvQlPPFLY0y/sMjonYWJpJ5WlLZwI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ribIDfHv0Iy+y8ry2ixCYZ6R60T5kYkjT4lTMkoM8HX7ZQ5qPWkDGLoSekqvL4yUOyNEJ1c/tFSVYnF2uG2+X+wsQQA2eRq7h47FV/PwHmeB8QyhglBPuYLwrXgqdoNe0YbxCy04lb3OQMR0Qsog+3a7O7Vble3k0rpC5j/HXZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=iHZZRizy; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="iHZZRizy"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1707060543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxN9iVeNYyr8VeLpvfWCziCv5+trCGjLwnywlmK6v44=;
	b=iHZZRizyqnG0Jq4b6GmM5FN8wAcc2CSvhgyW79oHSQtY/OLmwb0miePo2GyGil7gBRn737
	WLrbrtyyzWeyKZDj9Te583YLbng8TtcZBHQYuhS3timDLhyWknhhZDJRZNwzIE5autCVst
	yqdRFf/Tz6uOYTVF38E3nQ4Rj7TqaOXrCvNmP+yJ8NBCAlvpASv4cFBOTcMEeGYEe3pNuO
	KjpsXvVxwzxX/8riO8PSK2+/OdUPWZrBAkDBdi6Vf48XbVAWgjGHOFMp+2yTAJmI/Y+w/J
	XDeaUhcOneOOA2zqv+LinDiGBILYwFjvXis1kILhewcy6GkB6UHx+/hz/zu1qw==
Date: Sun, 04 Feb 2024 16:28:58 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>, "brian m.
 carlson" <sandals@crustytoothpaste.net>, Hans Meiser <brille1@hotmail.com>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>, git@vger.kernel.org
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
In-Reply-To: <Zb+pQk9R3AOouFxF@ugly>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <ZbxI4wNTBZ48YcTi@tapette.crustytoothpaste.net> <Zbx5Xzb3kyHvkp7C@tanuki>
 <0e3e6102-40eb-4462-b541-0c7452e79f42@gmail.com>
 <20240202115004.GV9696@kitsune.suse.cz> <Zb+pQk9R3AOouFxF@ugly>
Message-ID: <6dc25a1ab1531b508e844cee1c970438@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-04 16:12, Oswald Buddenhagen wrote:
> On Fri, Feb 02, 2024 at 12:50:04PM +0100, Michal Suchánek wrote:
>> Given the open nature of lore it should be feasible to provide
>> additional interfaces on top of it that cater to people used to PRs
>> on popular forge web UIs without hijacking the whole project and the
>> existing tools and interfaces. For some reason people are set on
>> replacing it as a whole, and removing the interfaces they personally
>> don't use,
> 
>> calling them obosolete.
>> 
> because they positively *are*.
> 
> when i started, patch-based code reviews were the norm, and i'm still
> using them for my small project with almost no external contributions.
> 
> 
> but after working with gerrit code review for over a decade, i find it
> mind-boggling that people are still voluntarily subjecting themselves
> to mail-based reviews for serious high-volume work.
> 
> it doesn't matter just how super-proficient you got with your old
> tools.  there is just no way you'll get anywhere near as efficient as
> you would with the new ones, if you just were interested enough to
> learn them.  migrating the workflows that are worth keeping isn't such
> a bit deal.

Please, keep in mind that not everyone lives in a web browser and
loves to click around.  Some people simply prefer to use the CLI
utilities and to press the keys on their keyboards, and are very
efficient while doing that.

> i'll note that i don't consider github-like forges to be adequate
> tools for serious work, as they seem to intentionally discourage
> producing polished commits.
> the gerrit project is unfortunately not interested in building a
> proper forge, but luckily there is a bridge to github (hosted version
> available at gerrithub.io).
