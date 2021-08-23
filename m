Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CA6C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 19:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69285611AF
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 19:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhHWT1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 15:27:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63556 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhHWT1w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 15:27:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9423DEFB3A;
        Mon, 23 Aug 2021 15:27:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0PEMbZQLsz8xcPDlGXqbcBZrDlg+IksHu49Mmg
        kwrmc=; b=S+w1N40y6GSF36NTjrH012RtEPsOMYeWbSuV9PfpYxPP4aQvaNdiAl
        Jo09PtTQ16uJP82R/0aB2wx9JGoLe6n4iDfXaws8iC3i+oV0D9z1zk+Nub4W+vlJ
        84/6h9/SNZ7h+9AtoOBOZFrNen+wG9go+2irpFxZwYejF/Eqf17Es=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 87DB2EFB38;
        Mon, 23 Aug 2021 15:27:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B5185EFB37;
        Mon, 23 Aug 2021 15:27:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nikita Bobko <nikitabobko@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Subject: Re: git read-tree doesn't accept tree-ish
References: <CAMJzOtxMjEuAy2B3oJqOZEnipmC4OBWxhQLx_baXDHcQ1C7-+g@mail.gmail.com>
        <YSPuq/HmF3tnYHCA@coredump.intra.peff.net>
        <CAMJzOtz_h0iEL1VQCFvvLzw3XnL+qM=f+BvkmsTU=ps+0VA7RA@mail.gmail.com>
Date:   Mon, 23 Aug 2021 12:27:06 -0700
In-Reply-To: <CAMJzOtz_h0iEL1VQCFvvLzw3XnL+qM=f+BvkmsTU=ps+0VA7RA@mail.gmail.com>
        (Nikita Bobko's message of "Mon, 23 Aug 2021 21:10:33 +0200")
Message-ID: <xmqq5yvwq7w5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B04AF1A-0448-11EC-A012-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nikita Bobko <nikitabobko@gmail.com> writes:

> `git checkout <hash> -- <path>` also doesn't work in my case because
> if any file is removed in `<hash>` but not in my HEAD then `git
> checkout` doesn't remove the file in my HEAD

Look for "--no-overlay" option in "git checkout", perhaps?
