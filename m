Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E74C1F404
	for <e@80x24.org>; Sun, 12 Aug 2018 04:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbeHLGno (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 02:43:44 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39555 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeHLGno (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 02:43:44 -0400
Received: by mail-oi0-f67.google.com with SMTP id d189-v6so22122554oib.6
        for <git@vger.kernel.org>; Sat, 11 Aug 2018 21:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WYA+fvynz6Tdlz+VO7QtsCXXp3x1gpVQMKtZTIxJfMQ=;
        b=T4ucut/leKxhmqEI82VabEUGj1nu4amI35vlNnLgyGtdSt6ifdaCJDBljeS1jAL13v
         9gnAgOk7q2mLomq/T14ADcOG8TQLD/nZGhsBLy7hwbiVpjCkdd36T7/c7anpTJXzAR7R
         vyJ7SHHLtqtfgh8qn9FSzv1zRdg2Qt9VAU8e8ulUNdkr2a+M5BoWWwrNa2qxRdPd452A
         aWcLRQKX8SfewEvcIOY7feEZGdfcnViGI8x5Nvd/JWG8HUf6bTIoCn++L7sczSWLY322
         gDxjomAXzN9Jl1rJiLVsivkNcjaBefw1oJlHQGzx8A54nRujrywjsIFvSlxU1xGf+Yp3
         EViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WYA+fvynz6Tdlz+VO7QtsCXXp3x1gpVQMKtZTIxJfMQ=;
        b=r4sMLWe6/Qw9ulX+UuttYNr4EaC7S5QyVkuY93pDyFuphvYqr1I5I5nG01lN2EC7Nz
         k4BFFdZlXcGMhaxNwruZg5c6Jk0i5f2CwLUm4BCiONIEo6rynHhCnsbCxc9Rs6OGVq8H
         fSNu+j1qAEsRdB3Vxsitp6zcpz4JqpzBN07EoFlLMwQ4JgBvEwrdpvXK/H3r7ZryPFW4
         2IcSwR0jYStp+83HgFDK94KHxJ112MyrgMnpTOwR6+O304bjp9G6Sg1cexP+v0mZUz2/
         GPQ579BzzUgHQT/Tnq70jz60zIlkmyIlFGdzI8Xk7+FWtPjM8uQV7XRErLTDgrhoj90k
         ITvw==
X-Gm-Message-State: AOUpUlGdkZ0/QxkQHS0faFhU5/VbpNAxtOlBawfM+mAIMcLtgHDNWBfX
        hwdM2cbO+Tv3aGDjln3bCFgnnkChLhCqwqVC2f0=
X-Google-Smtp-Source: AA+uWPzmYEcOPXK+0YMEya4obJD02s6x1xLf61neYd17dzuyjjtpjOuLYsUjz4Fpfp544v/FsBGX9DyUeqrG4E1mtGI=
X-Received: by 2002:aca:bf07:: with SMTP id p7-v6mr13811128oif.285.1534046833628;
 Sat, 11 Aug 2018 21:07:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:70d9:0:0:0:0:0 with HTTP; Sat, 11 Aug 2018 21:06:53
 -0700 (PDT)
In-Reply-To: <CAPig+cQK7JSosa0hNhgw7xoSui2f0m6yfRLWytsg_Zow3bN5bg@mail.gmail.com>
References: <20180805022002.28907-1-wchargin@gmail.com> <20180805022002.28907-2-wchargin@gmail.com>
 <20180805041956.GI258270@aiede.svl.corp.google.com> <CAPig+cQSryjWrFZML_g0fR5oq6dzVaWPXm_4R-Jg_ay1R2DzbQ@mail.gmail.com>
 <20180805205231.GA14688@sigill.intra.peff.net> <20180806130216.GA29966@sigill.intra.peff.net>
 <CAPig+cQK7JSosa0hNhgw7xoSui2f0m6yfRLWytsg_Zow3bN5bg@mail.gmail.com>
From:   William Chargin <wchargin@gmail.com>
Date:   Sat, 11 Aug 2018 21:06:53 -0700
Message-ID: <CAFW+GMCfMVLPH4909W-x8HHVn8-8oX=Dk=0D7sz=cWdh0xKOPw@mail.gmail.com>
Subject: Re: [PATCH 1/1] t/test-lib: make `test_dir_is_empty` more robust
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> That will recurse any subdirectories, possibly wasting time, but since
> the point is that we expect it to be empty, that's probably OK.

One caveat involves invocations of `test_must_fail test_dir_is_empty`,
wherein we _don't_ actually expect the directory to be empty. It looks
like there might not be any such invocations in Git, though, for what
it's worth.

The solution that counts the lines of `ls -a` seems like it should be
universally portable, both in POSIX and in practice, and it doesn't
complicate the code at all. (I'd say that it's slightly simpler than the
`egrep` approach in the status quo.) I've adjusted the patch to use
Eric's version, which I like a bit more than mine; I'll send out the
revised commit presently.

It's true that within Git we can simply try to avoid creating
pathological file names. But Sharness is also exposed as a standalone
library, and it seems clear that the public function therein should be
correct in all cases. Assuming that the new implementation is
sufficiently inoffensive, is there any harm in being perhaps a bit more
robust than is practically needed, and also maintaining consistency with
Sharness?

Thanks for all the suggestions and feedback so far!

Best,
WC
