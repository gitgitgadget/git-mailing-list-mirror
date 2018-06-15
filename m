Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B95291F403
	for <e@80x24.org>; Fri, 15 Jun 2018 18:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756353AbeFOSvn (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 14:51:43 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40498 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756315AbeFOSvn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 14:51:43 -0400
Received: by mail-wr0-f195.google.com with SMTP id l41-v6so10841474wre.7
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 11:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Gp8GkcthKRnOy8OndR1+DNI1baDPhc9aD6U+ISwORzw=;
        b=qwkXa2JulnEQUTeYuSh15T9acS9s0uCCTZ1lItvZw5j9WhO8OHil13cMM0Zo7TY7pX
         D2NPgkN9gizjPiJIFjcBsKywZBCVTOJ4wWACNUNltVz9qwl6PiKMqMbhcJ6LBJTxHnzM
         CjqQ6FXaDvhXnciBmXTW6ovbEgBqUvuyd+aOtnXP0rFzZU4FdFePbO8l9iEHOesbSqDe
         dTFzlY5PqDdcKQOhzEJj1o011onAX7+p8B9Xp7zp55ZK/M6vsrFvqeVmHnCxUeNaB0w3
         /Ole6HngyWTW4xKvvDsrqfpnZQ47vyVFT77ph7Z0AYKbVRVuCNizg7YCxIVLsla4o9oq
         U2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Gp8GkcthKRnOy8OndR1+DNI1baDPhc9aD6U+ISwORzw=;
        b=Q/ptI5eKfnNHjPdh61Rl1qMSndM2WZHYRg43KEP+Pi0rLqZBOf57egFMLIDdoPHM9i
         N3HkKqr1fjPGWI8WSbqAqzkdjpZG0frlXfMNkNGkLKysEx8ZYXOI6mQytlv7fdb7lidq
         T8GBvGq3AzuM0c+e1bEYru+H8sxKAysgPKMO3weVi4tOWCEzvAswFn0CbOKfyzkA7ARN
         qrastaugFr4kkHBd0+e1ek4IzM1TKdhRIugmXWURB++8UnQsjARemzqjhsTOYOydjisF
         tFG4G4dOqgFQsL5A2YUHYQmFPauNIx8n47piLlx8N2V8sHDeJwT5WSqXyuvLjIjbkQQ+
         LDqQ==
X-Gm-Message-State: APt69E1gOc8WVl6MAKDSeTvcEXKhbblsZOxo7OpxddC7rd9MblwGb/Hp
        8qVFpJS+RNVRvJF9WLO8ca0=
X-Google-Smtp-Source: ADUXVKKQlGyV89Vv+/Y/ONEFGWHRd/6MJhtGbkWGAaw+yeKi0r9A6bkiTIr9gqqPI0SyxBYbdojdvg==
X-Received: by 2002:adf:fb43:: with SMTP id c3-v6mr2778851wrs.32.1529088701444;
        Fri, 15 Jun 2018 11:51:41 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d5-v6sm10481193wrp.64.2018.06.15.11.51.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 11:51:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "ramsay\@ramsayjones.plus.com" <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 0/7] Delete unused methods in EWAH bitmap
References: <20180615143018.170686-1-dstolee@microsoft.com>
        <20180615182727.172075-1-dstolee@microsoft.com>
Date:   Fri, 15 Jun 2018 11:51:40 -0700
In-Reply-To: <20180615182727.172075-1-dstolee@microsoft.com> (Derrick Stolee's
        message of "Fri, 15 Jun 2018 18:27:36 +0000")
Message-ID: <xmqq1sd7288z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The EWAH bitmap code includes several logical operations that are
> important for a general-purpose bitmap library. However, Git only
> uses the XOR operation for storing deltas between reachability
> bitmaps. This means that we can delete the following unused methods:
>
> * ewah_and()
> * ewah_and_not()
> * ewah_not()
> * ewah_or()
> * ewah_serialize()
>
> We can also delete the unused methods bitmap_clear() and
> bitmap_each_bit().
>
> Derrick Stolee (7):
>   ewah/bitmap.c: delete unused 'bitmap_clear()'
>   ewah/bitmap.c: delete unused 'bitmap_each_bit()'
>   ewah_bitmap: delete unused 'ewah_and()'
>   ewah_bitmap: delete unused 'ewah_and_not()'
>   ewah_bitmap: delete unused 'ewah_not()'
>   ewah_bitmap: delete unused 'ewah_or()'
>   ewah_io: delete unused 'ewah_serialize()'
>
>  ewah/bitmap.c      |  32 -------
>  ewah/ewah_bitmap.c | 229 ---------------------------------------------
>  ewah/ewah_io.c     |  10 --
>  ewah/ewok.h        |  25 -----
>  4 files changed, 296 deletions(-)
>
>
> base-commit: fc54c1af3ec09bab8b8ea09768c2da4069b7f53e

Thanks.  

ewah_clear() can become file-scope static, and
rlwit_discharge_empty() can be eliminated.  I do not know if either
is worth doing, though.

 ewah/ewah_bitmap.c | 20 ++++++++++++--------
 ewah/ewah_rlw.c    |  8 --------
 ewah/ewok.h        |  6 ------
 ewah/ewok_rlw.h    |  1 -
 4 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 017c677f98..d59b1afe3d 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -276,6 +276,18 @@ void ewah_each_bit(struct ewah_bitmap *self, void (*callback)(size_t, void*), vo
 	}
 }
 
+/**
+ * Clear all the bits in the bitmap. Does not free or resize
+ * memory.
+ */
+static void ewah_clear(struct ewah_bitmap *self)
+{
+	self->buffer_size = 1;
+	self->buffer[0] = 0;
+	self->bit_size = 0;
+	self->rlw = self->buffer;
+}
+
 struct ewah_bitmap *ewah_new(void)
 {
 	struct ewah_bitmap *self;
@@ -288,14 +300,6 @@ struct ewah_bitmap *ewah_new(void)
 	return self;
 }
 
-void ewah_clear(struct ewah_bitmap *self)
-{
-	self->buffer_size = 1;
-	self->buffer[0] = 0;
-	self->bit_size = 0;
-	self->rlw = self->buffer;
-}
-
 void ewah_free(struct ewah_bitmap *self)
 {
 	if (!self)
diff --git a/ewah/ewah_rlw.c b/ewah/ewah_rlw.c
index b9643b7d0f..5093d43e2f 100644
--- a/ewah/ewah_rlw.c
+++ b/ewah/ewah_rlw.c
@@ -104,11 +104,3 @@ size_t rlwit_discharge(
 
 	return index;
 }
-
-void rlwit_discharge_empty(struct rlw_iterator *it, struct ewah_bitmap *out)
-{
-	while (rlwit_word_size(it) > 0) {
-		ewah_add_empty_words(out, 0, rlwit_word_size(it));
-		rlwit_discard_first_words(it, rlwit_word_size(it));
-	}
-}
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 0c504f28e2..84b2a29faa 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -72,12 +72,6 @@ void ewah_pool_free(struct ewah_bitmap *self);
  */
 struct ewah_bitmap *ewah_new(void);
 
-/**
- * Clear all the bits in the bitmap. Does not free or resize
- * memory.
- */
-void ewah_clear(struct ewah_bitmap *self);
-
 /**
  * Free all the memory of the bitmap
  */
diff --git a/ewah/ewok_rlw.h b/ewah/ewok_rlw.h
index bb3c6ff7e0..7cdfdd0c02 100644
--- a/ewah/ewok_rlw.h
+++ b/ewah/ewok_rlw.h
@@ -98,7 +98,6 @@ void rlwit_init(struct rlw_iterator *it, struct ewah_bitmap *bitmap);
 void rlwit_discard_first_words(struct rlw_iterator *it, size_t x);
 size_t rlwit_discharge(
 	struct rlw_iterator *it, struct ewah_bitmap *out, size_t max, int negate);
-void rlwit_discharge_empty(struct rlw_iterator *it, struct ewah_bitmap *out);
 
 static inline size_t rlwit_word_size(struct rlw_iterator *it)
 {


