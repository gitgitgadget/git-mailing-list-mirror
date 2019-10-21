Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44571F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 18:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfJUSkG (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 14:40:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40249 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUSkG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 14:40:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id b24so13785737wmj.5
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 11:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pW8pS6G2719q+zzOrXEH7KQeJ4JNJqRA2w3EaBCANzw=;
        b=AKCo6ZN8+cftLNVsvZFOb7r7PPuLcqkcwJ+Csm93WZZ+tVQ+91HXf+943or46zero1
         +Tj0FnE8ap+PajKX3Tfy4Dfomm7iL7xM53apRitNO3jlAMOvn4r+LnLSHnccjmxhocyi
         7DxSYJfD/5MRv4eciRCe4UVOqYKL4A7FZqt72bLFeoQVPkTEwN0wNOjH60Eez7YtoVvW
         AIlPrvt854g3eRqhxff9RWKpn1vCvb5m2/NqUZsjqoEZZg+k99QXhHut6ylFyIF2R/Ca
         E7QfV0LKMkpyTEQmjGVTkC4TfUdlwKJNULQy9HwV9SuElH1DZ9km9zBTeXDyo3EJsxLy
         EwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pW8pS6G2719q+zzOrXEH7KQeJ4JNJqRA2w3EaBCANzw=;
        b=nMyhXUc7RFNO0v2pr5abKXkp5/Opm6Mgt7NoRm33BlVJPuIBN77HZ2gej0hFinN6w7
         yf0NIdcNYQADwAkEiJ8wwXDwAO34gaqWbGjTk2lctsEQkCVAClKFOUeMl29I50XgQ8Mr
         WN58yRJFjPbqHm8k6Q1V+HKXme5dAqRwuPt6jQjUnNKvg0QPDWFfO7OzLsE85PeCw37Z
         +sctOG3uG3WKA3FhEx6zguiKGKKq0HzQieGcHfqiVnV6D03V3bbLFJC2vr/LlLrPCKf0
         yCsunxEwGJw0TWR6Pn7mlhK2XJAhfjpAX2PTTBBjeV5UGXVdrwkX++bLqJmHwBrV7bRU
         Ig3w==
X-Gm-Message-State: APjAAAWjibY7cLRYM1BXaEP2oXPaSgI5L2Y7dk4MjPPMI0zBlzRm/UJH
        2lll0H80aLf1aC8kQhVhpolrSIOh
X-Google-Smtp-Source: APXvYqzrTDeV6AQVMRLoJT7pJF7sbSRejNmFxXm08Si1l22f+NtyQCUtm7XcCNCGNn4gxXJyapxb6Q==
X-Received: by 2002:a05:600c:219a:: with SMTP id e26mr16446493wme.147.1571683204408;
        Mon, 21 Oct 2019 11:40:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13sm25578669wra.74.2019.10.21.11.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 11:40:03 -0700 (PDT)
Message-Id: <pull.337.v4.git.1571683203.gitgitgadget@gmail.com>
In-Reply-To: <pull.337.v3.git.gitgitgadget@gmail.com>
References: <pull.337.v3.git.gitgitgadget@gmail.com>
From:   "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 18:39:57 +0000
Subject: [PATCH v4 0/6] multi-pack-index: add --no-progress
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     williamtbakeremail@gmail.com, stolee@gmail.com,
        jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git contributors,

This is the fourth iteration of changes for adding support for
--[no-]progress to multi-pack-index. 

I'm resubmitting the series after a discussion regarding 'MIDX_PROGRESS'
that concluded with a decision to stick with the original changes in the v3
patch.

Thanks, William

William Baker (6):
  midx: add MIDX_PROGRESS flag
  midx: add progress to write_midx_file
  midx: add progress to expire_midx_packs
  midx: honor the MIDX_PROGRESS flag in verify_midx_file
  midx: honor the MIDX_PROGRESS flag in midx_repack
  multi-pack-index: add [--[no-]progress] option.

 Documentation/git-multi-pack-index.txt |  6 ++-
 builtin/multi-pack-index.c             | 18 +++++--
 builtin/repack.c                       |  2 +-
 midx.c                                 | 71 ++++++++++++++++++++------
 midx.h                                 | 10 ++--
 t/t5319-multi-pack-index.sh            | 69 +++++++++++++++++++++++++
 6 files changed, 149 insertions(+), 27 deletions(-)


base-commit: d966095db01190a2196e31195ea6fa0c722aa732
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-337%2Fwilbaker%2Fmulti-pack-index-progress-toggle-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-337/wilbaker/multi-pack-index-progress-toggle-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/337

Range-diff vs v3:

 1:  cd041107de = 1:  e7b1cc633b midx: add MIDX_PROGRESS flag
 2:  0117f55c9d = 2:  37768f5886 midx: add progress to write_midx_file
 3:  d741dc60bc = 3:  4ac9527d98 midx: add progress to expire_midx_packs
 4:  f208c09639 = 4:  3468acf39a midx: honor the MIDX_PROGRESS flag in verify_midx_file
 5:  7566090769 = 5:  d6ae4e1c54 midx: honor the MIDX_PROGRESS flag in midx_repack
 6:  a3c50948d9 = 6:  ea4f869780 multi-pack-index: add [--[no-]progress] option.

-- 
gitgitgadget
