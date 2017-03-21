Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C64632095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758087AbdCUSWx (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:22:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50043 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758078AbdCUSWR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:22:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0E7165276;
        Tue, 21 Mar 2017 14:22:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=V3jufavc46qa
        tJvUlQJqdbmfWpw=; b=GgkasGC8+Him1ZGbZHTQfKB/x6XRFck+MWTQCpTBd2Sr
        KWvS4rrnoByCEebcviCOH1qIXNhhSm/PP4dVvPoimCzgg5SPR/DFwoIrsCVQILSL
        82uPi7MPOluKN/D3CeTP82dBs3//NgXR6XrKjZbfrRIU67quTWBet8uOndIR8VI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rebXBb
        jd/m9sq3JBnMiJzCp+cK7I46qb+CQTNR+Qo1BPefx0vN+C9ko2k0G2A/PlVC7ccb
        KY+4CSeAh1ykC0g4vgiOfIZHxFtKwVjzeotycEadHAwbrE8smq0nWE2MTS8M9NZ1
        y+XmH3eqKcgmdSG3/ulw6sNkaTjO8H9AzGR5s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 983FB65275;
        Tue, 21 Mar 2017 14:22:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C31C465271;
        Tue, 21 Mar 2017 14:22:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/16] Various changes to the "tag" command & related
References: <20170321125901.10652-1-avarab@gmail.com>
Date:   Tue, 21 Mar 2017 11:22:13 -0700
In-Reply-To: <20170321125901.10652-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 21 Mar 2017 12:58:45 +0000")
Message-ID: <xmqqefxqqylm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4F0AE8CC-0E63-11E7-8DDB-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This series is now 2x the size of v1. The reason is that the
> discussion for v1 brought up lots of related side-points that I fixed
> while I was at it. Most if this *could* be split off, but since a lot
> of it's modifying the same bits of code doing that would result in
> merge conflict galore, so I think it's easier to bundle it up.

Whew.  v1 was already a tad larger than v0 and now this ;-) =20

Thanks for a well-written and concise summary below.  Makes it much
more pleasant to review than without them.
