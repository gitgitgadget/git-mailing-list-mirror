Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30BFC433E6
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3FDF23A9A
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbhANU6n (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 15:58:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61145 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbhANU6n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 15:58:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D5619E246;
        Thu, 14 Jan 2021 15:58:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ESluDod6pWabV2ZZskS6k8yswn4=; b=Y08GJj
        LuKc80xt1tt0fcXZvVCe9Oi0OVKYsVrFTzHEWR2CynzJnB7ebx2JH8R4neufpD8w
        Z7XM/jFfjuPa+B1bjCYCiXKzI35qPHcFLwE4RiVCqZ7Ti1maC+djq941akD2Q1dD
        +Hh8ae1Dmp+/H99qPi3jcoZGESakdVlEPjq9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FSrUJfuvVuhTO3OY0e3fBIphWcFq3Wqr
        xgu+irMMm35Moou7CGgdE7z5tCnA6X81Wi+aXtX9jr9zGcB/HKf7wszt400p3THw
        uoUgPbrQu37X0F6asIUoeV/hOmaRt5XY0k+B3yWKu91fb2cICLgbiDvFlS2EVbir
        0pU8AQYJP6g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 499B39E244;
        Thu, 14 Jan 2021 15:58:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B883B9E243;
        Thu, 14 Jan 2021 15:57:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, jrnieder@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v2 1/8] packfile: prepare for the existence of '*.rev'
 files
References: <cover.1610129989.git.me@ttaylorr.com>
        <cover.1610576805.git.me@ttaylorr.com>
        <6742c15c84bafbcc1c06e2633de51dcda63e3314.1610576805.git.me@ttaylorr.com>
        <xmqqsg74x9ks.fsf@gitster.c.googlers.com>
        <YACJsdDToLQ24p/Y@nand.local>
Date:   Thu, 14 Jan 2021 12:57:59 -0800
In-Reply-To: <YACJsdDToLQ24p/Y@nand.local> (Taylor Blau's message of "Thu, 14
        Jan 2021 13:13:05 -0500")
Message-ID: <xmqqmtxbw814.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F4ACAF4-56AB-11EB-ACB0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Your response did pique my interest, since I was wondering if we could
> improve the cold cache performance if the .rev file's contents were
> included in the .idx,...

Yes, that was the primary thing I was wondering.  As long as it was
considered and rejected for good reason, that is good.

Thanks.


