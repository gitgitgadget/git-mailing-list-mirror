From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document ls-files -t as obsolete.
Date: Wed, 14 Apr 2010 07:39:30 -0700
Message-ID: <7vaat6qesd.fsf@alter.siamese.dyndns.org>
References: <1271252704-21739-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Apr 14 16:39:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O23kl-0005fp-S1
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 16:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755785Ab0DNOji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 10:39:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755706Ab0DNOjh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 10:39:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 05454AA64E;
	Wed, 14 Apr 2010 10:39:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bIGpMr+fhzWY+8ncAOx4agnSQZo=; b=FW25n3
	DEee/gJxvAZ6AhTHduYeATHG2Kjsajq7KJ0Bm6+jCTzi7fhTixInGNKtquX0k+zH
	oOoEBBSgAaV07cJXviq+tiu2TqZ0TkhMIPgIiMes1j7VTdrLUXa1tk4iCVe6qo5B
	v7heGwTQ67MMqsFURtk4lw3JkKoxoS/kVTfeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ukvezmt2XHt0Dc/+/dNnMRZ8Wl6jO+Qk
	H7VLPMBLDSy8IC3fv0Er9DX9HIlXDgrQg/O0t0Y52j0k7une4Zehi8EjiM5SR+t9
	Xng8JEWKOvgG7wDy15Pm42F4ODk7ofLT7qOLg/PYRuKTm3ohaCdBPHmZghuw+xzF
	hnQedrmiqww=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C66C4AA64B;
	Wed, 14 Apr 2010 10:39:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 28245AA649; Wed, 14 Apr
 2010 10:39:31 -0400 (EDT)
In-Reply-To: <1271252704-21739-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Wed\, 14 Apr 2010 15\:45\:04 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8B75D47E-47D3-11DF-9318-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144877>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The behavior of "git ls-files -t" is very misleading (see
> http://thread.gmane.org/gmane.comp.version-control.git/126516 and
> http://thread.gmane.org/gmane.comp.version-control.git/144394/focus=144397
> for examples of mislead users) and badly documented, hence we point the
> users to superior alternatives.

I am no entirely happy with this patch.

If all your scripted Porcelain wants to see is "what are the paths I might
want to run 'git add' on?", you do not want to run diff twice (which is
what "status" does); you would say "ls-files -t -m -o --exclude-standard",
instead. The alternative is not even superiour in this case.

Having said that, I personally don't think of any other combination of
flags with which "ls-files -t" is useful.

If there are parts of the documentation that are misleading, perhaps that
is what your patch should be fixing instead, no?
