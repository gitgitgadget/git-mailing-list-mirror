From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Better handling of local changes in 'gitk'?
Date: Thu, 12 Jul 2007 14:01:00 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707121356430.20061@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0707121214420.20061@woody.linux-foundation.org>
 <7vir8ptksi.fsf@assigned-by-dhcp.cox.net>
 <7vejjdtkl0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 23:02:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I95nK-0004KK-EK
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 23:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933610AbXGLVBr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 17:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933501AbXGLVBq
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 17:01:46 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45779 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933491AbXGLVBp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jul 2007 17:01:45 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6CL16l2022601
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 Jul 2007 14:01:07 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6CL10oO002326;
	Thu, 12 Jul 2007 14:01:00 -0700
In-Reply-To: <7vejjdtkl0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.614 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52335>



On Thu, 12 Jul 2007, Junio C Hamano wrote:
>
> I just meant that I agree with you that --cc between HEAD, index and the 
> working tree is a wonderful way to view the current state.

Heh. I wasn't thinking of --cc, and if seen as a combination diff, I think 
--combined would be better (we very much want to see *all* changes, not 
just the conflicting ones, no?).

I was literally meaning two separate diffs, as two separate commits. But 
yes, I do agree that it might be very interesting to make "git diff-index" 
know about --combined/--cc in addition to --cached.

> It might make sense to teach "git diff" itself to show this
> 3-way diff with a new option ("git diff --h-i-w").  The
> necessary machinery is already there to handle "git diff maint
> master next pu" (four trees!), and "git diff maint:Makefile
> master:Makefile next:Makefile" (three blobs).

Actually, I think that if you teach "git diff-index" about --combined and 
--cc, then you'll automatically get it when you just do "git diff HEAD". 
No?

		Linus
