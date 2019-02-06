Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D94E31F453
	for <e@80x24.org>; Wed,  6 Feb 2019 20:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfBFUcO (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 15:32:14 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:36180 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfBFUcO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 15:32:14 -0500
Received: by mail-qt1-f170.google.com with SMTP id r9so9505193qtt.3
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 12:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YdEMk7wzAsuNvbxfPRMGZxkEzWwbnqdNLML7+R6NCWs=;
        b=ohMqc7RDNc1Z2s0EV2JjHf6aOKXKh6bXe1Bxl+oWxhHZcLpnwL2rQflEAV3bN2gHmX
         swNdnddGd8ZtKUeFn+P+dSw/5yJexMR2HTWnJL0SQH5uStasuh79MeGKT4HrPbc9DxL4
         pKj68odAyv3dw0m9J6Sg/g385RjwFIxflcF5NngRYVFlSQuiVp+ILp/WDMg7pAFHp1eG
         xa3+de0sWYt3CFpy9u1/XDz7YzHM3mtgN5R4OMWuYWdY6CI8Lzjqe3Gf5t3ql/0mVnvW
         rRF+UrCCJ3aFJMDKRrS7NDJ5JgyLI3Cs4UcOGuMGoRU9F5Hx4d8dGIN0In3fdcPj31EX
         ISBg==
X-Gm-Message-State: AHQUAuZQL6qtMpL2Bsh0D0/atUz8DQMrxB38YT0fuZHjicfnNiwiKN5t
        vpTUnVZVNBk5ninj4KqNvovE/lWiv3UtzoXFutc8lFJY
X-Google-Smtp-Source: AHgI3Ib+Qovwvv7ceK3dmwLPMPIdfuMU/IK8Rs8iWgef7q5AAhnq7juZ77bFy2y+/R1js9T//Zd5BXXRwxzK6dJ5e1U=
X-Received: by 2002:ad4:42d1:: with SMTP id f17mr9217278qvr.59.1549485133131;
 Wed, 06 Feb 2019 12:32:13 -0800 (PST)
MIME-Version: 1.0
References: <CALJ-GUD+6+_zrpEiWcKe7JwmM2t24R_NLpkk3Kg8g0VevCo1MQ@mail.gmail.com>
In-Reply-To: <CALJ-GUD+6+_zrpEiWcKe7JwmM2t24R_NLpkk3Kg8g0VevCo1MQ@mail.gmail.com>
From:   Tomas Tomecek <ttomecek@redhat.com>
Date:   Wed, 6 Feb 2019 21:32:02 +0100
Message-ID: <CALJ-GUBGcpctd-tRBtAHJJiemUvNQTp_AwUKPNtX_8Hc9ehRAQ@mail.gmail.com>
Subject: Bug report: git freezes when `git mergetool` crashes
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am using vimdiff as my merge tool. Unfortunately, vim(diff) crashed
and it froze my terminal completely, so I had to kill git. That was
kinda painful since I lost some of the work I did.

My expectation is that git should be able to recover from mergetool crash.

I'm actually unsure if git can actually do something about this.
Please let me know whether I should report this at vimdiff.

My environment is:

Fedora 29
vim-enhanced-8.1.847-2.fc29.x86_64
git-core-2.20.1-1.fc29.x86_64

Related bug report: https://github.com/rebase-helper/rebase-helper/issues/564
