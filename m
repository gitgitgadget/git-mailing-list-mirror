Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C4621F404
	for <e@80x24.org>; Tue, 14 Aug 2018 11:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbeHNNtC (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 09:49:02 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:39167 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbeHNNtB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 09:49:01 -0400
Received: by mail-pl0-f46.google.com with SMTP id w14-v6so8173800plp.6
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 04:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=3GRULzzI4HTZjqyWXVhOdL3izcWTKtnfkrJVsyR5kiY=;
        b=P/VBwaC1iesuo5Oc0oC+J/9Z+FpegZ/dBg5FJdrsk21DqacZOHMXLufKjJtbFZE4jl
         OXc3fWPxLLrffVsifdb/uJi/rqlqiOmuM3ktYerCoHk3s9xVXMgvZtUpn/C5QMIcP+ml
         n8V1kyY+d3uZh58qmPK6fREEqJc5fv5PZPkAwK+4rHeGbS53EThgJFhPdLkxJwUxEnQk
         fn36K+OdkTzi0OEgqGYO84EFQTk9pTshN+OYdo88y/EKNzTzbbvUcqR0lHjo9JF32ZQ2
         q+urL18x9XyhwNNM3ADmlhzkTRyC9G5gVePEE4HEhTtGqIqPY/tzjWR46Ke/vEPFM+fi
         UDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3GRULzzI4HTZjqyWXVhOdL3izcWTKtnfkrJVsyR5kiY=;
        b=MXMhkzeAEIpoCNZ/zB+aW4YEWxuF4g3UEy25IfyQYxdfOl5WETm/2lFdMizJTX692Z
         r+Wtcd+BHC9yzrmZaKjV7b2Qu/xQBcycG+53QLgVuwSz7th/A8TxZgmclHqGmRIAqVFN
         pEGrlGcClYErCYsOzHr6pDrHbDN/Ky6OSj7qIvkEYlTSH1TiLhN6GE7XHnkKxn3dWjnC
         m1QwEvHjNXeGFQAn2vsF/VskqIquMJZc7digLAN3I8aN9hynykpYlrDj0Vuhk1xNVDCL
         gZzKsOuHxEoMf+vSt3j5qc125O6kkSzziAsdbwX4r8r+Kzb0rqYqN6R+FEtGDOTIkyEz
         qa0Q==
X-Gm-Message-State: AOUpUlF+SANAllegQK8N3CzghyXigCnmc5KkxLBgBB08NSKFDV0um+tZ
        XHxxzMayiQoe0OkUQgHi1HLZWUWm
X-Google-Smtp-Source: AA+uWPyU6Bq75vhIH8V83uH3CQz5ZhC7uehkuxNb80la2F/x2V3JQgSCDMx+ayHsXVw3CRelSDkM+A==
X-Received: by 2002:a17:902:d70d:: with SMTP id w13-v6mr19894394ply.229.1534244541206;
        Tue, 14 Aug 2018 04:02:21 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id c85-v6sm41376000pfd.110.2018.08.14.04.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 04:02:20 -0700 (PDT)
Date:   Tue, 14 Aug 2018 04:02:20 -0700 (PDT)
X-Google-Original-Date: Tue, 14 Aug 2018 11:02:16 GMT
Message-Id: <pull.18.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Fix a recently-introduced compile warning
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

With the relatively frequent breakages of pu recently, I had trouble staying
on top of the compile errors/test failures, sorry.

This one exists since Sunday, and it is a compile error only with 
DEVELOPER=1, which is, however, the recommended way to build in Git for
Windows' SDK.

Note: it is based on nd/clone-case-smashing-warning.

Johannes Schindelin (1):
  mark_colliding_entries(): fix incorrect #if...#endif guard

 entry.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


base-commit: f80218bf4e65ccc06cc9173c0ac5a5520d380f36
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-18%2Fdscho%2Fclone-case-smashing-warning-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-18/dscho/clone-case-smashing-warning-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/18
-- 
gitgitgadget
