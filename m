Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632526;
	b=whWBDH+4FYZRQbpxg7HSgQlJ+wWrnDIhlsuci/U58A953VP0UpxZ431WhF3YV+3txbuS
	 eQSC0V5k4Zep6v6FMAeYnRIq2/NQelyhdQ81H320AKlH8ag7RDoGoWwatvYLSlH6CacVl
	 SFhIKwMBF4mP49jP2G4pp6OBXXPKUHKmZDM116ZSeUrtJkIGxcoPzLtuVWsS0Iqb5FsWs
	 KR6aYYHSydbrJIzDcKqlrZrXTipwC40F3nlW4Conz0VW+ROAvK8ILbktn+5CqXhdPU3ka
	 FaaJb5p2wvxkWx8qZg/QQ20QzQscYH26y4XDNIF6lZbowCuYhYwoPxqILOxwMaffQMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kr7Rr81U7jcizo6ibrrNBTLUYWrFETPjlZM7rbPGAdU=;
	b=YQuUYk7Cq3fWIZhdpU3RGc1XNxX2Flvjg3XDpg8Kx93ljOuemjvUK6aCBGANDA0clt3W
	 hPkDbQ1zzEqva2lH5Dpdz/L0Nxbe8p79X8zgj5kQH5etUJ7eJ9B1t4p0pLemdMRRKgaCs
	 vFhJsHTzO/Xoz9bpvOCu3cIgBmgfGaQhJ8P7HjCv542QoCtM8hCDjE0REmB21l/Cc7r8p
	 3el+s9KP91Gmw+OEP4LWYnxalc+VPftKdYA7WRs8NlZAgUynZCt7YTCU83a/FyK8Amb2U
	 Cfc/HEaUHnoGl/R5excWgcr12GbX+XNg+zfLnTVu+UVwpbCkJtsbG3D0QQDJPVeQw1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bmIfteGN;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0C760B4D10
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 15:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F0C760B4D10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bmIfteGN
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48e3b22e971so1572891f8f.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 07:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793632524; x=1794237324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kr7Rr81U7jcizo6ibrrNBTLUYWrFETPjlZM7rbPGAdU=;
        b=bmIfteGNJIoEz/vUF1n3F9Rsr8Nlc6uENDwYP3jsBkQ7ApCqJfCoacDgC0zexJlJEd
         jc5+Fn0QTt+Ff6I1Ex3BLYL9blPNjgHcGBUAdx4NE7fcgBngI2y0HG3eS26mHZUm0+Jk
         kIDab9XVhYylnbvx5ZDdqdaw8LQO6fwJY5bfCP3c8p3PkOJeu+9b5yXgNSOY26+Z/CfO
         EXa4lxXVRe/zxg8+jOCUkm5gSCzKCpRN15mVVFlgNzv5wOJ7n1+nU9aGy7JGTg8321ET
         a5kZFUJiYNDQXaGw7KXV/mjnGEtHwqpvS0biuEoFfY9kvVl6g7MiwLj8bW6lhCxh+7JA
         wo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632524; x=1794237324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kr7Rr81U7jcizo6ibrrNBTLUYWrFETPjlZM7rbPGAdU=;
        b=y9lutZPdhBAc4e3hHrbZTT1BAn4JIZ8hLIyC8r9XPJpPaJecOXISafIkJSwdi6Cd0h
         HJa7EdAd40V7365TZlDY4X/ykQSnr758jX8aWMv58uTjE942f8A+7RuraeBhu7ErnkpC
         EljUbX/Ju44NkVUivooUWzOP+mz3bk0IlExr6pkMqcRacHPCTd/Sc0P/NwFxBE+lxU/A
         aebPR5ZOhJ/IKi7olFPoVAW+vfzXQuPPiCxdomFDErJo+dMCRjdHTOgWWmo3wF3ZwNXv
         x/4pn26hsyXnuJH5th0r9+y/JMZuWhIrDUykHeWwWkFcUbKF8RMvO5A06q0oO3MgPjOq
         7qig==
X-Gm-Message-State: APuU4Z8KRr5Kq+UKtmrfE+BUam+yiYS552XOnz7uv5BlmdOhVwjpOFeu
	5RWTNOFC67TiQLNPanuLFx/aA5Vtuwg1LC+6XAM33V8FEix4SrZQipoc/SK6VA==
X-Gm-Gg: AYBFou0Rj+gQY9haXGAElPBZ/KWUWV/EJesktXD7FXtXTZiQPpWOeXem5pvbT/NGUzM
	X6AFdolBRMx+kal2VqUNBbhsSjbA9psJ9IuYad/p4YtqMy/aXrq95ckmjsicZC+T5TkyDUGM6Ed
	E5Xb3Ar9l5PyvshpA9KJCri23v3HRDpIeyWYc7r7ZLwoA/sqPJpMHzvNBUwmlvtPoY6UqYJnzay
	PFuqgmdYPj7oMuWIYrrb3+0VP9pz0F60SHgPJfetU0VG7yVH2jz2fuUINuy1/lnIIgL8m4HiYvj
	E1Def3nLAcxMIoM6w2cDFxeSXs7S4jgEJyecEjH+i9hHvHfDPIkBtvd33MA2v4xp/BPHSg6UdHd
	8L++9zScnJ1oQoHfStqvcvzQy5JRmzk5kfboUnV7bg/Hh6oTyY5bDVZEMBCxOcMCfzCEPLH27uK
	ziNCwwSA8vd8nKIo8NLv+p/Hx6S6pEM3zs0J+MUiQ79E0qRyvo7Ppn2p1zc7c4BWGKxyhZ96FrF
	5O1kdl+GwrBjooWsGN9l6Tz1Jr3l1YekBVhJqW4BYRDRPw0LB6XbsWcb6yCg5eARN4GfS+53wJj
	IKh6IMBfu/d2+EfLXTgYh6tCxfUZ7l/lH3qUfT45UPVCO06CCBly7p3Hg5fwCYMdwz/Uwpv0end
	rrWT7laNA0GpP4Og6t6kzLeW7C78xic4lNyqDK82Te9jUVVfhOforvSuei2JUINSEtiL2cE+lv/
	OA7OH4K7BDiUKzOnlte4h87QfKVgmkrAKxXVt3X/LcFylxK2Z1PsBoZWcps+G0
X-Received: by 2002:a05:6000:200b:b0:48e:5df2:fd24 with SMTP id ffacd0b85a97d-48e6e305bc0mr23684024f8f.32.1793632524283;
        Mon, 02 Nov 2026 07:15:24 -0800 (PST)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b80eb1sm21851553f8f.34.2026.11.02.07.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:15:23 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Cynthia Uche <herroyalpriestess@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 2/4] parse-options: extract lookup_long_opt() from parse_long_opt()
Date: Mon,  2 Nov 2026 16:14:50 +0100
Message-ID: <20261102151447.734680-8-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.4.gceeb21e89e
In-Reply-To: <20261102151447.734680-6-christian.couder@gmail.com>
References: <20261012074413.337183-1-christian.couder@gmail.com>
 <20261102151447.734680-6-christian.couder@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a following commit, an early scan of the command line will need to
look up long options the same way parse_options() does, including
unambiguous abbreviations and negated forms, but without any side
effect: it must neither set option values nor call die() or error().

parse_long_opt() can't be used for that, as it does both the look up
and the actions that follow it: it calls get_value() on the option it
finds, die()s when abbreviations are disallowed, and error()s on an
ambiguous abbreviation.

Let's extract a new lookup_long_opt() helper from parse_long_opt() to
perform only the look up part, and let parse_long_opt() act on what
lookup_long_opt() returns.

There is no behavior change intended. In particular an exact match is
still preferred to any abbreviation, abbreviations are still rejected
when disallowed only if there is no exact match, and the ambiguity
error message is unchanged.

Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 parse-options.c | 117 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 89 insertions(+), 28 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index d7cbb5a343..d94d6fed93 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -516,16 +516,46 @@ static void register_abbrev(struct parse_opt_ctx_t *p,
 	abbrev->flags = flags;
 }
 
-static enum parse_opt_result parse_long_opt(
-	struct parse_opt_ctx_t *p, const char *arg,
-	const struct option *options)
+enum long_opt_lookup {
+	LONG_OPT_EXACT,      /* exact match found */
+	LONG_OPT_ABBREV,     /* unambiguous abbreviation found */
+	LONG_OPT_AMBIGUOUS,  /* more than one candidate abbreviation */
+	LONG_OPT_UNKNOWN,    /* nothing matches */
+};
+
+/*
+ * Look up the long option named by `arg` (without its leading "--")
+ * without acting on it. (Neither prints nor dies.)
+ *
+ * Return value:
+ * - On LONG_OPT_EXACT, `found` is the exact matching option and its flags
+ *   (including OPT_UNSET for a negated form), and `stuck` points after
+ *   the '=' or is NULL.
+ * - On LONG_OPT_ABBREV, `found` is the unambiguous abbreviation, same as
+ *   above for its flags and `stuck`.
+ * - On LONG_OPT_AMBIGUOUS, `found` and `other` are two candidates of an
+ *   ambiguous abbreviation.
+ * - On LONG_OPT_UNKNOWN, nothing matches, no result.
+ *
+ * `other` is only meaningful for LONG_OPT_AMBIGUOUS.
+ */
+static enum long_opt_lookup lookup_long_opt(struct parse_opt_ctx_t *p,
+					    const char *arg,
+					    const struct option *options,
+					    struct parsed_option *found,
+					    struct parsed_option *other,
+					    const char **stuck)
 {
+	enum opt_parsed flags = OPT_LONG;
 	const char *arg_end = strchrnul(arg, '=');
 	const char *arg_start = arg;
-	enum opt_parsed flags = OPT_LONG;
 	int arg_starts_with_no_no = 0;
-	struct parsed_option abbrev = { .option = NULL, .flags = OPT_LONG };
-	struct parsed_option ambiguous = { .option = NULL, .flags = OPT_LONG };
+
+	found->option = NULL;
+	found->flags = OPT_LONG;
+	other->option = NULL;
+	other->flags = OPT_LONG;
+	*stuck = NULL;
 
 	if (skip_prefix(arg_start, "no-", &arg_start)) {
 		if (skip_prefix(arg_start, "no-", &arg_start))
@@ -554,43 +584,74 @@ static enum parse_opt_result parse_long_opt(
 
 		if (skip_prefix(arg_start, long_name, &rest)) {
 			if (*rest == '=')
-				p->opt = rest + 1;
+				*stuck = rest + 1;
 			else if (*rest)
 				continue;
-			return get_value(p, options, flags ^ opt_flags);
+			found->option = options;
+			found->flags = flags ^ opt_flags;
+			return LONG_OPT_EXACT;
 		}
 
 		/* abbreviated? */
 		if (!strncmp(long_name, arg_start, arg_end - arg_start))
 			register_abbrev(p, options, flags ^ opt_flags,
-					&abbrev, &ambiguous);
+					found, other);
 
 		/* negated and abbreviated very much? */
 		if (allow_unset && starts_with("no-", arg))
 			register_abbrev(p, options, OPT_UNSET ^ opt_flags,
-					&abbrev, &ambiguous);
+					found, other);
 	}
 
-	if (disallow_abbreviated_options && (ambiguous.option || abbrev.option))
-		die("disallowed abbreviated or ambiguous option '%.*s'",
-		    (int)(arg_end - arg), arg);
-
-	if (ambiguous.option) {
-		error(_("ambiguous option: %s "
-			"(could be --%s%s or --%s%s)"),
-			arg,
-			(ambiguous.flags & OPT_UNSET) ?  "no-" : "",
-			ambiguous.option->long_name,
-			(abbrev.flags & OPT_UNSET) ?  "no-" : "",
-			abbrev.option->long_name);
-		return PARSE_OPT_HELP_ERROR;
-	}
-	if (abbrev.option) {
+	if (other->option)
+		return LONG_OPT_AMBIGUOUS;
+
+	if (found->option) {
 		if (*arg_end)
-			p->opt = arg_end + 1;
-		return get_value(p, abbrev.option, abbrev.flags);
+			*stuck = arg_end + 1;
+		return LONG_OPT_ABBREV;
 	}
-	return PARSE_OPT_UNKNOWN;
+
+	return LONG_OPT_UNKNOWN;
+}
+
+static enum parse_opt_result parse_long_opt(struct parse_opt_ctx_t *p,
+					    const char *arg,
+					    const struct option *options)
+{
+	struct parsed_option found;
+	struct parsed_option other;
+	const char *stuck;
+	enum long_opt_lookup result = lookup_long_opt(p, arg, options,
+						      &found, &other, &stuck);
+
+	switch (result) {
+	case LONG_OPT_UNKNOWN:
+		return PARSE_OPT_UNKNOWN;
+	case LONG_OPT_ABBREV:
+	case LONG_OPT_AMBIGUOUS:
+		if (disallow_abbreviated_options) {
+			const char *arg_end = strchrnul(arg, '=');
+			die("disallowed abbreviated or ambiguous option '%.*s'",
+			    (int)(arg_end - arg), arg);
+		}
+		if (result == LONG_OPT_AMBIGUOUS) {
+			error(_("ambiguous option: %s "
+				"(could be --%s%s or --%s%s)"),
+			      arg,
+			      (other.flags & OPT_UNSET) ? "no-" : "",
+			      other.option->long_name,
+			      (found.flags & OPT_UNSET) ? "no-" : "",
+			      found.option->long_name);
+			return PARSE_OPT_HELP_ERROR;
+		}
+		/* fallthru */
+	case LONG_OPT_EXACT:
+		p->opt = stuck;
+		return get_value(p, found.option, found.flags);
+	}
+
+	BUG("unknown enum long_opt_lookup value '%d'", result);
 }
 
 static enum parse_opt_result parse_nodash_opt(struct parse_opt_ctx_t *p,
-- 
2.56.0.4.gceeb21e89e

