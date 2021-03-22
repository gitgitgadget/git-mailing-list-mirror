Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F050DC433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 04:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF1A61968
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 04:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCVE1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 00:27:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63459 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhCVE1P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 00:27:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A0E6C75B5;
        Mon, 22 Mar 2021 00:27:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vkDUnQF+wkAt
        h4qWqzHMrk/rSUc=; b=R876O2D3UnPSUUrgT6BTTwTP2NULLgblfdm6rQHuRnMl
        /SB2z04zXLmaBTh1HOtPKSMCsa6UC2HWAA7fnTMEY/UT8EGpSRF5L5E1V3L+2gzV
        mqQ728EyQ7Pvk+nZreA4tJVZQW76lVr5sTvY0LabPIjH5aSPteWlqQhcs7rTITA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CVGo8f
        jiIV9TYwulNiaAfYQ15Qk45eES4eXrEooqcCIn7FcH8ZdIZH/EToTzWAof+o8eWl
        PrQh+2TNy3laQsMBXVLlx5AfUQs+zBibj9/w6HHN+OX2+vmbsSPoxQXZEEtMjYTv
        6y7siS/7kikgGH1bFLzn1bP7PVbfP2UJJX2QM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 726B0C75B4;
        Mon, 22 Mar 2021 00:27:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F3250C75B3;
        Mon, 22 Mar 2021 00:27:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 0/2] diff --no-index: fix test blind spots
References: <cover.1616330120.git.avarab@gmail.com>
        <cover.1616366036.git.avarab@gmail.com>
Date:   Sun, 21 Mar 2021 21:27:13 -0700
In-Reply-To: <cover.1616366036.git.avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sun, 21 Mar 2021 23:36:18 +0100")
Message-ID: <xmqqblbb95jy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E0885CA6-8AC6-11EB-9916-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Fixes a stupid s/Test/test/ typo in v1. Thanks Ramsey. I also noticed
> a failure on one of the Windows CI's (curiously, not all?), so
> POSIXPERM for these tests is another thing I forgot.

Nice.  Thanks for a quick reroll.
