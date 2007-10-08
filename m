From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Clean up "git log" format with DIFF_FORMAT_NO_OUTPUT
Date: Mon, 8 Oct 2007 13:55:07 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710081353290.4964@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710081337490.4964@woody.linux-foundation.org
 > <alpine.LFD.0.999.0710081342530.4964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 22:56:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iezdl-00084H-2c
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 22:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbXJHUzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 16:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbXJHUzk
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 16:55:40 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54252 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751536AbXJHUzj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Oct 2007 16:55:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l98Kt7H7002614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Oct 2007 13:55:09 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l98Kt7QI019068;
	Mon, 8 Oct 2007 13:55:07 -0700
In-Reply-To: <alpine.LFD.0.999.0710081342530.4964@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.737 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60338>



On Mon, 8 Oct 2007, Linus Torvalds wrote:
> 
> This fixes an unnecessary empty line that we add to the log message when 
> we generate diffs, but don't actually end up printing any due to having 
> DIFF_FORMAT_NO_OUTPUT set.

Btw, this seems to break a few tests, where the test assumed the extra 
newlines at the end of commands like "git show -s" (which also triggered 
the extra unnecessary padding between commit text and the suppressed 
diff).

I think the patch is correct, but the tests obviously would need fixing 
before this patch should be applied.

		Linus
