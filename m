From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: squelch warning due to comparing undefined
 $_ to ""
Date: Wed, 20 Feb 2008 10:37:29 -0800
Message-ID: <7vmypv5v9y.fsf@gitster.siamese.dyndns.org>
References: <1203486907-12304-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 19:38:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRtpe-00086b-AH
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 19:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbYBTShj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 13:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbYBTShi
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 13:37:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbYBTShh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 13:37:37 -0500
Received: from .pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F00342A5;
	Wed, 20 Feb 2008 13:37:36 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 8F22F42A2; Wed, 20 Feb 2008 13:37:32 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74533>

Jay Soffian <jaysoffian@gmail.com> writes:

> The check to see if initial_reply_to is defined was also comparing $_ to
> "" for a reason I cannot ascertain (looking at the commit which made the
> change didn't provide enlightenment), but if $_ is undefined, perl
> generates a warning.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
> Junio, the commit which introduced the change was yours, but I don't
> see why you were comparing $_ to "". 

I think it was meant to check for $initial_reply_to being empty
(i.e. not compare $_ but the variable), but even if that is the
case I do not think the check would make a difference.

So the patch looks good.  Thanks.
