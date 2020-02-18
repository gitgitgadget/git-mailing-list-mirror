Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5071CC34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 21:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB762070B
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 21:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xGuQULty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgBRVFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:05:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58478 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgBRVFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 16:05:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E4C65CFE4;
        Tue, 18 Feb 2020 16:05:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3XIqXQ/UTTgWlMvCEzMtW4Xeosk=; b=xGuQUL
        tyjXG5RObVpyZqGAdLIF2iTmLICwTQZHOgd/dfWIzUQnSImI80sDIeIOi7GBhsDu
        U5wQIDR20bARCZT1rcXajd+W3ODwAQRpfapKuUnz7s6czjAjHDToaVugkraWsdtI
        FPnJosJVa1imhRx30Nuc6HihqDgBn9GHeY6S0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LM1V/iTzMViziMEDwE3BZitPLOxbco7Q
        9Eyo9XQvVxAiY90qWmzRl/Y+gvec6D0YlIs75hJ9ic0e6A/wmndsvpCTjSdlne+W
        O3CZvfKVXsePm1db7I18U0z3gl6E/ByeaK3qnbMBI5zkzFPS92BUPdqkPCafkzAk
        CtHg1wsd9w0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4A5A5CFE2;
        Tue, 18 Feb 2020 16:05:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E56045CFDC;
        Tue, 18 Feb 2020 16:05:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v6 0/5] Reftable support git-core
References: <pull.539.v5.git.1581344060.gitgitgadget@gmail.com>
        <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
Date:   Tue, 18 Feb 2020 13:05:02 -0800
In-Reply-To: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Tue, 18 Feb 2020 08:43:35
        +0000")
Message-ID: <xmqqy2szip35.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55FDF59A-5292-11EA-B676-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is what I got from "git am --whitespace=fix" on these five patches.
Does it match your test application?

Applying: refs.h: clarify reflog iteration order
Applying: create .git/refs in files-backend.c
Applying: refs: document how ref_iterator_advance_fn should handle symrefs
.git/rebase-apply/patch:145: trailing whitespace.
    
.git/rebase-apply/patch:147: trailing whitespace.
    
.git/rebase-apply/patch:6544: indent with spaces.
        left = *destLen;
.git/rebase-apply/patch:6545: indent with spaces.
        *destLen = 0;
.git/rebase-apply/patch:6548: indent with spaces.
        left = 1;
warning: squelched 15 whitespace errors
warning: 20 lines applied after fixing whitespace errors.
Applying: Add reftable library
Applying: Reftable support for git-core
