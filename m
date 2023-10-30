Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280FD30D
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A142F135
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 02:45:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id F1EAC1FE4E;
	Mon, 30 Oct 2023 09:45:57 +0000 (UTC)
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 9A60CA3E6A;
	Mon, 30 Oct 2023 09:45:57 +0000 (UTC)
Date: Mon, 30 Oct 2023 10:45:56 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jeff King <peff@peff.net>
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Alexander Mills <alexander.d.mills@gmail.com>, git@vger.kernel.org
Subject: Re: please add link / url to remote - when - git push
Message-ID: <20231030094556.GI6241@kitsune.suse.cz>
References: <CA+KyZp5mwGJ6YOvjKtfnDMDb9ci3vSq5KNUep6-8EfkHNaxREg@mail.gmail.com>
 <20231030063633.GA7451@tb-raspi4>
 <20231030085205.GF6241@kitsune.suse.cz>
 <20231030090626.GA84866@coredump.intra.peff.net>
 <20231030093023.GG6241@kitsune.suse.cz>
 <20231030093919.GF84866@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231030093919.GF84866@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
	 TAGGED_RCPT(0.00)[];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: F1EAC1FE4E

On Mon, Oct 30, 2023 at 05:39:19AM -0400, Jeff King wrote:
> On Mon, Oct 30, 2023 at 10:30:23AM +0100, Michal Suchánek wrote:
> 
> > > > On the other hand, option to NOT display those remote messages is also
> > > > missing. At least with git 2.35 they are displayed even when -q argument
> > > > is given.
> > > 
> > > That is also up to GitHub to fix on the server side:
> > > 
> > >   https://lore.kernel.org/git/20230519090559.GA3515410@coredump.intra.peff.net/
> > 
> > If the server did not reject the push the messages it returns could be
> > considered informational.
> 
> Hmm, yeah, I could perhaps buy that line of argument. Though it's
> possible they are "warnings" of the sort that should still be emitted
> with "--quiet"; really only the server knows. And note that even "reject
> the push" is not necessarily all-or-nothing. The server may accept some
> subset of the refs.
> 
> But...
> 
> > Not sure if the final status of the push is available or of the
> > rejection is only noted in these messages, though.
> 
> Yes, this is a problem. Those messages are streamed out as we receive
> them from the server, and before we get any status report back. I don't
> think we'd want to buffer them, as they can be arbitrarily large (and
> may even be progress reports that are meant to be shown in real-time).

Not when the user asked to not show progress.

Thanks

Michal
