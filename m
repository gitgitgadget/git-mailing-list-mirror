Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A085DC2B9F4
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80FC560698
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhFODNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 23:13:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61958 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhFODNv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 23:13:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9813612541A;
        Mon, 14 Jun 2021 23:11:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=h8mY1vAyH8U9
        2BI1F98Sng2Y9/cgRQUFM0ImcJj2+bU=; b=TF1Vx0nVjwFhjghjKuxz2FKy8iB9
        FWsl2U3HC5uQPZhsw3Soag1Kl3LLEN26Vdy6f8GIJhpfuRX/sndg3cH9LEcTVvlK
        7QQ222wFrGLROnId6vfwTcF/kD7MFQGw9/UzO+/bjp8gtdMy3XdT3W4pZqfq2zyS
        5tiQAVU7fDWMeXU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 90D65125419;
        Mon, 14 Jun 2021 23:11:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D7E1E125417;
        Mon, 14 Jun 2021 23:11:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 0/4] show-branch: add missing tests, trivial color
 output fix
References: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com>
Date:   Tue, 15 Jun 2021 12:11:43 +0900
In-Reply-To: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 14 Jun
 2021 19:18:06 +0200")
Message-ID: <xmqq8s3byg7k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6A153892-CD87-11EB-AD58-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This is a series I've had lying around for a while, when looking at
> the color output for show-branch I noticed it reset and re-enabled
> color for every single space character.
>
> This fixes that, but mostly fixes the mostly non-existing tests for
> that old command it. It still has big blind spots, but now we have
> fewer blind spots.

I am surprised if there are still users of this command that I wrote
only for my own use and that I no longer use more than once every
two months ;-)

Thanks.  Will queue.

>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
>   show-branch tests: rename the one "show-branch" test file
>   show-branch tests: modernize test code
>   show-branch: fix and test --color output
>   show-branch tests: add missing tests
>
>  builtin/show-branch.c          |   9 +-
>  t/t3202-show-branch-octopus.sh |  70 ----------------
>  t/t3202-show-branch.sh         | 149 +++++++++++++++++++++++++++++++++
>  3 files changed, 155 insertions(+), 73 deletions(-)
>  delete mode 100755 t/t3202-show-branch-octopus.sh
>  create mode 100755 t/t3202-show-branch.sh
