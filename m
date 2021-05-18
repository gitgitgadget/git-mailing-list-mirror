Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC37C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 14:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C71EE61007
	for <git@archiver.kernel.org>; Tue, 18 May 2021 14:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349903AbhEROTC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 10:19:02 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64417 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349900AbhEROTB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 10:19:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 012BFCC53E;
        Tue, 18 May 2021 10:17:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iTBKTYKsuQgAVuF9yUH30Pr3q94y/si2PDRUJJ
        XyllA=; b=t5v6PRaAcukfbsoOLvLhVSRVMv/JXnsXvfvrIfyqFARxF8t46m9qvn
        meRWAbH65wKNfPh5gPOD2ZVm67p3+3eO7l5RHNN/3AOr3cHDo8j8s4p6zMTFDWfV
        t5tYqt8JWls7zazR2QhETc3rMQQ0tsN1wiSXuxEXQGPXyLDkCZLH4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC026CC53D;
        Tue, 18 May 2021 10:17:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6F420CC53C;
        Tue, 18 May 2021 10:17:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1 0/9] diff-merges: let -m imply -p
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210517155818.32224-1-sorganov@gmail.com>
Date:   Tue, 18 May 2021 23:17:41 +0900
In-Reply-To: <20210517155818.32224-1-sorganov@gmail.com> (Sergey Organov's
        message of "Mon, 17 May 2021 18:58:09 +0300")
Message-ID: <xmqqr1i42kje.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF16AED8-B7E3-11EB-BA33-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Sergey Organov (9):
>   t4013: test that "-m" alone has no effect in "git log"
>   t4013: test "git -m --raw"
>   t4013: test "git -m --stat"

These two are mistitled (s/git -m/git log -m/).  Not a big deal as I
could "rebase -i" locally if there is no other changes needed, but
if you are going to have a reroll for other reasons, please correct
them.

>   stash list: stop passing "-m" to "git list"

s/git list/git log/, I would think.

>   diff-merges: rename "combined_imply_patch" to "merges_imply_patch"
>   diff-merges: let "-m" imply "-p"
