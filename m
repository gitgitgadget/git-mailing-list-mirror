Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F3451F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 21:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfHMVE0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 17:04:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60826 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfHMVEN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 17:04:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C8341719AB;
        Tue, 13 Aug 2019 17:04:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DOtvlz6+SqLRJIXOEUk264RvLR0=; b=RTRSTR
        XbdN36CWtIPGl5o8Dfp3wWA7Hf09TEleX+EfV/0ubX5PmMyEq7+c1DSrE2+UzP2w
        uJEVrqEl2auQZyBqsA10kdeNgOUts6U1W4ai7p1raLxZUVTmy90odDwIRcJUQtmw
        IdTguljrYQPEqTI6FxXwWf3RDGJLOH9GAkblk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AOjg2U/ZsqxuiosEF4k0nCXTKqOBipZM
        fgKCIl8mchHWx2RAQTw1KzhKlRijkvZyZGvitu19LzM8kY5cWs9MU5Gv58jQKLW3
        xDcryZVWfnDyAGcvaiD+8T66YohsccHhA6dd9p5h9PLgUcB5Mi3a/xc2XPXUZy+f
        jLRDQWC8HGw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 74FCE1719AA;
        Tue, 13 Aug 2019 17:04:11 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DFBE81719A9;
        Tue, 13 Aug 2019 17:04:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v4 0/6] Create 'feature.*' config area and some centralized config parsing
References: <pull.292.v3.git.gitgitgadget@gmail.com>
        <pull.292.v4.git.gitgitgadget@gmail.com>
Date:   Tue, 13 Aug 2019 14:04:09 -0700
In-Reply-To: <pull.292.v4.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Tue, 13 Aug 2019 11:37:42 -0700 (PDT)")
Message-ID: <xmqqmugc7p6e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5B72004-BE0D-11E9-91EE-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * Update docs and 0 constant in feature.experimental around
>    merge.directoryRenames.

I somehow thought that the concensus was that *.experimental is for
things that should become the future default, and this one is not
something we would want to make the default.

