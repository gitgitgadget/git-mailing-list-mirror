X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: Moving a directory into another fails
Date: Mon, 4 Dec 2006 22:05:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612042201420.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com>
 <20060726223459.GA30601@vsectoor.geht-ab-wie-schnitzel.de>
 <9e4733910607261603m6772602cr333d8c58f555edaa@mail.gmail.com>
 <20060728014350.GI13776@pasky.or.cz> <f3d7535d0612041019q4bda01a1k9938b056d51f8a78@mail.gmail.com>
 <el1qtr$bca$1@sea.gmane.org> <Pine.LNX.4.63.0612042001320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <el1rmm$bca$2@sea.gmane.org> <Pine.LNX.4.63.0612042009590.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612041114240.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 4 Dec 2006 21:05:24 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0612041114240.3476@woody.osdl.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33250>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrL05-0005eS-PQ for gcvg-git@gmane.org; Mon, 04 Dec
 2006 22:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937389AbWLDVFS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 16:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937392AbWLDVFS
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 16:05:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:38388 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S937389AbWLDVFP
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 16:05:15 -0500
Received: (qmail invoked by alias); 04 Dec 2006 21:05:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp031) with SMTP; 04 Dec 2006 22:05:13 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 4 Dec 2006, Linus Torvalds wrote:

> On Mon, 4 Dec 2006, Johannes Schindelin wrote:
> > 
> > On Mon, 4 Dec 2006, Jakub Narebski wrote:
> > 
> > > Johannes Schindelin wrote:
> > > 
> > > > On Mon, 4 Dec 2006, Jakub Narebski wrote:
> > > > 
> > > >> [...] git should acquire core.filesystemEncoding configuration variable 
> > > >> which would encode from filesystem encoding used in working directory 
> > > >> and perhaps index to UTF-8 encoding used in repository (in tree objects) 
> > > >> and perhaps index.
> > > > 
> > > > So, you want to pull in all thinkable encodings? Of course, you could rely 
> > > > on libiconv, adding yet another dependency to git. (Yes, I know, mailinfo 
> > > > uses it already. But I never use mailinfo, so I do not need libiconv.)
> > > 
> > > A conditional dependency. If you don't have libiconv, this feature wouldn't
> > > be available.
> > 
> > You are speaking as somebody compiling git from source. We are a minority.
> 
> You guys are ignoring the _real_ problem. 
> 
> It has nothing at all to do with dependencies on external packages. The 
> REAL problem is that if you do locale-dependent trees and other git 
> objects, git will STOP WORKING.

The issue was _not_ locale-dependent trees, but file systems which 
_change_ the encoding. And even then, Jakub's proposition reencoding could 
work, because it is an _encoding_ after all, i.e. bijective (reversable 
mapping for you non-Math guys). Not at all comparable to cases 
insensitivity, which _loses_ information.

But for reasons described in another mail, there are more fundamental 
problems with encodings, especially with MacOSX which (braindeadly) 
encodes _differently_ when writing and reading.

So, we reach the same conclusion, but for different reasons.

Ciao,
