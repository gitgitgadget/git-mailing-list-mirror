Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD8941F453
	for <e@80x24.org>; Tue,  6 Nov 2018 20:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeKGGBs (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 01:01:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38867 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbeKGGBr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 01:01:47 -0500
Received: by mail-pg1-f194.google.com with SMTP id f8-v6so6324548pgq.5
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 12:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V8SsT1NTY+sAA/lYezBMcF+UYwmMqYZCSrZE0DicUv4=;
        b=kbxgZR5JYAtJdnxfORU9CDxJIblEcxHaKxMbPYeg0c10IZh3ZeSxC6Mkb9mrQvKxBf
         EwSv3sx+INlRzpJG9/t20lpjfVKEWuNHqdwGm5Pb+BsO+rsO67i3gdCH4cegicmvgLJB
         HKMbCCcL0a23pnNsdWdLp5Qrf/y3d93O8APOAJeid3fr+7lPAXWNFNnDCvTStHsaOm8j
         3tRIPgO8lwwpZ1iAGyhzea1CrmY+yhEdvpDBFKmz6gLwBI7xCE62eakKf+zR/udyI/kH
         wkIo16E89wnnxLnSG4e3lMCYwnQSCM6s2XaR+fghMBQkHPA6vCYmIAMOzHuRJKbnaRof
         EZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V8SsT1NTY+sAA/lYezBMcF+UYwmMqYZCSrZE0DicUv4=;
        b=WqbX+XK07J/E5/s+nNuBMTK2i9u7BluXBM8mIFLI5BAHhrJ1yEdCejpeK94HNad1/w
         iH0Djb++odrWO7+607rAZcZeNvLbmQW2uJ/Iv045JngH4k+BkmG4eXz4s9W7/36VQWjl
         vJMA8XCxtO6UU5Nm8zV/OQX/hY7FYSakQt7xijcINnCVDtZXUbnKgb/MqzWg+17TMLw2
         JVXtMtE+Tql+fCFVZrCFpnM18V0Yqi04q7iLY7RaRsNiJyLp6Sz9cKEDlCsTzhPVkXy1
         LSerAD7nxK1RVT6GA6tuDSc8W+cMKqBTVqLcDKp8cDK6MQgyORkfToI9SrtRbHnIiEsM
         D8Gw==
X-Gm-Message-State: AGRZ1gLZFQ8VJ9MzMAAKQAYkx0S8qLxg13uCSYK/SwrUCkeSObtoULs8
        5t9ohZ3b7txosFhVSdTAw8E5DXLyXWs=
X-Google-Smtp-Source: AJdET5eJhnh11R7DQG1/ZdYoHnaEXMIA59+ZCJT2zNPVFBs8VRXXZXvdXMgDZAVqtgPX7HSnx6euzQ==
X-Received: by 2002:a62:449b:: with SMTP id m27-v6mr27838791pfi.82.1541536486933;
        Tue, 06 Nov 2018 12:34:46 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id o1sm21157293pgn.63.2018.11.06.12.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 12:34:46 -0800 (PST)
Date:   Tue, 06 Nov 2018 12:34:46 -0800 (PST)
X-Google-Original-Date: Tue, 06 Nov 2018 20:34:43 GMT
Message-Id: <pull.68.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.68.git.gitgitgadget@gmail.com>
References: <pull.68.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] send-pack: set core.warnAmbiguousRefs=false
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

I've been looking into the performance of git push for very large repos. Our
users are reporting that 60-80% of git push time is spent during the
"Enumerating objects" phase of git pack-objects.

A git push process runs several processes during its run, but one includes 
git send-pack which calls git pack-objects and passes the known have/wants
into stdin using object ids. However, the default setting for 
core.warnAmbiguousRefs requires git pack-objects to check for ref names
matching the ref_rev_parse_rules array in refs.c. This means that every
object is triggering at least six "file exists?" queries.

When there are a lot of refs, this can add up significantly! My PerfView
trace for a simple push measured 3 seconds spent checking these paths.

The fix is to set the global warn_on_object_refname_ambiguity to 0 for the
section that is performing these object reads.

In addition to this patch submission, we are looking into merging it into
our fork sooner [1].

[1] https://github.com/Microsoft/git/pull/67

Changes in V2: Instead of using the "-c" flag from send-pack, just set the
global. I left the name of the cover letter the same to not confuse anyone
viewing the message without threading.

Derrick Stolee (1):
  pack-objects: ignore ambiguous object warnings

 builtin/pack-objects.c | 6 ++++++
 1 file changed, 6 insertions(+)


base-commit: cae598d9980661a978e2df4fb338518f7bf09572
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-68%2Fderrickstolee%2Fsend-pack-config-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-68/derrickstolee/send-pack-config-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/68

Range-diff vs v1:

 1:  1ef2c51550 < -:  ---------- send-pack: set core.warnAmbiguousRefs=false
 -:  ---------- > 1:  002868ee6b pack-objects: ignore ambiguous object warnings

-- 
gitgitgadget
