Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BCAC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 17:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50092074D
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 17:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZMVGuyTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388856AbgDBRxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:53:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58516 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgDBRxh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 13:53:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00C6B5FFBC;
        Thu,  2 Apr 2020 13:53:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eGE7ilAYT2Ue
        CQ+7Ny6LXj47h84=; b=ZMVGuyTf8dyrdPmnJdWSbt8jZli1SLdK5LmPbmbfUQsY
        4Xh3OZ7uhnXK0/liy86tApH7zKFTr3lB6ShzGu0Q/++ikzfWuyJHhPpxZK9KPVlh
        LAxbvPqlXZOTyQiXTm5HVdeYTv+FhOLgBgFT93dJ3faCWt5ibeDnkW/rFNN9hzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Y7ZMfz
        cdqiai8u+j1eBX20pHodNCf41hIp8v2ph6djqIldoRzYAXRzGHUOn+fMVDkTq1Rb
        zpysh4y5TRo3TdLgs/0Pad4sDk4kSSKX2imb2GG2zimzWxWYEj1BonUTWS8RT99r
        oJcHAZk0NZI8crR9VP+7KzF+hxK+T1aX1AV58=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB06C5FFBA;
        Thu,  2 Apr 2020 13:53:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 739485FFB9;
        Thu,  2 Apr 2020 13:53:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/6] Travis + Azure jobs for linux with musl libc
References: <cover.1585474409.git.congdanhqx@gmail.com>
        <cover.1585832270.git.congdanhqx@gmail.com>
Date:   Thu, 02 Apr 2020 10:53:35 -0700
In-Reply-To: <cover.1585832270.git.congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Thu, 2 Apr 2020 20:03:59 +0700")
Message-ID: <xmqqsghl3hb4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E080DBD4-750A-11EA-9F60-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> This is a nearly rewrite of this series, because there're GitHub Action
> allow running directly inside container.
>
> =3D> I rewrite this series to prepare as much as possible for the GitHu=
b
> Action series.
> ...
>  .travis.yml                                   | 10 ++++-
>  azure-pipelines.yml                           | 39 ++++++++++++++++++-
>  ci/install-docker-dependencies.sh             | 18 +++++++++
>  ci/lib.sh                                     |  8 ++++
>  ...n-linux32-build.sh =3D> run-docker-build.sh} | 39 +++++++++++++----=
--
>  ci/{run-linux32-docker.sh =3D> run-docker.sh}   | 28 ++++++++++---
>  6 files changed, 121 insertions(+), 21 deletions(-)
>  create mode 100755 ci/install-docker-dependencies.sh
>  rename ci/{run-linux32-build.sh =3D> run-docker-build.sh} (63%)
>  rename ci/{run-linux32-docker.sh =3D> run-docker.sh} (43%)

Thanks.  The above diffstat makes me wonder if it makes more sense
to do the topic from Dscho first to migrate existing CI targets to
GitHub Actions and then add musl job to the ci suite on top?  That
way, we won't have to worry about azure-pipelines.yml at all here.



