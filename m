Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D7801FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 20:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933801AbdCJUNQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 15:13:16 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58799 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933732AbdCJUNP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 15:13:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83DA169634;
        Fri, 10 Mar 2017 15:13:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uyLQn6eRu1aC
        IU6PNcyIhiETHhk=; b=wyS4xJ/6UDbpOA5iZPHhmGQvVywZBRSbX53pMuaBOnGk
        WHXqmLMX5W58WpZtlD7A6X3qEGd0CdvMsV+JKrHZKcik2Av6sTnrgXvOUUkN8ALh
        ewlucVwIl7I4vzLUxZweBgARXKR7kt+umHEvteMpv5bdJwjyQ67XLYaS45n7DLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wpCxlr
        KG3cXun9IoMEWvtJWZV3gDIEkVTDwKysaPoKy62wXPfLBMFwB+R7D74RO5AFmXFJ
        5/mtsn5v5YbVVWt9y2O9Eh5xHQ5hjU2LitBx05rAgSb00KZmbibn7v5rNa1u1kss
        QIzlCE7wZe6XlJjPdOInopapL7LCFZd+j1Yks=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BC0169633;
        Fri, 10 Mar 2017 15:13:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DBFBF69632;
        Fri, 10 Mar 2017 15:13:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        allan.x.xavier@oracle.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v1] Travis: also test on 32-bit Linux
References: <alpine.DEB.2.20.1703030315580.3767@virtualbox>
        <xmqqh93a9p5r.fsf@gitster.mtv.corp.google.com>
        <xmqq8tol7vs1.fsf@gitster.mtv.corp.google.com>
        <CAPc5daW=gtN18JZTQMqUje5fxL4oNdTucB0dXFbybPRJggPBUw@mail.gmail.com>
        <2205F1A7-A694-4F40-B994-D68C3947F2BB@gmail.com>
        <f5f5886a-aaec-7426-ea33-f5d65516348b@oracle.com>
        <af31ef46-bd0c-c3f2-5a1e-7d97da6ec9a0@oracle.com>
        <282895e1-d9eb-2368-a8e7-8085ad9b17ed@oracle.com>
        <20170305113618.ko2jymle4n5f2b5l@sigill.intra.peff.net>
        <c553da50-e5ca-d064-e75c-46e5a5042935@web.de>
        <20170310081759.yka476hnw4w3mghs@sigill.intra.peff.net>
        <04f4849c-e1e0-f0ac-5b1e-10a343391db4@web.de>
Date:   Fri, 10 Mar 2017 12:13:11 -0800
In-Reply-To: <04f4849c-e1e0-f0ac-5b1e-10a343391db4@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 10 Mar 2017 17:20:13 +0100")
Message-ID: <xmqqfuikyjoo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FD0A2E72-05CD-11E7-9678-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> I think this misses the other two cases: (*dst, src) and (*dst, *src).
>
> ... and that's why I left them out.  You can't get dst vs. *dst wrong
> with structs (at least not without the compiler complaining); only
> safe transformations are included in this round.

I haven't followed this discussion to the end, but the omission of 2
out of obvious 4 did pique my curiosity when I saw it, too, and made
me wonder if the omission was deliberate.  If so, it would be nice
to state why in the log message (or in copy.cocci file itself as a
comment).

It also made me wonder if we would be helped with a further
combinatorial explosion from "T **dstp, **srcp" and somesuch (in
other words, I am wondering why a rule for 'T *src' that uses '*src'
need to be spelled out separately when there already is a good rule
for 'T src' that uses 'src'---is that an inherent restriction of the
tool?).




