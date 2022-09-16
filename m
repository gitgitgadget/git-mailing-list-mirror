Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D319AECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 20:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiIPUJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 16:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiIPUJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 16:09:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A30B7282
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 13:09:14 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A6D31BA79D;
        Fri, 16 Sep 2022 16:09:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bC1EQSr+y09mcL9oELolShJ7+hT2nRA0C2FeCE
        DboVA=; b=JgYjxedOvKibu6p4ebaZHvXMos979ZoPMlIZPuTYty0D5HkI7Hpbm1
        EqtVR48DmcA9XFdeyfrEMKSKW6NW6bEHTjmuS/rudmQfM2fX7q2V4oStejmR++hs
        vLOlXDASo479nkittbeWC7Z9hhVkzkKd6vmvk/Oju/YyHi+JUb314=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7119D1BA79C;
        Fri, 16 Sep 2022 16:09:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 425B11BA79B;
        Fri, 16 Sep 2022 16:09:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v7 0/6] fsmonitor: option to allow fsmonitor to run
 against network-mounted repos
References: <pull.1326.v6.git.1663100858.gitgitgadget@gmail.com>
        <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com>
Date:   Fri, 16 Sep 2022 13:09:06 -0700
In-Reply-To: <pull.1326.v7.git.1663358014.gitgitgadget@gmail.com> (Eric
        DeCosta via GitGitGadget's message of "Fri, 16 Sep 2022 19:53:28
        +0000")
Message-ID: <xmqq5yhngjz1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B6041DC-35FB-11ED-97CC-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  5:  9c1f408ae6d ! 4:  3a9fe473cf4 fsmonitor: deal with synthetic firmlinks on macOS
>      @@ fsmonitor--daemon.h: struct fsmonitor_daemon_state {
>        };
>        
>        /*
>      -@@ fsmonitor--daemon.h: void fsmonitor_publish(struct fsmonitor_daemon_state *state,
>      -  */
>      - void fsmonitor_force_resync(struct fsmonitor_daemon_state *state);
>      - 
>      -+char *fsmonitor_resolve_alias(const char *path,
>      -+	struct alias_info *alias);
>      -+
>      - #endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
>      - #endif /* FSMONITOR_DAEMON_H */
>       
>        ## fsmonitor-path-utils.h ##
>       @@
>  -:  ----------- > 5:  4d00adb1deb fsmonitor: deal with synthetic firmlinks on macOS

"rebase -i" mistake or something?
