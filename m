Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B71C207D6
	for <e@80x24.org>; Thu,  4 May 2017 16:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754454AbdEDQhR (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 12:37:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57350 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753246AbdEDQhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 12:37:16 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 3FE72207D6;
        Thu,  4 May 2017 16:37:16 +0000 (UTC)
Date:   Thu, 4 May 2017 16:37:16 +0000
From:   Eric Wong <e@80x24.org>
To:     Ethan Clevenger <ethan@sternerstuffdesign.com>
Cc:     git@vger.kernel.org, Hiroshi Shirosaki <h.shirosaki@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug? git svn tag Authentication failed
Message-ID: <20170504163716.GA20370@starla>
References: <CAOY55trVg7CYqzp7vTxaeVnqvM7YKnys-+88DnDRc4nbmBEBAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOY55trVg7CYqzp7vTxaeVnqvM7YKnys-+88DnDRc4nbmBEBAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ethan Clevenger <ethan@sternerstuffdesign.com> wrote:
> Git version: 2.12.2.windows.2
> 
> `git svn tag 1.0` results in:

<snip>

Note, "git svn tag" uses the same backend code as "git svn branch",
and there was a recent fix for that in
commit e0688e9b28f2c5ff711460ee8b62077be5df2360
("git svn: fix authentication with 'branch'")

Looks like that change will be in 2.13 (it's in all the
release-canditates), but it should backported to 2.12.x

Junio: I think that commit should go into 'maint', too.  Thanks.

> In my .subversion directory I do have cached credentials under
> auth/svn.simple. A vanilla svn CLI commit also works:
> 
> >  svn ci -m 'do creds work?'
> > Adding         trunk\.bar
> > Transmitting file data .done
> > Committing transaction...
> > Committed revision 1651133.
> 
> 
> Unsure if this is actually a bug or my oversight.

Seems like a bug to me.  Can you try one of the 2.13 release
candidates to confirm?  Thanks.
