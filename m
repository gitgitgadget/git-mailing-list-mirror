From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] test-lib: refactor $GIT_SKIP_TESTS matching
Date: Fri, 17 May 2013 10:22:38 -0700
Message-ID: <7vobc9zfkx.fsf@alter.siamese.dyndns.org>
References: <cover.1368736093.git.trast@inf.ethz.ch>
	<9b7e6a882a21b7e1734ec6fd90d3cf0208bb68f1.1368736093.git.trast@inf.ethz.ch>
	<5195C4B1.3010201@viscovery.net>
	<87y5beav7d.fsf@linux-k42r.v.cablecom.net>
	<7vfvxl1rj9.fsf@alter.siamese.dyndns.org>
	<87sj1lbkvm.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 17 19:22:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdOMf-0006a0-H9
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756398Ab3EQRWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 13:22:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49070 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756367Ab3EQRWk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 13:22:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AD601FD7B;
	Fri, 17 May 2013 17:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vf6wfy/mmpP9STqKjPlYwK78CH8=; b=Z7hKH4
	j4pxlC9WMO9u9YGE8PLfOMFckhIlB1G3XTfWoKYTeRQ5dlqcZQm8hPqD5F8iW7SU
	LQ77j8H9RIPr7pODKKmmnqJ8vz9d5ejJMDHW1ix9kEwrgnWJmb/SQnPzdT68GYeK
	rSLQQCP/n5dDyrrNmG6/szLx4emdCxbpjrgj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l2qhnopKFsbog8sAfAlPQIx4JFfI9dzo
	Ebho9lpN6W9xdqc9qffi2Fkn1hdyT7nNu+r0agORXPte33BCTTmiqaS8g9oiE8Ng
	52UtGCCl8mACqncLmhnDRPJ0L/q9e9nqHpTZK9KojgDs8D8K5nsmLGzF3oJLQ6+W
	qnCNW6vkbo8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31EA51FD7A;
	Fri, 17 May 2013 17:22:40 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC8C81FD79;
	Fri, 17 May 2013 17:22:39 +0000 (UTC)
In-Reply-To: <87sj1lbkvm.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Fri, 17 May 2013 19:02:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 601C1492-BF16-11E2-8050-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224715>

Thomas Rast <trast@inf.ethz.ch> writes:

> At this point the splitting has already happened in the caller when it
> does the (refactored)
>
> +	if match_pattern_list $this_test.$test_count $GIT_SKIP_TESTS
>
> So $@ and "$@" is actually the same thing.

Ah, then it is perfect.  Thanks.
