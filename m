Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896BFC433E0
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 21:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D8C206D5
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 21:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Px0w2Qq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgFHVZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:25:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53321 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgFHVZf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 17:25:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E12B965CA9;
        Mon,  8 Jun 2020 17:25:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eizBqBeUYpU1asZZ2oOdNib+Tb4=; b=Px0w2Q
        q1eXTTvFpcYsjlxZzYLbG656ofT/szzc8p8a/R0T6T9H4mwCkUpF6UxPeIHlr76Q
        542Qiu1QQXwWqgDNHCLSOYObbvEV+yMaEdKZYERHBsmuCdHXKxickAf1V+J3El1e
        bILnHbTG60C432dudAcxBFJAF3Kyxv3s9MddU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gAf5HQF+S7SaJm5rGINBia5AgYSZycpz
        JcTAUy45OOkJSXBPPiUmc2XFI+dA9pH7Ke4hE+yIJ5Xg1d/RIy4aBdNlz29rsYUh
        AEwonq8jOpBLzA0J+0s1xGLBRsy0u9XojbKTW3P3ydiSO7zrf7PSmneKq5ntQ4Me
        HjM2mUOIszY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D790C65CA8;
        Mon,  8 Jun 2020 17:25:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5B71865CA7;
        Mon,  8 Jun 2020 17:25:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Jonathan =?utf-8?Q?M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [PATCH 3/8] worktree: give "should be pruned?" function more meaningful name
References: <20200608062356.40264-1-sunshine@sunshineco.com>
        <20200608062356.40264-4-sunshine@sunshineco.com>
Date:   Mon, 08 Jun 2020 14:25:31 -0700
In-Reply-To: <20200608062356.40264-4-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Mon, 8 Jun 2020 02:23:51 -0400")
Message-ID: <xmqqv9k1jlmc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95734336-A9CE-11EA-8B66-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Readers of the name prune_worktree() are likely to expect the function
> to actually prune a worktree, however, it only answers the question
> "should this worktree be pruned?". Give it a name more reflective of its
> true purpose to avoid such confusion.

100% agreed.
