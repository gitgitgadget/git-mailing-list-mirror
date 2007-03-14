From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Tue, 13 Mar 2007 18:13:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703131757080.9690@woody.linux-foundation.org>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 02:14:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRI45-0006at-Fv
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 02:14:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbXCNBNX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 21:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbXCNBNW
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 21:13:22 -0400
Received: from smtp.osdl.org ([65.172.181.24]:47804 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683AbXCNBNV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 21:13:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2E1DDOb012965
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Mar 2007 18:13:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2E1DCMn014515;
	Tue, 13 Mar 2007 17:13:13 -0800
In-Reply-To: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
X-Spam-Status: No, hits=-2.484 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42162>



On Wed, 14 Mar 2007, Alex Riesen wrote:
>
> This introduces a new command-line option: --exit-code. The diff
> programs will return 1 for differences, return 0 for equality, and
> something else for errors.

I don't think you should need a new command-line option.

Is there any reason to not just do this unconditionally?

> As promised on irc. I'm somewhat confused about diff_tree: it used to
> unconditionally return 0, yet every caller of it saves and passes the
> value!

I think we just never implemented the error codes, but they were always 
meant to be there.

I also thought I did some early-out logic (for the revision list pruning 
thing), where the "show_entry()" routine could return a negative value to 
say "Ok, no need to do anything more" but apparently I never added that..

[ I have this very distinct memory of working on it, but either I was 
  dreaming or I never got it working.. ]

			Linus
