Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE5DC433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 19:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235310AbiCMTB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbiCMTBv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 15:01:51 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCFD4D61A
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 12:00:43 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B532F17CA44;
        Sun, 13 Mar 2022 15:00:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2YU7GNAcgsjn4aWpEb50sS8if5qSJj1O6NjFUN
        0g2/0=; b=IPKlDL+7szPjUlC1qVtquO8UjM51NlfInqp5GsKKgLNOhT00PbFuKK
        XW6h9SIFmJK+3zg3QCid3ysppIdjRNkzbrcOWs+PSXoAjnLpF0b7Q+s00+vIqTwQ
        YrU0wNa5jDdwdZKfBOiNq1XW9EciiMxd10UNg+U13+QIDWsBwA11Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC52617CA43;
        Sun, 13 Mar 2022 15:00:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 381E117CA42;
        Sun, 13 Mar 2022 15:00:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] Documentation: simplify synopsis of git-repack(1)
References: <20220312113136.26716-1-bagasdotme@gmail.com>
Date:   Sun, 13 Mar 2022 19:00:39 +0000
In-Reply-To: <20220312113136.26716-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Sat, 12 Mar 2022 18:31:37 +0700")
Message-ID: <xmqqsfrlvfs8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E023FF34-A2FF-11EC-9F5F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Simplify SYNOPSIS section to only mention [<options>...] placeholder.
> Redundant options list can now be avoided for aesthetic and clarity.

The "git cmd --help" output is meant to be readable and useful, so
clarity is good, but I do not know much about aesthetics.

More importantly, the above does not answer a lot more important
question.  Is it just loss of duplicated information that this
commit brings in?  Isn't the motivation that "not all options are
listed in SYNOPSIS section, and/or some options listed there are not
described in the body text and are not supported"?  And instead of
trying to keep them in sync, the author chose to simplify SYNOPSIS
and have readers look options up in the body text, no?  These two
would make a good pair of "what problem do we solve?" and "how we
choose to solve it?".

>  [verse]
> -'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>] [--write-midx]
> +'git repack' [<options>...]

Unlike commands with multiple "operation modes", "repack" does one
thing and only one thing, so a single-liner "git repack <options>"
may work well.
