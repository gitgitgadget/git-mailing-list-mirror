Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D953C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4650B610C9
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 23:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbhIIXbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 19:31:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57165 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbhIIXbu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 19:31:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CEE81F0FA5;
        Thu,  9 Sep 2021 19:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sFusUNoJIkNIUczH6P7S/qoVkVTFkk5o2Zbdy0
        MqVhY=; b=kSKRhSJ+coy/xaZ2XVq9YAKAdc4PErJBWxnFn4/HRVMRQSr8BW2nqM
        0TVDa7u6GupIpIjtPwybKnc0zbc3HdRjRCskfjIjAhwjbt+0ndEriKwoB/0waRZ9
        mlqU1noDIbyfF+iBlTYcsXL0Z7g17QFxn8qoksCr59HZYiy2+LbWg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6653F0FA4;
        Thu,  9 Sep 2021 19:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D142F0FA3;
        Thu,  9 Sep 2021 19:30:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH 3/9] pack-write: refactor renaming in finish_tmp_packfile()
References: <cover.1630461918.git.me@ttaylorr.com>
        <cover.1631157880.git.me@ttaylorr.com>
        <35052ef494dbc55119614f3e22742d8d814b21b1.1631157880.git.me@ttaylorr.com>
        <xmqqk0jpzgxu.fsf@gitster.g> <YTp3rYqxLE5/X521@nand.local>
Date:   Thu, 09 Sep 2021 16:30:38 -0700
In-Reply-To: <YTp3rYqxLE5/X521@nand.local> (Taylor Blau's message of "Thu, 9
        Sep 2021 17:07:57 -0400")
Message-ID: <xmqqilz9wcm9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1209CA0-11C5-11EC-9988-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> In each of these three, I wasn't able to decide if you wanted these
> addressed in a newer version of this series, or if you were happy enough
> with the result to pick it up. I'm happy to send you a new version, but
> don't want to clog your inbox if you were already planning on picking
> this up.

Well, it is often a no-cost operation to replace a topic that has
been in 'seen' with a newer round, so you do not have to worry about
my inbox.  As I often say, if it turns out to be a bad idea, I can
just drop it from 'seen' as if I didn't see it ;-)

Anyway.

If a newer version will come, I'd love to see the review comments at
least considered (be it from me or from anybody else) --- after all,
if the original were good enough, reviewer(s) wouldn't have raised
them as potential issues.

Of course, "considered" is the key word.  No need to blindly follow;
as long as there is a solid reason to justify why changing would be
worsening the well-written original.

Thanks.
