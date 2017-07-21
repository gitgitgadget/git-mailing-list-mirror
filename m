Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39CBF20288
	for <e@80x24.org>; Fri, 21 Jul 2017 14:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753727AbdGUOyw (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 10:54:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50048 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753473AbdGUOyd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 10:54:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42C1B987A7;
        Fri, 21 Jul 2017 10:54:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AylEFOOVW594
        ls7u82ihtOzzC2I=; b=Oc7MMPhbmlvs9LK7apfy98WDdezXsSb6gl1xew1708QE
        Qy3Xm7qgs0oppfc6bipnjKZZGrPwsn7PwpN3G/jTINAUkKt6iMfeblwdrHLWtvuP
        0eqdSG0ZlBMUtsjAjHpm1658k9Bcd3XQLKn+4mWu5VHWEFzxOVSZe30BtiwKDgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mUkQJe
        Xsx3fdPT5/kxB61fD4/j18urp/WVfEUx6SP29bcGHd8BVmysLcf5wGLKWWgTu7su
        LpZUaxajE0vi0mdg8NDaqrkNOO7IRvqSxu9lr5VIuH6NkKPq1i3OVXSthV0xo44s
        G1hYxthUQhro7Lg7x7H2DhuhC2jzNTcxRC2RA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C02D987A6;
        Fri, 21 Jul 2017 10:54:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9CAD3987A5;
        Fri, 21 Jul 2017 10:54:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
        <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
        <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com>
        <CANYiYbEcMrriaor9OT4c2qtfh9Ja5NJ9KBSxa3XhPAuoN0t42A@mail.gmail.com>
        <xmqq60epfy27.fsf@gitster.mtv.corp.google.com>
        <CANYiYbFROuyXso2ZKuJWDp4cSwpBu=bNAbC-yZtEyDwkbUcAhQ@mail.gmail.com>
        <alpine.DEB.2.21.1.1707191456010.4193@virtualbox>
        <xmqq8tjkm3ly.fsf@gitster.mtv.corp.google.com>
        <xmqqo9sfkm32.fsf@gitster.mtv.corp.google.com>
        <xmqqfudrkkci.fsf@gitster.mtv.corp.google.com>
        <f00aeb42-75ad-d5ec-b4fb-c80b48827db4@free.fr>
Date:   Fri, 21 Jul 2017 07:54:24 -0700
In-Reply-To: <f00aeb42-75ad-d5ec-b4fb-c80b48827db4@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
        Avila"'s message of "Fri, 21 Jul 2017 16:38:58 +0200")
Message-ID: <xmqq7ez1j0wv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7D3458A2-6E24-11E7-87EE-EFB41968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:

> Le 20/07/2017 =C3=A0 20:57, Junio C Hamano a =C3=A9crit :
>>
>> +	git diff --quiet HEAD && git diff --quiet --cached
>> +
>> +	@for s in $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL); \
>
> Does PRIuMAX make sense for perl and sh files?

Not really; I did this primarily because I would prefer to keep
things consistent, anticipating there may be some other things we
need to replace before running gettext(1) for other reasons later.

I do not mind removing them, if Jiang/Dscho already reviewed and
tested _this_ version (which we do not yet know), I'd prefer not to
touch it for the upcoming release.

Thanks for reading it over.


>> +	do \
>> +		sed -e 's|PRItime|PRIuMAX|g' <"$$s" >"$$s+" && \
>> +		cat "$$s+" >"$$s" && rm "$$s+"; \
>> +	done
>> +
>>  	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C=
)
>>  	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_=
SH) \
>>  		$(LOCALIZED_SH)
>>  	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_=
PERL) \
>>  		$(LOCALIZED_PERL)
>> +
>> +	git reset --hard
>>  	mv $@+ $@
>> =20
>>  .PHONY: pot
