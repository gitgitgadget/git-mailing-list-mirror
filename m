From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-send-pack SIGSEGV..
Date: Fri, 15 Jun 2007 10:26:43 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706151025490.14121@woody.linux-foundation.org>
References: <alpine.LFD.0.98.0706142124380.14121@woody.linux-foundation.org>
 <7vvedp935y.fsf@assigned-by-dhcp.pobox.com> <7vr6od92nj.fsf@assigned-by-dhcp.pobox.com>
 <Pine.LNX.4.64.0706150949300.5848@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jun 15 19:27:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzFZv-0001e5-JC
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 19:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbXFOR1R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 13:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbXFOR1R
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 13:27:17 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50818 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750932AbXFOR1R (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jun 2007 13:27:17 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5FHQnjG023890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 Jun 2007 10:26:50 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5FHQhAn024112;
	Fri, 15 Jun 2007 10:26:43 -0700
In-Reply-To: <Pine.LNX.4.64.0706150949300.5848@iabervon.org>
X-Spam-Status: No, hits=-2.546 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50273>



On Fri, 15 Jun 2007, Daniel Barkalow wrote:
> 
> Your analysis of the failure was right, though. I reproduced it, and this 
> fixes it for me:
> 
> --- cut here ---
> Author: Daniel Barkalow <barkalow@iabervon.org>
> Date:   Fri Jun 15 10:22:37 2007 -0400
> 
>     Fix pushing to a pattern with no dst
>     
>     Refspecs with no colons are left with no dst value, because they are
>     interepreted differently for fetch and push. For push, they mean to
>     reuse the src side. Fix this for patterns.
>     
>     Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

And in case anybody cares, I've also verified it, so here's an

	Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

in case Junio didn't already apply it.

		Linus
