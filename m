X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Possible BUG with git-rev-list --all in a StGit repository
Date: Tue, 28 Nov 2006 00:41:21 -0800
Message-ID: <7vd57855fy.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550611260827t686a5071w7f050f17f784e5d9@mail.gmail.com>
	<7v7ixit13h.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550611262231s3eac2d11ke9fcdb0d699093f0@mail.gmail.com>
	<e5bfff550611262238q60d466a3r230c9c4af283b76b@mail.gmail.com>
	<7vzmadl5b0.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550611272357w33756febud0bbbe59e2e1e140@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 08:41:39 +0000 (UTC)
Cc: catalin.marinas@gmail.com, "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <e5bfff550611272357w33756febud0bbbe59e2e1e140@mail.gmail.com>
	(Marco Costalba's message of "Tue, 28 Nov 2006 08:57:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32495>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoyWt-00013i-O6 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 09:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758590AbWK1IlX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 03:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757285AbWK1IlX
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 03:41:23 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:12273 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1758590AbWK1IlW
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 03:41:22 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061128084122.TKRN7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Tue, 28
 Nov 2006 03:41:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id s8hW1V00H1kojtg0000000; Tue, 28 Nov 2006
 03:41:31 -0500
To: "Marco Costalba" <mcostalba@gmail.com>
Sender: git-owner@vger.kernel.org

"Marco Costalba" <mcostalba@gmail.com> writes:

>> If you (as a Porcelain) want to get all refs under refs/heads/,
>> there are (unfortunately) two ways to get that list.  I would
>> suggest obtain the refs you want that way, pass them as command
>> line arguments to rev-list.
>
> Unfortunatly that does not work in case a branch and a tag have the same name.

I am not quite grokking what the problem you are trying to solve
is, so this is a shot in the dark, but

	git rev-list refs/heads/test refs/tags/test

to disambiguate, perhaps?
