Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02589C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 06:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A9B61DC4
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 06:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhF2Gbx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 02:31:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58783 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhF2Gbw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 02:31:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A65E13431E;
        Tue, 29 Jun 2021 02:29:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=7JdD8uMULy7lTY2ytrcH0g7TB
        YDXXoqIv+wJWSiv5oA=; b=IOIl/voZG5RRxLf5pnBv+gRaBdx/2WDiO5TaDBClR
        g20UuCYwtYo74LrbkQRqFLcCpo4IwLNIgYdTLNfiZo5dbHj2gPsXBEIuLojHR9sc
        kEikt7PTSWzVl2GtaMYAsf+6SFCJQiDHD0+jie40ak4cidMPJXrcxhsZfg3eK6d0
        YM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 132AB13431D;
        Tue, 29 Jun 2021 02:29:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5B04113431C;
        Tue, 29 Jun 2021 02:29:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>
Subject: Re: [PATCH 0/3] Makefile: "make tags" fixes & cleanup
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
Date:   Mon, 28 Jun 2021 23:29:21 -0700
Message-ID: <xmqqa6n9yyim.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5813C65A-D8A3-11EB-BE23-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> A small series to fix the various "tags" targets, i.e. "make tags TAGS
> cscope". We'll now properly detect their dependencies, so we don't
> needlessly run them every time. I have this as part of my standard
> "make git" command, so doing nothing when we have nothing to do is
> preferrable, especially when my editor will eagerly reload the TAGS
> file every time it changes.
>
> As noted in 3/3 this is better on top of my just-submitted
> .DELETE_ON_ERROR change[1], but will also work independently of that
> patch/series.
>
> 1. https://lore.kernel.org/git/patch-1.1-9420448e74f-20210622T141100Z-a=
varab@gmail.com/
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
>   Makefile: move ".PHONY: cscope" near its target
>   Makefile: fix "cscope" target to refer to cscope.out
>   Makefile: don't use "FORCE" for tags targets
>
>  .gitignore |  2 +-
>  Makefile   | 31 +++++++++++++++++--------------
>  2 files changed, 18 insertions(+), 15 deletions(-)

Looks mostly like good patches, with concrete suggestions for
improvements given.  Please do not leave another loose end that
should be easy to tie untied and float away to some other topics.

Thanks.
