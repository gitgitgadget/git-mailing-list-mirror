Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA12334E74D
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786138767; cv=none; b=WkHUlif1AClrQo6lwHl9v0uBefAnoUBYMdkGeVo69svaWDg808dYBdSb2y3ynlH4pygRvg82lnBn+C2QJu4BcyddS1JOTRS1dwgFxeb+isDB9iEjJn/T+VdQt85sYFORsK1mF5Ow/WVXzlaU62py5tLCXvGN6jBPU0mawqjVuhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786138767; c=relaxed/simple;
	bh=YYQu68NqtQdOA301Tke5Iy3ayEzhjh/pvpUDg2Rqxzk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F0tSIH5fvCWMA7tdt20fNGVoYYe8wf4I7efLhaXKLgedbX8LQCfEb796YV+8mFkznfDSslz+wlRj0nr0Aq4llVgX+Lol/MiTvjHQSux4ElOFCWazpQTCiTTUZBUj4H49V+ZwBoKfToJxyqu9jYn0LFRrk6AHBPABwWoQrkoQJTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=twied@gmx.net header.b=kKlvtDIv; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=twied@gmx.net header.b="kKlvtDIv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1786138762; x=1786743562; i=twied@gmx.net;
	bh=YYQu68NqtQdOA301Tke5Iy3ayEzhjh/pvpUDg2Rqxzk=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kKlvtDIv3TejHto6a18rjFoF89meXZOalcgUKj9NpIisrZJPOQdtBWxPhqJRt+2x
	 hSA3Dt6L0EUd/7BtB4ZXIMyEYZpX68ydq3REsiM62aLQoRRwtkrTAccc5hgV0omUC
	 FWMqWC2nuadpcUww9bsWxdbbojHab5/xmY855PWpvoj5img7/wU3YaYuLELJHekGQ
	 veSUiLZUR3DnM5eGqzJXe1JP7ia/Uq3U27aVcSCkO8yz2h9cRc4sFjBp1q3ZlL+3q
	 AHLF2VSHhmiBOCFT5SVAdqBzKGc0Rz4xv/ZysZmbl41xffKJcNGX8m6ZeDWHrh52+
	 NH4A4kxd1kvQrA1dyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GMk-1wwwOI36zg-013uDj; Fri, 07
 Aug 2026 23:39:22 +0200
Message-ID: <76636876b815ac4aaac77eb7b772e2e55234e11a.camel@gmx.net>
Subject: Re: [PATCH] gitk: add user-defined custom commands
From: Tim Wiederhake <twied@gmx.net>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, Tim Wiederhake via GitGitGadget
	 <gitgitgadget@gmail.com>
Date: Fri, 07 Aug 2026 23:39:22 +0200
In-Reply-To: <82e59e71-5cb0-4a7f-9fc1-e66b367670f0@kdbg.org>
References: <pull.2371.git.git.1785879839766.gitgitgadget@gmail.com>
	 <82e59e71-5cb0-4a7f-9fc1-e66b367670f0@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:NlIWVWrXIDsUy91LPfPTrZo2jBMbKR9QZb97/Sa33lT2oR53UOj
 T1qZA2AryVcb54pdjqHoZIz7Xc01/k2JcS+6Me2R+deLczA8xnW2bPNIaFQ92POWZ9hVRSk
 l2U4Se2Cl8g4NPeBfe6e3eNo6FdpX860PLkWSymjjzilJBSHXWksjIMV31I648OA6ZCs9ZV
 K71A9P0WjTB7tGXH0fgoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SqlnMDXnKGg=;/xQFfCxuF+PhVeMr3wCQmyY1O/X
 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

On Wed, 2026-08-05 at 08:59 +0200, Johannes Sixt wrote:
> Am 04.08.26 um 23:43 schrieb Tim Wiederhake via GitGitGadget:
> > Allow users to define up to three custom commands each for the
> > commit
> > list and the diff display area.=C2=A0 Commands are configured in a new
> > "Commands" tab in the preferences dialog, with a name and a command
> > template per slot.=C2=A0 Non-empty slots appear in the right-click
> > context
> > menu of the respective area.
> >=20
> > Command templates support placeholder substitution (commit id,
> > commit
> > title, author name, author date, etc.) and are executed via "sh -c"
> > to allow for background execution by appending "&", and pipeing.=C2=A0
> > If
> > a command terminates with exit code 42, its output is displayed;
> > otherwise only non-zero exit codes are reported.
>=20
> Thanks, but this commit message is a bit lacking: it does not explain
> why it is a good idea to have this feature, what purpose it servers.
> For
> this reason, it is not possible to tell whether the design is sound
> and
> whether the implementation follows the design.
>=20
> > Signed-off-by: Tim Wiederhake <twied@gmx.net>
> > Assisted-by: Claude Opus 4.6
> Thank you for being explicit about AI assistance. Note that this code
> is
> going to be downstreamed to the Git project. Therefore, their AI
> rules[*] must be obeyed.
>=20
> Equally important is that I want to be sure that you have checked and
> carefully reviewed and understood everything the AI produced. I am
> not
> going to look at the code until there is sufficient insurance that
> you
> did. (Blatantly put, I don't want to review code produced by someone
> else with AI.)
>=20
> [*] https://git-scm.com/docs/SubmittingPatches#ai
>=20
> -- Hannes

Hi Hannes,

thanks for the feedback!

I agree that the commit message is a bit light on the "why" side of
things. Personally, I wrote this patch because i wanted gitk to have
the ability to let me select a line in any commit, rebase to that
commit, start an editor with that file and line selected, and after
quitting the editor amend the commit and continue the rebase. An "edit
this line at that point in history" function of sorts, because I tend
to spot typos only twenty commits later.

If I had proposed a patch to this effect, I am sure it would have been
nack'd as too niche, wrong tool, or any other reason. But having the
possibility to define custom commands allows users to adapt gitk to
their workflow instead of the other way round. I am very open to
suggestions on how to put this in the commit message without resorting
to (contrieved) examples.

Regarding the use about AI: I used Claude to produce the initial
implementation. I do not write Tcl, and frankly, this patch has not
changed that. I have reworked the code - using Claude - until it was
effectively the Tcl version of code I would have written myself in
Python or C or any other language that I actually understand. Does that
pass the bar?

Regards,
Tim
