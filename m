Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604126281
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720272660; cv=none; b=nzc3XHhM/Z/1AwIx9qEtpYmwjPMsHN8GySaiCHTbGtW1L3LtRLRsanMcfpbJXe44+uNmOzHjb4ENqIVYp1CxVcc7CZnT6oJbmRY5YexaTeX3SjXDr0RZFHT6i6pwcIzp80Jm8h1ylJUfv4gCHLCZK5tmwIc4y6JHgSgJhQJcCew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720272660; c=relaxed/simple;
	bh=ddoxElNtLT822iEy39XBaMgh+FZw0NOUELPzN2KefS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWZLScZH2Ae0XMu41RuZwLbIimYleHs1LO9biRsHW27rkq+R9YtcaLsol6nqUDBM8jigLavh/gB7OuUj7L3u08QT7WAr3s5bEuFykRi80QpHOPIaYiQMTD340nMw5qC0yXMF4576AssmKqh05pQuhEJehiZqk0/e2zn+iw1DnXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu; spf=pass smtp.mailfrom=delpeuch.eu; dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b=K7klWAC9; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delpeuch.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delpeuch.eu header.i=antonin@delpeuch.eu header.b="K7klWAC9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delpeuch.eu;
	s=s1-ionos; t=1720272646; x=1720877446; i=antonin@delpeuch.eu;
	bh=ddoxElNtLT822iEy39XBaMgh+FZw0NOUELPzN2KefS8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=K7klWAC9YtMnMrkoQuXvSjkqEJFWqs35A1GSaJlkhNmvaHgQSaJDSiwE/x+4yFmQ
	 hUEcfqJ5Slw2Fvs1BUT40yVtcvpbdELx5Y93TluV1V4i2qw6LvBxGaKsKZVZTOdha
	 2P+Gwpw2pcvXSi3QUjY4N7uriCtzt+9NvO0bUoGXNY0+p5UOnX38MUWWaKC807nd8
	 pvUOkvD26iKRSrn83yALBAB/s+om8cw9IPAjJX9YDnTtJ4IHXwamH+X+kTApm10Om
	 2y2JQbUXEQzpCw6yXjQyFgrADT+qv4P9sPz+RCYFWop3rM3+ZIzpJihdhBYNZrspq
	 MkkE0IZyxuH39noC7g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.42] ([84.184.28.147]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M9nlN-1sVKAF2Cvd-00G6s4; Sat, 06 Jul 2024 15:30:46 +0200
Message-ID: <7bc2ff20-98b8-45d7-95b8-e1b09bdeda07@delpeuch.eu>
Date: Sat, 6 Jul 2024 15:30:45 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] merge-file: warn for implicit 'myers' algorithm
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Cc: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1741.git.git.1720016469254.gitgitgadget@gmail.com>
 <xmqqmsmycriv.fsf@gitster.g>
 <dd1f768f-a137-428c-8a60-c5e875b66592@delpeuch.eu>
 <xmqqr0ca9qkj.fsf@gitster.g>
 <CABPp-BEspjHqNXSAwptgxP059qOFU6MzwAd23-893Nw99ft_Ew@mail.gmail.com>
 <xmqqed873vgn.fsf@gitster.g>
From: Antonin Delpeuch <antonin@delpeuch.eu>
In-Reply-To: <xmqqed873vgn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7zfR8KvNIMG8lauIyaWfcuhETAAcrnG/YhjkfRQ6bYJKyiMQ3Lx
 CeeWkes/nNwMwoQJck9KCrSBhxon8zB/yz/SrKRQijDcxDfInl23/9NHY7Mt40jsYsD+fup
 QGE/rjITYQWXH4/bCt3E6VwuVdx53TGhr7SP9Z8QR/F7/6XK9uURqQsw7DWe5/xCMxPW8FA
 WNQ0sp+MSbOugZIEsM3Tg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U98oC3dc0jM=;CredqRHfeKPbFLOTIFuIaw3f5ZN
 md6fhRbhsj66sBlQiLKGkO6RDu41zxdVgmiZ18+CyFlokuWuiSphYG0JsP4fzu34IyceOzqsB
 Hup+kCpCJeStRh+XTdm0a0Uf+hcreVhRQF6+sNrnFCRDbCpz4Cqff+khRHlvsFctKFivM4usS
 zf2bwPgzq7MlNQ86adgzhk0b6DEQoNigXZoN6PzGtpt2JZtHbudWGgKJEkPEjXUCHnbX9YU4P
 l5QfsdPybkGay6+mKpFT+/LSgUWVrOtJm/HijRco2F7VLCVTictgTZxwAZr2s2e2iO0ZIWKJ6
 qiDgHDw4B07+FC4xrf38ROgzNPIFBH9lwtVQK0FKDyDXP7lOlh/3X58cpacHDSOpZ+AzHivKJ
 ytJtTECDtqYAe0PVbPYZqPR9RzZdq3VdREw/95wJ9JUmq/kX27jJ0mFqsXISFlC0JJ/YeZFD7
 avF2CLPhVY1I9BOpfnbuEf4KCDFomG9nBmd7sDwPouwYtze7lUXunidXy6deciv4QgH6jPOxh
 D+ANrRKjU/02CASE4J+0aieBvNROv2808IFSnmDMDBiVvM9skNK3hCrEupqvsUlJWPWJdi/io
 OLidMGbBpMPo2UPzU6+2xNKU5oAb1+WYgOf8Zkz3RR03Rzrt0vpwb23ITs6dLJUx4aYbyGUSF
 O3SD9LQYfa28Smq4Nxy7B0oWeRizZ8qO8UeRmyTxXNpLdjwYg4F9gTFsa/1d4Ks8cY9dNtjoM
 wHxzwzgYhrl6uqQn2s1IOyHisZ8utCzqcQd2tsufzytw29ct8xdkvU=

On 06/07/2024 08:06, Junio C Hamano wrote:
> Everybody uses diff.c::diff_algorithm somehow, will be affected by
> the diff.algorithm configuration variable, and everybody should
> honor "--diff-algorithm=3D<choice>" command line option to override?

I have looked into writing a patch to implement this, but it looks like
the situation is quite messy. There are already half a dozen of commands
which claim to honour the diff.algorithm configuration variable, but
ignore it entirely.

In the documentation of the recursive merge strategy (for instance in
"man git-merge"), it is claimed that "recursive defaults to the
diff.algorithm config setting". As far as I can tell, both from my
reading of the code and my interactive testing, this is wrong. This
affects the "merge", "rebase" and "pull" commands, which all three
mention this configuration variable in their man page without respecting
it. Ouch!

I have looked for all commands which mention diff.algorithm in their man
page and checked whether they indeed respect it. The "diff-index",
"diff-tree" and "diff-files" commands also make this erroneous claim.
The --diff-algorithm CLI option (as well as the --histogram and
siblings) are respected, but not the diff.algorithm config variable.
Those inconsistencies seem to be caused by the inclusion of the
`diff-options.txt` file in the man pages, which leads their man pages to
documenting a bunch of config variables which are in fact ignored. From
a user perspective, I would say that those commands should indeed honour
diff.algorithm, so I would be tempted to fix the code rather than the
documentation. That being said, the man pages of those commands also
mention other options which are in fact ignored, such as
"diff.relative". I think it's likely that for some of those variables,
the contrary is desirable: remove them from the docs because they indeed
shouldn't be relied on by the command (because it does not make sense
for that particular command). I don't have (yet) a good enough
understanding of those commands and those options to judge this
immediately, but it looks like there is some cleaning up to do.

In diff.c, the code that is responsible for reading diff.* configuration
variables for commands like "log", "diff" or "diff-index" divides diff.*
variables into two categories: the ones that are "basic" (parsed by
"git_diff_basic_config") and the ones only relevant to the "ui" (parsed
by the "git_diff_ui_config" function). Surprisingly to me, the
"diff.algorithm" variable belongs to the "ui" category, and is therefore
skipped by commands such as "diff-index". It seems natural to me to move
diff.algorithm to the "basic" section. However, that alone will not fix
the problem (in my opinion much more serious) that the recursive merge
strategy ignores the variable. To fix this, the parsing of this variable
could either be added to "merge_recursive_config" (in
merge-recursive.c), or in fact directly to "git_xmerge_config" (in
xdiff-interface.c), which would then not only fix the recursive merge
strategy, but also a range of other commands such as "rerere" or
"merge-file". Given that I started looking into this with a specific
interest in "merge-file", I would obviously be tempted to fix this bug
directly at the xmerge level, and I think it would indeed make sense for
other affected commands (surely "rerere" should benefit from using merge
options that are consistent with the ones used for "git merge" or "git
rebase", no?), but I can imagine that it's too bold a step and could
have unwanted consequences I am not aware of - especially since Junio
recommended to add support for diff.algorithm at the diff.c level. What
do you think?

In any case, I would of course make sure the "ort" strategy continues to
ignore diff.algorithm for now, given its current default value.

If you want to try this out for yourself, I have set up a test
repository at https://git.kanthaus.online/antonin/testrepo. It has two
branches "master" and "theirs", which you can try to merge/rebase, for
instance "git merge -s recursive theirs" while being on master and
having "diff.algorithm" set to "histogram". The merge scenario is
designed to fail with a conflict if the myers algorithm is used, and
succeed if histogram is used. You should be able to see that "git merge
-s recursive theirs" will fail but "git merge -s recursive
-Xdiff-algorithm=3Dhistogram theirs" should work.

Best,

Antonin

