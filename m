Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC679C48BE6
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 06:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B250E610A2
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 06:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhFNGUQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 02:20:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61575 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbhFNGUP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 02:20:15 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C234CD884D;
        Mon, 14 Jun 2021 02:18:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xC3X3U11+mHH+wsznnTNwoS5FzNzHcdZJc2Bcr
        Ojukc=; b=dp52tK7WbojQvbZU7Ibo6khS+hlaX3w0aAwRyHH0OVOdXuqtAajowk
        uckVJbp35l4VW+NhOf16lYJB2QHQ4GVFXUHQFSclY2E87zcRIACo7zqsmuGxyhR+
        AxiBxrNM+kQKQnrFfj/OMyQ1KJG9WWXodG0c6KrBGuvnZCPK+IpFs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8F40D884B;
        Mon, 14 Jun 2021 02:18:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 210CFD884A;
        Mon, 14 Jun 2021 02:18:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] submodule: cache superproject gitdir during
 absorbgitdirs
References: <20210611225428.1208973-1-emilyshaffer@google.com>
        <20210611225428.1208973-4-emilyshaffer@google.com>
Date:   Mon, 14 Jun 2021 15:18:11 +0900
In-Reply-To: <20210611225428.1208973-4-emilyshaffer@google.com> (Emily
        Shaffer's message of "Fri, 11 Jun 2021 15:54:27 -0700")
Message-ID: <xmqqim2hx93w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BCACD52-CCD8-11EB-8CE7-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +	test . -ef "$(git -C sub1 config submodule.superprojectGitDir)" &&

Unfortunately "test f1 -ef f2", "test f1 -nt f2", etc. are not part
of POSIX.

When in doubt, check

  https://pubs.opengroup.org/onlinepubs/9699919799/utilities/toc.html

Thanks.
