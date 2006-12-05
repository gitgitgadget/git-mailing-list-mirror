X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re: Moving a directory into another fails
Date: Tue, 5 Dec 2006 09:11:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612050908520.3542@woody.osdl.org>
References: <9e4733910607260800v618edf0em7b0f5c3332bf8fc5@mail.gmail.com>
 <20060726223459.GA30601@vsectoor.geht-ab-wie-schnitzel.de>
 <9e4733910607261603m6772602cr333d8c58f555edaa@mail.gmail.com>
 <20060728014350.GI13776@pasky.or.cz> <f3d7535d0612041019q4bda01a1k9938b056d51f8a78@mail.gmail.com>
 <el1qtr$bca$1@sea.gmane.org> <Pine.LNX.4.63.0612042001320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <el1rmm$bca$2@sea.gmane.org> <Pine.LNX.4.63.0612042009590.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612041114240.3476@woody.osdl.org>
 <Pine.LNX.4.63.0612042201420.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612041317480.3476@woody.osdl.org>
 <Pine.LNX.4.63.0612050831550.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 17:11:56 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612050831550.28348@wbgn013.biozentrum.uni-wuerzburg.de>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33357>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrdpZ-0008Jb-Pq for gcvg-git@gmane.org; Tue, 05 Dec
 2006 18:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968473AbWLERLn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 12:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968474AbWLERLm
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 12:11:42 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51055 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S968473AbWLERLm
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 12:11:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kB5HBaID010441
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 5
 Dec 2006 09:11:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kB5HBZsY004253; Tue, 5 Dec
 2006 09:11:35 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org



On Tue, 5 Dec 2006, Johannes Schindelin wrote:
> 
> On Mon, 4 Dec 2006, Linus Torvalds wrote:
> 
> > 	[core]
> > 		escapefilenames = true
> 
> I think this goes too far.

Sure., I agree that in _practice_ this isn't actually a problem, because 
people have long since learnt to avoid strange filenames in SCM's, simply 
because you can't get it right with insane filesystems.

That said, it might be a good idea to abstract out the create/read phase 
for filenames in the working tree regardless, since that also tends to be 
an area where other issues can come up (whoops - '/' vs '\' as the 
directory separator etc).

