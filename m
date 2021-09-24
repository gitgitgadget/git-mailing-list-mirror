Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C735AC433FE
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 23:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABE52604DB
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 23:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245016AbhIXXzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 19:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbhIXXzG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 19:55:06 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FB6C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 16:53:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w29so31987876wra.8
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 16:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7X2vP95Nrih2/ZYF5MeQkFO3N7Ybz8M6MMt6amHXYUA=;
        b=RHXLDyCHpMx9ls3U4mHL1tguKOjEy1+9EkKRD/mmBMb73vKPIijCvXj46ooeAn2G3V
         NZdsuqdSp1G7fF+rl1dt2ZlMXRJkC5GZYFgJ1Jjb3ymk5M1Mr9x8vB+zQHtWTsJQZoBC
         GURXkxQkC2SKUJea+AH5v99fjmKO6KA06IniXiHZlj/vNDOzal13psDHBm41rnXyfEHw
         g0L+ycwL0nCkOLdtbGbH/9sYjL+Cyh823aK3/iBjpF9Hr90MrbZye7kMsWp3IFuhvWit
         GYAcGR0vQcxRGSq8XQubnVde+Eycu3phDOuVWAE5Il1C1zY2+uMBlatXhAG53M+pljFe
         nY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7X2vP95Nrih2/ZYF5MeQkFO3N7Ybz8M6MMt6amHXYUA=;
        b=P0H+jbUtMli/z39DfH9LDteQdAu6WhLKBvAFmIwu7LEvt8RAaSOtU2pxVPMn0ClpXf
         kihmDDy9btEqFJabvo6hRW0/6GTRD6rfckqbnNk39A1b4houV0WfedqOzfoNjDh1Qznn
         6tYHt+GPFT71x5l2l57CTztVtfc0SPfSNXjROVvI1rfzG5eYVO/sxjCllhNWuV2yV8xN
         Z+5HWsCBDIXZW+UrIadPzQZwxXd8DzYpnV90oymT9HJcyNTNa04dvP9VKtdGRvrhw9lf
         6iH+cO53+0tr3Y9dpO3Cl62/RXNaNNlJG7LiavZBf0MGVo8P5g62sHlb8fZTIFdQCk1y
         i3qQ==
X-Gm-Message-State: AOAM5335rI9Rf1s2IzObD+7do1v+jFyFA0YlN4TTByaNyV85FWrSZyd1
        BnUDNy+auhLB0tIrCsfLJnxYUcYeGps=
X-Google-Smtp-Source: ABdhPJxlt/wqHSlmlfmyzwcw8nX+DpZCJt6zMsN2teAVy20a4WhAtIFK7oN0BKzRqCiOQcLcEMNKmw==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr4541087wmj.33.1632527611373;
        Fri, 24 Sep 2021 16:53:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18sm11212363wmq.23.2021.09.24.16.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 16:53:31 -0700 (PDT)
Message-Id: <ebba65e040cfa0b9d157e0dc383a6213c81f1943.1632527609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
References: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
        <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 23:53:23 +0000
Subject: [PATCH v6 2/8] bulk-checkin: rename 'state' variable and separate
 'plugged' boolean
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Preparation for adding bulk-fsync to the bulk-checkin.c infrastructure.

* Rename 'state' variable to 'bulk_checkin_state', since we will later
  be adding 'bulk_fsync_state'.  This also makes the variable easier to
  find in the debugger, since the name is more unique.

* Move the 'plugged' data member of 'bulk_checkin_state' into a separate
  static variable. Doing this avoids resetting the variable in
  finish_bulk_checkin when zeroing the 'bulk_checkin_state'. As-is, we
  seem to unintentionally disable the plugging functionality the first
  time a new packfile must be created due to packfile size limits. While
  disabling the plugging state only results in suboptimal behavior for
  the current code, it would be fatal for the bulk-fsync functionality
  later in this patch series.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 bulk-checkin.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index b023d9959aa..f117d62c908 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -10,9 +10,9 @@
 #include "packfile.h"
 #include "object-store.h"
 
-static struct bulk_checkin_state {
-	unsigned plugged:1;
+static int bulk_checkin_plugged;
 
+static struct bulk_checkin_state {
 	char *pack_tmp_name;
 	struct hashfile *f;
 	off_t offset;
@@ -21,7 +21,7 @@ static struct bulk_checkin_state {
 	struct pack_idx_entry **written;
 	uint32_t alloc_written;
 	uint32_t nr_written;
-} state;
+} bulk_checkin_state;
 
 static void finish_bulk_checkin(struct bulk_checkin_state *state)
 {
@@ -260,21 +260,23 @@ int index_bulk_checkin(struct object_id *oid,
 		       int fd, size_t size, enum object_type type,
 		       const char *path, unsigned flags)
 {
-	int status = deflate_to_pack(&state, oid, fd, size, type,
+	int status = deflate_to_pack(&bulk_checkin_state, oid, fd, size, type,
 				     path, flags);
-	if (!state.plugged)
-		finish_bulk_checkin(&state);
+	if (!bulk_checkin_plugged)
+		finish_bulk_checkin(&bulk_checkin_state);
 	return status;
 }
 
 void plug_bulk_checkin(void)
 {
-	state.plugged = 1;
+	assert(!bulk_checkin_plugged);
+	bulk_checkin_plugged = 1;
 }
 
 void unplug_bulk_checkin(void)
 {
-	state.plugged = 0;
-	if (state.f)
-		finish_bulk_checkin(&state);
+	assert(bulk_checkin_plugged);
+	bulk_checkin_plugged = 0;
+	if (bulk_checkin_state.f)
+		finish_bulk_checkin(&bulk_checkin_state);
 }
-- 
gitgitgadget

