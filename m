Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B55202C43
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524548; cv=none; b=YGA3T+7uJKBkoXVhl3hYLoC6QcErfx4IdAbHIfKonvDBL3eiygGDZQpNSCrHXmeCQZHu7s/GRPA869+LX1Y/WsUt5PEzSPopZnMTLB77HilyFzWCgk57TnbH3RuJI/Hg+bvR7Qa/tLA5TxIQ2PIHEumIXYz1govFz/tjBoR/yN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524548; c=relaxed/simple;
	bh=lr8af3UnEhnPj+iDcjRmbGnpOPB+04wKPGMGLwcbw2E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CKLZNWVX81dc3GQHNC7Pu/LeESeV60WUs7ZTzFCPMDXG2SvLni0stwzOrbnM2MbEjnG7IffFxPmmqDz/i2DCJUgt6Xipz3aTAnmRBZ4cGDLL0Nx4wMpRxUJx9mHb3M6mpC+2HUcBOaUtxYtLLUQq1AH5UZNnUXlyRT8E1ChxQZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=S49Ku6MS; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="S49Ku6MS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743524544; x=1744129344;
	i=johannes.schindelin@gmx.de;
	bh=lr8af3UnEhnPj+iDcjRmbGnpOPB+04wKPGMGLwcbw2E=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=S49Ku6MSJTBU0p2RJu/rz/5RKyzmbS5VL3ObqQ4wpljH5gRPZdSTniAjRLW6yyt1
	 5b5rORE4elxw7cue/g8PIfCAG+tbDM8VZI6qhimlDRS0t57r3OSYfNItBYuawdY8Z
	 p4Q3lJCnAJLDwz3eBGYZWHrl4Lymtk6AR7T+ygo/HxfQdsDqGPnw2Bj1XbYlTW9RZ
	 N0w+l+NVPcAPkTNBxf5LcuQWDKbpXE26Xv5ij4MLKRxzLIUigx7+/r1IZnqvgykJ7
	 53GUdwrxSOnz6Hfx+DVnBd0Ua/xR+yWnqoj0nm0TCKpVet4DGnLREyeXsWiZvlz6g
	 MnsAZlf0yyjXpoQnJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEm6L-1ttttr29bn-004RYb; Tue, 01
 Apr 2025 18:22:24 +0200
Date: Tue, 1 Apr 2025 18:22:24 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>, 
    Philippe Blain <levraiphilippeblain@gmail.com>, 
    Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 3/3] wt-status: suggest 'git rebase --continue' to conclude
 'merge' instruction
In-Reply-To: <db01acdd062a17b1cca62428eba8c3ed62ca7c6a.1743181401.git.gitgitgadget@gmail.com>
Message-ID: <0bd7e0c1-fe73-9e16-0737-d6b175a60dd3@gmx.de>
References: <pull.1897.git.1743181401.gitgitgadget@gmail.com> <db01acdd062a17b1cca62428eba8c3ed62ca7c6a.1743181401.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vafoj6lgZzSd3q0O8lWu4rB0jxaq2Y3FLOzPe74GPbsVqgUzVAL
 wFe31nLehGe0bdJoq+PZZGIy2EPnTcnt9ooOZtl+hZZVGHSCliyRnnhuY1E0PlsNqeHwvrp
 edEyjR1+Ynlqj1YJG7gp8J60fctpTSsEfbkNDhX4aV/JNaKBAa2lUeTSNYxHhLtfUvtgtMS
 E+W773Ck8y5uF0+FffG+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v2CpJolqdZk=;JsbvGCqeudzRKcPzFl8Bo6CHNY4
 WMotfLM8NpVVcZEzrS6YJ3C+gRVrNlLjSvpczAU1S5RqhuHKPZrVz/IGx1VtAYw4qXaSyWZfG
 e/oUWRMUYyLzvJAVJFmua7mZjkqcBHRGAvRb756USJYbjJP1dFKytkmbKSuHg1jRKacwF+KTF
 t79OKFOfDyO0zSDHTB48Icz6R4xyag94xz/piMN5c/PzsDZV+vpNDvFsWuZH+SwYy6QIGbMxN
 CCBfwEp1FqFuDrqI4Mk0i6J1NIKhqI1hLQ/1yg0oqwcdijrmnKYTc6SG7IrELWCK0/+jSBq18
 zQ4zeBdqt5HHX9W3Zb26lpnOjcJZXY5q3LpovNqADbrTkm6soXBe3qlSuyFBSzbhAX/Ycwnfx
 tva+p2Rz9ORgXyPzcBohXwfZu7Esy1u9So6aFPHfJD4/uXo3in1eScyOc7ur0dfpsnC31HYfB
 aAgZdI4JYUcq7zHIuW4KIQdN5qETWVDiqA8lNjRA08Jqi0cSqH3yVP3jJDUrEN+8MToTqqvBa
 iRSWsES6FCFR1niRzTzEMIuTOT2p3oQJ3oQdjvLwCjM7scT53Bg2JGP8jFueD7jjmnUhnZ5RX
 vyaaQeQCAUS7JM+kr+xuPnij73eTGV9LNuDCbxp02jqlQP+xggV5b4xK8tUBWfiDedortJRMA
 DdYXtjqnNpPBO6NdJ7QhfEvKvbBc1+LnlkOLjVHUAFpRIbpEZGNHeXhCweqsdaIgfvt5WMPf5
 wZa/5N0oyHhUiecMfcyTEoWzmyduq8G6rdx+71mzJiCUlzNNRqVz7/MQYKkqPuLMoPmTjPgJT
 5+6rCG9l5vx7vSotgVrq0orgBi/BNAM0Q9xSNX2XmL2oQyZNafz88lpukIb4zRRYbTtrgmAbM
 5ZHxuXezTUUs1mYH91ZK1aIatU1XhLMoxZWnUyM50H9WeSBqEc6V6DMPGBQWXVxoY/D+iNV9t
 a2T3x4GDjEL5A63gImMjxsv32JoJl7d6Okfof3XJAytuedCpk8zsti+r8+Tcnx/2amekPbJjL
 0HUS3SqdCScdiXoUurmDvyo3ty6TR39PaxTMIfg4CBmtkDS9kf8qp8VhOTz4Db/RyxCHNMBDo
 UAyWQ9Q39u8LXy7IE9YnEx9clNEUjpHVn7Tfpg5bWbYc0dsTdc0lF3hnOMVx8m9d+sKawORiR
 c9PuCEs6SzcVup59oU9VeCpErPY/tGSWyL7nZOeyr+hfscQXk9rrxWuw8RU2NZ4U6jiXfrQj3
 Anqlovp16oEgquLSz9aFrzM4worinV0yUF3Ka739Efwdum7kSF1l1RUcQ6dKJyQ+tIBjc9YOn
 tgj3DTZaogUdNbKhkX1wzoQfu7ruHQnaAaZjICBWtWckKr18qr20Bw5XONSLkVoB2TEVWZe+o
 qTt/obz3LKu/6QEdWC78AhIRHked1ROOTgMACHYac7DxcHlvap9TYDOFWOfjrgscB1kSiqly3
 T+Zd/yyc3GvwAUR9mDkT8q0xqtHvYc2QK3YWJ9GSyHsCBpUFE
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Fri, 28 Mar 2025, Philippe Blain via GitGitGadget wrote:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Since 982288e9bd (status: rebase and merge can be in progress at the
> same time, 2018-11-12), when a merge is in progress as part of a 'git
> rebase -r' operation, 'wt_longstatus_print_state' shows information
> about the in-progress rebase (via show_rebase_information), and then
> calls 'show_merge_in_progress' to help the user conclude the merge. This
> function suggests using 'git commit' to do so, but this throws away the
> authorship information from the original merge, which is not ideal.

It is unfortunate that we cannot fix this, as `git commit` with an
interrupted `pick` _would_ retain authorship, right? (Why is that so? Can
we really not use the same trick with `merge`s?)

Ciao,
Johannes
