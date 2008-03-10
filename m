From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git checkout" branch switching safety broken in 'next'
Date: Mon, 10 Mar 2008 07:38:25 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803100735530.5896@woody.linux-foundation.org>
References: <7vmyp7j8ui.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 15:39:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYjAI-0003DD-PH
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 15:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbYCJOio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 10:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbYCJOin
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 10:38:43 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38087 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751256AbYCJOin (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2008 10:38:43 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2AEd4sj032743
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Mar 2008 07:39:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2AEcPrO021344;
	Mon, 10 Mar 2008 07:38:26 -0700
In-Reply-To: <7vmyp7j8ui.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.378 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76731>



On Mon, 10 Mar 2008, Junio C Hamano wrote:
>
> Linus, please be careful when switching branches if you are using your
> unpack_trees() patch (in 'next') for production.  There is a breakage that
> makes switching branches with "git checkout" lose your work-in-progress.

Ouch. I've been using those patches "in production" since posting them, 
but since I don't generally use branches on the kernel (it happens, but 
it's rare), I wouldn't have noticed.

And in git, it probably wouldn't have triggered for me, since it looks 
like it would only trigger for changes in subdirectories, not in the top 
level (which is probably also why it passed all the tests!).

My bad. Your patch looks obviously correct.

			Linus
