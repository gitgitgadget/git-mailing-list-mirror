Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 032C21F45F
	for <e@80x24.org>; Thu,  9 May 2019 10:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfEIKKr (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 06:10:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35347 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfEIKKq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 06:10:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id h1so978052pgs.2
        for <git@vger.kernel.org>; Thu, 09 May 2019 03:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eUuMrQz1P1VV81mUclXKEZIs//ab2mw66SNRwfcZj18=;
        b=IB5c2qy+pcQOOe99jHT+Dhj5DjkuHBr84HjRwpf4C9T3VT96j365oh+WlVFHqci8su
         wIleSvgmTxUa2aomm23rz4I0Hk/0cgtYrTUZvvq2Ir7mHa5VbqmyVx9MxoGd890QHocJ
         1OxNusPvBSACFJR3uf4fMBBVgYRfIMn8ECnFtKerHwaGQHHUzANzIj9O94MI9e+MJdot
         kUi1NuYJLNht3mDVSf3SbdNNAI6G8/x5C1rSev3QrGbxZaWfyoXxX2R75PiJzWjbfo9c
         2+FfBzaetpy/xv6nN8WhRPWi5ZMtUFnbxR/TSVLKFuNzHNer5uAlJSW43NmlR/j8vOoW
         fiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eUuMrQz1P1VV81mUclXKEZIs//ab2mw66SNRwfcZj18=;
        b=lu7baUf0876EL1xYxBirL7d0nTQeYTc4LB4f4/h3v8UhO+jO5NjSrcpjZZzL52aQF7
         RAczCyoDLUPj5j9HEtr215tlO5WF4DkYlM+VbdjCfmp90ykW0ErQea4y/S7ilC0oUQau
         n1wdGWAgY65plcJvjyAkXmZoM1zKJunbREA9P6cw92PDkmFLY8rkZiMksHb7IO6AND7v
         01OD7cbJcMrQGaCyBYMuxvW/184Daavw9tBE+xqb+qXDozUKVuMFtWubxYy3CABzI/E4
         b35y4LvusQbZkK8GdOxWAyItpaBkpompjqzWkmZ1mjvZJEFVEx8Ut/0US1rX7AtjYln2
         eAZA==
X-Gm-Message-State: APjAAAVaLWvHPonE/UNJQnw92oVviWYy2fhhzDnMa5v5pB4F4ro1FSky
        +wZyug/Pnh4RfpQUVpPoOVE=
X-Google-Smtp-Source: APXvYqyu1sesIz519ErD9vmL2BFHlJ5GUkplEBy2mV4Or67K2Ac82GAND6HhR6cu+1rGCaaLfd/vcQ==
X-Received: by 2002:aa7:8493:: with SMTP id u19mr3621388pfn.233.1557396646196;
        Thu, 09 May 2019 03:10:46 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id s78sm4800603pfs.187.2019.05.09.03.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 03:10:45 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 09 May 2019 17:10:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, emilyshaffer@google.com
Subject: [PATCH v2 0/2] nd/merge-quit update
Date:   Thu,  9 May 2019 17:10:26 +0700
Message-Id: <20190509101028.24656-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
In-Reply-To: <20190501131152.314-1-pclouds@gmail.com>
References: <20190501131152.314-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple typos in the commit message. No code change.

Nguyễn Thái Ngọc Duy (2):
  merge: remove drop_save() in favor of remove_merge_branch_state()
  merge: add --quit

 Documentation/git-merge.txt |  4 ++++
 branch.c                    | 11 ++++++++---
 branch.h                    |  6 ++++++
 builtin/merge.c             | 30 ++++++++++++++++++------------
 t/t7600-merge.sh            | 14 ++++++++++++++
 5 files changed, 50 insertions(+), 15 deletions(-)

Range-diff dựa trên v1:
1:  a87e56a43a ! 1:  51710c4c6c merge: add --quit
    @@ -2,10 +2,10 @@
     
         merge: add --quit
     
    -    This allows to cancel the current merge without reseting worktree/index,
    +    This allows to cancel the current merge without resetting worktree/index,
         which is what --abort is for. Like other --quit(s), this is often used
         when you forgot that you're in the middle of a merge and already
    -    switched away, doing different things. By the time you're realize, you
    +    switched away, doing different things. By the time you've realized, you
         can't even continue the merge anymore.
     
         This also makes all in-progress commands, am, merge, rebase, revert and
-- 
2.21.0.1141.gd54ac2cb17

