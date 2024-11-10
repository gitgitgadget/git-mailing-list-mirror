Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1FC17C8D
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731255551; cv=none; b=dHEW03xj/Ik/GucQkeil+579AG7IaL5RxptKYdjx+SsdVHZQBKk/KwVqv4Z1ycXg3qEALCiDtzbpAPkleXr1EKtfsOwFtkaBq4yMi374V7UA74x/mZYventOYEvZNpbjEMqlPcqQbXptHxV7XIA7wc12+/Eq22iRM/es9vKmykY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731255551; c=relaxed/simple;
	bh=BkVoOyOrClv1X7lUijxhjdysUHze226aWhEquatIGl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxbZ/EjQw0XOkYzYpESxBb9xPEKeqT3dndyok6n+6npY68iMIXaeA2P37BzEuwGHOsMe0YTpkJI1ac0jlrjOJn94dKENnLHXEStL7OttloJjGxZEwuqlhRvj/iG1Qb8I8i3sdVVYd2/dC3i8yxDvF2jDJsRl05vdk7fCz9oimhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=gQW8rCbd; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="gQW8rCbd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202408171023; t=1731254953;
	bh=k1o/Do2tbH/YKrDnx6J1UiUUMaoqIP93jpQ6cn7/IrQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gQW8rCbd48j7twfRxyjDVGV4NlRJuY0yaYACgMYClTk6IR8fGUM8vb38oo0jT5nES
	 VnN7gfaGbLiAe0ay5XtXqhqIi70DY8q8QGoFfuiSo4w67cKOVmyC6ZRziH9XFN+QKw
	 /wfnRIbCc7fQHlx9Aj+AHvsZnG3JK91n6nc7yr4gUbRI2uwjErvd9VSxPNwOK0QBay
	 QXz0+PjkRu6d8ShMg4zddQiqGT/HFFUhxjs1+txm6lJoPpSyhsSalFKtQbA9l3ZX81
	 r46Db2axsl4EkRGJ6DWdjwMkAmAYk/IyBo7h///cvCIh+yJpp2otFTHAHbtrxaQBYf
	 BsaxNqv5ym+KA==
Received: from [192.168.42.22] (78-99-142-46.pool.kielnet.net [46.142.99.78])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 2D6A53C19D2;
	Sun, 10 Nov 2024 17:09:13 +0100 (CET)
Message-ID: <d9832c11-7c2b-43a8-a7d7-a1de137a5b13@haller-berlin.de>
Date: Sun, 10 Nov 2024 17:09:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Feature Request: Interactively pick fixup revision
Content-Language: de-DE, en-US
To: Martin Imre <martinimre25@gmail.com>
Cc: git@vger.kernel.org
References: <CABg7He2asYQbdRvSvfh1YZ2FRPchVfvta8yBv4PFdVNnhzX6Ow@mail.gmail.com>
 <D5HQH12Y4SWF.2W70SKEDB7HBF@cepl.eu>
 <debabf92-7d23-4d17-bb0e-36691c94430a@app.fastmail.com>
 <D5HWL26B3HOT.1ZVXUC37BCGL@cepl.eu>
 <CABg7He0upi8kmagGO13UMwSWOLeHoryZQU5CGsfbhgqedBKw=Q@mail.gmail.com>
From: Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <CABg7He0upi8kmagGO13UMwSWOLeHoryZQU5CGsfbhgqedBKw=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

On 10.11.24 08:55, Martin Imre wrote:
> Thanks for pointing me towards https://github.com/keis/git-fixup/ and
> git-absorb (https://github.com/tummychow/git-absorb).
> I'll try them out and see if I like the ergonomics of them.
> 
> Just as a general question: With 2 (or even more) different
> implementations that solve the same problem, wouldn't this be a good
> addition for a future version of git?

I'll throw a third one into the mix: lazygit. It's a TUI client that has
similar functionality built in. (See [1])

As for why this isn't built in: there are a lot of subtleties to how
exactly it works, and people might not agree on these. For example,
git-absorb seems to have certain design goals that I don't agree with; I
have written a longish document about that if you're interested. [2]


[1] <https://github.com/jesseduffield/lazygit/blob/master/
     docs/Fixup_Commits.md#finding-the-commit-to-create-a-fixup-for>

[2] <https://github.com/jesseduffield/lazygit/blob/master/docs/
     dev/Find_Base_Commit_For_Fixup_Design.md>

