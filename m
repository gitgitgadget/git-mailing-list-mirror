X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Colourise git-branch output
Date: Mon, 11 Dec 2006 14:47:06 -0800
Message-ID: <7vbqma1251.fsf@assigned-by-dhcp.cox.net>
References: <200612112210.08327.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 11 Dec 2006 22:47:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612112210.08327.andyparkins@gmail.com> (Andy Parkins's
	message of "Mon, 11 Dec 2006 22:10:08 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34047>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GttvV-0005SV-8i for gcvg-git@gmane.org; Mon, 11 Dec
 2006 23:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937712AbWLKWrJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 17:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937711AbWLKWrJ
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 17:47:09 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:43904 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937712AbWLKWrI (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006
 17:47:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061211224707.RENW20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Mon, 11
 Dec 2006 17:47:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id xanJ1V00S1kojtg0000000; Mon, 11 Dec 2006
 17:47:18 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> I wanted to have a visual indication of which branches are
> local and which are remote in git-branch -a output; however
> Junio was concerned that someone might be using the output in
> a script.  This patch addresses the problem by colouring the
> git-branch output - which in "auto" mode won't be activated.

Hmm.

"git branch --color" does not seem to work, so is this config
only?

> As yet, there is no support for changing the colors using the
> config file; but it wouldn't be hard to add.

I am not sure about that.  Would it be something like this?

	[branch.color]
        	remote = purple
                local = yellow

I wonder what would happen when you have a branch called
"color".  Would the above cause "git-fetch" to fetch from
"purple" remote by default?
