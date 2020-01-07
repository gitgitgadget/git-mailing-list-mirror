Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4531DC33C9B
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 21:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1C82072A
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 21:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YwJ7CDWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgAGVvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:51:47 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50161 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgAGVvp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 16:51:45 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95D3390212;
        Tue,  7 Jan 2020 16:51:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VTywSyi+e6yiq0+iQkkzObc0w34=; b=YwJ7CD
        WZdbqZMwJRoNiFO+UKM0NManYxtPDb8aNuHXCOVcqAjs6jre6ibSOTYAQDy72zYk
        GKoAQ2Y89RewlLnTYqwX7MNR2hXHPQgvjoi06GLRl9f7zNV3AnS5kY8OL5aWTzmk
        telv8Iw1afcgpWMYfa8JLP6hqnOUS/ZZDLl2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z4cS5C2MKKXuH/5XiaXjGBQCxR+mgmxa
        77hNr/n7LY0px5cknyX/0zeztwTDaMVNbBGflF+1bCu6rSoLTkEBXOT5GTyFVE6p
        s4SPfbg2eymE0se1qzN/AoeVjgQCv2AnSkWwKAK2g9gFr8z3lOscXyQZltxfEOJP
        6wtDB0o87RQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D52690210;
        Tue,  7 Jan 2020 16:51:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B11309020F;
        Tue,  7 Jan 2020 16:51:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, brad@brad-smith.co.uk,
        sunshine@sunshineco.com, James Coglan <jcoglan@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/2] graph: fix lack of color in horizontal lines
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
        <pull.517.v2.git.1578432422.gitgitgadget@gmail.com>
        <11887bd38d73b48c6677ef1e8fe2b9f0c295c8a0.1578432422.git.gitgitgadget@gmail.com>
Date:   Tue, 07 Jan 2020 13:51:38 -0800
In-Reply-To: <11887bd38d73b48c6677ef1e8fe2b9f0c295c8a0.1578432422.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 07 Jan 2020
        21:27:02 +0000")
Message-ID: <xmqq8smj3pg5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E30E96FE-3197-11EA-9207-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> In some cases, horizontal lines in rendered graphs can lose their
> coloring. This is due to a use of graph_line_addch() instead of
> graph_line_write_column(). Using a ternary operator to pick the
> character is nice for compact code, but we actually need a column to
> provide the color.
>
> Add a test to t4215-log-skewed-merges.sh to prevent regression.
>
> Reported-by: Jeff King <peff@peff.net>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---

Thanks.  Looks good.
