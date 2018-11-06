Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3921F453
	for <e@80x24.org>; Tue,  6 Nov 2018 14:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388851AbeKGASw (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 19:18:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46683 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388428AbeKGASw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 19:18:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id r64-v6so6199849pfb.13
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 06:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=BzUqSNVOJFaThAa1U3cTJhss3l1r8vRkGHQcLHaB8Os=;
        b=ehn8kxfVnCKWCX0mo9ISC84FA8/+5FIUsITWTdJlC79Ud/tV6etdRHGXvzsQ6a00Pf
         I/5ZAXqgXQH0qoecY5EIuHC+DHw6udRO16VpGsn9N+EISgW/St7lrcPIfHvENjaI1DnJ
         KzZCIWcYiGgadcIxsSul8fWkKkwhK2srw7B7Pxooqu6aW8o6t3s/xEFg3Qgfc7vzdhwV
         Sw7sbj3wr17hFo3xOwlVJpWsPPqdMtQqvSYLYTvc/cT/4eSNEPr+mLCuXTHJrUVRkLBQ
         6t/mOErlQ4GlLUGRe3a19S8ypeq9JG0qgir1EO1jbbeowM+toahKX/s7zxH6LwTPUaCZ
         e39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BzUqSNVOJFaThAa1U3cTJhss3l1r8vRkGHQcLHaB8Os=;
        b=lH0m2ZNRRGS6czXhyWVURV3ol9SrlBpR+Ny3TklPk/PocyIMptc3A25FufcvvIqXp8
         PVxU5bsx8AEOGei8YBBe8myx9hrM8I6UZq5PJzP+OkNxFhhrTGOLzN1gjrjl4GZ4Y/p+
         oojN93Jc0S/ItqSZ0lRVO8Chz1zfQEAMriQN++ZX7m3VIUepaSCebr++p4oyH2Trp0l6
         h+kYHabHntpobk3U5glcF/C7Kh+QY+VmsHDnE/HgUiCUU7nmhhx+Z03FUXoT6OVn/yOH
         e2r0PVKESeds/pmsXeEMKct0fUoQGIO8EsOFtTv/t/pKSQIf35NsN8RAutiZ54jhjIyS
         nZXg==
X-Gm-Message-State: AGRZ1gJilHL0i3H14m/rGkUJq+yKUu2f4dW1rBS/SGFXVrssBQoUHn+e
        AR4+LfrhXPF/oSVY1LidGTh/WO7E
X-Google-Smtp-Source: AJdET5evHodOREYwIQ4L1SyO5peo96SRp2vGSfwG3LsAA4zjv1LsmCorrMWeh8J2dXul9rK/xVzIew==
X-Received: by 2002:a62:30c7:: with SMTP id w190-v6mr25980610pfw.188.1541515997014;
        Tue, 06 Nov 2018 06:53:17 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id u9-v6sm23242215pfm.175.2018.11.06.06.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 06:53:16 -0800 (PST)
Date:   Tue, 06 Nov 2018 06:53:16 -0800 (PST)
X-Google-Original-Date: Tue, 06 Nov 2018 14:53:13 GMT
Message-Id: <pull.66.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] mingw: handle absolute paths in expand_user_path()
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

While this patch has been "in production" in Git for Windows for a good
while, this patch series is half meant as a request for comments.

The reason is this: something like this (make paths specified e.g. via 
http.sslCAInfo relative to the runtime prefix) is potentially useful also in
the non-Windows context, as long as Git was built with the runtime prefix
feature.

The main problem with non-Windows platforms is that paths starting with a
single slash are unambiguously absolute, whereas we can say with certainty
that they are not absolute Windows paths.

So maybe someone on this list has a clever idea how we could specify paths
(unambiguously, even on non-Windows platforms) that Git should interpret as
relative to the runtime prefix?

Johannes Schindelin (1):
  mingw: handle absolute paths in expand_user_path()

 path.c | 5 +++++
 1 file changed, 5 insertions(+)


base-commit: cd69ec8cde54af1817630331fc441f493866f0d4
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-66%2Fdscho%2Fmingw-expand-absolute-user-path-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-66/dscho/mingw-expand-absolute-user-path-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/66
-- 
gitgitgadget
