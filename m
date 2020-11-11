Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A742C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 21:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C7020825
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 21:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="neP5A6SJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgKKVuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 16:50:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58024 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVuB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 16:50:01 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26424A36FE;
        Wed, 11 Nov 2020 16:49:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kaXXIyXw84MbKLLgrIW/hXN+6ao=; b=neP5A6
        SJW3Sn+/ujAtiVRFEK574kFP2Bw3jyrxdIGI1ur3Jy8Ibw/W+y1kX/X0NRlcx5RP
        a/dtuQaRoUD+pFQg7CHqZVPVYFYPodWoVBx4tHRYnYvN/0rm6zORdu5V6fSiUu/H
        A/pLLn0Cre0mELQrLtAsVzGJQpfFM3vGGUY94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mqXubMyP4sENRlA2zHwuGvZOvL/iKnAr
        O2nTSkjgfANKyWomb/L8w+RKB2hxrI0OSP/ulW/b3zVEfAzBK4IMZg1uvlEisAY0
        JSHeDdB0dtW6hZZzMQAeExliydy2rt3x8xQMdkp1haTDFnhC5a7WYM1kcuspQCMO
        wROsdJGpjgQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F50DA36FD;
        Wed, 11 Nov 2020 16:49:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 98C67A36FC;
        Wed, 11 Nov 2020 16:49:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] t4013: prepare for the new default branch name "main"
References: <pull.783.git.1604829561838.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2011112137390.18437@tvgsbejvaqbjf.bet>
Date:   Wed, 11 Nov 2020 13:49:57 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011112137390.18437@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 11 Nov 2020 22:43:08 +0100
        (CET)")
Message-ID: <xmqqsg9f36nu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7D7C134-2467-11EB-9E47-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Could you advise how I could help advance this patch further? This is the
> last patch I need that is not in `next` to get to the patch series that
> actually flips the default of `init.defaultBranch` to `main` (see
> https://github.com/gitgitgadget/git/pull/762).

Is it an option to add 

    git config --global init.defaultBranchName master

at the very beginning of the test script without making any other
change?

After all, we may want to avoid 'slave' but 'master' by itself is
not all that bad, especially given that it is used only in the test
script.  If we were to have "does the configuration variable work
OK?" test somewhere anyway, why not make it this test?
