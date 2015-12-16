From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Tue, 15 Dec 2015 22:05:57 -0800
Message-ID: <xmqqoadrdj22.fsf@gitster.mtv.corp.google.com>
References: <1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
	<xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com>
	<xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
	<xmqq6100ke7v.fsf@gitster.mtv.corp.google.com>
	<xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
	<CACBZZX6=sU2cb_vRn5DAqVEuNTwsk0m7vQ0_WUp5qPWeQq5JhQ@mail.gmail.com>
	<xmqqh9jjfqk4.fsf@gitster.mtv.corp.google.com>
	<CACBZZX7QW2J6DcMSXTa1y+QdMrqq5DXs1Fu3m8toV5a4yZKNjw@mail.gmail.com>
	<xmqqy4cvco25.fsf@gitster.mtv.corp.google.com>
	<20151216024605.GA618@sigill.intra.peff.net>
	<xmqqwpsfdl5y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 16 07:06:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a95EN-0002Kh-1S
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 07:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538AbbLPGGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 01:06:01 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751398AbbLPGF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 01:05:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B3242E321;
	Wed, 16 Dec 2015 01:05:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MhG7TVf2FDu1QHqgWxqkY7KS0DY=; b=vsp0v2
	3RUHSygXCbRcSsQgv1nBLmBSNbO5irlLNTJF7WRrnWLD5piZ99Xa/W9VtfmIfxTX
	T+jhsdZON5qCWsNvPTdDRqz/dsGT3jsrFCwRwuEi5gqosAMVYtnSjyWxKM9Cjvxe
	yfWfnvGoaCcLt/SMqKrlTkI2Tqfs1CQV7xcP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JL104rhyDSRsa1W+5nSRVuT3zmXdKJTI
	lmFgCruEl3A+SEKx24bNKORnCUgTBT6gRnd5kfcztsR9WvKtA+W5B8FO0jGcbnrv
	SWoN/D1bH+/iSsPJt6X3Fblmk99ntzpA7Gp4tnYI8Ym6riDT8UVtUNZ+L2fWKT7J
	tGjEZo1/XwQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 11C952E320;
	Wed, 16 Dec 2015 01:05:59 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7BFEB2E31F;
	Wed, 16 Dec 2015 01:05:58 -0500 (EST)
In-Reply-To: <xmqqwpsfdl5y.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 15 Dec 2015 21:20:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 137DBFBE-A3BB-11E5-A2E6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282536>

Junio C Hamano <gitster@pobox.com> writes:

> This is why the_index.has_untracked_cache is not just a simple "Do I
> want to use this feature?" boolean configuration.  The index also
> stores the real data, and "Am I using this feature?" bit goes hand
> in hand with that real data.  Thinking that this is merely a boolean
> configuration is the real source of the confusion, and introducing a
> config that overrules what the user has stored in the index needs to
> add complexity.
>
> The additional complexity may (or may not) be justifiable, but in
> any case "all other things being equal, this is a config" feels like
> a flawed observation.

To put it another way, the "bit" in the index (i.e. the presence of
the cached data) is "Am I using the feature now?".  The effect of
the feature has to (and is designed to) persist, as it is a cache
and you do not want a stale cache to give you wrong answers.  There
is no "Do I want to use the feature?" preference, in other words.

And I do not mind creating such a preference bit as a configuration.

That is why I suggested such a configuration to cause the equivalent
of "update-index --untracked-cache" when a new index is created from
scratch (as opposed to the case where the previously created cache
data is carried forward across read_cache() -> do things to the
index -> write_cache() flow).  Doing it that way will not have to
involve additional complexity that comes from the desire that
setting a single configuration on (or off) has to suddenly change
the behaviour of an index file that is already using (or not using)
the feature.
