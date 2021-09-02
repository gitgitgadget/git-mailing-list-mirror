Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF3FC433EF
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 20:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C11160FC0
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 20:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhIBUzB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 16:55:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54623 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbhIBUzA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 16:55:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C093E17EF;
        Thu,  2 Sep 2021 16:54:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=naFp41VZDFf0
        JeZ8X/Q2NBG0etHW6rzKcg5RVnXK1VY=; b=Fwz+xMB+KQOV3Fcv9Cuev33MGhxo
        pukB/XeBeerJOFKHuLPVOteJAzNJ5/J0uN3uIubVzTGOpJ37ysIjInZeO5HUl/MG
        CxGpxWZNS3/ManP8E2kOFvIcLBbpfyStaXji5SFZ4IDqxALYXX/KZKdZXrOCmHGZ
        3p2WB/wO0ZeNK/E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A72FEE17EE;
        Thu,  2 Sep 2021 16:54:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D9CC7E17ED;
        Thu,  2 Sep 2021 16:53:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH 0/9] remove dead shell code
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
Date:   Thu, 02 Sep 2021 13:53:59 -0700
In-Reply-To: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 2 Sep
 2021 18:01:07 +0200")
Message-ID: <xmqq5yvik8bc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E5BE44A2-0C2F-11EC-B83E-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove dead shell code in git-sh-setup, inspired by parallel
> discussion on another topic (but the two don't conflict):
> https://lore.kernel.org/git/87lf4f9gre.fsf@evledraar.gmail.com/
>
> The last two patches were picked from a dropped series of mine
> submitted earlier this year, it was dropped because of other more
> complex patches that I haven't included here:
> https://lore.kernel.org/git/20210311001447.28254-1-avarab@gmail.com/
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (9):
>   git-sh-setup: remove unused set_reflog_action() function
>   git-sh-setup: remove unused git_editor() function
>   git-sh-setup: remove unused git_pager() function
>   git-sh-setup: remove unused sane_egrep() function
>   git-sh-setup: remove unused require_work_tree_exists() function
>   git-sh-setup: move create_virtual_base() to mergetools/p4merge
>   git-sh-setup: move peel_committish() function to git-subtree.sh
>   git-bisect: remove unused SHA-1 $x40 shell variable
>   test-lib: remove unused $_x40 and $_z40 variables

Was "unused" above decided based solely on the presence of in-tree
users?  If that is the case, I do not think we want to take these
sh-setup changes.

The implementation details of the remaining part of git-bisect.sh
and test-lib.sh are OK, of course, as that is truly our local
issue.

Thanks.
