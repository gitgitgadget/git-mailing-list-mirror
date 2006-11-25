X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] get_shallow_commits: Avoid memory leak if a commit
 has been reached already.
Date: Sun, 26 Nov 2006 00:36:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611260033410.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87slg8uc0l.fsf@wine.dyndns.org> <ek9u4f$vmk$1@sea.gmane.org>
 <Pine.LNX.4.63.0611251947310.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wnr2twq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 25 Nov 2006 23:41:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v1wnr2twq.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go78o-0007Bs-HG for gcvg-git@gmane.org; Sun, 26 Nov
 2006 00:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935214AbWKYXky (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 18:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935216AbWKYXky
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 18:40:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:6024 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S935214AbWKYXkx (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 18:40:53 -0500
Received: (qmail invoked by alias); 25 Nov 2006 23:36:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp032) with SMTP; 26 Nov 2006 00:36:10 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Sat, 25 Nov 2006, Junio C Hamano wrote:

> I think you could pretend the commit->util field to be of some kind of 
> int and avoid the allocation altogether ;-).

I actually thought about that, and found it too dangerous. But of course, 
since we need at least a 32-bit architecture, chances are very high that a 
pointer is castable to an int.

Ciao,
Dscho
