Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D22B1F732
	for <e@80x24.org>; Thu,  8 Aug 2019 16:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390179AbfHHQAJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 12:00:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62409 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732698AbfHHQAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 12:00:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4BED1538BE;
        Thu,  8 Aug 2019 12:00:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DfMgc8tlMJOGv1zyWd05Qk0N8HQ=; b=vNAo4g
        ZGzggyGkXpUTNQKjkwoWW5V3l7N67UVGOUb+W1NAVKtkn3ltTkYDN6PIubvzLFjV
        /9pagvwyK0PwhdvaAV+r7Q0ndbP8iOwnLPiS8fUMcJelrcRnCwIjGsTq8m0jQEAq
        KxwepT84mbTvwq8DGay7cFu+KLS4GsVc6DiGM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GiK3OTZ26xigtiFVyKu0Kdd2ycs4SUl9
        ZAjKfT+sG2k+6Tuh3uKtyMHZ0bTjXUNcmrROg82xaGLUiQ898g/MaSX9g9oBHBGA
        uXuhUQ+45Rg34jgOi9dDzRfwh0uyS7fj2flvEq9DQY1lyEYrsyn31Cdqy6jy2P3b
        3M7daYDxWnQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB1A31538BD;
        Thu,  8 Aug 2019 12:00:06 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2083F1538BC;
        Thu,  8 Aug 2019 12:00:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        GIT Mailing List <git@vger.kernel.org>,
        Thomas <t.gummerer@gmail.com>, Elijah <newren@gmail.com>,
        Dscho <Johannes.Schindelin@gmx.de>,
        Martin <martin.agren@gmail.com>
Subject: Re: [GSoC][PATCHl 3/6] rebase -i: support --committer-date-is-author-date
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
        <20190806173638.17510-4-rohit.ashiwal265@gmail.com>
        <e2ce49a2-3681-23a8-baad-5dfcea7cbe77@gmail.com>
Date:   Thu, 08 Aug 2019 09:00:04 -0700
In-Reply-To: <e2ce49a2-3681-23a8-baad-5dfcea7cbe77@gmail.com> (Phillip Wood's
        message of "Thu, 8 Aug 2019 12:29:20 +0100")
Message-ID: <xmqqwofnfy0r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96EB7C5C-B9F5-11E9-9EEF-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> ...
> I think it would be better to handle committer_date_is_author_date in
> a single place in this function, not have two implementations one of
> ...
> git has a high level api for manipulation author/committer information
> in ident.c, it would be best to use that. In any case code like this
> should be using strbuf's rather than malloc
> ...
> Do the committer_date_is_author_date check after the end of this if.
>
> Best Wishes
>
> Phillip

I've read all your review comments for this round, and they all
cover good points.  Thanks for a good reviewer and a mentor.  After
reading the patches myself, I have little to add ;-)
