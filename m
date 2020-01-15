Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B18C32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 23:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E65A2465A
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 23:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nNJjnsQw";
	dkim=pass (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="WN8CKzdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgAOXbB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 18:31:01 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58651 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730364AbgAOXbA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 18:31:00 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 13B4996081;
        Wed, 15 Jan 2020 18:31:00 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=tOr+c8cB362J3Ldua82HHQxNPfk=; b=nNJjns
        QwzIJ8JiVdVJVjgxbeLmiOrUm5Y+ovXvlpu4/kdlhEuDDWdyTXvH21NSNyTf5xLL
        mJo05m6XRh1katMdFJX3GP9GN2VJ1Hq85D69RKLcu+TTs3R/L7xci31XK1iFmIeA
        HGogoS6nasEKy7yXYVkR4EZ/sAeOibW9hYQQQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0C7D49607F;
        Wed, 15 Jan 2020 18:31:00 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=bZW+dBfOq8f5IT7HiocZZxpLqRrgySs/n2lnLgPg/+Q=; b=WN8CKzdjLHWj2YLhWzu5l+cXlqWgl5DbIqzSWTk0WmuZr4sKWoNfdvA65G0IlFO/45LVXpu2UUZyfDZbNmvv5iaAx2voobPsqNZtxt8JNnWG7CbduLpQ6CK8glU+nHofq42OLtANk8ua44W773xzg8kWfOG0uw6/Ig3V6MHZx+A=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5FE459607B;
        Wed, 15 Jan 2020 18:30:57 -0500 (EST)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kevin.Willford@microsoft.com,
        newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] clean: demonstrate a bug with pathspecs
In-Reply-To: <pull.526.git.1579119946211.gitgitgadget@gmail.com>
References: <pull.526.git.1579119946211.gitgitgadget@gmail.com>
Date:   Wed, 15 Jan 2020 23:30:48 +0000
Message-ID: <87zheo2t7b.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14CFBAF8-37EF-11EA-B4EE-8D86F504CC47-24757444!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> b9660c1 (dir: fix checks on common prefix directory, 2019-12-19)
> modified the way pathspecs are handled when handling a directory
> during "git clean -f <path>".

I can't find b9660c1.  I think this and other references below should
point to b9670c1f5e (dir: fix checks on common prefix directory,
2019-12-19), which matches the base-commit value for this patch.
