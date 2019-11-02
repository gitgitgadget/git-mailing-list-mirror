Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D26421F454
	for <e@80x24.org>; Sat,  2 Nov 2019 05:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfKBFpw (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 01:45:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57509 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKBFpv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 01:45:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D903F9CD22;
        Sat,  2 Nov 2019 01:45:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qwIAKB2QUYG7
        gxk/ptYK7ixCWm0=; b=WqwITwpK7dbuTwaoreFgZZd4SN+Xyww0kGkSNKtio6Uq
        dy01oQMfD97yag6HFtrrkfIUutoYUbG2tqjTGh3j31fJ39onEBk+4gPAGT2wfM8J
        9GD4ggtb6OEpyTNfm4XIekRfgQjAbK0LwX7VnsPrnZERDejqqf+r1w9Bw7p72P8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=M+/+0v
        SNWJKIOm/rmMhtrhJoR1honq3nb9+vJB/tETdUt71hKKLZWx658PoNEIf2lHrZE3
        bPwArmgfqpHWnW55hN9tNvP/og5r6i17ylWBHRkGcqPPX6RlE7hjMsJ0d8/nPbNx
        DQT2Xl+W2S52fb/MQ9ReEPMIzrwk+jbnomYD8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C494B9CD21;
        Sat,  2 Nov 2019 01:45:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E28B19CD20;
        Sat,  2 Nov 2019 01:45:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] manpage-bold-literal.xsl: provide namespaced template for "d:literal"
References: <20191030204104.19603-1-martin.agren@gmail.com>
        <20191031023150.mdbj74sthrftnqie@camp.crustytoothpaste.net>
        <CAN0heSrY9jOrRmt_ViJZ8Yv96XPNh4atArxqNO1=Tr57wdt0Zw@mail.gmail.com>
Date:   Sat, 02 Nov 2019 14:45:45 +0900
In-Reply-To: <CAN0heSrY9jOrRmt_ViJZ8Yv96XPNh4atArxqNO1=Tr57wdt0Zw@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 31 Oct 2019 07:21:32
 +0100")
Message-ID: <xmqq4kzm4yra.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 053BCCDA-FD34-11E9-97CE-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

>> If you want to avoid duplication, you can write the existing template =
as
>> follows:
>>
>>   <xsl:template match=3D"literal|d:literal">
>>
>> That will match both literal and d:literal tags.  You still need the
>> namespace declaration you added, of course.
>
> Thanks. I use this for v2.

Thanks, both.
