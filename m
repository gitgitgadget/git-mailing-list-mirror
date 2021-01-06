Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD6DC433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 20:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E3242312A
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 20:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbhAFUxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 15:53:17 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52323 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbhAFUxR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 15:53:17 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2E16F1159A1;
        Wed,  6 Jan 2021 15:52:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KKkKKvauTeMEuX65/CjTEffNSvU=; b=CEKrW0
        Sv5fUIJBALjM1avI1rf35ah2hCmToRob/qFscEnRrJo09gnd5DJ2V11Ov3G3GGTm
        ST4sc6XX3oamynfXfKlOx3ybrcWd3SH8QheWSrmKhLZH01HZ7RYW/Ns9jGuGuqjG
        GbVfUs2h6yPyreI+xdZzJOLv+Wsbiw1S70DzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o+GgHXWDQJ6W/jH+Q5IFXqruh/NXPQfO
        d8lYbPLHwGtOl4JuOFLRIpzAdGnPh9RcksAD9a68xWTR64J4urIDRQxdXP7wtoMl
        P6lq5E2gUK56QoNU22l4OPZU3hOqbSGPhAJUfspFJWD1kN3qc1VV5MR3cdbzl3CD
        hSr8BMT2HTk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2688D1159A0;
        Wed,  6 Jan 2021 15:52:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6B44A11599F;
        Wed,  6 Jan 2021 15:52:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 00/12] Remove more index compatibility macros
References: <pull.830.git.1609506428.gitgitgadget@gmail.com>
        <xmqqczyiwwgl.fsf@gitster.c.googlers.com>
        <a93359c3-66bf-80bc-f053-4742563163d0@gmail.com>
Date:   Wed, 06 Jan 2021 12:52:30 -0800
In-Reply-To: <a93359c3-66bf-80bc-f053-4742563163d0@gmail.com> (Derrick
        Stolee's message of "Wed, 6 Jan 2021 06:35:53 -0500")
Message-ID: <xmqqpn2hrdo1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18E3BE56-5061-11EB-B2BA-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> My intention was to reduce the use of globals in libgit.a while keeping
> with existing patterns of static globals in the builtin code.

The above (without having thought about it too hard or long enough
yet) sounds a sensible guideline to go by.  Thanks for a helpful
hint to keep in mind while reading the series.

> While
> this can be thought of "module variables" instead of true globals, they
> aren't exactly desirable. In v2, these static globals are temporary to
> the series and are completely removed by the end.

;-)
