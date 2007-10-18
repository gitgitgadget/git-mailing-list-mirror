From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 20:32:58 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710172017020.26902@woody.linux-foundation.org>
References: <1192565900.6430.16.camel@athena>
 <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
 <20071017015109.303760cc@localhost.localdomain>
 <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
 <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
 <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
 <20071018003256.GA5062@coredump.intra.peff.net>
 <alpine.LFD.0.999.0710171753020.26902@woody.linux-foundation.org>
 <20071018024553.GA5186@coredump.intra.peff.net> <Pine.LNX.4.64.0710172002020.10276@asgard.lang.hm>
 <20071018030055.GA7218@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: david@lang.hm, Luke Lu <git@vicaya.com>,
	Christer Weinigel <christer@weinigel.se>,
	Tom Tobin <korpios@korpios.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 18 05:33:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiM8e-0006yB-IN
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 05:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761190AbXJRDdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 23:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761611AbXJRDdZ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 23:33:25 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49220 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761096AbXJRDdY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 23:33:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9I3X3kn016474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Oct 2007 20:33:04 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9I3WwKP022571;
	Wed, 17 Oct 2007 20:33:00 -0700
In-Reply-To: <20071018030055.GA7218@coredump.intra.peff.net>
X-Spam-Status: No, hits=-2.717 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61459>



On Wed, 17 Oct 2007, Jeff King wrote:
> 
> Yes, obviously. The people who advocate mixing really _are_ objectively
> wrong. But I was talking about all-spaces versus all-tabs.

If you really are all one-or-the-other, then everything is obviously fine, 
and spaces have somewhat stronger guarantees (I say "somewhat", because 
the line-up-guarantee of all-spaces is only guaranteed with fixed-width 
fonts, and hard-tab indents often look nicer in printouts, and are 
generally much more flexible in just how wide you make the indent *look*, 
ie hard-tabs at least *allow* people to see the indents in different 
ways, even if that will potentially mess up any alignment).

But some mixing is inevitable, and at least in UNIX, the tendency is for 
tabs, not spaces, by default, so tabs have a much higher chance of 
*staying* mostly tabs, while anybody who uses spaces pretty much *will* 
get tabs inserted by just about any programming editor that isn't set up 
for python.

So you always get _some_ amount of mixing, exactly because most editors 
won't show you the difference, and what people aren't aware of, they don't 
think about. There's no getting away from that, unless you actually 
enforce it with hooks (and in a distributed environment, even that isn't 
really going to fly, is it?).

And if you *do* decide to enforce it with hooks, you now have issues like 
the fact that some files mustn't do it (autoconvert tabs to spaces in a 
Makefile, and it just stops working!), and others have somewhat subtle 
issues forcing your converter to be somewhat knowledgeable (trivial 
example: strings that are spread across multiple lines in C..)

In general, if you do enforce it (which I personally think is not likely a 
good idea, but hey, it's up to the project), I'd *still* suggest going the 
way of enforcing hard-tabs, not spaces. As mentioned, space does matter, 
but hardtabs really are "friendlier", and if you're a vi user, you can do 
a :set tabstop=4 and if that's what you're used to, it will all look 
better to you.

In contrast, all-spaces just sucks. It really has no redeeming values.

		Linus
