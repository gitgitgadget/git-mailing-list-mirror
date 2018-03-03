Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152671F576
	for <e@80x24.org>; Sat,  3 Mar 2018 11:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeCCLjk (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 06:39:40 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43504 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbeCCLjg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 06:39:36 -0500
Received: by mail-pl0-f66.google.com with SMTP id f23-v6so7189416plr.10
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 03:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LnKgr1/hTZCcbnDukbVYRKdemCg0ERWN6BmKx0lRo00=;
        b=n94kHbIJHa2+7TIfbZSUxhVlIh4l/tuuvaiLnzJaf+hoUG06ClN4qrYz6JH06rqzGj
         9Zn7hn1NGUfcLacIk3UJ6Gx7koMdIAa2E3998Bv0sK1X77x3fYzHWzVBBJPNXax72iec
         HZYgVf6ewzFdNUA++TvjBe4CZJX20gmrd62ZxLDkD1XztM3g6aWdxiycfebO23pXkTWW
         vSn85PZxUlW/3D4MjW8Rs2Ggtm4KNdmZDoZtVhK2PQJDB263OIB6LH1lomqdhqGEwJHN
         u5fZbMl3BGXloovDkyS6C8dzrM9Fhoj4XMVZ3PP8hrCqg1CbQjZ8dwPVbpnGLcUzh57C
         fMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LnKgr1/hTZCcbnDukbVYRKdemCg0ERWN6BmKx0lRo00=;
        b=C0DoJ27lHUoumv2WaaaHKOsacZn1YXR2lZvDVBsbo76axZpfBM6PW3TRmMfkT9ZZGR
         YOyHnhwZLIe7xcBn9IQlK+Hc905XHAE1rVgU79iHrTX0IOGHUJHBczt+q6VcNd58eXRL
         2FpIB1/n4qlXwv266KfDhw7zCd7bBbBL+zr81gdwOQVkSYWbmaromdReBac8VkOvww3A
         89g7phIqXcTYxfQVNbo3w0YidwVdDQE5VgUNFrr0e9o3LXy9pKClvrbsd6inPSfaXiDn
         HmccAKN/GpAf0T3SzBr+G+sxFhV+SLS6qdBNY0Hx3eY7C+kT88pO5P++umCIeiVQrvi2
         EZJA==
X-Gm-Message-State: APf1xPA8NiWhLgJlsNj4yq3Xs21ZWIOdjfr7AYgYxzdHBAaRPxftDZMN
        GVOXCIv1plHx0yBKQkASPhq0Jg==
X-Google-Smtp-Source: AG47ELu1c7wu+sudIUBrnT2goJS9l5kxzTTmp+96nCQyxgMiPf7TEsKbznOUxrs7wNBq31m7Z3wAlw==
X-Received: by 2002:a17:902:bc41:: with SMTP id t1-v6mr8070094plz.436.1520077175446;
        Sat, 03 Mar 2018 03:39:35 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id f82sm20127699pfd.175.2018.03.03.03.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Mar 2018 03:39:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 18:39:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 34/44] packfile: allow rearrange_packed_git to handle arbitrary repositories
Date:   Sat,  3 Mar 2018 18:36:27 +0700
Message-Id: <20180303113637.26518-35-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 packfile.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 0eaf5ee100..5356712717 100644
--- a/packfile.c
+++ b/packfile.c
@@ -865,10 +865,10 @@ static int sort_pack(const void *a_, const void *b_)
 	return -1;
 }
 
-static void rearrange_packed_git(void)
+static void rearrange_packed_git(struct repository *r)
 {
-	the_repository->objects.packed_git = llist_mergesort(
-		the_repository->objects.packed_git, get_next_packed_git,
+	r->objects.packed_git = llist_mergesort(
+		r->objects.packed_git, get_next_packed_git,
 		set_next_packed_git, sort_pack);
 }
 
@@ -892,7 +892,7 @@ void prepare_packed_git(void)
 	prepare_alt_odb(the_repository);
 	for (alt = the_repository->objects.alt_odb_list; alt; alt = alt->next)
 		prepare_packed_git_one(alt->path, 0);
-	rearrange_packed_git();
+	rearrange_packed_git(the_repository);
 	prepare_packed_git_mru(the_repository);
 	the_repository->objects.packed_git_initialized = 1;
 }
-- 
2.16.1.435.g8f24da2e1a

