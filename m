Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AD011F453
	for <e@80x24.org>; Thu, 25 Oct 2018 05:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeJYOPJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 10:15:09 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42145 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbeJYOPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 10:15:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15-v6so3481210wru.9
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 22:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZaWjsLCL7DI2wakjr+9KEp7G4ERsntw41o6Wtzlz6hY=;
        b=ZOs7JmhAZAXULu3OepGbtyN6x9+ehxGticx17ONhzMXPuPEtj7+biSG+2YL6lh8cuc
         4ZsD/4d//2jDa0dVhB5P6m1muM7yUohcZeUIMMBUO1rdE7pbHhFDOBWAVh0maipgex09
         8w1dH5kFPkPWvncnTOy8VVc7sRcNua/2nkg3T2oOsQ7Re6L06nKrCgihIdGp8hMsAB6r
         cFIekH4jGCuJgNHC+hh6bdy+ofjSG7wSbK+wlm2u4aOiHbktIq5qKBEDwcvMPPrMNziX
         hBN7f10AvrdPUnE+fGDwA71tETc5rJfn4V05aFNLG/oF3Z4tju/fM9rTHybrj7iCarZ5
         97lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZaWjsLCL7DI2wakjr+9KEp7G4ERsntw41o6Wtzlz6hY=;
        b=umqvtp89CafOANOeIIYwAvNDvdzS1q2WiLeMAFNA/rMlRVzg9wY/+MVcZM1zuNsGG+
         NGPI1AYh/7C5IG+2WbDWH/dfD1GsQnfhXdfOJrPsidnQHrVxCsU4gpjS4HVyoGRGc5jC
         +rfMTQlGwca9LWmlZD63tFP8G9UYVjimRnmPGc9F6y21BYE/BWcM05KUirAgJEOmDnD2
         rQqmyy2iupY+n5zP+YlYSq5EvkER7TVJJLq44q5eyoj0RwYCjElLwqIRpgnT1O3gbIKR
         Q4NItxYyGquEkGr7wew5Kh/1xVDUpCjv49r11jt5cjtwuVKSmcDtkQk2xL5edMzwaxTX
         o59A==
X-Gm-Message-State: AGRZ1gKwGBMG3iRge53Q82908uNpszKut4ZlBsBVIrBnbBsk1k7b8C89
        +7pgcsYzY/yZIIphHG2T8eg=
X-Google-Smtp-Source: AJdET5f0q/FvCNRsLJVkbKu56DBimF57dSwKkhkKEg/RakF7XAidzzBNGHaQw3+Jhp2IpW0CHSfcPA==
X-Received: by 2002:adf:cc8a:: with SMTP id p10-v6mr219709wrj.208.1540446239495;
        Wed, 24 Oct 2018 22:43:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c21-v6sm156230wmh.26.2018.10.24.22.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 22:43:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] howto/using-merge-subtree: mention --allow-unrelated-histories
References: <20181024080452.11876-1-uwe@kleine-koenig.org>
Date:   Thu, 25 Oct 2018 14:43:57 +0900
In-Reply-To: <20181024080452.11876-1-uwe@kleine-koenig.org> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Wed, 24 Oct 2018 10:04:52
 +0200")
Message-ID: <xmqqd0ryk2ci.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Uwe Kleine-König <uwe@kleine-koenig.org> writes:

> Without passing --allow-unrelated-histories the command sequence
> fails as intended since commit e379fdf34fee ("merge: refuse to create
> too cool a merge by default"). To setup a subtree merging unrelated
> histories is normal, so add the option to the howto document.
>

Thanks.  We should have been more careful when we tightened "git
merge".

Will apply.

> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> ---
>  Documentation/howto/using-merge-subtree.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/howto/using-merge-subtree.txt b/Documentation/howto/using-merge-subtree.txt
> index 1ae8d1214ec0..a499a94ac228 100644
> --- a/Documentation/howto/using-merge-subtree.txt
> +++ b/Documentation/howto/using-merge-subtree.txt
> @@ -33,7 +33,7 @@ Here is the command sequence you need:
>  
>  ----------------
>  $ git remote add -f Bproject /path/to/B <1>
> -$ git merge -s ours --no-commit Bproject/master <2>
> +$ git merge -s ours --no-commit --allow-unrelated-histories Bproject/master <2>
>  $ git read-tree --prefix=dir-B/ -u Bproject/master <3>
>  $ git commit -m "Merge B project as our subdirectory" <4>
