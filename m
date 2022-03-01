Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620C2C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 17:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbiCARiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 12:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbiCARiB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 12:38:01 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589612F022
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 09:37:20 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C941B18C8B3;
        Tue,  1 Mar 2022 12:37:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4K5ULTwil+lnFsmAve2wW/PRQAYfSK1LrzOfF9
        RXc1s=; b=TgjPuxeks5bCoHqvQrgFfNYKRnwBGGpdbudRrqPQM5zuLyN5x6GfHr
        TxJxqcHojfVFU0adBW2oau5chHHVnZxz9oBwpwopfRHMrKHvYkbiJmO/GSwK55Pm
        yB/guINJ4bm1q7JysBU1ud/FS9eL3Tk0y/Q2389FvId3JZiF1yGzw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C09CF18C8B2;
        Tue,  1 Mar 2022 12:37:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 15AFA18C8AF;
        Tue,  1 Mar 2022 12:37:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v5 06/30] fsmonitor--daemon: add a built-in fsmonitor
 daemon
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <bdd7334da3162ce77c216d61ce9d979f12637ac5.1644612979.git.gitgitgadget@gmail.com>
        <220225.865yp27e1c.gmgdl@evledraar.gmail.com>
        <ffcd037b-256c-2e4b-79b7-ae725ad17c04@jeffhostetler.com>
Date:   Tue, 01 Mar 2022 09:37:15 -0800
In-Reply-To: <ffcd037b-256c-2e4b-79b7-ae725ad17c04@jeffhostetler.com> (Jeff
        Hostetler's message of "Tue, 1 Mar 2022 09:58:42 -0500")
Message-ID: <xmqq35k1shf8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C7BD5C8-9986-11EC-8F46-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> Finally, I'm not sure how much value there is in being able to catch
> parse_options() BUGs on Linux (or any other yet-to-be-supported
> platform).

I don't either.  Even though I am not 100% happy with the current
implementation of the embedded sanity checker in parse-options API,
as long as it is made available on all platforms, developers of a
platform specific part can also take advantage of it to catch any
issues while they develop, without waiting for Linux (or other
platforms) users to help them do so.


