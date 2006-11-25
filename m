X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: git-format-patch little gripe
Date: Sat, 25 Nov 2006 10:30:33 -0500
Message-ID: <BAYC1-PASMTP115161C7958A05B82E52A9AEE00@CEZ.ICE>
References: <376237.14965.qm@web31805.mail.mud.yahoo.com>
	<20061103185026.GA28566@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 25 Nov 2006 15:31:09 +0000 (UTC)
Cc: Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061125103033.2ea742d3.seanlkml@sympatico.ca>
In-Reply-To: <20061103185026.GA28566@coredump.intra.peff.net>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 25 Nov 2006 15:40:21.0421 (UTC) FILETIME=[0430DDD0:01C710A8]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnzUF-00084L-EH for gcvg-git@gmane.org; Sat, 25 Nov
 2006 16:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966639AbWKYPag (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 10:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757893AbWKYPag
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 10:30:36 -0500
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:25332 "EHLO
 BAYC1-PASMTP11.CEZ.ICE") by vger.kernel.org with ESMTP id S1757794AbWKYPaf
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 10:30:35 -0500
Received: from linux1.attic.local ([65.93.43.74]) by BAYC1-PASMTP11.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Sat, 25 Nov
 2006 07:40:21 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GnyY4-0006M2-BL; Sat, 25 Nov 2006 09:30:32 -0500
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

On Fri, 3 Nov 2006 13:50:26 -0500
Jeff King <peff@peff.net> wrote:

> For my own workflow, I don't want to have to pick the commit out of
> rev-list (or log) output. I want to find it and hit a button to say "OK,
> now mail this patch." So I put _all_ of my patches into an mbox, and
> then browse them with mutt. Sort of a poor man's patch browser, but then
> I'm ready to jump into mailing them immediately.
> 
> I use the following script:
> 
> #!/bin/sh
> root=${1:-origin}
> git-format-patch -s --stdout $root >.mbox
> mutt -f .mbox
> rm -f .mbox

If your mail setup support imap, the patches can be dumped directly into
it rather than having to go through an mbox.  For instance you can have
something like this in your ~/.gitconfig:

[imap]
   Host = imap.server.com
   Folder = "Drafts"
   User = uname
   Pass = password

And then the above command line becomes:

git-format-patch -s --stdout $root | git-imap-send

To move all the patches into your imap drafts folder to be accessed
by whatever email client you use.

Sean
