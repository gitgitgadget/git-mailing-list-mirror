X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use new .git/config for storing "origin" shortcut
 repository
Date: Sun, 26 Nov 2006 14:45:15 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611261437270.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <ekafpm@sea.gmane.org> <200611260003.31025.andyparkins@gmail.com>
 <Pine.LNX.4.63.0611260141390.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzmaeyie6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 26 Nov 2006 13:45:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vzmaeyie6.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32345>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoKK0-0001aa-59 for gcvg-git@gmane.org; Sun, 26 Nov
 2006 14:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935386AbWKZNpT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 08:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935388AbWKZNpT
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 08:45:19 -0500
Received: from mail.gmx.de ([213.165.64.20]:11428 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S935386AbWKZNpR (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 08:45:17 -0500
Received: (qmail invoked by alias); 26 Nov 2006 13:45:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp019) with SMTP; 26 Nov 2006 14:45:15 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Sat, 25 Nov 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This hunk is wrong: "git-repo-config remote.bla.fetch b" will _overwrite_ 
> > remoter.bla.fetch. To avoid that, you have to use "git repo-config 
> > remote.bla.fetch b ^$". (The last argument is a regular expression which 
> > has to be matched by the value-to-be-oreplaced.)
> 
> Yup, one of the joys of working the config file everybody seems to like 
> ;-).

The problem is: config files are ubiquitous, so you need not teach 
users about it. On the other hand, they are just key / value stores, i.e. 
reflecting a mapping. What we want here, is a multimapping, so we use the 
wrong tool.

But sometimes it is so much more pragmatic to just take off one shoe and 
put the darned nail back into the wall than to go to the shop, buy the 
hammer, go back, put the nail in, and try to sell the hammer via eBay.

BTW regarding your criticism of the config file: I agree that the write 
support of git-repo-config was quite brittle at the start. Which is my 
fault.

However, we had quite some flashing out bugs in the mean time, so I am 
quite confident in the tool. Of course, what with the recent addition of a 
user specific config file (which makes the name "repo-config" seem utterly 
wrong), there might be some dragons in the code.

So, it seems that the whole config writing code is a perfect opportunity 
for people wanting to audit source code!

Ciao,
Dscho

