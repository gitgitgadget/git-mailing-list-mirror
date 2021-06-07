Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA44C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 05:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EDBE6121D
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 05:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhFGF5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 01:57:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53393 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGF5x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 01:57:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB759135A5C;
        Mon,  7 Jun 2021 01:56:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3wNhQg0OAGuBPRJLRAyU7B8U6qZlwqh++TwdOt
        BoHMY=; b=gD8QPW5V5kMHC7YHLyfLiFqqaAY6F5fkYN6E92gLru+Lw7QlVTO26Q
        HRy3wPCQVEjas78Yvdy8qHwR664G8PNVTkggGTKtNJU/J6bbF1xn7e1tfF8D8/PR
        mZGzdMTtJuw++DKgOyqCCOpVqxI8iGdZlR5AOAQ29KoC087WtFyWI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B4036135A5B;
        Mon,  7 Jun 2021 01:56:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 03C4D135A58;
        Mon,  7 Jun 2021 01:55:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 0/6] [GSOC][RFC] ref-filter: add %(raw:textconv) and
 %(raw:filters)
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 14:55:58 +0900
In-Reply-To: <pull.972.git.1622884415.gitgitgadget@gmail.com> (ZheNing Hu via
        GitGitGadget's message of "Sat, 05 Jun 2021 09:13:28 +0000")
Message-ID: <xmqq35tuw74h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08E551A2-C755-11EB-B471-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The current series is based on 0efed9435 ([GSOC] ref-filter: add %(raw)
> atom)

I do not have that commit object, but these six patches include the
two commits that are %(raw) and %(raw:size), so I'll just discard
the old round that wasn't based on the atom-type stuff and queue
these six as a single series.

As I already said, I am not sure how %(rest) makes any sense outside
the context of "cat-file --batch"; I suspect it would make more sense
to make it easier to arrange certain placeholders to error out when
used in a context where they do not make sense (e.g. use of --rest
in "git branch --list").

