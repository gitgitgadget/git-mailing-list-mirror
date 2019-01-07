Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39EF01F803
	for <e@80x24.org>; Mon,  7 Jan 2019 19:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfAGT3Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 14:29:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55220 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfAGT3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 14:29:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so1931630wmh.4
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 11:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=w+duDI0jWIECrtpWsFWC3f70GX6328mlM2rCPfyL/eY=;
        b=ZUam0dTCSvSJPbGf2sBxZFLQ1acLdSenJnkYJFZhfFxraq3Nf+3o2jDDyOy0gZ8RmI
         ZkSlTHclp7qdmhOml0Lvb4KhiyaxedbeCN6CLTNHBSN9gqizKYCkx1Ad+1l0+cACqCj+
         MqhLuPYyMOh0dWjM0elZ7c7XHgHmNvc52wstJ7m3Aeq07CN07rEvjXIUDq+1c9Yzdh6O
         z0m4PYYAMFIH/txdfmHRV4S0YPhh4xoOaiBuDGqjcUA8MMuLUrHnZvfgaz9kSB2bmX3/
         UCDxl0/pM3+1iW0QU37ckhscOR/gt2vj7T7lz5Dy7XbTlzIaY0An+JN9u4rqJWw0xpuq
         88XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=w+duDI0jWIECrtpWsFWC3f70GX6328mlM2rCPfyL/eY=;
        b=eaDi0XVvc2vfwMj43TRmO/yeFUSOsiIuLiXvPDT0qlDW8a3lFysYid9Q/+X/gflHuc
         alhM06gwOxAYnbLLbYenm+nP5sqU4U9oXEJ4FVHzVn6VOCVfsGhVlfUOf0TMV9OWHRWQ
         yhG2Z3QPArnYvtLhDsIb2Pz3kr5C7q+LvvalaJ8RDG33KDvBex6Pa+AeBYvDGQ4cTMBG
         RHzweQiF/jfc55R09evE40BMEdd9zTVexJE/+fWjihPTeXHxpAFHTIYXElQUSDZyL14A
         KtQRbgNWsFBFCwVhn4uV9jAUehDXwdFWPu7cH2BgUIvJNR+JSAMHBZVKQZQza2lh51eV
         nHdw==
X-Gm-Message-State: AJcUuke9ECjhxcj+iWySfmRsfHcrudSUn0iEz8xu5TpIyBBnn1HkrSVH
        NAHtvJ5OmdK1D9EYyMuwdSk=
X-Google-Smtp-Source: ALg8bN6z4xLpscZmBWe2qEoV6sEm9h1hbUSv0t8GviR3dUt64yVmEt7afs8rFFGy1UuPRsugfiHrzw==
X-Received: by 2002:a7b:c852:: with SMTP id c18mr9108662wml.49.1546889362135;
        Mon, 07 Jan 2019 11:29:22 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 129sm9704913wmd.18.2019.01.07.11.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 11:29:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: jk/loose-object-cache
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
        <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
Date:   Mon, 07 Jan 2019 11:29:20 -0800
In-Reply-To: <3512c798-aa42-6fba-ee82-d33a8985be91@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 6 Jan 2019 17:39:14 +0100")
Message-ID: <xmqqo98s8dwv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 28.12.2018 um 19:04 schrieb Junio C Hamano:
>> * jk/loose-object-cache (2018-11-24) 10 commits
> ...
> So this has hit master in the meantime.  We discussed a sort performance
> fix in [1]; I'll reply with a short series containing a cleaned-up and
> rebased version as a follow-up.

Thanks.

-- >8 --
Subject: [PATCH 4/3] sha1-file.c: make odb_load_loose_cache() static

Now there is only a single internal caller to this helper function
that knows the implementation detail of the cache too much, hide it
from outside world by making it static.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object-store.h |  7 -------
 sha1-file.c    | 24 +++++++++++++++---------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/object-store.h b/object-store.h
index 2fb6c0e4db..e16aa38cae 100644
--- a/object-store.h
+++ b/object-store.h
@@ -47,13 +47,6 @@ void add_to_alternates_file(const char *dir);
  */
 void add_to_alternates_memory(const char *dir);
 
-/*
- * Populate an odb's loose object cache for one particular subdirectory (i.e.,
- * the one that corresponds to the first byte of objects you're interested in,
- * from 0 to 255 inclusive).
- */
-void odb_load_loose_cache(struct object_directory *odb, int subdir_nr);
-
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
diff --git a/sha1-file.c b/sha1-file.c
index 2adc56cde4..936d216ad4 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -2150,15 +2150,12 @@ static int append_loose_object(const struct object_id *oid, const char *path,
 	return 0;
 }
 
-struct oid_array *odb_loose_cache(struct object_directory *odb,
-				  const struct object_id *oid)
-{
-	int subdir_nr = oid->hash[0];
-	odb_load_loose_cache(odb, subdir_nr);
-	return &odb->loose_objects_cache[subdir_nr];
-}
-
-void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
+/*
+ * Populate an odb's loose object cache for one particular subdirectory (i.e.,
+ * the one that corresponds to the first byte of objects you're interested in,
+ * from 0 to 255 inclusive).
+ */
+static void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
 {
 	struct strbuf buf = STRBUF_INIT;
 
@@ -2178,6 +2175,15 @@ void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)
 	strbuf_release(&buf);
 }
 
+struct oid_array *odb_loose_cache(struct object_directory *odb,
+				  const struct object_id *oid)
+{
+	int subdir_nr = oid->hash[0];
+	odb_load_loose_cache(odb, subdir_nr);
+	return &odb->loose_objects_cache[subdir_nr];
+}
+
+
 void odb_clear_loose_cache(struct object_directory *odb)
 {
 	int i;
