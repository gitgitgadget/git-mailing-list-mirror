Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42113C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbhLTP5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:57:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60791 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbhLTP5R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:57:17 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D70A10DDF4;
        Mon, 20 Dec 2021 10:57:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VLxv77lhVD05ulroN0zwi9P+AvA13nMd+tdrCB
        L4GxQ=; b=nvTFNRjf3H64xE01RyhAxMMBJm1opb6HA7lg0GRLFlOG/2ayi064yY
        6Of7ArpYsCev1/I92AlJpjII4M39y+Yxrg8ag15Q+8EiNsIvz8cUchXK7FDIs67F
        gsvxkeT79L/wCz6qmQf6mGcl6nwR+l6EcIAzUCOopLlBUlfyMg+JY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02E6B10DDF2;
        Mon, 20 Dec 2021 10:57:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 47E0A10DDF1;
        Mon, 20 Dec 2021 10:57:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] merge: allow to pretend a merge into detached HEAD is
 made into a branch
References: <xmqqbl1ezq5j.fsf@gitster.g>
        <211218.86sfuqw6ii.gmgdl@evledraar.gmail.com>
        <b52be977-f03c-7915-68c8-f1842e920184@gmail.com>
Date:   Mon, 20 Dec 2021 07:57:14 -0800
In-Reply-To: <b52be977-f03c-7915-68c8-f1842e920184@gmail.com> (Derrick
        Stolee's message of "Mon, 20 Dec 2021 10:36:28 -0500")
Message-ID: <xmqqwnjzxo9x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81000EC8-61AD-11EC-9BDD-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> While sometimes undocumented, these "--no-" options allows calling an
> alias that might have the positive version included while disabling the
> option.
>
> 	git alias merge-main merge <lots-of-custom-things> --detached-head-name=main
> 	git merge-main --no-detached-head-name
>
> So, I think using the standard OPT_STRING here is fine.

Exactly.  Not just 'is fine', but is more correct.  Thanks.

