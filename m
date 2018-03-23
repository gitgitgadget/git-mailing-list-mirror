Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B243C1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeCWRpn (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:45:43 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37196 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbeCWRpm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:45:42 -0400
Received: by mail-lf0-f68.google.com with SMTP id m16-v6so15742709lfc.4
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kBOXfS2hWuuUvO43Ve8oqMVcJk6mKELQdB81IRMeGRI=;
        b=E2DZQKxXtp0sol6sBRH1mEsKvoeHrewRy3c2dmPbLkjzLZcmMLx+RjRPvY/1bXxtyd
         mNKX2SOhhL8Fx8GuwK9cmHkSUERjjTjmgNINm/L/K/2WqDnwTjyeCwBGPDkAx3klk0k8
         qw47oGs31w0PO3qykKFoijF5S+sh6R+CojQ9gv9mlgI3LrztnHsOLG01lHVdnzNVxZqQ
         h/M2N08dkMnpYbrvB3glxty505Utpgs5iIQd7GtcPYj7vyz1c2X4OGYkRZPqriExSp20
         FaAxCXKoSJ/Hf+6+8VblR0El6iTP+ntPtNwqfwbxYrLmEr/FlLnT7f+PZeVEQE9MTiRi
         te1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kBOXfS2hWuuUvO43Ve8oqMVcJk6mKELQdB81IRMeGRI=;
        b=juACnduHP96+bK8kLQniYGvy9vaQqMT0cyYPyfpgODxgY99AJAaOszwjeGu+qNj3NE
         02reWX8fbwQUDsARPHMZvwf1p7Q2Xfp4loQSHkM1W/f94/QUDGrSYu9Pd7T1Je41bsKM
         IVixGJUIcIT20qD1aVsyjASdKM/UokIMwH6hMNVD5s4ltpJ4CRNCoXz/zJwrdmBDRGrn
         tZiwX/iCBGmwsbOmn8MonTqyEN6IFWFS+IETBIHHlKr0W4L/iKynUWDL8imTOhonNbkc
         g25UC+LvOsVxNYdfnAt5RuObIdv55tc82NReCY96fTZDuFptkzwgUc1KCHylEEQ0awHL
         /8Ag==
X-Gm-Message-State: AElRT7EwZ3dd099c6aIxi2fmaiDLqcw64lDZOB1Oeo0GApXkIiTEUFMz
        c/+PYHfP6rd6WbU87BIaX0Y=
X-Google-Smtp-Source: AG47ELvviOYdO5W6DxJl7FJDUWxxGEp/glY3DIIr+b6h4laCLLXqyG9xf+6u+5L5dEiEHGe8MCfJJg==
X-Received: by 10.46.2.90 with SMTP id 87mr6955661ljc.46.1521827140874;
        Fri, 23 Mar 2018 10:45:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id e8sm847487ljj.6.2018.03.23.10.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:45:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 00/12] sb/packfiles-in-repository updates
Date:   Fri, 23 Mar 2018 18:45:15 +0100
Message-Id: <20180323174527.30337-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the rebased version on the updated sb/object-store I just sent
out plus the fix for get_object_directory(). The interdiff (after
rebased) looks small and nice

diff --git a/packfile.c b/packfile.c
index e02136bebb..63c89ee31a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -890,7 +890,7 @@ static void prepare_packed_git(struct repository *r)
 
 	if (r->objects->packed_git_initialized)
 		return;
-	prepare_packed_git_one(r, get_object_directory(), 1);
+	prepare_packed_git_one(r, r->objects->objectdir, 1);
 	prepare_alt_odb(r);
 	for (alt = r->objects->alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(r, alt->path, 0);

I notice there's still one get_object_directory() left in packfile.c
but that should not cause problems with converted functions. That
could be done in "phase 2".

Nguyễn Thái Ngọc Duy (1):
  packfile: keep prepare_packed_git() private

Stefan Beller (11):
  packfile: allow prepare_packed_git_mru to handle arbitrary
    repositories
  packfile: allow rearrange_packed_git to handle arbitrary repositories
  packfile: allow install_packed_git to handle arbitrary repositories
  packfile: add repository argument to prepare_packed_git_one
  packfile: add repository argument to prepare_packed_git
  packfile: add repository argument to reprepare_packed_git
  packfile: allow prepare_packed_git_one to handle arbitrary
    repositories
  packfile: allow prepare_packed_git to handle arbitrary repositories
  packfile: allow reprepare_packed_git to handle arbitrary repositories
  packfile: add repository argument to find_pack_entry
  packfile: allow find_pack_entry to handle arbitrary repositories

 builtin/count-objects.c  |  3 +-
 builtin/fsck.c           |  2 --
 builtin/gc.c             |  3 +-
 builtin/pack-objects.c   |  1 -
 builtin/pack-redundant.c |  2 --
 builtin/receive-pack.c   |  3 +-
 bulk-checkin.c           |  3 +-
 fast-import.c            |  3 +-
 fetch-pack.c             |  3 +-
 http-backend.c           |  1 -
 http.c                   |  2 +-
 pack-bitmap.c            |  1 -
 packfile.c               | 76 +++++++++++++++++++---------------------
 packfile.h               | 11 +++---
 server-info.c            |  1 -
 sha1_file.c              |  8 ++---
 sha1_name.c              |  2 --
 17 files changed, 58 insertions(+), 67 deletions(-)

-- 
2.17.0.rc0.348.gd5a49e0b6f

