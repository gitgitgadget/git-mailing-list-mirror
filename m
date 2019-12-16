Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B52C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 20:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0051207FF
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 20:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mh0ranMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfLPUjK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:39:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60553 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfLPUjK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 15:39:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34D8633134;
        Mon, 16 Dec 2019 15:39:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pm2BjrbwCdxtYI1riaQmOWn2GwM=; b=mh0ran
        MlGwy5TGXj5BE/UXoL7RarIkQ+YSprBRnJX60uFc1Rcoalw7Y4791Vsvw7qhmV1N
        ZJeRrbJu7q6MoXBGIQAzZnej8aSiiLOZ/4dutNJGxVBCJVfq3JdaM5TSjPnYX4KU
        6M7y+G/u+IQ7pUaVHKobUi3ZQoRGAFjIuBK0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l/kZbCVD5ZpQf+wnmvbibjKGH94C823o
        er7WJmVRksIDnmNxi+Isvxiq4zM4STU23bqJaYMuPphikXj3PatNb/GzkLzfHLM1
        V1ekhoQJZTuUyiYeUFhJCF9Su1R+6B/AXr6Nvi3jJNPg00LPdCqMh9GGnvC1Ohql
        MwJY+8SdEEU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D10B33133;
        Mon, 16 Dec 2019 15:39:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 75DEB33132;
        Mon, 16 Dec 2019 15:39:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH v5 0/4] git-p4: Usability enhancements
References: <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
        <pull.675.v5.git.git.1576504942.gitgitgadget@gmail.com>
Date:   Mon, 16 Dec 2019 12:39:06 -0800
In-Reply-To: <pull.675.v5.git.git.1576504942.gitgitgadget@gmail.com> (Ben
        Keene via GitGitGadget's message of "Mon, 16 Dec 2019 14:02:18 +0000")
Message-ID: <xmqq8sncj991.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B3BE348-2044-11EA-8975-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Keene via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Some user interaction with git-p4 is not as user-friendly as the rest of the
> ...
>
> Ben Keene (4):
>   git-p4: yes/no prompts should sanitize user text
>   git-p4: show detailed help when parsing options fail
>   git-p4: wrap patchRCSKeywords test to revert changes on failure
>   git-p4: failure because of RCS keywords should show help

The reviews on the list seem to be in favor of these and I didn't
see much wrong (I think I fixed up an indented empty line) in the
series.  I'd appreciate a blessing from a git-p4 expert, though.

Thanks.
