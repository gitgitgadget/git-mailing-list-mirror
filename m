From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] allow setting GIT_WORK_TREE to "no work tree"
Date: Wed, 06 Feb 2008 12:59:32 -0800
Message-ID: <7vwsphu7gr.fsf@gitster.siamese.dyndns.org>
References: <20080206102608.GA1007@coredump.intra.peff.net>
	<47A98F07.4000402@viscovery.net>
	<20080206110131.GA4167@coredump.intra.peff.net>
	<7v4pclvmae.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 22:00:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMrNR-0006xx-3I
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 22:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757702AbYBFU7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 15:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758027AbYBFU7n
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 15:59:43 -0500
Received: from rune.pobox.com ([208.210.124.79]:52582 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756339AbYBFU7n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 15:59:43 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 9784E194598;
	Wed,  6 Feb 2008 16:00:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id BE2FC194563;
	Wed,  6 Feb 2008 15:59:57 -0500 (EST)
In-Reply-To: <7v4pclvmae.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 06 Feb 2008 12:54:01 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72854>

Junio C Hamano <gitster@pobox.com> writes:

>> The other option is setting
>>
>>   GIT_MAGICALLY_SET_GIT_DIR_SO_DONT_ACT_LIKE_THE_USER_DID=1
>>
>> but I was hoping to avoid that.
>
> Yuck.  Let's then try your original (slightly redundant) one.

Oops, scratch that.  I was confused.

I do not like the magic GIT_WORK_TREE=: which is simply
illogical.  GIT_EDITOR=: made perfect sense (":" is actually a
command that succeeds without doing anything), but ":" does not
have anything to do with "there is no such path".

I was tempted to suggest GIT_WORK_TREE=/dev/null because that is
what "diff" uses to mark "this does not even exist", but that
feels dirty.
