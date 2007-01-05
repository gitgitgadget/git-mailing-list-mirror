From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Fri, 5 Jan 2007 13:57:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701051354590.3661@woody.osdl.org>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
 <204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com>
 <7v1wmalez6.fsf@assigned-by-dhcp.cox.net> <204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com>
 <7vbqldfg56.fsf@assigned-by-dhcp.cox.net> <204011cb0701051133r1ede14a6gd5093a3e7fa88cb5@mail.gmail.com>
 <20070105193958.GE8753@spearce.org> <7vtzz5duk1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Chris Lee <chris133@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 05 22:58:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2x4Y-0000bp-1x
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 22:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbXAEV5p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 16:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbXAEV5p
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 16:57:45 -0500
Received: from smtp.osdl.org ([65.172.181.24]:35781 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbXAEV5o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 16:57:44 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l05LvaWi010798
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 5 Jan 2007 13:57:37 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l05LvV5w001892;
	Fri, 5 Jan 2007 13:57:33 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vtzz5duk1.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.67 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36029>



On Fri, 5 Jan 2007, Junio C Hamano wrote:
> 
> Somehow we forgot to turn save_commit_buffer off while walking
> the reachable objects.  Releasing the memory for commit object
> data that we do not use matters for large projects (for example,
> about 90MB is saved while traversing linux-2.6 history).

Heh. Maybe we should just make the default the other way? It's probably 
pretty easy to find any users that suddenly start segfaulting ;)

(and just setting it in "cmd_log_init" would likely catch quite a number 
of them already).

		Linus
