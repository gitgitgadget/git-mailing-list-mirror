Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FDDC1F461
	for <e@80x24.org>; Sat, 24 Aug 2019 22:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfHXWi6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Aug 2019 18:38:58 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:37472 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbfHXWi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Aug 2019 18:38:58 -0400
Received: by mail-wm1-f42.google.com with SMTP id d16so12383082wme.2
        for <git@vger.kernel.org>; Sat, 24 Aug 2019 15:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=KwsgNVP55X4n/zHcDMDC1geFNq5dkZ1cM08wiKqC2W8=;
        b=cJ4eIKyH2OiOmUwyTD59Pr+cSPi8c+vvGkKPBeiB17p5MtlEi7kvd/bzKhiX8bMFVJ
         D2pWOCWJX+KNBkBhoztbqDN/nmBEYdJsx09kjU7WD4m61OsEaKAVBb+9LD6Qu0rxq6Ar
         vRwvaDKf6Gnx9IxJxwN/Ki4iwzymZ0Idxxpm6MMGG6shdYetAkQ+Sp3wz3Hvvfra27xd
         Sm8Is2OhKNpWI1TIb9lkbigivzNBrLlzYbzomvSLZhPE5VZw2tYM3Ev/ZMAg3fXD2EsC
         Rsj1ECyfzaz/YfehX7q4QqHs98yISlWRrpSKcRo9hcqUdOKQXsVRLW2whUEoGhFrhH/E
         Qdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KwsgNVP55X4n/zHcDMDC1geFNq5dkZ1cM08wiKqC2W8=;
        b=KdN3jHkr9Q7otLRODkxvuxEXEFAEiUhDqnTZ52HXXDK1tjI0o2iq9mG4ZrGgBVan7l
         hw12FIFfLcbQv0AKH7tCPykOFeE7Xbxnt+z5ouKsnfnBMJT4CifTIgIWRQZHljvHSJ78
         UXlwjUf5y8XZvLU8nwAfLPQ/Hg+v4SZPMzPO7uxSipQ3Me3+H/jBMMXeizjbzrhxY4D8
         oRZ0iwLurU9WoYh29ooDBJU57rVOk9vGetcKy86k0INrjWS88i1RggIqalaexFW/v3Mt
         efUkRumBIPYrBSDJEsOBbBIoDBW5AQNVyWm8mjx72/fccUDM6s/kwYp0JITG0zDck6Mi
         oXOw==
X-Gm-Message-State: APjAAAUEL0FTRIopMPIadhmnbLAc6oyunViwFAVzL74qCZFbTGDhp475
        cnKcGush80fq0OT18pNlL7GbRbwT
X-Google-Smtp-Source: APXvYqxUfYUU6Rt0y7esl8CDpOucW+2KE5nnd5MHWXCGjUFJD+8wcoRib25P9lMszqR8rPfHn4rZaQ==
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr13216231wmi.50.1566686336108;
        Sat, 24 Aug 2019 15:38:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c1sm5818587wmc.40.2019.08.24.15.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2019 15:38:55 -0700 (PDT)
Date:   Sat, 24 Aug 2019 15:38:55 -0700 (PDT)
X-Google-Original-Date: Sat, 24 Aug 2019 22:38:54 GMT
Message-Id: <pull.135.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] mingw: handle non-ASCII PATH components correctly
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

We need to be careful on Windows: there are "ANSI" versions of the API
functions that take char *, and "Unicode" versions that take "wchar_t `
strings as parameters. The ANSI versions are subject to the current
codepage, i.e. almost guaranteed to *not handle UTF-8. Internally, we do
want to use UTF-8, though, at least in compat/mingw.c, so we really have to
use the Unicode versions of the Win32 API.

Adam Roben (1):
  mingw: fix launching of externals from Unicode paths

 compat/mingw.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-135%2Fdscho%2Ffix-externals-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-135/dscho/fix-externals-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/135
-- 
gitgitgadget
