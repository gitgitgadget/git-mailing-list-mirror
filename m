Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C03FC43381
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC93164E9A
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbhBIXNi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 18:13:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61140 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbhBIW7h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:59:37 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 349AAB18E4;
        Tue,  9 Feb 2021 17:58:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C5uuEpF4HA3M2jiJvV4nbgbovmk=; b=NmWu3/
        UwImBBXhgAst1wM7RPyKuTj5wVySqx5Tb3n6aOc/pjiZRGMi0r8uv6r1qsQtsKch
        XEIemCynQEAAw1WWw868XOhesLdqVdQZaICeeNJB5KSAxfDJyBoVKC7pZV4B7BG1
        BPMdjhLKFHK466SHrkKKMgH0nmJRNkcncBgws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Kb03El/RtcHgFGuvMr06xoNp9kv12efA
        ue4JXD5CNGvgsNnp9+XYr2U+LsZPKWKecr2LcUOO9/F9mhpqXkJTafkJkHi5kF8q
        HnJPGXSL5hNQVMhzco5w1ZKpnft12QfXrQWFTeVLaOVweMrwEwl/PFl6vPw+OHlg
        8gsuCj5VMOE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D4FAB18E3;
        Tue,  9 Feb 2021 17:58:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A168FB18E2;
        Tue,  9 Feb 2021 17:58:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     shubham verma <shubhunic@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 00/10] Modernizing the t7001 test script
References: <20210209173254.17712-1-shubhunic@gmail.com>
Date:   Tue, 09 Feb 2021 14:58:41 -0800
In-Reply-To: <20210209173254.17712-1-shubhunic@gmail.com> (shubham verma's
        message of "Tue, 9 Feb 2021 23:02:44 +0530")
Message-ID: <xmqqy2fwyhjy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A8B0632-6B2A-11EB-B7F4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

shubham verma <shubhunic@gmail.com> writes:

> In this patch series modernize the t7001 test script by changing the
> style of its tests from an old one to the modern one and by cleaning
> up the test script.
>
> Changes since v1:
>
> - Change commit messages and added brief explanation about commit.
> - Modernize subshell formatting
> - Use ': >' rather than '>'
>
> Thanks everyone for your feedback and suggestions.
>
> shubham verma (10):
>   t7001: modernize test formatting
>   t7001: indent with TABs instead of spaces
>   t7001: remove unnecessary blank lines
>   t7001: modernize subshell formatting
>   t7001: remove whitespace after redirect operators
>   t7001: avoid using `cd` outside of subshells
>   t7001: use '>' rather than 'touch'
>   t7001: put each command on a separate line
>   t7001: use here-docs instead of echo
>   t7001: use `test` rather than `[`
>
>  t/t7001-mv.sh | 432 ++++++++++++++++++++++++--------------------------
>  1 file changed, 204 insertions(+), 228 deletions(-)


I would have used test_write_lines instead of here-doc in 9/10, but
that is such a minor preference thing that it is not worth going
back and replace.  Nothing else stood out during my cursory scan.

Will queue; thanks.



