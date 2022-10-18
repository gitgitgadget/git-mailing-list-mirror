Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96421C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 18:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiJRSeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 14:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiJRSei (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 14:34:38 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC34911461
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 11:34:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DCEF150615;
        Tue, 18 Oct 2022 14:34:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lzY8hzjs2GVAh+PTogE1oGP9NIyOONcVvJXyPI
        VI8OY=; b=bPe5pstY/XY0YZifqUnWckok9cm3Tav/139TEGC3WasASfHfuLqqhW
        1hfW/9biAGdICoIzHkXPgvoKIuP9jpG+FUxG1SEOPLV1oUohXDPO4ozXxcMOdQwr
        2/tl+KEBcgSyoTSawacDq8y0gk9BL7GNtA0IF4rK5xkgjjssgjdFo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 52E9C150614;
        Tue, 18 Oct 2022 14:34:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A1262150612;
        Tue, 18 Oct 2022 14:34:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/9] archive: Add --recurse-submodules to git-archive
 command
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
        <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
Date:   Tue, 18 Oct 2022 11:34:28 -0700
In-Reply-To: <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com> (Heather
        Lapointe via GitGitGadget's message of "Mon, 17 Oct 2022 02:23:12
        +0000")
Message-ID: <xmqqo7u9t1zf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80796E8C-4F13-11ED-9E83-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Today I was scheduled to be offline, so I won't dig further on the
issues this topic has now, but the new tests this series introduces,
namely t1023 and t5005, both relies on being able to clone a nested
submodule via file:// transport, which no longer is allowed.

The patches need to be updated to adjust to the new world order, of
course, but we probably should take it as an example of what the
most recent update may be breaking for real world users.

Thanks.
