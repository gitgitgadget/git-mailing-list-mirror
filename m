Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB52C2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 06:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24E46120D
	for <git@archiver.kernel.org>; Sat, 22 May 2021 06:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhEVGsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 02:48:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58842 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhEVGsN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 02:48:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 72B42144EFC;
        Sat, 22 May 2021 02:46:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GSkCxs0XOd6Z
        l4+UPQGw1Gus+g01XXnZ2y8WqNhwhBc=; b=E/BC9T20egZhU/PZo8mAZ0iTN2va
        wgfGqDeYpLiu6FCHnBv5pQQl0A8ghmrpMel5wIjwjIIdATorr1wJvt/QuIohYKx5
        D8CuSRoNNpNXvuCKN5q6dfqyZdMgtMUV/4/8+DxkI8M7VsueSRyB0lI9leQtiafu
        pGcZA7x7Tx+RfXE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C15F144EFB;
        Sat, 22 May 2021 02:46:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A9C3B144EFA;
        Sat, 22 May 2021 02:46:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t: use configured TAR instead of tar
References: <20210522062815.17083-1-congdanhqx@gmail.com>
Date:   Sat, 22 May 2021 15:46:45 +0900
In-Reply-To: <20210522062815.17083-1-congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Sat, 22 May 2021 13:28:15 +0700")
Message-ID: <xmqqk0nrqn8q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7A3F387E-BAC9-11EB-97DE-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> Despite that tar is available everywhere, it's not required by POSIX.
> And, we're allow users to specify which tar they want to use in Makefil=
e

s/we're/we/;

> knobs, and we prefer GNU tar in autotools script.

The last part I didn't know about---it is sad if autotools require
use of gtar (but since use of autoconf and autotools is not required
to build Git, I do not deeply care ;-)).

> In our testsuite, 7 out of 9 tar-required-tests use "$TAR", the other
> two use "tar".
>
> Let's change the remaining two tests to "$TAR".

Nice.
