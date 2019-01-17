Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4309E1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 20:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbfAQUOt (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 15:14:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43218 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbfAQUOs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 15:14:48 -0500
Received: by mail-ed1-f65.google.com with SMTP id f9so9361914eds.10
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 12:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=lBAtEFUCPkyYlVcHvfAfIherYJoteNMtVpP/K2+EpFw=;
        b=lxkf/CWT6TQ1E+0T9lvf+8liyvRrGNHGxeBF0Yxbp50RUFzAP9Et0ut8/EXwEEIeab
         yT7oXRYOgeGGq6Pux3tR6h7UOUwNWcrzydSYGcZuqXBJsWkjXugJzF/g1lOetRt+voUO
         Ys+AQXG9IeB6Til1Dm4voNDkqBftU9IGyd1sX0ZTCc1iMPWfyoTM5O6H5OEFJS23BSP2
         TdibiVgF39cO48phIeJlYwbS/gWRLcjF/AtQj/v5p7fGg/tk6auNDXEdMhVZb4EwsDFp
         MTufJr3SW3mKcLj4xj5z0Fl7oXovCljbqFzOe+aW004Hru/GdNWs80nBXeiC/y4st6kh
         Ullw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lBAtEFUCPkyYlVcHvfAfIherYJoteNMtVpP/K2+EpFw=;
        b=A8imJneu/lB+iEzhblN95hWRxhHCcWYw2Yv1VDTXz/PByuV8bL9SudXwKurmTastpU
         TvrPB71cn7qESErMVrxwkjjAxmQSAFrjhxtapdb69CLdfek3c9XlP2JLFTtsZPqgrRht
         2JchvegT11GqxA22uefX9DzNQtHm1aMPYnZyUkdhjgVt9C4TyQoQlesV3o2C6jdRTLeQ
         BvfGL9i2I+QjUABr9BFcKvdCVLAN1u2RJyFRvToHliYeK1tA5pR2HrYHRbiT5mi9FzdF
         okiAoNLm8wyhxmLNJHOd1zuZ6qTNCCMByOUYO1I67Hv2MGBq/BCeKcZ19D+dWFp+lmuB
         li/g==
X-Gm-Message-State: AJcUukfauqhb1EAdoDPDuu43i6/65uM2HpRQl8ovvHo+Qi8yoANi3eSQ
        wyx76NF7wNaDQY8kT4NlGZ91kbaM
X-Google-Smtp-Source: ALg8bN6jYxrhRX8jT/r/h8ik2i+g5xBiFvNIdewm8q63oXNGHwicX79GTkfOx7XYZjBC5xqMex7iJg==
X-Received: by 2002:a50:9a01:: with SMTP id o1mr13376985edb.82.1547756086981;
        Thu, 17 Jan 2019 12:14:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11sm6564176edn.14.2019.01.17.12.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 12:14:46 -0800 (PST)
Date:   Thu, 17 Jan 2019 12:14:46 -0800 (PST)
X-Google-Original-Date: Thu, 17 Jan 2019 20:14:43 GMT
Message-Id: <pull.94.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/2] mingw: fix git clone \\server\share
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

Due to quirks in the MSYS2 runtime intended to help interpret a command-line
as if it had been pre-processed by a shell, the backslashes would be
misinterpreted as if they were escape characters. This showed most
prominently when trying to clone from a network share, as the path would
start with two backslashes.

These patches have been carried in Git for Windows for more than
one-and-a-half years (in a slightly different, less readable form), and it
is time to bring them home.

Johannes Schindelin (2):
  mingw (t5580): document bug when cloning from backslashed UNC paths
  mingw: special-case arguments to `sh`

 compat/mingw.c            | 77 ++++++++++++++++++++++++++++++++++++++-
 t/t0061-run-command.sh    | 10 +++++
 t/t5580-clone-push-unc.sh |  5 +++
 3 files changed, 91 insertions(+), 1 deletion(-)


base-commit: 77556354bb7ac50450e3b28999e3576969869068
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-94%2Fdscho%2Func-path-w-backslashes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-94/dscho/unc-path-w-backslashes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/94
-- 
gitgitgadget
