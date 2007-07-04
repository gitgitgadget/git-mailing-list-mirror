From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch documentation: some more touch-ups.
Date: Wed, 04 Jul 2007 09:56:52 -0700
Message-ID: <7vhcokhzu3.fsf@assigned-by-dhcp.cox.net>
References: <20070703220540.GN12721@planck.djpig.de>
	<1183534367401-git-send-email-johannes.sixt@telecom.at>
	<Pine.LNX.4.64.0707041155110.4071@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Frank Lichtenheld <frank@lichtenheld.de>, j.sixt@eudaptics.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 18:57:04 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I68A1-0004d7-Es
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 18:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbXGDQ46 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 12:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753619AbXGDQ46
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 12:56:58 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:48636 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbXGDQ45 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 12:56:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070704165658.WYVP1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Jul 2007 12:56:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KUws1X00T1kojtg0000000; Wed, 04 Jul 2007 12:56:53 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51623>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 4 Jul 2007, Johannes Sixt wrote:
>
>> - The map function used to fail, but no longer does (since 3520e1e8687.)
>> - Fix the "edge-graft" example.
>> - Show the same using .git/info/grafts.
>> 
>> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
>> ---
>> 
>> I think that "edge-graft" makes more sense than "etch-graft".
>> Native speakers, please?
>
> I looked at dict.leo.org, and it does not know either version. Maybe it is 
> just "graft"?

Why even need a new term there, if you are not going to use it
elsewhere?  Instead of saying:

    -To "etch-graft" a commit to the revision history (set a commit to be
    +To "edge-graft" a commit to the revision history (set a commit to be
     the parent of the current initial commit and propagate that):

     ----------------------------------------------------------------------
     git filter-branch --parent-filter sed\ 's/^$/-p <graft-id>/' newbranch
     ----------------------------------------------------------------------


You could say:

	To set a commit to be the parent of the current initial
	commit and propagate that:

without inventing unfamiliar word that is not used anywhere else
in the documentation.

One thing that you may want to stress is that <graft-id> does
not represent a single commit, but the history that leads to it.
So "set a commit to be a parent" is technically correct, but it
is not "To edge-graft _a_ commit", but more like "Paste another
history behind the current beginning of time".

You have two filmstrips, the first frame of one filmstrip, your
current history, should logically follow the last frame of the
other filmstrip but they are separated into two.  You are
splicing them together to make a single, longer, filmstrip.
