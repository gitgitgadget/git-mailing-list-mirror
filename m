From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 15/15] Replace "unset VAR" with "unset VAR;" in
 testsuite as per t/README
Date: Thu, 30 Sep 2010 09:09:58 -0700
Message-ID: <7v39srkyax.fsf@alter.siamese.dyndns.org>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-16-git-send-email-newren@gmail.com>
 <7viq1omiv8.fsf@alter.siamese.dyndns.org>
 <AANLkTimgTAerCNcSHBR9t-s-ThWHLMXdsb2T=E2w8gpB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 18:10:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1LiP-0000gh-0T
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 18:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182Ab0I3QKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 12:10:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925Ab0I3QKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 12:10:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BBC3BDAA1E;
	Thu, 30 Sep 2010 12:10:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NJr5R6qs+qqEAjS6zxek7X2EePo=; b=jy8IB5
	wJLtmysIfj/+RvrnYAimLLZOOqjDyJXhsJqIXm4ApG29tdujsQABgtJSyVuFPCRo
	/VKpnV4aN6oa/Tvzzl5twUEriH5EAa3YLQvN9caY9g1d3HWHSHbezYI6wxX8/y0C
	JvTVM/yDitBc4dVzw6x+OdySXeNfCBTBbkWUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XowmDXiUNKNKI/z/SCB1z/MmkmnhjKMF
	BQgBqsOEjRaYzahDHkIkdW50TC50xIf1db+u2r8UjKS5y3KyCQVG0yo1k3IdpjaB
	Ik+xhu8u5EKND8BOxbHQTcMyNt78+XsEoHvods1efNb54hNYiZJKgh091zQcG/QD
	TlR+lB/v7M4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 995D4DAA19;
	Thu, 30 Sep 2010 12:10:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC927DAA18; Thu, 30 Sep
 2010 12:10:00 -0400 (EDT)
In-Reply-To: <AANLkTimgTAerCNcSHBR9t-s-ThWHLMXdsb2T=E2w8gpB@mail.gmail.com>
 (Elijah Newren's message of "Wed\, 29 Sep 2010 14\:30\:19 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2F18E716-CCAD-11DF-A8AB-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157685>

Elijah Newren <newren@gmail.com> writes:

> They break the && cascades, but aren't the && cascades already
> inherently broken due to the unportable return value of unset?

Of course; that is the breakage you are trying to fix, no?  My comment was
that I understand you are trying to, but the patch is not actually fixing
it.

If anything, it is making it worse. Earlier we would have got a false
breakage that would make people notice and take a look. With your patch
applied, we instead would let a breakage in parts earlier than these
"unset VAR;" go unnoticed, no?
