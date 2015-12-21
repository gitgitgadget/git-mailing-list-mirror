From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Mon, 21 Dec 2015 10:30:07 -0800
Message-ID: <xmqqy4cnfyds.fsf@gitster.mtv.corp.google.com>
References: <CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
	<xmqq6100ke7v.fsf@gitster.mtv.corp.google.com>
	<xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
	<CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com>
	<xmqqh9jjfqk4.fsf@gitster.mtv.corp.google.com>
	<CACBZZX7QW2J6DcMSXTa1y+QdMrqq5DXs1Fu3m8toV5a4yZKNjw@mail.gmail.com>
	<xmqqy4cvco25.fsf@gitster.mtv.corp.google.com>
	<20151216024605.GA618@sigill.intra.peff.net>
	<xmqqwpsfdl5y.fsf@gitster.mtv.corp.google.com>
	<xmqqoadrdj22.fsf@gitster.mtv.corp.google.com>
	<20151217074443.GA4830@sigill.intra.peff.net>
	<CACsJy8BwARfGmGBXEdWHnDxxXcubZDzjCg7Zy6qD0qzHZWGoFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 19:30:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB5Ds-0000nO-IG
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 19:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbbLUSaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 13:30:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751304AbbLUSaK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 13:30:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CC7A433F32;
	Mon, 21 Dec 2015 13:30:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZKNG55vHPWWsCk6V5WG0lvXY83s=; b=BrFNw4
	HVPFxPV2qk3FDnNACM2F3NwRbDU5JwZ9SppCH8Mh4izl++KPAb9Sy/FAXo0+lU/y
	PY3am+8vf6oOspidW3SfqAtDfrTE0i5JI3NtcKLi3lMUtCZ9zmQzAlpb3pL5Se/j
	kRNFKrCSbryyDuRzyG/hdBPiuQ/0YcPr5sfTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gKd1vI4yVzWmg9/y0AxXiCfdjARDX7eL
	RX6aChYs17B3+snjVewvv04uU+EkX1vL9bLxqpbfwASqX0zoxiSYd3iLCdQlnmP5
	NVxLaLaAnoRgqBdAzfoclvU/Zpvqg/n4/h2H6Y2X9smZS49TF030SJMLdmeQdJZ9
	W7L0OAwHYZQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ACA6B33F2F;
	Mon, 21 Dec 2015 13:30:09 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EB14033F21;
	Mon, 21 Dec 2015 13:30:08 -0500 (EST)
In-Reply-To: <CACsJy8BwARfGmGBXEdWHnDxxXcubZDzjCg7Zy6qD0qzHZWGoFw@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 17 Dec 2015 19:26:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DD4E2636-A810-11E5-A920-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282807>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Dec 17, 2015 at 2:44 PM, Jeff King <peff@peff.net> wrote:
>> I think we may actually be thinking of the same thing. Naively, I would
>> expect:
>>
>> ..
>>   - if there is cache data in the index but that config flag is not set,
>>     presumably we would not update it (we could even explicitly drop it,
>>     but my understanding is that is not necessary for correctness, but
>>     only as a possible optimization).
>
> No, if somebody adds or removes something from the index, we either
> update or drop it, or it's stale. There's the invalidate_untracked()
> or something in dir.c that we can hook in, check config var and do
> that. And because config is cached recently, it should be a cheap
> operation.

Checking the config may be cheap, but it bothers me a lot that we
have to call that "invalidate" thing every time we go into the
codepath to deal with the index, from code cleanliness point of
view.
