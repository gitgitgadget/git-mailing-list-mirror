Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48C071FF34
	for <e@80x24.org>; Fri, 12 May 2017 16:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933124AbdELQVa (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 12:21:30 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36990 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932920AbdELQV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 12:21:27 -0400
Received: by mail-wm0-f52.google.com with SMTP id d127so19892429wmf.0
        for <git@vger.kernel.org>; Fri, 12 May 2017 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K6lbtYO8tjBhpk3nQDDnCrN+YqaGJoHnidNEi6UVbkQ=;
        b=ltMD7MclzL+4k5BfnY827K7SLGo0zE/gxaNKj2WRIe0XEDuxs0Dkwm+9ua1OAg8faq
         oWp+M+lS9+YxWt0cjBk11rkyymJPuZSFL1PhCU1um2PH9UX3YX0PxPmjRQ6cLNEhw+FG
         BNi9kTC2M4yByPT44qisUFa8dXw5u9IEkxipPCMjcBAr3HwIMg7MfP0t2Rj7gId5k6St
         bOr8j5zjJhYqrlz/IB4vCXQWKm9oSArQzdhwsxp2JKFrP5HgVfiT49Bor7y58uCfMoeo
         Q3bG4nxCwCDdF7gj7bY0nhBolbAsmo4KHtcdxpCiEGW+MTlmNG3h/Ual+feoNkJOrT5x
         GBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K6lbtYO8tjBhpk3nQDDnCrN+YqaGJoHnidNEi6UVbkQ=;
        b=knuK5KQWdySIucEGWKDgFUscDeRkaHBw/2PvPpwt3q/zrwvJZVNe6bf/hQ2zrCBTbE
         zIE4ut8ldHxZV7Cdmud5mON+CosSNFaK6Ng2IcEn9iIAuDW2rPzjzBwi7laWy+VqkRUy
         ivuXrH/hmukRWNYal5wCbI1ndaDXeLXHcLcD0srPjwALyJ9IK4zf+XhIasUy8jZ0r1yJ
         mdMekmciQk+TM+1nrOUspWhaZekxEiyuGAPQuHCQ7jLS6YO0DMRaxDuqkMSCVCUG/FY6
         RgJaGtW560rBTZXcgIDYM7ntEbOs2mIx/lKJo+RaT+BEd/BygqZu4UYYL/EcJduC0Krs
         59bg==
X-Gm-Message-State: AODbwcDAyzzR6mK3MM1HbvtNEGVkn5TdYm6qNR9S3JEUMPsYJtUo5FTr
        Sw5tl1LExtupZme/GFi8ww==
X-Received: by 10.28.91.3 with SMTP id p3mr3637061wmb.68.1494606081069;
        Fri, 12 May 2017 09:21:21 -0700 (PDT)
Received: from localhost.localdomain (cpc25-camd13-2-0-cust158.hari.cable.virginm.net. [77.99.142.159])
        by smtp.gmail.com with ESMTPSA id 4sm4563982wry.31.2017.05.12.09.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 May 2017 09:21:20 -0700 (PDT)
From:   paul@myitcv.io
To:     gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re: [PATCH 3/2] ls-files: only recurse on active submodules
Date:   Fri, 12 May 2017 17:21:09 +0100
Message-Id: <20170512162109.49752-1-paul@myitcv.io>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <xmqqefwpdx9x.fsf@gitster.mtv.corp.google.com>
References: <xmqqefwpdx9x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> ...

I'm nowhere near up to speed with the entire history of this chain so
please excuse me if I've missed some detail somewhere.

As of b06d3643105c8758ed019125a4399cb7efdcce2c, the following command
"hangs" at near 100% CPU in a repo of mine:

git ls-files --recurse-submodules

The "hang" appears to be an explosion of subprocesses (snipped the
COMMAND detail from ps):

git ls-files --recurse-submodules
git --super-prefix=g/_vendor/src/github.com/ramya-rao-a/go-outline/ ls-files --recurse-submodules --
git --super-prefix=g/_vendor/src/github.com/ramya-rao-a/go-outline/g/_vendor/src/github.com/ramya-rao-a/go-outline/ ls-files --recurse-submodules --
....

In v2.11.0 I simply get a fatal error (this repo doesn't actually
contain any submodules):

fatal: can't use --super-prefix from a subdirectory

I haven't yet been able to work out what's special about the
subdirectory g/_vendor/src/github.com/ramya-rao-a/go-outline/

Is this expected? (I'm guessing not)

How can I help diagnose what's going on here?

Thanks

