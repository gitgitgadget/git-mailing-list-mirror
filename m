Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3072018A
	for <e@80x24.org>; Fri, 24 Jun 2016 16:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbcFXQy0 (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 12:54:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64120 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751143AbcFXQyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 12:54:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B616263E2;
	Fri, 24 Jun 2016 12:54:24 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s1Skko4X7CKM4qInz6KfYp7JQOY=; b=O1lfwM
	46KbveKrqeC6tCUfGli7pg4DqjiNCViNPAFdjzlKHlGhw4efFedbWwB9debCoeaw
	1EPaf0udijdtYCdV/lYDngfoQn8PY6uQyUFeKb1ZyDC2J1m4Y8WyHdJ/JSrgcNYg
	IvBePR48dxiIzO6IiOY/LJ8DublAOxGKF0Rkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ur010BQZrlkF0/hG8Y1YZLOcyrDCYz7G
	jpDD4ZNempon0HLgNZuI0nVHgG6Dxc1zE1TgamAyo7N0Hmfzywf8aSISBUDgT3/5
	rerXuIN0kyRW6Ibhm9NVktnZhu/MGFO0n/dkg5seKTcquQhHfhqmCG97Ir3rAQyZ
	IkqUVDbrhms=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1421C263E1;
	Fri, 24 Jun 2016 12:54:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FF64263E0;
	Fri, 24 Jun 2016 12:54:23 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org
Subject: Re: Short-term plans for the post 2.9 cycle
References: <xmqqh9covlkb.fsf@gitster.mtv.corp.google.com>
	<20160624154800.GB2448@sigill.intra.peff.net>
Date:	Fri, 24 Jun 2016 09:54:21 -0700
In-Reply-To: <20160624154800.GB2448@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 24 Jun 2016 11:48:01 -0400")
Message-ID: <xmqqd1n6h6iq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D8B7A7C-3A2C-11E6-B955-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ...  It's
> not a flag day for either, of course; we'll build in all of the usual
> backwards-compatibility flags. But it's convenient for users to remember
> that "3.0" is the minimum to support a new slate of
> backwards-incompatible features.
>
> So my inclination is that the next version is simply v2.10. And maybe
> you thought of all of this already, and that's why you didn't even
> bother mentioning it. :) I'm just curious to hear any thoughts on the
> matter.

You traced my thought very precisely.  If you take the "It is for
compatibility breaking release" and "We plan such a release well in
advance with transition period" together, a natural consequence is
that by the time we tag one release (e.g. v2.9), it is expected that
the release notes for it and a few previous releases would all have
said "in v3.0, this and that things need to be adjusted, but the
past few releases should have prepared all of you for that change".

So, no. I do not think the next one can sensibly be v3.0.

During this cycle what can happen at most is that harbingers of
compatibility breakers conceived, transition plans for them laid
out, and the first step for these compatibility breakers included.
That will still not qualify for a version bump.  The follow-up steps
for these compatibility breakers may start cooking in 'next', and
during the next cycle the list may agree they are ready for the
upcoming release.  At that point, before tagging the last release in
v2.x series, we already know that the cycle after that will be v3.0
to include these compatibility breakers.


