From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git apply vs. renamed files index mismatch
Date: Mon, 08 Sep 2008 17:53:41 -0700
Message-ID: <7vej3ucf6y.fsf@gitster.siamese.dyndns.org>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
 <1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
 <48C57A92.6060608@freescale.com>
 <20080908212717.GA21338@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Wood <scottwood@freescale.com>,
	Becky Bruce <becky.bruce@freescale.com>,
	linuxppc-dev@ozlabs.org, git@vger.kernel.org
To: avorontsov@ru.mvista.com
X-From: git-owner@vger.kernel.org Tue Sep 09 02:55:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcrVa-0004hZ-DH
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 02:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811AbYIIAx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 20:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754224AbYIIAx6
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 20:53:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbYIIAx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 20:53:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9A29679487;
	Mon,  8 Sep 2008 20:53:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4EC4379484; Mon,  8 Sep 2008 20:53:43 -0400 (EDT)
In-Reply-To: <20080908212717.GA21338@oksana.dev.rtsoft.ru> (Anton Vorontsov's
 message of "Tue, 9 Sep 2008 01:27:17 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C7FFBFDA-7E09-11DD-A993-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95323>

Anton Vorontsov <avorontsov@ru.mvista.com> writes:

>>>  3 files changed, 201 insertions(+), 201 deletions(-)
>>>  create mode 100644 arch/powerpc/kernel/dma.c
>>>  delete mode 100644 arch/powerpc/kernel/dma_64.c
>>
>> Passing -M to git format-patch makes it much easier
>
> I always thought that posting "-M" patches to the public lists is
> discouraged since it is quite difficult to apply them via patch(1).
> Also think of non-git users...

My understanding has been that it is encouraged on the kernel mailing
list, because the rename format is far easier to review by showing the
differences that matter to reviewers, than showing a big chunk of text
deleted and another big chunk of text that is similar added elsewhere.

I won't comment on this any further; the use of it is strictly a list and
community policy issue.

> This is still possible by comparing the hashes:
> ...
> That is, if hashes match then it was pure rename.
>
> Though, too bad git {apply,am} does not produce any warnings if there
> are any hidden changes...

But I _do_ want to know what you mean by this comment.  Your statement
makes it sounds as if apply/am happily and silently accept "hidden
changes" and it is a bad thing.

Now what do you exactly mean by "any hidden changes"?  Do you mean "the
sender did not use renaming format, the patch you fed was a one that
removes a huge chunk of text from one file, and adds a similarly huge
chunk of text to another file.  The changes to these files looked similar
but was not quite the same"?  It is all there for you to review, and
especially if you prefer non-renaming format, then that is what you get.
So I do not think that is what you are complaining about.  It must be
something else --- what is it?
