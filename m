Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A957B1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 20:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbcLEUbu (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 15:31:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65099 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752078AbcLEUbt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 15:31:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 68CD554ED8;
        Mon,  5 Dec 2016 15:31:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ay8VCHXyNueQ
        TKayQ2b2ts/KIAI=; b=nLZhCoTkGL4Kb6wElA6a7LdrXvXZhVcUjXK0QLJCvXEc
        w62P//4qcbv1vqsqjZg2BJ7P2vYBTJyb/D8jN5dVOwN5YstO9ygl+yqgopVyCMtJ
        E2CON6gNb254cgLST7b+6BwNLDQY9ZWAT7JBiXg7GibNafzO0Ef+6TYO2Ls+VSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rE9pQx
        VBb1fHwUdHnR5Zw6Vpg8QkmdmPwEbx29rms87vku4jUbu42fDQgA1JMRkeZksFh6
        k2fBnZhDuEWhw8f1+Y/QGNh5gqPFWycRBDvrnwrNvKmYU3av2BiPf62ym1ZUZVVa
        wiWu7wtQNl7CVRmOvrrED2EvjzFk2jZCNHXQ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E97C54ED7;
        Mon,  5 Dec 2016 15:31:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BDDFE54ED6;
        Mon,  5 Dec 2016 15:31:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
Subject: Re: [PATCH v4 1/3] update-unicode.sh: automatically download newer definition files
References: <835c0328-e812-1cb7-c49e-714ff0e9ffb3@drbeat.li>
        <1480798849-13907-1-git-send-email-dev+git@drbeat.li>
        <20161204075800.GA2415@tb-raspi>
Date:   Mon, 05 Dec 2016 12:31:46 -0800
In-Reply-To: <20161204075800.GA2415@tb-raspi> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Sun, 4 Dec 2016 07:58:00 +0000")
Message-ID: <xmqqmvga3yod.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D846913C-BB29-11E6-89D9-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On Sat, Dec 03, 2016 at 10:00:47PM +0100, Beat Bolli wrote:
>> Checking just for the unicode data files' existence is not sufficient;
>> we should also download them if a newer version exists on the Unicode
>> consortium's servers. Option -N of wget does this nicely for us.
>>=20
>> Reviewed-by: Torsten Boegershausen <tboegi@web.de>
>
> Minor remark (Not sure if this motivates v5, may be Junio can fix it lo=
cally?)
> s/oe/=C3=B6/
>
> Beside this: Thanks again (and I learned about the -N option of wget)

Will fix up while queuing (only 1/3 needs it, 2/3 has it right).

Also, I'll do s/update-unicode.sh/update_unicode.sh/ on the title
and the message to match the reality.  At some point we might want
to fix the reality to match people's expectations, though.

Thanks.
