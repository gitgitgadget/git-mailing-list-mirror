Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D776C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 20:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A246103A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 20:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbhHMUax (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 16:30:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60885 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbhHMUaw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 16:30:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0444EDF984;
        Fri, 13 Aug 2021 16:30:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ydyaaaW0WbnjLr4IHDZ5APCy6psi9qqYOp02q8
        o64UI=; b=xGiczmLO99L9RCiaMc7PMgAUDuw2SX711HlG449psQFW/mslrIHohx
        eq017cc4wNWdqD1Kgs6dMttKP9jFzQsRIHbELli0aG9XrftySSVg1GBbPXDv5byQ
        7oWs93b5UKyu3+BdH03GJg7MrP5ayHpAN8jbsGe20UPPpmutqNwZY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CA5B7DF983;
        Fri, 13 Aug 2021 16:30:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 257BFDF981;
        Fri, 13 Aug 2021 16:30:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Mahi Kolla <mahikolla@google.com>
Subject: Re: [PATCH v5] clone: set submodule.recurse=true if user enables
 feature.experimental flag
References: <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
        <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
        <xmqqeeaz70ph.fsf@gitster.g> <YRW0pGXXWnY7C470@google.com>
        <xmqqpmuiynbs.fsf@gitster.g> <YRbU0uBxqinQ1EnE@google.com>
Date:   Fri, 13 Aug 2021 13:30:22 -0700
In-Reply-To: <YRbU0uBxqinQ1EnE@google.com> (Emily Shaffer's message of "Fri,
        13 Aug 2021 13:23:46 -0700")
Message-ID: <xmqqv949uly9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49ABD1FC-FC75-11EB-B056-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> I think the right move, then, is to explore whether your suggestion in
> https://lore.kernel.org/git/xmqqeeaxw28z.fsf%40gitster.g is appropriate
> - I have the sense that it is, but I want to make sure to think it
> through before I say so for sure. 

Not that one---it was a 40% tongue-in-cheek comment, and does not
deserve to be called a suggestion.  
