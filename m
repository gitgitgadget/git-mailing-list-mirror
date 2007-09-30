From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A tour of git: the basics (and notes on some unfriendly messages)
Date: Sun, 30 Sep 2007 03:17:25 -0700
Message-ID: <7vr6kgh2yy.fsf@gitster.siamese.dyndns.org>
References: <87ir5us82a.wl%cworth@cworth.org>
	<20070929000056.GZ3099@spearce.org>
	<E5C688F2-4A8D-402A-9757-5007BE4A8B25@zib.de>
	<7vlkapjeir.fsf@gitster.siamese.dyndns.org>
	<E8851B12-AAA5-4B4D-9F28-C5AB5AEF0E57@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Carl Worth <cworth@cworth.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Sep 30 12:17:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibvro-00027p-PC
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 12:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbXI3KRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 06:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752935AbXI3KRd
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 06:17:33 -0400
Received: from rune.pobox.com ([208.210.124.79]:51562 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190AbXI3KRc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 06:17:32 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 8067B13EBC7;
	Sun, 30 Sep 2007 06:17:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id C883413EBC3;
	Sun, 30 Sep 2007 06:17:48 -0400 (EDT)
In-Reply-To: <E8851B12-AAA5-4B4D-9F28-C5AB5AEF0E57@zib.de> (Steffen Prohaska's
	message of "Sun, 30 Sep 2007 10:15:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59532>

Steffen Prohaska <prohaska@zib.de> writes:

> ... If everything's ok I do.
>
>    git checkout master
>    git merge for/master
>    git push
>
> The last merge must be a fast forward.

Last week I saw somebody (I think it was Shawn) mentioned a
trick:

	git push . thisbranch:thatbranch

will moves thatbranch to thisbranch iff thisbranch is a
descendant of thatbranch.  So doing

	git push . for-master:master

instead of that checkout + merge command sequence would
obviously be a good solution for your particular use case.

Having said that it may make sense to swap the order so that the
diffstat is shown first and then a single line "Merge made by
recursive" or "Updatting A..B, Fast Forward" concludes the
report.  At least, I do not think such a swapping would hurt the
usability, although people used to the UI may first feel uneasy.
I would not object to such a patch in principle.
