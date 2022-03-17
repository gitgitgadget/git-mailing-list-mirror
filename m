Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD54C433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 16:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbiCQQc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 12:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiCQQc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 12:32:28 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C126216017B
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 09:31:10 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C3061287EF;
        Thu, 17 Mar 2022 12:31:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hUAmvA09itxQ03rD6s4IcVRIvy79RdMQBfQJTM
        ooWJc=; b=mAxWsInwjK+PVn1X8nUD3P15nrQ2ZBXHDti1zv3kqyvcxmJbCDvZTW
        OwNkd0DXn2Gh9PMf7gW3xcGdfcqazLr4+9hbVgR/F8xa57FxjKBehOP5zWTSuUcY
        GVHj0e/0t2LKKsyxafrR3RjB40E0GpxhxdTnwcTwJPPDAbDa5gKDk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E18511287EE;
        Thu, 17 Mar 2022 12:31:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ACBB41287EB;
        Thu, 17 Mar 2022 12:31:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/13] tests: add and use a "test_hook" wrapper +
 hook fixes
References: <cover-v2-00.10-00000000000-20220307T123909Z-avarab@gmail.com>
        <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
Date:   Thu, 17 Mar 2022 09:31:04 -0700
In-Reply-To: <cover-v3-00.13-00000000000-20220317T100820Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 17 Mar
 2022 11:13:05
        +0100")
Message-ID: <xmqqpmmkh77b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A53F730E-A60F-11EC-A2EC-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a quick update before I finish my first integration cycle of
today.  t543 has a "test_hook" call inside a subshell, but because
the helper runs test_when_finished, a sanity check kicks in and
fails the test.

I'll continue the integration cycle with this topic kicked out of
'seen' for now.
