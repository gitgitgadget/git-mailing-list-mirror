Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6660C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 18:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF8723DE3
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 18:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393152AbgLJSfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 13:35:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64276 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392328AbgLJSf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 13:35:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB81391091;
        Thu, 10 Dec 2020 13:34:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LISqxURuxs0EWXvmcd2WWb8Qt+o=; b=UdYa7r
        DNodPQkUkbXrqgh7PXANPFPEihxh90K7DqY37pyLp4A3k0DtrHC584qjJ/19Or+V
        rJDWQd8Rl1TvxrQXpjv2cq+X/hT4I6j7lwKOZf8ltlqY/B/PDTu/IG28lL4vy+1z
        RtNUcOHJeQ/6MTlaipjPMUtZ200ljZWEh1oz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mTHCtzsPI/eGsUApVTUq+VWonlKdJtgn
        nthmSI/FDG/2OkcLwBWBnNGkVjek37p2cNpdgt7y9tQTp697sKBfQuba65UOGGXe
        6D7Ea/g3ZsBNnJ02XM8aP0nQHu/1EmP2zn2V5EXAEYcx56V7wYic/o45qjJ+QXXv
        4o/oksD0xbA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2BC99108F;
        Thu, 10 Dec 2020 13:34:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 653279108E;
        Thu, 10 Dec 2020 13:34:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: bc/rev-parse-path-format, was Re: What's cooking in git.git
 (Dec 2020, #01; Tue, 8)
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2012100454120.25979@tvgsbejvaqbjf.bet>
Date:   Thu, 10 Dec 2020 10:34:44 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2012100454120.25979@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Thu, 10 Dec 2020 04:56:45 +0100
        (CET)")
Message-ID: <xmqqa6ulwlvf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60347440-3B16-11EB-969F-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 8 Dec 2020, Junio C Hamano wrote:
>
>> * bc/rev-parse-path-format (2020-10-09) 2 commits
>>  - rev-parse: add option for absolute or relative path formatting
>>  - abspath: add a function to resolve paths with missing components
>>
>>  "git rev-parse" can be explicitly told to give output as absolute
>>  or relative path.
>
> This is listed in the "Stalled" section, but v4 has been sent out this
> past Sunday, and in the replies brian promised to work on a v5:
> https://lore.kernel.org/git/20201206225349.3392790-1-sandals@crustytoothpaste.net/
>
> May I suggest to move the item to the "Cooking" section?

Thanks.  I was planning to do so when replacing it with the latest.
