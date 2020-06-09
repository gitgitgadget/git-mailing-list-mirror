Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E0EC433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 05:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52CD120774
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 05:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YKf13BKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgFIFqG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:46:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59690 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgFIFqE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 01:46:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0009FD3981;
        Tue,  9 Jun 2020 01:46:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VPZUhBDuYHoFB2PjGLH9120jJdY=; b=YKf13B
        KGKu5u9ZiuzROi1W1BuC57/MhwUeXL5k/zHQifFYaD7wYUvGDeD0UtGi/b7cgQcC
        iBJY4O2Z7WsRtsociNKJdZ8EnP7cSRC5uVGaxhcBi45omRhYAquzgFJmLYdSpHja
        flQmj/DknDySFAHr+imH6JdQ29SP3ZByjmZLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eRf8ELJoNHgQYmK3wKWb/ShLn/NTQZum
        aqs3VUa5wehwV7fp/B2rPRByW8wqUBJrOP7RF9yi0xD/S8pDXGDKV6u/HMwu+N0K
        Zj2Og/I8t3EN7NEDNTKUmGq8DlGxqUOl9qF8tG1P09j3+YuDGsFcNILLjK9m75eV
        PDXXJxpboIs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ECDB3D3980;
        Tue,  9 Jun 2020 01:46:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 15AC0D397C;
        Tue,  9 Jun 2020 01:46:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH 3/3] Documentation: tweak git diff help slightly
References: <pull.804.git.git.1591661021.gitgitgadget@gmail.com>
        <9318365915cfe1898b2942c735d675656ce7b5e5.1591661021.git.gitgitgadget@gmail.com>
Date:   Mon, 08 Jun 2020 22:45:58 -0700
In-Reply-To: <9318365915cfe1898b2942c735d675656ce7b5e5.1591661021.git.gitgitgadget@gmail.com>
        (Chris Torek via GitGitGadget's message of "Tue, 09 Jun 2020 00:03:41
        +0000")
Message-ID: <xmqqimg0iyg9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F5C2428-AA14-11EA-8476-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Chris Torek via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  'git diff' [<options>] [<commit>] [--] [<path>...]
>  'git diff' [<options>] --cached [<commit>] [--] [<path>...]
>  'git diff' [<options>] <commit> <commit> [--] [<path>...]
> +'git diff' [<options>] <commit>..<commit> [--] [<path>...]
> +'git diff' [<options>] <commit>...<commit> [--] [<path>...]
>  'git diff' [<options>] <blob> <blob>
>  'git diff' [<options>] --no-index [--] <path> <path>

We actually are trying to wean users off of saying "diff A..B" which
is a nonsense notation, so I'd rather not to see it added here.
Describing "diff A...B" is a good idea, though.

While we have our attention on this part of the documentation, would
it make sense to also add description on invoking the combined diff
as well?
