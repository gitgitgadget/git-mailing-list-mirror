Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605C960BA2
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873026; cv=none; b=plECZpm+1qF22tFdXgMZHKxlaXNiOuKoxCRtykpyO1L38oo6OY7laC4tiiss7OeEFNvBkv5jlIR2TyjYRUnjtMixiA6qV93nwY2D9V6TR0lKz+fZnqdlCdrYWhqP+u223uoRd5piO2Wb5JjakokxDzpBsh+XfnPF147Z1/+7Ehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873026; c=relaxed/simple;
	bh=Hk6/ZXhu22kOUjJ5YyoTLpU6yHn8Jgh2nSu+Wc4TPW0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=s4dXvZTCaqT0G6U4GnlQKJp5zQ938gTGFLwq6hSIhS1qwJSgYtwonT8qxVijiiGxtDDrWGbE5LELgNjRKHiNzvmdM2Yv9iYKqrcNdqqbSn16kaUzGqoVakUzlHY7CMuF209Kjf9QIRI1395qF6+ub2DkdX+OXcVElCSXMSL6b4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=SRIti5Y9; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="SRIti5Y9"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706873022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MpFUf4lzdPCQItN1rL7qFlcQsKwZRIGri63/Ih0kRc=;
	b=SRIti5Y9d7kIFccwDrts+84ysoNt0/9NDjyNbH45OpFxbrCyPRNFUyjQXKAIGJ13EN++Gu
	+/0L6T7BJoYDD8f83vfhM9WutudeIzjvFguVGB+5d40Psp2StYjiVT2/3lH/EkuIGPGJhV
	0BhoZ2R6jx+pnuLiD+faMYJSUxmQ2rMonEZVNmuD9+SfpQQjaaQ6m0/tLzKxjOMKh2B+0U
	rVap37XXA5Bi9xyJ08sc2xPzba6FFwjFMFs3+zg/BtW/ezC0bbXmo++kK2XrB5AQcgAENE
	WJTsxefyZn8ac9mvHFvmhMaW2ukG72C/EUnnXxSrJK1sqfg9RfyHBRvHGd1LtA==
Date: Fri, 02 Feb 2024 12:23:41 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: git@vger.kernel.org
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Hans Meiser
 <brille1@hotmail.com>, Patrick Steinhardt <ps@pks.im>, "brian m. carlson"
 <sandals@crustytoothpaste.net>, rsbecker@nexbridge.com, Nico Williams
 <nico@cryptonector.com>, Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Antonin Delpeuch <antonin@delpeuch.eu>, Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Muting and unmuting threads (Was: Migrate away from vger to GitHub or
 (on-premise) GitLab?)
In-Reply-To: <c9a0cb1fe64f8e7d21c21458e5e76af9@manjaro.org>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <691395bc13ea6c3013adcb98cfcbd102@manjaro.org>
 <DB9P195MB2130EB8EB69A8140A31BB432E2422@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c9a0cb1fe64f8e7d21c21458e5e76af9@manjaro.org>
Message-ID: <93be64af474b228e914a4c39443b5a9c@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello everyone,

I went ahead and contacted the mlmmj project, which runs the vger 
mailing
lists, [1] with an idea to implement a new command/feature that allows
threads to be muted or unmuted.  For example, that would allow receiving
only the replies to one's patch that was sent to a list.

The initial reactions are good, but various concerns have been raised
regarding the actual implementation.  I'll think about the way to 
implement
it in an efficient and simple way.  I think this would make using 
mailing
lists much more friendly to many users.

All suggestions and thoughts are welcome, of course.

[1] https://people.kernel.org/monsieuricon/subspace-mailing-list-server


On 2024-02-02 11:54, Dragan Simic wrote:
> On 2024-02-02 11:18, Hans Meiser wrote:
>>> Please keep in mind that editing the git man pages requires very
>>> intimate knowledge of the related git source code.  Many times even
>>> small changes to the language style can change the meaning and 
>>> diverge
>>> the man pages from the source code, making the man pages useless.
>> 
>> Sure. Eventually, I'd rather propose to have parts of the man pages be
>> generated from code comments (XmlDoc, JsDoc or similar), particularly
>> syntax and parameter list. That would keep documentation from
>> deviating from code right from the beginning. And it would keep
>> documentation writers from manually updating obvious parts.
> 
> That might work out in some places, but I'm not really sure about the
> overall effectiveness.  The git man pages don't document function 
> calls.
> 
>>> A git server?  I was under impression that you proposed running an
>>> own instance of GitLab or something similar.
>> 
>> Basically, GitLab, GitHub, Azure DevOps are all just Git servers, plus
>> collaboration and automation functionality. I suggested using GitWeb
>> only in case you wanted to write  (and keep control over)
>> collaboration and automation functionality yourself. Otherwise you may
>> use one of the existing ones that have already been written (i.e.,
>> GitLab, GitHub, Azure DevOps).
> 
> The plus brings additional issues.  It's been already noted that 
> favoring
> any of those solutions actually wouldn't be in the interest of git 
> itself
> as a project, because it wants to remain neutral.
> 
> IMHO, these days too much is expected to be handled by "something 
> else",
> instead of the developers handling that.  It's like offloading the 
> basically
> unavoidable complexity to some utility, and expecting that the 
> complexity
> will somehow go away.
> 
> In other words, a developer has to keep quite a lot in their short-term
> memory, and a lot in their long-term memory, to be able to accomplish 
> some
> task, and hardly any utility is going to make that significantly 
> easier.
> The same principle, in general, applies to a group of developers 
> working
> on the same task.
