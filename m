Received: from bumble.birch.relay.mailchannels.net (bumble.birch.relay.mailchannels.net [23.83.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6C4328B7F
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791071138; cv=none; b=l4qLyRyuNBczcss5yaqBWlGshePxQriS8RmheXQ8sK39uAx+ZgxnqtnYobNoliSUcMG/GXmU5aNl5ZoA4Qxf4NxiBrVSL7DAdLMoQwzxGAJu7BJxcL+AB/A4BCY9AKT7Cxd37eLpHk06s1dpr7i/WBIWd2bgOFS6fWd1TzIXu4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791071138; c=relaxed/simple;
	bh=zYmFlGgGL4zzf1xkWAjAa4fsSbFq2LTucRL9TVTTpZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pf/BylgxWEEXar9vSkjxvPz+Ej7+cFC7PGOXfQ+M3FdbNKLX++wYsyLA/1LEF+jWevIvBS4yey9sMdjJxish2mwf4Jq+CAm9PKltbupMKLcXixm/XlWOq/ZY5TB55RYuX3BvCRo78/nuXnjv8XzPbb55lZ657VDy2SdZ/9ZBSU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=Tj2gex2D; arc=none smtp.client-ip=23.83.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="Tj2gex2D"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E16A03E0E20;
	Sat, 03 Oct 2026 21:13:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.96.18.116])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 809623E09E2;
	Sat, 03 Oct 2026 21:13:28 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Reign-Suffer: 3ece9ed17761277f_1791062012785_2432176429
X-MC-Loop-Signature: 1791062012785:3798860909
X-MC-Ingress-Time: 1791062012785
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.18.116 (trex/8.0.2);
	Sat, 03 Oct 2026 21:13:32 +0000
Received: from ubby (unknown [24.28.102.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4hxz075bhvzS7;
	Sat,  3 Oct 2026 14:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1791062008;
	bh=IDwmRNpE43znXevYj6HobM0vh2PPZod3OaD7QZZYT7Y=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Tj2gex2DWtN1Mvt9Hg6HWkwGJl/TtF2MXWkQaXys+HC5VeMf2XDKX1XXQdrZjROuz
	 j0lyBW8eYJ95geo66yYQgZBX3CSfQl1msA46XgXSxTHOkNL9QCbn13rFTUmQewJy7M
	 CoogGRqsfKItpYqxRoRjHVDJoPH93lPT+i93icvIkKNDUkfKb8FLxwLL9Ce2LV1hLS
	 HjqZDx0n5ZQWQcqYN8fPS65xdicddEcI9gDUZdhLZzkGZCI5iEMp+pgf1Tw9SmklG3
	 iQoU4aDtZtO8ZUjkZwk3bibSHHyn1NRzYIi8M2C5qAhOCi6KJu1kRtudfgiVuURuhG
	 1PHl5fq1RHQAg==
Date: Sat, 3 Oct 2026 16:13:25 -0500
From: Nico Williams <nico@cryptonector.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ben Boeckel <mathstuf@gmail.com>,
	Viktor Dukhovni <viktor@openssl.org>
Subject: Re: [RFC] git-brebase
Message-ID: <asFv9QcpLgzPnnFb@ubby>
References: <asFRVdMTpshsazgM@debian>
 <asFoDZKscLKqaIf+@ubby>
 <asFoq4gnl1caJM2U@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asFoq4gnl1caJM2U@debian>

On Sat, Oct 03, 2026 at 10:56:25PM +0200, Alejandro Colomar wrote:
> > I also have a getopts_long-like function (see my gists) for bash if you
> > like.
> 
> I think getopts(1) is not usable for git(1)-related scripts, because
> getopts(1) interprets '--' as the end of the options, but git(1) uses it
> for distinguishing commits from paths.  If anyone shows me how it can be
> used, I'd be interested, because I've hit this issue in the past with
> other script.

https://gist.github.com/nicowilliams/f3fe2b10b380aecdef403acb246dced2

Though there's many ways to do this.

> > > cat >"$callback" <<__EOF__
> > > #!/bin/bash
> > > ...
> > > __EOF__
> > > chmod +x "$callback";
> > 
> > Here what might be better is to have a command-line option to execute
> > this callback without having to write it to a file,
> 
> How would you do it?

I'd have an option or sub-command of the main script that says "do the
callback thing", then when you run `git bisect run ...` put in the name
of this script as the command and the "do the callback thing" option
next.

> > and use environment
> > variables to pass arguments to it.
> 
> The callback doesn't really need any arguments, since 'git bisect run'
> won't pass any arguments to it.

But you're embedding values into the temp executable script -- if you
don't have that any more you'll have to pass those in.

> > which means I can't use this in detached HEAD mode :(
> 
> Oh!  I wasn't aware that git-rebase(1) supported detached HEAD mode.

Sure does!

> > I work in detached HEAD mode almost exclusively.  I know, that's..
> > weird.  But it works for me.
> 
> Ouch!  Indeed.  :)
> Out of curiosity, are there any interesting reasons for such
> self-implied pain?

I often do:

: ; git checkout origin/master
: ; <do some work>
: ; git add ...; git commit -m '...'
: ; git push myfork HEAD:refs/heads/the-branch-name-here  # <-- I name it here

then open a PR.

Now I don't have a branch here, but who cares?  If I switch to other
work and later want to come back to this work I'll either a) create a
local branch then, and/or b) when I resume work on the first thing I'll
`git checkout myfork/the-branch-name-here` and...  once more work in
detached HEAD mode.

And if I need to see "what was I doing?" then I use `git log --oneline`
and `git reflog` and I quickly see the remote branch of interest.

The remote branches are the symbolic names I need to preserve, and my
clone will know them, so I only need local branch names for things I
work on w/o a network or over a long time.

I do exaggerate a bit.  I do this a lot, but maybe not quite "almost
exclusively".  Often I'm forced to have a local branch by opinionated
tools other than git itself.

Nico
-- 
