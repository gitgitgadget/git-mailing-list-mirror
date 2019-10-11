Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AB781F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 06:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfJKGAC (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 02:00:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52865 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfJKGAC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 02:00:02 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9E52699514;
        Fri, 11 Oct 2019 02:00:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7NFnokr40aNrAwtVULqtTDNm3Fo=; b=YxkVg8
        HPvTqNztS7engY552XV9xqe3zNqrAwcfbQdDcCTmNmoTrKeyH3bOYz0j3L5VBWGg
        VZ1zCPH3JlBR3Uygg06mqPiWbess3w2b0YeGFTajGOQMdy852F9AkUBlA2lxR90V
        DDWa9WudWdfb6jPKxeppY0EXqZBVX+Xeiofpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lVK50/UgZyq/kGrJ42dmWkWRg9DwxpmV
        RbDSidYl2e/+yeCmhr2z2/6XkhoWOwilrGjx0zPo9qYZnlsjG3Ulg/TIucLpRBgW
        XbHuc43Q+PZak+lnqyH1SZp5fyEjp+z/JQ8GFVuZ0+x5oWl/W5gn/wmvouNDVs8t
        pgQQfgrgs70=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E81199513;
        Fri, 11 Oct 2019 02:00:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B773D9950C;
        Fri, 11 Oct 2019 01:59:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] pthread.h: manually align parameter lists
References: <b3d6dfe44a76c4f3bf00eb901c1844b12300c66e.1570736137.git.liu.denton@gmail.com>
Date:   Fri, 11 Oct 2019 14:59:55 +0900
In-Reply-To: <b3d6dfe44a76c4f3bf00eb901c1844b12300c66e.1570736137.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 10 Oct 2019 12:37:04 -0700")
Message-ID: <xmqqimovhles.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5AADCEC4-EBEC-11E9-925D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In previous patches, extern was mechanically removed from function
> declarations without care to formatting, causing parameter lists to be
> misaligned. Manually format changed sections such that the parameter
> lists are realigned.
>
> Viewing this patch with 'git diff -w' should produce no output.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> I missed a step in 'dl/compat-cleanup'. This patch can be applied on the
> tip of that branch.
>
>  compat/win32/pthread.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
> index f1cfe73de9..737983d00b 100644
> --- a/compat/win32/pthread.h
> +++ b/compat/win32/pthread.h
> @@ -51,7 +51,7 @@ typedef struct {
>  } pthread_t;
>  
>  int pthread_create(pthread_t *thread, const void *unused,
> -			  void *(*start_routine)(void*), void *arg);
> +		   void *(*start_routine)(void*), void *arg);

Yup, I missed that too.  Thanks for a clean-up.

>  
>  /*
>   * To avoid the need of copying a struct, we use small macro wrapper to pass
