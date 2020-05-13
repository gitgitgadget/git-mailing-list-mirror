Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A83BC433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 16:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C983220708
	for <git@archiver.kernel.org>; Wed, 13 May 2020 16:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KNO+iMdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389515AbgEMQlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 12:41:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64667 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389365AbgEMQlw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 12:41:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 312846221D;
        Wed, 13 May 2020 12:41:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=j2zlK3DKgNph
        auZsj7ZdxmhnLBU=; b=KNO+iMduM7fZoarTo8iD1D3sTQvJlx+BdgE40+fDWH/u
        3/ICCertMMv96tGit8lcgEM0x+ZjTappzdyqTnO18vvRDaqKQXrTyIsme1sM5P3A
        zRQ7ukB2KQGu/4dswbHAhXU1u//4/yLaMYaZYV8MaGDKp0gbikf7bfkRNbQ4zjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=lbNrL7
        9BbALPERZXOUiLfZ13mBNJ2JG3dm72wWywCK37hguzYS2dRU8NHi4a7r7/pOWEEw
        FegWUNYUdX4N4W/zO4LjJsXLB1pOtxX81CZpKtVLXDPRyxyUY8CZI6uBaA5U5uRy
        R50ExLcLEVnDs0dkOWgwGDRnt9LyjtmljupjU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 293CF6221C;
        Wed, 13 May 2020 12:41:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC1F26221B;
        Wed, 13 May 2020 12:41:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] CI: Enable t1509 on GitHub Actions and Travis
References: <cover.1589375923.git.congdanhqx@gmail.com>
Date:   Wed, 13 May 2020 09:41:49 -0700
In-Reply-To: <cover.1589375923.git.congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Wed, 13 May 2020 20:23:05 +0700")
Message-ID: <xmqqh7wjvlbm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A46850CA-9538-11EA-9CFA-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> It's our long desire to enable t1509 in CI system [1]
>
> This is here to enable it.

Yuck.

It's not like having a single repository at /.git that govern
everything on the machine is a usecase we care about, but if it is
easily ported with just two patches, and the task has already been
done, then why not?  ;-)




>
> [1]: https://lore.kernel.org/git/1FEDCA48-FE77-44C3-8C4A-65B4C435E6B3@g=
mail.com/
>
> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh (2):
>   t1509: correct i18n test
>   CI: enable t1509 in Travis and GitHub Actions
>
>  ci/lib.sh                 | 13 +++++++++++++
>  ci/run-docker-build.sh    |  3 +++
>  t/t1509-root-work-tree.sh |  4 ++--
>  3 files changed, 18 insertions(+), 2 deletions(-)
