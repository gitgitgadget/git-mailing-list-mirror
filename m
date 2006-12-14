X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 17:34:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612141732410.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612141340.43925.andyparkins@gmail.com>
 <200612141518.05770.andyparkins@gmail.com> <458171B7.1020702@xs4all.nl>
 <200612141620.17782.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 16:35:15 +0000 (UTC)
Cc: git@vger.kernel.org, hanwen@xs4all.nl
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612141620.17782.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34367>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GutY2-0008GJ-FG for gcvg-git@gmane.org; Thu, 14 Dec
 2006 17:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932865AbWLNQfD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 11:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932864AbWLNQfB
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 11:35:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:50659 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932860AbWLNQfA
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 11:35:00 -0500
Received: (qmail invoked by alias); 14 Dec 2006 16:34:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp006) with SMTP; 14 Dec 2006 17:34:58 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Andy Parkins wrote:

> On Thursday 2006 December 14 15:45, Han-Wen Nienhuys wrote:
> 
> > I just noticed that git-fetch now runs git-show-ref --verify on every
> > tag it encounters. This seems to slow down fetch over here.
> 
> There aren't any tags in this repository :-)

git-show-ref traverses every single _local_ tag when called. This is to 
overcome the problem that tags can be packed now, so a simple file 
existence check is not sufficient.

It would be much faster, probably, if you pack the local refs. IIRC I once 
argued for automatically packing refs (and all refs), but this has not 
been picked up, and I do not really care about it either.

Ciao,
Dscho
