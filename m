From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-remote: better handling of multiple remote HEADs
Date: Sat, 14 Feb 2009 11:48:34 -0800
Message-ID: <7vy6w8sstp.fsf@gitster.siamese.dyndns.org>
References: <20090214034345.GB24545@coredump.intra.peff.net>
 <1234607430-5403-1-git-send-email-jaysoffian@gmail.com>
 <20090214175420.GA3457@coredump.intra.peff.net>
 <76718490902141035o5430707ck47cd72d9efe87318@mail.gmail.com>
 <20090214185411.GA13121@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	barkalow@iabervon.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 14 20:50:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYQWj-0002FD-DX
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 20:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbZBNTsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 14:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbZBNTsq
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 14:48:46 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbZBNTsp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 14:48:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DDA9F9929A;
	Sat, 14 Feb 2009 14:48:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EE47E99299; Sat,
 14 Feb 2009 14:48:37 -0500 (EST)
In-Reply-To: <20090214185411.GA13121@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 14 Feb 2009 13:54:11 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7C6FC0C6-FAD0-11DD-9138-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109908>

Jeff King <peff@peff.net> writes:

> Which made me think of something else, with all of this talk about
> reviewers that has been going on. Junio is actually in a little bit of a
> special position with small changes (like style issues) to say "I'll
> apply this, but tweak these changes".

It is not that I am special.

What is special is an otherwise obviously good patch with a few trivial
mistakes that I can fix locally without worrying the fix-up may be wrong.
It is not even per author, it is per patch, and it is a rare exception.

Often, I notice these things *after* I applied and reviewed the results,
so it already is in my work area.  I then judge the tradeoff between an
extra round (which as you stated needs another fresh review, patch
application and testing here) and the possibility that I may make a silly
mistake myself while attempting a fix-up (such a mistake by me will not
be seen on the list and others do not have chance to catch them).

For this reason, I try to keep these "will fix up no need for resend" to
the minimum and only to the most trivial cases.

> ... But the rest of us are stuck
> saying "I would change this one line" to the list; then either:
>
>   - the original submitter re-rolls the patch, which takes their time
>     and everyone else's time to look at the new patch, see that it is
>     trivially changed, etc
>
>     or
>
>   - Junio has to read the followup comments, then go back and find the
>     spot in the original patch to mark it up.

A third option is:

	"I would change this and that" review comment message, followed by
	a separate message "Here is how I would have done it", addressed
	To: the original submitter (with in-body From: line), Cc: to the
	list and me.

The original submitter can verify the latter one, and either agree to or
disagree with it.  If the reroll is good, then I can just pick it up.  I
think you have done that in the past yourself, and the process made my
life a lot easier.
