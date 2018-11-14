Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EFF81F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 04:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeKNOSR (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 09:18:17 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64770 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeKNOSR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 09:18:17 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 33B4429264;
        Tue, 13 Nov 2018 23:16:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JixSseC/mroa
        eLx39LV8566QzAg=; b=A16gSkvrANe9+6/T+eunA72KMhpwGGvJfv5/lr8l4xoZ
        XlsxeKmYR3bbgl3mpEwoH5qMgU4jDORNr1cOwgij6BSfTdq67HkYQ8SgmpABziqD
        8747NKVfrYrDDgjbB01N4HRdF1IBfRVxBRIZ3WOYiYMJK34pIBaBZ+szpavUGN0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eEmErK
        l9j+JTz9PWj/4sYujdsruJze0cQULTktF0UwScN/oHnoBnPS9O+OjUg0MyWbwFZz
        ubHhoMO9UrrM+LfhkXIdsVUlFMINYkt+XwtQ6LHsMm7t/exYiS8EnJIRC0KN+i2V
        BkbGceDVc08uhQ4J3NkSZ6wIkU07ly83YqpAs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D15D29263;
        Tue, 13 Nov 2018 23:16:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3DBC829262;
        Tue, 13 Nov 2018 23:16:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v4] commit: add a commit.allowEmpty config variable
References: <87d0rm7zeo.fsf@evledraar.gmail.com>
        <20181113155656.22975-1-tanushreetumane@gmail.com>
        <nycvar.QRO.7.76.6.1811132021390.39@tvgsbejvaqbjf.bet>
        <87zhuc1xcx.fsf@evledraar.gmail.com>
Date:   Wed, 14 Nov 2018 13:16:44 +0900
In-Reply-To: <87zhuc1xcx.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 13 Nov 2018 22:27:58 +0100")
Message-ID: <xmqqzhucpa37.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1986C0AE-E7C4-11E8-90F3-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Agreed. I'm happy to see the test for-loop gone as I noted in
> https://public-inbox.org/git/87d0rm7zeo.fsf@evledraar.gmail.com/ but as
> noted in that v3 feedback the whole "why would anyone want this?"
> explanation is still missing, and this still smells like a workaround
> for a bug we should be fixing elsewhere in the sequencing code.

Thanks.  I share the same impression that this is sweeping a bug
under a wrong rug.
