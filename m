Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020F6C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 20:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A041420790
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 20:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NcqA60mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1825001AbgJ0Ucx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 16:32:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55414 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441556AbgJ0Ucx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 16:32:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4718F8085B;
        Tue, 27 Oct 2020 16:32:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A6ysuArgR3cubaeEn9H6yJLDDk0=; b=NcqA60
        mfgLz1w0L4aluORy5Jxsh1W4drzk1HTWcNUx3h2hBF5Q72FU6+Hw7M/bFCMlUumW
        N+dsGkhUsHyqpntDE6QwTdLwbA3PN35sB5nQSJ8XxFtpOyhUWKKanAiBKj/SbueR
        Kbjz5kwSw7gF/l9JwPrvmN6va4gDaC62SssY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rhy2rcDZN5NJA6E/fXCkRNxwaDms6LWw
        U9X+RyBR5JWh5BGx1aU6IJVmY+4PZFq0utSS6YPeNBjo8P405KzAn58+FXlSnybk
        7YLSDL1SQslhg7oTYAWNgbfUsT/C6OOPoPit4X+FYpV7wxrpsOFddS/7AB+8iI+D
        AxHmy6uMbGo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E7B98085A;
        Tue, 27 Oct 2020 16:32:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B207980858;
        Tue, 27 Oct 2020 16:32:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Filipp Bakanov <filipp@bakanov.su>
Cc:     git@vger.kernel.org
Subject: Re: Proposal: "unadd" command / alias.
References: <CAAdniQ5pRHKUU77XVmZkZ_gUgfYYFpo9=Xt2T6EgzJ3hoT0YMg@mail.gmail.com>
Date:   Tue, 27 Oct 2020 13:32:50 -0700
In-Reply-To: <CAAdniQ5pRHKUU77XVmZkZ_gUgfYYFpo9=Xt2T6EgzJ3hoT0YMg@mail.gmail.com>
        (Filipp Bakanov's message of "Tue, 27 Oct 2020 23:10:00 +0300")
Message-ID: <xmqqblgnbea5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9534A35E-1893-11EB-BCB7-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Filipp Bakanov <filipp@bakanov.su> writes:

> Hi! I suggest to add "unadd" command, that will undo a git add command.
>
> git unadd path/to/file
>
> It will be an alias to:
>
> git reset HEAD -- path/to/file
>
> The motivation is that I always forget syntax and have to google each
> time I want to undo accidentally added files. Unadd is just much
> easier to remember and quite obvious.

The alias is for you to do the above, I think.
