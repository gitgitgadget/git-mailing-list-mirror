Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 021401F406
	for <e@80x24.org>; Thu, 10 May 2018 21:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeEJVTX (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 17:19:23 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42482 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbeEJVTW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 17:19:22 -0400
Received: by mail-pl0-f67.google.com with SMTP id u6-v6so2002524pls.9
        for <git@vger.kernel.org>; Thu, 10 May 2018 14:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E/6lQRSYRZ5DV66d2BeLa70v/WRbNKOOqQT58Q5/HoQ=;
        b=PTsWQyKGTd9MI8hFBJi0E2srxM3NwA1eVjeUJyGVjIbpRj5nniz6RPVEdzXhShSDrJ
         32AnTOZN5yF/zF9jThezK289gFzut6eEo8n6jSbZfSxPgUOR4a4ubOQE95xaZJSY1eVy
         LaMXmioySZy2MTXjD8wPJv3f4RIzI0tYkzXDFm/u+3IyeooWeSCGk26BdhpuxWmJZdYC
         yAeswd0a/QvSAgbar1PNsSHmRwPlG30Q6rugmn3Is2VxheFSUv99LYsFL7duw/Q1cO/E
         aEr1WziKMTe2KKoDRhLek517h6XN58jCSP7SCf1DxhA1klnCQAwA+XTVI3H0lB83N+VG
         2utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E/6lQRSYRZ5DV66d2BeLa70v/WRbNKOOqQT58Q5/HoQ=;
        b=V52Zj5OpOuFlA6GjHaKtqhQtpWRWXLPzT3E9hl269OMwKUY0aLq1EqkJSSnzhqB5ab
         nZOsqCcQCfgeXbQ+pIKLDczcQmIx/94s25skcM6WKckUyjAvvX/hfi91p9rY4Ypt174g
         iOFEgZcOqqL5bdABe91EZYGXr3MD/PXx1u1/3Sc/5iWzCE5J2jcFEOOh69GsoRUTSxCI
         1bdo14Dyh/3QfSyxPwhb+CnNddDczIuxaaWJVn/+RHGJPvI8feiI28Jy/oayfp9ptsLw
         mhRYUg+ZpIkn/fA4BuhzNhrRtzCYVhZCc4e0Sb+0znHp3FnEBrJRMsGB/9mM9ux/Aao8
         HsQg==
X-Gm-Message-State: ALKqPwcZzPZwsXUIPK+n09axlm+VQkPTUJphQk0//Ou73B5ows7HSAoo
        qbWvWBE9t7kGqTbF34advSB9Q5DSLCM=
X-Google-Smtp-Source: AB8JxZp6mTEni8ZtecAGQT9+BSOOihs/A4rQKeEvmMzuu8QXLXNCM1KmzqSQYxdr9KpUeIGuH/5DBw==
X-Received: by 2002:a17:902:7487:: with SMTP id h7-v6mr2768234pll.154.1525987161216;
        Thu, 10 May 2018 14:19:21 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id d19-v6sm5510544pfk.59.2018.05.10.14.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 14:19:20 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     leif.middelschulte@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.ath.cx, sbeller@google.com
Subject: [PATCH 0/2] Submodule merging: i18n, verbosity
Date:   Thu, 10 May 2018 14:19:15 -0700
Message-Id: <20180510211917.138518-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.255.g8bfb7c0704
In-Reply-To: <CANw0+A_T5zDUUWznYBe0m9fkSODPnfQaK1yJKPPawHTxi9+9BQ@mail.gmail.com>
References: <CANw0+A_T5zDUUWznYBe0m9fkSODPnfQaK1yJKPPawHTxi9+9BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Leif wrote:
> Sure, let me know what to use instead and I’ll update and resubmit the patch.
> Sure, but `MERGE_WARNING` prefixes all the messages with "Failed to
> merge submodule“.

I thought about replying and coming up with good reasons, but I wrote some
patches instead.

They can also be found at https://github.com/stefanbeller/git/tree/submodule_i18n_verbose

I think these would be a good foundation for your patch as well, as you can use the
output() function for the desired cases.

Feel free to take these patches as part of your series or adapt
(or be inspired by) as needed.

Thanks,
Stefan


Stefan Beller (2):
  submodule.c: move submodule merging to merge-recursive.c
  merge-recursive: i18n submodule merge output and respect verbosity

 merge-recursive.c | 169 +++++++++++++++++++++++++++++++++++++++++++++-
 submodule.c       | 168 +--------------------------------------------
 submodule.h       |   6 +-
 3 files changed, 170 insertions(+), 173 deletions(-)

-- 
2.17.0.255.g8bfb7c0704

