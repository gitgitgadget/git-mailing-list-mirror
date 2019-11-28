Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D048C432C3
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 22:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EB221787
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 22:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfK1Wbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 17:31:46 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:57276 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfK1Wbq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 17:31:46 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id A9F7D1F463;
        Thu, 28 Nov 2019 22:31:45 +0000 (UTC)
Date:   Thu, 28 Nov 2019 22:31:45 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: recommend lore.kernel.org over public-inbox.org
Message-ID: <20191128223145.GA23772@dcvr>
References: <20191127125231.GH22221@sigill.intra.peff.net>
 <20191127125343.GA27983@sigill.intra.peff.net>
 <20191127125936.GA9877@dcvr>
 <nycvar.QRO.7.76.6.1911272059050.31080@tvgsbejvaqbjf.bet>
 <20191127200421.GA27456@dcvr>
 <nycvar.QRO.7.76.6.1911281123100.31080@tvgsbejvaqbjf.bet>
 <20191128194829.GA15521@dcvr>
 <nycvar.QRO.7.76.6.1911282315570.31080@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1911282315570.31080@tvgsbejvaqbjf.bet>
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
> >
> > > And: if I want to track the latest mails in GitGitGadget, what indication
> > > will I have that I'll need to switch to `.../1`?
> >
> > You can use the gzipped JSON grokmirror manifest at:
> > https://lore.kernel.org/git/manifest.js.gz
> >
> > grokmirror could be a bit of a pain to install because of Python
> > dependencies, so periodically attempting to clone the next
> > numbered epoch ought to be fine, too.
> >
> > I've also considered adding epoch info into
> > https://lore.kernel.org/git/_/text/config/raw
> > so shell scripters w/o JSON parsers can use "git config"
> 
> I just had a look at its contents:
> 
> -- snip --
> ; example public-inbox config snippet for "git"
> ; see public-inbox-config(5) manpage for more details:
> ; https://public-inbox.org/public-inbox-config.html
> [publicinbox "git"]
> 	inboxdir = /path/to/top-level-inbox
> 	; note: public-inbox before v1.2.0 used "mainrepo"
> 	; instead of "inboxdir", both remain supported after 1.2
> 	mainrepo = /path/to/top-level-inbox
> 	address = git@vger.kernel.org
> 	listid = git.vger.kernel.org
> 	filter = PublicInbox::Filter::Mirror
> 	newsgroup = org.kernel.vger.git
> 	nntpmirror = nntp://nntp.lore.kernel.org/org.kernel.vger.git
> -- snap --
> 
> Isn't `inboxdir` and `mainrepo` incorrect?

How so?  It's fine to have both in case users need to downgrade
to older versions of public-inbox.

> And yes, adding `epoch` information there would be very welcome.

Noted.  Not sure if the "modified" and "fingerprint" keys of
manifest would make sense there, too...
