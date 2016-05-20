From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t0008 test fails with ksh
Date: Fri, 20 May 2016 09:03:31 -0700
Message-ID: <xmqqr3cwg1ik.fsf@gitster.mtv.corp.google.com>
References: <CALR6jEjWjJA0X2qXsxqObqc_yxrgX87LYf8cmJ0MmJFF6PkmTQ@mail.gmail.com>
	<20160512182055.GB13886@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 20 18:03:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3mtq-0005nZ-P4
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 18:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631AbcETQDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 12:03:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56305 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754499AbcETQDf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 12:03:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DCB61C315;
	Fri, 20 May 2016 12:03:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Yhh6Gkt2bvfjGCei3uko1SugOg=; b=vNjYEb
	4/B1CQZciMYSuKTEcnympYKqsmqTHV2aUKS133g1i4Q85Mv2lbvMP0Q5A6ibPUpC
	Aw166ZvTZfQO4WyglJKPYP7tvH4IclFyJcsEgM+IsCLdc7e5H5jyfHzhaPNuHm1j
	fo/7R1ejNoYitgLrC4L623WU9M0nWX+1qW1q8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cy484is5W91Pdld9BB2ak84GfVpxK8pi
	Ej1jJIiq84EY8JRZDmuAu2w0uYqsUvU/UYzJhqHxxV4VvGJIlcm39Y5cnkLiigqm
	N3vb/DEAMBY95VGaUKGXHbC9JEn00VQkals2cBZKMswXZSJjPW6CG8yM2QZ+QCpU
	za7l7ohW7XQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED6851C312;
	Fri, 20 May 2016 12:03:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5729D1C310;
	Fri, 20 May 2016 12:03:33 -0400 (EDT)
In-Reply-To: <20160512182055.GB13886@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 12 May 2016 14:20:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 670BF024-1EA4-11E6-9336-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295178>

Jeff King <peff@peff.net> writes:

>   ... However,
>   the double-quote character ( '"' ) shall not be treated specially
>   within a here-document, except when the double-quote appears within
>   "$()", "``", or "${}".
>
> So OK, that sounds like ksh is doing the right thing. But what's that
> "specially" in the last sentence?

I would say: Just like \X is passed thru as-is without losing \, \"
is passed thru without losing \, because " is not special, just like
X is not special.

> Anyway, it doesn't really matter what the standard says. We can spell
> this in a less ambiguous way, and it does not hurt too much to do so.

Yes.
