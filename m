Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11258C433DB
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 23:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAAD61883
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 23:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhCTXI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 19:08:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55221 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTXIe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 19:08:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2752CBF84E;
        Sat, 20 Mar 2021 19:08:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8FFR8cGpI11h
        IKP+m01zCT0duWA=; b=HiwbG5mQObOqnxpsYS1gc9MIOIGDDz62mKtEwUaiYA8z
        E1lsKEXHMaGQnKoQMa5Cax8Coz2846iylDh6mc/NzyZJufCJm/Ypc0eQlEn8r/rg
        6yGeQFOToPoXboiOglK3xSShjg8+Ef5GBsVi7VL5Xa/qRHD4Io3WgDfjUZ6VD78=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=I/Vz1D
        9lea7wo1UKp97M2NbzGK0NUcGc2VPqTgCCcE/qa8nuj9HDgbGMLB5psUrx36+wN1
        dpR4m+avFgRP0CHjVGn2Y7ZWQ9qg9oNyPR81Ywdi6+PJUGcy18gBkAO4nMYmyTvN
        /fh4Z1iL5aVjTDjcFocrMUI/z2L6mJrgfBolA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FB19BF84D;
        Sat, 20 Mar 2021 19:08:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A105CBF848;
        Sat, 20 Mar 2021 19:08:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v5 0/8] read_tree() and read_tree_recursive() refactoring
References: <xmqqpmzxy939.fsf@gitster.g>
        <cover.1616279653.git.avarab@gmail.com>
Date:   Sat, 20 Mar 2021 16:08:27 -0700
In-Reply-To: <cover.1616279653.git.avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 20 Mar 2021 23:37:43 +0100")
Message-ID: <xmqqy2ehctjo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2F206C74-89D1-11EB-BA59-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> A refactoring of v4[1], not quite as as suggested by Junio in[2], but
> which I think makes this whole thing less confusing and more
> straightforward.

Yeah, I admit that I gave only a cursory look, but the progression
presented in this round makes a lot of sense to me.

Thanks, will replace.
