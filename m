From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] cherry-pick/revert: add support for
 -X/--strategy-option
Date: Fri, 10 Dec 2010 18:29:15 -0800
Message-ID: <7vvd319h50.fsf@alter.siamese.dyndns.org>
References: <20101211005144.GA6634@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Justin Frankel <justin@cockos.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Kevin Ballard <kevin@sb.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 11 03:29:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRFDU-0000ra-4V
	for gcvg-git-2@lo.gmane.org; Sat, 11 Dec 2010 03:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676Ab0LKC3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 21:29:38 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab0LKC3h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 21:29:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 768762DCE;
	Fri, 10 Dec 2010 21:29:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+GeU1jOH256SkYB3x/WRuuiiQ5Q=; b=bzHO/j
	5UrUYyO1iSBLYSKLZAj01LcZJyUUWA5TxaV4IJnqqSlZp3S7utdB5ldGN9OPUzfN
	bTSPHerQWv26FcEkDVYv81ONKfwAi17G3qF/VEMiaERCDgowXAM2pq2WU/55mQhB
	kEpjjNvb1efSWlfHamFfWMZAc/UUg/32Y2kyU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kglp7EEOE16j7fcxsIzkta3IUKzGRvMN
	NeNzp3YMsv7OyHUXhPErfVgkv0M0sCx9Y5xehXOc/s4G7JZo17hlaKDItU8M9IHp
	+S++R6ASJ+0lDROOMBoYQwkePrqETTIX10//KB/7Ts4CRpSGRB482DILeOjBQ564
	oo7SM+3bdlI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 05EC12DCA;
	Fri, 10 Dec 2010 21:29:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1C60E2DC4; Fri, 10 Dec 2010
 21:29:41 -0500 (EST)
In-Reply-To: <20101211005144.GA6634@burratino> (Jonathan Nieder's message of
 "Fri\, 10 Dec 2010 18\:51\:44 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 87D64822-04CE-11E0-B991-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163456>

Jonathan Nieder <jrnieder@gmail.com> writes:

> For example, this would allow cherry-picking or reverting patches from
> a piece of history with a different end-of-line style, like so:
>
> 	$ git revert -Xrenormalize old-problematic-commit
>
> Currently that is possible with manual use of merge-recursive but the
> cherry-pick/revert porcelain does not expose the functionality.
>
> While at it, document the existing support for --strategy.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Thoughts?

I guess this can also take "ignore whitespace", which might be a better
option for this particular use case?
