Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76ED01F404
	for <e@80x24.org>; Wed, 29 Aug 2018 20:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeH3AVe (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 20:21:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:54253 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbeH3AVe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 20:21:34 -0400
Received: from bedhanger.strangled.net ([188.194.175.24]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LvzF3-1froNh0yrt-017i8p; Wed, 29 Aug 2018 22:10:24 +0200
From:   Ann T Ropea <bedhanger@gmx.de>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH 1/2] tests: fix non-portable "${var:-"str"}" construct
Date:   Wed, 29 Aug 2018 22:09:08 +0200
Message-Id: <20180829200908.13461-1-bedhanger@gmx.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
References: <20180828193827.8648-1-avarab@gmail.com> <20180828193827.8648-2-avarab@gmail.com>
In-Reply-To: <20180828193827.8648-2-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sdGbx3/wgcPHpMq67Wwafbdel//bvrBZLH01PvSJKNOrfhdTBUG
 DTeJpquFfIBJUr7tKbMamh7quB1cB9Akda0Sdj+gqKkvzWA9H9jdD1jX18BT5+nwH4DBHlV
 k9uRU5xit4t/vUPwsZtqQlZnrVVgf6Y0/jSIbOQ1nAdMvlbMh6VnrQjpMkIYiYbEQRyzyVm
 iyxxxHT4vejdSwm7zBEPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MqNDYzp/RSo=:tnv8DrkX4kWY5Cr3gkW8DY
 j4os23OnFxSrQUqskZT8vp43ELgGa7fPBHnDigrApn/5D8+AC6ARCu4rEuXBj+hICbrS/PPe3
 67p6DTe5LXcC5aa+qUveeMZMbc1sLuewa4GQgqCCl30bp/GJSCFAMr+kG0wRHDK5279HWUxFj
 0Y5WdZ59vNgBGjT1QBmVvpRHaQaWwbxw8OrhaXFs1uSN6MQ7ir4yXqzciKm2LiAWZtOiT5jLM
 ykYnRBXNGWhUfiOq5wTc5J3n/1v4pgyNxS6kXj3GmLwcxxbBONEN1E7m1Ver2ktkAOmZP/CSV
 LI5V5VIfYqX3coDeAV5Eo3wp6/0ZLq21QxHaHR+Bav/H2Pck6ewtNcryhCE9dQTHmJRrwvajC
 V7dBauDTAYCZbkIw2s0PBwfCgP1kU4FFk5fMbRN5sfUYZ2u+0o3Mv/1Jl+F1K/DS+ZgML/XNb
 Z6+9NxFZ90sUKXwjTt+zxj9UPWfgs2vkDZq4pW8507RasJ9WpvAstTp8B/dWnxGIxuWZe0v5u
 RfIJYW6yZJ+mh1vOsIz2WBgiWOOt/s/H2iLWTnGTx73CRIIv/4xwo1gmzCdHUziglWztyZFh0
 9bu6qloP5PukInDLckciUIMg0mCwsq2AO8912e129VvzqwCfua/mVzvNgvJgOEN4fYc1GmYIS
 azN9RFkNh6royJyNq+lyqGIKF4rC3wC0GKujF3qs24aMkLBMcdMioVwpPNzDlgMVGEPnwosDH
 WQiT/mbx4ZFTdG/rCIaxiHCYapdRU/fqUwABzzVzU/9gehqOTZUpkGfUYTVsDz2wDx2/p73Vt
 i70mnSY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Fix this by removing the redundant quotes. There's no need for them,
> and the resulting code works under all the aforementioned shells. This
> fixes a regression in c2f1d3989 ("t4013: test new output from diff
> --abbrev --raw", 2017-12-03) first released with Git v2.16.0.

Acked-by: Ann T Ropea <bedhanger@gmx.de>

Thanks.
