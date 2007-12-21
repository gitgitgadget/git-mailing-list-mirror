From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-commit: add --verbatim to allow unstripped commit
 messages
Date: Thu, 20 Dec 2007 16:49:33 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712201645020.21557@woody.linux-foundation.org>
References: <20071220211835.GA3052@steel.home> <alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org> <20071220233324.GB3052@steel.home> <alpine.LFD.0.9999.0712201545450.21557@woody.linux-foundation.org> <20071221001449.GA10607@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Bj?rn Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 21 01:50:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5W5V-0002zc-Qi
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 01:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473AbXLUAtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 19:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754795AbXLUAtl
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 19:49:41 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54625 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753329AbXLUAtl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Dec 2007 19:49:41 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBL0nX60030923
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Dec 2007 16:49:34 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBL0nXwU021827;
	Thu, 20 Dec 2007 16:49:33 -0800
In-Reply-To: <20071221001449.GA10607@atjola.homenet>
X-Spam-Status: No, hits=-4.413 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_22,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69035>



On Fri, 21 Dec 2007, Bj?rn Steinbrink wrote:
> 
> Hm, this is a bit more intrusive, but should catch most cases.
> 
> At the top of the comments in the commit message template add:
> #GIT CUT HERE
> (And adjust the descriptive text)

Ouch. I'd personally hate to see something like that at the top and then 
have to save it. I always add my text to the top of the message, and all 
the pre-made messages for me are at the top (ie the kinds you get with 
"git commit --amend", where the top of the thing is the old message).

That said, I might well agree with this approach if we made the marker 
line be the *last* line of the message, ie make it be something that ends 
with (ignoring empty whitespace at the end, of course, since those are 
invisible in most editors):

	# Remove this line to keep all comment lines

or something like that.

That still keeps the question about whitespace cleanups. But if it's just 
about whitespace or no whitespace, then a simple "--verbatim" flag would 
work.

			Linus
