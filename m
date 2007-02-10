From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Allow aliases to expand to shell commands
Date: Sat, 10 Feb 2007 10:04:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702101000100.8424@woody.linux-foundation.org>
References: <20070209014852.GA13207@thunk.org> <1171123504783-git-send-email-tytso@mit.edu>
 <11711235041527-git-send-email-tytso@mit.edu> <11711235042388-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Feb 10 19:04:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFwam-0007GC-Nk
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 19:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbXBJSEx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 13:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbXBJSEx
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 13:04:53 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53569 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbXBJSEw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 13:04:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1AI4mUI020293
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 10 Feb 2007 10:04:48 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1AI4lQp018316;
	Sat, 10 Feb 2007 10:04:47 -0800
In-Reply-To: <11711235042388-git-send-email-tytso@mit.edu>
X-Spam-Status: No, hits=-2.433 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.116__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39249>



On Sat, 10 Feb 2007, Theodore Ts'o wrote:
>
> If the alias expansion is prefixed with an exclamation point, treat
> it as a shell command which is run using system(3).

ACK. This should also make it possible to do pipelines etc as aliases, 
although to be *really* useful we would probably have to have some way to 
specify where the arguments to the alias would go.

The more generic solution is obviously to just do it as external shell 
scripts (which can be named "git-xyzzy" so that you don't even need this 
kind of thing), but for the simple cases like gitk/qgit/xmerge/whatever, 
this approach by Ted seems to be a good way to get easy access to stuff 
that doesn't need anything fancier..

			Linus
