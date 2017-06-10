Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 684AC1F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 05:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbdFJFyl (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 01:54:41 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33897 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbdFJFyk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 01:54:40 -0400
Received: by mail-pf0-f176.google.com with SMTP id 15so7383929pfc.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 22:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=toy5xpDSCr1QsiHNMn+0+JnkHDe6dI/im1PVHz7pnKU=;
        b=E7A3AxXKJ+tI2Taqyb2txaB+YMbT/vSSmYrM+OVhmWsdHU75QKkVuz63OUGuVkZ8eT
         kDDCQmO1i1djZbtgY/0m7u3z+pEn7rNGm+Lw0o1qq1viu2Oj83E3cR4gWgRuNWkIXpBN
         3IWfzp9x9XJvUDnk+scgw9pGgc3sy+cTtx3n9J6RSmWDBR1Rm9fEEqSxfdzIaWYSXKVH
         HANJ2ya34QaZllal+1jUmW0qHFBcvvtYIv8uY52zzFFhIYaBJGoLXcLBZE91MGuMSXEI
         cKCECBt+M5y0Nkk0nyWLjtnllCB8v2pCvC09FRexJDaHwZqAbnl9TQQQkdvmgBpB8+GE
         Vgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=toy5xpDSCr1QsiHNMn+0+JnkHDe6dI/im1PVHz7pnKU=;
        b=IK7pKJ1nqWu6hWYgllyQRh8J1vYMdbPOdGhudCXy09LCh2f9cfaIVFp0fz9Cfws8Wi
         kVvwgqxVruTLx+STXBzYjYnbI/94yOpoVqmGDHpUffG4VCQxDUH+YnSu0N9+rSHRWMCA
         Gx+fMWQCXH47W3aINfS4a3G9/hNwp07M86K/FNCCOOw8gpZdLx1053FIEk71a9Zq2atv
         NPwJHMC9ghksy81ig/x6GXhpWE8u+lN96MjXR5sNIC6AJFIYexv5D6AM3qjvaXn9BkAX
         tW2oNqURFW7KCkPE08RYJBqRCjLq32rWqyNZBk2ONuRPffe391EoOIn2PE7SDpWawKlF
         s3SQ==
X-Gm-Message-State: AODbwcB/29D8wBWmduVokIEGSqNj5l2CtDVh34hX3qXtccR7wD8Vt/We
        z60JoHGKcD93Wg==
X-Received: by 10.98.147.67 with SMTP id b64mr45934903pfe.145.1497074079549;
        Fri, 09 Jun 2017 22:54:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d192:93c8:4f75:5879])
        by smtp.gmail.com with ESMTPSA id i188sm6409610pgd.5.2017.06.09.22.54.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 22:54:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Xie <emilyxxie@gmail.com>
Cc:     git@vger.kernel.org, novalis@novalis.org
Subject: Re: [PATCH] pathspec: die on empty strings as pathspec
References: <20170607033308.33550-1-emilyxxie@gmail.com>
Date:   Sat, 10 Jun 2017 14:54:38 +0900
In-Reply-To: <20170607033308.33550-1-emilyxxie@gmail.com> (Emily Xie's message
        of "Tue, 6 Jun 2017 23:33:08 -0400")
Message-ID: <xmqqfuf82xr5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Xie <emilyxxie@gmail.com> writes:

> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index f3a4b4a..40a0d2b 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -331,9 +331,8 @@ test_expect_success 'git add --dry-run --ignore-missing of non-existing file out
>  	test_i18ncmp expect.err actual.err
>  '
>  
> -test_expect_success 'git add empty string should invoke warning' '
> -	git add "" 2>output &&
> -	test_i18ngrep "warning: empty strings" output
> +test_expect_success 'git add empty string should fail' '
> +	test_must_fail git add ""
>  '

Doesn't this affect the tests that follow this step?  We used to
warn but went ahead and added all of them anyway, but now we fail
without adding anything, which means that the state of the index
before and after this patch would be different.

>  test_expect_success 'git add --chmod=[+-]x stages correctly' '
