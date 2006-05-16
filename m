From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix silly typo in new builtin grep
Date: Mon, 15 May 2006 20:32:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605152028050.3866@g5.osdl.org>
References: <Pine.LNX.4.64.0605151743360.3866@g5.osdl.org>
 <7vu07qfyj0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 05:32:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfqIT-0001fI-Ie
	for gcvg-git@gmane.org; Tue, 16 May 2006 05:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWEPDcW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 23:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWEPDcW
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 23:32:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51383 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751102AbWEPDcU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 23:32:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4G3WGtH008583
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 May 2006 20:32:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4G3WFtC026747;
	Mon, 15 May 2006 20:32:15 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu07qfyj0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20097>



On Mon, 15 May 2006, Junio C Hamano wrote:
> >
> > (In fact, I would say that doing the above command in just 4 seconds is 
> > damn impressive - it's a large code-base, and v2.6.13 is several months, 
> > and over 20 _thousand_ revisions ago).
> 
> That is a BS praise and you know it ;-).  You do not have delta
> chains that are 20k long, so grepping from the tree 10 revs ago
> and from the tree 20k revs ago would not make a difference.

Oh, I agree. I meant in a "general version-control sense". I doubt a lot 
of other version-control systems could do it. Git can, exactly because 
it's whole-file based, and our deltas are limited.

So it's not that "builtin-grep" is wonderful. It's that _git_ is
wonderful, and the builtin-grep just shows one of the end results.

That's why we have killer features. To show off.

(That said, git will slow down a tad too - the pack-file access won't be 
as optimized for an old version tree, and so you'll seek around some more 
for the cold-cache case).

		Linus
