Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C34CC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 20:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbiGMUyd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 16:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbiGMUy1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 16:54:27 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A441C138
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 13:54:22 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1F541B618C;
        Wed, 13 Jul 2022 16:54:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fiU7FT0+qW8KUx8g+Ww/D0zOcUIMxfqCC5RPsP
        OoNo4=; b=suvp5UrlW8ytrvfNbCPK7KUDmu6+W/hYxBwswatfZ028FzkypTuJH1
        w7gxcCXkbJOlndR3M4e/lPBrsWJhdm6JYHJrrskHzQVaN044TUTTdP7UX5nkbx+u
        Hurr8zNKy9R2t8gCb0wOnGSC9aMtUaoNXWXHnkpVvvkdTcLbi10p8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EA4801B618B;
        Wed, 13 Jul 2022 16:54:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7CF881B618A;
        Wed, 13 Jul 2022 16:54:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mergetool(vimdiff): allow paths to contain spaces again
References: <pull.1287.git.1657726969774.gitgitgadget@gmail.com>
        <xmqqfsj5dlt7.fsf@gitster.g> <Ys8wkC1f2qc+7IX8@zacax395.localdomain>
Date:   Wed, 13 Jul 2022 13:54:16 -0700
In-Reply-To: <Ys8wkC1f2qc+7IX8@zacax395.localdomain> (Fernando Ramos's message
        of "Wed, 13 Jul 2022 22:52:32 +0200")
Message-ID: <xmqqbktsbuo7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5F41AB2-02ED-11ED-8C49-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fernando Ramos <greenfoo@u92.eu> writes:

> On 22/07/13 09:22AM, Junio C Hamano wrote:
>> Thanks for a clear description of the problem and the solution.
>> 
>> Fernando?  Ack?
>
> Yes. 100% Ack'ed.
>
> Thanks Johannes for the bug report and the patch!

Funny that we now seem to fail t7609 mergetool --tool=vimdiff
tests, e.g.

    https://github.com/git/git/actions/runs/2665800752

