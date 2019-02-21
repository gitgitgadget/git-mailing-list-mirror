Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F6001F462
	for <e@80x24.org>; Thu, 21 Feb 2019 11:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfBULQe (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:16:34 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:33664 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfBULQd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 06:16:33 -0500
Received: by mail-pl1-f179.google.com with SMTP id y10so14046021plp.0
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 03:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1WnNWV66qXQ/ybTACmVFwa5+1IM89xL+iYcA/HmrdY8=;
        b=BR2jPUwoIchb94rZ3Y6KBgLvuVPCMpTr+u9HX1TkjzAehBFkrvS4QIOIGBnwCIG/v+
         Efg69W50sCCgch50eXiCoTinwSs9gEwSvmMGH3Dl8WzQTUHHrD/v/d0OgWNR07AYs3DH
         pUZt/Giv3iE3n17G0qS0Spfl3t6ccN/rkTTGiZKh+XVyNYHnK+0Jx7cW2z4xk7uKe8TN
         rOpuJui2rjItHWRsOvGeuuQ430XeGL5BLvl9Q2EU8UQyBtPgbr1rNckP/6GOkPpkVl8h
         9vBU/71wKJaksFQTfIb3rjU4d6go0QiuOIeTXYZ1pUV0gX5JN/OV65rdrayY+G2Tyr7m
         kxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1WnNWV66qXQ/ybTACmVFwa5+1IM89xL+iYcA/HmrdY8=;
        b=FIAmbocfU95Re1lXWSMPxFln0CvYJ8XPESb7tjKROkRAdXrE4KIbmio1AyTK8lF8sG
         yhL1Sx6ovM1kqbk2ggqE+kapzlzXjD++HRy+W6lLPTLNwkxRU6G2R3MB8hYZvG/QNvHu
         07ani6q9kfJPTZ5KQmMiaQRvdEkrH8se5kgeo5tpIey6LYrCPMAbtQZv1s/lWaoJR/93
         HRJLdHTuXR3mB6/L7guDa2OohPOxzvhQr+vMBfFVynUobZc0cPUqDNHWrgQromuSxRF/
         naPYTux7dS1SqK8AcMmTbLjs3ANkRHINfv+K4Bn0ctoaLpFBeou1obWpXni7nOoiJoPa
         YsWw==
X-Gm-Message-State: AHQUAuYEqUwhpsS6bna98l3J7jPQrmk4ZA5VlDwTLZt0plJkkEBNJmqE
        KfroLF9hKusT1nqZA0ccqbYb0a5m
X-Google-Smtp-Source: AHgI3IYYlH8aZmaNXaYw68FmRXuIslSHfAa4Boy1cr/ma3EO6dUWBgIOM2syN3R+d7lHczuT78OLgg==
X-Received: by 2002:a17:902:284b:: with SMTP id e69mr1185445plb.11.1550747792389;
        Thu, 21 Feb 2019 03:16:32 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id q62sm20844202pfi.183.2019.02.21.03.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 03:16:31 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 21 Feb 2019 18:16:27 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, rybak.a.v@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 00/21] nd/diff-parseopt-2 updates
Date:   Thu, 21 Feb 2019 18:16:00 +0700
Message-Id: <20190221111621.27180-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190216113655.25728-1-pclouds@gmail.com>
References: <20190216113655.25728-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Super tiny document update noticed by Andrei.

Range-diff dựa trên v3:
 1:  38230c7de4 !  1:  070164af4d diff-parseopt: convert --dirstat and friends
    @@ -3,7 +3,6 @@
         diff-parseopt: convert --dirstat and friends
     
         Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
      --- a/Documentation/diff-options.txt
    @@ -12,7 +11,7 @@
      	number of modified files, as well as number of added and deleted
      	lines.
      
    -+-X<param1,param2,...>::
    ++-X[<param1,param2,...>]::
      --dirstat[=<param1,param2,...>]::
      	Output the distribution of relative amount of changes for each
      	sub-directory. The behavior of `--dirstat` can be customized by
 2:  3ae4e6cd92 =  2:  89b1103e76 diff-parseopt: convert --check
 3:  127056f59c =  3:  fedf018125 diff-parseopt: convert --summary
 4:  f6329c8d41 =  4:  13cb7ab220 diff-parseopt: convert --patch-with-stat
 5:  aec0afbe0d =  5:  f1aad0dd16 diff-parseopt: convert --name-only
 6:  bcbeaf3792 =  6:  69724a34d5 diff-parseopt: convert --name-status
 7:  23a9f378ed =  7:  6d388db7ae diff-parseopt: convert -s|--no-patch
 8:  3376918b02 =  8:  c378c333fe diff-parseopt: convert --stat*
 9:  6bc89cece3 =  9:  089d37bc74 diff-parseopt: convert --[no-]compact-summary
10:  327e4ce71d = 10:  36731a8c60 diff-parseopt: convert --output-*
11:  a7fd8b2637 = 11:  c043243fac diff-parseopt: convert -B|--break-rewrites
12:  abe34ced9b = 12:  52da05a2fe diff-parseopt: convert -M|--find-renames
13:  27a03cf277 = 13:  4fe9111123 diff-parseopt: convert -D|--irreversible-delete
14:  d0e744740a = 14:  b85e3bb302 diff-parseopt: convert -C|--find-copies
15:  71d80976eb = 15:  bd7f8fe4ae diff-parseopt: convert --find-copies-harder
16:  e066d3b245 = 16:  ed3b271d82 diff-parseopt: convert --no-renames|--[no--rename-empty
17:  f35c5d409d = 17:  6bebd80fee diff-parseopt: convert --relative
18:  a560fa8cd6 = 18:  a6ae538b90 diff-parseopt: convert --[no-]minimal
19:  97c424c1ce = 19:  ed3634e0bd diff-parseopt: convert --ignore-some-changes

Nguyễn Thái Ngọc Duy (21):
  diff-parseopt: convert --patch-with-raw
  diff-parseopt: convert --numstat and --shortstat
  diff-parseopt: convert --dirstat and friends
  diff-parseopt: convert --check
  diff-parseopt: convert --summary
  diff-parseopt: convert --patch-with-stat
  diff-parseopt: convert --name-only
  diff-parseopt: convert --name-status
  diff-parseopt: convert -s|--no-patch
  diff-parseopt: convert --stat*
  diff-parseopt: convert --[no-]compact-summary
  diff-parseopt: convert --output-*
  diff-parseopt: convert -B|--break-rewrites
  diff-parseopt: convert -M|--find-renames
  diff-parseopt: convert -D|--irreversible-delete
  diff-parseopt: convert -C|--find-copies
  diff-parseopt: convert --find-copies-harder
  diff-parseopt: convert --no-renames|--[no--rename-empty
  diff-parseopt: convert --relative
  diff-parseopt: convert --[no-]minimal
  diff-parseopt: convert --ignore-some-changes

 Documentation/diff-options.txt |  20 ++
 diff.c                         | 510 +++++++++++++++++++--------------
 2 files changed, 319 insertions(+), 211 deletions(-)

-- 
2.21.0.rc1.337.gdf7f8d0522

