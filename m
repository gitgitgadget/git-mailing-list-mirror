Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB8D20467
	for <e@80x24.org>; Thu, 12 Oct 2017 00:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbdJLAyF (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 20:54:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56578 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753052AbdJLAyD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 20:54:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3AC4E978BB;
        Wed, 11 Oct 2017 20:53:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mJ2zoa7eW4vw0XNOZcjlZZiQz0Q=; b=s0iyqo
        hFjGOwuCBWjT+ldfLen69JuD/XWIaMAEzGPEcexSETcNhB7beuhg0ltvOvztqFoB
        Me1oYI4RIMqDBASwZhLt+Xp75X82mf2PijcvDvgUTdhsYpbw/SotP29UBotqyVXq
        LihAPb11TLF/qSBYKgkfqSPkOpob3v/iSZ4PY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=svFvjdLGaRFJufrsnIlVwIYApECLsoXq
        0kQ+I6XwtDIWjl7SHUEb8mdx1Z7lQGbv7GhD9lvj2DrDAOm2XjjLLECcYmQAWb+d
        fL/B/gRYWYlKxy0/1dZ6PZ9whyNI/3fFcJ/e34xhnJxC5ReTYk+l9e1oyxpMqF69
        e9+RWnpx7MA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 33453978BA;
        Wed, 11 Oct 2017 20:53:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 95062978B7;
        Wed, 11 Oct 2017 20:53:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Takahito Ogawa <aiueogawa217@gmail.com>
Cc:     git@vger.kernel.org, Takahito Ogawa <takahito.ogawa@datagrid.co.jp>
Subject: Re: [PATCH 1/1] git-stash.txt: correct "git stash" behavior with no arguments
References: <20171011180350.99888-1-takahito.ogawa@datagrid.co.jp>
Date:   Thu, 12 Oct 2017 09:53:56 +0900
In-Reply-To: <20171011180350.99888-1-takahito.ogawa@datagrid.co.jp> (Takahito
        Ogawa's message of "Thu, 12 Oct 2017 03:03:50 +0900")
Message-ID: <xmqqr2u92nkr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D40AFB1E-AEE7-11E7-B1D7-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Takahito Ogawa <aiueogawa217@gmail.com> writes:

> @@ -33,7 +33,7 @@ and reverts the working directory to match the `HEAD` commit.
>  The modifications stashed away by this command can be listed with
>  `git stash list`, inspected with `git stash show`, and restored
>  (potentially on top of a different commit) with `git stash apply`.
> -Calling `git stash` without any arguments is equivalent to `git stash save`.
> +Calling `git stash` without any arguments is equivalent to `git stash push`.

Hmph.  Is there any difference between

	git stash save
	git stash push

without any other argument?  Aren't they equivalent to

	git stash

without any argument, which is what this sentence explains?

