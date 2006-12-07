X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Fast access git-rev-list output: some OS knowledge required
Date: Thu, 7 Dec 2006 15:53:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612071553090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550612061124jcd0d94em47793710866776e7@mail.gmail.com>
 <20061206192800.GC20320@spearce.org> <e5bfff550612061134r3725dcbu2ff2dd6284fcd651@mail.gmail.com>
 <20061206194258.GD20320@spearce.org> <20061206195142.GE20320@spearce.org>
 <45781639.1050208@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 7 Dec 2006 14:54:20 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45781639.1050208@op5.se>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33585>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsKdW-0001rE-Bq for gcvg-git@gmane.org; Thu, 07 Dec
 2006 15:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937967AbWLGOyF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 09:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937969AbWLGOyE
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 09:54:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:52181 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S937967AbWLGOyB
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 09:54:01 -0500
Received: (qmail invoked by alias); 07 Dec 2006 14:53:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp019) with SMTP; 07 Dec 2006 15:53:59 +0100
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 7 Dec 2006, Andreas Ericsson wrote:

> Shawn Pearce wrote:
> > 
> > Perhaps there is some fast IPC API supported by Qt that you could use 
> > to run the revision listing outside of the main UI process, to 
> > eliminate the bottlenecks you are seeing and remove the problems noted 
> > above?  One that doesn't involve reading from a pipe I mean...
> > 
> 
> Why not just fork() + exec() and read from the filedescriptor? You can 
> up the output buffer of the forked program to something suitable, which 
> means the OS will cache it for you until you copy it to a buffer in qgit 
> (i.e., read from the descriptor).

Could somebody remind me why different processes are needed? I thought 
that the revision machinery should be used directly, by linking to 
libgit.a...

Ciao,
Dscho
