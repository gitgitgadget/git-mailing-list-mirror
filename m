From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Move "show_all_errors = 1" to
 setup_unpack_trees_porcelain()
Date: Thu, 02 Sep 2010 08:52:24 -0700
Message-ID: <7v8w3k2ldz.fsf@alter.siamese.dyndns.org>
References: <vpq39ttxumz.fsf@bauges.imag.fr>
 <1283428655-12680-4-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jim Meyering <jim@meyering.net>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Sep 02 17:53:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrC6O-0005y8-8u
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 17:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160Ab0IBPwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 11:52:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47026 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756133Ab0IBPwe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 11:52:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB558D29CF;
	Thu,  2 Sep 2010 11:52:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1VYwSkESW+D161b1zAWx/11fA1I=; b=UKTTQX
	69TUen+7iXc/mMQUdT9Y+Nm9Pu2EkhKjWeaimqJAkPVhT5QvfqjR14s7yiooRkCU
	S8VnA0u7aqnXCovVttP4+Fp8EVQ6+HjixdohvWB1fLtXuTT5VWFleFiS/Lj+ROgd
	zYPZXCuyZsDrZqyJqbX2maF97Q+HiGWYdByrY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oCaUCrzZRFjIJmDF6ASBSJXvqaytONT4
	0ipxLH2vSLfBpYIu57/feIGPJW1pbrwbuZQYI5icavw7KZzYWPAVRfnSYlQZt9w7
	EbbtP+7ZiN8ekrLedStX9Yakk3p2wbmerb07GD+cOwapkaqOkoJGTLAIEHif5XTk
	Oa0Fs3Baxr4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71E1AD29CE;
	Thu,  2 Sep 2010 11:52:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E2C9D29CD; Thu,  2 Sep
 2010 11:52:26 -0400 (EDT)
In-Reply-To: <1283428655-12680-4-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Thu\,  2 Sep 2010 13\:57\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 17C733CE-B6AA-11DF-A83E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155139>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Not only this makes the code clearer since setting up the porcelain error
> message is meant to work with show_all_errors, but this fixes a call to
> setup_unpack_trees_porcelain() in git_merge_trees() which did not set
> show_all_errors.
>
> add_rejected_path() used to double-check whether it was running in
> plumbing mode. This check was inefficient since it was setting
> show_all_errors too late for traverse_trees() to see it, and is made
> useless by this patch. Remove it.

Do you mean inefficient or ineffective?

The code in this patch looks fine, though.

Thanks.
