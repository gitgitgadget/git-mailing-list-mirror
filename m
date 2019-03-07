Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3E7520248
	for <e@80x24.org>; Thu,  7 Mar 2019 15:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfCGP3e (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 10:29:34 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:34979 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCGP3e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 10:29:34 -0500
Received: by mail-ed1-f41.google.com with SMTP id g19so13828446edp.2
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 07:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=ko7c2mJYq1DUpxj1IWTCgRbewR/Ufn0VYIv2RGwmmPc=;
        b=e9TVnj4gfGEtUWF2aNdWrPgV5khK/Ty3B7HoAmPLBfPuK9yiDHAxKYpQPhUd8nzpS7
         OOqDHA0LMkM81TviDgBIEKqu9xONTAOCOS1XV2tJ4DJhY5rJIgciMGjLWTc5raUSqya7
         4+YKwOdMHEcMnAvpeSIwYVwyG4VxlPCv+j1ppeMg90KAfiZJodfo0dnRT2wLRqP2Rlbr
         iguzS6kITN0Q6FK6MvYXnXw2lNQjA+/SyRV71yBOat8f+78wcfosA0b9FrJVjY7N5P/4
         mhPts6v4Z2oHl5YCxLkcGX2ay67m41f0LzIZRXYWEOvYOykezImL49SRI3JlnnIQtC6l
         Jrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ko7c2mJYq1DUpxj1IWTCgRbewR/Ufn0VYIv2RGwmmPc=;
        b=Hn/Ta2hzkX3fGXSnyhjFQAvxBqNSZI5V2dJzsL/BogqxXrV1HbzCxcnYLlTwJeYSqa
         y7r3+g6KwVLEQTCxR1RCYikeBugz9l0S3VNy7uIegxg2VfYD5kBeeiIFMFggNCdOqOAn
         xOLMhI5ncUI1pg4ucITmVTrKcp4YP/U8uEimP0ClCTuLwanU0CKHfDZNIRY55xewGWMN
         fOU8xtkDbNpWI830MJhHmAQUn0q16yVFhNnnsGQ4j3/jgNzPthayZfdkXWRaRJf9TKuV
         gou1nADCH5cxIyn5D+tRJQs4fy0FbblpE/0097jUekR8yUig1H2Z+jaGJYQR90SRuAdT
         /dNg==
X-Gm-Message-State: APjAAAUwM9OhGZOsPiFrNHua+JoIeqGgqh9WIrjw9rJ5TtebgETtOTnB
        O0HtMRubxotpMAOHuyAR3mftxaCU
X-Google-Smtp-Source: APXvYqzD4aoS3C+9PBVYsqa+Vv5WMP+LYmzJI7q0978C9h8djye0Am8bb/l1IIYPle7YYCtR3EM6xg==
X-Received: by 2002:a50:9235:: with SMTP id i50mr28193765eda.20.1551972572565;
        Thu, 07 Mar 2019 07:29:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 31sm1391540edr.7.2019.03.07.07.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 07:29:32 -0800 (PST)
Date:   Thu, 07 Mar 2019 07:29:32 -0800 (PST)
X-Google-Original-Date: Thu, 07 Mar 2019 15:29:29 GMT
Message-Id: <pull.159.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] stash: handle pathspec magic again
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

It was reported in https://github.com/git-for-windows/git/issues/2037 that 
git stash -- ':(glob)**/*.testextension is broken. The problem is not even
the stash operation itself, it happens when the git add part of dropping the
local changes is spawned: we simply passed the parsed pathspec instead of
the unparsed one.

While verifying the fix, I also realized that the escape hatch was seriously
broken by my "backport of the -q option": It introduced four bogus eval 
statements, which really need to be dropped.

Johannes Schindelin (2):
  legacy stash: fix "rudimentary backport of -q"
  built-in stash: handle :(glob) pathspecs again

 builtin/stash.c                    | 5 +++--
 git-legacy-stash.sh                | 8 ++++----
 t/t3905-stash-include-untracked.sh | 6 ++++++
 3 files changed, 13 insertions(+), 6 deletions(-)


base-commit: 7906af0cb84c8e65656347909abd4e22b04d1c1e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-159%2Fdscho%2Fstash-with-globs-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-159/dscho/stash-with-globs-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/159
-- 
gitgitgadget
