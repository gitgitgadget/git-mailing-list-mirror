Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E022BC433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 17:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbiBRRXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 12:23:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbiBRRX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 12:23:29 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B17BE3886
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 09:23:12 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0E00218D226;
        Fri, 18 Feb 2022 12:23:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ffpn37n/zmUOglNM5OGWmCpHWkQ74FWsjLP43s
        gN0BI=; b=cxhhQyl4rjZFikdjAj+UY21+YKekahUlh9CqsJgwb8UjSotKptr0pQ
        zASBVhl8QnlTGzwp8ICy/g/BbHNkAQyiyOwMMiBVWoJYkugLCiOsP0D0aIXt8s/u
        5jx7VMm1rFl2JKolFzru+HWGCRZtYaJNxvlxgWSqNH86YQpBisWoM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0649B18D225;
        Fri, 18 Feb 2022 12:23:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E6F9218D223;
        Fri, 18 Feb 2022 12:23:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v9 4/4] cat-file: add --batch-command mode
References: <pull.1212.v8.git.git.1645023740.gitgitgadget@gmail.com>
        <pull.1212.v9.git.git.1645045157.gitgitgadget@gmail.com>
        <dbe194f8a8592dd67d6ba3a11cb7b1c81b789cec.1645045157.git.gitgitgadget@gmail.com>
        <095278d4-217b-7d97-5364-9cd491b34ed0@gmail.com>
Date:   Fri, 18 Feb 2022 09:23:07 -0800
In-Reply-To: <095278d4-217b-7d97-5364-9cd491b34ed0@gmail.com> (Phillip Wood's
        message of "Fri, 18 Feb 2022 11:26:10 +0000")
Message-ID: <xmqqtucw2io4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7100B746-90DF-11EC-94B8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> This is looking good. I think the only thing that is missing (and
> which I should have realized earlier) is that there are no tests for
> valid or invalid format arguments to --batch-command. I haven't
> checked but there must be some other tests in the t1006 that we can
> piggy back on to add that. I've left some stylistic comments below but
> I don't fell strongly about them apart from the README comment so
> please don't feel obliged to act on them, it's looking pretty good as
> is.

Yes, I agree that this is mostly good.  I also agree with all the
points you raised in your review, including the stylistic ones.
