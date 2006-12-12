X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-add --interactive (wip)
Date: Tue, 12 Dec 2006 23:15:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612122311400.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <360959.72234.qm@web31809.mail.mud.yahoo.com>
 <7vd56s8t9w.fsf@assigned-by-dhcp.cox.net> <7vslfm23co.fsf_-_@assigned-by-dhcp.cox.net>
 <200612111147.44964.Josef.Weidendorfer@gmx.de> <7vwt4wpytm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 22:16:05 +0000 (UTC)
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vwt4wpytm.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34151>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuFut-0002GZ-Fv for gcvg-git@gmane.org; Tue, 12 Dec
 2006 23:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932473AbWLLWQA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 17:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWLLWQA
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 17:16:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:44295 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932473AbWLLWP7
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 17:15:59 -0500
Received: (qmail invoked by alias); 12 Dec 2006 22:15:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp047) with SMTP; 12 Dec 2006 23:15:58 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 12 Dec 2006, Junio C Hamano wrote:

> I've updated my "git add --interactive" in 'pu' and it now knows how to 
> split a hunk into smaller pieces and recounting the diff offsets before 
> applying (Johannes pointed out that his partial commit script, entirely 
> written in bash using shell arrays, has a similar feature.  I guess I 
> should have stolen his code instead of lifting the logic from my own 
> abandoned porcelain).

Well, not completely true. I do not split hunks into subhunks.

Note that you _could_ split hunks at arbitrary lines; if it is a line 
common between the two files, it is easier though.

And you could not have ripped from my script: I make heavy use of bash 
arrays (in fact, I wrote this script partly to learn how to work with bash 
arrays). If I could think of a clean way to spawn processes piped into 
"less -FS" several times from a C program, I would already have rewritten 
it in C.

> So in short, I think per-hunk update-index is a cute hack and may be 
> useful in a narrow simple cases, but it would not be so useful in the 
> real life.

To the contrary! In spite of having written git-hunk-commit to please 
those poor souls coming from the darcs side, I already used it myself 
quite often! I think it is a killer feature.

Ciao,
Dscho
