Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D60E320899
	for <e@80x24.org>; Thu, 17 Aug 2017 19:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbdHQT4D (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 15:56:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53402 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753310AbdHQT4C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 15:56:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64957AAF4D;
        Thu, 17 Aug 2017 15:56:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tsE/YHi0BU47
        1OjmqyjLYKl1J98=; b=pGY5qzBjmvKawuihDJYhTveDrJ5uhhi/Pt/sLDNpVbuQ
        WXeCXoonZtT2Gz9ZA8651w9ew5iisEdEAEZHascRAsv2rACYr8Ncv7Dl6h/q3IVR
        WHHVMSU49jk/5kam5B18cdzrqcgg/I/LKeNvWXPKLKpL8KjTbZsS6J8mvSkua4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Fqeh+c
        uXXliuWG1sPzhnuPZci/66kwBZdyi2DPCc27TQJ9hWGUQ/4ATLFX6+faLV1L0bKG
        j9sOBgsWhyM5lTm7ipxW7GQ3o4rQYC+5o4aIuVjLwcs+rqo0Np1eIrx8H7nXNXq4
        OSmIY4zT1zsG/DP5kv9sZ3qk+yvLioDonJ7Ug=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF779AAF4B;
        Thu, 17 Aug 2017 15:56:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 23D94AAF4A;
        Thu, 17 Aug 2017 15:56:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] builtin/branch: stop supporting the use of --set-upstream option
References: <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com>
        <20170817025425.6647-1-kaarticsivaraam91196@gmail.com>
        <20170817025425.6647-2-kaarticsivaraam91196@gmail.com>
        <CAN0heSquaXk421sR6Ry59C+er8n26nC93=3KG1wD0xNXZkuiGw@mail.gmail.com>
Date:   Thu, 17 Aug 2017 12:55:58 -0700
In-Reply-To: <CAN0heSquaXk421sR6Ry59C+er8n26nC93=3KG1wD0xNXZkuiGw@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 17 Aug 2017 20:21:26
 +0200")
Message-ID: <xmqqshgqezox.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1785DE00-8386-11E7-962A-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On 17 August 2017 at 04:54, Kaartic Sivaraam
> <kaarticsivaraam91196@gmail.com> wrote:
>> Helped-by: Martin =C3=85gren <martin.agren@gmail.com>,  Junio C Hamano=
 <gitster@pobox.com>
>> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
>
> I didn't expect a "Helped-by", all I did was to give some random
> comments. :-) I'm not so sure about the comma-separation, that seems to
> be a first in the project.

I didn't either ;-)=20

The line looks odd so I'll remove it while queuing.

Thanks for noticing.
