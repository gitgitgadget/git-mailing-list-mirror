From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 15:23:23 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808011507430.6819@nehalem.linux-foundation.org>
References: <20080731194042.a1534b4d.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org> <20080801124550.26b9efc0.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
 <20080801131127.20b3acfd.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org> <20080801132415.0b0314e4.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org>
 <20080801135421.5ca0f6af.akpm@linux-foundation.org> <7vvdykqub6.fsf@gitster.siamese.dyndns.org> <20080801145804.85041bbd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:24:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP33I-0006um-2X
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 00:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099AbYHAWXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 18:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755937AbYHAWXs
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 18:23:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54914 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753109AbYHAWXr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 18:23:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71MNOE4011948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Aug 2008 15:23:25 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71MNNPb006831;
	Fri, 1 Aug 2008 15:23:23 -0700
In-Reply-To: <20080801145804.85041bbd.akpm@linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.411 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91111>



On Fri, 1 Aug 2008, Andrew Morton wrote:
> 
> I preserve the quotes (when present) in signoffs for this exact reason.

You must be one of the few ones. According to the RFC's, you should quote 
pretty much any punctuation mark, including "." itself. Which means that 
things like 

	Signed-off-by: David S. Miller <davem@davemloft.net>

should be quoted if they were email addresses.

That would be very irritating. 

It's even _more_ irritating for things like D'Souza (or Giuseppe D'Eliseo 
to take a real example from the kernel).  For David, we could just not use 
the "S." - for others, the special characters are very much part of the 
name. It would also be very irritating for important messages like

	Signed-off-by: Linus "I'm a moron" Torvalds <torvalds@osdl.org>

etc, where it sure as heck isn't a rfc2822-compliant email address.

So the thing is, "strict email format" is just very annoying. Git does 
know how to do (well, it _should_) it for "git send-email", but making the 
human-readable output ugly just because somebody might want to 
cut-and-paste it sounds really sad.

You could cut-and-paste just the stuff inside the angle branckets, though. 
That should work.

		Linus
