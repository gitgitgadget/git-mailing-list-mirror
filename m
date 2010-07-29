From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Document -B<n>[/<m>], -M<n> and -C<n> variants of
 -B, -M and -C
Date: Thu, 29 Jul 2010 09:10:28 -0700
Message-ID: <7vk4oeuv4b.fsf@alter.siamese.dyndns.org>
References: <1280310239-16897-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Jul 29 18:10:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeVh9-0004Ko-CE
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 18:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758002Ab0G2QKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 12:10:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64654 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757999Ab0G2QKh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 12:10:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FDDCC975F;
	Thu, 29 Jul 2010 12:10:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=bLGsMsmFm8EAN5PR00brhoyWJ40=; b=AunxpF820VktQfcHNdRly4u
	SLrEz92KYhGBFNssGgx8k2wPNojDvw3unEEtV+Ltja6HMtv1diayBHwDTlVL5LWG
	jdmKg7n/OMWcNwnWsFJFc0VzaFVK6BHgklAX/BX8QTxWax6UDEpToNMzN0Cg00wx
	ss3uZCcmHbwyYwkWVPjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=RSG4hqcgVQ3A8nChiF/EcALNEmbtrsywDUgj1tWRAJr8q527Q
	2KrjR4sTqUOCajPUXgOFKDtnBAZ5nzNB7G8gJCVG/ByN4B/6ofl7qfKYoHc/UNyK
	waWCTDBct8mhRlxVdky0UFoVX8bfojX34LsXwCcLESaQsSsaGaPSc4ADNc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71EE3C975E;
	Thu, 29 Jul 2010 12:10:33 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7CB0C975C; Thu, 29 Jul
 2010 12:10:30 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D0DC3552-9B2B-11DF-9934-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152185>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> I'm not really happy with my description of -Bn/m, which I essentially
> took from eeaa46031479 (Junio, Jun 3 2005, diff: Update -B
> heuristics). Someone with better understanding of how it works can
> probably propose something better.

Your explanation for '<n>' being the same across -B/-M/-C is reasonable.
Explanation of '<m>' might want to clarify why it counts only the deletion
and to mention that "100-similarity != dissimilarity", but as the end-user
level documentation, these probably are unnecessary.

> +-B[<n>]::
> +-B<n>/<m>::
>  	Break complete rewrite changes into pairs of delete and create.
> +	If `n` is specified, it gives the threshold (as a percentage
> +	of changed lines) above which a change is considered as
> +	complete rewrite.  For example, `-B90%` means git will detect a
> +	rewrite if more than 90% of the lines have been modified. ...

I am fine with the use of word "lines" if it is clear that we are giving a
simplified explanation (white lie) to the readers, but the (dis)similarity
numbers don't have much to do with "lines".  I would of course be happier
if we can come up with a phrase that tells the readers that these numbers
range between 0-100%, and the larger the <n> is, the larger the extent of
change has to be for the filepair to be considered for -B/-M processing,
without use of word "lines".

Thanks.
