Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8275C1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 15:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfFSPDA (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 11:03:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64034 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSPDA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 11:03:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BA58C164DA9;
        Wed, 19 Jun 2019 11:02:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GRepWFczk414EVObV32tOyDYFMQ=; b=VO/v14
        KM0Cntz4OiMNJ/PTA2zReeVC7hJyf6Ll+tDfEYNw2dP6QgmprypAuqmLXPUN2j9T
        mt+EXJx2jYEK01d9Dlu3gpawT6XaIRcS61XZaKhInfPxSY/3dg9nhelM43oObOUp
        DOWuRe93gop8/Nbpxct7cxIhn9e+rXWrA0jI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kpEi+nQ5yFBdubq5zMMjgDK9zNX6NN0X
        Obx5PnygCUPu/sqNCN7xR4xtwAi0/1rOD9LRzKcLRMoP3Ko0sK4kGc0ICo4AU8j6
        XBI5UdLrMT/0Us0hN+BYvCGQZVuo8rLoxth44K5L7WjNH7j32fLg+ufMghODpu29
        OKkrZr1k2zs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B316E164DA8;
        Wed, 19 Jun 2019 11:02:59 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28E01164DA7;
        Wed, 19 Jun 2019 11:02:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>, Boxuan Li <liboxuan@connect.hku.hk>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH] userdiff: ship built-in driver config file
References: <20190617165450.81916-1-liboxuan@connect.hku.hk>
        <488f215a-cb32-db3f-4a45-0062f0f0a0a9@kdbg.org>
        <20190619034929.GA515@sigill.intra.peff.net>
        <1da78555-96eb-1206-679b-527911f6af29@kdbg.org>
Date:   Wed, 19 Jun 2019 08:02:58 -0700
In-Reply-To: <1da78555-96eb-1206-679b-527911f6af29@kdbg.org> (Johannes Sixt's
        message of "Wed, 19 Jun 2019 08:30:25 +0200")
Message-ID: <xmqqblytr525.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53A01B20-92A3-11E9-80E8-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> But /etc/gitconfig would be the wrong place, because it would not be
> updated when a new version ships with new patterns.
>
> I would suggest to install the file as $prefix/share/git-core/userdiff
> although the name "userdiff" sounds like an accident. How about
> .../filetypes?

I am not sure about the filename, but I do agree with your choice of
"somewhere under $prefix/share/".

Thanks.
