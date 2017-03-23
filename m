Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D775020958
	for <e@80x24.org>; Thu, 23 Mar 2017 21:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935989AbdCWVhB (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 17:37:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60332 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935953AbdCWVgz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 17:36:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2076A693C7;
        Thu, 23 Mar 2017 17:36:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bsETl69Wl/h2
        nASyNylnhpi5ylI=; b=cYrr5d7YMe6C5MhtwsMzubHAOe/Ai+mSztRRs6v36bgc
        bDVqsbAkIQTrXjW0zKJPtDz+RD2OLtJtT+8Qm4p1Ju8s+A/rSq8rc+yqPh/lzN35
        d2Hz3jUAOF04J8L0Jda6PkfitRYws1tS+ic7GPUFcpNcrUh9bjB05zwasFnVq08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JwzOxj
        v382EsABG00NW+NBBqrtHgUqG9uHC4UT+LYqtLXiTouLSXz8uMJx9Zk2NClnmMN6
        95QtEml55z+9jD/w69wEMWOAFzL3v/bqF0Q2MKaFXjC/Xaon8g4fEHOze8Quvod+
        drqacoIxkbDmQqcQWLT1iF5iJZputp3Jvdp9g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 16891693C6;
        Thu, 23 Mar 2017 17:36:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 703ED693C5;
        Thu, 23 Mar 2017 17:36:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 09/16] tag: add more incompatibles mode tests
References: <20170323130529.11361-1-avarab@gmail.com>
        <20170323130529.11361-10-avarab@gmail.com>
        <xmqqtw6jex0o.fsf@gitster.mtv.corp.google.com>
        <CACBZZX5wFaSdeXGxGNMK4j_OoEJ_Zt08vAYRosSwnJVs9K+Lng@mail.gmail.com>
Date:   Thu, 23 Mar 2017 14:36:51 -0700
In-Reply-To: <CACBZZX5wFaSdeXGxGNMK4j_OoEJ_Zt08vAYRosSwnJVs9K+Lng@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 23 Mar
 2017 21:37:18
        +0100")
Message-ID: <xmqqtw6jad58.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D44BF9E6-1010-11E7-BA46-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Mar 23, 2017 at 6:13 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>> Amend the test suite to test for more invalid uses like "-l -a"
>>> etc. This change tests this code path in builtin/tag.c:
>>>
>>>     `(argc =3D=3D 0 && !cmdmode)`
>>>     ->
>>>     `((create_tag_object || force) && (cmdmode !=3D 0))`
>>
>> What is this notation trying to tell us?  A range of lines starting
>> with the first one to the second one?
>
> Yeah.

The reason why I asked about the original notation was because it
looked as if you are saying "the former is changed to the latter,
and this is to make sure it does not regress". =20

Compared to that, spelling out why in a readable sentence would be
much more helpful for later readers of the log output, no matter
what they want to do with the information.
