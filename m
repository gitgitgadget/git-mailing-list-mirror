Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E5CC433E1
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 20:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BB420789
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 20:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pOMq5hj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgHRUdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:33:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64533 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHRUdN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 16:33:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A43AE60F2;
        Tue, 18 Aug 2020 16:33:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m1BApgnGygy44VWpTJ8TEuPLr/Y=; b=pOMq5h
        j1BfWV+Huvaf77m8u9+Wl9d7C0X2spRp4fyQ7/knlKlzjVTc8gB8BeF4ekmZt3CI
        d+6nZT8vWz54ysEm81AybQ2nwMUrWP62U9m+0jEyMdWvFOp72KSkMPgJwWe/tCut
        ScqaoQ9L2FZGbRlyWORjwnZOycz9nvik0w1LY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AR1gVNCBvEPKjCNwDwG6HhSle82xEvcz
        5vV4BjiEyB8Pj2GZV1IBwxzBBF2j51TL0d1ULCa8pr+ieG5g4eovpTDCxcGLz98h
        907wSeMEkdBmS+8dVWQrKVmVodk5XGJn8QkvRcGLlvW18l2eUMlwTxFJ4zd8AVaM
        Bx6/Dr6Vmj8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 710F8E60F0;
        Tue, 18 Aug 2020 16:33:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9CCE0E60EB;
        Tue, 18 Aug 2020 16:33:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 0/3] Use refs API for handling sundry pseudorefs
References: <pull.706.git.1597753075.gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 13:33:03 -0700
In-Reply-To: <pull.706.git.1597753075.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Tue, 18 Aug 2020 12:17:52
        +0000")
Message-ID: <xmqq1rk3y9s0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 065EA6A8-E192-11EA-8DB3-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series changes the handling of CHERRY_PICK_HEAD and REVERT_HEAD to use
> the refs API, as a preliminary refactor for reftable. 

Nice.
