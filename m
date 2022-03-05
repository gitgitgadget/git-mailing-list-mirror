Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57263C433EF
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiCEAlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiCEAlw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:41:52 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E00159EBC
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:41:01 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E143D17ABA9;
        Fri,  4 Mar 2022 19:41:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C3ITa8kO+a2eOrs5nicOlSXGO+jDyahGmPaiCf
        /L7Jw=; b=w2NC3aO4LBCuYeNnJ9H3h6tF7qNrnjciuHD7ukCHwyNDR98EMgu8kP
        0g3ip/58Voo9TmuHp4jbbDgyeEWVghVVmElkKwgkivc9+VJqFRozvTWoOtMbX0Bj
        0zKlj7OUU2SkWEuB6k1FA0tE5Y4QB0q+fiwFGRmvcKvTddNS0rzkE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D9EBC17ABA8;
        Fri,  4 Mar 2022 19:41:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 40EAB17ABA2;
        Fri,  4 Mar 2022 19:40:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r?= =?utf-8?Q?=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v4 00/13] submodule: convert parts of 'update' to C
References: <20220303005727.69270-1-chooglen@google.com>
        <20220305001401.20888-1-chooglen@google.com>
Date:   Fri, 04 Mar 2022 16:40:56 -0800
In-Reply-To: <20220305001401.20888-1-chooglen@google.com> (Glen Choo's message
        of "Fri, 4 Mar 2022 16:13:48 -0800")
Message-ID: <xmqqfsnxw7s7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EBECE0FE-9C1C-11EC-9DEC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Original series: https://lore.kernel.org/git/20220210092833.55360-1-chooglen@google.com
>
> = Patch summary
>
> - Patch 1 adds extra tests to "git submodule update" to make sure we
>   don't break anything
> - Patch 2 removes dead code that used to be part of "git submodule
>   update"
> - Patch 3 prepares for later changes by introducing the C function that
>   will hold most of the newly converted code
> - Patch 4 moves run-update-procedure's --suboid option into C
> - Patch 5 moves ensure-core-worktree into C
> - Patches 6-8 move run-update-procedure's --remote option into C
> - Patches 9-11 move "git submodule update"'s --init into C
> - Patches 12-13 move "git submodule update"'s --filter option into C

Looking good.  Will queue.

Let's see if there are further comments before declaring victory and
merging it down to 'next' shortly.

Thanks.
