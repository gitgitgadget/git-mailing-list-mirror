From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Tue, 15 Dec 2015 21:20:25 -0800
Message-ID: <xmqqwpsfdl5y.fsf@gitster.mtv.corp.google.com>
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
X-From: git-owner@vger.kernel.org Wed Dec 16 06:20:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a94Vw-0007fd-64
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 06:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbbLPFUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 00:20:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752070AbbLPFU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 00:20:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 43DF82D36D;
	Wed, 16 Dec 2015 00:20:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LBsHD2vhZxU4khJMlaMvPRegAtA=; b=TDWlZ9
	nSP0TXs4FXN7ah6gBCwyXBUmai0cjFEnVHUstEipxFatPMFOWaGQZayAe27N9DDG
	eDhCQS6On304J/Ouln7spl4pCdSLJrCmcUEX/wZiXG0oFyj6Q9+e4xLBylMwNyHS
	suuOvdIT60O+OtoCTsDGNJt+NKgf6vMxhNeYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U5HvDQyLqei/HlqlAJC6qM0KAbAyNWyr
	PRJNs/KrvKGmN0GjUytFLVgkr+qMA33kS2UEmPALVbOsexyxD4+CCN3GwdMJS3Wd
	5r1Udle8rI6uG8iCBk5/aR0UUXoZp5SETU79WZwJTfGmFOjOhlP2+/P9N74nnv7F
	LB0Anezh1mk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3330C2D36C;
	Wed, 16 Dec 2015 00:20:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 989DE2D36B;
	Wed, 16 Dec 2015 00:20:26 -0500 (EST)
In-Reply-To: <20151216024605.GA618@sigill.intra.peff.net> (Jeff King's message
	of "Tue, 15 Dec 2015 21:46:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B7298AF0-A3B4-11E5-ACBE-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282534>

Jeff King <peff@peff.net> writes:

>> If the feature is something only those with really large repositories
>> care about, is it a good trade-off to make everybody pay the runtime
>> cost and make code more complex and fragile?  I am not yet convinced.
>
> I'm not sure I understand the runtime and complexity costs of the config
> option. Isn't it just:
>
>   if (core_untracked_cache) {
> 	/* do the thing */
>   }
>
> and loading core_untracked_cache in git_default_core_config()? Versus:
>
>   if (the_index.has_untracked_cache) {
>         /* do the thing */
>   }

The latter is pretty much so, but the former needs to be a bit more
involved, e.g. more like:

        if (core_untracked_cache) {
            if (!the_index.has_untracked_cache)
                create_and_attach_uc(&the_index);
            /* do the thing */
        } else {
            if (the_index.has_untracked_cache)
                destroy and remove untracked cache;
        }

Otherwise, after adding the cache to the index, flipping the config
off, doing things with the index and working tree and then filpping
the config back on, the index would have a stale cache that does not
know what happened to the working tree while config was off, and
your "git status" will start throwing a wrong result.

This is why the_index.has_untracked_cache is not just a simple "Do I
want to use this feature?" boolean configuration.  The index also
stores the real data, and "Am I using this feature?" bit goes hand
in hand with that real data.  Thinking that this is merely a boolean
configuration is the real source of the confusion, and introducing a
config that overrules what the user has stored in the index needs to
add complexity.

The additional complexity may (or may not) be justifiable, but in
any case "all other things being equal, this is a config" feels like
a flawed observation.
