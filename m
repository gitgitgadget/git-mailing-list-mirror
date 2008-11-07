From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: multiple-commit cherry-pick?
Date: Fri, 7 Nov 2008 10:08:36 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811071004170.3468@nehalem.linux-foundation.org>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com> <20081106213711.GA4334@blimp.localdomain> <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org> <7vskq4gmf5.fsf@gitster.siamese.dyndns.org> <20081107071231.GA4063@blimp.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 19:10:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyVnF-0006OU-0w
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 19:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbYKGSJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 13:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbYKGSJ0
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 13:09:26 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55530 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751080AbYKGSJ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Nov 2008 13:09:26 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA7I8bmJ019233
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Nov 2008 10:08:38 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA7I8aQA032551;
	Fri, 7 Nov 2008 10:08:36 -0800
In-Reply-To: <20081107071231.GA4063@blimp.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.436 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100320>



On Fri, 7 Nov 2008, Alex Riesen wrote:
> 
> Does not work if there are ranges given :-/
> It'd be very nice to have: git show #c1..$c2 $c3 $c4 $c5..$c6

Yeah, we've very fundamentally never supported that. Not for show, but 
also not for anything else (ie "gitk a..b c..d" does _not_ give you two 
ranges).

It's easy to see why once you understand what 'a..b' really means (ie it 
just expands to '^a' and 'b'), and how it's not really a "range" operation 
as much as a set operation that interacts with all the other arguments 
too. But unless you're very aware of that, it can be surprising.

		Linus
