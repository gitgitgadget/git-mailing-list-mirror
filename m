Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41C1C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A425664DA8
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 07:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBKHhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 02:37:55 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50846 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhBKHhw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 02:37:52 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F2240119976;
        Thu, 11 Feb 2021 02:37:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CxNGenskkK6nhXapGXoSyfEfr3o=; b=uA+cpT
        xo4gJGbeN9ftE0tDJ+FOBGyVYN8OyNdmazYtrrTNBty04YZROz6gc5+RLOY9SpmM
        X0u1CRsCUK04N1mlu4Pg/q5Ibc33iZ+YW3WbSZIsFLlTufIa9QEaAA1dnt2ycOS/
        N6KcUV00ciAKt0Cp8vuajh8t+JAFMAFIdgw80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=odZRyjtzLTuTfsMlHKoq2+sHGrnXw2tb
        fKAAUDrlixON3u0tsrQGnli2t1RtMpn15Ryd4B0tA8kFo58HPoJMbUkh5U/l/3Yp
        sStBolRA8a0qYtkEtsaTHoJ9GfGdEuRTiLaErg8dWGjPgRkRuemlKNWGvPtTS1G2
        QK5Mrvh+BSA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EBA0C119975;
        Thu, 11 Feb 2021 02:37:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 32440119974;
        Thu, 11 Feb 2021 02:37:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     shubham verma <shubhunic@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 00/10] Modernizing the t7001 test script
References: <20210209173254.17712-1-shubhunic@gmail.com>
        <xmqqy2fwyhjy.fsf@gitster.c.googlers.com>
        <CAPig+cSXi7Ct48gqkBVvBtOm6bMqDhPcxXeiK3ZytAitZXNT5Q@mail.gmail.com>
Date:   Wed, 10 Feb 2021 23:37:03 -0800
In-Reply-To: <CAPig+cSXi7Ct48gqkBVvBtOm6bMqDhPcxXeiK3ZytAitZXNT5Q@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 11 Feb 2021 02:28:54 -0500")
Message-ID: <xmqq35y3ys0w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F01C310A-6C3B-11EB-BB23-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Feb 9, 2021 at 6:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>> shubham verma <shubhunic@gmail.com> writes:
>> > In this patch series modernize the t7001 test script by changing the
>> > style of its tests from an old one to the modern one and by cleaning
>> > up the test script.
>> >
>> I would have used test_write_lines instead of here-doc in 9/10, but
>> that is such a minor preference thing that it is not worth going
>> back and replace.  Nothing else stood out during my cursory scan.
>
> I read over the entire series and likewise didn't find anything to
> comment on, thus consider it in good shape. For what it's worth,
> consider this series:
>
>     Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

Yup, this one looked good to me.  Thanks.

Except that the author's name were spelled in all lowercase, unlike
v1, which made me wonder if it was intentional, that is.
