From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 9 Jan 2007 16:54:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701091649510.3594@woody.osdl.org>
References: <87odphgfzz.wl%cworth@cworth.org> <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net>
 <20070108131735.GA2647@coredump.intra.peff.net> <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net>
 <20070109142130.GA10633@coredump.intra.peff.net> <7virffkick.fsf@assigned-by-dhcp.cox.net>
 <20070109213117.GB25012@fieldses.org> <7vy7obj07k.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701091539050.3594@woody.osdl.org> <7vd55nivx7.fsf@assigned-by-dhcp.cox.net>
 <20070110001822.GG30023@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 01:54:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Rja-0007MU-Bt
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbXAJAy1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbXAJAy1
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:54:27 -0500
Received: from smtp.osdl.org ([65.172.181.24]:59846 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932598AbXAJAy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:54:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0A0s3Wi026708
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 Jan 2007 16:54:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0A0s2bV020159;
	Tue, 9 Jan 2007 16:54:03 -0800
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070110001822.GG30023@spearce.org>
X-Spam-Status: No, hits=-2.666 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36448>



On Tue, 9 Jan 2007, Shawn O. Pearce wrote:
> 
> My point about reset --hard/--soft probably also needing this check
> still stands however.

Well, I disagree, if only because the whole _point_ of "git reset" is to 
leave some point behind. I use it all the time (well, often enough) as a 
"undo" operation, and it's fundamentally different than "git checkout" at 
least to my worldview.

When you do "git reset" you _expect_ state to be reset/dropped. But when 
just switching between branches, you don't.

(I realize that "git checkout filename/goes/here" has kind of mixed up 
"git reset" and "git checkout". The "git checkout filename" syntax 
basically resets the filename, and that confuses things a bit. So in the 
above, I really do talk about just "checking out a _commit_" and do a 
state switch, not a "check out a filename" and overwrite the old contents 
of that file).

		Linus
