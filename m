Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBF131F597
	for <e@80x24.org>; Fri,  3 Aug 2018 23:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732034AbeHDBkK (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 21:40:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44262 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbeHDBkK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 21:40:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so6802469wrt.11
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 16:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1eQj1FO4aw/fdxiC+2TXDRHvw09QeobstC8j+6cSRhg=;
        b=cDkdV4kq5/TqmCm3v+vv3AYaOWraTQaF/0XO0WupFWQuKgxsmfuw3/PUpaHtp/WDOK
         jfTTxPYghQCG/nqFhVvwB24xdVr8uouc4zIRbsW7daJHpzaXvckupyrwQFMsx9KTKZLk
         IVTZHaPppxrLDaRfY4kGR3qbd5UWwSfKqNOMopvv5ZOkLsZxgU8OVuwmfJ9KVKhYdogU
         Cula4QpWvvSb/FvQ2/1U72G0KB8N2VDrStsr/7A+WlI/Sv4CUwRstzqj7g1l+MGwVMFr
         F8R72exIpxnwRKWUc/yklpIG4Vo6DgDN4QNZmLBgkKhILbHo/Xh7lYrqZfwAt+AG6vSs
         bCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1eQj1FO4aw/fdxiC+2TXDRHvw09QeobstC8j+6cSRhg=;
        b=GM3UmUMNnhAe9lgjLrjYqkpWEISKAOycvnN/7MZl3OFEyM+jjYJy1yH4p5eKzJ6Dra
         3dVvgbwUNraeEW2SO00n9zwz3LvfmjeUr/dAP3Qs+PS8t2GpmkHuJ9trdDbNfygbxG1C
         ZawxeZ1L0RNZ7lQ3sQT5qvFpVqSqMA675AAjsj7HyScklm7NHKegdJ5qnCHPQxDsE9vg
         vMezOkOCnbvaUSaBeQscq76yq11Rx3XcCJvPMDX39h8Ti8QbO6iqiNfAboOUKzrg9IUh
         Z8IisgSpFmWAStd6He11uHygmdTyK8QIaa0DfaMdR1Tptkv6M89TSuZP5nouT/nIFr52
         5G7g==
X-Gm-Message-State: AOUpUlHnyhO80oGBgARj7ut4YwltUvwoRz/vcYvPbmd+xOnIxxlyDOVT
        2IjSPkowVL0EU3eebN+GPdU=
X-Google-Smtp-Source: AAOMgpc0BcrJojnUMeDdzcUzGbHkOR7d/TSqIYQcbrPcETEfkxyFVPc7kkbfbqbfYzqQPJ8c+64fNQ==
X-Received: by 2002:adf:8877:: with SMTP id e52-v6mr4061139wre.30.1533339703269;
        Fri, 03 Aug 2018 16:41:43 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u71-v6sm814094wmd.12.2018.08.03.16.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 16:41:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t7406: Make a test_must_fail call fail for the right reason
References: <20180803231407.10662-1-newren@gmail.com>
Date:   Fri, 03 Aug 2018 16:41:42 -0700
In-Reply-To: <20180803231407.10662-1-newren@gmail.com> (Elijah Newren's
        message of "Fri, 3 Aug 2018 16:14:07 -0700")
Message-ID: <xmqqd0uzuifd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> A test making use of test_must_fail was failing like this:
>   fatal: ambiguous argument '|': unknown revision or path not in the working tree.
> when the intent was to verify that a specific string was not found
> in the output of the git diff command, i.e. that grep returned
> non-zero.  Fix the test to do that.
> ---
>  t/t7406-submodule-update.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index f604ef7a72..7be8b59569 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -599,7 +599,7 @@ test_expect_success 'submodule update - update=none in .git/config but --checkou
>  	 ) &&
>  	 git diff --raw | grep "	submodule" &&
>  	 git submodule update --checkout &&
> -	 test_must_fail git diff --raw \| grep "	submodule" &&
> +	 git diff --raw | test_must_fail grep "	submodule" &&

Good spotting, but a few comments.

 * I've seen "do not have 'git' upstream on a pipee (it would hide
   the exit status from an unexpected failure of 'git') recently.
   We probably want to do the same.

 * We do not use test_must_fail for non-git things, as we are not in
   the business of protecting us from unexpected segfault of system
   binaries like grep.

So an immediate improvement for this line would be

	! git diff --raw | grep " submodule" &&

and longer-term clean-up would aim for

	git diff --raw >differs &&
	! grep " submodule" &&

or something like that.  I suspect that --raw may want to be updated
to --name-only or something, as I do not see the tests using the
object names hence no strong need for using --raw format.



