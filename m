Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4893AC43381
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 22:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03CB864FAA
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 22:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhBDWm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 17:42:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59777 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbhBDWmX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 17:42:23 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70E3FB5848;
        Thu,  4 Feb 2021 17:41:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CiIsb/cTa76EtNpcE0FBIQOihWM=; b=wkEEcG
        D5UFMbSivrwZUOqDuKYYOF/zbVJpzsBEFHeZbLJvj9p8bRsa4ABTjIweJRGNGeql
        ofhnBZND3sbkHKmcMvhzKlxSYZqZ+QHl/MYSuoHgrUrX+YocJfKkmzYn3+H+50xx
        DtxJWyLhLlzdsqqx9j3Tp8Z/UXFmA25JbODJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Dv3TgvjNSwsK/HQfiRNZmHFlT05InBz4
        //FvBN5pco4PUrTy+w6GMh3wxBMsgeZTu7qLXyEe/6BDXQ70MQJlZGYjYM8JqgQQ
        tZxK5DloNqpN9X6YULWvrgt3b++J0b9W05mm2plJXjlwpir7d6E1DWL+bfWyJY5a
        3dARQEkjt3U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6906FB5847;
        Thu,  4 Feb 2021 17:41:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EBB9BB5846;
        Thu,  4 Feb 2021 17:41:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/6] Optionally restrict range-diff output to "left" or
 "right" range only
References: <pull.869.git.1612469275.gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 14:41:39 -0800
In-Reply-To: <pull.869.git.1612469275.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 04 Feb 2021 20:07:48
        +0000")
Message-ID: <xmqqtuqr4frw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 257FFA22-673A-11EB-9CE0-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> One of my quite common workflows is to see whether an ancient topic branch I
> have lying about has made it into Git. Since my local commit OIDs have
> nothing to do with the OIDs of the corresponding commits in git/git, my only
> way is to fire up git range-diff ...upstream/master, but of course that
> output contains way more commits than I care about.
>
> To help this use case, here is a patch series that teaches git range-diff
> the --left-only and --right-only options in the end, restricting the output
> to those commits and commit pairs that correspond to the commits in the
> first and the second range, respectively.

Makes sense.
