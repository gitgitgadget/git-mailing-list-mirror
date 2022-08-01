Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8DAC00144
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 21:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiHAVq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiHAVq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 17:46:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E896C1570E
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 14:46:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDDDC13B1ED;
        Mon,  1 Aug 2022 17:46:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U9i8V6gKkOtBirIW8XOno4L3Yars6YT5OmCsLn
        j/juQ=; b=i8h4Gir2vBoUvJ/rtd9IKifjDxkR7qL8Z5BNsPj9V8tiFHtqQm0wm3
        72g3vJ8TtBHtPfA5e/FdRd5I+CWeG4TITWLiDhS2hR7yu4/2f4vu+RaOWR9ek/aS
        RTNp23YFXKC89WTAVFrz1b3XpE1CUqS1ln3JfDboqwnI+L9nHWpp4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E43DD13B1EB;
        Mon,  1 Aug 2022 17:46:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E8CA13B1EA;
        Mon,  1 Aug 2022 17:46:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 1/7] scalar: use "$GIT_UNZIP" in 'scalar diagnose' test
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <a7a766de29b53610d19e56f270863230f3a2eab6.1659388498.git.gitgitgadget@gmail.com>
Date:   Mon, 01 Aug 2022 14:46:52 -0700
In-Reply-To: <a7a766de29b53610d19e56f270863230f3a2eab6.1659388498.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Mon, 01 Aug 2022 21:14:52
        +0000")
Message-ID: <xmqqbkt3ocvn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74D08786-11E3-11ED-B189-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Use the "$GIT_UNZIP" test variable rather than verbatim 'unzip' to unzip the
> 'scalar diagnose' archive. Using "$GIT_UNZIP" is needed to run the Scalar
> tests on systems where 'unzip' is not in the system path.

Makes sense.  It makes it more in line with how a handful of tests
in t/ already use the zip archive.

