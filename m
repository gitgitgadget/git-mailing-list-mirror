Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B438B22630
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707062338; cv=none; b=g5IpROeVf1sq1LjGQM/EMqgcCW7sGGma5GeJwaLJ3YO8kR8s3e+6PYJfH9njAOp2QaUSL4bO3mIYd6ZhSB14JUxA2AP7hMTGBDRpVNnziHFiBK8XpMkItxZCr4AJ92UF3AnHlFdw4qeJp2VAayszjKyGW3fBc+coxTJCLyrHSsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707062338; c=relaxed/simple;
	bh=baK+r0anKJnCIVUT+q+eYlEAhuM5tS4HhiB+72k2MIo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AKCknILKfdQwtn8gFcqK/Hs+kVhGOK4zg9xs17l34IZVfUnd0JGp4hLjf6KxtEVTgKpguNIUAD02ipnDbldkSR/XvNp/BG0OZflCzK0I3qXXrKVNPbfNNH05dwVovHd9NornQnKNRai3KVzyPL8VZ+6tJiHXXArOcT0mZ1D/fsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=UbUSOl/H; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="UbUSOl/H"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1707062333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2KvCZvHLLqPBV9zjV3lABgSzwkP5my+I+RcgG8/DLY=;
	b=UbUSOl/HlUD1tvx4GXYgRwDp62KbZGGiID94QrLzN+mcnzdA/arkYkvq592otLwxCvRPOR
	/FgMkTUwhPLv/Tus58Ithb3ZT5r2e2v9KyX+ob/kezq0Wh2F8nDG8hKX5vtEB59tfJvp1l
	pQ2d/vx7jQRy2ofT5h4UJxMHMdX8hjDirpqJKr71Ey66BdPscHC1+ZAiVAqE+G+L3onpY6
	SR/UCvsDfWI3BJSYmidQ98BxoQMdQRRenx6VM8vUHsuHrF4KEYL1zLtpJ3YjudbnaqMkcX
	bmgvEs9wmxph6EvHOclg1+88VpW3UUQwPEmbEhRbjVIdwaTGNyvnXI3abmu9xQ==
Date: Sun, 04 Feb 2024 16:58:49 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>, "brian m.
 carlson" <sandals@crustytoothpaste.net>, Hans Meiser <brille1@hotmail.com>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>, git@vger.kernel.org
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
In-Reply-To: <20240204155107.GA9696@kitsune.suse.cz>
References: <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <ZbxI4wNTBZ48YcTi@tapette.crustytoothpaste.net> <Zbx5Xzb3kyHvkp7C@tanuki>
 <0e3e6102-40eb-4462-b541-0c7452e79f42@gmail.com>
 <20240202115004.GV9696@kitsune.suse.cz> <Zb+pQk9R3AOouFxF@ugly>
 <6dc25a1ab1531b508e844cee1c970438@manjaro.org>
 <20240204155107.GA9696@kitsune.suse.cz>
Message-ID: <9741936d0b69369ea75a9d5d402b68de@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-04 16:51, Michal Suchánek wrote:
> On Sun, Feb 04, 2024 at 04:28:58PM +0100, Dragan Simic wrote:
>> On 2024-02-04 16:12, Oswald Buddenhagen wrote:
>> > On Fri, Feb 02, 2024 at 12:50:04PM +0100, Michal Suchánek wrote:
>> > > Given the open nature of lore it should be feasible to provide
>> > > additional interfaces on top of it that cater to people used to PRs
>> > > on popular forge web UIs without hijacking the whole project and the
>> > > existing tools and interfaces. For some reason people are set on
>> > > replacing it as a whole, and removing the interfaces they personally
>> > > don't use,
>> >
>> > > calling them obosolete.
>> > >
>> > because they positively *are*.
>> >
>> > when i started, patch-based code reviews were the norm, and i'm still
>> > using them for my small project with almost no external contributions.
>> >
>> >
>> > but after working with gerrit code review for over a decade, i find it
>> > mind-boggling that people are still voluntarily subjecting themselves
>> > to mail-based reviews for serious high-volume work.
>> >
>> > it doesn't matter just how super-proficient you got with your old
>> > tools.  there is just no way you'll get anywhere near as efficient as
>> > you would with the new ones, if you just were interested enough to
>> > learn them.  migrating the workflows that are worth keeping isn't such
>> > a bit deal.
>> 
>> Please, keep in mind that not everyone lives in a web browser and
>> loves to click around.  Some people simply prefer to use the CLI
>> utilities and to press the keys on their keyboards, and are very
>> efficient while doing that.
> 
> The forge vendors found out, and started to provide CLI tools. That's
> not really a general argument against forge software. Just as people
> living on web is not general argument against e-mail - it's been 
> brought
> to the web a long time ago.

Please, don't get me wrong, I'm not against the GUI and web-based
utilities in the sense of telling other people they're bad or shouldn't
be used.  I love the variety and the freedom of choice, so everyone
can freely choose the most suitable option for them.

Though, I'd also expect that everyone respect different choices made
by other people.  That's how we keep the variety available.
