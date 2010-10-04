From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Don't leak To: headers between patches
Date: Mon, 04 Oct 2010 00:11:58 -0700
Message-ID: <7v39sma0u9.fsf@alter.siamese.dyndns.org>
References: <a9b17bd454e57abb75f6cd2a7da63ec7738f5e7b.1286170305.git.viresh.kumar@st.com>
 <1286175924-15761-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Viresh Kumar <viresh.kumar@st.com>, git@vger.kernel.org,
	Joe Perches <joe@perches.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 09:12:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2fDb-0001L1-CY
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 09:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518Ab0JDHMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 03:12:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab0JDHMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 03:12:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E3A1FDBAF9;
	Mon,  4 Oct 2010 03:12:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TQyAcbCfDnQl+2fcLlqsq2apjw0=; b=SO6wUX
	2tdHLz2E1J+IUCG43U5Z4j5F4XUnyCS4So6EqvAOksNV4L+swrUkzdP4uLC4WEMj
	FWwh5iXb4hA2AB8LxQZbIsOvgvC0TAqEg9k+qL5JY9Dqctlo0Megmaj6Sb1zMwi/
	Oct4McfmGP7n2snUjMw4H3NLEYbmu/thtYEn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P6sMTOG4NreJzBx7tgdGtXJHpZiGAs6U
	XyC2uoM6Q23j8OvTb5LncjrsQSFHkFDaClSiBvaBM6KstE0Np5Mjaaeo5aLFszEO
	3FZEj3+t1K2lNhTYJu0mGG18491DpecCG4HivT2KO2fTwYy1bCe2M9bCVL9L7b4L
	LrxW2kZ8ZOs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A03E7DBAF8;
	Mon,  4 Oct 2010 03:12:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A535ADBAF2; Mon,  4 Oct
 2010 03:11:59 -0400 (EDT)
In-Reply-To: <1286175924-15761-1-git-send-email-bebarino@gmail.com> (Stephen
 Boyd's message of "Mon\,  4 Oct 2010 00\:05\:24 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B0FC2EF6-CF86-11DF-8265-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157995>

Stephen Boyd <bebarino@gmail.com> writes:

> Ah, I didn't think about this at all. Your patch doesn't look right though.
> Consider a user adding a --to argument on the command line. The first patch
> will be sent to the right place but the second one will be sent to nobody.
> Right?
>
> How about this instead? Based on sb/send-email-use-to-from-input. Junio,
> looks like this would also fix a similar situation with the to_cmd in
> next.

Yeah, I haven't applied nor run it, but your fix looks correct.  Thanks.
