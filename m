Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8ED71F954
	for <e@80x24.org>; Fri, 17 Aug 2018 18:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeHQVFF (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 17:05:05 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46669 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeHQVFE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 17:05:04 -0400
Received: by mail-lf1-f65.google.com with SMTP id e23-v6so1134730lfc.13
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 11:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2DyB65MLbEnrQVw4vJm+Acx4SrcYI8fW7U2rt6SLZ3c=;
        b=mOuDpbiswQcocHRFwwIXnXkVRa8JA3xkpkKDg/R16yS+xMdOHebkiGsefeFirYcPzr
         htv5kddmTFVuQnKU5+96j3CU4I17vlnFBGxjOej5wmtaE01eZlS7IFZum/N6UDx5klbs
         CaQUk3Tmxsbor/ad7Dn8Xrky0QRKUGItdx+KMlmsGawkI4RYZrC+RSH6UCrCdHxsu+Pj
         ow5PCitMvcb5dVWpeYK/UsCTjxwROETJYdaZ0WiUkhQZqsUNSenDAhPlVKx15uLyCwzK
         kGJHkLzGll7M9z0Umpq3lhRyJBF+BdwS0YcOQ8vOtdJVJRAO8VIQ9cKg2U1nyNRIN3vr
         AZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2DyB65MLbEnrQVw4vJm+Acx4SrcYI8fW7U2rt6SLZ3c=;
        b=AqBen5pLTECviVIM/XOmxlpAgdvhJdOcY00obrSqS+O1rRBykRVBtTkp5MX+KH0RGn
         Et42AkEq7jm93oCzDpK7Go+Q755XnCnk+xqmjBqXwD4Ge4wqiMO5rbogBmf+hC/MzWdE
         LpsTDAOIWyOTvKORd9srpdSpKvkkbPS2UFgqUgUjV4mqxRodLlCXq+BNbHIz/ETOx6V0
         aGFqnfPloKLjLcHek+Tc+KmnJND/MOpB5wAJiABIeVWBC+HwvB+B3WXgl3d7Smtgjqmh
         yaPYsjUDrBwOE2HvdY0PMzAciLQ2jr96hriNrJu5pdi9V8acTXYLjcTcqgSRd7HL7Fp+
         l9KA==
X-Gm-Message-State: AOUpUlGFub1zhG1wG1Z8o/mnzwPF+GJ50dtm/oTTJLDL8djG4XHH9H1o
        PErj9oHbAhoLngtvmZL8gzC2+nXe
X-Google-Smtp-Source: AA+uWPwfRIixMnAJPbJiFY+3f4LPeowz3uc7Xq5R9QmT8YcOxaRulyZnXUp2GurAlsCx254juPp8vg==
X-Received: by 2002:a19:2841:: with SMTP id o62-v6mr7923620lfo.86.1534528842609;
        Fri, 17 Aug 2018 11:00:42 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d203-v6sm277249lfe.82.2018.08.17.11.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 11:00:41 -0700 (PDT)
Date:   Fri, 17 Aug 2018 20:00:39 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, newren@gmail.com,
        pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com, tboegi@web.de
Subject: Re: [PATCH v5] clone: report duplicate entries on case-insensitive
 filesystems
Message-ID: <20180817180039.GA31789@duynguyen.home>
References: <20180812090714.19060-1-pclouds@gmail.com>
 <20180817161645.28249-1-pclouds@gmail.com>
 <xmqqh8jsc3kr.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqh8jsc3kr.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 10:20:36AM -0700, Junio C Hamano wrote:
> I highly suspect that the above was written in that way to reduce
> the indentation level, but the right way to reduce the indentation
> level, if it bothers readers too much, is to make the whole thing
> inside the above if (o->clone) into a dedicated helper function
> "void report_collided_checkout(void)", I would think.

I read my mind. I thought of separating into a helper function too,
but was not happy that the clearing CE_MATCHED in preparation for this
test is in check_updates(), but the cleaning up CE_MATCHED() is in the
helper function.

So here is the version that separates _both_ phases into helper
functions.

-- 8< --
Subject: [PATCH v6] clone: report duplicate entries on case-insensitive filesystems

Paths that only differ in case work fine in a case-sensitive
filesystems, but if those repos are cloned in a case-insensitive one,
you'll get problems. The first thing to notice is "git status" will
never be clean with no indication what exactly is "dirty".

This patch helps the situation a bit by pointing out the problem at
clone time. Even though this patch talks about case sensitivity, the
patch makes no assumption about folding rules by the filesystem. It
simply observes that if an entry has been already checked out at clone
time when we're about to write a new path, some folding rules are
behind this.

In the case that we can't rely on filesystem (via inode number) to do
this check, fall back to fspathcmp() which is not perfect but should
not give false positives.

This patch is tested with vim-colorschemes and Sublime-Gitignore
repositories on a JFS partition with case insensitive support on
Linux.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/clone.c  |  1 +
 cache.h          |  1 +
 entry.c          | 31 +++++++++++++++++++++++++++++++
 t/t5601-clone.sh |  8 +++++++-
 unpack-trees.c   | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.h   |  1 +
 6 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5c439f1394..0702b0e9d0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -747,6 +747,7 @@ static int checkout(int submodule_progress)
 	memset(&opts, 0, sizeof opts);
 	opts.update = 1;
 	opts.merge = 1;
+	opts.clone = 1;
 	opts.fn = oneway_merge;
 	opts.verbose_update = (option_verbosity >= 0);
 	opts.src_index = &the_index;
diff --git a/cache.h b/cache.h
index 8b447652a7..6d6138f4f1 100644
--- a/cache.h
+++ b/cache.h
@@ -1455,6 +1455,7 @@ struct checkout {
 	unsigned force:1,
 		 quiet:1,
 		 not_new:1,
+		 clone:1,
 		 refresh_cache:1;
 };
 #define CHECKOUT_INIT { NULL, "" }
diff --git a/entry.c b/entry.c
index b5d1d3cf23..8766e27255 100644
--- a/entry.c
+++ b/entry.c
@@ -399,6 +399,34 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
 	return lstat(path, st);
 }
 
+static void mark_colliding_entries(const struct checkout *state,
+				   struct cache_entry *ce, struct stat *st)
+{
+	int i, trust_ino = check_stat;
+
+#if defined(GIT_WINDOWS_NATIVE)
+	trust_ino = 0;
+#endif
+
+	ce->ce_flags |= CE_MATCHED;
+
+	for (i = 0; i < state->istate->cache_nr; i++) {
+		struct cache_entry *dup = state->istate->cache[i];
+
+		if (dup == ce)
+			break;
+
+		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
+			continue;
+
+		if ((trust_ino && dup->ce_stat_data.sd_ino == st->st_ino) ||
+		    (!trust_ino && !fspathcmp(ce->name, dup->name))) {
+			dup->ce_flags |= CE_MATCHED;
+			break;
+		}
+	}
+}
+
 /*
  * Write the contents from ce out to the working tree.
  *
@@ -455,6 +483,9 @@ int checkout_entry(struct cache_entry *ce,
 			return -1;
 		}
 
+		if (state->clone)
+			mark_colliding_entries(state, ce, &st);
+
 		/*
 		 * We unlink the old file, to get the new one with the
 		 * right permissions (including umask, which is nasty
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 0b62037744..f2eb73bc74 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -624,10 +624,16 @@ test_expect_success 'clone on case-insensitive fs' '
 			git hash-object -w -t tree --stdin) &&
 		c=$(git commit-tree -m bogus $t) &&
 		git update-ref refs/heads/bogus $c &&
-		git clone -b bogus . bogus
+		git clone -b bogus . bogus 2>warning
 	)
 '
 
+test_expect_success !MINGW,!CYGWIN,CASE_INSENSITIVE_FS 'colliding file detection' '
+	grep X icasefs/warning &&
+	grep x icasefs/warning &&
+	test_i18ngrep "the following paths have collided" icasefs/warning
+'
+
 partial_clone () {
 	       SERVER="$1" &&
 	       URL="$2" &&
diff --git a/unpack-trees.c b/unpack-trees.c
index cd0680f11e..213da8bbb4 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -345,6 +345,46 @@ static struct progress *get_progress(struct unpack_trees_options *o)
 	return start_delayed_progress(_("Checking out files"), total);
 }
 
+static void setup_collided_checkout_detection(struct checkout *state,
+					      struct index_state *index)
+{
+	int i;
+
+	state->clone = 1;
+	for (i = 0; i < index->cache_nr; i++)
+		index->cache[i]->ce_flags &= ~CE_MATCHED;
+}
+
+static void report_collided_checkout(struct index_state *index)
+{
+	struct string_list list = STRING_LIST_INIT_NODUP;
+	int i;
+
+	for (i = 0; i < index->cache_nr; i++) {
+		struct cache_entry *ce = index->cache[i];
+
+		if (!(ce->ce_flags & CE_MATCHED))
+			continue;
+
+		string_list_append(&list, ce->name);
+		ce->ce_flags &= ~CE_MATCHED;
+	}
+
+	list.cmp = fspathcmp;
+	string_list_sort(&list);
+
+	if (list.nr) {
+		warning(_("the following paths have collided (e.g. case-sensitive paths\n"
+			  "on a case-insensitive filesystem) and only one from the same\n"
+			  "colliding group is in the working tree:\n"));
+
+		for (i = 0; i < list.nr; i++)
+			fprintf(stderr, "  '%s'\n", list.items[i].string);
+	}
+
+	string_list_clear(&list, 0);
+}
+
 static int check_updates(struct unpack_trees_options *o)
 {
 	unsigned cnt = 0;
@@ -359,6 +399,9 @@ static int check_updates(struct unpack_trees_options *o)
 	state.refresh_cache = 1;
 	state.istate = index;
 
+	if (o->clone)
+		setup_collided_checkout_detection(&state, index);
+
 	progress = get_progress(o);
 
 	if (o->update)
@@ -423,6 +466,10 @@ static int check_updates(struct unpack_trees_options *o)
 	errs |= finish_delayed_checkout(&state);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
+
+	if (o->clone)
+		report_collided_checkout(index);
+
 	return errs != 0;
 }
 
diff --git a/unpack-trees.h b/unpack-trees.h
index c2b434c606..d940f1c5c2 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -42,6 +42,7 @@ struct unpack_trees_options {
 	unsigned int reset,
 		     merge,
 		     update,
+		     clone,
 		     index_only,
 		     nontrivial_merge,
 		     trivial_merges_only,
-- 
2.18.0.1004.g6639190530

-- 8< --
--
Duy
