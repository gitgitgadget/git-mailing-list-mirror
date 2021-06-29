Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA135C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 06:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820E061D22
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 06:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhF2HBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 03:01:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64717 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhF2HBw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 03:01:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 280C6157324;
        Tue, 29 Jun 2021 02:59:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=jHboFCZ3UEmh5uYvkRqp4QeAWc4/abGbqh3fFyuyOcM=; b=hkLz
        Z4c3/Btt7NCEowcRkQv/PeDFe35hm4QrL9J8DAJFcnyFdCF4zGnlOLfXD3EssjWW
        r63LSCKng+5r/l3ieNbzPnn7KhSy1DumImXQtqsYGi0AZRXA5AiuJPEA1rfmWg4A
        0bNk9qHjG3wB1tO4tKeiGv5RldbiujNp1EzrxoM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2182F157323;
        Tue, 29 Jun 2021 02:59:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5C918157320;
        Tue, 29 Jun 2021 02:59:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Buckley <Kevin.Buckley@pawsey.org.au>
Cc:     git@vger.kernel.org
Subject: Re: Definition of "the Git repository"
References: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
Date:   Mon, 28 Jun 2021 23:59:21 -0700
Message-ID: <xmqq4kdhyx4m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88F69D34-D8A7-11EB-80B9-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Buckley <Kevin.Buckley@pawsey.org.au> writes:

> git init
>
> initialises a Git repository, however, the only thing that changes
> as a result is that a .git directory has been created, ergo, the
> .git directory is the repository.

Well, there is a distinction between "non-bare" and "bare"
repository, so it is not exactly _wrong_ per-se to include the
working tree portion of a non-bare repository as part of the
repository created when you run "git clone", i.e. it is not a crime
to say "please run 'git clone' to get a new repository to work in".

Often we do need to single out the things under .git/ in a non-bare
repository when explaining certain features of Git, and need to
clarify if it is not clear in the context (e.g. "the .git repository
proper in the result of such a non-bare 'git clone'").  

It is nothing new in inter-human communication.

If there is a use of word "repository" in our documentation where it
is not clear if the repository proper or the combination of both
working tree and the repository prper is meant, you may want to
propose a clarification patch.

Thanks.
