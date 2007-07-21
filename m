From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Internationalization of git-gui
Date: Sat, 21 Jul 2007 15:36:37 -0700
Message-ID: <7vzm1ptmdm.fsf@assigned-by-dhcp.cox.net>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
	<200707210951.00210.stimming@tuhh.de>
	<20070721080338.GT32566@spearce.org>
	<200707211433.29318.stimming@tuhh.de>
	<Pine.LNX.4.64.0707211427190.14781@racer.site>
	<7vejj1v92b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707212208110.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Stimming <stimming@tuhh.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 22 00:36:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICNZ5-0006zU-N9
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 00:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbXGUWgj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 18:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbXGUWgj
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 18:36:39 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:35768 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbXGUWgi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 18:36:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070721223638.XVDS1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 21 Jul 2007 18:36:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SNcd1X0041kojtg0000000; Sat, 21 Jul 2007 18:36:37 -0400
In-Reply-To: <Pine.LNX.4.64.0707212208110.14781@racer.site> (Johannes
	Schindelin's message of "Sat, 21 Jul 2007 22:12:40 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53193>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Two questions and a half.
>> 
>>  - The above means git-gui-i18n.git's master is rebased.  Is
>>    that the intention?  IOW, people are supposed to work on it
>>    with fetch+rebase, not fetch+merge (= pull)?
>
> Okay, you have me there.  Usually I am the one saying "rebasing is bad".  
> So I'll refrain from that practice.  From now on, 'master' will _not_ be 
> rebased.  From time to time I will prepare 'for-shawn' branches, which are 
> "master rebased onto git-gui".

I did not mean to say "rebase is bad".  Quite the contrary.

Rebase is bad for a repository meant for public consumption of
the under-development-snapshot, like git.git's 'master' and
'next'.  For a repository like git-gui-i18n whose sole point is
to serve as a public gathering point of narrowly focused area of
development (only translation of messages), I actually think
"everybody fetches and rebases" workflow is perfectly fine, as
long as all participants understand what the expected workflows
are.  My comment was more about making it clear what the policy
is to its intended audience.

Rebasing git-gui-i18n to keep its history clean would eventually
allow you to merge it directly into git-gui.  But if you are not
aiming for that (and you said your plan is to cherry pick the
result, not to merge, which is fine), then rebasing would no buy
you anything, so I think it would be a reasonable and manageable
workflow to:

 - people fork from 'mob', push back to 'mob';

 - you 
   - build 'master' by cherry picking good bits from 'mob', and
   - do your own fixups and framework changes on 'master',
   - merge 'master' back to 'mob' to allow contributors to
     adjust their work on the updated 'master' by simply
     following 'mob',

 - and eventually clean-up 'master' to make it mergeable and/or
   applicable to git-gui itself.
