From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/6] receive-pack: Send internal errors over side-band #2
Date: Tue, 09 Feb 2010 23:23:30 -0800
Message-ID: <7vwryleeq5.fsf@alter.siamese.dyndns.org>
References: <1265767290-25863-1-git-send-email-spearce@spearce.org>
 <1265767290-25863-2-git-send-email-spearce@spearce.org>
 <4B725CB1.1080908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 08:23:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf6vL-0002e7-N5
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 08:23:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480Ab0BJHXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 02:23:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab0BJHXl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 02:23:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 725D598347;
	Wed, 10 Feb 2010 02:23:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dKgU0VGB8KvKHAVDtPbEWIEiPrU=; b=BLCEau
	M822DJ3uIcqpHhPbzHlq6j7I+XhPKPev8JI48ZYr4byE2kJ5X1+y3v195Fx6eTzC
	mWW1bbYj1o4aA0WD71s4BL5r0WlLesBHJ2w/OnDdQ3iV05tXXSGSmyH+140tpusC
	QmuefEFTd3B/teRLbGB7QwVCUbS+kndRbkNYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kpz3SYnHTR8PclHyYgZmXI9/6nQG/oMi
	1paVK4YnutumOBFL7xoEcakpnmR71CS882pbMU46ufCfaU2WpFQnfCUk/9P1E2dC
	oM3OqPwVBKJdrt7Ae/QLMPmgwro21wzdg2wRawkjZD8ulkto3r5pHFak3S7/Xnlm
	xSKWhi2Oj5I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A23A98344;
	Wed, 10 Feb 2010 02:23:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E4E098343; Wed, 10 Feb
 2010 02:23:32 -0500 (EST)
In-Reply-To: <4B725CB1.1080908@viscovery.net> (Johannes Sixt's message of
 "Wed\, 10 Feb 2010 08\:13\:53 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 33B54A98-1615-11DF-BA0E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139497>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Looks like we need set_report_routine().
>
> Or did you replace only selected error() and warning() calls by rp_error()
> and rp_warning()?

That actually sounds like a good suggestion.
