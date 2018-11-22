Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB4721F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 15:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437778AbeKWCT2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 21:19:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54984 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731999AbeKWCT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 21:19:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so9426857wma.4
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 07:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IKGWhWnXjHBQSuwYSGldNyiM/4Te1V6W+5Y3Fgr+5Bg=;
        b=TeBp9r0NtS34AUT0rc5xPrbEOTGe3+NvjiIu+aGRBRV/x/HKCEoB7w8U4Nv1/8sELK
         t50bfdrTUd2MwWouz1y7zW09To4Pw/PVvRnMDUCj9EFaDfA4HeJE7Yg/qdEv62HVL3gY
         ViZp+4A2/rBhZ7UG10q2fb8Ck3dNrgJ+DfEs48hXNAqsvgNqAbJZy8S17k2CZAwtkIXg
         tEU5a4Ji1KsEdJylPzHBr14q3ywKBnHZnB/UORVEMbNrBtafhhflulvXYGfgp7nFwWQ+
         7fSzDlzRpqmxMqZAueDEeqhEgQVLjL0idpp1MllqWTuDVDkJ2K3JAFv1HBQyOPUv5dfm
         783A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IKGWhWnXjHBQSuwYSGldNyiM/4Te1V6W+5Y3Fgr+5Bg=;
        b=fktn6KrzXW1F1/gS0Gcy+6zHQgLEBokq2YBZ0M2PsbRD6RT4IZ2vTjkRQC+BLivNiq
         3v34ijr/dHkJUoLaU/5ejfyXsq95oBm92PSa65w0xOtesAtVCWRfQlCxuwsCrPyA4V5H
         02Gf0ydTcgboemOyqMPgGHMccqSH5cUWr5pH48OtR+cVzRfPDwYvvoALXLjLCmVR1FHT
         5MBOpz8iA1RjD3tCYyYm3ZlusZHc28WR6/c6H6CvFh3zCCVLUWzGLL2EMyAqlhJ2Keqk
         GVapxd7T2QieHfXM6c7wp5/qD8z7MlWCyV5pcHadqmh8IAaeuLBa0VnTJTmaPz4cWt0b
         3fhA==
X-Gm-Message-State: AGRZ1gJi09vd6Ei/nG6pA7PDB/664Z3T3VPcml/orshOuCZH1jXAe2I9
        QG5341ZMACJV3vHyxezYEobpbZi1Yhk=
X-Google-Smtp-Source: AFSGD/VmNwBRQl0DyJgFptqfbgO4ZbyCh4rHGBK/FYIl3QUi0G2t9LTlxdGozCm5dAwWPrulMjHFOA==
X-Received: by 2002:a1c:8acf:: with SMTP id m198mr9958625wmd.15.1542901172947;
        Thu, 22 Nov 2018 07:39:32 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a17sm7329389wrs.58.2018.11.22.07.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 07:39:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 00/10] commit-graph write: progress output improvements
Date:   Thu, 22 Nov 2018 15:39:12 +0000
Message-Id: <20181122153922.16912-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c
In-Reply-To: <20181122132823.9883-1-avarab@gmail.com>
References: <20181122132823.9883-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "Writing out" progress output was off-by-one because I'd screwed
up a merge conflict. Fix that, and update the various progress output.

On my test setup the "Annotating commit graph" progress sometimes
shows up on linux.git, sometimes not, it's right on that edge of
taking 1 second. So always show it in the commit message examples,
that's less confusing for the reader.

SZEDER Gábor (2):
  commit-graph: rename 'num_extra_edges' variable to 'num_large_edges'
  commit-graph: don't call write_graph_chunk_large_edges() unnecessarily

Ævar Arnfjörð Bjarmason (8):
  commit-graph write: rephrase confusing progress output
  commit-graph write: add "Writing out" progress output
  commit-graph write: more descriptive "writing out" output
  commit-graph write: show progress for object search
  commit-graph write: add more descriptive progress output
  commit-graph write: remove empty line for readability
  commit-graph write: add itermediate progress
  commit-graph write: emit a percentage for all progress

 commit-graph.c | 130 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 102 insertions(+), 28 deletions(-)

Range-diff:
1:  2b52ad2284 ! 1:  9c17f56ed3 commit-graph write: add "Writing out" progress output
     a => b | 0
     1 file changed, 0 insertions(+), 0 deletions(-)
    
    @@ -15,10 +15,11 @@
     
             $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
             Finding commits for commit graph: 6365442, done.
    +        Annotating commit graph: 2391666, done.
             Computing commit graph generation numbers: 100% (797222/797222), done.
    -        Writing out commit graph: 100% (3986110/3986110), done.
    +        Writing out commit graph: 100% (3188888/3188888), done.
     
    -    This "Writing out" number is 4x or 5x the number of commits, depending
    +    This "Writing out" number is 3x or 4x the number of commits, depending
         on the graph we're processing. A later change will make this explicit
         to the user.
     
    @@ -126,7 +127,7 @@
     +		 * below loops over our N commits. This number must be
     +		 * kept in sync with the number of passes we're doing.
     +		 */
    -+		int graph_passes = 4;
    ++		int graph_passes = 3;
     +		if (num_large_edges)
     +			graph_passes++;
     +		progress = start_delayed_progress(
2:  b1773677b1 ! 2:  79b0a467d9 commit-graph write: more descriptive "writing out" output
     a => b | 0
     1 file changed, 0 insertions(+), 0 deletions(-)
    
    @@ -3,7 +3,7 @@
         commit-graph write: more descriptive "writing out" output
     
         Make the "Writing out" part of the progress output more
    -    descriptive. Depending on the shape of the graph we either make 4 or 5
    +    descriptive. Depending on the shape of the graph we either make 3 or 4
         passes over it.
     
         Let's present this information to the user in case they're wondering
    @@ -13,8 +13,9 @@
     
             $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
             Finding commits for commit graph: 6365442, done.
    +        Annotating commit graph: 2391666, done.
             Computing commit graph generation numbers: 100% (797222/797222), done.
    -        Writing out commit graph in 5 passes: 100% (3986110/3986110), done.
    +        Writing out commit graph in 4 passes: 100% (3188888/3188888), done.
     
         A note on i18n: Why are we using the Q_() function and passing a
         number & English text for a singular which'll never be used? Because
    @@ -35,7 +36,7 @@
      	if (!commit_graph_compatible(the_repository))
      		return;
     @@
    - 		int graph_passes = 4;
    + 		int graph_passes = 3;
      		if (num_large_edges)
      			graph_passes++;
     +		strbuf_addf(&progress_title,
3:  3138b00a2c ! 3:  b32be83b38 commit-graph write: show progress for object search
     a => b | 0
     1 file changed, 0 insertions(+), 0 deletions(-)
    
    @@ -8,12 +8,12 @@
     
         Before we'd emit on e.g. linux.git with "commit-graph write":
     
    -        Finding commits for commit graph: 6365492, done.
    +        Finding commits for commit graph: 6365442, done.
             [...]
     
         And now:
     
    -        Finding commits for commit graph: 100% (6365492/6365492), done.
    +        Finding commits for commit graph: 100% (6365442/6365442), done.
             [...]
     
         Since the commit graph only includes those commits that are packed
4:  f41e3b3eb3 ! 4:  54276723c0 commit-graph write: add more descriptive progress output
     a => b | 0
     1 file changed, 0 insertions(+), 0 deletions(-)
    
    @@ -10,7 +10,7 @@
         we support:
     
             $ git commit-graph write
    -        Finding commits for commit graph among packed objects: 100% (6365492/6365492), done.
    +        Finding commits for commit graph among packed objects: 100% (6365442/6365442), done.
             [...]
     
             # Actually we don't emit this since this takes almost no time at
    @@ -20,7 +20,7 @@
             [...]
     
             $ (cd .git/objects/pack/ && ls *idx) | git commit-graph write --stdin-pack
    -        Finding commits for commit graph in 3 packs: 6365492, done.
    +        Finding commits for commit graph in 2 packs: 6365442, done.
             [...]
     
         The middle on of those is going to be the output users might see in
5:  74037032d3 = 5:  0e847366e1 commit-graph write: remove empty line for readability
     a => b | 0
     1 file changed, 0 insertions(+), 0 deletions(-)
    
6:  502da68d14 ! 6:  c388aff73e commit-graph write: add itermediate progress
     a => b | 0
     1 file changed, 0 insertions(+), 0 deletions(-)
    
    @@ -10,22 +10,22 @@
         million objects we'll now emit:
     
             $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    -        Finding commits for commit graph among packed objects: 100% (50026015/50026015), done.
    -        Annotating commit graph: 21567407, done.
    -        Counting distinct commits in commit graph: 100% (7189147/7189147), done.
    -        Finding extra edges in commit graph: 100% (7189147/7189147), done.
    -        Computing commit graph generation numbers: 100% (7144680/7144680), done.
    -        Writing out commit graph: 21434417, done.
    +        Finding commits for commit graph among packed objects: 100% (48333911/48333911), done.
    +        Annotating commit graph: 21435984, done.
    +        Counting distinct commits in commit graph: 100% (7145328/7145328), done.
    +        Finding extra edges in commit graph: 100% (7145328/7145328), done.
    +        Computing commit graph generation numbers: 100% (7145328/7145328), done.
    +        Writing out commit graph in 4 passes: 100% (28581312/28581312), done.
     
         Whereas on a medium-sized repository such as linux.git these new
         progress bars won't have time to kick in and as before and we'll still
         emit output like:
     
             $ ~/g/git/git --exec-path=$HOME/g/git commit-graph write
    -        Finding commits for commit graph among packed objects: 100% (6365492/6365492), done.
    +        Finding commits for commit graph among packed objects: 100% (6365442/6365442), done.
             Annotating commit graph: 2391666, done.
             Computing commit graph generation numbers: 100% (797222/797222), done.
    -        Writing out commit graph: 2399912, done.
    +        Writing out commit graph in 4 passes: 100% (3188888/3188888), done.
     
         The "Counting distinct commits in commit graph" phase will spend most
         of its time paused at "0/*" as we QSORT(...) the list. That's not
7:  dfaf840983 ! 7:  fd692499e0 commit-graph write: emit a percentage for all progress
     a => b | 0
     1 file changed, 0 insertions(+), 0 deletions(-)
    
    @@ -7,22 +7,13 @@
         write: add progress output", 2018-09-17) and evidently didn't notice
         how easy it was to add a completion percentage.
     
    -    Now for the very large test repository mentioned in previous commits
    -    we'll emit (shows all progress output):
    -
    -        Finding commits for commit graph among packed objects: 100% (48333911/48333911), done.
    -        Annotating commit graph: 100% (21435984/21435984), done.
    -        Counting distinct commits in commit graph: 100% (7145328/7145328), done.
    -        Finding extra edges in commit graph: 100% (7145328/7145328), done.
    -        Computing commit graph generation numbers: 100% (7145328/7145328), done.
    -        Writing out commit graph in 5 passes: 100% (35726640/35726640), done.
    -
    -    And for linux.git:
    +    Now for e.g. linux.git we'll emit:
     
    +        ~/g/git/git --exec-path=$HOME/g/git commit-graph write
             Finding commits for commit graph among packed objects: 100% (6365442/6365442), done.
             Annotating commit graph: 100% (2391666/2391666), done.
             Computing commit graph generation numbers: 100% (797222/797222), done.
    -        Writing out commit graph in 5 passes: 100% (3986110/3986110), done.
    +        Writing out commit graph in 4 passes: 100% (3188888/3188888), done.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
-- 
2.20.0.rc0.387.gc7a69e6b6c

