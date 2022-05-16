Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E303CC433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 22:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348558AbiEPWQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 18:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348484AbiEPWQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 18:16:16 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436672C10B
        for <git@vger.kernel.org>; Mon, 16 May 2022 15:16:15 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9918412860B;
        Mon, 16 May 2022 18:16:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pSjqLJ5B3rN9u+MJsT82a/PjqpevpOvN8NSmp3
        +wAsA=; b=lylaF1tmrhpDnz7Kof/c9D2wQ3/lm1Ctl9XfqA31X67cP0awr0wfKx
        cQF5lZP36pM8C2C7vrEXle0sndengzhpHn8O4zam/ZZJnY6jwfsSkHfXqfL9J+/+
        ATO0pFbrNvXCgRsCZ2g89raunoTB4LoUQo0LO5IDrOCCWnsXbs9cs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9162F128608;
        Mon, 16 May 2022 18:16:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EC906128607;
        Mon, 16 May 2022 18:16:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v2 0/2] setup.c: make bare repo discovery optional
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
        <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
        <xmqqy1z12zxr.fsf@gitster.g>
        <kl6ly1z1iati.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqk0al1e50.fsf@gitster.g>
        <kl6lv8u5i5pn.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 16 May 2022 15:16:12 -0700
In-Reply-To: <kl6lv8u5i5pn.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 16 May 2022 13:27:00 -0700")
Message-ID: <xmqq8rr115ub.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC6EE4DE-D565-11EC-B5D2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> which I took to mean "Junio thinks that, by default, Git should stop
> walking up to find a bare repo, and thinks this is better because of
> rationale X."

The X is "it would not break existing use case too badly, just to
address a 'security' story whose severity is not so clearly
expressed".

> If it the latter, then I'm in favor of taking Stolee's suggestion to
> drop "cwd", since nobody else finds it useful enough. (I like the
> 'simplification' story, but not enough to push "cwd" through, especially
> since it does quite little security-wise.)

As long as you'll be there to answer the angry mob that complain
loudly (and irritatingly enough, the only do so after a release is
made to flip the default), I do not care too much either way ;-).

Thanks.

