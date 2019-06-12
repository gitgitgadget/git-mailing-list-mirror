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
	by dcvr.yhbt.net (Postfix) with ESMTP id B70481F462
	for <e@80x24.org>; Wed, 12 Jun 2019 20:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388669AbfFLU2Q (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 16:28:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35960 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388244AbfFLU2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 16:28:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id k21so24272035edq.3
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 13:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=41wLUZ8Hrs72zNxKAvp44gLB5t4ocj7OTd6uFvXv7VI=;
        b=XK24206QfSRHYG8lrKZ7MKwrV+OPk2RybWg6s8Ee3W+KkESSX5Jo33/sFTGLruVVtW
         iugVSfvg/pKhzBPTFTaHdFFaXAhA1hPEaEppf3q3F8dtAkGSkjxdBp/5DOmoL2abQxpg
         ahX0uNLnmRqXtkEGL7DgdQCY7RpwJ9Jxqy9SXsWbtqpzJIGnI4DlUHykxa6jeAERjezn
         l0Dix8pDbIJ8hah0b90o6ZHM/aQCcPmuDyDy8xiq3gWZBNzWAXPKLDh2ZPrDDJcwwm5O
         2OFjRk4005Fu1bg9UG9FlQSnHEnBe4NbnZy8txHREVt21VYKrUaZ2itttTwpK0c5FRt2
         J/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=41wLUZ8Hrs72zNxKAvp44gLB5t4ocj7OTd6uFvXv7VI=;
        b=Tt9W/EjUPT33K2jDBki1hiivXeJiyvhhodsSXTiGreIh86LnRUk7GqLgNajI7QchhY
         y3VRaaB7TdoU3OpJhp+AeX0va/wjA+aySEK9N63vKZEHFqX7rRSVTTKKI08dUPrCPfkQ
         cSRcAft4+BcrywY4igq/PLMua1ud8TPemxmzWHWXiu/KQlWSL2vPB7BKs4X4o04twhDE
         E9k6uyLmV/IF9+nL/5Zo3e0VaStzyu89xpS0d8SlnUaRHA3IbiJut9es3WomoctKIilh
         E645qf1QbJ88AHOCNcgspd0Z+pMyo5i/Kb6eSipBXz8RSwvfYTjNuAqPzFaqoL4TtV2H
         djig==
X-Gm-Message-State: APjAAAV+I289FTFqc07RyGQZvpDVpGZSKQj8HglwHYkfPLwUkF0Ke+dV
        5vCk3WAkGYWV6ZhAHKsqAcRReiVV
X-Google-Smtp-Source: APXvYqwnQwlupBioeVU1DCZqRO15Chy2P260JWFHHUASs73OA9RaF7Sz+2NJMjxFllu8lTuGTUfvxw==
X-Received: by 2002:a50:86b7:: with SMTP id r52mr62324554eda.100.1560371294523;
        Wed, 12 Jun 2019 13:28:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 15sm150495ejz.24.2019.06.12.13.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 13:28:13 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:28:13 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2019 20:28:12 GMT
Message-Id: <pull.263.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.263.git.gitgitgadget@gmail.com>
References: <pull.263.git.gitgitgadget@gmail.com>
From:   "Morian Sonnet via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] submodule foreach: fix recursion of options
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

During the usage of git in Buildkite we noted that git fails upon calling 
git submodule foreach --recursive git reset --hardafter updating git version
to 2.22.0.

This is due to a problem with the recursive calling of git submodule--helper 
itself, which is fixed in the patch below.

Morian Sonnet (1):
  submodule foreach: fix recursion of options

 builtin/submodule--helper.c  | 1 +
 t/t7407-submodule-foreach.sh | 7 +++++++
 2 files changed, 8 insertions(+)


base-commit: b697d92f56511e804b8ba20ccbe7bdc85dc66810
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-263%2Fmomoson%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-263/momoson/master-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/263

Range-diff vs v1:

 1:  e766e51777 ! 1:  c46e5bd140 submodule foreach: fix recursion of options
     @@ -65,8 +65,10 @@
       '
       
      +test_expect_success 'option-like arguments passed to foreach recurse correctly' '
     -+  cd super &&
     -+  git submodule foreach --recursive git reset --hard
     ++  (
     ++    cd super &&
     ++    git submodule foreach --recursive git reset --hard
     ++  )
      +'
      +
       test_done

-- 
gitgitgadget
