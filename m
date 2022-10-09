Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F752C43217
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 23:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbiJIXqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 19:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiJIXpz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 19:45:55 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CF95A8AC
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 16:17:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 81A021C602A;
        Sun,  9 Oct 2022 18:24:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AugUy5QXGr0SZ3fLRn7JVBuCamPZcJ3NS7Gt6X
        qgiUU=; b=DZ0ZQa240MdEhWLSt0xfgoMigqP5My9Cl5GViv+8dNCE4+vXrFAg+p
        qbao4NzegeYzBv1GGIfD6tWfldoWH5KVI+vc4HLfVzeogO5I12cRdAAsQy3QLKoS
        xw+pmld0zpavd1qiLUOEXeE039Jpcxjjwh1lQlgN2PctmfP9rK51Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A4111C6029;
        Sun,  9 Oct 2022 18:24:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A6BBE1C6028;
        Sun,  9 Oct 2022 18:24:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH 00/12] fsmonitor: Implement fsmonitor for Linux
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
Date:   Sun, 09 Oct 2022 15:24:45 -0700
In-Reply-To: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com> (Eric
        DeCosta via GitGitGadget's message of "Sun, 09 Oct 2022 14:37:26
        +0000")
Message-ID: <xmqqsfjw63f6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E580170-4821-11ED-8A0F-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Goal is to deliver fsmonitor for Linux that is on par with fsmonitor for
> Windows and Mac OS.
>
> This patch set builds upon previous work for done for Windows and Mac OS
> (first 6 patches) ...

For those who are watching from sidelines...

The Windows part is already in Git 2.38; the changes needed for
macOS are already in 'next' and the first 6 patches in this 12-patch
series are identical to them.  The patches 7-12 are new.

> to implement a fsmonitor back-end for Linux based on the
> Linux inotify API. inotify differs significantly from the equivalent Windows
> and Mac OS APIs in that a watch must be registered for every directory of
> interest (rather than a singular watch at the root of the directory tree)
> and special care must be taken to handle directory renames correctly.

