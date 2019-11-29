Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5400C432C3
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 09:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74ABF21721
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 09:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfK2J7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 04:59:15 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:35710 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfK2J7P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 04:59:15 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 06E9C1F463;
        Fri, 29 Nov 2019 09:59:14 +0000 (UTC)
Date:   Fri, 29 Nov 2019 09:59:13 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: recommend lore.kernel.org over public-inbox.org
Message-ID: <20191129095913.GA20216@dcvr>
References: <20191127125231.GH22221@sigill.intra.peff.net>
 <20191127125343.GA27983@sigill.intra.peff.net>
 <20191127125936.GA9877@dcvr>
 <nycvar.QRO.7.76.6.1911272059050.31080@tvgsbejvaqbjf.bet>
 <20191127200421.GA27456@dcvr>
 <nycvar.QRO.7.76.6.1911281123100.31080@tvgsbejvaqbjf.bet>
 <20191128194829.GA15521@dcvr>
 <nycvar.QRO.7.76.6.1911282315570.31080@tvgsbejvaqbjf.bet>
 <20191128223145.GA23772@dcvr>
 <nycvar.QRO.7.76.6.1911291029460.31080@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1911291029460.31080@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi Eric,
> 
> On Thu, 28 Nov 2019, Eric Wong wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > Hi Eric,
> > >
> > > On Thu, 28 Nov 2019, Eric Wong wrote:
> > >
> > > > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > >
> > > > > And: if I want to track the latest mails in GitGitGadget, what indication
> > > > > will I have that I'll need to switch to `.../1`?
> > > >
> > > > You can use the gzipped JSON grokmirror manifest at:
> > > > https://lore.kernel.org/git/manifest.js.gz
> > > >
> > > > grokmirror could be a bit of a pain to install because of Python
> > > > dependencies, so periodically attempting to clone the next
> > > > numbered epoch ought to be fine, too.
> > > >
> > > > I've also considered adding epoch info into
> > > > https://lore.kernel.org/git/_/text/config/raw
> > > > so shell scripters w/o JSON parsers can use "git config"
> > >
> > > I just had a look at its contents:
> > >
> > > -- snip --
> > > ; example public-inbox config snippet for "git"
> > > ; see public-inbox-config(5) manpage for more details:
> > > ; https://public-inbox.org/public-inbox-config.html
> > > [publicinbox "git"]
> > > 	inboxdir = /path/to/top-level-inbox
> > > 	; note: public-inbox before v1.2.0 used "mainrepo"
> > > 	; instead of "inboxdir", both remain supported after 1.2
> > > 	mainrepo = /path/to/top-level-inbox
> > > 	address = git@vger.kernel.org
> > > 	listid = git.vger.kernel.org
> > > 	filter = PublicInbox::Filter::Mirror
> > > 	newsgroup = org.kernel.vger.git
> > > 	nntpmirror = nntp://nntp.lore.kernel.org/org.kernel.vger.git
> > > -- snap --
> > >
> > > Isn't `inboxdir` and `mainrepo` incorrect?
> >
> > How so?  It's fine to have both in case users need to downgrade
> > to older versions of public-inbox.
> 
> I must have misinterpreted the purpose of this URL, then. I thought that
> was the configuration of _this_ instance, and that I could use the path
> indicated by `mainrepo` to replace the `/_/text/config/raw` part of the
> URL to get to the repo URL.
> 
> Is this just a template file, then?

It's a config snippet that can be copy+pasted into
~/.public-inbox/config and edited to suit the local machine
(but also human-readable and git-config(1)-parseable)

Both "mainrepo" and "inboxdir" refer to local paths, not URLs,
currently.  But it would be nice to access inboxes over WebDAV
or similar :>

> > > And yes, adding `epoch` information there would be very welcome.
> >
> > Noted.  Not sure if the "modified" and "fingerprint" keys of
> > manifest would make sense there, too...
> 
> I have no idea what purpose they serve, so I have no opinion on this
> question.

They're timestamps and checksums used to reduce the cost of
checking multiple repos for updates.  It's hugely beneficial
when there's 100s or 1000s of repos to mirror.  grokmirror only
makes one HTTP request to get manifest.js.gz, and only runs
fetches for ones that need updating.

It's a less useful for git@vger since there's only one epoch,
currently; and checking for the existence of a next one (1.git)
isn't that expensive.
