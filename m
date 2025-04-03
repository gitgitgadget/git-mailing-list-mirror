Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213151519A7
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743682685; cv=none; b=E//mZYATTWRPJ9E+/iW7RrSOEukNCUoowDwh4d+PTHx+vcEfnSdo7L2iAjMuK+CkxRcWx+OfbB8YT1zxo8ONX5rcQXgIu24SvyWeMGSiuynawvuJTzRyKFSFI1FIvvel56uRCkKO6qGhq6CG0HXqb3nhWUJsSXemj4RFQO3xnY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743682685; c=relaxed/simple;
	bh=ZOAbJwJXphycC7Dxat9wj99q8AgCgngoM4TBP3FLoKo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gJhGQGUMNcbPaKJq1orWKcop6odSM692vGVcUxW+xgLIDdLpD2B/HM3PA42a0L9tlDvfl0dS9XotfaHzBmcJV5fzgmZgtVJ6v/9Ym7QGdSDJuX0x0/RdlUGAs7L/hwjFXYNy+QwXyNB8wJUOGvoZm/ivn6OLyRkiRW5tR4MbWVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ISxtitLW; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ISxtitLW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743682677; x=1744287477;
	i=johannes.schindelin@gmx.de;
	bh=ZOAbJwJXphycC7Dxat9wj99q8AgCgngoM4TBP3FLoKo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ISxtitLWXZytdm38C8AejNoQ9jag5lv+T/CvCpXDDCFFerHiH4keJTa+aeo6LJJe
	 Ri6cDf44qxHfxcd6tmG4FUviotfr6tZ62FJx0CpMH9+JzVFiAwS2ubVz5SlF44HgH
	 H9LF6yiQpLz5hugJ7syzF+0iq7FUNExfCOUuQnDrOE5YAiaUpkPdtM9UyYIGYPWlM
	 2K0olPglkkPAqEqgYDC9R0j6cTBjTfJVnV7EI3HGZMdJDLsLBMNQDc0+VNf8WSO7N
	 sqGw9OBj/zHdvVYuXybTkVyBsBeX249a5VL5PfzEuw4aIgREoq3OZEyJX2tAB3sCp
	 BH3HsVzWIm7UPkS5FQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1tgiIm2z9t-00I0Fe; Thu, 03
 Apr 2025 14:17:57 +0200
Date: Thu, 3 Apr 2025 14:17:57 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 3/3] wt-status: suggest 'git rebase --continue' to conclude
 'merge' instruction
In-Reply-To: <a81dbb21-b50b-4358-b2d4-7f804b66bcbc@gmail.com>
Message-ID: <15222e69-9452-fd61-6ffc-8c8de0c68d8a@gmx.de>
References: <pull.1897.git.1743181401.gitgitgadget@gmail.com> <db01acdd062a17b1cca62428eba8c3ed62ca7c6a.1743181401.git.gitgitgadget@gmail.com> <0bd7e0c1-fe73-9e16-0737-d6b175a60dd3@gmx.de> <a81dbb21-b50b-4358-b2d4-7f804b66bcbc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9F8mu57FgAi05JZm1sQIgrtr5iv+TirzBNRvQaJbNas5RjnRuq6
 b4g+eF0kvzrTSGpwCl5Og1qRdSqjZkBX/mmGQWri90fSGEo9CiWtbUPN2G+btDimwrHqqea
 OnoxWmASiYIHFzzXwmUDhi5gaJAIur6vxVENhh1efoz851tvvNR6CpJPjhnSNx+spXW4fop
 Cko8nI0YTB6Fat6faYg8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pZgBnCTqUBY=;iWzJlijs3gEWQAEYJ0K9EvgbcYG
 pI18BemVG1ALxMIqiPI2NFWVNeYe4Biig/4q+z7Zg5Ddnw0/rosN+K/RtJazKQFo9SDxdB6jN
 i2iVNEPUIgaZcOOhhVcY6aM/Or4juJucI1fmwblul2XLlrznoxIojlb8IrZOPjDGjD96md/vC
 Lx4u3O2gD3zzzkrRzT4cJLiTXA2/ZC1yEY7ms11V4T3LV/4D25FUhT2OsPbmoYXmZ8Lv//MIp
 HadF7XFihruTJ9un+Vn4Tg6pV1CvrFHatP8FJKwovLBZjbNDzuGuv9ishe0cPrdOskAwHI9hI
 Genj4K0wul1i8KYccYcLGLamtAb+1NwvQvkov37ltSkjOl8YNRzy3Onn9xsCurJgnuW78N4yQ
 mIDzENedzHAivd04vEZNp1Ro8HO/2LkTSJSs0Spz2IrV0rgM8KvjS+ffMUg6GrsKqHM102IRx
 +2mLBInGfFh9e7JJBrB4evd2SPWTvbPbshDEU7xf5OwuUfiiToHJ6/4sVmr0E97rlm6pBxY5G
 oHkbRe8zJLM8F9aBDvSFcjyOnmh6jQ5x8TTRHtNR2Yp5HrEDv9SKL0JM4lZOGw5stE4W1OJvd
 dxmGHnnpwMydn6hx0k0XufgWFyK6+i/8YQEKyYvSSZ36g195pYSLIQlZ//7Zqi1JoTaSgJe9A
 wMiTTzPmNe8f+cBQw7qHRM1lUYSGQUcsokXRj5667oOTaXJn9fu7+zHlh/CCDaSFkPapehPaB
 FiNTmvRYcMNEDOa1QfbIK++QmNEqi+USXWAUkfLB0LXTND4O045+fwcCfUGTOh51rXDt5R+Gi
 pyvtuf2NTINAwX4JOO3ZRhkAAnPLRoYDOr0Fuo67xnlnKuOfMpSdFfuqUZMcgrx4p2REcRSq+
 sg376+yfrojXrqkGnhsdVOP8LCZWVq+KKiGA2GLtAm8IMMPT/2L4XnVSxeM6dmRpX3do2ZAMj
 bFYfBdq0wdvZCp0z46JqE3Mh32U2l1Y18X1DIenCRdoqDlObHD3ch+KNhKLs4PHTVsdGEbToD
 oQnJpwxgYg42u7kgaOmpEOBypiYXkr3l2gwOZsEXWaZOfyGZcFKjumiHPI8Y1erNLvSLrHW3h
 BFjSg0ogEKYgclMXPxc5pnwOXm/UnuygyhaPmT2bO0kWkEh8lUW6zxrc6DY7cn7lo594ISs+l
 YsbnJC45Ad8PkVlliIUA73cp29b1Yi/rpPGBGCFyR9PYfzkfp6cNTodVhh88UErHDjyM6PK7t
 Tf2PVRXHqgNTYe6gDw+CPvFrZ7RWfL0m4OpEu0TwnRbrTUgYDbALAdUdlC2JkZTH31dBMi0Rc
 TYiS2xNJcgriuTIRl00jw8WmuPrSWflCvchTAaOZMJfF/x+pVZ0XWZbIPGF2uN8Rh80Shbcae
 8WNNAEj3GY8VPt94rAl+pdpkmlzHSeqR0z6GdRtIDZccY2lgxgLid/bklSwYjmIM/ZUkryP6Q
 tr7wVm35joz/C8fZUWPxD+YEqSlur0LAYlPl2/IP81MdJMVrJ
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Wed, 2 Apr 2025, phillip.wood123@gmail.com wrote:

> On 01/04/2025 17:22, Johannes Schindelin wrote:
>
> > On Fri, 28 Mar 2025, Philippe Blain via GitGitGadget wrote:
> >
> > > From: Philippe Blain <levraiphilippeblain@gmail.com>
> > >
> > > Since 982288e9bd (status: rebase and merge can be in progress at the
> > > same time, 2018-11-12), when a merge is in progress as part of a
> > > 'git rebase -r' operation, 'wt_longstatus_print_state' shows
> > > information about the in-progress rebase (via
> > > show_rebase_information), and then calls 'show_merge_in_progress' to
> > > help the user conclude the merge. This function suggests using 'git
> > > commit' to do so, but this throws away the authorship information
> > > from the original merge, which is not ideal.
> >
> > It is unfortunate that we cannot fix this, as `git commit` with an
> > interrupted `pick` _would_ retain authorship, right?
>
> Unfortunately not. Running "git commit" rather than "git rebase
> --continue" to commit a conflict resolution when rebasing always loses
> the authorship.
>
> > (Why is that so? Can we really not use the same trick with `merge`s?)

Authorship is retained when a `git cherry-pick` (what an unwieldy command
name for _such_ a common operation!) failed with merge conflicts and those
conflicts were resolved and the user then calls `git commit`, though.

Why can this technique not be used in interrupted `pick`/`merge` commands
of `git rebase`?

Ciao,
Johannes
