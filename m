Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9896CC2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3052076A
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 23:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="on1J5HU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgI1X3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:29:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54156 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgI1X3F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 19:29:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CC481EF386;
        Mon, 28 Sep 2020 18:11:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g0Q7/qtgUOHJptZmAL3VtrHA4VU=; b=on1J5H
        U1oAr+XZSUubuWj8pKKIxyxwNsyYNad2UqkhOAxZM6h/EfjCe6XTVB+JthKDTtQH
        48uZDpfgU20zkWqgEopVSJZLtpbSoVKvVSXNT17y4NKN+VftYXPXSdI5xXuRE5zZ
        1+v9Fr/nPuhxjO7xi997U+4vIFZ5iejX/fk2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Um7bF2Y/0mdLTzhmagCVGzkIHEucK9a2
        QOVCpLvZVjzY60tYspRWPpj+9zeEhhzOGXDbUaJ90bm7lSgA6pu6Z3JSGSxG0mFJ
        Ri+D8zLAavfFnXeYLdQe7i8jBsuxu3sqrAS9GZ1D5S00zFBSCb60b6L6aw+73KZW
        YbN3l8EqP2U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ADEB8EF385;
        Mon, 28 Sep 2020 18:11:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D1C42EF384;
        Mon, 28 Sep 2020 18:11:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH v3 11/11] cmake: fix typo in message when `msgfmt` was
 not found
References: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com>
        <pull.738.v3.git.1601327357.gitgitgadget@gmail.com>
        <c3e235fe39b41b90a8a00d81220cb28e83580f13.1601327357.git.gitgitgadget@gmail.com>
Date:   Mon, 28 Sep 2020 15:11:13 -0700
In-Reply-To: <c3e235fe39b41b90a8a00d81220cb28e83580f13.1601327357.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 28 Sep 2020
        21:09:16 +0000")
Message-ID: <xmqqtuvhk0vy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86F54B7C-01D7-11EB-A8DC-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Shouldn't this be squashed into the step being fixed, which is part
of this series?  Would it be the "fall back to using..." step (4/11)?

>  contrib/buildsystems/CMakeLists.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 4b16744847..b9fced682e 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -166,7 +166,7 @@ find_program(MSGFMT_EXE msgfmt)
>  if(NOT MSGFMT_EXE)
>  	set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
>  	if(NOT EXISTS ${MSGFMT_EXE})
> -		message(WARNING "Text Translations won't be build")
> +		message(WARNING "Text Translations won't be built")
>  		unset(MSGFMT_EXE)
>  	endif()
>  endif()
