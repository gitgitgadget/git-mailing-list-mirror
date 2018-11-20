Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC34A1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 20:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbeKUGcw (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 01:32:52 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:37823 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbeKUGcw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 01:32:52 -0500
Received: by mail-pl1-f178.google.com with SMTP id b5so1868491plr.4
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 12:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:mime-version:content-transfer-encoding
         :fcc:content-transfer-encoding:mime-version:to:cc;
        bh=g0aYGjW9JMF9vFeq9pjALtor8ww/YiDkYnfe0PoEVn4=;
        b=bracTPvu7Z9xTOcUKPVlBbZZiHkU3ekLEULzuo/aDHzx7GyoNqVZOAstkilaTQcG+P
         AK6NOnu5tF9XyFPSya1+jfXRlWS+Xv1kMKkCZE0Tzhduif4ZLl0CWMJwxxl8opxN2IvS
         oYpUoPjpbj7sL0VuUDFP0xlZwwl3Ng74DhwqUxcn2m6scNH/V9adhg+S/pQ/f9UWbIHw
         FsEgrxkHXPU+NDwp5n4MnsqnchE3qPaLLgNLcGi7Oemr2i4/KS+Wwdl+s+Vrn0foOUNf
         MymMi5/0ctnQV/ZL7W6+/OjuvIgz4o8KW7Q15gcpezgG1QCbpBbdfpP3fa8y8IZ8puQ+
         8qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=g0aYGjW9JMF9vFeq9pjALtor8ww/YiDkYnfe0PoEVn4=;
        b=kKbsc2qbxlySLphBx5OxBPfgH36BoSeXUWBuMpeugdc5sijXR0sBHWw7T6+f0Q+ROo
         KjtXaQ34PPaV5kNZ39vtH8b45GqJ8swvjWe/kCgPKSm9NslcJUYFEQnX0ccPy4jelMLV
         s107Zh+x1mhPgG0K1NpHQbdyPPNOxTz8mU5rJvVZ68TvzRKDTaPHvPMnx9L1Gt1K4zJF
         OEiHJzEvFAUOp0KH6J3onjryw8ufR0OaZ/COzluli3Vr3+wiJrYpbU+YThpct2il1yPJ
         KrPP+0Dnp/U4XO9TOwP7cy8qwdlygUxNEbhaMsH1fKhPy1Usk7S1sbybmIWlssXIM3L6
         HrKA==
X-Gm-Message-State: AA+aEWZLhmZoyQ0cYE5xADCSvLgGxqV+5llVGXylPNbXPOeV18ofnj7P
        Crv7dcWrYU8CzcGgN/y7aZ/12dlJ
X-Google-Smtp-Source: AFSGD/Wdpav095RyArBn681Cxx5YJRwc6bOQsDErrEEPS6e+xpY/StwrOtFED2Kuy59VSZ/FaRpmaA==
X-Received: by 2002:a17:902:a70b:: with SMTP id w11mr3613981plq.84.1542744120566;
        Tue, 20 Nov 2018 12:02:00 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id 74sm52724414pgh.82.2018.11.20.12.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 12:01:59 -0800 (PST)
Date:   Tue, 20 Nov 2018 12:01:59 -0800 (PST)
X-Google-Original-Date: Tue, 20 Nov 2018 20:01:56 GMT
Message-Id: <pull.86.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] legacy-rebase: fix "regression"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

This is a backport, really, to accommodate a new regression test that was
introduced when the built-in rebase learned to validate the -C<n> and 
--whitespace=<option> arguments early.

Johannes Schindelin (1):
  legacy-rebase: backport -C<n> and --whitespace=<option> checks

 git-legacy-rebase.sh | 8 ++++++++
 1 file changed, 8 insertions(+)


base-commit: bb75be6cb916297f271c846f2f9caa3daaaec718
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-86%2Fdscho%2Fscripted-rebase-Cn-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-86/dscho/scripted-rebase-Cn-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/86
-- 
gitgitgadget
