Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE0D41FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 18:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbcFWSwz (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 14:52:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751390AbcFWSwz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 14:52:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E8752570F;
	Thu, 23 Jun 2016 14:52:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0xCzS4hwDeakiZaIxPDS32sVh8A=; b=Kl1QMl
	gVmWcT8N23/b1s50bgLmSU07UfptAlJQ8W8F4rLqM0t6VfoO0sx8THvQdeU9py18
	oooLV8P23Ty18yqjXDohaKxaduD1KKIhvMhHjtjL+sI7YqknFswbeYu789FsUQzf
	Q+XwF14ytwrrhJIOZDtUgNeO2Z8w+P5E5F15M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yo1ezBop9Ik2hZ0DkMJVBgOOaUUvI2t5
	OIKSSVRh8QKKOGIAaBagk3EgycMXIxJI48HeAKUIwVuelOi60ImQcN5UxyTXVoqk
	/LaqWQthf9CZE0tkA2xMjKDuMZIUVow40DSYz6PfWoN5v6qGmP8VTdbQVwuW+ZPm
	gT1r6w7OQek=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 15EFF2570E;
	Thu, 23 Jun 2016 14:52:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8EEF825709;
	Thu, 23 Jun 2016 14:52:53 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, Simon Courtois <scourtois@cubyx.fr>
Subject: Re: [PATCH v2 7/7] color: support strike-through attribute
References: <20160623173048.GA19923@sigill.intra.peff.net>
	<20160623174015.GG15774@sigill.intra.peff.net>
	<xmqqpor7iwgo.fsf@gitster.mtv.corp.google.com>
	<20160623183907.GA32368@sigill.intra.peff.net>
Date:	Thu, 23 Jun 2016 11:52:51 -0700
In-Reply-To: <20160623183907.GA32368@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 23 Jun 2016 14:39:08 -0400")
Message-ID: <xmqqlh1vivp8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B10F4A1A-3973-11E6-8985-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jun 23, 2016 at 11:36:23AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > This is the only remaining attribute that is commonly
>> > supported (at least by xterm) that we don't support. Let's
>> > add it for completeness.
>> >
>> > Signed-off-by: Jeff King <peff@peff.net>
>> > ---
>> > This was mostly for fun.  I can't think of a way in which it would be
>> > useful, and I'm not sure how compelling completionism is as an argument
>> > for inclusion. I'm OK if we drop this one.
>> 
>> It indeed is fun and it even makes sense in this context:
>> 
>>     $ ./git -c diff.color.old='red strike' show
>
> Ooh, I hadn't thought of that. It's a bit noisy for my tastes in a
> line-oriented diff, but with --color-words, it actually helps quite a
> bit (try it on the documentation patch from this series, for example).

What I usually use is diff.color.old='red reverse' because I cannot
easily tell between black and dark red in small font on my white
background.  s/reverse/strike/ makes it much less noisy.

What is sad for me is that I usually work in GNU screen, displaying
on either xterm or gnome-terminal.  Without screen, strike shows but
inside it I cannot seem to be able to get strike-thru in effect.
