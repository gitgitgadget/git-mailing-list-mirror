Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C94332055E
	for <e@80x24.org>; Wed,  1 Nov 2017 08:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754305AbdKAIS6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 04:18:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51195 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754230AbdKAISy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 04:18:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id s66so3197233wmf.5
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 01:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8/NE8oX8qktufOiHCQ+IuCCOGMD/TbxQGgCaAo4QArg=;
        b=tC4eXjGKGJQxKn9xaKjb1TEvVTtAX0ukLiVvyE1oIMLTX7AEQJ+wJZbcfenWd6FfMP
         cppylZcnZNK1G4BH0t3gQorGQWgzMbTJyddr4qFHnjM4qqhwtDO5jcypm9NDtri6xTI9
         f6TZAyoV7BbJCj8l0ag1uu4h/ZRcVbS40+rrhKiq4BZyQdpL6G6sIOdy2FZgArS/sy1V
         0ysBLChiKV0u6gLdBhwmzOUW93PQmtGj2V6LXvRB0R3nHBl2SkOcE5qg/KrhLXXEvfqu
         HdqtoFMdPSOLmaw4jzqerWCofozrj2DbFxs6jv8uC9u709IrZoIB/8gTG9xVNi9jZN2I
         FgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8/NE8oX8qktufOiHCQ+IuCCOGMD/TbxQGgCaAo4QArg=;
        b=gbNbSxygec9QTbPWcNJ89WU+EoKky+T33CSGKuRFz0kdiNEbXaa/QwizUsfM4nOvGF
         wroohmFjgb+mugmlk4h534tCC+PMYxFupddh86tSEQ+KE1S15fixVIZYzBEDjlhJHNyV
         cFsqrcbqcZAZ0G3ZGAkiPgiES4Jz7h7rDqEnqLVLIopqamj1gzJ2HCN72jPIk+R/C+BZ
         8EN9nQ9eewR9VjSxQEhXYOMLsZEVI4+wCXB4hXwRf4iiiZ2gJV69Iv+e6x7A3JdoEnnW
         EKUvwNlFP5KG+loEINE5FsyhSooisY/LwL/QlpM0Nw52czS4XQd1gRJjI3sn7S94Ure/
         cb0A==
X-Gm-Message-State: AMCzsaVLGRDnnl/X9gZM5YhG+Smu2LGKoUHWH1BoyoW0HN6gv7/dVerz
        z9ViYlMKOMDX8cPN61NTC48=
X-Google-Smtp-Source: ABhQp+QvFH02f0rP8FQfN2EpQ/PjLb75WrmpIUOws0k3AIn3qMHTWRXz5TPY7/JHw7soWODHNOq9AA==
X-Received: by 10.28.103.4 with SMTP id b4mr4459199wmc.70.1509524332563;
        Wed, 01 Nov 2017 01:18:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id p128sm204522wmb.1.2017.11.01.01.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Nov 2017 01:18:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/7] refs: tidy up and adjust visibility of the `ref_update` flags
Date:   Wed,  1 Nov 2017 09:18:08 +0100
Message-Id: <20171101081808.5962-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.415.gac1375d7e
In-Reply-To: <da4974c47a7fd72e41513218e0c824d4d6377b8c.1509183413.git.mhagger@alum.mit.edu>
References: <da4974c47a7fd72e41513218e0c824d4d6377b8c.1509183413.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28 October 2017 at 11:49, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> The constants used for `ref_update::flags` were rather disorganized:

> * The documentation wasn't very consistent and partly still referred
>   to sha1s rather than oids.

> @@ -478,22 +462,23 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>   *
>   *     refname -- the name of the reference to be affected.
>   *
> - *     new_sha1 -- the SHA-1 that should be set to be the new value of
> + *     new_oid -- the SHA-1 that should be set to be the new value of
>   *         the reference. Some functions allow this parameter to be
>   *         NULL, meaning that the reference is not changed, or
> - *         null_sha1, meaning that the reference should be deleted. A
> + *         null_oid, meaning that the reference should be deleted. A
>   *         copy of this value is made in the transaction.
>   *
> - *     old_sha1 -- the SHA-1 value that the reference must have before
> + *     old_oid -- the SHA-1 value that the reference must have before

You still refer to "SHA-1" twice in this hunk. Maybe squash this in, at
least partially? This addresses all remaining "sha"/"SHA" in refs.h.

Martin

-- >8 --
diff --git a/refs.h b/refs.h
index f0958e5bf..18582a408 100644
--- a/refs.h
+++ b/refs.h
@@ -126,7 +126,7 @@ int peel_ref(const char *refname, struct object_id *oid);
 /**
  * Resolve refname in the nested "gitlink" repository in the specified
  * submodule (which must be non-NULL). If the resolution is
- * successful, return 0 and set sha1 to the name of the object;
+ * successful, return 0 and set oid to the name of the object;
  * otherwise, return a non-zero value.
  */
 int resolve_gitlink_ref(const char *submodule, const char *refname,
@@ -260,7 +260,7 @@ struct ref_transaction;
 
 /*
  * The signature for the callback function for the for_each_*()
- * functions below.  The memory pointed to by the refname and sha1
+ * functions below.  The memory pointed to by the refname and oid
  * arguments is only guaranteed to be valid for the duration of a
  * single callback invocation.
  */
@@ -354,7 +354,7 @@ int reflog_exists(const char *refname);
 
 /*
  * Delete the specified reference. If old_oid is non-NULL, then
- * verify that the current value of the reference is old_sha1 before
+ * verify that the current value of the reference is old_oid before
  * deleting it. If old_oid is NULL, delete the reference if it
  * exists, regardless of its old value. It is an error for old_oid to
  * be null_oid. msg and flags are passed through to
@@ -462,13 +462,13 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  *
  *     refname -- the name of the reference to be affected.
  *
- *     new_oid -- the SHA-1 that should be set to be the new value of
- *         the reference. Some functions allow this parameter to be
+ *     new_oid -- the object ID that should be set to be the new value
+ *         of the reference. Some functions allow this parameter to be
  *         NULL, meaning that the reference is not changed, or
  *         null_oid, meaning that the reference should be deleted. A
  *         copy of this value is made in the transaction.
  *
- *     old_oid -- the SHA-1 value that the reference must have before
+ *     old_oid -- the object ID that the reference must have before
  *         the update. Some functions allow this parameter to be NULL,
  *         meaning that the old value of the reference is not checked,
  *         or null_oid, meaning that the reference must not exist
@@ -633,7 +633,7 @@ int ref_transaction_abort(struct ref_transaction *transaction,
  * It is a bug to call this function when there might be other
  * processes accessing the repository or if there are existing
  * references that might conflict with the ones being created. All
- * old_sha1 values must either be absent or NULL_SHA1.
+ * old_oid values must either be absent or null_oid.
  */
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err);
-- 
2.15.0.415.gac1375d7e

