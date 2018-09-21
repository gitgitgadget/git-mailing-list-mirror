Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62CC41F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390204AbeIUUyn (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 16:54:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42882 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbeIUUyn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 16:54:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so6102736pff.9
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XgCTm9Sbu7UweOwHoihMf6Tu0k5lMLFAezU32w8e3J0=;
        b=GAd42gg3qPCoAsjRZX2oiClLU/2/zeX4LN6dCFbMLeCUdYrsf0EXgBzn1e4hKYhwDW
         lxZBCVPpHriTJ0iRvCPI8Bu2ldaJo/nJJ/jW7Rx712LJrujnC1PsieYzzZCMCTUMQxTG
         uprLYOTLfut3DJ+lHbzDqbfuMHpMeMxdZ4Hbdk5bFADlWpgLFhXR9fURmyhS+SAn2EMu
         MUX6KnAW+KoqCjQdU6G9ki1fNPztUx76/3+T/9s5qXA5DC0QRTg2b2bIxsEqwmSdzE+g
         WPm+2jgltzj3JPRU9V6KuEzTXMA5Dh5bOtciScgrMtqkF8CXGzDx6KTTFxeqq3ECRkuH
         EIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XgCTm9Sbu7UweOwHoihMf6Tu0k5lMLFAezU32w8e3J0=;
        b=TEFyDIsM1tiKiTEutY1nIcJIz5sErtnKZnQ9UtPaBdJkaI8DmIYvwL98STZSkxSKfH
         tLbRo//vgmsBjr/FkQ8BAwMdTbHvCVJw/p9xOk/jzQ/lZORxVolh6RIL8Y1lZhJ9SSYH
         RTrfjgZvvmkvjJQnJeae3dVCYtkTM5/58Tr1HlSCXFo2GK4EVMhuQmPrrLSWLOgvVBq4
         SGCVFA3S2+W+dgkPfX1Ssd6H89x5TIq2VPEohXXVZfIX2CiN3ZLPrtzxeFCLZKexs1ND
         AXw8Z1GkTFplHpuCcAnbgSDMev4zjBICr6jZKxlwiUjuEPEUZc3KffC39PIEmyaxED3B
         Ld8A==
X-Gm-Message-State: APzg51CPLwY/AJcFMn968kotR/DrNDy+9sjP9QmXlsWGbDRYZBO/wnAC
        BtOstaxu31/tRcL/r/syX1W9NhLd
X-Google-Smtp-Source: ANB0VdaREGwa6lBNsGY8oqE+I+d41tsEvO3ykt3JTdgDUu5TYcKi1d+1hmKtZY1A/IfftLnCLcdyZA==
X-Received: by 2002:a62:ea05:: with SMTP id t5-v6mr47340817pfh.228.1537542325705;
        Fri, 21 Sep 2018 08:05:25 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id z11-v6sm46954528pfi.4.2018.09.21.08.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:05:24 -0700 (PDT)
Date:   Fri, 21 Sep 2018 08:05:24 -0700 (PDT)
X-Google-Original-Date: Fri, 21 Sep 2018 15:05:20 GMT
Message-Id: <pull.39.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.39.v2.git.gitgitgadget@gmail.com>
References: <pull.39.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/2] Properly peel tags in can_all_from_reach_with_flags()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Peff reported [1], the refactored can_all_from_reach_with_flags() method
does not properly peel tags. Since the helper method can_all_from_reach()
and code in t/helper/test-reach.c all peel tags before getting to this
method, it is not super-simple to create a test that demonstrates this.

I modified t/helper/test-reach.c to allow calling
can_all_from_reach_with_flags() directly, and added a test in
t6600-test-reach.sh that demonstrates the segfault without the fix.

For V2, I compared the loop that inspects the 'from' commits in commit
ba3ca1edce "commit-reach: move can_all_from_reach_with_flags" to the version
here and got the following diff:

3c3
<                 if (from_one->flags & assign_flag)
---
>                 if (!from_one || from_one->flags & assign_flag)
5c5,7
<                 from_one = deref_tag(the_repository, from_one, "a from object", 0);
---
>
>                 from_one = deref_tag(the_repository, from_one,
>                                      "a from object", 0);
14a17,22
>
>                 list[nr_commits] = (struct commit *)from_one;
>                 if (parse_commit(list[nr_commits]) ||
>                     list[nr_commits]->generation < min_generation)
>                         return 0; /* is this a leak? */
>                 nr_commits++;

This diff includes the early termination we had before 'deref_tag' and the
comment for why we can ignore non-commit objects.

[1] 
https://public-inbox.org/git/0bf9103c-9377-506b-7ad7-e5273d8e94fc@gmail.com/T/#u

Derrick Stolee (2):
  commit-reach: properly peel tags
  commit-reach: fix memory and flag leaks

 commit-reach.c        | 41 ++++++++++++++++++++++++++++++++++-------
 t/helper/test-reach.c | 22 +++++++++++++++++-----
 t/t6600-test-reach.sh | 30 ++++++++++++++++++++++++++++--
 3 files changed, 79 insertions(+), 14 deletions(-)


base-commit: 6621c838743812aaba96e55cfec8524ea1144c2d
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-39%2Fderrickstolee%2Ftag-fix-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-39/derrickstolee/tag-fix-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/39

Range-diff vs v2:

 1:  4bf21204dd ! 1:  0a1e661271 commit-reach: properly peel tags
     @@ -53,8 +53,11 @@
      +
      +		list[nr_commits] = (struct commit *)from_one;
      +		if (parse_commit(list[nr_commits]) ||
     -+		    list[nr_commits]->generation < min_generation)
     -+			return 0; /* is this a leak? */
     ++		    list[nr_commits]->generation < min_generation) {
     ++			result = 0;
     ++			goto cleanup;
     ++		}
     ++
      +		nr_commits++;
       	}
       
 -:  ---------- > 2:  b2e0ee4978 commit-reach: fix memory and flag leaks

-- 
gitgitgadget
