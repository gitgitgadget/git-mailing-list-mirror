Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19DB420248
	for <e@80x24.org>; Thu,  7 Mar 2019 10:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfCGKA6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 05:00:58 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38205 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCGKA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 05:00:57 -0500
Received: by mail-ed1-f66.google.com with SMTP id h58so12911372edb.5
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 02:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=IWkbPkTzX8ktyjmP839Vrqg08ew3i+NdaodeVtYcxTM=;
        b=XBcnUrtQcRpmfnWmf9cgoyUhEH0ZRZZy5SaWC/gK8SgF5asgjZbuYvtBMqTC0NpqG+
         XxB7jfjNjmXH43eauJVTABgoDbis4hl0FjfIYAsOMje66VXGRragvC58Mwk1GSNzXETT
         9NE25mSAWwg1R+yGjTiYmH96ZY0HxQlUPM/FdOqhmQw6Lnci8khahsBO8MpHg3MGQ2/w
         dvWzt0IUM/CJYu4QgUEYbd6ie+6scjwCmM52on47nXh0rOb1FmIvtRgVOltCs6MRnViH
         khexXcGitzEOqWUhzDaoXI7U+KTc5X9hXzjwutJoIgxROU5iQrlFnl4zOYEkj1c07M+N
         e1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IWkbPkTzX8ktyjmP839Vrqg08ew3i+NdaodeVtYcxTM=;
        b=uZ654kkBGvEZ6JPNbj70gzIwcxvZ4r3Qj0GyrvtZpfa5pAXynvmq28UVWEnP+X4eXO
         CNuTnViY7PF8kyxAm4je9DiUYFPj04nsdBqlxbKY+YU2fjsD4ISvHMShH2YPNHLysy4S
         AeHU3dMtggJmemevOAKORbvP96JxEKbA4oCCHMWL9v4XCD2Qw7BITVBGqlrAgMUe+c5k
         vngDNlUJ1S172b4WGsPRFuk+r1/0xi8+03EzRCdPfuqH0CciE9gLHUU+IVzvvmE3c9N/
         XNPC6i4GQZmpVNRLXNRZ+tSZyE91QNNKCyASGaVFke3sEK1UstQKqcKusOyxemdBruWi
         Ou1w==
X-Gm-Message-State: APjAAAXhqs1hMI8sD89LcON3SVPC2vAHQFPy8bGmTtctKVGfHnhKkmog
        tYPoEVc5GTxbrbK12aIW0HkJFthX
X-Google-Smtp-Source: APXvYqxx42b3faBmN+2yuQ8kvg7EfgssMtSoyB9khv63SBlLmKDGwtCzXK5+KRxwB+F/Mqg+k1KOfg==
X-Received: by 2002:a50:b37b:: with SMTP id r56mr26823246edd.187.1551952855998;
        Thu, 07 Mar 2019 02:00:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q55sm1240387eda.19.2019.03.07.02.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 02:00:55 -0800 (PST)
Date:   Thu, 07 Mar 2019 02:00:55 -0800 (PST)
X-Google-Original-Date: Thu, 07 Mar 2019 10:00:54 GMT
Message-Id: <pull.158.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Deprecate git rebase --preserve-merges
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

It had a good run, but its design was irreparably limited. So I came up with
a redesign:--rebase-merges. It seems to work all right, so now it is time to
start letting go of the previous design.

Johannes Schindelin (1):
  rebase: deprecate --preserve-merges

 Documentation/config/branch.txt |  6 +++---
 Documentation/config/pull.txt   |  6 +++---
 Documentation/git-rebase.txt    | 23 ++++++++++++-----------
 builtin/rebase.c                |  8 ++++++--
 git-rebase--preserve-merges.sh  |  2 ++
 5 files changed, 26 insertions(+), 19 deletions(-)


base-commit: 36eb1cb9cfe327583128a4b0abdf9516c2ca815b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-158%2Fdscho%2Fdeprecate-rebase-p-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-158/dscho/deprecate-rebase-p-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/158
-- 
gitgitgadget
