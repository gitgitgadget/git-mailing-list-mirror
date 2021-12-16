Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5E5C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 18:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240594AbhLPSTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 13:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhLPSTG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 13:19:06 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE8CC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 10:19:06 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso58391wme.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 10:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lysH+u1hA2PG+nEmoZsVMZExxz7UFgME0ywqbhIyYVU=;
        b=n+pogzmln6rqLfaGs/0otVxI7ddlDuHp/fqrp1q60ApT3Jx+1Bu7bWEOR3ngrnWMte
         1TWcUa8bvV78Lr6PWqQ5Hv/3zJkUYbElNWSijc3YyCZF4r7NOFJGTURRSrP55SpjHXOz
         w8xPpuSK4LSIIWXdGdMmlhejvos1SAKwhgY8f9Cg+Hq0L2y5Tb67brilW8Ws0Mt+85eL
         hrwwxzJGpA5zXdGttsT8rbWwYIHs4RSjGnKM51Uz6t/IYBx8xTDs0b3ubpjb6Erz2ynE
         AMtNUYB3wxoxvpCHxAC4jx21s07NXUlFBcsuAPI7PfxM/7ZtaSRnYisit6qXV2PGiaFw
         qMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lysH+u1hA2PG+nEmoZsVMZExxz7UFgME0ywqbhIyYVU=;
        b=xIGspKBqOB3C7arpHyern5jNoertNtBeKI8MV99Q/xcgpqRttHpT4RvbLc8KPXfqBb
         8T6uvGE7if+nNUqtkKMRVn5ac6E/11aDEB8Xho6nnZYtBuBNtrebYCOmMU7YcAPOx3iH
         iaD4wVEr4XLLGXsTQwx7kSCrd+UEe/4mQ6Xb6mbTDYboxYqFtuAY+wvEoaGWkN57Rrf0
         RcRYIDbM88hBJCVN9nffj1KsWqyBEvgV+545u1QhIHahiquw+eFhmbhv2Gb9qh/rYffY
         Xz3EdqRxe3AVasVtoUBQL4Dc42gUS12ybHLeu317LxuIZc2jRhRBpN6hk9qi2k4Qfvlw
         6VoQ==
X-Gm-Message-State: AOAM530U/DuimYhuyuCpB5gRxZwzn8oX3Y7bgMgMmLB9PxlNwQYnw8qZ
        L0+NiqOa8Hr2sZU+rgSjt62SmaoSMJw=
X-Google-Smtp-Source: ABdhPJxfu7COrvPfByhZMyngfrDIt3/1l9Sfn+CE0rVyB/YUKST2/XpQJD+gWTh49YdwcOJKqUJmlA==
X-Received: by 2002:a05:600c:4e8f:: with SMTP id f15mr6207142wmq.76.1639678744914;
        Thu, 16 Dec 2021 10:19:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n1sm6744703wrc.54.2021.12.16.10.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 10:19:04 -0800 (PST)
Message-Id: <pull.1166.v3.git.git.1639678734.gitgitgadget@gmail.com>
In-Reply-To: <pull.1166.v2.git.git.1639609138813.gitgitgadget@gmail.com>
References: <pull.1166.v2.git.git.1639609138813.gitgitgadget@gmail.com>
From:   "kashav madan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Dec 2021 18:18:50 +0000
Subject: [PATCH v3 0/4] normalize format of yes/no prompts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Altmanninger <aclopte@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        kashav madan <kshvmdn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:

 * Moves question mark before the yes/no choices, to be more consistent with
   other tools.
 * Normalizes format string for bisect--helper, clean, add-patch.
 * Updates localized versions of all changed strings, which was missed in
   v2.

Kashav Madan (4):
  bisect--helper: normalize format string of yes/no prompts
  clean: normalize format string of yes/no prompt
  add-patch: normalize format string of yes/no prompt
  help: make auto-correction prompt more consistent

 add-patch.c              |  4 ++--
 builtin/bisect--helper.c |  6 +++---
 builtin/clean.c          |  2 +-
 help.c                   |  2 +-
 po/bg.po                 | 14 +++++++-------
 po/ca.po                 | 20 ++++++++++----------
 po/de.po                 | 20 ++++++++++----------
 po/el.po                 | 14 +++++++-------
 po/es.po                 | 22 +++++++++++-----------
 po/fr.po                 | 20 ++++++++++----------
 po/git.pot               | 10 +++++-----
 po/id.po                 | 18 +++++++++---------
 po/it.po                 | 14 +++++++-------
 po/ko.po                 | 16 ++++++++--------
 po/pl.po                 | 20 ++++++++++----------
 po/pt_PT.po              | 16 ++++++++--------
 po/ru.po                 | 16 ++++++++--------
 po/sv.po                 | 22 +++++++++++-----------
 po/tr.po                 | 20 ++++++++++----------
 po/vi.po                 | 20 ++++++++++----------
 po/zh_CN.po              | 20 ++++++++++----------
 po/zh_TW.po              | 20 ++++++++++----------
 22 files changed, 168 insertions(+), 168 deletions(-)


base-commit: e773545c7fe7eca21b134847f4fc2cbc9547fa14
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1166%2Fkashav%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1166/kashav/master-v3
Pull-Request: https://github.com/git/git/pull/1166

Range-diff vs v2:

 1:  e6dc616c964 < -:  ----------- help: make auto-correction prompt more consistent
 -:  ----------- > 1:  e7672e70cc9 bisect--helper: normalize format string of yes/no prompts
 -:  ----------- > 2:  0c81a14247f clean: normalize format string of yes/no prompt
 -:  ----------- > 3:  4a70e569f8a add-patch: normalize format string of yes/no prompt
 -:  ----------- > 4:  fc913ef31fb help: make auto-correction prompt more consistent

-- 
gitgitgadget
