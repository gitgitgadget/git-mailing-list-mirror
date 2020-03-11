Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F54BC0044D
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 19:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A4E20736
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 19:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ybr8YEnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbgCKTKx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:10:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61944 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731051AbgCKTKw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 15:10:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A67FE4750C;
        Wed, 11 Mar 2020 15:10:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2+cLfMjcOGj2PbB9LYJP/0698OU=; b=ybr8YE
        nVSL+LCaQN3SxOTu4fPsfn1ojxSqNSbLAm89eS70N8cwHAZbZfJm14e0BGb33i7F
        caTrJowayYZwGF7zFGOtXMjVtQJEXzSnGWWmZ9uTxbyi/F6+RcPps6YBEEZHmrpy
        cEIBUrcmpss139n23oZ2pTlmwZ+tohD4QY/Iw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BxsktFNytVi9gZPKEoy6JN8cGAp9cB3b
        3lj8Nmhb/wusXeT/KuvAHkzOi0LVPVgDzFz6HxFFts8wgsyFYDkNNI+woyowp6sz
        35pT+2q1/iz/4Cx//szbCT03xQezgTBwr+NdJqS8X2u8nLc+oBhIEuGnjesX+gkD
        JU9XyYWfnfU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EFDE4750B;
        Wed, 11 Mar 2020 15:10:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2DC024750A;
        Wed, 11 Mar 2020 15:10:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 2/2] git-rebase.txt: highlight backend differences with commit rewording
References: <pull.722.git.git.1583903621.gitgitgadget@gmail.com>
        <pull.722.v2.git.git.1583940623.gitgitgadget@gmail.com>
        <6d51cff41d9ee312a0d9ae3308546284ead1d4c6.1583940623.git.gitgitgadget@gmail.com>
        <20200311163643.GD27893@coredump.intra.peff.net>
Date:   Wed, 11 Mar 2020 12:10:49 -0700
In-Reply-To: <20200311163643.GD27893@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 11 Mar 2020 12:36:43 -0400")
Message-ID: <xmqqk13qhfly.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0553366E-63CC-11EA-BE5C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Thanks. With the earlier bug fix and this documentation change, I'm OK
> with keeping the merge-backend transition in v2.26.0. This change
> _might_ cause problems in somebody's script, but that will be true
> whether it comes in 2.26 or 2.27, and I think it's clear this is the end
> state we want to get to eventually.

I am OK either way, so let's take these two, plus the "don't i18n
the literals that must be given as option values" patch from Jiang,
and discard the "let's delay the inevitable to buy some time" patch.

I merged the last one locally to 'next' already but I haven't pushed
the result out, so it is still possible to back out ;-)
