From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v7 0/5] git checkout: optimise away lots of lstat()
 calls
Date: Tue, 13 Jan 2009 12:17:48 -0800
Message-ID: <7viqoj6jv7.fsf@gitster.siamese.dyndns.org>
References: <1231849748-8244-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Harlan <pgit@pcharlan.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Tue Jan 13 21:19:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMpjM-0005eG-El
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 21:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162AbZAMUR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 15:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755145AbZAMUR5
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 15:17:57 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057AbZAMUR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 15:17:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4E09F90514;
	Tue, 13 Jan 2009 15:17:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 33DB390511; Tue,
 13 Jan 2009 15:17:50 -0500 (EST)
In-Reply-To: <1231849748-8244-1-git-send-email-barvik@broadpark.no> (Kjetil
 Barvik's message of "Tue, 13 Jan 2009 13:29:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4325F360-E1AF-11DD-85E2-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105529>

Kjetil Barvik <barvik@broadpark.no> writes:

> Junio, I hope it is possible to use patches 1/5, 2/5 and 3/5 from this
> version instead of 1/3, 2/3 and 3/3 from version 6, for the possible
> future in origin/pu?  See also a) above.  Thanks in advance!
>
> In general, are we allowed to redesign the patch-series while the
> patches is inside origin/pu?

You won't be too far off if you thought of 'pu' branch nothing more than
my bookmarks into the list archive.  They are interesting enough to keep
an eye on their evolution but not yet stable enough to go into initial
round of wider testing and incremental development which starts to happen
when they hit 'next'.

So yes, while you are not yet confident that the series does not need
major redesign, please keep sending replacements (not incremental
updates), making it clear that you still have reservations and I'll keep
them in 'pu', until the initial barrage of "Oh, I think this way is
better", "The previous review comments were valuable, and this round
contains all of them" is over and things seem to stabilize into a testable
shape.

Personally I felt your v5 and later ones were already 'next' material, and
the only reason why the series haven't landed on 'next' was because you
kept sending updates before I sat down in the evening and said "Ok, this
looks good---let's merge it to 'next'".  Instead I ended up saying "Hmph,
I thought it looked good already but the author seems not satisfied yet;
there is another round of update to replace the previous one.  Let's queue
it in 'pu', as it may be updated again, and I have to also look at series
from other people.' ;-)
