Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 591581F428
	for <e@80x24.org>; Fri,  5 Jan 2018 18:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752263AbeAESwX (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 13:52:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53280 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeAESwW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 13:52:22 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9695CCB7E5;
        Fri,  5 Jan 2018 13:52:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XypFEOIyVvM6
        vTDCSE0/CGKY/w8=; b=Z2LdzrAU5MapgNjDW/k+6b8W9aQ56vc4Z50C63+huLVB
        BozO7Xw+ZXL3G11QwverIWIiHRP01WmPld1vTyb/xh7UhZ4S1kxZAxRGOH+Dv4v4
        tqDtbahJNvNNPtfaHXxFL2+7/MbVEO+ASZDBiwhNv+c5gBo771S2abN6UVQe3Ic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=girPT0
        ZR/ovm2lRyOxP69B6Lpp1IrW5gegDiDWMcn4om8ynkCuMb3nygltGr1L8WH8nW+T
        FOGWirQZoGPn2B9FiJRRrdJchkRO2KyMPtNXBnTWoZxkGKSh3qAfwb4zgI3NoNhy
        nutbanx4ZY6BJ7A2at9G3Kq94fXmvKqTVqGgQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 88533CB7E4;
        Fri,  5 Jan 2018 13:52:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1D97CB7D7;
        Fri,  5 Jan 2018 13:52:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>, git-for-windows@googlegroups.com
Subject: Re: [PATCH v2 2/2] Windows: stop supplying BLK_SHA1=YesPlease by default
References: <20171228140742.26735-1-avarab@gmail.com>
        <20171228140742.26735-3-avarab@gmail.com>
        <alpine.DEB.2.21.1.1801041828540.31@MININT-6BKU6QN.europe.corp.microsoft.com>
        <871sj5cw9i.fsf@evledraar.gmail.com>
Date:   Fri, 05 Jan 2018 10:52:19 -0800
In-Reply-To: <871sj5cw9i.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 04 Jan 2018 19:30:01 +0100")
Message-ID: <xmqqy3lccf4s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8F44882E-F249-11E7-AB96-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> So I would like to ask to skip this patch for now, and take Jeff
>> Hostetler's patch as part of the MSVC patches later, once they have be=
en
>> matured in Git for Windows?
>
> Sounds good to me. Junio, could you please drop this one and just take
> 1/2?

Done. Thanks, both.
