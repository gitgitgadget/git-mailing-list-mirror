Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4ECC2B9F7
	for <git@archiver.kernel.org>; Mon, 24 May 2021 15:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 990EA613EA
	for <git@archiver.kernel.org>; Mon, 24 May 2021 15:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhEXPZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 11:25:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57469 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbhEXPX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 11:23:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C89813005D;
        Mon, 24 May 2021 11:21:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=9Lxx2gW0TXkewK0NkqzTLdFE3CngRlmnV0ppnB5GC78=; b=bOqf
        t6U5qC/rVbf6SbazzJiFRSM0R14UjxLPFRmHeB2RzdLu2ljharApwu2nKI4C6n6Y
        ZZcdwf9hRjHGXCoqAb/zZL57856dAcwpfMUPXJcyoM2r9CPcBTwzZ1216ucmEx4I
        gmqV/+NbsIgBCVfYKR/193dBxghiZbYjU8W2ZAI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2252113005B;
        Mon, 24 May 2021 11:21:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6795613005A;
        Mon, 24 May 2021 11:21:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 0/3] [GSOC][RFC] ref-filter: add contents:raw atom
References: <pull.959.git.1621763612.gitgitgadget@gmail.com>
        <xmqq1r9xndjf.fsf@gitster.g> <60ab1246d2d14_1691c2083b@natae.notmuch>
        <72ce81a2-68eb-a750-8ca1-425af3cac370@gmail.com>
Date:   Tue, 25 May 2021 00:21:53 +0900
Message-ID: <xmqqo8d0jgxa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C61CEB2A-BCA3-11EB-921E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> I think we should go with "raw", because the payloads we discussed here
> are unmodified. It is akin to "raw data" that is processed further to
> produce porcelain output, such as templating engine that process raw
> HTML into HTML pages that would be served to end user.

Oh, I can certainly live with --format='%(raw)'; I just view that
%(contents:raw) is problematic, especially if we meant to apply it
to trees and blobs, because they are not what %(contents) is about.

Thanks.
