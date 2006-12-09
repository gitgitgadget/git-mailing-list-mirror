X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Documentation/git-commit.txt
Date: Fri, 08 Dec 2006 20:25:24 -0800
Message-ID: <7vpsatelvv.fsf@assigned-by-dhcp.cox.net>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612082141260.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 04:25:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612082141260.2630@xanadu.home> (Nicolas Pitre's
	message of "Fri, 08 Dec 2006 21:58:14 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33797>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GstmM-0004nI-99 for gcvg-git@gmane.org; Sat, 09 Dec
 2006 05:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758356AbWLIEZ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 23:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758389AbWLIEZ0
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 23:25:26 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:56194 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1758356AbWLIEZZ (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 23:25:25 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061209042525.KROD97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Fri, 8 Dec
 2006 23:25:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id wUQo1V0081kojtg0000000; Fri, 08 Dec 2006
 23:24:48 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> Frankly I feel unconfortable with this.
>
> 1) too many examples.
>
> Yes, examples are good, but somehow there is something in the current 
> text that make me feel they are not providing the clarification they 
> should.  Dunno... I think I'd still push them after option list.

Hmmm.  I was merely trying to respond with recent requests on
the list (might have been #git log) to make common usage
examples more prominent.  While I feel that following the UNIXy
manpage tradition to push examples down is the right thing to
do, you and I are not the primary audience of Porcelain
manpages, so...

> 2) explanation of how to resolve and commit a conflicting merge should 
>    really be found in git-merge.txt not in git-commit.txt.
>
> It feels a bit awkward to suddenly start talking about git ls-files and 
> merge here.

I agree that it looks a bit out of place; the primary reason I
talked about the merge was to make it clear that a conflicted
merge will still stage the changes for cleanly auto-resolved
paths.  In other words, it makes me feel uneasy that there is no
mention of it in the list in your version that follows this
sentence:

> +... All changes
> +to be committed must be explicitly identified using one of the following
> +methods:

It would make me happier if you had, at the end of enumeration,
something like:

	Note that the contents of the paths that resolved
        cleanly by a conflicted merge are automatically staged
        for the next commit; you still need to explicitly
        identify what you want in the resulting commit using one
        of the above methods before concluding the merge.

Another reason I described the merge workflow is it would become
much less clear why --only is useless in merge situation if the
reader does not know that a conflicted merge stages the
auto-resolved changes.
