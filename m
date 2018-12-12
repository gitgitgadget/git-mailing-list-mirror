Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DCC320A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 19:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeLLTsz (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 14:48:55 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37784 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbeLLTsz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 14:48:55 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so55828edb.4
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 11:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X5l2f8KAx8sW8iNTvDyzA8UWHUbEbfYJPJUd+K1Pt3I=;
        b=Fdk9ifQE6EbR22TDQRHJvqeoeF45QpQOqjMNe7b9BtU3WDytUDVcFKra84RrCjdEeV
         ezfhxwmGtMiceLQ6iIZZBvEKz59pukMlh55p45Jq09caJwsMKQ5BKjrYKSVoXRV8e61U
         P9j1UCrXSmDIO3x+LpmceNVxfyd+Tn0Bs8Cec26v9HyPr16oXsvkF8QMbDwawmgKL59g
         iPt/S6C77YrTFhqJLG0L/qrL1lNnHD/GeXTGGPt9wV0P/7pSAeKOGrbnT2Jf+uclDiPV
         u/9CYlEc/0sQK1ULZafa8GAxDEUyjKHFErL4vcqvEaQ7HuhvftvLCmN4hGJ05UDs6TdA
         BTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5l2f8KAx8sW8iNTvDyzA8UWHUbEbfYJPJUd+K1Pt3I=;
        b=kChYbW+cb+GJ9IBm79mqK5ELKxm0RV6nWt2eARfUCpNmBdqTYXoiAb0wase5DGE4K8
         rk4ZmufRblu6I3l3RI0kDPJEaIJnzMtqKcnoJutD4znu+RPlH5VppgEKnTK4uxhW34Ya
         17pgBE38MX3k8VNgLVcgTe9NhLoCDYBh2/I6ya2GhPkx8alnBMEnEDvQrfnStHHjA+TP
         CKn4Aoa2zHuRrA0AaECi61kk434vJpZYp4Q872IyURaa09zEu4xcQHLrRPGaxg5nfuzN
         DN7bksSeYGBRF/dHed2UUIy4/iLgrJE4TNnn8BEnrlHJ/QSAAAWg4T7mct3NamSF1h8S
         A/VA==
X-Gm-Message-State: AA+aEWY4xqFv91oXKUHqwHFMXRH4VvQ7Ph+DRffnQZ7ak4TeoD10+rcX
        2U+pEKewYiXw7KWAwKTdmcb5ca2hqZ7l31gkyKiQfg==
X-Google-Smtp-Source: AFSGD/W9oM+JbP4xQ4ErheNDA20mqY6oUUPaKAbwNZPd4OkLWOYU/QNrZ3rYMDIf7KJH4dMnpSPp5UntCt6LkRI/TTs=
X-Received: by 2002:a17:906:f04:: with SMTP id z4-v6mr16369663eji.106.1544644132993;
 Wed, 12 Dec 2018 11:48:52 -0800 (PST)
MIME-Version: 1.0
References: <CAGZ79kYDa27EFk4A9uEzCnoW7scjb1U8fKwCo0P7rUZESto+Qg@mail.gmail.com>
 <20181211040839.17472-1-debian@onerussian.com> <20181211040839.17472-2-debian@onerussian.com>
In-Reply-To: <20181211040839.17472-2-debian@onerussian.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Dec 2018 11:48:41 -0800
Message-ID: <CAGZ79kY17gmEh5Sawa+1fG5cXjOReOgCjDyEmGbbpJ5EE1APdw@mail.gmail.com>
Subject: Re: [PATCH 2/2] RF+ENH(TST): compare the entire list of submodule
 status --recursive to stay intact
To:     debian@onerussian.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 8:09 PM Yaroslav Halchenko
<debian@onerussian.com> wrote:

Thanks for the patches. The first patch looks good to me!

> [PATCH 2/2] RF+ENH(TST): compare the entire list of submodule status --recursive to stay intact

The subject is a bit cryptic (specifically the first part before the
colon), maybe

  t7406: compare entire submodule status for --reset-hard mode

?


> For submodule update --reset-hard the best test is comparison of the
> entire status as shown by submodule status --recursive.  Upon update
> --reset-hard we should get back to the original state, with all the
> branches being the same (no detached HEAD) and commits identical to
> original  (so no merges, new commits, etc).

"original state" can mean different things to different people. I'd think
we could be more precise:

   ... we should get to the state that the submodule is reset to the
    object id as the superprojects gitlink points at, irrespective of the
    submodule branch.


>  test_expect_success 'submodule update --merge staying on master' '
>         (cd super/submodule &&
> -         git reset --hard HEAD~1
> +        git reset --hard HEAD~1

unrelated white space change?

>         ) &&
>         (cd super &&
>          (cd submodule &&
> @@ -307,16 +318,28 @@ test_expect_success 'submodule update --merge staying on master' '
>  '
>
>  test_expect_success 'submodule update --reset-hard staying on master' '
> [..]
> +'
> +

The tests look good to me, though I wonder if we'd rather want to inline
{record/compare}_submodule_status as then you'd not need to look it up
and the functions are rather short?
