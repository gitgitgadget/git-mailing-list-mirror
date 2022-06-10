Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451EBC43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 16:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349589AbiFJQaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 12:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbiFJQaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 12:30:13 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C53356764
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 09:30:12 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02A3D13DD2D;
        Fri, 10 Jun 2022 12:30:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SFvABJHVv5zmpYMAnCe1A5DypQMpokLcgB+ywo
        XZWO0=; b=GXtpz1TkHya5EAjmAjiwkcbyTnLLCb9Jt0eWHHGjeD3f3IzPKxBV/C
        dGIYk4T9XoYwOcViKlJNHn71FOB/+ThO1nU10/CaX29REnG3i0MaNofpKC7Dpoas
        G6yr8Zv6nKe6iwd/G8IUlgecSvIGbRctAn/cADFcRtcxzfvkEclT0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 607A713DD2B;
        Fri, 10 Jun 2022 12:30:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8FBBA13DD29;
        Fri, 10 Jun 2022 12:30:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] ci(github): also mark up compile errors
References: <pull.1253.git.1654774347.gitgitgadget@gmail.com>
        <19d6e34f038121b927cdfacc3c4ae5abd1791415.1654774347.git.gitgitgadget@gmail.com>
Date:   Fri, 10 Jun 2022 09:30:07 -0700
In-Reply-To: <19d6e34f038121b927cdfacc3c4ae5abd1791415.1654774347.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 09 Jun 2022
        11:32:27 +0000")
Message-ID: <xmqqzgikfpm8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 983B049E-E8DA-11EC-B7F4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +		sed 's/^\(\([^ ]*\):\([0-9]*\):\([0-9]*:\) \)\(error\|warning\): /::\5 file=\2 line=\3::\1/'

https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#setting-a-warning-message

seems to use comma as field separator, not SP, for files and lines.
We'll see if they are equivalent without getting documented soon, as
I will be adding this to my tree for 'seen' today.  We should throw
a build failure in to see its effect ;-)

