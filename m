From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 08:32:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org>
References: <200704171041.46176.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 17:32:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdpfS-0007W3-UU
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 17:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474AbXDQPc1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 11:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754476AbXDQPc1
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 11:32:27 -0400
Received: from smtp.osdl.org ([65.172.181.24]:52217 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754474AbXDQPc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 11:32:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3HFWOTW006353
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Apr 2007 08:32:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3HFWNem032530;
	Tue, 17 Apr 2007 08:32:23 -0700
In-Reply-To: <200704171041.46176.andyparkins@gmail.com>
X-Spam-Status: No, hits=-0.964 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44780>



On Tue, 17 Apr 2007, Andy Parkins wrote:
> 
> Adding expansion is harder, as I have no clue which calls to make to find
> even the most basic information about an object; but I thought I'd get
> feedback before I expend that effort.

Adding expansion is not just "harder". It's basically impossible to do 
with any kind of performance.

Think "git checkout newbranch".

And think what we do about files (and whole subdirectories!) that haven't 
even changed. And finally, think about how important that optimization is 
in an SCM like git that supports branches.

I think you'll find that keyword expansion simply isn't acceptable.

But hey, you didn't believe me, so I'm happy you are trying to write the 
patches. Either you'll prove me wrong, or you'll realize just *how* broken 
the feature is.

(Yeah, "unexpansion" is easy. It's easy for all the same reasons CRLF is 
easy: it has no state!)

			Linus
