From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Reformat "your branch has diverged..." lines to reduce
 line length.
Date: Wed, 16 Jul 2008 15:03:16 -0700
Message-ID: <7v3am9pjvf.fsf@gitster.siamese.dyndns.org>
References: <1216235967-9510-1-git-send-email-apenwarr@gmail.com>
 <7v4p6pr4ob.fsf@gitster.siamese.dyndns.org>
 <32541b130807161327k17f3a58ay5ab2da75963a2d50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 00:04:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJF6o-0008G6-Qs
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 00:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757079AbYGPWDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 18:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756877AbYGPWDZ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 18:03:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202AbYGPWDY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 18:03:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 828BC2F068;
	Wed, 16 Jul 2008 18:03:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 930352F066; Wed, 16 Jul 2008 18:03:18 -0400 (EDT)
In-Reply-To: <32541b130807161327k17f3a58ay5ab2da75963a2d50@mail.gmail.com>
 (Avery Pennarun's message of "Wed, 16 Jul 2008 16:27:15 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 01197DA8-5383-11DD-8824-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88768>

"Avery Pennarun" <apenwarr@gmail.com> writes:

>>         Your branch is ahead of 'origin/add-chickens2' by 21 commits.
>>
>>         Your branch is behind 'origin/add-chickens2' by 1 commit.
>>
>>         Your branch and 'origin/add-chickens2' have diverged, and have
>>         21 and 1 different commit(s) each, respectively.
>>
>>  I moved "respectively" so that the variable parts will come close to the
>>  beginning of physical line.
>
> Well, the fact that the number of commits is "variable" isn't so
> important, unless you start diverging by 1e9 commits or something :)

No, no, no.  The point is not about keeping it on screen when "less -S"
chops at the right end.  The point is to limit eye-movement of the user;
i.e. presenting important information consistently at around the same
column, closer to the left edge.  Probably the line break should be before
"and have" to make it even easier to read.

>>         Your branch and 'origin/add-chickens2' have diverged,
>>         and have 21 and 1 different commit(s) each, respectively.

> Alternatively, your rephrasing above made me think of the idea of just
> printing *both* of the first two messages in the "diverging" case.

I do not think it is such a good idea --- we invite silly comments like
"You say X is ahead of Y, and X is behind of Y, which is true?".

> Please let me know if you want me to resubmit the patch with your
> suggestions or whether you'll handle it.  I'm still a little vague on
> the exact patch approval process.

It is very much more "consensus building" than "approval", and at this
point we wait for a day or two to see if people come up with even better
alternatives.  Just be kind enough to prod me if I forget after a few
days, though ;-)
