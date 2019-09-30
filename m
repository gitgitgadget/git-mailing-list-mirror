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
	by dcvr.yhbt.net (Postfix) with ESMTP id 183BE1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 09:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfI3JpH (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 05:45:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39048 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729590AbfI3JpG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 05:45:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id v17so11930692wml.4
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 02:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7cuzMBNJi0CFp257FCir1+s81P7XjNZ+el2Iekj34Oc=;
        b=mXwdHyAvw9lGLqqVbNTI4w3Se9waHfNno3SHv/fNb35ry1wzgUiHkMo5DVlH8HIasq
         NcE3srZ6tIXOv9qAzI3eUvSudk5YfhsJsSe0Fzeb0m0DEDnAWAv79Olm6V0oYjcLytLv
         5tZ4L8iwM1MOcCbTAbM6Bzn2M6POtr2vGMWqWbSg+1QSnUcJuAnAcU3Yoikr0a0rwHSx
         q1dzzzfIGtyRM1DWq764IWCTUPZ2ms+N8EQAqQ0tu8EqzliNfMCs2ke7gHtfyir3TBzv
         eQPwbGHYTq+55TTDPKj32NfEclkezziuYeYKQCEajmz4T9RajjCoDon3XRQMDszXKB1r
         tDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7cuzMBNJi0CFp257FCir1+s81P7XjNZ+el2Iekj34Oc=;
        b=fB1H7+VOgAuz3P0xFMETI7uwVD0GP/m1T3EZzEqsDhPJ08Eywex9PPxQ142DIMDaU7
         vbBp5vofCM0bWD+5luKKBwf/fhavOoBxNwC1FYSobukpEfGgdQOa0qLPl8u0YemEjasJ
         bg+xonzSQrZ/XY3as8nvjt6/AtXhHZE3dKy+xpLbk1ILsXYlBl/JAKa7vblxtd2loKwO
         tKEdh8J/XFq60+qPDIVCIqRh6BKUZJ8ZGwb5fj53kRaz2L3OU/eURtemfAlfo5KOd5ZF
         Rk58Cx8UZlIsN9eonF0bznUFf21WHZCSomOgIjvgMrB7wNGS6F62hfqR/JAAPKUf31qV
         vuwg==
X-Gm-Message-State: APjAAAVaQ3EGdHVP8YSlzAM3nAvu18DoME3bX5GGY93t2u3f6OgEfwUM
        O4zazGdWmnqRqgpAEkW4X7wCC/Jf
X-Google-Smtp-Source: APXvYqxSsKlloQy7TFEfSI04KKylKCgo1M8d8Es7uUyOnoiANrFLnxVQnAC0JLY7pCArxIWlClpg0g==
X-Received: by 2002:a1c:3803:: with SMTP id f3mr17701344wma.161.1569836704983;
        Mon, 30 Sep 2019 02:45:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 207sm22462971wme.17.2019.09.30.02.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 02:45:04 -0700 (PDT)
Date:   Mon, 30 Sep 2019 02:45:04 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Sep 2019 09:45:02 GMT
Message-Id: <pull.361.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.361.git.gitgitgadget@gmail.com>
References: <pull.361.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] git-gui: respect core.hooksPath, falling back to .git/hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is yet another patch from Git for Windows.

Changes since v1:

 * Rather than a fine-grained override of gitdir just for the hooks path, we
   now spawn git rev-parse --git-path [...] every time gitdir is called with
   arguments. This makes the code safer, although at the cost of potentially
   many spawned processes.

Johannes Schindelin (1):
  respect core.hooksPath, falling back to .git/hooks

 git-gui.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)


base-commit: 60c60b627e81bf84e1cb01729d2ae882178f079d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-361%2Fdscho%2Fgit-gui-hooks-path-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-361/dscho/git-gui-hooks-path-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/361

Range-diff vs v1:

 1:  eca193f91b < -:  ---------- respect core.hooksPath, falling back to .git/hooks
 -:  ---------- > 1:  c101422936 respect core.hooksPath, falling back to .git/hooks

-- 
gitgitgadget
