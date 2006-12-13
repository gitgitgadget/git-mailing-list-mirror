X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: svn versus git
Date: Wed, 13 Dec 2006 15:45:02 -0800
Message-ID: <7vfybjbbsx.fsf@assigned-by-dhcp.cox.net>
References: <200612132200.41420.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 23:45:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612132200.41420.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 13 Dec 2006 22:00:37 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34261>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gudmf-0003A8-SP for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:45:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751662AbWLMXpG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWLMXpF
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:45:05 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:38689 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751662AbWLMXpE (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 18:45:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061213234503.LWQB7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Wed, 13
 Dec 2006 18:45:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id yPlE1V00t1kojtg0000000; Wed, 13 Dec 2006
 18:45:15 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> ...  The output of git-ls-tree is not user friendly; it
> requires some understanding of git internals.

ls-tree is not Porcelain and has right to expose the internals
by default.  "git ls-tree --name-only" could be aliased to give
"git ls" if you wanted to, but I wonder how often you would want
to run:

	svn list -r538

and for what purpose?

I often find myself doing

	git diff -r --name-status v1.3.0 HEAD

to check if a file was already in v1.3.0 version, and I could do
the same thing with

	git list v1.3.0 >/var/tmp/1
        git list HEAD >/var/tmp/2
        diff -u /var/tmp/[12]

but that certainly is awkward.

What do people use "svn list -r538" for and how often?  In other
words, when does it become necessary to get the full list of
paths in an arbitrary revision?

