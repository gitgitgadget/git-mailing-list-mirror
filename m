Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4185E20248
	for <e@80x24.org>; Sun,  3 Mar 2019 17:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfCCRLz (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 12:11:55 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:41223 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfCCRLz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 12:11:55 -0500
Received: by mail-ed1-f49.google.com with SMTP id x7so2304051eds.8
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 09:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5ikZQR71Htz5vw4U6lOnqBerV+FC1K5qbDSedjWj9Mc=;
        b=EalQjyY0Jzud5sUsmimalOcSQOUAB8Ox6OnOnIfzDx+0Ru3STrrL1JgKtkEM5ZRTxu
         a/5iqYJR/+kPd2psuOlFSwSzxrfLiFv2mEGY9j2IobK6406B+X+9VOaTHWl2o75g7V7p
         qdh1eHJPf8NY6a47tPGpWoYf6rhImCy9XdblyKEuJL6wIbBrOP55mO/2HkjPYSG27u/c
         87bRH7w+e9OmYFK4+EBNvQ2HINKStoHjibAH8adUOqhKzU1cK1rQI1vJoNvWMcmOLeC6
         n7or/YZZA/6Nus5OgGAjbiMwYk69Y3yTWvQDBF/RAZRHh8I8AOoRbQOkEIGluix87e+f
         FgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5ikZQR71Htz5vw4U6lOnqBerV+FC1K5qbDSedjWj9Mc=;
        b=st9LmlJHCiJ8eXcMsPxtcusQgtRM7eBK8OpCT7MO2vbKksxRS7/4p1xkcodYxy+ty1
         o1S1e1/HWgeoOvQ6acbn4i5EQFh59Rf2AsnyKZAgMNKDCc4P7sqObrBQ1rkchoOGiPVQ
         EHms1WRnlYulNZ0F8B+UHihAI+wEFvhyS7Xo1glSgf32GlppQIhr5fZuC9RrRxyGFHkU
         HvCr4Ki8182u4UsmRPJSO7YlKjr5NaX970Z5yirYf+B4eUQVZVdv4KTT6lR3fI95aygF
         HFk8cwsje1sxeDg2gFujPQhF4lsfszG44NpW9qjlutnWwMEBmAkpMkKjtOy6X9JoyDoT
         ZtiA==
X-Gm-Message-State: APjAAAVGmJsbEyJ6cnS9bD2H2rnb8rMd1TY2LN2LdYTEFL0mERrjoke5
        4rTOH2iLpXnQWXDSLk3LNghtAojg
X-Google-Smtp-Source: APXvYqwRlP9SwBv7fOI9ZQ/w0yl9sLFyHS5xoM9W567VSZLP5qeYaGPsEFCLBP/Wx7RgxrGug+wqXg==
X-Received: by 2002:a17:906:c45a:: with SMTP id ck26mr9927225ejb.216.1551633112885;
        Sun, 03 Mar 2019 09:11:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6sm746244ejs.29.2019.03.03.09.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:11:52 -0800 (PST)
Date:   Sun, 03 Mar 2019 09:11:52 -0800 (PST)
X-Google-Original-Date: Sun, 03 Mar 2019 17:11:48 GMT
Message-Id: <pull.153.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.153.git.gitgitgadget@gmail.com>
References: <pull.153.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/4] Fix ORIG_HEAD behavior of the built-in rebase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nazri Ramliy <ayiehere@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was reported by Nazri Ramliy that ORIG_HEAD was set incorrectly again,
this time caused by the shortcut to call git am directly, without detouring
to a Unix shell script.

Patch 2/4 might look like something completely unrelated, but without it,
the update to HEAD might use an incorrect reflog message.

Patch 1/4 is more a "while at it" patch; while looking which code paths
might need to update ORIG_HEAD, I noticed that this reset_head() call did
unnecessary work.

Changes since v1:

 * Reworded the unclear commit message of patch 1/4.

Johannes Schindelin (4):
  built-in rebase: no need to check out `onto` twice
  built-in rebase: use the correct reflog when switching branches
  built-in rebase: demonstrate that ORIG_HEAD is not set correctly
  built-in rebase: set ORIG_HEAD just once, before the rebase

 builtin/rebase.c  | 37 +++++++++++++++++++++----------------
 t/t3400-rebase.sh |  8 ++++++++
 2 files changed, 29 insertions(+), 16 deletions(-)


base-commit: 21853626eac565dd42572d90724b29863f61eb3b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-153%2Fdscho%2Frebase-am-and-orig-head-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-153/dscho/rebase-am-and-orig-head-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/153

Range-diff vs v1:

 1:  2d99429387 ! 1:  59c3266ed5 built-in rebase: no need to check out `onto` twice
     @@ -4,12 +4,21 @@
      
          In the case that the rebase boils down to a fast-forward, the built-in
          rebase reset the working tree twice: once to start the rebase at `onto`,
     -    then realizing that the original HEAD was an ancestor, `reset_head()`
     -    was called to update the original ref and to point HEAD back to it.
     +    then realizing that the original (pre-rebase) HEAD was an ancestor and
     +    we basically already fast-forwarded to the post-rebase HEAD,
     +    `reset_head()` was called to update the original ref and to point HEAD
     +    back to it.
      
          That second `reset_head()` call does not need to touch the working tree,
     -    though, as it does not change the actual tip commit. So let's avoid that
     -    unnecessary work.
     +    though, as it does not change the actual tip commit (and therefore the
     +    working tree should stay unchanged anyway): only the ref needs to be
     +    updated (because the rebase detached the HEAD, and we want to go back to
     +    the branch on which the rebase was started).
     +
     +    But that second `reset_head()` was called without the flag to leave the
     +    working tree alone (the reason: when that call was introduced, that flag
     +    was not yet even thought of). Let's avoid that unnecessary work by
     +    passing that flag.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
 2:  b92d76065d = 2:  67e41c032a built-in rebase: use the correct reflog when switching branches
 3:  1bc3cbad26 = 3:  17737998f4 built-in rebase: demonstrate that ORIG_HEAD is not set correctly
 4:  1786c172ef = 4:  7891c05f51 built-in rebase: set ORIG_HEAD just once, before the rebase

-- 
gitgitgadget
