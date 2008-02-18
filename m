From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] xdl_merge(): make XDL_MERGE_ZEALOUS output simpler
Date: Mon, 18 Feb 2008 00:35:57 -0800
Message-ID: <7vy79ir79u.fsf@gitster.siamese.dyndns.org>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com>
 <alpine.LFD.1.00.0802121544370.2920@woody.linux-foundation.org>
 <alpine.LSU.1.00.0802130003370.3870@racer.site>
 <alpine.LSU.1.00.0802130108060.3870@racer.site>
 <7v3arxzlke.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802131113360.30505@racer.site>
 <7vlk5mgm5y.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0802151012380.3066@woody.linux-foundation.org>
 <alpine.LSU.1.00.0802171816150.30505@racer.site>
 <alpine.LSU.1.00.0802171906590.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Voltage Spike <voltspike@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 09:37:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR1Uf-000656-Mx
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 09:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430AbYBRIgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 03:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754612AbYBRIgW
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 03:36:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48007 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754250AbYBRIgV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 03:36:21 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 549D878CE;
	Mon, 18 Feb 2008 03:36:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 77F2A78CD; Mon, 18 Feb 2008 03:36:10 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802171906590.30505@racer.site> (Johannes
 Schindelin's message of "Sun, 17 Feb 2008 19:07:19 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74243>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When a merge conflicts, there are often less than three common lines
> between two conflicting regions.
>
> Since a conflict takes up as many lines as are conflicting, plus three
> lines for the commit markers,  the output will be shorter (and thus,
> simpler) in this case, if the common lines will be merged into the
> conflicting regions.
>
> This patch merges up to three common lines into the conflicts.

I can give immediate positive feedback to this.

When I rebuilt "next" last night, I considered rebasing its
constituent branches while I was at it (I ended up not doing
that as I felt it was too much).

The tip of js/reflog-delete used to be at cb97cc9.  Rebasing
this on top of any recent master will give you unreadable
conflicts in t/t1410-reflog.sh, but with these two patches (but
the second one does not have chance to kick in for this
particular case) the result is quite obvious and much cleaner.
