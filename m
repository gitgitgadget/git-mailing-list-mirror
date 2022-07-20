Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E03BC433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 16:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiGTQJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 12:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGTQJt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 12:09:49 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A680A4D145
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 09:09:48 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 00CBA1A3BD2;
        Wed, 20 Jul 2022 12:09:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RE+z31XLNrY+PYafeGMxYFFGgWw9bSU5VvhACg
        441SY=; b=Esa97+cDX8ucIwKmSnb14S65U6WM9APCf9fUuPZZFSqn6vUyP9Pd0+
        h84+6RF9CB4YTpGYEU/NZOrHtfFKmP4sl0FOGMrD4D4+67lG0fTp5c9EebHISNnQ
        XtKhiggX7XP+CKvSAYlR3Yo1HEnv913EvTZuOIM1xHefXytQmzHds=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EB8D01A3BD1;
        Wed, 20 Jul 2022 12:09:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9A7CF1A3BCF;
        Wed, 20 Jul 2022 12:09:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Moritz Baumann <moritz.baumann@sap.com>
Subject: Re: [PATCH 1/2] git-p4: fix typo in P4Submit.applyCommit()
References: <pull.1297.git.git.1658298900.gitgitgadget@gmail.com>
        <1484eee8961227a9901e3baa052c74a6d992c220.1658298900.git.gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 09:09:43 -0700
In-Reply-To: <1484eee8961227a9901e3baa052c74a6d992c220.1658298900.git.gitgitgadget@gmail.com>
        (Moritz Baumann via GitGitGadget's message of "Wed, 20 Jul 2022
        06:34:58 +0000")
Message-ID: <xmqqedyf4vg8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E9DF4B8-0846-11ED-9A7E-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Moritz Baumann <moritz.baumann@sap.com>
>
> Signed-off-by: Moritz Baumann <moritz.baumann@sap.com>
> ---
>  git-p4.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 8fbf6eb1fe3..1de3d6f1cd4 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2226,7 +2226,7 @@ class P4Submit(Command, P4UserMap):
>                                  raw=True):
>                              if regexp.search(line):
>                                  if verbose:
> -                                    print("got keyword match on %s in %s in %s" % (regex.pattern, line, file))
> +                                    print("got keyword match on %s in %s in %s" % (regexp.pattern, line, file))

OK.  That's an obvious fix.

>                                  kwfiles[file] = regexp
>                                  break
