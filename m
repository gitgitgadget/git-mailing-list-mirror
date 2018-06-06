Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13C6E1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 10:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932398AbeFFK1h (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 06:27:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51304 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932378AbeFFK1f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 06:27:35 -0400
Received: by mail-wm0-f66.google.com with SMTP id r15-v6so10494350wmc.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 03:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZsOuOcOhRNaxSdBHrDWIzpJey3cNnA8u9eKaTn1e1I4=;
        b=hCYicqVjljHkpWLN4Eh+zse7nqe5rBAVo6Ut+2OX6wLIYlUUu6QvPsMYixoN0M6ZT+
         cC07jIZztCDga5x+qtfRBAcShAdtFr8487z4lW9E1XKKU+p2Tkz8BHsyIJg3RADKbWjC
         OI+dfsfZC0habkkNtovr1719YJ82a0JNcp+DBZPXx28jADeyfkCPZ0lZt5HVIwvAADJC
         Y0rdFzTCcDy9S1I05LoPbDOJBZjIHJuzp4HNcdLlwUMhohkdXvUEQ8RYkGbYbz/tvcTi
         RHeFQzAz5VV61jNItXHwpuvu09jGuGLBNmm4du4EsiGd8Hr6dHnpfPUhC8Lw2Nf4Ciod
         5H6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZsOuOcOhRNaxSdBHrDWIzpJey3cNnA8u9eKaTn1e1I4=;
        b=krd9ThfGWL4YUN+A+qsCy08T9BTnOEfWjmGj1IWBKSDqd/9dK4ixssX+KLIZIrEux2
         W5mN1osLXOWQxT7l7KllqyypCAhfIcVm8EsCvWXXNZJ8BA8anuI1DpHQruKZE9PsC/+L
         g0TtZKdQmiPiBcPF5BdcnDeFVPcYtvCGXKe3EURq4s/Zz6hLy9xU32YYIq2SmFXm3zQt
         6JCSt30hBXMBdA7Vy2uelQ1m4EZDazS9mzp4jVejkIgUOQbIH/xJODRLQLa+61uie7dC
         ta70DSrBEZfTmjiwTWpaQTOHf2Sh0JZmu7fpQGv1ywSQrdp28rUvmaqlLNQMklyCR7ES
         i3ZQ==
X-Gm-Message-State: APt69E2BpVtQUVicgqQEHGmN9At6KlshlrPR080XEvDNipOf1xOWWDWk
        0PcJbJvSnP0zqxgwFW9Iw7l/h3HW
X-Google-Smtp-Source: ADUXVKK9TMMO+IFLCQ3eJPIyj/QNlPb7P/tkRN6Fmrc+ZPxAlOxi+rIS5R3e++Ga8QyRdzXP2qiXgw==
X-Received: by 2002:a1c:8ec1:: with SMTP id q184-v6mr1298165wmd.48.1528280853407;
        Wed, 06 Jun 2018 03:27:33 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id u108-v6sm63722766wrc.40.2018.06.06.03.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 03:27:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 2/2] sha1-name: add core.validateAbbrev & relative core.abbrev
Date:   Wed,  6 Jun 2018 10:27:19 +0000
Message-Id: <20180606102719.27145-3-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180606102719.27145-1-avarab@gmail.com>
References: <20180606102719.27145-1-avarab@gmail.com>
In-Reply-To: <87lgbsz61p.fsf@evledraar.gmail.com>
References: <87lgbsz61p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Linus added auto-sizing for abbreviations in
e6c587c733 ("abbrev: auto size the default abbreviation", 2016-09-30)
we've been less likely to produce a short SHA-1 today that'll collide
on the same repository tomorrow, since before we'd always pick the
bare minimum we could get away with.

But we still do a full disambiguation check, which can be very
expensive in some cases. There's a work-in-progress MIDX
implementation to address that[1].

This change adds an alternate method of achieving some of the same
ends (but possibly not all, see [2] and replies to the original thread
at [1]).

Now, as described in the docs the user can set a relative abbreviation
length via core.abbrev, e.g. on linux.git core.abbrev=+2 will produce
SHA-1s that are 14 characters (as opposed to the implicit 12).

This in combination with core.validateAbbrev=false (off by default)
allows for picking a trade-off between performance, and the odds that
future or remote (or current and local) short SHA-1 will be ambiguous.

1. https://public-inbox.org/git/20180107181459.222909-1-dstolee@microsoft.com/
2. https://public-inbox.org/git/87lgbsz61p.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt | 46 ++++++++++++++++++++++++++++++++++++++++
 cache.h                  |  2 ++
 config.c                 | 14 ++++++++++++
 environment.c            |  2 ++
 sha1-name.c              | 15 +++++++++++++
 5 files changed, 79 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a9..8624110818 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -919,6 +919,52 @@ core.abbrev::
 	in your repository, which hopefully is enough for
 	abbreviated object names to stay unique for some time.
 	The minimum length is 4.
++
+This can also be set to relative values such as `+2` or `-2`, which
+means to add or subtract N characters from the SHA-1 that Git would
+otherwise print. This is useful in combination with the
+`core.validateAbbrev` setting, or to get more future-proof hashes to
+reference in the future in a repository whose number of objects is
+expected to grow.
+
+core.validateAbbrev::
+	If set to false (true by default) don't do any validation when
+	printing abbreviated object names to see if they're really
+	unique. This makes printing objects more performant at the
+	cost of potentially printing object names that aren't unique
+	within the current repository.
++
+When printing abbreviated object names Git needs to look through the
+local object store. This is an `O(log N)` operation assuming all the
+objects are in a single pack file, but `X * O(log N)` given `X` pack
+files, which can get expensive on some larger repositories.
++
+This setting changes that to `O(1)`, but with the trade-off that
+depending on the value of `core.abbrev` way may be printing
+abbreviated hashes that collide. Too see how likely this is, try
+running:
++
+-----------------------------------------------------------------------------------------------------------
+git log --all --pretty=format:%h --abbrev=4 | perl -nE 'chomp; say length' | sort | uniq -c | sort -nr
+-----------------------------------------------------------------------------------------------------------
++
+This shows how many commits were found at each abbreviation length. On
+linux.git in June 2018 this shows a bit more than 750,000 commits,
+with just 4 needing 11 characters to be fully abbreviated, and the
+default heuristic picks a length of 12.
++
+Even without `core.validateAbbrev=false` the results abbreviation
+already a bit of a probability game. They're guaranteed at the moment
+of generation, but as more objects are added, ambiguities may be
+introduced. Likewise, what's unambiguous for you may not be for
+somebody else you're communicating with, if they have their own clone.
++
+Therefore the default of `core.validateAbbrev=true` may not save you
+in practice if you're sharing the SHA-1 or noting it now to use after
+a `git fetch`. You may be better off setting `core.abbrev` to
+e.g. `+2` to add 2 extra characters to the SHA-1 in combination with
+`core.validateAbbrev=false` to get a reasonable trade-off between
+safety and performance.
 
 add.ignoreErrors::
 add.ignore-errors (deprecated)::
diff --git a/cache.h b/cache.h
index 89a107a7f7..6dc5af9482 100644
--- a/cache.h
+++ b/cache.h
@@ -772,6 +772,8 @@ extern int check_stat;
 extern int quote_path_fully;
 extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
+extern int default_abbrev_relative;
+extern int validate_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
diff --git a/config.c b/config.c
index 12f762ad92..b6e0d17af1 100644
--- a/config.c
+++ b/config.c
@@ -1146,11 +1146,25 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.validateabbrev")) {
+		if (!value)
+			return config_error_nonbool(var);
+		validate_abbrev =  git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.abbrev")) {
 		if (!value)
 			return config_error_nonbool(var);
 		if (!strcasecmp(value, "auto")) {
 			default_abbrev = -1;
+		} else if (*value == '+' || *value == '-') {
+			int relative = git_config_int(var, value);
+			if (relative == 0)
+				die(_("bad core.abbrev value %s. "
+				      "relative values must be non-zero"),
+				    value);
+			default_abbrev_relative = relative;
 		} else {
 			int abbrev = git_config_int(var, value);
 			if (abbrev < minimum_abbrev || abbrev > 40)
diff --git a/environment.c b/environment.c
index 2a6de2330b..4a24d8126b 100644
--- a/environment.c
+++ b/environment.c
@@ -22,6 +22,8 @@ int trust_ctime = 1;
 int check_stat = 1;
 int has_symlinks = 1;
 int minimum_abbrev = 4, default_abbrev = -1;
+int default_abbrev_relative = 0;
+int validate_abbrev = 1;
 int ignore_case;
 int assume_unchanged;
 int prefer_symlink_refs;
diff --git a/sha1-name.c b/sha1-name.c
index 60d9ef3c7e..aa7ccea14d 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -576,6 +576,7 @@ int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 	struct disambiguate_state ds;
 	struct min_abbrev_data mad;
 	struct object_id oid_ret;
+	int dar = default_abbrev_relative;
 	if (len < 0) {
 		unsigned long count = approximate_object_count();
 		/*
@@ -602,6 +603,20 @@ int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len)
 	if (len == GIT_SHA1_HEXSZ || !len)
 		return GIT_SHA1_HEXSZ;
 
+	if (dar) {
+		if (len + dar < MINIMUM_ABBREV) {
+			len = MINIMUM_ABBREV;
+			dar = 0;
+		}
+
+		if (validate_abbrev) {
+			len += dar;
+		} else {
+			hex[len + dar] = 0;
+			return len + dar;
+		}
+	}
+
 	mad.init_len = len;
 	mad.cur_len = len;
 	mad.hex = hex;
-- 
2.17.0.290.gded63e768a

