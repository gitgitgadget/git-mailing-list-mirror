Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EEEF1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 14:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbeHWSLZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 14:11:25 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:46132 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730300AbeHWSLY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 14:11:24 -0400
Received: by mail-pf1-f178.google.com with SMTP id u24-v6so2803904pfn.13
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 07:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NYs8gFvT0u5W3JAhy4soJLsmOsNaAFi/+LiW9O79v0o=;
        b=dRqxYfE4xj2O2lJUvqkr0cqxGcYBXD9k5aaMuLYklTuLNS7ILUsHhaE9knTLEuY9jF
         eXsMfhJci5WSqIzlvVeLvsGhRXkbd7Va6tITrKhbnYsw4+HzluKKC6LvKnZL9MckVIUs
         FhZMcx7krcHrmVO6ltOk3K8kg74KPmxkhZGKkzqUNNGSmDRQ8EW/J4riv2WJgo+rAGMq
         epEWsg1qvDA2+8zI9PDm+GwU8nQ1ljQ6MaAUA+g5uttguoODby/hOOMZi1w0ANxtzExg
         MHx/NZJnhofupHrMvMBilIxjBNBdDMVv33dhwWMG+kbu0V0bLsNb/aKvJLObPxpIYDAD
         6WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NYs8gFvT0u5W3JAhy4soJLsmOsNaAFi/+LiW9O79v0o=;
        b=DWRBULZl922mruCzzaaR4q64zf42FfedR9jp95ndrmBiuVfZ8/6LsQTYZbBK6JleXc
         ds6qVQPm3K529fjNgblU4pTCbroC+ie0YsDGRObOHb5kQr5gAs+Uh/9bVF/ijka2DBua
         LJ+ZAhhJJnUeuxgzeiBgW+F5T/zIsllwzwWH8+7NNQ4q6W7cCsD0oyOVB/2V2s0pMfkv
         DmX+65auAOMbbam+ELksdeOxjibWGLq7rwuns77VAxVTRizjmcB8ffMi/8isJcF3VvIk
         STYS0nB7hvk3gDGyI95hkPmonIjefu+C7KuTT2SJ8ULwshdzmItEubgMXrpeQrzed2kM
         ndqg==
X-Gm-Message-State: AOUpUlEovFAwDm1sUvTPBuZKsZv3OnwiwMT7PlipjkjpWCHArE5nptLE
        Vv1kYJorg2iNyOjhzr5W7HgblmAq
X-Google-Smtp-Source: AA+uWPxn7KuH/cBjEFEIDi69/E4O+7c4M8JBYjseA5RRhpVCM46BHAjW6CecJYs2+6JyKvgPA6CAwg==
X-Received: by 2002:a17:902:5a0a:: with SMTP id q10-v6mr14746603pli.300.1535035284971;
        Thu, 23 Aug 2018 07:41:24 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id m26-v6sm8780846pfi.102.2018.08.23.07.41.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 07:41:23 -0700 (PDT)
Date:   Thu, 23 Aug 2018 07:41:23 -0700 (PDT)
X-Google-Original-Date: Thu, 23 Aug 2018 14:41:20 GMT
Message-Id: <pull.20.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.20.git.gitgitgadget@gmail.com>
References: <pull.20.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Make t2024 NO_PERL-safe
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     AEvar Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While trying to run the build & test with NO_PERL, I noticed that t2024 had
a failing test case. This patch works around that failing test case by
skipping it when we know that the error message looks different than that
test case would expect.

Changes since v1 (which did not make it to the list due to 
https://github.com/gitgitgadget/gitgitgadget/issues/29):

 * reworded the commit message slightly.

Johannes Schindelin (1):
  t2024: mark a `checkout -p` test as requiring Perl

 t/t2024-checkout-dwim.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: 8d7b558baebe3abbbad4973ce1e1f87a7da17f47
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-20%2Fdscho%2Fcheckout-default-remote-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-20/dscho/checkout-default-remote-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/20

Range-diff vs v1:

 1:  619d7bcc31 ! 1:  8d46b31f5a t2024: mark a `checkout -p` test as requiring Perl
     @@ -3,9 +3,11 @@
          t2024: mark a `checkout -p` test as requiring Perl
      
          A recently-added test case tries to verify that the output of `checkout
     -    -p` contains a certain piece of advice. But if Git was built without
     -    Perl and therefore lacks support for `git add -i`, the error output
     -    contains the hint that `-p` is not even available instead.
     +    -p` contains a certain piece of advice.
     +
     +    But if Git was built without Perl and therefore lacks support for `git
     +    add -i`, the error output contains the hint that `-p` is not even
     +    available instead.
      
          Let's just skip that test case altogether if Git was built with NO_PERL.
      

-- 
gitgitgadget
