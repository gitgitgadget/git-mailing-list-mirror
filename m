Received: from sienna.cherry.relay.mailchannels.net (sienna.cherry.relay.mailchannels.net [23.83.223.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E964743B6FA
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062579; cv=none; b=ugf+m8VZOgjyeakp/M+7LE+Pbx5pfHHxW+uAqHIKSK44X7yUmmajwTljCbjSe9eo5CryGvUIFEjiybPTRNHVPtvgZnnROygt9VXrxDmGtek0kr2bxC8x0Twb2GBQhl+Yk/nlXo5llkzj1iHU5ZAeNU+wwZ01eL8r9yTa42eR44g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062579; c=relaxed/simple;
	bh=OlLTZmBX1uJcZe9z9DG4ok22U4VJiyEKM9krpXH4ryE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugs/mGpO3xV9wfOzq9uDvbYPeyGH6ykDeQS68giMRl0k+TmJ8LwKKjkY3T1tg1HvlIFUqaUgPfz2sWgD3W8ZG4Ep9RrFRBagTnU0uYHEALxFp95WD/Tuh/IrZUHYhBXzx+xo2GXtBM5T42CCjfL7sM//I85yd0A9W7j18ZxdF8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=SX1lBKdR; arc=none smtp.client-ip=23.83.223.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="SX1lBKdR"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DB4F4161660;
	Sat, 03 Oct 2026 20:39:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (100-96-12-121.trex-nlb.outbound.svc.cluster.local [100.96.12.121])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7465D161712;
	Sat, 03 Oct 2026 20:39:44 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Sponge-Fumbling: 2290c45f402ac97e_1791059988737_1530337231
X-MC-Loop-Signature: 1791059988737:2223425599
X-MC-Ingress-Time: 1791059988737
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.12.121 (trex/8.0.2);
	Sat, 03 Oct 2026 20:39:48 +0000
Received: from ubby (unknown [24.28.102.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4hxyFC5NMrzS7;
	Sat,  3 Oct 2026 13:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1791059984;
	bh=6kQcbViWtoW6I+dp4uvXF4duVomGzIpgut1ZZAQbG/4=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=SX1lBKdRbjWjPEoU1gqdGYuIGwZY86kxtCF2V9XPPrjW9IyDMYNz2BpICkTQ2xEfT
	 zwAz2UfMoloy5lth8TBDFE+ejMpNmiEOQFm0Ca8+DwuT6oBQUQSNYbE1QkWjXohjkI
	 ddW7Uv1PqttxyTZQEP1YCAzAcMwCOQOE0LRF1Zu82f+65VZxbDWzNvxWkepTCca9a7
	 9GkmA9GMvGF3lSgaGk8ttv+KxjXWFmWqJVR5dw7JrEY3qiISu+yygeX7DrMQE5L9Mc
	 RWM4VNcS9Joz4rb1mb6oFb5S168ffxU1bqONKUIMINv0NrSGM9Syja2iZx8v7TxqOt
	 4U6tplP0czoWA==
Date: Sat, 3 Oct 2026 15:39:41 -0500
From: Nico Williams <nico@cryptonector.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ben Boeckel <mathstuf@gmail.com>,
	Viktor Dukhovni <viktor@openssl.org>
Subject: Re: [RFC] git-brebase
Message-ID: <asFoDZKscLKqaIf+@ubby>
References: <asFRVdMTpshsazgM@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asFRVdMTpshsazgM@debian>

On Sat, Oct 03, 2026 at 10:11:47PM +0200, Alejandro Colomar wrote:
> We'll discuss the exact way it should be integrated within git(1), but
> first it'd be interesting to get feedback about the tool itself,
> regardless of the actual form.  Actually, because of the specialized
> flags --pre-exec and --post-exec, and the --first-parent flag from
> git-bisect(1) --and the fact that it runs git-bisect(1) machinery--, I'm
> not entirely sure that it should be just a new flag to git-rebase(1).
> It might be confusing to have these three flags being dependent on
> another flag, and not being able to use this within a git-bisect(1)

IMO that's not a problem at all.  There are a lot of Unix/Linux commands
that have flags that only make sense when used with other specific
flags.  So I still like a `--first-conflict` or `--onto-first-conflict`
option.

(I really like `--pre-exec` and `--post-exec`, BTW.)

> session, unlike other git-rebase(1) operations.  That might call for
> a new git command.

That might still be the case in that this will be such a useful tool
that it deserves a name.  But also, `git-rebase(1)` should always have
been this useful, so that argues for this to be either... a new option
like `--onto-first-conflict`, or even a new default behavior.

Does jj have a feature like this?  What do they call it?

> ---
> #!/bin/bash
> # Copyright 2026, Alejandro Colomar <alx@kernel.org>
> # SPDX-License-Identifier: GPL-3.0-or-later
> 
> set -Eeufo pipefail;
> shopt -s lastpipe;
> 
> err()
> {
> 	>&2 printf '%s\n' "$(basename "$0"): error: $*";
> 	exit 1;
> }
> 
> fp='';
> other='';
> pre='';
> post='';
> while test $# -ge 1; do

I normally use

  while getopts +:<short-options-here> opt; do ...

I also have a getopts_long-like function (see my gists) for bash if you
like.

> [...]
> 
> # Set up the callback script for 'git rebase run'.
> mktemp \
> | read -r callback;

I like to set a `trap` to remove temp files.

> cat >"$callback" <<__EOF__
> #!/bin/bash
> ...
> __EOF__
> chmod +x "$callback";

Here what might be better is to have a command-line option to execute
this callback without having to write it to a file, and use environment
variables to pass arguments to it.

> # Perform the conflicting rebase
> git switch "$branch";

Ah, that came from:

> git rev-parse --abbrev-ref HEAD \
> | read -r branch;

which means I can't use this in detached HEAD mode :(

I work in detached HEAD mode almost exclusively.  I know, that's..
weird.  But it works for me.  Can we avoid forcing the user to be on a
branch?

Nico
-- 
