Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B6CC433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 18:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240654AbiGNSZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbiGNSZL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 14:25:11 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3716A9E0
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 11:25:08 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D31E12DF10;
        Thu, 14 Jul 2022 14:25:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eapszDerQ8+qI1Gzf2EeLitUEza3EA3gcBdzeI
        wwCRU=; b=E6gXAObPiu1plQfyci1q2DJ6v/CLnOUmyT35Z9RpVZOJP8LOk9ZEuP
        PtvXDe2m+bnohY9GiofFw9ge+OkBgRJC5i4z2064sJ1kazmqXhyqGLuru7vHxfCW
        JpNXn4WOL7NohiEJKwqjQSXIKf3IK/XEzTzxXWINW8k0lCj0d9u1E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 87CEB12DF0E;
        Thu, 14 Jul 2022 14:25:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9E7B712DF0D;
        Thu, 14 Jul 2022 14:25:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] shortlog: use a stable sort
References: <pull.1290.git.1657813429221.gitgitgadget@gmail.com>
Date:   Thu, 14 Jul 2022 11:25:05 -0700
In-Reply-To: <pull.1290.git.1657813429221.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 14 Jul 2022 15:43:49
        +0000")
Message-ID: <xmqqr12n5z7i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 493D3168-03A2-11ED-9F64-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>     why does our current CI not fail in the vs-test job?". The answer is
>     surprisingly trivial: Because our CMake-based definition universally
>     defines INTERNAL_QSORT
>     [https://github.com/git/git/blob/v2.37.1/contrib/buildsystems/CMakeLists.txt#L227],
>     which should actually not even be necessary, while the Azure Pipeline I
>     used still calls make vcxproj to generate the Visual Studio build
>     definition and does not define that flag.

Diversity in test environments is very good.

