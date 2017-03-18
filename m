Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D0162095B
	for <e@80x24.org>; Sat, 18 Mar 2017 17:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbdCRRuS (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 13:50:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62656 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751655AbdCRRuR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 13:50:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C0558321C;
        Sat, 18 Mar 2017 13:49:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ov0ye08YYbZ9
        aOV2hhNeA1lFSyM=; b=BTSLKHRAj5JveRjS6RmMzyMlKiCAOSFGavj21hNhtRof
        JCsZUsdAYUzwSFBYKvMc7gMGbR1wDotM9dbXSjfPBtjYXFVEv3wDyllnminG1083
        sIGwhcv+NBE/5wlPPe+CWiRuu+FnQjsZobPNy0wIVLrpCVj9its2Soap47jRz48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=pzRGFJ
        JzEMBQpE158O2BsIuTsd+Xbu5OH2HHmzGbZpBhj3nFdd7RQ+7siM7z0fS3jIRkdh
        HRmD98GxcoxGwTVOeD5KFHvKgq1McHRCojUw7Fn8jzEXIPG9pbTRQ85MzP2aeRCW
        PYkjU5dnN85h7VhP1MRO5fgud8GXTtzAynNNc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 753278321B;
        Sat, 18 Mar 2017 13:49:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D18CF8321A;
        Sat, 18 Mar 2017 13:49:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 0/4] Kill manual ref parsing code in worktree.c
References: <20170216120302.5302-1-pclouds@gmail.com>
        <20170318100206.5980-1-pclouds@gmail.com>
Date:   Sat, 18 Mar 2017 10:49:57 -0700
In-Reply-To: <20170318100206.5980-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Sat, 18 Mar 2017 17:02:02 +0700")
Message-ID: <xmqqd1de4gqi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4DDAF68E-0C03-11E7-A20A-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> v3 is a rebased version on latest nd/files-backend-git-dir [1]. Since
> that series added a bunch of new refs_* functions, v2's 02/05 and
> 04/05 are removed. The new 01/04 could be an indepedent fix, but at
> test-ref-store.c requires it, so I put it here. More tests are added
> now that we have test-ref-store.c (yay!)

I think the corresponding ones were queued on a separate topic
nd/worktree-kill-parse-ref that is based on nd/files-backend-git-dir
but I do not mind making these 4 patches just part of the latter
topic.

Will send comments on individual patches separately.

Thanks. =20

>
> [1] http://public-inbox.org/git/%3C20170318020337.22767-1-pclouds@gmail=
.com%3E/
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
>   environment.c: fix potential segfault by get_git_common_dir()
>   refs: introduce get_worktree_ref_store()
>   worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
>   refs: kill set_worktree_head_symref()
>
>  branch.c                               |  15 ++---
>  environment.c                          |   2 +
>  refs.c                                 |  32 +++++++++++
>  refs.h                                 |  12 +---
>  refs/files-backend.c                   |  44 --------------
>  t/helper/test-ref-store.c              |  19 ++++++
>  t/t1407-worktree-ref-store.sh (new +x) |  52 +++++++++++++++++
>  worktree.c                             | 102 +++++++++----------------=
--------
>  worktree.h                             |   2 +-
>  9 files changed, 143 insertions(+), 137 deletions(-)
>  create mode 100755 t/t1407-worktree-ref-store.sh
