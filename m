Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A56B1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 19:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbeI1BcZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 21:32:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45126 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbeI1BcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 21:32:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id x16-v6so3458106ljd.12
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 12:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P9Dy9YBaRFer+Hd7eBwfwqPwloiri0u9MKsA3Ln+YYw=;
        b=FtngJXp8NKu3bX5RYVFXm+032KlTEs2QPByGiN4HMJ1BPYsR6ipOdW9uYUa+EuP+Xd
         iTOG65mrPqfyX0j4Na58NKuy/yRNios8WaqJV7KmT5BV8nmJYaILeH1tkbi1AamseZZ0
         ivJVMrnDsY6rCoyvr3IBoHpwkj9GHw5lUZSIQrXqNetdybqrDiYmP2HxcrtSMNZ9jpSX
         /2kSxl+E81w7GhZQqTNEMO8wBMVWuN0z72VTpLNrkoym84OKz+QJan+IBcursSyByUK7
         cRYH4zPow0lhbXXKyCctbjbtlETQ4Z/BQGqz4zPkXbEBEnDaGj45airNgsrCVJDAOi2Y
         YCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P9Dy9YBaRFer+Hd7eBwfwqPwloiri0u9MKsA3Ln+YYw=;
        b=dwY88b/SuIUPr2aY4FG3emNrd9POIzjibTHgi8hHe0EmTnn0ebjBPxBIT/Z/KoFDib
         Usd+RWXrfY8mCN4i9JeJup0LkT5Bu72napZ73suX07wM+otb+MS+1ZpLl3pMsFZUxR8F
         6IA13zug13FxFiMUbaCtst3htPH2i9DlBdSywzLT/sye32MHwZAbyTs+LnSpQUcHWgj5
         2q/J6iym+YY/kVpIaj5vsyqSftPUxHLCC5aMMs+KQN+HRdxJWljE5XjwhZjneDFY1a6R
         KS6pqmW2+N4rlDk7eVsKf8XWL4GgefBy1Lgs6Xk5hivyxtCNvsxlZwiePvtvEcLs1Lj7
         5bEg==
X-Gm-Message-State: ABuFfogrGLA1GGOhJ7hpUzoks2D6Gj3YwaekY7JKv4NulZoF/qJcBLHf
        CEq64rTdB/RqfOhKgKgak4JAys+S
X-Google-Smtp-Source: ACcGV61JRpf8kEuJhSqmAnAOVF/MLy6sJbjPdsWitHO+96C9JFUDiBniyPYPAqgb3oczceoCvBeorg==
X-Received: by 2002:a2e:8715:: with SMTP id m21-v6mr53472lji.2.1538075557471;
        Thu, 27 Sep 2018 12:12:37 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id r79-v6sm561673ljb.84.2018.09.27.12.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 12:12:36 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 0/4] git-commit-graph.txt: various cleanups
Date:   Thu, 27 Sep 2018 21:12:18 +0200
Message-Id: <cover.1538075326.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.19.0.216.g2d3b1c576c
In-Reply-To: <6b1cb43e-a1a8-921f-cd66-3697609854e0@gmail.com>
References: <6b1cb43e-a1a8-921f-cd66-3697609854e0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v2 starts with the same two patches as v1 did, then goes on to
change "[commit] graph file" to "commit-graph file" with a dash, to
match other instances as well as Derrick's feedback.

Martin Ågren (4):
  git-commit-graph.txt: fix bullet lists
  git-commit-graph.txt: typeset more in monospace
  git-commit-graph.txt: refer to "*commit*-graph file"
  Doc: refer to the "commit-graph file" with dash

 Documentation/git-commit-graph.txt       | 31 ++++++++++++------------
 Documentation/technical/commit-graph.txt |  8 +++---
 2 files changed, 20 insertions(+), 19 deletions(-)

Range-diff against v1:
1:  222721870b = 1:  837ef2f231 git-commit-graph.txt: fix bullet lists
2:  acac5c3584 = 2:  9759a162ca git-commit-graph.txt: typeset more in monospace
3:  65f42c947a ! 3:  759bc886d8 git-commit-graph.txt: refer to "*commit* graph file"
    @@ -1,17 +1,17 @@
     Author: Martin Ågren <martin.agren@gmail.com>
     
    -    git-commit-graph.txt: refer to "*commit* graph file"
    +    git-commit-graph.txt: refer to "*commit*-graph file"
     
    -    This document sometimes refers to the "commit graph file" as just "the
    +    This document sometimes refers to the "commit-graph file" as just "the
         graph file". This saves a couple of words here and there at the risk of
         confusion. In particular, the documentation for `git commit-graph read`
         appears to suggest that there are indeed different types of graph files.
     
         Let's just write out the full name everywhere.
     
    -    The full name, by the way, is not the "commit-graph file" with a dash,
    -    cf. the synopsis. Use the dashless form. (The next commit will fix the
    -    remaining few instances of the "commit-graph file" in this document.)
    +    The full name, by the way, is not the dash-less "commit graph file".
    +    Use the dashed form. (The next commit will fix the remaining few
    +    instances of the "commit graph file" in this document.)
     
         Signed-off-by: Martin Ågren <martin.agren@gmail.com>
     
    @@ -24,7 +24,7 @@
      
     -Read a graph file given by the commit-graph file and output basic
     -details about the graph file. Used for debugging purposes.
    -+Read the commit graph file and output basic details about it.
    ++Read the commit-graph file and output basic details about it.
     +Used for debugging purposes.
      
      'verify'::
    @@ -35,7 +35,7 @@
      
     -* Write a graph file, extending the current graph file using commits
     -  in `<pack-index>`.
    -+* Write a commit graph file, extending the current commit graph file
    ++* Write a commit-graph file, extending the current commit-graph file
     +  using commits in `<pack-index>`.
      +
      ------------------------------------------------
    @@ -43,16 +43,14 @@
      ------------------------------------------------
      
     -* Write a graph file containing all reachable commits.
    -+* Write a commit graph file containing all reachable commits.
    ++* Write a commit-graph file containing all reachable commits.
      +
      ------------------------------------------------
      $ git show-ref -s | git commit-graph write --stdin-commits
      ------------------------------------------------
      
     -* Write a graph file containing all commits in the current
    --  commit-graph file along with those reachable from `HEAD`.
    -+* Write a commit graph file containing all commits in the current
    -+  commit graph file along with those reachable from `HEAD`.
    ++* Write a commit-graph file containing all commits in the current
    +   commit-graph file along with those reachable from `HEAD`.
      +
      ------------------------------------------------
    - $ git rev-parse HEAD | git commit-graph write --stdin-commits --append
4:  fc81147ea4 < -:  ---------- git-commit-graph.txt: refer to the "commit graph file" without dash
-:  ---------- > 4:  99b64287ec Doc: refer to the "commit-graph file" with dash
-- 
2.19.0.216.g2d3b1c576c

