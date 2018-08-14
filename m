Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E54881F404
	for <e@80x24.org>; Tue, 14 Aug 2018 20:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbeHNXIP (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 19:08:15 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:47837 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeHNXIP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 19:08:15 -0400
Received: by mail-ua1-f74.google.com with SMTP id g19-v6so10899735uan.14
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 13:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1FcWBGDuqVH+9mdiLRBzJNtDEq5ttT0EdKj4LQhG2uw=;
        b=lqHeSa0rHGLVI2sj2pIa9sfpiXtAdq78bjmnJT+f5ytBkDxEt+eT/VGF5T+jjpSDTH
         ByKs5jYEJzr2RISAuvxKtYJSASvEH4ACDEtfFucAE93mM56mCBZuF8DFk6k6PjxvKdDi
         mtx+3IxgzuNjqurnftkiEIXRqIR5Dykde1chIAKFvAg2d58on5iFBZUOc3DStnNghI/e
         yDuMrhuBMPDxO59lZ/4RDaO8Gtbhit9XppR4+CgrfnKRUqY0cSdbFiBIc4aMBUNHc44l
         32+C0MSX7fdjSpuqlvWpQBefV78Q19/9r+EX/j4WSXekebwGur9KajOFZGuBTSDWMN4n
         lYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1FcWBGDuqVH+9mdiLRBzJNtDEq5ttT0EdKj4LQhG2uw=;
        b=RlNvs8MpjY3q8tXPJ0AVE3uwdSRFN733oDA71RLhHuA5poK44A+KUm9V1xJVkh409J
         5F5ZpQ0IEFggR7hXmBzOD8xtBSKyf93CsTH9zOrI63H3bemSZJKyYi2lcZOSYkLtvDsL
         05N9PkzthH2AHU9DrZkKbytHpMq0b3TXKCcCE7tmV2Xk0p44RSw0AdQB11hvIzbFF+qj
         AwqKSTduoO4ieWdTtHyQt1AvvoUyZuK1uBr5rhWwSx6L62BVeoHF4eFpXdH6xSkPGxhl
         Y37U4dyrTBUYjsUEjxBhUnAA/BGQoeoyuZ/PnvT7RhST7m0N1nXBIwyqkIxZOeSJvO0O
         oDAA==
X-Gm-Message-State: AOUpUlEyYxpEwB6h4sOsigYF0YTgvbLsDYZn0TJmw7yj6HSyH8cHHaSs
        2JH1jkfIdA1I2MTGHjxefLMSeCX8WmQJDe4vZPOQ
X-Google-Smtp-Source: AA+uWPzkhYkaj3eRxCzQUnjIstBoojpOyHBmvesKnOKSLOkIH4FgEkJuQ23vm+hVw7xC38jEWjw7Fq5sZHR3vENTWyyA
X-Received: by 2002:a1f:990a:: with SMTP id b10-v6mr13307352vke.92.1534277964296;
 Tue, 14 Aug 2018 13:19:24 -0700 (PDT)
Date:   Tue, 14 Aug 2018 13:19:20 -0700
In-Reply-To: <CAMfpvhKr4jmjZ3NUmxMyTM7KJxQX30UYXKf_rJ30A4C=P3tB=g@mail.gmail.com>
Message-Id: <20180814201920.56534-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAMfpvhKr4jmjZ3NUmxMyTM7KJxQX30UYXKf_rJ30A4C=P3tB=g@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6-goog
Subject: Re: [PATCH v4 6/6] list-objects-filter: implement filter tree:0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> - grep -E "tree|blob" objs >trees_and_blobs &&
> - test_line_count = 1 trees_and_blobs
> + grep -E "tree|blob" objs \
> + | awk -f print_1.awk >trees_and_blobs &&
> + git -C r1 rev-parse HEAD: >expected &&
> + test_cmp trees_and_blobs expected

Indent "| awk" (and similar lines in this patch) - although I guess it
is likely that you actually have it indented, and your e-mail client
modified the whitespace so that it looks like there is no indent.

Other than that, this interdiff looks good to me. Thanks.
