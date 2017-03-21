Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5F272095B
	for <e@80x24.org>; Tue, 21 Mar 2017 19:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933603AbdCUT1J (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 15:27:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50273 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933009AbdCUTZW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 15:25:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A7FB68113;
        Tue, 21 Mar 2017 15:24:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fGAbmpnZWkfH
        DiZ6ZSBILUHuoQg=; b=Ir2yPjolIzOi7/tEoThe7t9lSSgUyHBYrVMjybZAfTHJ
        6PbLQ+WdW6QbqGHOsmYwrbr7OBKlaZ5oO26MJQ0iItYRklEmHdr7oFR7vWBOwdBo
        ASSeg6DjatM/LGN0pMUMZX/EKWJQNnOfJ64CA1b2N1tMTXC29l3J2kep6Dg3/d8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pgCuy9
        xfRJC59HwlotyokgDBfP4paf3Nys0Z81Yxh4Kx/DTfsAK/J7afCAkKdnAmFc9QbG
        Vx+7IymtBRrxqVz2hgq7BaGAPf2mAW+JNBIz1h2tUwMx4Xcup4N9d2Cb4K/Xzu+y
        pKqj1i27c79hEy6MNZsyQ0SlM+2gv0SyRO3FA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1342A68112;
        Tue, 21 Mar 2017 15:24:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F89468111;
        Tue, 21 Mar 2017 15:24:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 15/16] tag: implicitly supply --list given the -n option
References: <20170321125901.10652-1-avarab@gmail.com>
        <20170321125901.10652-16-avarab@gmail.com>
        <xmqq37e6piae.fsf@gitster.mtv.corp.google.com>
        <CACBZZX7yRRTQpcFZ9eO2_+HdB979p6URE+jsXJakxw7jpnOvmA@mail.gmail.com>
Date:   Tue, 21 Mar 2017 12:24:25 -0700
In-Reply-To: <CACBZZX7yRRTQpcFZ9eO2_+HdB979p6URE+jsXJakxw7jpnOvmA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 21 Mar
 2017 20:11:15
        +0100")
Message-ID: <xmqqtw6mo2l2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FF48E6FA-0E6B-11E7-A29E-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Yeah I see now that this is rather badly explained. I'll fix this up
> for v3. All of this worked already:
>
>     $ ./git tag 100
>     $ ./git tag -n -l 100
>     100             tag: add tests for --with and --without
>     $ ./git tag -l -n 100
>     100             tag: add tests for --with and --without
>
> So actually thinking about it again it doesn't add any more ambiguity
> than we had before. The change is just strictly getting rid of the
> need for -l for consistency with --contains, --points-at etc.
>
> I see now that the whole thing that led me down this golden path was
> that I was removing the failing "git tag -n 100" test,...

Wait a minute.  I do not think I would agree with the behaviour of
the last one, if "tag -l -n 100" is taking 100 as a pattern, not a
numerical argument to "-n".  That sounds utterly broken.

Is it because we use it OPT_OPTARG, which requires it to be spelled
as "-n100" or "-n=3D100" or somesuch?

In any case, it is not a new confusion this series introduces, so
let's include it in the series, but I'd prefer to see it kept as a
separate patch, at least for now.  Maybe somebody else have an idea
to resolve this apparent confusion in a cleaner way.

Thanks.
