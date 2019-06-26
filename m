Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC07A1F461
	for <e@80x24.org>; Wed, 26 Jun 2019 18:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfFZSNV (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 14:13:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51954 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfFZSNU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 14:13:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E93D16B395;
        Wed, 26 Jun 2019 14:13:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=k74bhzUND8bs
        SON0c/cUAa8GuRM=; b=nOe/hckanvLW2lJGMNMd9gGnoI/esm0BrMpOGGZjkVXU
        IgF/q2jjq8q0hiME2zawl/gvTTAePieOfFKCcV30N+fftHG3uhVYmGWswl9VD/Ib
        LPNnSrTVt2Gokb9Mq+L85iAkjh5+uJlZgJUFRlOKv+s1b0595SKX3Zi+JFvSkMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vkUHGW
        YAl41p6knVNrS7gVK60w0NA/bfyoCiLw2z//dQ20zljTusT0JmecGa1n6CmnulK8
        qxuHA07cWYliBHqFFCxC5wh1sSwnd/5YXAAq2nNZtaItc1/w/k5JmbpyG/Mr7Zuz
        6YvuXyZgq0Q9H/2wJgB244NAk9h4dZXnK/qTM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35BF516B394;
        Wed, 26 Jun 2019 14:13:20 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9CD5D16B393;
        Wed, 26 Jun 2019 14:13:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [RFC/PATCH 2/7] grep tests: move "grep binary" alongside the rest
References: <87r27u8pie.fsf@evledraar.gmail.com>
        <20190626000329.32475-3-avarab@gmail.com>
Date:   Wed, 26 Jun 2019 11:13:18 -0700
In-Reply-To: <20190626000329.32475-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 26 Jun 2019 02:03:24 +0200")
Message-ID: <xmqqsgrwcj0h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 13A68900-983E-11E9-8E10-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Move the "grep binary" test case added in aca20dd558 ("grep: add test
> script for binary file handling", 2010-05-22) so that it lives
> alongside the rest of the "grep" tests in t781*. This would have left
> a gap in the t/700* namespace, so move a "filter-branch" test down,
> leaving the "t7010-setup.sh" test as the next one after that.

A gap here and there is fine.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  ...ilter-branch-null-sha1.sh =3D> t7008-filter-branch-null-sha1.sh} | =
0
>  t/{t7008-grep-binary.sh =3D> t7815-grep-binary.sh}                  | =
0
>  2 files changed, 0 insertions(+), 0 deletions(-)
>  rename t/{t7009-filter-branch-null-sha1.sh =3D> t7008-filter-branch-nu=
ll-sha1.sh} (100%)
>  rename t/{t7008-grep-binary.sh =3D> t7815-grep-binary.sh} (100%)
>
> diff --git a/t/t7009-filter-branch-null-sha1.sh b/t/t7008-filter-branch=
-null-sha1.sh
> similarity index 100%
> rename from t/t7009-filter-branch-null-sha1.sh
> rename to t/t7008-filter-branch-null-sha1.sh
> diff --git a/t/t7008-grep-binary.sh b/t/t7815-grep-binary.sh
> similarity index 100%
> rename from t/t7008-grep-binary.sh
> rename to t/t7815-grep-binary.sh
