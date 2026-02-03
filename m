Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0409021B9FD
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113888; cv=none; b=Qbihst/MF/1RpT/ckEaGE0aEfYe9usvnc53JR5f0YIXltaQgjHrm6wNgr7CeaMyQR0OWAXla9eU7S7jUzuWcPAQY0mmXKtPoSbWw9kIxwRrKVYKxEbJWRbZIG+uGSu8NZc54WV0fCNcHPSPjBT2/vyopTBfzakX4ZE1V9rdlzHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113888; c=relaxed/simple;
	bh=4rw82rR7AQjntIinmSle7kVyrof6PcAzIASs6x8kkHE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PNg/d/lpPFm6MBxmx97dtog6/9D+JDcCOh9hXhrykzH8zkZYhbOqFJxVmjBS5jnpOZKGrDpvK38mCTjUr+0sl1OHFVwFZFToR9aC7HlRxRQEkRbWmV0DcIrXyBS243AFQDBMt0cIOipaOzpHnM7L10RaJ9ts8NhAh3oUTg5IhuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5YMatdF; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5YMatdF"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b71557299dso5541516eec.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 02:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770113886; x=1770718686; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+ryvqx4gGdLtEp7cDMCa1bwO+odMmFuhYeTLB+E5BM=;
        b=I5YMatdFXYkMSBA8KhQCGKkSauyTbBGEv3STyzDV74q8p90jZWVDs9de8VQ5wAODXa
         5ezUs56tW3CAdGUEmUL1Cxin8v3X7pmaGxNqrqwUGlzMYBWNBmrpIeRZbyZloEJruDy7
         l9XLUATOUfKStQGHGLsaeZq/3wkTjSQyHGTCGxzQ1agiiW5CBm9YhWQrw0lJUoyGHMQM
         INuxpHeHo8XIDc91ASxcESjiG6nK4ASNfRPPWu5ysp/M+5a+AtmxTcLFyFNAo1jvRqW9
         daNNWuTXL+To4r/HEGSBQhArbXX26q1y6sHGaJu6C684R4LGGIGH4ng+a9xpypahkkIC
         MEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770113886; x=1770718686;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5+ryvqx4gGdLtEp7cDMCa1bwO+odMmFuhYeTLB+E5BM=;
        b=Q4Jl0HXtzBkG+n6A6UseAb9FbDvWHmyQLoSq51E6amZDftT+brbPVop6yhpbg2UXPu
         KJiXZOwlAZSGAVY9KUgwZJYdtcbV+g3pR143xlqs9ra/TYXLcQukckOV/z6OOwEP1bPp
         JsLvzRfcrJT7SHPvny06i7BQw4nFm0xLR/hmpjDc21K/bRH2gIn29RwU7ifq19FFYT9b
         RpIC+XoMvsxHIOnoCTMeceV8IlBUUITFEWF7913u+KBPENV7OmbG6Fbn7V/Gpmct88rC
         k8dPOTGO/MqkQ9ONuuyrla0Rq8I/gRnM/uLEfpPORg7gbT7YeAIzHEzithe4UvTQynDe
         LV1Q==
X-Gm-Message-State: AOJu0Yy2UQH/0bvnaNTcALTPfJf2z6JJihtIsVzp/RTXl3P8ubmSCu9w
	hyZ7sSXrrkJDq2Tyx7H6yR2EsuU7PJef4PAeQcbNLQS7uJWBr/wSstZVmnFJ5JX2
X-Gm-Gg: AZuq6aI6/5PG2OZNsscrDLtfUB/Ogq8Bizd8+3BPNvDHll8esh0mekMm8Z5mt7X0IaS
	cW3q1E/LcAVuB6xC0LKI91nCbnD5Lr+QxUUcXbyC8WAkAwEVAiXZ2Amk2IwvwKhj0JuVWLrFmIF
	88IaI2+eZDYQiQSvW0zZKmuggIDw5J9O8IR1i4l+s1K3LjEUx7fNScYLydRn6YiShiT1fd/w2M9
	0cC2b4KfYAi4AdLxtGCrrtbIysRccn3REP1ydLPvBPAljQybk7wHyYtrLdZqcuV9iRyHZS0u6Ft
	um0J4MaYIAp1yi6NxnD+3+P9iE2+G1Zt30bHPVLn+JIBhcKiRdCR53eu+dHksg5ckI8vn0CHFwi
	ubtnCnHc7fl5Dsi68vpIrz8hhQyTP4i6XoyEDLXTf4Zz97zR5UihPlbJubUhPMKUJavZCswJMjl
	lEmkOY5EmoftfPaQ==
X-Received: by 2002:a05:693c:2b15:b0:2b8:209d:5983 with SMTP id 5a478bee46e88-2b8209d5c1fmr882872eec.29.1770113885486;
        Tue, 03 Feb 2026 02:18:05 -0800 (PST)
Received: from [127.0.0.1] ([128.24.162.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe92dsm21894091eec.17.2026.02.03.02.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:18:04 -0800 (PST)
Message-Id: <pull.1853.v4.git.1770113882.gitgitgadget@gmail.com>
In-Reply-To: <pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
References: <pull.1853.v3.git.1768602373.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Feb 2026 10:17:56 +0000
Subject: [PATCH v4 0/6] Sanitize sideband channel messages
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Andreas Schwab <schwab@linux-m68k.org>,
    Ondrej Pohorelsky <opohorel@redhat.com>,
    Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

Git's sideband channel passes server output directly to the client terminal
without sanitizing it, creating an ANSI escape sequence injection
vulnerability (CWE-150 [https://cwe.mitre.org/data/definitions/150.html]). A
malicious or compromised server can corrupt terminal state, obscure
information, or inject characters into the terminal's input buffer (which
the terminal will interpret as if the user had typed them).

Git users have no mechanism to distinguish between Git's legitimate output
and content displayed (or hidden) via attack sequences.

This series aims to fix the vulnerability by sanitizing control characters
in the sideband output. To address concerns about existing hacks that
exploit Git's lack of sanitizing, this security fix will only kick in with
Git v3.0, where the default will change to pass ANSI color sequences (SGR
codes) through by default, since server-side hooks exist that use these for
visibility (e.g. https://github.com/kikeonline/githook-explode). By default,
all other control characters will be rendered in caret notation (e.g., ESC
becomes ^[).

Users who need different behavior get configuration options:
sideband.allowControlCharacters provides an escape hatch for environments
that require raw passthrough. The defaults in Git v3.0 will be secure.

This series applies cleanly on v2.53.0.

Changes since v3:

 * Targeting maint-2.53 now instead of maint-2.47.
 * Turned the "safe by default" behavior into a breaking change that will be
   in effect in Git v3.0.

Changes since v2:

 * Added curly brackets around a single-line if clause.
 * Enclosed the values in the documentation within backticks.
 * Aligned the enum values for better readability.
 * Added support for sideband.<url>.allowControlCharacters (à la
   http.<url>.*) on top of sideband.allowControlCharacters.

Changes since v1:

 * Applied the suggestions by Phillip and brian.
 * Rebased onto v2.47.3.
 * Added more categories of ANSI Escape sequences that can be enabled (but
   that are off by default because they could be used to hide information).

Johannes Schindelin (6):
  sideband: mask control characters
  sideband: introduce an "escape hatch" to allow control characters
  sideband: do allow ANSI color sequences by default
  sideband: add options to allow more control sequences to be passed
    through
  sideband: offer to configure sanitizing on a per-URL basis
  sideband: delay sanitizing by default to Git v3.0

 Documentation/config.adoc           |   2 +
 Documentation/config/sideband.adoc  |  39 ++++++
 sideband.c                          | 185 +++++++++++++++++++++++++++-
 sideband.h                          |  14 +++
 t/t5409-colorize-remote-messages.sh | 100 +++++++++++++++
 transport.c                         |   3 +
 6 files changed, 341 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/config/sideband.adoc


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1853%2Fdscho%2Fsanitize-sideband-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1853/dscho/sanitize-sideband-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1853

Range-diff vs v3:

 1:  e6b71af0ca = 1:  7addb9ca52 sideband: mask control characters
 2:  8f64d65844 ! 2:  20058534e8 sideband: introduce an "escape hatch" to allow control characters
     @@ Commit message
          Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     - ## Documentation/config.txt ##
     -@@ Documentation/config.txt: include::config/sequencer.txt[]
     + ## Documentation/config.adoc ##
     +@@ Documentation/config.adoc: include::config/sequencer.adoc[]
       
     - include::config/showbranch.txt[]
     + include::config/showbranch.adoc[]
       
     -+include::config/sideband.txt[]
     ++include::config/sideband.adoc[]
      +
     - include::config/sparse.txt[]
     + include::config/sparse.adoc[]
       
     - include::config/splitindex.txt[]
     + include::config/splitindex.adoc[]
      
     - ## Documentation/config/sideband.txt (new) ##
     + ## Documentation/config/sideband.adoc (new) ##
      @@
      +sideband.allowControlCharacters::
      +	By default, control characters that are delivered via the sideband
     @@ sideband.c: static struct keyword_entry keywords[] = {
      +static int allow_control_characters;
      +
       /* Returns a color setting (GIT_COLOR_NEVER, etc). */
     - static int use_sideband_colors(void)
     + static enum git_colorbool use_sideband_colors(void)
       {
     -@@ sideband.c: static int use_sideband_colors(void)
     - 	if (use_sideband_colors_cached >= 0)
     +@@ sideband.c: static enum git_colorbool use_sideband_colors(void)
     + 	if (use_sideband_colors_cached != GIT_COLOR_UNKNOWN)
       		return use_sideband_colors_cached;
       
     -+	git_config_get_bool("sideband.allowcontrolcharacters",
     ++	repo_config_get_bool(the_repository, "sideband.allowcontrolcharacters",
      +			    &allow_control_characters);
      +
     - 	if (!git_config_get_string_tmp(key, &value))
     + 	if (!repo_config_get_string_tmp(the_repository, key, &value))
       		use_sideband_colors_cached = git_config_colorbool(key, value);
     - 	else if (!git_config_get_string_tmp("color.ui", &value))
     + 	else if (!repo_config_get_string_tmp(the_repository, "color.ui", &value))
      @@ sideband.c: void list_config_color_sideband_slots(struct string_list *list, const char *pref
       
       static void strbuf_add_sanitized(struct strbuf *dest, const char *src, int n)
 3:  44838acacc ! 3:  919111f590 sideband: do allow ANSI color sequences by default
     @@ Commit message
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     - ## Documentation/config/sideband.txt ##
     + ## Documentation/config/sideband.adoc ##
      @@
       sideband.allowControlCharacters::
       	By default, control characters that are delivered via the sideband
     @@ sideband.c: static struct keyword_entry keywords[] = {
      +} allow_control_characters = ALLOW_ANSI_COLOR_SEQUENCES;
       
       /* Returns a color setting (GIT_COLOR_NEVER, etc). */
     - static int use_sideband_colors(void)
     -@@ sideband.c: static int use_sideband_colors(void)
     - 	if (use_sideband_colors_cached >= 0)
     + static enum git_colorbool use_sideband_colors(void)
     +@@ sideband.c: static enum git_colorbool use_sideband_colors(void)
     + 	if (use_sideband_colors_cached != GIT_COLOR_UNKNOWN)
       		return use_sideband_colors_cached;
       
     --	git_config_get_bool("sideband.allowcontrolcharacters",
     +-	repo_config_get_bool(the_repository, "sideband.allowcontrolcharacters",
      -			    &allow_control_characters);
     -+	switch (git_config_get_maybe_bool("sideband.allowcontrolcharacters", &i)) {
     ++	switch (repo_config_get_maybe_bool(the_repository, "sideband.allowcontrolcharacters", &i)) {
      +	case 0: /* Boolean value */
      +		allow_control_characters = i ? ALLOW_ALL_CONTROL_CHARACTERS :
      +			ALLOW_NO_CONTROL_CHARACTERS;
      +		break;
      +	case -1: /* non-Boolean value */
     -+		if (git_config_get_string_tmp("sideband.allowcontrolcharacters",
     ++		if (repo_config_get_string_tmp(the_repository, "sideband.allowcontrolcharacters",
      +					      &value))
      +			; /* huh? `get_maybe_bool()` returned -1 */
      +		else if (!strcmp(value, "default"))
     @@ sideband.c: static int use_sideband_colors(void)
      +		break; /* not configured */
      +	}
       
     - 	if (!git_config_get_string_tmp(key, &value))
     + 	if (!repo_config_get_string_tmp(the_repository, key, &value))
       		use_sideband_colors_cached = git_config_colorbool(key, value);
      @@ sideband.c: void list_config_color_sideband_slots(struct string_list *list, const char *pref
       		list_config_item(list, prefix, keywords[i].keyword);
 4:  cc578465b9 ! 4:  ec48f1cba1 sideband: add options to allow more control sequences to be passed through
     @@ Commit message
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     - ## Documentation/config/sideband.txt ##
     -@@ Documentation/config/sideband.txt: sideband.allowControlCharacters::
     + ## Documentation/config/sideband.adoc ##
     +@@ Documentation/config/sideband.adoc: sideband.allowControlCharacters::
       	By default, control characters that are delivered via the sideband
       	are masked, except ANSI color sequences. This prevents potentially
       	unwanted ANSI escape sequences from being sent to the terminal. Use
     @@ sideband.c: static struct keyword_entry keywords[] = {
      +}
       
       /* Returns a color setting (GIT_COLOR_NEVER, etc). */
     - static int use_sideband_colors(void)
     -@@ sideband.c: static int use_sideband_colors(void)
     - 		if (git_config_get_string_tmp("sideband.allowcontrolcharacters",
     + static enum git_colorbool use_sideband_colors(void)
     +@@ sideband.c: static enum git_colorbool use_sideband_colors(void)
     + 		if (repo_config_get_string_tmp(the_repository, "sideband.allowcontrolcharacters",
       					      &value))
       			; /* huh? `get_maybe_bool()` returned -1 */
      -		else if (!strcmp(value, "default"))
 5:  f2eb0a758c ! 5:  692d1a63ed sideband: offer to configure sanitizing on a per-URL basis
     @@ Commit message
          Suggested-by: Junio Hamano <gitster@pobox.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     - ## Documentation/config/sideband.txt ##
     -@@ Documentation/config/sideband.txt: sideband.allowControlCharacters::
     + ## Documentation/config/sideband.adoc ##
     +@@ Documentation/config/sideband.adoc: sideband.allowControlCharacters::
       	`true`::
       		Allow all control characters to be sent to the terminal.
       --
     @@ sideband.c: static void parse_allow_control_characters(const char *value)
      +	config.collect_fn = sideband_config_callback;
      +
      +	normalized_url = url_normalize(url, &config.url);
     -+	git_config(urlmatch_config_entry, &config);
     ++	repo_config(the_repository, urlmatch_config_entry, &config);
      +	free(normalized_url);
      +	string_list_clear(&config.vars, 1);
      +	urlmatch_config_release(&config);
       }
       
       /* Returns a color setting (GIT_COLOR_NEVER, etc). */
     -@@ sideband.c: static int use_sideband_colors(void)
     - 	if (use_sideband_colors_cached >= 0)
     +@@ sideband.c: static enum git_colorbool use_sideband_colors(void)
     + 	if (use_sideband_colors_cached != GIT_COLOR_UNKNOWN)
       		return use_sideband_colors_cached;
       
     --	switch (git_config_get_maybe_bool("sideband.allowcontrolcharacters", &i)) {
     +-	switch (repo_config_get_maybe_bool(the_repository, "sideband.allowcontrolcharacters", &i)) {
      -	case 0: /* Boolean value */
      -		allow_control_characters = i ? ALLOW_ALL_CONTROL_CHARACTERS :
      -			ALLOW_NO_CONTROL_CHARACTERS;
      -		break;
      -	case -1: /* non-Boolean value */
     --		if (git_config_get_string_tmp("sideband.allowcontrolcharacters",
     +-		if (repo_config_get_string_tmp(the_repository, "sideband.allowcontrolcharacters",
      -					      &value))
      -			; /* huh? `get_maybe_bool()` returned -1 */
      -		else
     @@ sideband.c: static int use_sideband_colors(void)
      -	default:
      -		break; /* not configured */
      +	if (allow_control_characters == ALLOW_CONTROL_SEQUENCES_UNSET) {
     -+		if (!git_config_get_value("sideband.allowcontrolcharacters", &value))
     ++		if (!repo_config_get_value(the_repository, "sideband.allowcontrolcharacters", &value))
      +			sideband_allow_control_characters_config("sideband.allowcontrolcharacters", value);
      +
      +		if (allow_control_characters == ALLOW_CONTROL_SEQUENCES_UNSET)
      +			allow_control_characters = ALLOW_DEFAULT_ANSI_SEQUENCES;
       	}
       
     - 	if (!git_config_get_string_tmp(key, &value))
     + 	if (!repo_config_get_string_tmp(the_repository, key, &value))
      
       ## sideband.h ##
      @@ sideband.h: int demultiplex_sideband(const char *me, int status,
     @@ transport.c
       #include "bundle-uri.h"
      +#include "sideband.h"
       
     - static int transport_use_color = -1;
     + static enum git_colorbool transport_use_color = GIT_COLOR_UNKNOWN;
       static char transport_colors[][COLOR_MAXLEN] = {
      @@ transport.c: struct transport *transport_get(struct remote *remote, const char *url)
       
     - 	ret->hash_algo = &hash_algos[GIT_HASH_SHA1];
     + 	ret->hash_algo = &hash_algos[GIT_HASH_SHA1_LEGACY];
       
      +	sideband_apply_url_config(ret->url);
      +
 -:  ---------- > 6:  8b8244eca9 sideband: delay sanitizing by default to Git v3.0

-- 
gitgitgadget
