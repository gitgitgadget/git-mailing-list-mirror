X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: lockfiles & fork()
Date: Sat, 28 Oct 2006 03:21:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610280319250.26682@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sat, 28 Oct 2006 01:23:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30355>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdctM-00010o-BA for gcvg-git@gmane.org; Sat, 28 Oct
 2006 03:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751532AbWJ1BVl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 21:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWJ1BVl
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 21:21:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:25493 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1751507AbWJ1BVl (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 21:21:41 -0400
Received: (qmail invoked by alias); 28 Oct 2006 01:21:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp033) with SMTP; 28 Oct 2006 03:21:39 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

when you setup a lockfile, and then fork(), you could easily end up with 
atexit() kicking in to remove the lockfile, before the main process has a 
chance to commit. (Yes, I need to hold the lock long before the fork()).

Any ideas how to solve the problem?

Ciao,
Dscho
