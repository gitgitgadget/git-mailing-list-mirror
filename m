Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D1301F89D
	for <e@80x24.org>; Sun, 23 Jul 2017 06:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750964AbdGWGCj (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 02:02:39 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35657 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdGWGCi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 02:02:38 -0400
Received: by mail-wm0-f48.google.com with SMTP id c184so1398025wmd.0
        for <git@vger.kernel.org>; Sat, 22 Jul 2017 23:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Z/KCO6F83oeGP170O8MQJUi6/7EvOZd2bYqsyhfkCZg=;
        b=Z47EBrLxktzDU1Rzwf0hIDmr0TU3CeEfZrO3xGZ9hGMPnt4KUUtaGGygM1/vjbXfj2
         PkXzRxsULB+RFvHmGxW7EFMx/iZl6PF2koUBGlPvFHRr2W+jXmOTdT3EjEBA2NEvKgLu
         /s64ktxf7/4MjrExXqwJ3sLQipapcx6GZBCAI+xquzWzARPwc7ZHu8QJ9HmSLIzHIJFo
         9RPSSrxHuOENOnPYA2xPystbPnh5VVZJpiJHVIuNbE1kRMs7D5XpAPKDf3NuK9nru4oG
         tiCD+B5u/8NrS5qn96zRG6Cv+Wsl6um6NccHZk1pIRXiaIKgZbPFVK6RbdbtSNrwngAZ
         wb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Z/KCO6F83oeGP170O8MQJUi6/7EvOZd2bYqsyhfkCZg=;
        b=HWp0gF5ykgOOWdffzkeWNJv8iXaAzEMIjZc88NhncN9crIUNOnMJiXhfUWze7dWIIZ
         BDGv9MqtCXd85CM+QwHZsCZwrLwjJnyDKPsRLJiOEKr6H0LA6A+FadMt3nahj2fDrjW+
         4KmsjDgrFm9OkVotek+dS1gv3lL2v/jPqGNjpko+YdOhF0Slb4P+lEBbHRXhWtinNkNd
         ghcVWssx32Qo/DE6guCvew+PH7aCTFIyMEfkwC+UlHmO/Dou4FJgY2edMRHYUgwtPdGJ
         Gm+AsBpIlcW2XUb0FMC0kRm8gUYwIhjpEoaRR7GxoSFEl5PATk3e4Rw78Xhety9t56Il
         9nPQ==
X-Gm-Message-State: AIVw1104coUww7e9hTae/YWQlfOyNASX1cqr0yslA/Vxo8v3Xm4mCDhT
        KjlOJJ/RK22EItyMO7H9RLQ1HpsOew==
X-Received: by 10.80.166.133 with SMTP id e5mr10287118edc.71.1500789757326;
 Sat, 22 Jul 2017 23:02:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.134.76 with HTTP; Sat, 22 Jul 2017 23:02:36 -0700 (PDT)
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Sun, 23 Jul 2017 09:02:36 +0300
Message-ID: <CAGHpTB+dSGza5Lwg76WXg+pPZ=dz3QdCTnDozWG_y+5_bPor6A@mail.gmail.com>
Subject: recursive grep doesn't respect --color=always inside submodules
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When git grep --color=always is used, and the output is redirected to
a file or a pipe, results inside submodules are not colored. Results
in the supermodule are colored correctly.

- Orgad
