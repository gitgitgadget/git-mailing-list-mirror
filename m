From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-clone --reference problem?
Date: Sun, 23 Apr 2006 11:40:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604231137580.3701@g5.osdl.org>
References: <1145810080.16166.223.camel@shinybook.infradead.org>
 <Pine.LNX.4.64.0604231122490.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 23 20:41:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXjWJ-000361-4X
	for gcvg-git@gmane.org; Sun, 23 Apr 2006 20:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWDWSku (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 14:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWDWSku
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 14:40:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29403 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751440AbWDWSkt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Apr 2006 14:40:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3NIejtH015759
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 23 Apr 2006 11:40:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3NIei2W028293;
	Sun, 23 Apr 2006 11:40:44 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <Pine.LNX.4.64.0604231122490.3701@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19073>



On Sun, 23 Apr 2006, Linus Torvalds wrote:
>
> I also forget whether we decided that non-absolute paths were 
> relative to the $reference directory, or to the $reference/objects/ 
> directory.

Just checked. It should be relative to $reference/objects, and we should 
strip out lines that start with '#', since we allow comments.

Blah. That whole shell-thing is cerainly convenient for prototyping, but 
it would be wonderful if we had some enterprising young soul that rewrote 
these things in C and made them built-ins. It may be wasteful to use C for 
this, but it would make portability easier, and we have all those nice 
routines for validating and building alternate db lists already that do it 
right.

Oh, well.

		Linus
