Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BB7C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2630B613D0
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 16:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFJQCZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 12:02:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65358 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbhFJQCY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 12:02:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 813ABCEFE1;
        Thu, 10 Jun 2021 12:00:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=8CgrjD7jMPV0TR9NqehUDWT8al1VNXIf+8q6cOpyqNY=; b=qzQR
        R2AJlBF/9jtGuOnXQxFAu8qrnb0CW5lIBCE1eTOkL0l68vf5UYmj8tFr1xUZrbdK
        Z6PRbMzElK+HkmmhcTOPSlox28s/gx7DspONRq6KAPwLvi+DCEmXMFRcBnC87+fF
        +WDOCdyCVbUIyleZme4N+75LGOskLsqsGuz1lNI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78F8FCEFE0;
        Thu, 10 Jun 2021 12:00:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECF34CEFDF;
        Thu, 10 Jun 2021 12:00:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] multimail: stop shipping a copy
References: <pull.977.git.1623313765122.gitgitgadget@gmail.com>
Date:   Fri, 11 Jun 2021 01:00:25 +0900
Message-ID: <xmqqbl8demli.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8544318-CA04-11EB-B878-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The multimail project is developed independently and has its own project
> page. Traditionally, we shipped a copy in contrib/.
>
> However, such a copy is prone to become stale, and users are much better
> served to be directed to the actual project instead.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

FWIW, the upstream hasn't seen any activity since early November
2019.  I'm pinging Matthieu just in case, but I do not expect
anybody would object this move.

The fewer files we need to worry about, the better ;-)

>     Stop shipping a (potentially stale) copy of multimail
>     
>     The project is maintained elsewhere.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-977%2Fdscho%2Fstub-out-contrib-multimail-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-977/dscho/stub-out-contrib-multimail-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/977
>
>  contrib/hooks/multimail/CHANGES               |  285 --
>  contrib/hooks/multimail/CONTRIBUTING.rst      |   60 -
>  contrib/hooks/multimail/README.Git            |   12 +-
>  .../README.migrate-from-post-receive-email    |  145 -
>  contrib/hooks/multimail/README.rst            |  774 ---
>  .../multimail/doc/customizing-emails.rst      |   56 -
>  contrib/hooks/multimail/doc/gerrit.rst        |   56 -
>  contrib/hooks/multimail/doc/gitolite.rst      |  118 -
>  .../hooks/multimail/doc/troubleshooting.rst   |   78 -
>  contrib/hooks/multimail/git_multimail.py      | 4346 -----------------
>  .../hooks/multimail/migrate-mailhook-config   |  274 --
>  contrib/hooks/multimail/post-receive.example  |  101 -
>  12 files changed, 2 insertions(+), 6303 deletions(-)
>  delete mode 100644 contrib/hooks/multimail/CHANGES
>  delete mode 100644 contrib/hooks/multimail/CONTRIBUTING.rst
>  delete mode 100644 contrib/hooks/multimail/README.migrate-from-post-receive-email
>  delete mode 100644 contrib/hooks/multimail/README.rst
>  delete mode 100644 contrib/hooks/multimail/doc/customizing-emails.rst
>  delete mode 100644 contrib/hooks/multimail/doc/gerrit.rst
>  delete mode 100644 contrib/hooks/multimail/doc/gitolite.rst
>  delete mode 100644 contrib/hooks/multimail/doc/troubleshooting.rst
>  delete mode 100755 contrib/hooks/multimail/git_multimail.py
>  delete mode 100755 contrib/hooks/multimail/migrate-mailhook-config
>  delete mode 100755 contrib/hooks/multimail/post-receive.example

