Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 841891F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 17:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934052AbcJTRLG (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 13:11:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50331 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933403AbcJTRLF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 13:11:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F379467CC;
        Thu, 20 Oct 2016 13:11:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vSEVdz89a24U
        9C8p+6M1csQ3Pbs=; b=aoGyMHJxTveqKBD7xgSiJKk6Fp87eVDfnhB6ZdyS4d+/
        Y9A7Gg1oveyUp8xNYF6h+c3OOfx7mJKYbMdeXooJSAs1vXnoViAFFXi8CGLgg+eG
        qVckd58EsFXPKp5NiYeLBFS5f/lsqaYzsn8ZTBBvfAHdhDbsMmuJ9pbtoB1P200=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jNdz5/
        83zn4NSxXs8WrjTswcit6adsLmAOhY04LujeoSGo1rY4bBxxiWOZJdsZRk2K72/7
        1akBPh8thkrDnuz5GRmEBhTboHPID9CRezl1hM3R02csDPiiY31k2a0dNWAzbonj
        HVcijaRNWLgW9hB2olABMIIrfriln4KnKiKRE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12491467CB;
        Thu, 20 Oct 2016 13:11:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68533467CA;
        Thu, 20 Oct 2016 13:11:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        Jakub =?utf-8?Q?Na?= =?utf-8?Q?r=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v4 05/14] i18n: add--interactive: mark plural strings
References: <20161010125449.7929-1-vascomalmeida@sapo.pt>
        <20161010125449.7929-6-vascomalmeida@sapo.pt>
        <1476981335.14459.19.camel@sapo.pt>
Date:   Thu, 20 Oct 2016 10:11:00 -0700
In-Reply-To: <1476981335.14459.19.camel@sapo.pt> (Vasco Almeida's message of
        "Thu, 20 Oct 2016 16:35:35 +0000")
Message-ID: <xmqq37jrhrob.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2E48A78E-96E8-11E6-9320-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> A Seg, 10-10-2016 =C3=A0s 12:54 +0000, Vasco Almeida escreveu:
>> @@ -70,6 +72,8 @@ Git::I18N - Perl interface to Git's Gettext localiza=
tions
>> =20
>>         printf __("The following error occurred: %s\n"), $error;
>> =20
>> +       printf __n("commited %d file", "commited %d files", $files), $=
files;
>> +
>
> I forgot to add \n to this example as suggested in
> <xmqqoa2ymnb1.fsf@gitster.mtv.corp.google.com>
>
> What should I do? Should I wait for more reviews and then send a new
> re-roll fixing this?

You fix it up locally not to forget, in case you need a reroll, and
wait for more reviews.  In the meantime, I'll also fix it up locally
not to forget ;-)  That way, if it turns out that this round is good
enough to be the final version, people will see my fixup, and if what
I have needs to be replaced with your new version, your fixup will
be in there.

Thanks.
