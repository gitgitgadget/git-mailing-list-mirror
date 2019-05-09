Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 901011F488
	for <e@80x24.org>; Thu,  9 May 2019 20:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfEIUOC (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 16:14:02 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41954 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfEIUOC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 16:14:02 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E2EE91F45F;
        Thu,  9 May 2019 20:14:01 +0000 (UTC)
Date:   Thu, 9 May 2019 20:14:01 +0000
From:   Eric Wong <e@80x24.org>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: Proposal: Remembering message IDs sent with git send-email
Message-ID: <20190509201401.mtinxj7wqjw6bvlg@dcvr>
References: <20190508231013.GA25216@homura.localdomain>
 <20190509001959.GB14000@google.com>
 <20190509165025.GA18342@homura.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509165025.GA18342@homura.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew DeVault <sir@cmpwn.com> wrote:
> --in-reply-to=ask doesn't exist, that's what I'm looking to add. This
> convenient storage mechanism is exactly what I'm talking about. Sorry
> for the confusion.

Using Net::NNTP to query NNTP servers using ->xover([recent-ish
range]) to scan for Message-IDs and Subjects matching the
current ident could be an option, too.

It could cache the xover result for --dry-run and format-patch
cases; and Net::NNTP is a standard Perl module.  Going online
to do this query also benefits people who work across different
machines/environments, as it's one less thing to sync.

Fwiw, this list has:
	nntp://news.gmane.org/gmane.comp.version-control.git
	nntp://news.public-inbox.org/inbox.comp.version-control.git

And there's a bunch of kernel lists at nntp://nntp.lore.kernel.org/
