Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AD0A2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933792AbdCUS3e (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:29:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57918 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933760AbdCUS3T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:29:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 396C56EC7D;
        Tue, 21 Mar 2017 14:29:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=76EZNzqSjEP1
        lYGfi9AXv+oSqeA=; b=iCnzVmNA9LtQrLPfB7mbPgcF0yZY7ItXPdTBYNE1LcxY
        NHCls9zVqkr2LmPkWaZgfcnAUqonUKxz1lfwtTa6x2w4QZ18kAY/d1ZueJm3613J
        0tLKFLyxcDuB8eYmWz54bR76JARViiUZV/w6kL2KgP8vuvaQACSBQvjdOaMtTjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oRWM3h
        H5D0ciykENfKqVsZg4YG5YeiBj+WM+Teb1W+R3smFXXNdy07InFgiStL83/B9yfZ
        jTb3WobAdbgsX/3T40VN/NEGDSTj/sQCJSPZlPRyphONbaiBZtMnvrLBRF3zC8vW
        S9J3ffd3fuKEJX7NFkFH/xZWlc8bQ/eOj1GaA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30EBB6EC7C;
        Tue, 21 Mar 2017 14:29:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FE596EC79;
        Tue, 21 Mar 2017 14:29:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 05/16] ref-filter: add test for --contains on a non-commit
References: <20170321125901.10652-1-avarab@gmail.com>
        <20170321125901.10652-6-avarab@gmail.com>
Date:   Tue, 21 Mar 2017 11:29:16 -0700
In-Reply-To: <20170321125901.10652-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 21 Mar 2017 12:58:50 +0000")
Message-ID: <xmqq1stqqy9v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4B0248E6-0E64-11E7-8715-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the tag test suite to test for --contains on a tree & blob, it

Either s/, it/. It/ or s/, it/; it/.

> only accepts commits and will spew out "<object> is a tree, not a
> commit".
>
> It's sufficient to test this just for the "tag" and "branch" commands,
> because it covers all the machinery is shared between "branch" and

Either s/is shared/shared/ or s/is shared/that is shared/.

> "for-each-ref".
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---

The patch itself looks good.

Thanks.
