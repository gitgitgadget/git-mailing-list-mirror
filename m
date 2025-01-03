Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84F0185935
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735935205; cv=none; b=hPNQp47LjK7TTTT87jkRD/vTo5xQg0qcdN039qP8rXGvAMBrCwmuZbNlwSMaYdTKqZFqh66I679jxfKQxCdbH4PeguyFhIYEe291SFd1SYfG+5LcCEEYCBhzS3D2oBFkweQhRQkYhqfkObd0HIC1tXHZ0AuRV1i5U1Ggm9d4y+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735935205; c=relaxed/simple;
	bh=LQODUD+d+ub+YYeEDk41g8vsn+TjCQFBGhJtgY/mi08=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aLeSNCLSelA827Gk1RdtFgPIvpPBZ7VgL3mD+n9aId1mJ+zZRLk3XGkkEqRWqaPEm+BhIg1ShyZRGQRxKXZuEhdbYdMWDx0Il+mdcPak49KwZolenBG6SMXPkovSeJxSuaU9RYKRgPZRVz6qKwuAS6+zypuGqcyQRWnKsdu6zGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=Xsngh8X2; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="Xsngh8X2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1735935198; x=1736539998; i=l.s.r@web.de;
	bh=rO7a12SoQ4KG5FRbkOmND0VtG5lgOaTS7aCsnoI13BM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Xsngh8X2GLwcNnUy5ydPH8O1fPMhm9hpMisV09HTP+rrsTn6ji4nltU91fGrw2Xx
	 i5PvbkDB97tj30qZ83ZdgKwhZ3AfVhyt9p3R2iKYKqfmDIsUW6jbJf3DDRtfTJkJ6
	 bjFGqJQ3s80eUiVnKKYkInrrNTB3mIguLQ+CEUN5ahWNPsasTBpSG+BAlgR4NhAOv
	 /Da5Z8cFTRtRKgwTF+LS+fIDo9nBOzBMuALSP363/1I4WPULvRP8RYqaxpfdTK9XP
	 zmxWWvN6m3gyzhoSX0kAxkyCuUsTzaEwCcrDfAYIF/7onNf7OP3um7DMMXGZgPhuA
	 I6BuuSj/KfCtS1cCcw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.20.45]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Icn-1tj0wL2ShD-00uAaD; Fri, 03
 Jan 2025 21:13:18 +0100
Message-ID: <5796785f-134b-487b-90e4-e7aaf78cb912@web.de>
Date: Fri, 3 Jan 2025 21:13:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git log date filter bug
To: Sarah Gastner <gastner2001@protonmail.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <gEmXX5Orp18U4lUPlWeCKoepi91ih8VkreogEnepOIzTOihbf_iNuXqvdhFcgnIpRabnUscWIKf_GH04iI5NeVpdWjbHnPIPa6ZAtkfITk0=@protonmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <gEmXX5Orp18U4lUPlWeCKoepi91ih8VkreogEnepOIzTOihbf_iNuXqvdhFcgnIpRabnUscWIKf_GH04iI5NeVpdWjbHnPIPa6ZAtkfITk0=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VbssnYXs623w9+peTwxKuIWkxCBwz8+46PuowsIEXW8zmV1Mi+o
 zPiIvTG3X3T2TOvdpqkmU9VMn7NVJ9DPrdmtLzsutd/vcL/7NIpuyVjBkEJxAZDbUywOaRJ
 DzzuxiEDJfzp5uwdZ22YxWcXKLk7VJazbx2txWo4AbU9Q0Dn/orkVuFEZlUIX8F4DY4NJDM
 w1MU1qajRQQdhSLz83I1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KWpNOqCP8Ao=;EsUqo4cJU5kNpqM9UjV6lz18NKT
 Jnxa98UdgTr1H+hhkqwKKFrdDhAe3L1e/EIsGCG4bI6X+f4YXVsNPS1tJFar43C+L3oatRJuh
 cqRbRrfcw/GQWLNn5jwnT9aSWw+GfQ0VmObzRRX8E87E4NfZBLMkkJEufSYsZW7/rcvAls7cv
 YV/vXeSlGOd1S6R2uDy/xYI9gHEyCGTki/JcZ+pNNAXIAG4avh5cbyejHzJv1IanTncc2RBem
 y+3Ygji90uQkFZbwTzYFvRsonz7qjgjvmRCHY1qkUnJQ9EQtbemtJycCE0Pf9tY3ByGRzWYor
 eC9oB3s80iM6X8QpnmLVOJGQW4hcL3VN0FlFxvLRm+pdggfQ0cUhrdyPBG1Ofv+45j7H23xcd
 wwc3U9J/ydSRLof/kLL/iaB43Ov/NHqRcSoDORVYvU81jq/tgzB0Q2YXNiLyWJz3+UF9Evue7
 9C9+prpsnnSNLB7M5FNiLcHb8T8HvecRckgPX5gLbnZ8bfiKhsa8LtYORGLL+ID7WBmu1EbDW
 h7sV5uNxnf7Fs/LPw5rPiSMOvJA7penp6dpMcwrNOWlynO+EVNpzilkDyazf7eWZs0Sd2TrZC
 +rCItuNfOKONIp0+el0QUjkNdP7vG1dEAtA2SACKO0Y7OMDwzr/SWxW2Z2/bb7ZcaoN8JzMSI
 qqX8yHJugvf88EblG00dPD0XhDzMlPdtz12nuBuRSV+Fq0t4wBQWVi2LzOR+NBh9OF3+LUtT7
 LNimzpM0W+48Qtbd4HNo0V5qZDJpP0v+Kd+7yoQrUD+Wv47lTnu1DQ/SSc4zsA5ExtIvUFtSV
 TeA4u8xy4Vlgree2QkEu/anUxAxjUtAIt160Xp6R6A6LwhytBLIGiAa0tPEAxhv4hxBvDTQD0
 J6y2If6/tIq7xd/FBSPidCWHWlEcNlZVb2sadNQ3fR3QgwLUqRJr3owt1XeEvlMQRYpYfWI8M
 oS24UKzZEHvLd0bOYB7kJDXyBwL9zO6IXfxI68ssXGKXv5oslAVvD1iPk+HOKyHP8Njd69zRq
 cpGrfIXWrLLagQECYwqLkjlsBxXJeK/ccC9S5uwyowUn9FqQaiKaIqUMrf0Jegl/7vnD63brs
 OVkpEPMQo=

Am 02.01.25 um 16:15 schrieb Sarah Gastner:
> I encountered some weird behaviour that I think is a bug. I'll paste
> the bug report below and also attach it to this email.
The following command shows the offending commit along with its parent,
child and grandchild; the format shows commit time, author time, commit
hash and parent commit hash:

$ git log --format=3D"%ci %ai %h %p" --max-count=3D4 82eb24156a1
2023-03-08 15:01:06 -0800 2023-03-08 15:01:06 -0800 82eb24156a1 4346c5e5e2=
9
2023-03-07 15:51:09 -0800 2023-03-07 15:51:09 -0800 4346c5e5e29 501976cc34=
e
2023-03-13 14:40:47 -0700 2023-03-13 14:40:47 -0700 501976cc34e feb18b3f5f=
9
2023-03-07 15:49:19 -0800 2023-03-07 15:49:19 -0800 feb18b3f5f9 54283a1d38=
3

So 501976cc34e was ostensibly committed six days after its child commit
4346c5e5e29, which would require time travel capabilities.  Or, more
likely, someone edited the commit history, but did not update the
commit times, possibly with git rebase --committer-date-is-author-date.

git log assumes that commit dates are chronological and stops
traversing the history if it encounters a commit with a timestamp
older than the time given with --after.  That is a reasonable
assumption usually.

Not sure what git log could do better here.  It could add some slack to
the specified time and look deeper than actually asked for to try and
catch such time travel artifacts, but how much exactly?  History can be
arbitrarily deep and history editing can move commits arbitrarily far.

Should it go all the way down to the root commits to be safe?  That's
expensive.  Should out-of-order commits be put on some kind of special
list for special treatment?  Sounds complicated.  The current deal of:
"You want to mess up commit dates, then tell your collaborators to add
some slack to commit date options" is not ideal, but fair in a  way.

Perhaps someone has a better idea?

Ren=C3=A9

