Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A889B1F404
	for <e@80x24.org>; Sun, 11 Mar 2018 13:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbeCKN7N (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 09:59:13 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40959 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932136AbeCKN7M (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 09:59:12 -0400
Received: by mail-wm0-f65.google.com with SMTP id t6so11444293wmt.5
        for <git@vger.kernel.org>; Sun, 11 Mar 2018 06:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/QwV0JrVj1m9c4rrWpD9KLpsogPaQXDmTfxPXs4LBV8=;
        b=LUL9bW/Dbg+5TVnQvaTxkLyMm+lTv3K4GhrmZlUqjgk+VS6UxZeANTKICIqkgehVpr
         lhLw6kR3b+jaNkv/YKNvmAcco91ldwbD2aataRSP0812J3pu51T90DNvK6c6W/ESU64b
         d9kaq0njFKphyfULsQ2Cg6fgdh3L7cotH6jAT0TnVDjHmIxfOtvCi4BmTdK/BgDBCuQB
         BqAaFDKgjHUyrTwycbneXZiIF0MU5+g6Hm/A/KIUSm6/J5rr5umk75HMw0xACoDip9Zj
         MpObKDVXB/g8Fd7rJVkBD1WZh2cJZnGDUdTfP6yhpfaOuC1hxDlLJxSeZKkHVIxu7bB+
         laMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/QwV0JrVj1m9c4rrWpD9KLpsogPaQXDmTfxPXs4LBV8=;
        b=S6NvHxLz4vtcInhI7N2ViIUfl8yfU1DbJu5gEZq8wg579zY867r08fwAL4cRuLsZvz
         zZeE5lXq+y8j+o5s660PJ+znNGr1wK3k8gAHpuIh4yChoG4NL8nzYSCjtcDjSZbNAVbD
         RTyjuVUtkGR3IPLZkJOljlBUpBcq4Sw1xdL0odBp8uAeeWzk4I2j+NiRND58MHIWVPzU
         f7QHjkYR6wSz1r1UoJ/Dobvigs6KNNadT4Ar4ghG8+HktveQTLNd82FMqwkERQFUB+Xw
         zI/dDQnlCn0kUb795eyw2joPBJNRjjFwGPwRHdF9T1fR6T1UFqoQ8xK65Z99MARkaUEJ
         KCFQ==
X-Gm-Message-State: AElRT7FFaqDIVYHcSKuaEtG4L/gV9chzT4NiUxBqRSK9D42gRG9DJGr0
        Vy6B0ziO/8mvj4ywBdhY4c8qLw==
X-Google-Smtp-Source: AG47ELtSsw82hUA8PIQeW2gGDuP3zTqEtGro1KMI/H5b3zDdGS89OS0f5uoTTVY+sbPyJ0I7UE29ug==
X-Received: by 10.28.139.142 with SMTP id n136mr3097307wmd.101.1520776750940;
        Sun, 11 Mar 2018 06:59:10 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a62:81d:ab01:6470:d27b:6b84:5144])
        by smtp.gmail.com with ESMTPSA id c192sm3505133wma.12.2018.03.11.06.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Mar 2018 06:59:09 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH v2 0/2] git-svn: --author-prog improvements
Date:   Sun, 11 Mar 2018 14:58:33 +0100
Message-Id: <20180311135835.9775-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180304112237.19254-1-asheiduk@gmail.co>
References: <20180304112237.19254-1-asheiduk@gmail.co>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first patch has been queued by Eric Wong but by Junio Hamano, so
I'm not sure what's the expected procedure. I#M posting it again just
in case.

The second patch has grown up with some documentation and some tests.

Andreas Heiduk (2):
  git-svn: search --authors-prog in PATH too
  git-svn: allow empty email-address in authors-prog and authors-file

 Documentation/git-svn.txt       | 13 ++++++++++---
 git-svn.perl                    |  3 ++-
 perl/Git/SVN.pm                 | 13 ++++++-------
 t/t9130-git-svn-authors-file.sh | 14 ++++++++++++++
 t/t9138-git-svn-authors-prog.sh | 25 ++++++++++++++++++++++++-
 5 files changed, 56 insertions(+), 12 deletions(-)

-- 
2.16.2

