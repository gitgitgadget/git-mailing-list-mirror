Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B8971F406
	for <e@80x24.org>; Tue, 15 May 2018 01:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeEOBXY (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 21:23:24 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:46958 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbeEOBXX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 21:23:23 -0400
Received: by mail-yw0-f195.google.com with SMTP id i17-v6so4180334ywg.13
        for <git@vger.kernel.org>; Mon, 14 May 2018 18:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rO+yLd+Rqe4XlX4HAsRiTCPV38sA1ErOsYHYMoK28NU=;
        b=gqwBdALzwt2NkS0Om/LiM+5BULnQBJ/2xyN36NZNt5TqldIcN6V5KXmfTQ7R6xrmmv
         sL9dkL8L4QbY4eZIuzC/oaFe7Luv8szMVIx0OBu4TLepCAcCMDAzpuYkvqnd9uYPmUXh
         226+P/8Cs25H7ybgCbYvFQONJXozdpSRmJmcL4p0kSuTrOymmsTEdAUksZ/rt16EeSBi
         FZDQFeVbDvKn6uKGGKutYATzbliqFkCfyODac5D5XMYMVJeJMKftJZNXoF9uLNrej+ZH
         LEWpbjMAKDuSCif0SOa27PxeKcHZsMkOWIZNM3cnGHuREFa+K8oIRyIsLiRFmJ/l0jDB
         RiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rO+yLd+Rqe4XlX4HAsRiTCPV38sA1ErOsYHYMoK28NU=;
        b=Bkt/P3hWxEi/rGbZQsmmsNUbGbul86cwEJcZ8RZ9C1a0Xb4XxTtu6ZPmanVUiV+XIN
         l1JPQPZfCpyyBjX+e6yGLRsj3pUA7kjzRnF11mX6AkmKA22Qcpoo9g1r+7mH9bkhIKL9
         yR2+eVe/NvVmB0OBaFTVw1afxpqJ27yALEWDHVIoV8/+VO5OgL9CdPnfdmhh0QZyupRh
         k94R5br3b87tNyb/WBO/Q+qjV0tqc0VWjFXTqjxx/YsSz8vNKe1KPfPgW9B2jBPJ11hM
         JKcorBG0UStOCkq16ndf0rudUWDzr/GtlqpevOhHborcVDblO8AGV5PSo6gO6kLRSx8/
         VmNg==
X-Gm-Message-State: ALKqPweIv5i3NVPXDu2pPtXInXSBaA6oG2JTVoAHK46dG527UADZxATF
        maGj4j3732Ff1LESoEZRQ0wSveMOP8D5GpJbjMAspg==
X-Google-Smtp-Source: AB8JxZqvGvBDkqd5hjW4zlQF+ZSPJExd6Jq5xStWvlVvSmruHmOQwZNtC3reW24caso71FjAzDG7CK4HCe8aGp4Erh8=
X-Received: by 2002:a81:9447:: with SMTP id l68-v6mr5441238ywg.345.1526347402863;
 Mon, 14 May 2018 18:23:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Mon, 14 May 2018 18:23:22
 -0700 (PDT)
In-Reply-To: <20180514105823.8378-4-ao2@ao2.it>
References: <20180514105823.8378-1-ao2@ao2.it> <20180514105823.8378-4-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 May 2018 18:23:22 -0700
Message-ID: <CAGZ79kYJUrT8kZWWKVbJXdtHA_3gHtseS3zMhWZwYF3=3bf4_Q@mail.gmail.com>
Subject: Re: [RFC PATCH 03/10] t7411: be nicer to other tests and really clean
 things up
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 14, 2018 at 3:58 AM, Antonio Ospite <ao2@ao2.it> wrote:
> Tests 5 and 8 in t/t7411-submodule-config.sh add two commits with
> invalid lines in .gitmodules but then only the second commit is removed.
>
> This may affect subsequent tests if they assume that the .gitmodules
> file has no errors.
>
> Since those commits are not needed anymore remove both of them.
>
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
>
> I am putting these fixups to the test-suite before the patch that actually
> needs them so that the test-suite passes after each commit.
>
>  t/t7411-submodule-config.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
> index 0bde5850a..a648de6a9 100755
> --- a/t/t7411-submodule-config.sh
> +++ b/t/t7411-submodule-config.sh
> @@ -135,7 +135,7 @@ test_expect_success 'error in history in fetchrecursesubmodule lets continue' '
>                         HEAD submodule \
>                                 >actual &&
>                 test_cmp expect_error actual  &&
> -               git reset --hard HEAD^
> +               git reset --hard HEAD~2
>         )
>  '

As this is the last test in this file, we do not change any subsequent
tests in a subtle way.
Good!

This is
Reviewed-by: Stefan Beller <sbeller@google.com>

FYI:
This test -- of course -- doesn't quite follow the latest coding guidelines,
as usually we'd prefer a test_when_finished "<cmd to restore>"
at the beginning of a test.
