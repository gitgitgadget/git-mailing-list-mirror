From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-revert: Revert revert message to old behaviour
Date: Fri, 23 Mar 2007 09:27:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703230926380.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703230805450.6730@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703231705150.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 23 17:28:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUmcd-0003ca-7p
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 17:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbXCWQ2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 12:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752060AbXCWQ2F
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 12:28:05 -0400
Received: from smtp.osdl.org ([65.172.181.24]:55743 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbXCWQ2E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 12:28:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2NGRs1o023898
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 23 Mar 2007 09:27:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2NGRs5T019091;
	Fri, 23 Mar 2007 09:27:54 -0700
In-Reply-To: <Pine.LNX.4.63.0703231705150.4045@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-2.467 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42948>



On Fri, 23 Mar 2007, Johannes Schindelin wrote:
> 
> When converting from the shell script, based on a misreading of the
> sed invocation, the builtin included the abbreviated commit name,
> and did _not_ include the quotes around the oneline message.
> 
> This fixes it.

How about the empty line in between the message and the "This reverts 
commit "..

> +		add_to_msg("Revert \"");
>  		add_to_msg(oneline);
> -		add_to_msg("\nThis reverts commit ");
> +		add_to_msg("\"\nThis reverts commit ");

This should probably be

	add_to_msg("\"\n\nThis reverts commit ");

with *two* \n's, no?

		Linus
