Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C2E52070F
	for <e@80x24.org>; Mon, 19 Sep 2016 21:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932253AbcISVIq (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 17:08:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50253 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932124AbcISVIp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 17:08:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F36740977;
        Mon, 19 Sep 2016 17:08:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gZKfuFl1LF32
        KuAmE+D5EYO5Vn4=; b=T82mRBh3NEzXR4sq5oE0wU5vC4zmPa2kDxzOXY0YdVse
        /gTO0EPNhKHiaECsviM+jLiJHJa0axTlv3hDzZnrwxReWK5gFwTmrSzvcSSnYd/u
        vFrLrAXuFzT1Du3VpxlgyNOqpkaaCD1mp036SOrn3iBDs+vHETTJxPF4/SEDZAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=R23PMA
        UUxPW/sUTQrZbFgRLzI2osGFpjDqzpuW24uDp2chO5tx/F0Rr2vfbqV5oGhVZBMM
        C1H4cD0GipDBr1D9xxj1s/G8augVaIHVC/3P+Rqp0snlm80ANCzeIUNikkfW4RKM
        q+kgmavF8RfEUbe+lLWyWnkRZlW49dpEVLKuI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1812340976;
        Mon, 19 Sep 2016 17:08:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C6FAE40975;
        Mon, 19 Sep 2016 17:08:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/6] i18n: commit: mark message for translation
References: <1474290501-2743-1-git-send-email-vascomalmeida@sapo.pt>
        <xmqq60prg4gy.fsf@gitster.mtv.corp.google.com>
        <34292875.FKhN8jTqO5@cayenne>
Date:   Mon, 19 Sep 2016 14:08:24 -0700
In-Reply-To: <34292875.FKhN8jTqO5@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Mon, 19 Sep 2016 22:34:49 +0200")
Message-ID: <xmqq4m5begxj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3CF18FE2-7EAD-11E6-B335-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> Maybe 3/6 would have benefited from some code factorization. But that's=
 ok for=20
> a few more sentences.

Ah, let me see I understood what you mean.  Adding something like
this

	static NORETURN void die_want_option(const char *option_name)
        {
        	die(_("option '%s' requires a value"), option_name);
	}

and have many of the callers of die() call it would reduce the
number of strings that translators would need to touch.

I agree, but I think we can do that in a later follow-up.

Thanks.
