Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65DF1FF32
	for <e@80x24.org>; Fri, 20 Oct 2017 18:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752388AbdJTS6T (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 14:58:19 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:54339 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdJTS6S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 14:58:18 -0400
Received: by mail-qk0-f182.google.com with SMTP id n5so15476317qke.11
        for <git@vger.kernel.org>; Fri, 20 Oct 2017 11:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H4cbIihW06eazyb2iIA3RAR+2Eu7rptaVLSgYv7QOdE=;
        b=wQePOHs8rMuBnmF7VrUTbsYnFJEQpe8QvCYreZEF/Z9DuzJr/hebGSJOuWRjndK9XW
         4fgmK0fnsr6fYKUkZMyp/6ocSVtIqzwA5eZqCojGReUjdrJ42yuAiYrkZu7Zf2Zn8k6q
         xw5KIvCMhx6wHPXXkREB3ThN+2iAn03ifc2MSUzWfiVHqch+54sMAYOgSMiCcsM+b3h8
         Gx+hKM7U4oDCo0bxDhZRRdt3VgAyZYF3m4POPL9fAc58ea8DT6zXwcVkhI+0Kah65LTh
         9E5vxYSi/o9sBrwP4RIRLMBES0nmZiE16TBfiKTT7GVqFA8sQUDIFX3rJnzwqQW68Hk0
         ExlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H4cbIihW06eazyb2iIA3RAR+2Eu7rptaVLSgYv7QOdE=;
        b=Q06oLr9k3s43iiKYoPjy2evsUpcaX+1S0e4SdQaAUjoxuE6za+1z1XI/XhJG4o7qZ8
         l0CpF4hKGhsI4kmos8pmvFeQlx8gR551IICqJ5B5+NoLJlxrJ+E684zD9bWTIe7H/+Aa
         JTQlfUDwhDsFkxsPXNVeMtp15qNAMcKt3MDZBteSSA5VCAc+1IZA++1G1adp/RsQAsuz
         M7NHLxJS4jwbKeEH4jKcmtbcbEzI3ySXYi36DitsZqpUuz+xlpVR2rBrv9x/OnnzMzNn
         7AgNOCxyiu/CHca5d3nHDcxzmTko4T5NbRsgnr29V7yQH8THzICko5RBvV0gLZ+WWbE3
         y3+g==
X-Gm-Message-State: AMCzsaX3Yaf0VBVMzhaVzVwHvs9WmVi2/ueH7cpMNgv3yyICIrnJS8xv
        mT84ZmC15516crEoruaZP4DJAaOTN0Xhs20kFm2txifN8wQ=
X-Google-Smtp-Source: ABhQp+RF2zJqSVr69RTBXQlxJM0DSQqnzxu1cfokfmxMMXFhEJSE+TtUapjLgZ7On8gCYliB8CX2qX85KEYbimLj7Zg=
X-Received: by 10.55.111.3 with SMTP id k3mr8176266qkc.332.1508525897728; Fri,
 20 Oct 2017 11:58:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Fri, 20 Oct 2017 11:58:17 -0700 (PDT)
In-Reply-To: <1508483371.2601.8.camel@gmail.com>
References: <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170925082024.2691-1-kaarticsivaraam91196@gmail.com> <1508483371.2601.8.camel@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Oct 2017 11:58:17 -0700
Message-ID: <CAGZ79kb9iSzYkmET8Xp=Hz-x+q_rdsaS1F7A3p1Q+URZ3uRCcw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] Give more useful error messages when renaming
 a branch
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 20, 2017 at 12:09 AM, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> What happened to the v2 of the patch? Has this not received attention
> or is there anything that's not done correctly?
>

I just checked origin/pu as well as the latest cooking email
https://public-inbox.org/git/xmqqr2tzith7.fsf@gitster.mtv.corp.google.com/
and could not find your series.

Sorry for dropping the ball as a reviewer, I'll take a look.

Thanks for pinging,
Stefan
