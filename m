From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form
 after-the-fact annotations on commits
Date: Mon, 28 May 2007 09:28:22 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705280924410.26602@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <200705271608.02122.johan@herland.net> <alpine.LFD.0.98.0705272131370.26602@woody.linux-foundation.org>
 <200705281254.23297.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 28 18:28:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hsi5P-0005bl-SS
	for gcvg-git@gmane.org; Mon, 28 May 2007 18:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761759AbXE1Q2f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 12:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762092AbXE1Q2f
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 12:28:35 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:47190 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761759AbXE1Q2e (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 May 2007 12:28:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4SGSN6S006362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 28 May 2007 09:28:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4SGSMiL016750;
	Mon, 28 May 2007 09:28:22 -0700
In-Reply-To: <200705281254.23297.johan@herland.net>
X-Spam-Status: No, hits=-3.023 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48622>



On Mon, 28 May 2007, Johan Herland wrote:
> 
> >  - This will probably scale horribly badly if you have tens of thousands 
> >    of notes, even when they are packed. Do we care?
> 
> I can't see why the current implementation would scale any worse than an
> equivalent number of (annotated/signed) tags. But then again, the tag
> system might not have been designed with tens of thousands of tag objects
> in mind. :)

Right. I was more thinking that this "notes" thing could potentially be a 
very useful thing for some random workflow - using notes to indicate that 
some commit has been vetted by somebody, for example (ie adding things 
like "Acked-by:" after-the-fact, which happens for the kernel).

And once you start using notes for something like that, I think you're 
going to end up with a set of notes that grows with history, and 
potentially grows quite quickly.

So I can see people having thousands of tags, but usually you only tag 
releases. In contrast, I can see notes being used not as a "per release" 
thing, but closer to a "per commit" thing. And that kind of worries me, I 
can see workflows where you end up having tons and tons of notes.

But hey, maybe I just worry unnecessarily.

		Linus
