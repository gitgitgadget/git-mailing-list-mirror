Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92465C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 02:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 749BE60FF2
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 02:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhHBCWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Aug 2021 22:22:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58030 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhHBCWC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Aug 2021 22:22:02 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C210ACA8D1;
        Sun,  1 Aug 2021 22:21:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UTLsCRR/d39wpszxMPm9xlxolDlFj8DVTKte6/
        chhBI=; b=DoKV7+kxoReYNYwC6z3XeT/sW6jkM31jgxNafWjPzoy5BaIcruoHtZ
        Afjm3UykUDSPBm3sUAYqJ+8zd6Ap5ap64BgJ2BBGfMevNaltnpVd6Ar1IHZ89/zy
        luR8ED2KN7zktMbmAM37IY8A41y2AXsP2rKuZ+4SseiTy2niwHoOs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA525CA8CF;
        Sun,  1 Aug 2021 22:21:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4BEFCCA8CE;
        Sun,  1 Aug 2021 22:21:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     heapcrash heapcrash <heapcrash@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Enhancing --show-function and --function-context in default
 configurations
References: <CAM1Tk15N6uK3aU5bY6mWQVX5UdEOraysrRmO+v4TA+P-Wa9_hQ@mail.gmail.com>
Date:   Sun, 01 Aug 2021 19:21:52 -0700
In-Reply-To: <CAM1Tk15N6uK3aU5bY6mWQVX5UdEOraysrRmO+v4TA+P-Wa9_hQ@mail.gmail.com>
        (heapcrash heapcrash's message of "Sun, 1 Aug 2021 16:40:58 -0500")
Message-ID: <xmqqzgu0y4an.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 66CB9510-F338-11EB-B848-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

heapcrash heapcrash <heapcrash@gmail.com> writes:

> gauge whether these changes would be accepted or not.  As far as I can
> tell, these would not change the default behavior of plain git
> {grep,log,diff} unless the --show-function or --function-context flags
> are specified

Two other places may be diff hunk headers and --diff-words output, I think.

> Should I work on a patch that does this?

That depends.  If you are going to introduce a mechanism to
introduce hardcoded configurations, depending on how it is done, it
will become a huge security headache.
