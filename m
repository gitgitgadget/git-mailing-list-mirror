From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6/6] DWIM "git add remote ..."
Date: Wed, 5 Dec 2007 11:34:01 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712051129280.13796@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0712051858270.27959@racer.site> <Pine.LNX.4.64.0712051902510.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 05 20:36:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J002x-0007de-LE
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 20:36:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbXLETgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 14:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbXLETgT
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 14:36:19 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:56579 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752012AbXLETgS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Dec 2007 14:36:18 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB5JY2Hh032007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Dec 2007 11:34:03 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB5JY10I022118;
	Wed, 5 Dec 2007 11:34:01 -0800
In-Reply-To: <Pine.LNX.4.64.0712051902510.27959@racer.site>
X-Spam-Status: No, hits=-3.228 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67185>



On Wed, 5 Dec 2007, Johannes Schindelin wrote:
> 
> It is wrong to divert to "git remote add" when you typed the
> (more English) "git add remote".  But is it also pretty convenient.

Please don't do cute things like this. Suddenly "git add remote" has two 
different meanings depending on whether you have a file called "remote" or 
not. That is *not* ok.

Not to mention the fact that your patch is also a horrible piece of 
bug-infested shit, to put it less-than-politely. Namely, you now broke 
"git add remote" when "remote" is a symbolic link pointing to hyperspace.

But even if you fix that bug, it only goes to show just how misguided 
things like these are. It's a *lot* more important to make sense and not 
have surprising special cases, than to try to make git command lines act 
as if they were free-form English.

		Linus
