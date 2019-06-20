Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7A5C1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 20:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfFTUSX (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 16:18:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56561 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfFTUSX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 16:18:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C93862801;
        Thu, 20 Jun 2019 16:18:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rPHqNShK3te4
        ShIUJAGPQT1Z2XI=; b=sY1ReeX8ry927j3EHHSR0j1s8LoAutA0xogUe2lSlBKK
        sDGYmlr2ONttWmIBhEubCSNy1jj/GGr7VL81CJSpYB9z7YO2Azv4G0BPyv2kR72V
        IqAdZeD/rLP2hggJpOEjfSQ5WAaoVrZJCkjnpXJTpuVpn6VOXxYPQfIJX0O9ykA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=aXP4hg
        eiHmrzfIeHwqieNhVuB+LjtZq6jtr9DtxTPBaprOa+4vHqn/jXk1VKuhn58irmdv
        jByqaTfBlra4OORSAp+RoYZFhnMl+KD8/PlL5XjXcPqQ6KRSrJc3yQ+iO7v13bCu
        jh/bjRwwwz1p7FYsZLnwIf/nrwy15QXFrjmwI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2466662800;
        Thu, 20 Jun 2019 16:18:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5761E627FF;
        Thu, 20 Jun 2019 16:18:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        kernel-usp@googlegroups.com
Subject: Re: [GSoC][PATCH v7 00/10] clone: dir-iterator refactoring with tests
References: <20190502144829.4394-1-matheus.bernardino@usp.br>
        <cover.1560898723.git.matheus.bernardino@usp.br>
Date:   Thu, 20 Jun 2019 13:18:16 -0700
In-Reply-To: <cover.1560898723.git.matheus.bernardino@usp.br> (Matheus
        Tavares's message of "Tue, 18 Jun 2019 20:27:37 -0300")
Message-ID: <xmqqef3om2nr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8AC13ED6-9398-11E9-9EAB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> Daniel Ferreira (1):
>   dir-iterator: add tests for dir-iterator API
>
> Matheus Tavares (8):
>   clone: better handle symlinked files at .git/objects/
>   dir-iterator: use warning_errno when possible
>   dir-iterator: refactor state machine model
>   dir-iterator: add flags parameter to dir_iterator_begin
>   clone: copy hidden paths at local clone
>   clone: extract function from copy_or_link_directory
>   clone: use dir-iterator to avoid explicit dir traversal
>   clone: replace strcmp by fspathcmp
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
>   clone: test for our behavior on odd objects/* content
>
>  Makefile                     |   1 +
>  builtin/clone.c              |  75 +++++----
>  dir-iterator.c               | 289 +++++++++++++++++++++--------------
>  dir-iterator.h               |  60 ++++++--
>  refs/files-backend.c         |  17 ++-
>  t/helper/test-dir-iterator.c |  58 +++++++
>  t/helper/test-tool.c         |   1 +
>  t/helper/test-tool.h         |   1 +
>  t/t0066-dir-iterator.sh      | 163 ++++++++++++++++++++
>  t/t5604-clone-reference.sh   | 133 ++++++++++++++++
>  10 files changed, 635 insertions(+), 163 deletions(-)
>  create mode 100644 t/helper/test-dir-iterator.c
>  create mode 100755 t/t0066-dir-iterator.sh

A higher level question is what's the benefit of using dir-iterator
API in the first place.  After subtracting 356 added lines to t/,
it still adds 279 lines while removing only 163 lines, so it is not
like "we have a perfect dir-iterator API that can be applied as-is
but an older code that predates dir-iterator API was still using an
old way, so let's make the latter use the former."


