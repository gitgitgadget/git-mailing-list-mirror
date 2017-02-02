Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48B4A1F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 09:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751074AbdBBJcU (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 04:32:20 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:35053 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdBBJcT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 04:32:19 -0500
Received: by mail-ot0-f179.google.com with SMTP id 65so7654627otq.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 01:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fRDFUFk+0wm1y2wpj5nL2Ar13SJfoh1usRozD/aiOgk=;
        b=MYD2prwJLDsHbsLn3TFvPmXW1Mt/bkw+g7NLUTCmVHtSRJPFAkvTwEz9tDJzvwEhcs
         UnSA4m5P/bzZZ/SFbaXB+Vfzqk2TsIvfdu985DoPCQAMJ3rMibAP0YDEbvFE3VKBgA9q
         4APitbLfCyb4GRUjqCBFeaRXjjz0d75c0FuySY4KkUfrYl1QCRJ4qJzt9RyEc37Gt0j5
         3K3f9HyasRZ/abRwaISAJ13uehrJ/qx/Ui0ZEuTTCeuoLwleFMNYLGU2dTTtVLEuLXV7
         BbHZLxuHwN+TL8WBQQRvug5uRLbi2pCO2eWQcCHkwXlj4AqzOfVV7chUlg3/nKkovg5x
         HJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fRDFUFk+0wm1y2wpj5nL2Ar13SJfoh1usRozD/aiOgk=;
        b=eWb/lGWCG9Fn5PqrUTDCfON9oDePAxLPTgPQ273JydKxc5vNr+hAgpqwqpDBTrrGMJ
         dnZnfonDMVzAJxCJaUfJr+hLAtUg9geYLXj5C+e69ypycBCXKlO60ojKHwdC6rD7fOap
         zdFIlysAOTbI0zOpADuRNdYpDIGmMcw8rBUGssKRqfASHx0g+kJCJrN8K5HOAxKqyXXp
         VBU31CJMCU5eyy05ivpmVifQsqODFffMGX2z+fIfm9pwH/izhgbxNbsJd9MwV8tXqHpF
         xCr1QnHFQhMT8dEOv83d8+0nyeJmJCn9a84BqX5vinQ70z7ltL5yU7KQ5G98drj+j+M/
         203w==
X-Gm-Message-State: AIkVDXLOn2OwsUGu54Qex+agcCu4+1YHdazb2tnBm3NoWzVcjw1Mj96CNMB/t/+60IrTc5RsfWl8DlK1sJxZIw==
X-Received: by 10.157.18.246 with SMTP id g109mr3948277otg.10.1486027938843;
 Thu, 02 Feb 2017 01:32:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Thu, 2 Feb 2017 01:31:48 -0800 (PST)
In-Reply-To: <87h94d8cwi.fsf@kyleam.com>
References: <87h94d8cwi.fsf@kyleam.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 Feb 2017 16:31:48 +0700
Message-ID: <CACsJy8AZUBt76ZocS2JEr9FP_8Obv8L911AvZxE_sww3qXB7qw@mail.gmail.com>
Subject: Re: init --separate-git-dir does not set core.worktree
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2017 at 10:55 AM, Kyle Meyer <kyle@kyleam.com> wrote:
> Hello,
>
> As of 6311cfaf9 (init: do not set unnecessary core.worktree,
> 2016-09-25), "git init --separate-git-dir" no longer sets core.worktree
> (test below).  Based on the commit message and the corresponding thread
> [1], I don't think this change in behavior was intentional, but I wasn't
> able to understand things well enough to attempt a patch.

I'm missing some context. Why does --separate-git-dir have to set
core.worktree? What fails for you exactly?

>
> Thanks.
>
> [1] https://public-inbox.org/git/CALqjkKZO_y0DNcRJjooyZ7Eso7yBMGhvZ6fE92oO4Su7JeCeng@mail.gmail.com/T/#u
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index b8fc588b1..444e75865 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -309,6 +309,7 @@ test_expect_success 'init with separate gitdir' '
>         git init --separate-git-dir realgitdir newdir &&
>         echo "gitdir: $(pwd)/realgitdir" >expected &&
>         test_cmp expected newdir/.git &&
> +       check_config realgitdir false "$(pwd)/newdir" &&
>         test_path_is_dir realgitdir/refs
>  '
>



-- 
Duy
