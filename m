Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B80C51F463
	for <e@80x24.org>; Mon, 16 Sep 2019 19:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388089AbfIPTZv (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 15:25:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57874 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfIPTZv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 15:25:51 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E85A285B8;
        Mon, 16 Sep 2019 15:25:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BDuMoZKWn7KRjceZnnYrh4ZR+mM=; b=YtvNib
        4UV+oe0t4Wg1gSzqN7c4hxw7uArAdL+V77kw7iDYYCVpF3YtihVc/uSYPN8s9Yl5
        8KM0HWzSs9Ia9u9TVMApf6ozeaW2Yhcw8jBMaxDF2u3IC/GAtZk0t0x19jSSUckQ
        Nv2qDGRMuXya7ywNZv0elwvp03Q4yzlr1TE4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YptNgdOTKwmSTEdYHdhomgeDSXt2+NvD
        hrr4N5GMEWuj3Bmbqig/3Y/45bTioqhPEHksa3yz43I103C+q49qiA8q/Jp57A1U
        X4yxio9thvLTHzx+vYGXmdJ+FfBMRGrFY7Dzy5TbFFJA8j82MpdLwne81rb65lto
        FLRHUT/gwqA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 657A4285B7;
        Mon, 16 Sep 2019 15:25:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F04B285B6;
        Mon, 16 Sep 2019 15:25:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] git-submodule.txt: fix AsciiDoc formatting error
References: <796a25ee1e9a9c0421d42ab6644e81d23a9bd99b.1568142486.git.liu.denton@gmail.com>
        <2ae16375ba185bcaceb2ba3e8843db495f0044a6.1568657575.git.liu.denton@gmail.com>
Date:   Mon, 16 Sep 2019 12:25:46 -0700
In-Reply-To: <2ae16375ba185bcaceb2ba3e8843db495f0044a6.1568657575.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 16 Sep 2019 11:19:17 -0700")
Message-ID: <xmqq4l1cavr9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C923B0F0-D8B7-11E9-98A6-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Break `--default` and `--branch` into their own separate invocations to
> make it obvious that these options are mutually exclusive.

That sounds even clearer than what the original wanted to do.  Very
good idea.

> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 0ed5c24dc1..1f46380af2 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -173,7 +173,8 @@ submodule with the `--init` option.
>  If `--recursive` is specified, this command will recurse into the
>  registered submodules, and update any nested submodules within.
>  --
> -set-branch ((-d|--default)|(-b|--branch <branch>)) [--] <path>::
> +set-branch (-b|--branch) <branch> [--] <path>::
> +set-branch (-d|--default) [--] <path>::
>  	Sets the default remote tracking branch for the submodule. The
>  	`--branch` option allows the remote branch to be specified. The
>  	`--default` option removes the submodule.<name>.branch configuration
