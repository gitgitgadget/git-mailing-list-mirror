Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CD5B1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 21:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfAWV7R (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 16:59:17 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41601 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfAWV7R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 16:59:17 -0500
Received: by mail-ed1-f67.google.com with SMTP id a20so2941777edc.8
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 13:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=J69APIHRcbOsELgkk2VN0CbBUgMHF4OWst/JfUEfRG0=;
        b=YodBf97RuaU9dJEZufHuMQOx4zMNyVyvlv37D9em539ZFD0iVkAPw5XrosDrv4bjSG
         /Ax1hFgOPodnZ6r7osoRf+b7oQjv/bc6NSNIKZHKYGruRWFN/aaakerKW6Fh4KkgQktJ
         mOdL0SPhhUYmL+VlsVj0V+u3+Vm9GDTTKGWBtuTTbYFNxJUnoSvCdQb8MO1jL5DblY+r
         54ANldcEd/8934Qnn0lOLQ7k52lwVZXfN6stLG89BZi08OcazyeRO3wlJZBIw6J7d2Fl
         AnUPjNqh9gQRuAHmmbuctBThV+5iCdpjFcWY+xjc5V2NbYfFrCwmy1uXT2NmyvoE5BRd
         ibsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J69APIHRcbOsELgkk2VN0CbBUgMHF4OWst/JfUEfRG0=;
        b=neuPeZ9Nq1GO6jMZTMsqdy6poGj1MR/CD4/UDcQxIjXoy4ucqIE2Df6cQpeYzoedOb
         xF2XoCz4zU/nXDF3eg5qfiyURgOtUb2S8QeRxtDpYJR1NZK7FyI9/kPa0Tt2omHJ2kzo
         hcoqU8L/RzwwlnX2zqiX4pzH8fBi5Dq3loFCRBxepUrF8EtlxKhVyCVHCxJQmY/OhV15
         Uwvit3vYTiL+OJ6ujH+LQVNjYklN2xx7HFSc3mqn6u30AAOJ7uN+1IL4ZXQd68XLjhmR
         P+e9KNbbKljlYWDJj0VKXiWa0oIW690MPxzDnup22O7F1zXGA4JmLvAbkTyC7qLnCi0R
         AhiQ==
X-Gm-Message-State: AJcUukenNTV4BwlBJ+ltSSX9hzqd7kZElaZo+hKxu18+Uos3ifpdNrM3
        +MHjVFC8YcKFyIc+k4cpj3WvR7al
X-Google-Smtp-Source: ALg8bN5sxJBZRoYl3fn3lWtURa5P9Y6+4Kch9Gw/vb34eLUpElQNFKh79vwMmeUSr62MuR9QqJZj6A==
X-Received: by 2002:a17:906:3712:: with SMTP id d18-v6mr738501ejc.126.1548280755206;
        Wed, 23 Jan 2019 13:59:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i46sm10486141eda.37.2019.01.23.13.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 13:59:14 -0800 (PST)
Date:   Wed, 23 Jan 2019 13:59:14 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 21:59:07 GMT
Message-Id: <pull.112.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/6] Create commit-graph file format v2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file format has some shortcomings that were discussed
on-list:

 1. It doesn't use the 4-byte format ID from the_hash_algo.
    
    
 2. There is no way to change the reachability index from generation numbers
    to corrected commit date [1].
    
    
 3. The unused byte in the format could be used to signal the file is
    incremental, but current clients ignore the value even if it is
    non-zero.
    
    

This series adds a new version (2) to the commit-graph file. The fifth byte
already specified the file format, so existing clients will gracefully
respond to files with a different version number. The only real change now
is that the header takes 12 bytes instead of 8, due to using the 4-byte
format ID for the hash algorithm.

The new bytes reserved for the reachability index version and incremental
file formats are now expected to be equal to the defaults. When we update
these values to be flexible in the future, if a client understands
commit-graph v2 but not those new values, then it will fail gracefully.

This series is based on ab/commit-graph-write-progress and bc/sha-256.

Thanks, -Stolee

[1] 
https://public-inbox.org/git/6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com/

Derrick Stolee (6):
  commit-graph: return with errors during write
  commit-graph: collapse parameters into flags
  commit-graph: create new version flags
  commit-graph: add --version=<n> option
  commit-graph: implement file format version 2
  commit-graph: test verifying a corrupt v2 header

 Documentation/git-commit-graph.txt            |   3 +
 .../technical/commit-graph-format.txt         |  26 ++-
 builtin/commit-graph.c                        |  43 +++--
 builtin/commit.c                              |   5 +-
 builtin/gc.c                                  |   7 +-
 commit-graph.c                                | 158 +++++++++++++-----
 commit-graph.h                                |  16 +-
 t/t5318-commit-graph.sh                       |  42 ++++-
 8 files changed, 233 insertions(+), 67 deletions(-)


base-commit: 91b3ce35eeb93be1f4406e25ccdc4ab983a8e5af
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-112%2Fderrickstolee%2Fgraph%2Fv2-head-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-112/derrickstolee/graph/v2-head-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/112
-- 
gitgitgadget
