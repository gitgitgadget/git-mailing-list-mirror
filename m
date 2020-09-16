Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB92C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D69206C9
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rlLnQA0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgIPTpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 15:45:34 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51340 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbgIPTpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 15:45:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 49D68E824B;
        Wed, 16 Sep 2020 15:45:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4VFD9QCxWmwrBQi/WhD8nB55p24=; b=rlLnQA
        0LW58rtIiolJPquw9SzzaF5/VOf+QT1H9SEPhXlo9dKm7HPVRZcWufQ78muBGD2O
        A9Ghdk+Fk5dbkLeAXI7+bxntBmIALhg/59XDaoq4NoDtxY9zk1YYvFoH2RSHgiLD
        Euncy2uxUIg3EIu4TrI7BIu4z67mZOfKLye3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gB1w9FDx9TwdzZ3Dt0V+etb6spAHEmOw
        MZQlY/CE2oCNG9XEnkigj4Ok3ugstbhC2HbiGlWKE2iwCAu5VVs8r6zy2Pb8Nr44
        mTwAlxQuTsOC543C5Kg1kMgRwSy+jENFVSUNlWG3IbcXRDJ6oKPAlSBrWa/jsiJp
        k6dxVVT2QXg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 42562E8249;
        Wed, 16 Sep 2020 15:45:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 111F5E8248;
        Wed, 16 Sep 2020 15:45:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 2/3] Doc: cover multiple contains/no-contains filters
References: <20200913193140.66906-1-alipman88@gmail.com>
        <20200916020840.84892-1-alipman88@gmail.com>
        <20200916020840.84892-3-alipman88@gmail.com>
Date:   Wed, 16 Sep 2020 12:45:03 -0700
In-Reply-To: <20200916020840.84892-3-alipman88@gmail.com> (Aaron Lipman's
        message of "Tue, 15 Sep 2020 22:08:39 -0400")
Message-ID: <xmqq4knxy08w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1ECCA4AE-F855-11EA-B0C7-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Lipman <alipman88@gmail.com> writes:

> Update documentation for "git branch", "git for-each-ref" and "git tag"
> with notes explaining what happens when passed multiple --contains or
> --no-contains filters.
>
> This behavior is useful to document prior to enabling multiple
> merged/no-merged filters, in order to demonstrate consistent behavior
> between merged/no-merged and contains/no-contains filters.
>
> Signed-off-by: Aaron Lipman <alipman88@gmail.com>
> ---
>  Documentation/filters.txt          | 3 +++

"git" has more than one concepts that relate to the word "filter",
like the one that are used to create lazy clone, the "filter-branch"
command, "smudge/clean" filter, "textconv" filter used by the diff
and grep machinery to name some.

Make sure you do not accidentally squat on a good-sounding but
an overly generic name.  ref-reachability-filters.txt perhaps?

> diff --git a/Documentation/filters.txt b/Documentation/filters.txt
> new file mode 100644
> index 0000000000..4ee17afc01
> --- /dev/null
> +++ b/Documentation/filters.txt
> @@ -0,0 +1,3 @@
> +When combining multiple `--contains` and `--no-contains` filters, only
> +references that contain at least one of the `--contains` commits and
> +contain none of the `--no-contains` commits are shown.
