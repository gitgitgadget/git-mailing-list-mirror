X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git newbie problems
Date: Tue, 05 Dec 2006 17:35:33 -0800
Message-ID: <7v4ps9byca.fsf@assigned-by-dhcp.cox.net>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org>
	<457611B9.9020907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 01:36:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <457611B9.9020907@gmail.com> (Graham Percival's message of "Tue,
	05 Dec 2006 16:41:29 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33398>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrlhT-000490-5H for gcvg-git@gmane.org; Wed, 06 Dec
 2006 02:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759469AbWLFBff (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 20:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759481AbWLFBff
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 20:35:35 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:37903 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1759469AbWLFBff (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 20:35:35 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061206013534.LNBU9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Tue, 5
 Dec 2006 20:35:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vDbk1V00R1kojtg0000000; Tue, 05 Dec 2006
 20:35:44 -0500
To: Graham Percival <gpermus@gmail.com>
Sender: git-owner@vger.kernel.org

Graham Percival <gpermus@gmail.com> writes:

> Trying really trivial in-index merge...
> Documentation/user/advanced-notation.itely: needs merge
> fatal: you need to resolve your current index first

You got from a "git pull", which means you were already in
another merge (perhaps failed).  That is a no-no.

The error messages need to be cleaned up and be more helpful.
There is no question about it.

> Nope.
> Merging HEAD with c21d3f3e1c77722e50d994763442e6f994b03ac2
> Merging:
> 038b7fc Misc small updates (trying to make git work).
> c21d3f3 Merge branch 'master' of
> ssh+git://hanwen@git.sv.gnu.org/srv/git/lilypond
> found 1 common ancestor(s):
> 84219bb don't have input/templates/ any longer.
> fatal: Entry '.gitignore' would be overwritten by merge. Cannot merge.
> No merge strategy handled the merge.

So the question is what you did _before_ initiating this "git pull".

For new people, we recommend to:

 * make sure you were on a right branch (I think you are.  You
   are on your 'master' branch and may not even have any other
   branches, which is fine.)

 * make sure all your changes are committed.

before initiating a "git pull".  And after a conflicted "git
pull", if you choose to punt,

	$ git reset --hard

would take you back to the state before you started the pull.

> SUGGESTIONS
>
> The "tutorial introduction to git" looks like a nice document, but it
> assumes that you are in control of the project.  For users who aren't in
> control (ie me) this is a problem, because it starts me skimming.
> "Importing a project"... nah, that's not me.  "Merging branches"... I
> don't care; I'm going to shove everything into the main branch.  "Using
> git for collaboration"... hmm, maybe this is the stuff I need to read.
> But by this point, I've already skimmed through five screens of info, so
> I'm not reading very carefully.

Yes, git caters to too many classes of people.

I've heard people talk about "everyday" document as a good
table-of-contents, primarily because it first breaks down the
userbase into roles and talks about common commands for each
role of the user.  I am not in the position to judge the quality
of the document, though.
