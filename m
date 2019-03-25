Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA5520248
	for <e@80x24.org>; Mon, 25 Mar 2019 14:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfCYOwG (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 10:52:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:35048 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726217AbfCYOwG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 10:52:06 -0400
Received: (qmail 350 invoked by uid 109); 25 Mar 2019 14:52:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Mar 2019 14:52:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8275 invoked by uid 111); 25 Mar 2019 14:52:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 25 Mar 2019 10:52:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2019 10:52:04 -0400
Date:   Mon, 25 Mar 2019 10:52:04 -0400
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
Subject: Re: How to disable docs when building Git from sources
Message-ID: <20190325145204.GB19929@sigill.intra.peff.net>
References: <CAH8yC8mDWpf0b3zykyvHRLLbYdmLB7hAk9LcsciB=dYhs4C=VA@mail.gmail.com>
 <27b99f79-7a6a-1205-b528-84fd81433e0e@kdbg.org>
 <CAH8yC8nheOmz0G_Pv3oCv03Se16-+Ynwse9xFRDqKf-x2b9Qkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8nheOmz0G_Pv3oCv03Se16-+Ynwse9xFRDqKf-x2b9Qkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 25, 2019 at 10:37:24AM -0400, Jeffrey Walton wrote:

> I used 'make -j 4 NO_GETTEXT=Yes' and I think that fixed the command
> line components. Or at least I did not see the error where I was
> previously seeing it.
> 
> I am seeing a similar issue now for the GUI components (assuming
> po2msg.sh is doing similar):
> 
> make -C git-gui  gitexecdir='/usr/local/libexec/git-core' all
> make[1]: Entering directory '/home/jwalton/Build-Scripts/git-2.21.0/git-gui'
> GITGUI_VERSION = 0.21.GITGUI
>     * new locations or Tcl/Tk interpreter
> tclsh po/po2msg.sh --statistics --tcl -l hu -d po/ po/hu.po
> tclsh po/po2msg.sh --statistics --tcl -l pt_pt -d po/ po/pt_pt.po
> make[1]: tclsh: Command not found
> make[1]: tclsh: Command not found

It looks like you don't have tcl at all. Try NO_TCLTK=Nope ?

-Peff
