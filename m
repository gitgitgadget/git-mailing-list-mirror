Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CC7C1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 06:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfKGGS5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 01:18:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61670 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfKGGS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 01:18:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3AFC30471;
        Thu,  7 Nov 2019 01:18:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TacODxPrhN+ZZB402jSslVbn6g8=; b=VaTRmI
        0Rt9SD7ZHkcxF/FiLZlh2tRSkkoNf0JehR967vVA739UJHw/TxruP1w0z4mUxTPb
        7rsoDGhhHOuxjfWWXuMDQ7eAiyA6SP4syxXAiUtwYnWOat234vfT5L/vU5sR7JS/
        It2VMPSQCNwddi4JnAccsdamRnUEgIH9GiV2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rpyH4vbHJi1grcPpAAahH6H7tZgmg55O
        eVJ6V/NI8ZSf30uLLB5U4388umn1qJnctO0Kf2343xe8hKwodOtt8gOaPFb5fh/f
        YHSuFdp6VnTCzuD23bjLMGIiAH6VIXEvzyx6uNPC59k7bfSV5j84a4lKRr41JFMd
        zx/YwscqewQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC6E73046F;
        Thu,  7 Nov 2019 01:18:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 19A413046E;
        Thu,  7 Nov 2019 01:18:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 2/8] configure.ac: define ICONV_OMITS_BOM if necessary
References: <20191031092618.29073-1-congdanhqx@gmail.com>
        <cover.1573094789.git.congdanhqx@gmail.com>
        <f07566c60c4421a5b33ef5c74a9a0a58947e7750.1573094789.git.congdanhqx@gmail.com>
Date:   Thu, 07 Nov 2019 15:18:52 +0900
In-Reply-To: <f07566c60c4421a5b33ef5c74a9a0a58947e7750.1573094789.git.congdanhqx@gmail.com>
        (Doan Tran Cong Danh's message of "Thu, 7 Nov 2019 09:56:13 +0700")
Message-ID: <xmqqbltoqkdv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79275C72-0126-11EA-984A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Doan Tran Cong Danh <congdanhqx@gmail.com> writes:

> From commit 79444c9294, ("utf8: handle systems that don't write BOM for
> UTF-16", 2019-02-12), we're supporting those systems with iconv that
> omits BOM with:
>
>     make ICONV_OMITS_BOM=Yes
>
> However, typing the flag all the time is cumbersome and error-prone.

Drop the last sentence.  Not having to give the flags is an already
solved problem and the solution is to use config.mak.

> Add a check into configure script to detect this flag automatically.

This is good.  "Makefile supports this knob, configure script was
not aware of it.  Teach configure to do so" flows the thought
perfectly well (and "typing all the time" does not have to come into
picture).

Thanks.
