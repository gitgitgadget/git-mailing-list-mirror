Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974B9C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 00:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiC2AoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 20:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiC2AoV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 20:44:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B142237FFF
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w21so18045255wra.2
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W9Vimte0sGyR2DMe0rSIsRe6vitxNiJv2vsesuc0ht0=;
        b=cd9jXdNIiJZFsZrT8zBQkwPGEoD8Ot2VIXq+u8ggdG4+5XE3g6AhCtYdO9a8Zp3RFf
         2XIgegBTuQLJB/b6hza8CRQCkb1+xPZ379I4PEHGrymYjXnvRShoDY9+iUYkeRE+2k03
         NSUU3xc83q7uXX+n+XI3BJ2yT8CjKHY/HJ/cKKMbHhrEI5QSgNfygS2oXW/ogpdsq/h4
         Qvg63RGon184At10ad6L5M4lHHMmGULu0OIaezj/dfx+aloo/+3SJy1JkM8US89iADbT
         uPn7IJOhcpRNMpBeMC7NcsX4EpcFQPd97Zk0oHRS/+9orqm42z0SRpiRhNcCzW7pnHfr
         xaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W9Vimte0sGyR2DMe0rSIsRe6vitxNiJv2vsesuc0ht0=;
        b=dRQmYGwQYIPeFWhJH0kv4pKIJi4xUUFyKGS9WGF/7lY+8jtBUYZgWj0eLTJvVuSC+3
         L/oQTqsjhXxc+syyGKxmDtXBFZke7UaO0UsuNrtEv+m2y+ohrAZbX1pGNL13oN5KE3uA
         0oyKZ437Tpru9IdkRT7ryZPE2ngEF7k3Xhnk1uhqfj98fw+1y4BOaJS/ljZVoA4t8lZK
         se0vsDSyNrV8tg4hA498IQNudclFWPr/yVOS5hnWv1JzKki6WBKdk/a9yAuOpcoWZw02
         r/UQWadttzs/5HG1gYuBrzEeH6EqCRMKny6amamLqr8JmB9uKB9SS5udG9Mi+1KfiyG0
         UMWQ==
X-Gm-Message-State: AOAM530qpqIWyBwBED3oepGGTgFBFjhUHdzEoGLfwoSyGL+4GHhxGJRv
        SLb0PQZPIhHoaDqRPUe3dibzNo1b6zo=
X-Google-Smtp-Source: ABdhPJwHmuhrU2P2nmApNe7aidNS12Dm7X+VlzLrJcA9SshRb1JyLOVJqv4MIXTFG6A6F97lGCQrFA==
X-Received: by 2002:adf:ed82:0:b0:205:9cf1:20fe with SMTP id c2-20020adfed82000000b002059cf120femr23663348wro.660.1648514557509;
        Mon, 28 Mar 2022 17:42:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r65-20020a1c4444000000b0038c48dd23b9sm1120847wma.5.2022.03.28.17.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 17:42:37 -0700 (PDT)
Message-Id: <2d1bc4568ac744f11c886a5f964dbe563c04ce8b.1648514553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
        <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 00:42:20 +0000
Subject: [PATCH v4 03/13] object-file: pass filename to fsync_or_die
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

If we die while trying to fsync a loose object file, pass the actual
filename we're trying to sync. This is likely to be more helpful for a
user trying to diagnose the cause of the failure than the former
'loose object file' string. It also sidesteps any concerns about
translating the die message differently for loose objects versus
something else that has a real path.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 object-file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index b254bc50d70..5ffbf3d4fd4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1888,16 +1888,16 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 }
 
 /* Finalize a file on disk, and close it. */
-static void close_loose_object(int fd)
+static void close_loose_object(int fd, const char *filename)
 {
 	if (the_repository->objects->odb->will_destroy)
 		goto out;
 
 	if (fsync_object_files > 0)
-		fsync_or_die(fd, "loose object file");
+		fsync_or_die(fd, filename);
 	else
 		fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd,
-				       "loose object file");
+				       filename);
 
 out:
 	if (close(fd) != 0)
@@ -2011,7 +2011,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
-	close_loose_object(fd);
+	close_loose_object(fd, tmp_file.buf);
 
 	if (mtime) {
 		struct utimbuf utb;
-- 
gitgitgadget

