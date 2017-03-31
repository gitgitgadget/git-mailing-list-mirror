Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44FC11FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 23:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933321AbdCaX43 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 19:56:29 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34428 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932756AbdCaX42 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 19:56:28 -0400
Received: by mail-pg0-f47.google.com with SMTP id 21so84406827pgg.1
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 16:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yutFJ5rnzY+2SsWtinGzGI+e8T2SoUZk1x/jjxxGtVQ=;
        b=mqqTBa4G9SxFAVuMZs7JSJuPvZybTFhS+0LQU3V11i2UgW2I0jCshnBmwvR2F40sn9
         E+dYVnDuSFJPvC/TqhvqoY5IGX+RZYfxFveemwBqEFWJzxaBAqSGresAOot75wcmpQPv
         u67qoR8uj1MjlkoZz3Ek/wKBct2oVDqkTKFc7PRjId7vJO8angtITF6a6CGCJW6aKbV6
         NMNlQVY+DvWNVQRIeFm4kTIQGdgvvdiY5Uyx9XBNkE9TPlIP6HkN0pBHgpWJn4I11e4c
         9jBRtihdfRSQ1NymZCNOQCFEmNRIXprZbMZZco13xF5yPPRgCwK6kPW2oL8rhIC4WbRD
         notA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yutFJ5rnzY+2SsWtinGzGI+e8T2SoUZk1x/jjxxGtVQ=;
        b=tfUpG6GdgaBbHe7X/mGXXxvxstcwpfyFHeSg5vAFClmi+Uvu+dpPTrMyar4CcsT30n
         feda5fpKYXlieKo2EyipjobtSWabnfZGWgQDqlAfygsKN5O6a0auobKigQN8WvXER7Ik
         G12/cmHz4z44S20fjjvaCtioHmGWTipY2w6G8jyVNVz5jPcHoMEanUNi3r3UFt1RYKme
         dFRBxM9pDTEo2dQ7edPUqXCwTUkZTNc+1hyo8r3M4MgBQTvTJVgshWoPq3xp8WyAHJYq
         ZeW3GZXpez5x+DV6USsqPdvEoK/bXJ5B5zrpDRV3T7u/uWJ7uo2vPiDY6u43dQ8HfNlo
         gNMw==
X-Gm-Message-State: AFeK/H1Xoty5rb50N7d895QRxinFaZ/bBSHe2BgEMWW3kARDCJDX8ORKaLz4P/MtdoSH3aKi
X-Received: by 10.98.214.156 with SMTP id a28mr4826704pfl.40.1491004587821;
        Fri, 31 Mar 2017 16:56:27 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id x22sm12504643pfi.35.2017.03.31.16.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Mar 2017 16:56:26 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, jrnieder@gmail.com
Subject: [PATCH v2 0/2] propagate push-options
Date:   Fri, 31 Mar 2017 16:56:21 -0700
Message-Id: <20170331235623.166408-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.564.g063fe858b8-goog
In-Reply-To: <20170331231135.195195-1-bmwill@google.com>
References: <20170331231135.195195-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 addresses Jonathan's comments as well as adds an additional patch to unmark
a local variable as static.

Brandon Williams (2):
  push: unmark a local variable as static
  push: propagate push-options with --recurse-submodules

 builtin/push.c          |  5 +++--
 submodule.c             | 13 +++++++++++--
 submodule.h             |  1 +
 t/t5545-push-options.sh | 39 +++++++++++++++++++++++++++++++++++++++
 transport.c             |  1 +
 5 files changed, 55 insertions(+), 4 deletions(-)

-- 
2.12.2.564.g063fe858b8-goog

