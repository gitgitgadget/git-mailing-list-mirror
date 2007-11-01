From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 01 Nov 2007 22:32:56 +0100
Message-ID: <200711012232.57286.johan@herland.net>
References: <20071022063222.GS14735@spearce.org>
 <916BE4AD-5BD9-48E6-8026-B1AC7387E28D@adacore.com>
 <7v4pg5btis.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Geert Bosch <bosch@adacore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 22:33:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InhfR-0001uw-1U
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693AbXKAVdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754690AbXKAVdK
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:33:10 -0400
Received: from smtp.getmail.no ([84.208.20.33]:53985 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754620AbXKAVdI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:33:08 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JQU00M0BJV7K600@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 01 Nov 2007 22:33:07 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JQU00AYFJUYFK80@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 01 Nov 2007 22:32:58 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JQU00GHMJUYOO00@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 01 Nov 2007 22:32:58 +0100 (CET)
In-reply-to: <7v4pg5btis.fsf@gitster.siamese.dyndns.org>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63011>

On Thursday 01 November 2007, Junio C Hamano wrote:
> Geert Bosch <bosch@adacore.com> writes:
> 
> > I often type "make clean" as well many "git xyz" commands
> > during development, and so it happens that at times, I type
> > "git clean" by accident.
> 
> Happened to me once.  I hate that command.
> 
> > So, I propose *not* converting git clean to a C builtin,
> > but instead adding --untracked and --ignored options to
> > git-rm.
> 
> I think what you are trying to do is to deprecate or remove "git
> clean".
> 
> I do not know where "git clean" came from.  I am suspecting that
> it was to give counterparts to some other SCMs, but do not know
> which ones.  Some people wanted to have it --- so you need to
> convince them that it is a bad idea first.  Adding an equivalent
> options to "git rm" alone does not solve that issue.

What about making "git clean" _stash_ your changes instead of deleting them 
(so that you can undo the clean)? Preferably they should be stashed 
somewhere _other_ than where "git stash" does its thing. "git clean" could 
even delete the stash immediately, but keep the reflog around so that 
the "clean" at least could be undone within 30 days (or whatever is the 
current default).

Thoughts?


Have fun! :)

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
