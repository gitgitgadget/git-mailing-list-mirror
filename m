From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/2] ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
Date: Fri, 05 Feb 2016 14:20:49 -0800
Message-ID: <xmqqwpqibxz2.fsf@gitster.mtv.corp.google.com>
References: <1454707746-18672-1-git-send-email-alonid@gmail.com>
	<1454707746-18672-3-git-send-email-alonid@gmail.com>
	<20160205214832.GA10052@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dan Aloni <alonid@gmail.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 23:20:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRokJ-00072P-K1
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 23:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbcBEWUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 17:20:52 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54226 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752062AbcBEWUv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 17:20:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C5A1E41509;
	Fri,  5 Feb 2016 17:20:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YPId8Dh9NLJrsmmuKvmPRpLlcXg=; b=S0L8Tq
	uQ8nBlwvlDRxnpx7kcYCyBqJmo3UirmDP8A3wN3CuO14haTLSmjd0xNT5ncDa//5
	D3GnVbJqnvBLv5lxPnjT3hONbCzewDzqppBRtcXa05DMGWGMutcu50WE+z/3OHlF
	1f2cFays5XRGuG4fWO/fhRFjfIVqpM6Dw4YOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vBjnl53RRFF+kyq1sLd+0rDsPgUKZ2oR
	Sr++lh5l8/Tej4XAb9vh0kBCHbDNTTqS27GXcb4jbwNiU49qcB6pxJ1X+DEMSK6Y
	COGUMFv28egqBJaV33fJSha1Fbdh+esaaQlJVVmisvpMjMwgBpgs9Wc1Djbe9BUV
	hjuMP+2aNbQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BC8AB41508;
	Fri,  5 Feb 2016 17:20:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3E5E541507;
	Fri,  5 Feb 2016 17:20:50 -0500 (EST)
In-Reply-To: <20160205214832.GA10052@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 5 Feb 2016 16:48:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B65138C4-CC56-11E5-B384-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285645>

Jeff King <peff@peff.net> writes:

> This is sort-of about "commit", which would put it in the t75xx range.
> But in some ways, it is even more fundamental than that. We don't seem
> to have a lot of tests for ident stuff. The closest is the strict ident
> stuff in t0007.

Good point.

>> +reprepare () {
>> +	git reset --hard initial
>> +}
>
> Do we need this reprepare stuff at all now? The tests don't care which
> commit we're at when they start.

Ah, I thought the function was needed to make sure we have something
to commit, but I agree that you do not need it, if you are going to
use "commit --allow-empty" in the tests.

> So all together, maybe:

Sounds sensible.

Thanks.
