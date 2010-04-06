From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFD} Use regex's in :/ revision naming machinery
Date: Mon, 5 Apr 2010 19:15:05 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1004051911190.11318@i5.linux-foundation.org>
References: <alpine.LFD.2.00.1004051551180.21411@i5.linux-foundation.org> <7vr5mtl55q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 04:19:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyyNu-0006QL-H4
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 04:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757070Ab0DFCTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 22:19:17 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53133 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757058Ab0DFCTQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Apr 2010 22:19:16 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o362IkMF001417
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 Apr 2010 19:18:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o362IjbO022561;
	Mon, 5 Apr 2010 19:18:46 -0700
In-Reply-To: <7vr5mtl55q.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.45 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144085>



On Mon, 5 Apr 2010, Junio C Hamano wrote:
> 
> A related but a larger issue is that I suspect this "two-dot" would not
> work, as the syntax looks for "Merge branch 'slabh'.." (two-dot taken
> literally).

That part works. We do the dot-dot handling first. But:

> I also happen to think that the current ':/' is more or less useless
> because you cannot tell it to start digging from only these branches, and
> it becomes dice-throwing which commit it would find.

I do agree that :/ would be much better if it just started from HEAD, 
rather than from any branch. It doesn't matter too much for me, but that's 
because for the kernel I tend to have just one branch (with random 
occasional topic-branches, but since I do merging rather than real 
development, that's the rare case)

> Compared to these, I don't think anybody has much against using regex.  I
> personally am all for it, but I am not sure how much regex makes it more
> useful.

I have to admit that I never use it. The reason I did that silly patch is 
that today I thought that I _could_ use it, but then my naive

	gitk :/slabh..

thing didn't work, and I wondered why.

Would I actually use it more regularly if it was a regex? And if it had 
saner semantics wrt branches? I dunno. Maybe my try at using it today was 
the last time I'd ever try to use it again, regardless.

			Linus
