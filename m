Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7325133DD
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ASE1ngWc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eju3Ri4D"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B139483
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 03:42:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 733521FEFD;
	Mon, 30 Oct 2023 10:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698662572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LoiEQViHrVsNINcA007EgN+FzFPHU66A3Z3M74ztcp8=;
	b=ASE1ngWcxJRfuOTBUJ1trAZ3NvwXNGD+klpZAtg7PLbtPC6Nq5VRbrKceFnamyZ9X8O9Nr
	uaTUiQJs+rXKq4iIRvmAOmmaSCzosrHbbhgJ0IkJF3sQuPFXEhgt9//g61aTyZTqd15B1n
	bBLQWzrJn04XAd99qamI/7SPCw5W1fY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698662572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LoiEQViHrVsNINcA007EgN+FzFPHU66A3Z3M74ztcp8=;
	b=eju3Ri4DRJLvqWNJAONFzn7WB8tI3gsSTa+74Nvc3UOUXuFiZK728/srSF6SvrKOHi9bdJ
	5LQua0/ap3Z+4MAA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 1EA9EA3E7B;
	Mon, 30 Oct 2023 10:42:52 +0000 (UTC)
Date: Mon, 30 Oct 2023 11:42:51 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jeff King <peff@peff.net>
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Alexander Mills <alexander.d.mills@gmail.com>, git@vger.kernel.org
Subject: Re: please add link / url to remote - when - git push
Message-ID: <20231030104251.GK6241@kitsune.suse.cz>
References: <CA+KyZp5mwGJ6YOvjKtfnDMDb9ci3vSq5KNUep6-8EfkHNaxREg@mail.gmail.com>
 <20231030063633.GA7451@tb-raspi4>
 <20231030085205.GF6241@kitsune.suse.cz>
 <20231030090626.GA84866@coredump.intra.peff.net>
 <20231030093023.GG6241@kitsune.suse.cz>
 <20231030093919.GF84866@coredump.intra.peff.net>
 <20231030094556.GI6241@kitsune.suse.cz>
 <20231030095401.GA848451@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231030095401.GA848451@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Oct 30, 2023 at 05:54:01AM -0400, Jeff King wrote:
> On Mon, Oct 30, 2023 at 10:45:56AM +0100, Michal Suchánek wrote:
> 
> > > Yes, this is a problem. Those messages are streamed out as we receive
> > > them from the server, and before we get any status report back. I don't
> > > think we'd want to buffer them, as they can be arbitrarily large (and
> > > may even be progress reports that are meant to be shown in real-time).
> > 
> > Not when the user asked to not show progress.
> 
> Sure, if you make the buffering behavior dependent on the presence of
> "-q". I guess that is not that hard to do, but it does increase the
> complexity of the code (you have both a streaming and a buffering code
> path).
> 
> Anyway, I am not all that convinced this is a fruitful path versus just
> fixing the server side. But if you want to look into writing a patch, go
> for it.

I will try to bug the forge upstream first.

Thanks

Michal
