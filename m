Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB9EC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 16:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245016AbiHIQul (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 12:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245009AbiHIQuc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 12:50:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0125C15818
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 09:50:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5035D13FC77;
        Tue,  9 Aug 2022 12:50:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VbELgz2VPfk4JBJWfsgC7ZTd7qPzbXy293MZUr
        brwnk=; b=U3bReU7ovoF9MNeJ6+DwDzu0n2Lnu80H4tPOLz97aGtvyaFGcAfMNE
        3RBrPO5wh9arMkuYQp3ngheY679Fnl0+6koCkyXZ90KUzgq36K7kdG2wp5fL1sKo
        l1p38Bj7MpkD4LaE0KmhcNS0KhZmmldXaU24rITceOkd1mKa8QEn0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45DAE13FC75;
        Tue,  9 Aug 2022 12:50:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9FCBF13FC74;
        Tue,  9 Aug 2022 12:50:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 00/10] Generalize 'scalar diagnose' into 'git
 diagnose' and 'git bugreport --diagnose'
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
        <xmqqwnbn6i0v.fsf@gitster.g>
        <82af0381-ecdc-adf4-1339-ec35c18118a1@github.com>
Date:   Tue, 09 Aug 2022 09:50:29 -0700
In-Reply-To: <82af0381-ecdc-adf4-1339-ec35c18118a1@github.com> (Victoria Dye's
        message of "Tue, 9 Aug 2022 09:17:18 -0700")
Message-ID: <xmqqmtcdqs2y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60D332EE-1803-11ED-9312-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> This is an interesting point and something I think users could plausibly run
> into. I can think of a few of ways to address that:
>
> 1. Do nothing, wait for feedback from users.
> 2. Create hidden option(s) '--report' and/or '--bugreport' in 'git diagnose'
>    that trigger a warning (or advice?) along the lines of "did you mean 'git
>    bugreport --diagnose'?" and exit with 'usage()'.
> 3. Create visible options '--report' and/or '--bugreport' in 'git diagnose'
>    that invoke 'git bugreport --diagnose'.
>
> I'm leaning towards option 2, but I'd also understand not wanting to clutter
> builtins with options it *doesn't* use for the sake of advising a user.

I was leaning towards option 1, actually ;-)

I'm offline today, so please expect no changes to the public
repositories.

Thanks.
