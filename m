From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Tue, 13 Mar 2007 18:20:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703131816360.9690@woody.linux-foundation.org>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
 <Pine.LNX.4.63.0703140201240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 14 02:21:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRIAn-0001Tn-5s
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 02:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbXCNBU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 21:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932723AbXCNBU6
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 21:20:58 -0400
Received: from smtp.osdl.org ([65.172.181.24]:47919 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932657AbXCNBU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 21:20:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2E1KoOb013184
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Mar 2007 18:20:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2E1KnBM014679;
	Tue, 13 Mar 2007 17:20:49 -0800
In-Reply-To: <Pine.LNX.4.63.0703140201240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-2.485 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42164>



On Wed, 14 Mar 2007, Johannes Schindelin wrote:
> 
> I am not convinced that this exit code (even if expected by experience) 
> makes sense. A diff should _only_ fail if anything goes _wrong_, not if 
> the files are _different. That is what cmp is for, no?

Well, "cmp" doesn't do a sane job for recursive diffs.

And Alex is certainly correct in stating that people historically expect 
and use the exit status of a regular "diff". I don't think there is any 
real down-side to making "git diff" have the same semantics, especially 
since the current exit-status isn't exactly useful.

			Linus
