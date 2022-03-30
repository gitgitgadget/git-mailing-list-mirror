Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F71C433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 23:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbiC3Xn4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 19:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiC3Xny (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 19:43:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF90D59A7C
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 16:42:05 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F2F017DC3D;
        Wed, 30 Mar 2022 19:42:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=abop912e6hxh4bo3K5xxvKzBQfh5803otftvwZ
        X10E4=; b=CDBWfvKPATxE2mxG+T/SArVcYA7u9pI3WK+XTXsCxLoPo6mQdRHOyF
        mwvaLtKy6POv4f6ILAPxh5shlu5C1SOT8gitPZg1MPMoW7s1REXrtPowtpngsX0H
        Pngf9miWqu3efFCHXhmwI8gssDbYb758qu0U0cokopFXYK2zDi6W4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 274C017DC3C;
        Wed, 30 Mar 2022 19:42:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 93F8217DC38;
        Wed, 30 Mar 2022 19:42:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v3 3/3] object-info: add option for retrieving object info
References: <20220330224314.2310534-1-jonathantanmy@google.com>
Date:   Wed, 30 Mar 2022 16:42:01 -0700
In-Reply-To: <20220330224314.2310534-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 30 Mar 2022 15:43:14 -0700")
Message-ID: <xmqqpmm357p2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FFD80010-B082-11EC-AA9A-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Calvin and I discussed details of implementation before he wrote these
> patches, and my thinking at that time was that to get the relevant
> information, we're prepared to fetch the objects themselves from the
> remote if need be, but prefer to fetch only metadata if possible, so
> putting it in "fetch" seemed reasonable to me. But I agree that it's
> probably better to put it somewhere else.

Yeah, I am sympathetic that every "learning something from remote"
looks like a "fetch".  After all, a remote blame may be "fetching
the result of running blame".  But it may not be a good way to
decide what the feature should be called.

Thanks.

