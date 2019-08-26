Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3888D1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 17:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbfHZRG5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 13:06:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60465 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbfHZRG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 13:06:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 989FF6D2EE;
        Mon, 26 Aug 2019 13:06:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qOiwC6xGwFTG
        vxb0VRKpFQrSvzI=; b=G7SyiSyGYgUtAeqcxwaDWWU+HfgtA0sE8Qa1Z6e5LJe2
        ujwVzb/il1ezrV26vn/jngFvjUXgTQBMRcJQ3UBWlquKd+vwac1r3eTYk+7qpfrm
        wcJfh1xlvCo9W2bB8VkjIODP3W9bcCkzXo/G+O35pwSa9KobYUo32cXYOK3Q1zI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wGlESM
        DdmGhLvyjD+GT9tQClXaDhiTxidObw3DoiVWDGAq2ec7ea/3adg111eR+XgsLX12
        cHHAUN8ocbuXLtlGDABxi4xqH/eaCSS/87Z/3Ooko3paNMoz98qA+PXUB/DQObgO
        OZOhyu8QoFgCd01IDi3k6GQP6ppcKHRT1EiZU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 90F186D2ED;
        Mon, 26 Aug 2019 13:06:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B8EFD6D2EA;
        Mon, 26 Aug 2019 13:06:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] mingw: support UNC as file://server/share/repo
References: <pull.93.git.gitgitgadget@gmail.com>
Date:   Mon, 26 Aug 2019 10:06:49 -0700
In-Reply-To: <pull.93.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Sat, 24 Aug 2019 15:07:58 -0700 (PDT)")
Message-ID: <xmqq7e6zj1p2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E5E235E4-C823-11E9-812A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Windows users might think that the common file:/// protocol also works =
for
> network shares. This patch makes it so.

Thanks, both.

>
> Torsten B=C3=B6gershausen (1):
>   mingw: support UNC in git clone file://server/share/repo
>
>  connect.c             |  4 ++++
>  t/t5500-fetch-pack.sh | 13 +++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
>
> base-commit: 5d826e972970a784bd7a7bdf587512510097b8c7
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-93%2F=
dscho%2Ffile-url-to-unc-path-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-93/dscho=
/file-url-to-unc-path-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/93
