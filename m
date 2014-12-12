From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] document string_list_clear
Date: Fri, 12 Dec 2014 11:17:55 -0800
Message-ID: <xmqqoar8brto.fsf@gitster.dls.corp.google.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
	<20141206020458.GR16345@google.com>
	<xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
	<20141209201713.GY16345@google.com> <20141209202738.GC12001@peff.net>
	<20141209222337.GA16345@google.com> <20141210084351.GA29776@peff.net>
	<20141210091815.GA18372@google.com> <20141212091625.GA9049@peff.net>
	<20141212183114.GA29365@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 20:18:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzVj8-0005ey-FF
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 20:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540AbaLLTSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 14:18:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752165AbaLLTSC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 14:18:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 34F84240A0;
	Fri, 12 Dec 2014 14:17:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8FUIGDzpN+nq2eUZQ/we6rLVPbI=; b=XEpV8L
	AGBD1cgv53TuYSWRCz37dU2Fgaqha/cdbdaHG99TF6hZti/Bt89YL+owdO/2LQPH
	qHAwZEdnSWD/XVq1FHoSgQzYVG8oQvGEDjfA6rN1qsmlBFtgd/xo0aEDslv2E5RH
	R64OxHm5qoTD7x7SqlouaQVv8cz3umBNZxdsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FGlD4/dKfJI2wTAoLaXcLmlqYLKn3F56
	LH82+HE1lOlB1mzaL4Ob4QNqkNHSUv4EsR2lhCg4xSn42XqhctJnnJEvYK6DtI3f
	COWiX1oDA/hMrz+xJlnPkgAxWuN8eKRA0YfDxeBBrc5xakHt7jDL+dRtF8p1OxIw
	DY1fjfoliuo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 293EF2409F;
	Fri, 12 Dec 2014 14:17:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B3382409C;
	Fri, 12 Dec 2014 14:17:56 -0500 (EST)
In-Reply-To: <20141212183114.GA29365@google.com> (Jonathan Nieder's message of
	"Fri, 12 Dec 2014 10:31:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9412D510-8233-11E4-A038-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261360>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jeff King wrote:
>
>> I'm not sure any such thought as "intended to be out of date" went into
>> it.
>
> Junio started the documentation in v1.5.4-rc1~49 (2007-11-24).  I'm
> not sure if there was a discussion preceding that commit.  My
> understanding was always that putting the documentation out-of-line
> was an intentional decision and that it was understood that the
> documentation would have cycles of falling out of date and needing to
> be updated, but I may be misunderstanding the history.

There of course was not "intended to be out of date".  It was just
that the prevailing style of comments in the header back then was
sporadic per-function explanation that would have served only as a
reminder for those who have read the corresponding *.c file, without
any overall structure of the API described.

We could have gone to "in header description" route back then and
the commit you referred to could have added

	/*
         * NEEDSWORK: describe the overall structure of the API
         * here, so that people can use it without reading the
         * implementation of the API itself.
         */

to each header file instead.  I chose not to primarily because those
who wanted to have documentation pages that are pointed from api-index
were audience different from those who updated *.[ch] files, and also
I had slight preference to have a set of *.txt files that do not force
me to squelch /* * * */ while reading them.

> Separate from the question of history, I honestly prefer this way of
> doing API documentation relative to 90% of the API documentation in
> headers I've seen in other projects.  I suspect you don't.  That's
> okay --- it's possible for rational people to disagree about things.

Yes.

> The overall concept is good.

OK, then let's agree to go in the "comprehensive doc in the *.h and
then those who want *.txt can help the machinery to extract"
direction.

Thanks.
