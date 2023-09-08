Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E4AEEB570
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 21:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbjIHVap (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 17:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjIHVan (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 17:30:43 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6E919B6
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 14:30:39 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61FF71F7A8;
        Fri,  8 Sep 2023 17:30:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=v/jnW4W0BgOXUi8yGG86YXVgBVvbBZ0NbM9h3m
        flN8A=; b=dJKcDhS9ihz8q1mJuV3H9qpGNSx7bI0mWkW0r94nPtDcKGDSR1IQ12
        zs7WjBrIWaMlbdXF1F6D/j+ne5VX6JltgqXKqAMtL5IgbvAX3v8miHEe7100fMO2
        W9gF/8/v3e1ZcBI0Cn/2/uA3UVY6AMw1ECwjmI6K5AsKacM+VABr4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A5E71F7A7;
        Fri,  8 Sep 2023 17:30:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 039A01F7A6;
        Fri,  8 Sep 2023 17:30:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, nasamuffin@google.com,
        jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Subject: Re: [PATCH v3 0/6] Introduce Git Standard Library
In-Reply-To: <xmqqr0n8s8ps.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        08 Sep 2023 13:36:47 -0700")
References: <a0f04bd7-3a1e-b303-fd52-eee2af4d38b3@gmail.com>
        <20230908174134.1026823-1-calvinwan@google.com>
        <xmqqr0n8s8ps.fsf@gitster.g>
Date:   Fri, 08 Sep 2023 14:30:33 -0700
Message-ID: <xmqqjzt0s686.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F22B688E-4E8E-11EE-B06D-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Calvin Wan <calvinwan@google.com> writes:
>
>> I have taken this series out of RFC since there weren't any significant
>> concerns with the overall concept and design of this series. This reroll
>> incorporates some smaller changes such as dropping the "push pager
>> dependency" patch in favor of stubbing it out. The main change this
>> reroll cleans up the Makefile rules and stubs, as suggested by
>> Phillip Wood (appreciate the help on this one)!
>
> What is your plan for the "config-parse" stuff?  The "create new library"
> step in this series seem to aim for the same goal in a different ways.

Actually, this one is far less ambitious in touching "config"
subsystem, in that it only deals with parsing strings as values.
The other one knows how a config file is laid out, what key the
value we are about to read is expected for, etc., and it will
benefit by having the "parse" code separated out by this series, but
they are more or less orthogonal.

Queued.  Thanks.

