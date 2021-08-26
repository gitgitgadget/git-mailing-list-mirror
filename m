Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA740C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 15:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA9D61026
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 15:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbhHZPGW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 11:06:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54886 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhHZPGV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 11:06:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3BA30149A83;
        Thu, 26 Aug 2021 11:05:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KE1bfVB9/+j1
        2spJf/AfWK9VPyH09wThE+qe3EY+KQc=; b=PoeQFGdAny0QlbWz1ccVHq2iniv1
        8LuXGS788aLfohhBYrSEaB/Hm1jAQOPgBfh5EBGj/h7o8iY1eeKX+IJMEnbAToab
        /vhghUGi4k8Llqi3j9L28zb7Ynds1TIUB8KGHB/H7hQMqDxPR7lfdzxx5gD2iMhT
        cSCWCgGsOpk3KEk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3289B149A82;
        Thu, 26 Aug 2021 11:05:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 07542149A7E;
        Thu, 26 Aug 2021 11:05:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v4 00/28] Support reftable ref backend for Git
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
        <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
        <xmqqfsuwha5p.fsf@gitster.g>
        <CAFQ2z_NBmKrVMeuTb=qeG_VSBWC7287-gGB9GhpokLZrmNiC0A@mail.gmail.com>
Date:   Thu, 26 Aug 2021 08:05:28 -0700
In-Reply-To: <CAFQ2z_NBmKrVMeuTb=qeG_VSBWC7287-gGB9GhpokLZrmNiC0A@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 26 Aug 2021 10:56:28 +0200")
Message-ID: <xmqqbl5kgsav.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0D99D934-067F-11EC-BA17-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> The bottom part of the errno series that I contributed has had ample
> scrutiny. It's a cleanup, and all-in-all much less experimental than
> the reftable work.  However, because it changes a calling convention
> in the ref backend API, it causes difficulty with other topics
> (notably: reftable). I would be in favor of graduating the series upto
> "refs: make errno output explicit for read_raw_ref_fn" early to
> provide a stable basis for other patches.

Very glad to see that the two of you are in agreement of the order
and the approach.  Let me replace the topics that have been queued
on 'seen' with the latest ones from =C3=86var, and we can go from there.

Thanks for a quick response. =20

