Received: from web23.osl1.nordkapp.net (web23.osl1.nordkapp.net [185.114.57.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC7E145347
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.114.57.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711905043; cv=none; b=O9/rwqh3DKxXbb8rimodeSBE6QyfLnMwdio0SRrZ5XK2hM3AB6J0FcXas5Q2FyJITHXpeLSjP81xqNVyoGI95NXl5euEzlhp3lEHXoEWPXYrHfFwA9up0tFdGGecIUEKOkejI+d7QhqvM/ekQWb43Ac2xQyd4SdZX3BuGD20Nrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711905043; c=relaxed/simple;
	bh=+ADAIheL/N3HtkIbFaWhhLJpx1HgyEJ9RK1CVz2oPeE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kgojfDiwJlUzJWIjk5XOBJFxoFMtNwkRWCcWjg2feVo+qYtIaGZalfvTQG7OSog558nJi+nXZhPFiYzDL0ALqbHZ+BrB9kBRcqVvzdo+eVp1M2/cX1qzZxicgbX33T8ZKsCXEBRqTDpwYc9B/9eOrO0gghRgCnwmypwzTpd1IPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se; spf=pass smtp.mailfrom=softwolves.pp.se; dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b=tJ11lWr/; arc=none smtp.client-ip=185.114.57.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b="tJ11lWr/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=softwolves.pp.se; s=x; h=Content-Type:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=btzWsjEItfK1MBEkJIAGvkTnFnw+yhzb0NUT5tK22AA=; b=tJ11lWr/H4PRBzF4rqfOcuquxQ
	FimZWQwI45EsMM8EtEuQSVEK8GRx+cMMPfYOp0xhbGyUOeXrTnRPfE4wWpPxv6HL7xtLmVbk8m2G5
	N5Txw6KRkvA8EETlPJezmefJ8z0teTbkYzzbY1w1fyrFV36rEy4pBgGlUpSYj/v/deRGMc5FfR9NR
	wKZh9gddEfPwHgUBddT62VZ+y6Npdicwb4s/bp2tMJO8RNwjcQEVOn/EnTbwj35c3DURzwPhdGXvK
	DMCeR9r2yOMdwaGy0f1farZK/L7bW/uqB6YnJmy9N55nN25hG17nhDXUx8MIjpNivl+asq20C7bqd
	o6bnIpvA==;
Received: from mail01.osl1.nordkapp.net ([185.114.57.50]:48506 helo=mail.nordhost.no)
	by web23.osl1.nordkapp.net with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <peter@softwolves.pp.se>)
	id 1rqyhU-00000007vv8-2NLE;
	Sun, 31 Mar 2024 19:10:32 +0200
Date: Sun, 31 Mar 2024 18:10:32 +0100 (CET)
From: Peter Krefting <peter@softwolves.pp.se>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org, 
    "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
Subject: Re: [PATCH v2] bisect: Honor log.date
In-Reply-To: <xmqqh6gni1ur.fsf@gitster.g>
Message-ID: <5ea0837f-2668-028d-4094-c9400e92fceb@softwolves.pp.se>
References: <3ec4ec15-8889-913a-1184-72e55a1e0432@softwolves.pp.se> <xmqqh6gni1ur.fsf@gitster.g>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Relay-Host: 185.114.57.50
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus

Junio C Hamano:

> I suspect that log.date is a small tip of an iceberg of the benefit
> we'll get from this switch.

Yeah. I was planning on elaborating a bit on that, but forgot 
completely by the time I came around to look at it. I will update the 
message with your suggestions for the next version.

> Some differences in the proposed output and the current output I see
> are:
>
> - the output now goes to the pager
>
> - it now honors log.mailmap (which may default to true, so you
>   could disable it with log.mailmap=false).
>
> - it shows the ref decoration by default (when the output goes to
>   terminal).
>
> - the commit object names for the merge parents are abbreviated.
>
> - it no longer shows the change summary (creation, deletion,
>   rename, copy).
>
> - it no longer shows the diffstat when the final commit turns out
>   to be a merge commit.
>
> There may be other differences.
>
> I personally welcome the first four changes above, which I suspect
> you didn't intend to make (I suspect that you weren't even aware of
> making these changes).

I hadn't really noticed that the previous implementation *didn't* 
display this. For the most part, the final output of 'bisect' looks 
like what I expect 'show' to display, to me it was mostly missing the 
other things.

> If there were no existing users of "git bisect" other than me, I
> would even suggest dropping "--no-abbrev-commit" from the set of
> hardcoded "git show" options, so that the commit object name itself,
> just like the commit object names for the merge parents, gets
> abbreviated.

The full commit hash is shown in the line above anyway, so that entire 
line is redundant. But since there is no standard format available 
that omits the commit hash I thought I'd leave it at the full hash to 
be the most like the previous behaviour as possible.

> The final two changes, lack of diffstat for merges, may or may not
> be considered a regression, depending on the user you ask.  I was
> just surprised by them but personally was not too unhappy with the
> behaviour change, but reactions from other couple of thousands of
> Git users (we have at least that many users these days, no?) may be
> different from mine, ranging from "Meh" to "you broke my workflow".

Those two were not intentional. I'll have to do a few test runs to 
compare the outputs and try to the change as non-intrusive as 
possible. Thanks.

> If you add --stat, don't you want to add --summary as well?  Try to
> bisect down to a commit that adds or removes files to see the output
> difference to decide.

There are a lot of parameters to show that I have haven't used in my 
14+ years of using Git, --summary is one of them. That's why I didn't 
add it.

-- 
\\// Peter - http://www.softwolves.pp.se/
