From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confusion about diffing branches
Date: Mon, 27 Aug 2007 00:07:39 -0700
Message-ID: <7vlkbxmp50.fsf@gitster.siamese.dyndns.org>
References: <20070826233555.GA7422@mediacenter.austin.rr.com>
	<7v6431omn8.fsf@gitster.siamese.dyndns.org>
	<20070827014056.GB7422@mediacenter.austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 09:07:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPYhP-0007gS-4U
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 09:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbXH0HHn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 03:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbXH0HHn
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 03:07:43 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:57310 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbXH0HHl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 03:07:41 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070827070741.YNSB2916.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 27 Aug 2007 03:07:41 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id gv7g1X0031gtr5g0000000; Mon, 27 Aug 2007 03:07:40 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56769>

Shawn Bohrer <shawn.bohrer@gmail.com> writes:

> So if I understand you correctly people in the git world are simply more
> used to typing two dots (instead of three) so that is why the two dot
> notation shows the more common use case (show me the difference between
> the tip of the master branch and the tip of the topic branch).

No, what I said was that two dot form is merely there to avoid
saying 'if you want to diff two trees, do not say "diff a..b"
but say "diff a b", dummy!'.  Instead of giving such an error
message, we just say "oh, you want difference between a and b?
here it is".

As to which is common between "diff a..b" and "diff a...b", that
really depends.  You seem to be hinting that you think a...b is
more useful but that is not always the case.  Comparing two
arbitrary trees _is_ the base form of diff, and that is what
"diff a b" gives you.  It does not require two trees to be
related in ancestry relationships in _any_ way.  For example,
you can say "git diff v2.6.20 v2.6.21" or "git diff v2.6.20.4
v2.6.21.2".

On the other hand, when you are into topic branch development
workflow, "diff a...b" is often useful but that does not mean
people using topic branch development does not need "diff a b"
form.  You can say either "diff a b" if you want straight diff
between two trees, or "diff a...b" if you want "what happened in
b, since it forked from the history leading to a"; if the
two-dot form confuses you, you do not have to use that synonym.

Both semantics of two-dot form and three-dot form are useful,
and choice between the two depends on what you want out of the
command.  You just need to know which one you want.
