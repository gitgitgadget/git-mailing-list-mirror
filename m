From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-diff not showing changes (corrupt repo?)
Date: Tue, 2 Oct 2007 20:44:01 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710022041340.3579@woody.linux-foundation.org>
References: <47029414.3080100@gmail.com> <7vbqbhl44h.fsf@gitster.siamese.dyndns.org>
 <470309D5.702@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>, Jeff King <peff@peff.net>
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 05:44:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcvA6-0000ZQ-A9
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 05:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbXJCDo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 23:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbXJCDo0
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 23:44:26 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40021 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750888AbXJCDoZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2007 23:44:25 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l933i2cW022835
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Oct 2007 20:44:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l933i166004009;
	Tue, 2 Oct 2007 20:44:02 -0700
In-Reply-To: <470309D5.702@gmail.com>
X-Spam-Status: No, hits=-2.749 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.46__
X-MIMEDefang-Filter: lf$Revision: 1.187 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59775>



On Tue, 2 Oct 2007, Dan Zwell wrote:
>
> I bisected twice to be sure, and have CC'd Martin Waitz on this (the issue is
> that some of my changes in a local repo are not being displayed by git-diff,
> either before or after they are committed, but git-status, git-whatchanged,
> and git-diff-tree all see that changes have been committed, and git-diff-files
> does see uncommitted changes).
> 
> e88ee2915493213ea0d0be64c542c090fefd4b33 is first bad commit

You most likely have a very buggy "less".

Try this:

	echo hello | less -FRSX

on the command line. Do you see the "hello"?

(The above is assuming you haven't set GIT_PAGER, PAGER or the LESS 
variables manually to something else)

		Linus
