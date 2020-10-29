Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E77C2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 20:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B282120759
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 20:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SyL75Y3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgJ2UTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 16:19:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51526 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgJ2UTw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 16:19:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ECA027E95E;
        Thu, 29 Oct 2020 16:19:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IJWVZRWj+f45r3HpATm5CimfeZs=; b=SyL75Y
        3rSs1oQ0sJBxRSP0P34AHZb8K2lD2bvhiPG7eM2ckkOTBdIvMGqXeBvZSm4eUC3k
        h8vPrBIwJt33P8ZYM0H9mWrkh7FPNiAPMjiWCb5cD/lHv8nhbb/i39Fptb3Nra9p
        t9ry6N4NHn/QBiIOmdxVxr8UFoPwCL6/5wANI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dFz78G8250XI/0OYw5YOFbtvd50oqa1h
        x9Q45DJ1xX0Dcwot72IIGm/CIz8lzrgwray7ESeq+B4eAd3BHjiMB0nD1VonKSZj
        cnIv2sdbZb8+PoSt3eoOsgL6Kks4pJl6tnbcSU6EBvjs43eSikUYhZQuFjt0WbJP
        ezLqYjW5HN4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D383F7E95D;
        Thu, 29 Oct 2020 16:19:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 48D637E95C;
        Thu, 29 Oct 2020 16:19:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 2/6] doc: line-range: improve formatting
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
        <7d3fc0a503b160ea15363a4465af4647bce6a30b.1603889270.git.gitgitgadget@gmail.com>
        <CAPig+cQcjjj3x_iTDX=yBUai6xHrShsGO5J3sdpX-2UhM7_OJQ@mail.gmail.com>
Date:   Thu, 29 Oct 2020 13:19:48 -0700
In-Reply-To: <CAPig+cQcjjj3x_iTDX=yBUai6xHrShsGO5J3sdpX-2UhM7_OJQ@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 28 Oct 2020 13:23:02 -0400")
Message-ID: <xmqqblgk7pjv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1843DA94-1A24-11EB-9D36-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Oct 28, 2020 at 8:48 AM Philippe Blain via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Improve the formatting of the description of the line-range option '-L'
>> for `git log`, `gitk` and `git blame`:
>>
>> - Use bold for <start>, <end> and <funcname>
>
> My impression is that it is more common in Git documentation for these
> placeholders to be formatted with backticks rather than as bold (or,
> if not more common currently, at least is trending that way). That's
> not to say that my impression is necessarily accurate.

I think the impression is fairly in line with the reality.  That is
not to say that it is a good future to aim for.

My personal preference is

    - use `as-is` for things that must be typed as-is (e.g. `-L`)

    - use 'emph' for things that are placeholder (e.g. '<start>'').

