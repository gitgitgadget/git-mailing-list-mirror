Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19B791F454
	for <e@80x24.org>; Wed,  6 Nov 2019 19:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbfKFTjR (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 14:39:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43128 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbfKFTjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 14:39:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id n1so27485917wra.10
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 11:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kG39/eiSIBNH/bA9w6LOLTwj0G5SifqI/+DzPX7UjHc=;
        b=qXPb/GniHQtTj0PSGjx2Q+FKHJuD/63ZjbDCa4S/btkeI8+m/BQ75ZToScOSFK6mzM
         OSGvrML4X9sw7I2EDRC5L8Q12jIEY+5WnhMw1ZH3or/eA3GchxZIBBuOC++xrV6umbaA
         r9j4UatxOQcFKbRKBJduQ+GTJmcd/n/Q2sSN7puhfwFGiSfcmQjL9Q76xnyABd7lQVbi
         V2jMPivP/3sLu7uJ3zZ+e7gfXQf2isNQe+lcM2CAu4pS+dkuTkJy66GVD2rB2ffUsLrJ
         Lkf77xbusc9z5njp3HsKE5pbXoZP4t7pfih3/TZxfoqy5zxSfeRVs1RtCLhb152PWAH0
         AhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kG39/eiSIBNH/bA9w6LOLTwj0G5SifqI/+DzPX7UjHc=;
        b=EZSx0HmQF/JjskgbWI6eueTa/KAd1Bxhk/INhQI3uJ1MeIDj9+yjUIQE+Cun/cGJ3d
         +dPCG3/iFCh0tHLsNQN7Q/F3m4s7B/blPFWIgSmL5fjjTq+Bo0C/RVb+2E5Ow78TfKHB
         WxKCN4/NeCEsEkKZiAhpPrfKMBV6hQB4O/0CUiALTNUM8IBC46xpv5gMnZiBeKYrgPHC
         fcjmomzFP/rJLGWK5BgVi2ulAUtuylUU3rdNdn0nqH1v1h2Qh8865rp73Mnd1DV3fe2+
         898ymz/DjgXjBh80oNGaAHJs3cp99N6eu/Zt6HWcvzdpWUT1X5/HNAvH9xR8DapJ5JFj
         NcpQ==
X-Gm-Message-State: APjAAAViDZFRL8kLK/wLkSLLIOgicBpCUK1c1MEWPoyC6sD8WrXYFmow
        56l0TuQrM1k0FGPZUDp7OLM1go7E
X-Google-Smtp-Source: APXvYqygXKXsBN3EQWeRu30xKI1oGNzPgKsaqKJK7Jl4QVNDJ/HqeOiOknxbk5LnMTOAPWpmZgDdfg==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr617775wrx.38.1573069153488;
        Wed, 06 Nov 2019 11:39:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm24657194wrr.19.2019.11.06.11.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 11:39:13 -0800 (PST)
Message-Id: <pull.451.v3.git.1573069152.gitgitgadget@gmail.com>
In-Reply-To: <pull.451.v2.git.1573066300.gitgitgadget@gmail.com>
References: <pull.451.v2.git.1573066300.gitgitgadget@gmail.com>
From:   "erik chen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 19:39:11 +0000
Subject: [PATCH v3 0/1] fetch: add trace2 instrumentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add trace2 regions to fetch-pack.c to better track time spent in the various
phases of a fetch:

* matching common remote and local refs
* marking local refs as complete (part of the matching process)

Both of these stages can be slow for repositories with many refs.

Signed-off-by: Erik Chen erikchen@chromium.org [erikchen@chromium.org]

Erik Chen (1):
  fetch: add trace2 instrumentation

 fetch-pack.c | 8 ++++++++
 1 file changed, 8 insertions(+)


base-commit: 566a1439f6f56c2171b8853ddbca0ad3f5098770
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-451%2Ferikchen%2Ftest12-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-451/erikchen/test12-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/451

Range-diff vs v2:

 1:  4fdbb9f504 ! 1:  364c526a5d fetch: add trace2 instrumentation
     @@ -16,10 +16,7 @@
       --- a/fetch-pack.c
       +++ b/fetch-pack.c
      @@
     - 	struct ref *ref;
     - 	int old_save_commit_buffer = save_commit_buffer;
     - 	timestamp_t cutoff = 0;
     --
     + 
       	save_commit_buffer = 0;
       
      +	trace2_region_enter("fetch-pack", "mark_complete_and_common_ref", NULL);
 2:  606756d7db < -:  ---------- add whitespace

-- 
gitgitgadget
