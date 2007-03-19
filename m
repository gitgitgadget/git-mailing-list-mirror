From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Rename handling
Date: Mon, 19 Mar 2007 13:07:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703191259420.6730@woody.linux-foundation.org>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
 <45FED31B.8070307@midwinter.com> <alpine.LFD.0.83.0703191427140.18328@xanadu.home>
 <45FEE629.8030606@midwinter.com> <45FEE869.3040308@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, John Goerzen <jgoerzen@complete.org>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 21:10:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTOBo-0006cV-Cy
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 21:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbXCSUIu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 16:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753160AbXCSUIt
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 16:08:49 -0400
Received: from smtp.osdl.org ([65.172.181.24]:53246 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150AbXCSUIW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 16:08:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2JK7pcD005799
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 13:07:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2JK7kpm015915;
	Mon, 19 Mar 2007 12:07:48 -0800
In-Reply-To: <45FEE869.3040308@midwinter.com>
X-Spam-Status: No, hits=-0.482 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42662>



On Mon, 19 Mar 2007, Steven Grimm wrote:
> 
> Err, then I am *going* to consider it a failure of the tool.

Sure.

And then realize that nothing is perfect.

Git is just *closer* to perfect than any other SCM out there. That doesn't 
mean that you can never find cases where you consider it failed. It just 
means that it fails less than the alternatives.

To be perfect, an SCM would have to be able to infer a higher meaning. Who 
knows - maybe that will happen in a few centuries (or decades, but AI has 
not had a good track-record so far). 

Git tracks exactly the stuff that does *not* require it to infer higher 
meanings - purely data. I personally consider it one of gits greatest 
strengths: it never matters *how* you get to some state, or what tools you 
used (patches, imports from other SCM's, "git mv" with intelligent 
developers, "git mv" with total clutzes, "plain mv", random monkeys 
typing, whatever). Git tracks not "intent", but "hard data".

The fact that git then can use that unambiguous hard data to show you 
interesting patterns is a big deal. But you need to realize that it's an 
even *bigger* deal that git only traffics in hard data that leaves 
absolutely no room for mistakes.

Git simply doesn't *care* whether you applied a patch to create the 
rename, or whether you imported the series from a system that doesn't 
track renames, or whether you just forgot to do "git mv". You should be 
really really happy about that. 

Btw, the reason -M isn't on by default is not that it's more expensive in 
CPU-time (it is, but quite frankly, you will never really see that effect 
in practice). No, the real reason is that if you use "-M" and actually see 
renames, traditional tools no longer understand the patches. And sadly, 
there are still too many unwashed and ignorant people out there to make 
the default patch format be git-specific.

When the revolution comes, and we can shoot everybody who uses anything 
else, we'll turn -M on by default.  Don't despair, comrade!

		Linus
