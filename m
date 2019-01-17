Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B4CC1F62E
	for <e@80x24.org>; Thu, 17 Jan 2019 06:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfAQGbs (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 01:31:48 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40877 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbfAQGbs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 01:31:48 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so7561440lji.7
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 22:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xsQEjOmEoDrDqgAPu+gKVR1BXupF39HZs13T7zSEnE4=;
        b=Tj3cxmhn9MjXvwT/3RBtB7Q4WUzWm8afhW5aezXmxhK2nLxdOKvT6s5ks52gwz9vcw
         VjSAK0y1phANnJWuxngsshWJlpsk3H3T07IOHvE72EQ2BcX4uhNwkJCx+0jHUYUFhcr+
         Noo2rJ5SLOXucVK2Bm1djNEBdfQesxzOTjLlvZCgoQ4Yw6q5mFMYSTFoEcD2/T4B+9r+
         20QUHGRotwC4EwIVsjZpQSSiKhWIt5nsdf5bpP7lad1DGFlbGbM4F9iZkBgF7PG5XMoW
         GR1VIGSGKGesO7z/6YyeLh8UHTyc/Gij8uZ2SAfhwax3IiP2C4ZrC1uU2V+Bxug7zgop
         UWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xsQEjOmEoDrDqgAPu+gKVR1BXupF39HZs13T7zSEnE4=;
        b=if7K04pEgakiX71Dtt8Hm+Jmj5D7GOHmJkPeJXzTcBjnlrbQEhbzIykMDjYDGHQfhq
         Rp74vzfiIv3T/U/VkSpNGMQbMLkuSUb5YlroDqs/CPQrD4tHWNtFza3UGUK4tuXZfPss
         T8AeRdEEvDhLt2vHoHdTyG6acrAg9pgy1OY7bdVTF8wG5g5/MRI4W59cEg2RL2gB5WyC
         rgeJAw5KYBXDYuiyVRlaqzgEW6DLTFH0O5i1172zMcYOZyaC5SRGENUgpmv/J/SUBVXu
         iRCpNBFEsPkgM5iWQb4KjgF+ABoIka4lKQQ04vLBQAqZpouEZbnHQgAt0mm9GnnNfVcn
         TjGA==
X-Gm-Message-State: AJcUukfhTSh9q0zvhJNLgeMpYIZExUARYGW1aMt+LX1sowGpssviC2JH
        KHYobMq6wOQFXkyDVtdA8vyNJbAV
X-Google-Smtp-Source: ALg8bN5nHovqIv2DyNuVPsq5phtTlWptb1PMoIXhqrevfTNlJn+S8jTYefoLf3dw2aTKkdJYuocnTQ==
X-Received: by 2002:a2e:7e04:: with SMTP id z4-v6mr8850441ljc.97.1547706705561;
        Wed, 16 Jan 2019 22:31:45 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id c2-v6sm87151ljj.41.2019.01.16.22.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 22:31:44 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/3] setup: do not use invalid `repository_format`
Date:   Thu, 17 Jan 2019 07:31:14 +0100
Message-Id: <20190117063114.1901775-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.20.1.98.gecbdaf0899
In-Reply-To: <20190115193112.GE4886@sigill.intra.peff.net>
References: <20190115193112.GE4886@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 15 Jan 2019 at 20:31, Jeff King <peff@peff.net> wrote:
>
> On Mon, Jan 14, 2019 at 07:34:56PM +0100, Martin Ågren wrote:
>
> > This can be observed by adding this to the end of
> > `read_repository_format()`:
> >
> >       if (format->version == -1)
> >               format->hash_algo = 0; /* no-one should peek at this! */
> >
> > Check that `version` is non-negative before using `hash_algo`.

> I'm still somewhat confused about how this breaks. If we move
> ".git/config" out of the way, then we have no version indicator and
> presumably we should guess GIT_HASH_SHA1. Which is what's happening if
> we fail to call repo_set_hash_algo(), no?  In other words, wouldn't
> repo_set_hash_algo() always be a noop in that case?
>
> I get why adding the code snippet above would cause that assumption to
> break, but I am just not sure why we would add that code snippet. ;)
>
> I also get why read_repository_format() doing this in patch 3 would be a
> problem:
>
>   +       if (format->version == -1) {
>   +               clear_repository_format(format);
>   +               format->version = -1;
>   +       }
>
> but doesn't that point out that clear_repository_format() should be
> setting hash_algo to GIT_HASH_SHA1 as the default (and likewise "bare =
> -1", etc, that is done in that function)?

Something like the below on top of this series (then rebased). (The last
hunk below is a revert of this patch.)

I'd like to think of the situation before this patch above as a
situation where the API promises something and the user uses the API
beyond that. The next patch in this series changes the internals of the
API in a way that is consistent with the promise made, but which ends up
affecting an over-eager user.

What this patch above does is to make the user do what the API promise
allows them to do, i.e., no more shortcuts. What you're saying is, why
isn't the promise stronger? So the user won't have to think as much?

So in particular, why doesn't `clear...()` and the error path in
`read_...()` impose sane, usable defaults? My first concern is that it
means we need to make a stronger promise, which might then be hard to
back away from, if we want to. Maybe we'll never want to...

My second concern is, what should we be falling back to, going forward?
At some point, the hash indicated by `REPOSITORY_FORMAT_INIT` will be
SHA-256. Before that, and as soon as we support both hashes, what if we
pick up SHA-256 before stumbling on some other piece of the config --
should we now reset the struct to indicate SHA-1, or rather keep the
SHA-256 value, which by itself is valid? (The same could be argued now,
for something other than hash functions, but the SHA-1/256 example might
be more obvious in the context of this patch.)

My third worry is that we should then equip `clear_...()` or at least
the error path of `read_...()` with some logic to keep "as much as
possible" of what we've picked up and reset the rest, all the while
making sure we don't end up with something self-contradicting or stupid.
After all, we'll have promised the users that they can ignore any errors
and just run ahead.

Maybe I'm worrying way too much, and I shouldn't be so afraid of making
a stronger promise here and now because of vague slippery-slope thinking.

Thanks for pushing back and forcing me to articulate my thinking.

Martin


diff --git a/cache.h b/cache.h
index 3ef63d27c4..acd86e9f9f 100644
--- a/cache.h
+++ b/cache.h
@@ -974,15 +974,21 @@ struct repository_format {
 
 /**
  * Always use this to initialize a `struct repository_format`
- * to a well-defined state before calling `read_repository()`.
+ * to a well-defined, default state before calling
+ * `read_repository()`.
  */
-#define REPOSITORY_FORMAT_INIT { 0 }
+#define REPOSITORY_FORMAT_INIT (struct repository_format){ \
+				 .version = -1, \
+				 .is_bare = -1, \
+				 .hash_algo = GIT_HASH_SHA1, \
+				 .unknown_extensions = STRING_LIST_INIT_DUP, \
+			       }
 
 /*
  * Read the repository format characteristics from the config file "path" into
  * "format" struct. Returns the numeric version. On error, -1 is returned,
  * format->version is set to -1, and all other fields in the struct are
- * undefined.
+ * set to the default configuration (REPOSITORY_FORMAT_INIT).
  */
 int read_repository_format(struct repository_format *format, const char *path);
 
diff --git a/setup.c b/setup.c
index 70d9007ae5..f3ea479ad9 100644
--- a/setup.c
+++ b/setup.c
@@ -511,15 +511,9 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 int read_repository_format(struct repository_format *format, const char *path)
 {
 	clear_repository_format(format);
-	format->version = -1;
-	format->is_bare = -1;
-	format->hash_algo = GIT_HASH_SHA1;
-	string_list_init(&format->unknown_extensions, 1);
 	git_config_from_file(check_repo_format, path, format);
-	if (format->version == -1) {
+	if (format->version == -1)
 		clear_repository_format(format);
-		format->version = -1;
-	}
 	return format->version;
 }
 
@@ -528,7 +522,7 @@ void clear_repository_format(struct repository_format *format)
 	string_list_clear(&format->unknown_extensions, 0);
 	free(format->work_tree);
 	free(format->partial_clone);
-	memset(format, 0, sizeof(*format));
+	*format = REPOSITORY_FORMAT_INIT;
 }
 
 int verify_repository_format(const struct repository_format *format,
@@ -1152,7 +1146,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
 			setup_git_env(gitdir);
 		}
-		if (startup_info->have_repository && repo_fmt.version > -1)
+		if (startup_info->have_repository)
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
 	}
 
