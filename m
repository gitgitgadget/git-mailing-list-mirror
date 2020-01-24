Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E200C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 19:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234332077C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 19:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L2BIYEMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389804AbgAXTWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 14:22:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55987 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387683AbgAXTWk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 14:22:40 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DD604151A;
        Fri, 24 Jan 2020 14:22:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qftR4JmDblMJvDG/VX7aAz9BRlY=; b=L2BIYE
        Muv438VJc8s5CKH1RakENz/4OmHuQoafVBtaUUDxoOmgRU/mmAELxtq761Gn6jSV
        XEmXE7+LQDK+gG/yVGEdz9/Es7fVbLUq3hWgQBvt7XsVFnx8s3PF2PKhxQHBQRsQ
        hHOQa3oOAUrIJGaa/NchdA19fBAhud1JrkuuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vyi6y1AbtZtWmkqr47Eyah5t9Vng1Ih6
        /UD+VK5CnVmu2/tMO7iGDlCDgeeSHAZhKbZzOUQHjRzbKnTG++LUVn4BD8ee3uZJ
        vAOWJB1iaNIwHiWvfeKUhHoNO8LrRO8B/vEXP8HPH/bmiaMFD8WCUoaGJfmouryH
        iwNd2S7lxUk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7601841519;
        Fri, 24 Jan 2020 14:22:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DBB3F41518;
        Fri, 24 Jan 2020 14:22:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v4 0/6] config: allow user to know scope of config options
References: <pull.478.v3.git.1579275102.gitgitgadget@gmail.com>
        <pull.478.v4.git.1579825267.gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 11:22:36 -0800
In-Reply-To: <pull.478.v4.git.1579825267.gitgitgadget@gmail.com> (Matthew
        Rogers via GitGitGadget's message of "Fri, 24 Jan 2020 00:21:00
        +0000")
Message-ID: <xmqqo8uszmkj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1BD5188-3EDE-11EA-926C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This was originally a pull request to the git-for-windows repository
> [https://github.com/git-for-windows/git/pull/2399]. It adds a new option
> --show-scope which would allow a user to see what scope a given
> configuration value has (sytem, local, global, etc.).

These generally look very good.

I'll queue them with proposed fix-ups, so please do not waste your
time by reworking on your patches in response to my review comments
before fetching today's integration result from the public
repository, which probably will happen in 5 hours or so.

Thanks.
