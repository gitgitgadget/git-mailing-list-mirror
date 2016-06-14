From: Junio C Hamano <gitster@pobox.com>
Subject: Re: compactionHeuristic=true is not used by interactive staging
Date: Tue, 14 Jun 2016 14:45:27 -0700
Message-ID: <xmqq37of8mx4.fsf@gitster.mtv.corp.google.com>
References: <CAEtHF9Na7yppEzuutp5=98KjLucgq=7Xv9GPidhaYEuC0oeqQQ@mail.gmail.com>
	<20160614214211.GB21560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alex =?utf-8?Q?Preng=C3=A8re?= <alexprengere@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 23:45:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCw9P-00036z-HZ
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 23:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbcFNVpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 17:45:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751817AbcFNVpa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 17:45:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A69DA22547;
	Tue, 14 Jun 2016 17:45:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cLY/b4nScIQdgEoy+t9EKh9knig=; b=Bdsb/N
	r/45vEJh8uDewDhm5lkQ8bcXY/SqMlpupIgkpIpv4vq1RjdfPmyhrDNRnL6I8maM
	mKRVtq1Mn7s0gt4hyIOBlghWVfKc4pYDPAZPWTWRRy3WsBMQT2+xVzS0SR1BwkWj
	hVbl7SG6XkQCqOCUAuurjKslwCrJEUrFFKqAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a9W1ket+RowGjUe+lhnREX+DwMSYfCbE
	+Q4uvkO1loIsENy0uEfAuXCquStVd8PoAvxrBuhia9xk6AqHWvTHVQiFrulIikt2
	Q7GA8b3iBPhpvCT+UQaHo9pXPH4KSlpBQjxNA2w6vlB42lGJSUAlgfwXOSvF05Bq
	rv9kPjoE3JA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DF6322546;
	Tue, 14 Jun 2016 17:45:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 29BBC22544;
	Tue, 14 Jun 2016 17:45:29 -0400 (EDT)
In-Reply-To: <20160614214211.GB21560@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 14 Jun 2016 17:42:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4FC06FBA-3279-11E6-9F47-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297337>

Jeff King <peff@peff.net> writes:

> Nobody noticed so far because originally the compaction heuristic was on
> by default, and so just worked everywhere. But we backed off on that at
> the last minute after finding a few cases where the diff looks worse.

Yup, and that is why this is called "experimental" in the release
notes ;-)
