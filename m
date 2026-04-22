Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7A430F938
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871561; cv=none; b=lmJjvS6FB7IF4QVKJvg95RhBlTlJtAnRbR26nPSykf1g4PDFeje7exqxSDdEicijhn58t8S4NCYBTEKT38vlTgF4nnXURqe3OHUuHApDdRb1vbuHFAKzOv+1XG8prj8KUhpQensUHt6RNh5+aYujnVZ6NdzPauEsyhXtfVKeOVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871561; c=relaxed/simple;
	bh=iIfyKRAie/8pgtsjNess1EAAuqvuTXnZG7VjEcqBZ9Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qZ4mgeCBXjtfDy91h0hPeSKF9YqfF8rgZw6zaIZwa8uTG1jafYxaQ6xzy34YsGGu3kuY4W9CFw7sYqWnAQvXD0Csyrgf3k6i04mB8JfGT8vGPxX0lD5alIH2xYFBGaGXtJ2gMVodWx9foq+SseUuSdSLjOYFBh2tFhaACjFi1XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=svGC5fDX; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svGC5fDX"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2e622a9da9cso5937418eec.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776871549; x=1777476349; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyT8gNuExzM1YsxbAVa9jt1VXJJnjDkvtyeGNKlx1k4=;
        b=svGC5fDXaHI554Oj4up61MCO9c/nn+SlJK+GyeT0IdZG3kIA6TSdDpI+E7Ohp7cwOm
         7soSfMcxqGQpwAUrCKU8Q2k/3KafuDaKjoBrJ9Agfn1DGFOWaeh5VpmRa2YVa2rOhVTy
         di5lek7hzdkLuizl+JUaKGe29EdYH+m4wcYO4u2ZBcipPBluoaPwv4oKOXFlVCh47vS+
         SXJu79ZMbpSWtGvB/BAS9wxFe5+kaMIZbco9PC9xd5fvRX7KMv+gADxuigqy17Rps7Fc
         2ZaB5NQwZSjwWpBhPc6JdyNTTQem3AEJ1EKPMuGoj1C5yCIDz2pAA10taRhkBD+W6pFP
         9xQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871549; x=1777476349;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JyT8gNuExzM1YsxbAVa9jt1VXJJnjDkvtyeGNKlx1k4=;
        b=hOqRfVWkRtPGXtRKQRi4+VMA5tSCgvVlniTQJdtrQHoPNH2NxhyW81Ay1qxu+f6ysA
         HVKiSpC5S/daNZwt45/MaRl5B0dpoKB4JhNYaOWWGpRc1UyBe0TuHi6rNrzk0YhJcSIN
         OvggycA7Og/EcDAJ6zW6hTf/jPtc1Ks5ISVJ5VojcCPhnbp8YSAOnfDDKcFnyC6lWEJ6
         ubZ164diEJ0z/WTZHSytBfuo2Ur77t+MAc9Rnf8rKb8FoECOKICWtzUjJhf6Bqf9waWd
         lS+hdDZT+/0X9FvLJ8ERYFSe8npSNIucrdhh7hYOc+MnuMwMe+Fq+vLIQHn00bJE7/Lp
         qtQA==
X-Gm-Message-State: AOJu0YxP5GU7RwIkqL31IUfG7UJCYceCwI/ffHMkvYMzVBXzIYmks7b/
	qO8Y6Z918aFejI1kk8DMaU4hnfBNofrfJD1gzj2+RHLpLyH2TebcEgcZIEys3w==
X-Gm-Gg: AeBDievVYdOlUGochG5p12CePG4hVU1PYOw9U0AksvGxniYUL1I84ep14JxPVu3/fdm
	tLQ67juI5PLmqduCvAOfJVsYgk0UGNmZIvuxHHnCShlgVM8nCYc5QtmAnOC+1j2vgROgi0IS8P6
	ZfOs4QEMWRGi5g+AECZI6jStsXB7DoqY/102/FMOR6xEHAdHK0K0jAFlvWWbyZYFl8RxFczbQNq
	oBwQQR2gbE0+5S4pZzuv1CZGv7ltxA0h1E1UGY6zoaNasVvitAUvtu+rqAVAVX1NFXBh6WgzzND
	6mwfa7xXtEYMKknWeB6KwWqNREVtRhFN2zJ/IsMs/vFnL7qGHKtZ8Ig13iaq7LvtOQ9kXBU/rkH
	m3F4tYhv690RGvcG4yUPt/Tr3BV3egVcK/+Dy23jOkzI1xHF1oUppjoIAA3T4ggqQRiTVw5E4Bw
	2ioo6rwGUajc8qW1FjGgT0iN6D6yoG28xeWHkGfA==
X-Received: by 2002:a05:7301:5784:b0:2de:c5ca:c1f3 with SMTP id 5a478bee46e88-2e465293dfdmr12379372eec.4.1776871548584;
        Wed, 22 Apr 2026 08:25:48 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa244csm22869546eec.2.2026.04.22.08.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:25:47 -0700 (PDT)
Message-Id: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Apr 2026 15:25:39 +0000
Subject: [PATCH v3 0/7] fetch: rework negotiation tip options
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
Cc: gitster@pobox.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>

Fetch negotiation aims to find enough information from haves and wants such
that the server can be reasonably confident that it will send all necessary
objects and not too many "extra" objects that the client already has.
However, this can break down if there are too many references, since Git
truncates the list of haves based on a few factors (a 256 count limit or the
server sending an ACK at the right time).

We already have the --negotiation-tip feature to focus the set of references
that are used in negotiation, but I feel like this is designed backwards.
I'd rather that we have a way to say "this is an important set of refs, but
feel free to add more refs if needed" than "only use these refs for
negotiation".

Here's an example that demonstrates the problem. In an internal monorepo,
developers work off of the 'main' branch so there are thousands of user
branches that each add a few commits different from the 'main' branch.
However, there is also a long-lived 'release' branch. This branch has a
first-parent history that is parallel to 'main' and each of those commits is
a merge whose second parent is a commit from 'main' that had a successful CI
run. There are additional changes in the 'release' branch merge commits that
add some changelog data, so there is a nontrivial set of novel blob content
in that branch and not just a different set of commits.

The problem we had was that our georeplication system was regularly fetching
from the origin and trying to get all data from all reachable branches. When
the 'release' branch updated, the client would run out of haves before
advertising its copy of the 'release' branch, but it would still list the
new 'release' tip as a want. The server would then think that the client had
never fetched that branch before and would send all of the changelog data
from the whole history of the repo. (This led to a lot of downstream
problems; we mitigated by setting a refspec that stopped fetching the
'release' branch, but this is not ideal.)

What I'd like is a mechanism to say "always advertise the client's version
of 'main' and 'release' but also opportunistically include some user
branches".

Based on my understanding, the '--negotiation-tip' option is close but not
quite what I want. I could have the client only advertise 'release' and
'main' and never advertise any user branches. But then we'd download all
content from each user branch every time it updates. Perhaps this would
happen even with opportunistic inclusion of more haves, but I'd like to
explore this area more.

There's also an issue that the '--negotiation-tip' feature doesn't seem to
have a config key that enables it without CLI arguments. This is something
that we could consider independently.

This patch series adds a new '--negotiation-include' option that does what I
want: it makes sure that these references are included as 'have's during
negotiation. In order to help clarify the difference between this and
'--negotiation-tip', I first create a synonym called
'--negotiation-restrict'.

Both of these options get 'remote.*.negotiation(Include|Restrict)' config
options that enable their behavior by default.

During development, I had briefly considered only using config values, but
that required some strange changes to care about the remote name in the
transport layer. This was most different in the 'git push' integration. When
I discovered the '--negotiation-tip' feature during the process, that gave
me a clear pattern to follow with the addition of a config on top.


Updates in v2
=============

This version is a near-complete rewrite based on feedback around the names
of the previous option and config. The --negotiation-restrict option is new
and the ability to set it via config is also new.

I did try to be more careful around translatable error messages, too.


Updates in v3
=============

 * --negotiation-tip is now an alias of --negotiation-restrict.
 * More translatable strings use %s to isolate non-translatable options from
   translatable words.
 * The string_list named negotiation_tip is now renamed to
   negotiation_restrict.
 * The config options now allow an empty value to reset the list.
 * The --negotiation-require option is now called --negotiation-include.
 * Similarly, the config option is renamed and all code references.
 * The included haves now mark their commits as COMMON so commits that they
   can reach are not included in the negotiation walk if they are reached
   from the restricted commits.
 * The ref iterators are more careful about failing on bad references (ref
   exists but object doesn't) and ignoring missing references (perhaps
   config is erroneous?).
 * When sending tips during push negotiation, use the --negotiation-restrict
   option instead of -tip.

Thanks, -Stolee

Derrick Stolee (7):
  t5516: fix test order flakiness
  fetch: add --negotiation-restrict option
  transport: rename negotiation_tips
  remote: add remote.*.negotiationRestrict config
  fetch: add --negotiation-include option for negotiation
  remote: add remote.*.negotiationInclude config
  send-pack: pass negotiation config in push

 Documentation/config/remote.adoc |  46 +++++++++
 Documentation/fetch-options.adoc |  27 +++++
 builtin/fetch.c                  |  70 ++++++++++---
 builtin/pull.c                   |   6 ++
 fetch-pack.c                     | 130 +++++++++++++++++++++---
 fetch-pack.h                     |  14 ++-
 remote.c                         |  16 +++
 remote.h                         |   2 +
 send-pack.c                      |  39 ++++++--
 send-pack.h                      |   2 +
 t/t5510-fetch.sh                 | 166 +++++++++++++++++++++++++++++++
 t/t5516-fetch-push.sh            |  32 +++++-
 t/t5702-protocol-v2.sh           |   4 +-
 transport-helper.c               |   2 +-
 transport.c                      |  16 +--
 transport.h                      |  10 +-
 16 files changed, 529 insertions(+), 53 deletions(-)


base-commit: 6e8d538aab8fe4dd07ba9fb87b5c7edcfa5706ad
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2085%2Fderrickstolee%2Fmust-have-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2085/derrickstolee/must-have-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2085

Range-diff vs v2:

 1:  466c56abe0 = 1:  466c56abe0 t5516: fix test order flakiness
 2:  9a25b0fade ! 2:  fe875399a8 fetch: add --negotiation-restrict option
     @@ Commit message
          For now, create a new synonym option, --negotiation-restrict, that
          behaves identically to --negotiation-tip. Update the documentation to
          make it clear that this new name is the preferred option, but we keep
     -    the old name for compatibility.
     +    the old name for compatibility. Mark --negotiation-tip as an alias of the
     +    new, preferred option.
      
          Update a few warning messages with the new option, but also make them
          translatable with the option name inserted by formatting. At least one
     @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remot
       	return transport;
       }
      @@ builtin/fetch.c: int cmd_fetch(int argc,
     + 			       N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg),
     + 		OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specific"), N_("option to transmit")),
       		OPT_IPVERSION(&family),
     - 		OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
     - 				N_("report that we have only objects reachable from this object")),
     +-		OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
      +		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_tip, N_("revision"),
     -+				N_("report that we have only objects reachable from this object")),
     + 				N_("report that we have only objects reachable from this object")),
     ++		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
       		OPT_BOOL(0, "negotiate-only", &negotiate_only,
       			 N_("do not fetch a packfile; instead, print ancestors of negotiation tips")),
       		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
     @@ builtin/fetch.c: int cmd_fetch(int argc,
       
       	if (negotiate_only && !negotiation_tip.nr)
      -		die(_("--negotiate-only needs one or more --negotiation-tip=*"));
     -+		die(_("--negotiate-only needs one or more --negotiation-restrict=*"));
     ++		die(_("%s needs one or more %s"), "--negotiate-only",
     ++		    "--negotiation-restrict=*");
       
       	if (deepen_relative) {
       		if (deepen_relative < 0)
 3:  0f89665aee ! 3:  4332cbf266 transport: rename negotiation_tips
     @@ Commit message
          layer. This requires the builtin to handle parsing refs into collections
          of oids so the transport layer can handle this cleaner form of the data.
      
     +    Also update the string_list used to store the inputs from command-line
     +    options.
     +
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## builtin/fetch.c ##
     +@@ builtin/fetch.c: static struct transport *gtransport;
     + static struct transport *gsecondary;
     + static struct refspec refmap = REFSPEC_INIT_FETCH;
     + static struct string_list server_options = STRING_LIST_INIT_DUP;
     +-static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
     ++static struct string_list negotiation_restrict = STRING_LIST_INIT_NODUP;
     + 
     + struct fetch_config {
     + 	enum display_format display_format;
      @@ builtin/fetch.c: static int add_oid(const struct reference *ref, void *cb_data)
       	return 0;
       }
     @@ builtin/fetch.c: static int add_oid(const struct reference *ref, void *cb_data)
       {
       	struct oid_array *oids = xcalloc(1, sizeof(*oids));
       	int i;
     + 
     +-	for (i = 0; i < negotiation_tip.nr; i++) {
     +-		const char *s = negotiation_tip.items[i].string;
     ++	for (i = 0; i < negotiation_restrict.nr; i++) {
     ++		const char *s = negotiation_restrict.items[i].string;
     + 		struct refs_for_each_ref_options opts = {
     + 			.pattern = s,
     + 		};
      @@ builtin/fetch.c: static void add_negotiation_tips(struct git_transport_options *smart_options)
       			warning(_("ignoring %s=%s because it does not match any refs"),
       				"--negotiation-restrict", s);
     @@ builtin/fetch.c: static void add_negotiation_tips(struct git_transport_options *
       
       static struct transport *prepare_transport(struct remote *remote, int deepen,
      @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remote, int deepen,
     + 		set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER, spec);
     + 		set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
       	}
     - 	if (negotiation_tip.nr) {
     +-	if (negotiation_tip.nr) {
     ++	if (negotiation_restrict.nr) {
       		if (transport->smart_options)
      -			add_negotiation_tips(transport->smart_options);
      +			add_negotiation_restrict_tips(transport->smart_options);
       		else
       			warning(_("ignoring %s because the protocol does not support it"),
       				"--negotiation-restrict");
     +@@ builtin/fetch.c: int cmd_fetch(int argc,
     + 			       N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg),
     + 		OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specific"), N_("option to transmit")),
     + 		OPT_IPVERSION(&family),
     +-		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_tip, N_("revision"),
     ++		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_restrict, N_("revision"),
     + 				N_("report that we have only objects reachable from this object")),
     + 		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
     + 		OPT_BOOL(0, "negotiate-only", &negotiate_only,
     +@@ builtin/fetch.c: int cmd_fetch(int argc,
     + 		config.display_format = DISPLAY_FORMAT_PORCELAIN;
     + 	}
     + 
     +-	if (negotiate_only && !negotiation_tip.nr)
     ++	if (negotiate_only && !negotiation_restrict.nr)
     + 		die(_("%s needs one or more %s"), "--negotiate-only",
     + 		    "--negotiation-restrict=*");
     + 
      
       ## fetch-pack.c ##
      @@ fetch-pack.c: static int next_flush(int stateless_rpc, int count)
 4:  a731f4fc87 ! 4:  d2f48b78b5 remote: add remote.*.negotiationRestrict config
     @@ Commit message
          If the user provides even one --negotiation-restrict argument, then the
          config is ignored.
      
     +    An empty value resets the value list to allow ignoring earlier config
     +    values, such as those that might be set in system or global config.
     +
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/config/remote.adoc ##
     @@ Documentation/config/remote.adoc: priority configuration file (e.g. `.git/config
      +command-line option.  If `--negotiation-restrict` (or its synonym
      +`--negotiation-tip`) is specified on the command line, then the config
      +values are not used.
     +++
     ++Blank values signal to ignore all previous values, allowing a reset of
     ++the list from broader config scenarios.
      +
       remote.<name>.followRemoteHEAD::
       	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`
     @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remot
      +	} else if (remote->negotiation_restrict.nr) {
      +		struct string_list_item *item;
      +		for_each_string_list_item(item, &remote->negotiation_restrict)
     -+			string_list_append(&negotiation_tip, item->string);
     ++			string_list_append(&negotiation_restrict, item->string);
      +		if (transport->smart_options)
      +			add_negotiation_restrict_tips(transport->smart_options);
      +		else {
     @@ builtin/fetch.c: int cmd_fetch(int argc,
       		config.display_format = DISPLAY_FORMAT_PORCELAIN;
       	}
       
     --	if (negotiate_only && !negotiation_tip.nr)
     --		die(_("--negotiate-only needs one or more --negotiation-restrict=*"));
     -+	if (negotiate_only && !negotiation_tip.nr) {
     -+		/*
     -+		 * Defer this check: remote.<name>.negotiationRestrict may
     -+		 * provide defaults in prepare_transport().
     -+		 */
     -+	}
     - 
     +-	if (negotiate_only && !negotiation_restrict.nr)
     +-		die(_("%s needs one or more %s"), "--negotiate-only",
     +-		    "--negotiation-restrict=*");
     +-
       	if (deepen_relative) {
       		if (deepen_relative < 0)
     + 			die(_("negative depth in --deepen is not supported"));
      @@ builtin/fetch.c: int cmd_fetch(int argc,
       		if (!remote)
       			die(_("must supply remote when using --negotiate-only"));
       		gtransport = prepare_transport(remote, 1, &filter_options);
      +		if (!gtransport->smart_options ||
      +		    !gtransport->smart_options->negotiation_restrict_tips)
     -+			die(_("--negotiate-only needs one or more --negotiation-restrict=*"));
     ++			die(_("%s needs one or more %s"), "--negotiate-only",
     ++			    "--negotiation-restrict=*");
       		if (gtransport->smart_options) {
       			gtransport->smart_options->acked_commits = &acked_commits;
       		} else {
     @@ remote.c: static int handle_config(const char *key, const char *value,
       		return parse_transport_option(key, value,
       					      &remote->server_options);
      +	} else if (!strcmp(subkey, "negotiationrestrict")) {
     -+		if (!value)
     -+			return config_error_nonbool(key);
     -+		string_list_append(&remote->negotiation_restrict, value);
     ++		/* reset list on empty value. */
     ++		if (!value || !*value)
     ++			string_list_clear(&remote->negotiation_restrict, 0);
     ++		else
     ++			string_list_append(&remote->negotiation_restrict, value);
       	} else if (!strcmp(subkey, "followremotehead")) {
       		const char *no_warn_branch;
       		if (!strcmp(value, "never"))
     @@ t/t5510-fetch.sh: test_expect_success '--negotiation-restrict and --negotiation-
       
      +test_expect_success 'remote.<name>.negotiationRestrict used as default' '
      +	setup_negotiation_tip server server 0 &&
     ++
     ++	# test the reset of the list on an empty value
     ++	git -C client config --add remote.origin.negotiationRestrict alpha_2 &&
     ++	git -C client config --add remote.origin.negotiationRestrict "" &&
      +	git -C client config --add remote.origin.negotiationRestrict alpha_1 &&
      +	git -C client config --add remote.origin.negotiationRestrict beta_1 &&
      +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
 5:  49c80cef2e ! 5:  ae81ef36a1 fetch: add --negotiation-require option for negotiation
     @@ Metadata
      Author: Derrick Stolee <stolee@gmail.com>
      
       ## Commit message ##
     -    fetch: add --negotiation-require option for negotiation
     +    fetch: add --negotiation-include option for negotiation
      
     -    Add a new --negotiation-require option to 'git fetch', which ensures
     +    Add a new --negotiation-include option to 'git fetch', which ensures
          that certain ref tips are always sent as 'have' lines during fetch
          negotiation, regardless of what the negotiation algorithm selects.
      
     @@ Commit message
          --negotiation-restrict to focus the negotiation to 'dev' and 'release'
          would avoid those problematic downloads, but would still not allow
          advertising potentially-relevant user brances. In this way, the
     -    'require' version solves the problem I mention while allowing
     +    'include' version solves the problem I mention while allowing
          negotiation to pick other references opportunistically. The two options
          can also be combined to allow the best of both worlds.
      
          The argument may be an exact ref name or a glob pattern. Non-existent
     -    refs are silently ignored.
     +    refs are silently ignored. This behavior is also updated in the ref matching
     +    logic for the related --negotiation-restrict option to match.
      
     -    Also add --negotiation-require to 'git pull' passthrough options.
     +    The implementation outputs the requested objects as haves before the
     +    negotiation algorithm kicks in and performs a priority-queue walk from the
     +    tip commits. In order to avoid duplicates, we mark the requested objects as
     +    COMMON so they (and their descendants) are not output by the negotiator. The
     +    negotiator still outputs at least one have before a round is flushed, when
     +    the server could ACK to stop the negotiation.
     +
     +    Also add --negotiation-include to 'git pull' passthrough options.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
     @@ Documentation/fetch-options.adoc: See also the `fetch.negotiationAlgorithm` and
       configuration variables documented in linkgit:git-config[1], and the
       `--negotiate-only` option below.
       
     -+`--negotiation-require=<revision>`::
     ++`--negotiation-include=<revision>`::
      +	Ensure that the given ref tip is always sent as a "have" line
      +	during fetch negotiation, regardless of what the negotiation
      +	algorithm selects.  This is useful to guarantee that common
     @@ Documentation/fetch-options.adoc: See also the `fetch.negotiationAlgorithm` and
      ++
      +If `--negotiation-restrict` is used, the have set is first restricted by
      +that option and then increased to include the tips specified by
     -+`--negotiation-require`.
     ++`--negotiation-include`.
      +
       `--negotiate-only`::
       	Do not fetch anything from the server, and instead print the
     @@ builtin/fetch.c
      @@ builtin/fetch.c: static struct transport *gsecondary;
       static struct refspec refmap = REFSPEC_INIT_FETCH;
       static struct string_list server_options = STRING_LIST_INIT_DUP;
     - static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
     -+static struct string_list negotiation_require = STRING_LIST_INIT_NODUP;
     + static struct string_list negotiation_restrict = STRING_LIST_INIT_NODUP;
     ++static struct string_list negotiation_include = STRING_LIST_INIT_NODUP;
       
       struct fetch_config {
       	enum display_format display_format;
     +@@ builtin/fetch.c: static void add_negotiation_restrict_tips(struct git_transport_options *smart_op
     + 		int old_nr;
     + 		if (!has_glob_specials(s)) {
     + 			struct object_id oid;
     ++
     ++			/* Ignore missing reference. */
     + 			if (repo_get_oid(the_repository, s, &oid))
     +-				die(_("%s is not a valid object"), s);
     ++				continue;
     ++			/* Fail on missing object pointed by ref. */
     + 			if (!odb_has_object(the_repository->objects, &oid, 0))
     + 				die(_("the object %s does not exist"), s);
     ++
     + 			oid_array_append(oids, &oid);
     + 			continue;
     + 		}
      @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remote, int deepen,
       			strbuf_release(&config_name);
       		}
       	}
     -+	if (negotiation_require.nr) {
     ++	if (negotiation_include.nr) {
      +		if (transport->smart_options)
     -+			transport->smart_options->negotiation_require = &negotiation_require;
     ++			transport->smart_options->negotiation_include = &negotiation_include;
      +		else
      +			warning(_("ignoring %s because the protocol does not support it"),
     -+				"--negotiation-require");
     ++				"--negotiation-include");
      +	}
       	return transport;
       }
       
      @@ builtin/fetch.c: int cmd_fetch(int argc,
     + 		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_restrict, N_("revision"),
       				N_("report that we have only objects reachable from this object")),
     - 		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_tip, N_("revision"),
     - 				N_("report that we have only objects reachable from this object")),
     -+		OPT_STRING_LIST(0, "negotiation-require", &negotiation_require, N_("revision"),
     + 		OPT_ALIAS(0, "negotiation-tip", "negotiation-restrict"),
     ++		OPT_STRING_LIST(0, "negotiation-include", &negotiation_include, N_("revision"),
      +				N_("ensure this ref is always sent as a negotiation have")),
       		OPT_BOOL(0, "negotiate-only", &negotiate_only,
       			 N_("do not fetch a packfile; instead, print ancestors of negotiation tips")),
     @@ builtin/pull.c: int cmd_pull(int argc,
       		OPT_PASSTHRU_ARGV(0, "negotiation-restrict", &opt_fetch, N_("revision"),
       			N_("report that we have only objects reachable from this object"),
       			0),
     -+		OPT_PASSTHRU_ARGV(0, "negotiation-require", &opt_fetch, N_("revision"),
     ++		OPT_PASSTHRU_ARGV(0, "negotiation-include", &opt_fetch, N_("revision"),
      +			N_("ensure this ref is always sent as a negotiation have"),
      +			0),
       		OPT_BOOL(0, "show-forced-updates", &opt_show_forced_updates,
     @@ fetch-pack.c: static void send_filter(struct fetch_pack_args *args,
      +static int add_oid_to_oidset(const struct reference *ref, void *cb_data)
      +{
      +	struct oidset *set = cb_data;
     -+	if (odb_has_object(the_repository->objects, ref->oid, 0))
     -+		oidset_insert(set, ref->oid);
     ++	if (!odb_has_object(the_repository->objects, ref->oid, 0))
     ++		die(_("the object %s does not exist"), oid_to_hex(ref->oid));
     ++	oidset_insert(set, ref->oid);
      +	return 0;
      +}
      +
     -+static void resolve_negotiation_require(const struct string_list *negotiation_require,
     ++static void resolve_negotiation_include(const struct string_list *negotiation_include,
      +					struct oidset *result)
      +{
      +	struct string_list_item *item;
      +
     -+	if (!negotiation_require || !negotiation_require->nr)
     ++	if (!negotiation_include || !negotiation_include->nr)
      +		return;
      +
     -+	for_each_string_list_item(item, negotiation_require) {
     ++	for_each_string_list_item(item, negotiation_include) {
      +		if (!has_glob_specials(item->string)) {
      +			struct object_id oid;
     ++
     ++			/* Ignore missing reference. */
      +			if (repo_get_oid(the_repository, item->string, &oid))
      +				continue;
     ++
     ++			/* Fail on missing object pointed by ref. */
      +			if (!odb_has_object(the_repository->objects, &oid, 0))
     -+				continue;
     ++				die(_("the object %s does not exist"),
     ++				    item->string);
     ++
      +			oidset_insert(result, &oid);
      +		} else {
      +			struct refs_for_each_ref_options opts = {
     @@ fetch-pack.c: static int find_common(struct fetch_negotiator *negotiator,
       	struct strbuf req_buf = STRBUF_INIT;
       	size_t state_len = 0;
       	struct packet_reader reader;
     -+	struct oidset negotiation_require_oids = OIDSET_INIT;
     ++	struct oidset negotiation_include_oids = OIDSET_INIT;
       
       	if (args->stateless_rpc && multi_ack == 1)
       		die(_("the option '%s' requires '%s'"), "--stateless-rpc", "multi_ack_detailed");
     @@ fetch-pack.c: static int find_common(struct fetch_negotiator *negotiator,
       	flushes = 0;
       	retval = -1;
      +
     -+	/* Send unconditional haves from --negotiation-require */
     -+	resolve_negotiation_require(args->negotiation_require,
     -+				    &negotiation_require_oids);
     -+	if (oidset_size(&negotiation_require_oids)) {
     ++	/* Send unconditional haves from --negotiation-include */
     ++	resolve_negotiation_include(args->negotiation_include,
     ++				    &negotiation_include_oids);
     ++	if (oidset_size(&negotiation_include_oids)) {
      +		struct oidset_iter iter;
     -+		oidset_iter_init(&negotiation_require_oids, &iter);
     ++		oidset_iter_init(&negotiation_include_oids, &iter);
      +
      +		while ((oid = oidset_iter_next(&iter))) {
     ++			struct commit *commit;
      +			packet_buf_write(&req_buf, "have %s\n",
      +					 oid_to_hex(oid));
      +			print_verbose(args, "have %s", oid_to_hex(oid));
     ++			count++;
     ++
     ++			/*
     ++			 * If this is a commit, then mark as COMMON to
     ++			 * avoid the negotiator also outputting it as
     ++			 * a have.
     ++			 */
     ++			commit = lookup_commit(the_repository, oid);
     ++			if (commit &&
     ++			    !repo_parse_commit(the_repository, commit))
     ++				commit->object.flags |= COMMON;
      +		}
      +	}
      +
       	while ((oid = negotiator->next(negotiator))) {
     -+		/* avoid duplicate oids from --negotiation-require */
     -+		if (oidset_contains(&negotiation_require_oids, oid))
     -+			continue;
       		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
       		print_verbose(args, "have %s", oid_to_hex(oid));
     - 		in_vain++;
      @@ fetch-pack.c: done:
       		flushes++;
       	}
       	strbuf_release(&req_buf);
     -+	oidset_clear(&negotiation_require_oids);
     ++	oidset_clear(&negotiation_include_oids);
       
       	if (!got_ready || !no_done)
       		consume_shallow_list(args, &reader);
     @@ fetch-pack.c: static void add_common(struct strbuf *req_buf, struct oidset *comm
       		     struct strbuf *req_buf,
      -		     int *haves_to_send)
      +		     int *haves_to_send,
     -+		     struct oidset *negotiation_require_oids)
     ++		     struct oidset *negotiation_include_oids)
       {
       	int haves_added = 0;
       	const struct object_id *oid;
       
     -+	/* Send unconditional haves from --negotiation-require */
     -+	if (negotiation_require_oids) {
     ++	/* Send unconditional haves from --negotiation-include */
     ++	if (negotiation_include_oids) {
      +		struct oidset_iter iter;
     -+		oidset_iter_init(negotiation_require_oids, &iter);
     ++		oidset_iter_init(negotiation_include_oids, &iter);
      +
      +		while ((oid = oidset_iter_next(&iter)))
      +			packet_buf_write(req_buf, "have %s\n",
     @@ fetch-pack.c: static void add_common(struct strbuf *req_buf, struct oidset *comm
      +	}
      +
       	while ((oid = negotiator->next(negotiator))) {
     -+		if (negotiation_require_oids &&
     -+		    oidset_contains(negotiation_require_oids, oid))
     ++		if (negotiation_include_oids &&
     ++		    oidset_contains(negotiation_include_oids, oid))
      +			continue;
       		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
       		if (++haves_added >= *haves_to_send)
     @@ fetch-pack.c: static int send_fetch_request(struct fetch_negotiator *negotiator,
       			      int *haves_to_send, int *in_vain,
      -			      int sideband_all, int seen_ack)
      +			      int sideband_all, int seen_ack,
     -+			      struct oidset *negotiation_require_oids)
     ++			      struct oidset *negotiation_include_oids)
       {
       	int haves_added;
       	int done_sent = 0;
     @@ fetch-pack.c: static int send_fetch_request(struct fetch_negotiator *negotiator,
       
      -	haves_added = add_haves(negotiator, &req_buf, haves_to_send);
      +	haves_added = add_haves(negotiator, &req_buf, haves_to_send,
     -+			       negotiation_require_oids);
     ++			       negotiation_include_oids);
       	*in_vain += haves_added;
       	trace2_data_intmax("negotiation_v2", the_repository, "haves_added", haves_added);
       	trace2_data_intmax("negotiation_v2", the_repository, "in_vain", *in_vain);
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
       	struct ref *ref = copy_ref_list(orig_ref);
       	enum fetch_state state = FETCH_CHECK_LOCAL;
       	struct oidset common = OIDSET_INIT;
     -+	struct oidset negotiation_require_oids = OIDSET_INIT;
     ++	struct oidset negotiation_include_oids = OIDSET_INIT;
       	struct packet_reader reader;
       	int in_vain = 0, negotiation_started = 0;
       	int negotiation_round = 0;
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
       				state = FETCH_SEND_REQUEST;
       
       			mark_tips(negotiator, args->negotiation_restrict_tips);
     -+			resolve_negotiation_require(args->negotiation_require,
     -+						    &negotiation_require_oids);
     ++			resolve_negotiation_include(args->negotiation_include,
     ++						    &negotiation_include_oids);
       			for_each_cached_alternate(negotiator,
       						  insert_one_alternate_object);
       			break;
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
       					       reader.use_sideband,
      -					       seen_ack)) {
      +					       seen_ack,
     -+					       &negotiation_require_oids)) {
     ++					       &negotiation_include_oids)) {
       				trace2_region_leave_printf("negotiation_v2", "round",
       							   the_repository, "%d",
       							   negotiation_round);
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
       		negotiator->release(negotiator);
       
       	oidset_clear(&common);
     -+	oidset_clear(&negotiation_require_oids);
     ++	oidset_clear(&negotiation_include_oids);
       	return ref;
       }
       
     @@ fetch-pack.c: void negotiate_using_fetch(const struct oid_array *negotiation_res
       			   int fd[],
      -			   struct oidset *acked_commits)
      +			   struct oidset *acked_commits,
     -+			   const struct string_list *negotiation_require)
     ++			   const struct string_list *negotiation_include)
       {
       	struct fetch_negotiator negotiator;
       	struct packet_reader reader;
       	struct object_array nt_object_array = OBJECT_ARRAY_INIT;
       	struct strbuf req_buf = STRBUF_INIT;
     -+	struct oidset negotiation_require_oids = OIDSET_INIT;
     ++	struct oidset negotiation_include_oids = OIDSET_INIT;
       	int haves_to_send = INITIAL_FLUSH;
       	int in_vain = 0;
       	int seen_ack = 0;
     @@ fetch-pack.c: void negotiate_using_fetch(const struct oid_array *negotiation_res
       	fetch_negotiator_init(the_repository, &negotiator);
       	mark_tips(&negotiator, negotiation_restrict_tips);
       
     -+	resolve_negotiation_require(negotiation_require,
     -+				    &negotiation_require_oids);
     ++	resolve_negotiation_include(negotiation_include,
     ++				    &negotiation_include_oids);
      +
       	packet_reader_init(&reader, fd[0], NULL, 0,
       			   PACKET_READ_CHOMP_NEWLINE |
     @@ fetch-pack.c: void negotiate_using_fetch(const struct oid_array *negotiation_res
       
      -		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send);
      +		haves_added = add_haves(&negotiator, &req_buf, &haves_to_send,
     -+				       &negotiation_require_oids);
     ++				       &negotiation_include_oids);
       		in_vain += haves_added;
       		if (!haves_added || (seen_ack && in_vain >= MAX_IN_VAIN))
       			last_iteration = 1;
     @@ fetch-pack.c: void negotiate_using_fetch(const struct oid_array *negotiation_res
       
       	clear_common_flag(acked_commits);
       	object_array_clear(&nt_object_array);
     -+	oidset_clear(&negotiation_require_oids);
     ++	oidset_clear(&negotiation_include_oids);
       	negotiator.release(&negotiator);
       	strbuf_release(&req_buf);
       }
     @@ fetch-pack.h: struct fetch_pack_args {
      +	 * as "have" lines during negotiation, regardless of what the
      +	 * negotiation algorithm selects.
      +	 */
     -+	const struct string_list *negotiation_require;
     ++	const struct string_list *negotiation_include;
      +
       	unsigned deepen_relative:1;
       	unsigned quiet:1;
     @@ fetch-pack.h: void negotiate_using_fetch(const struct oid_array *negotiation_res
       			   int fd[],
      -			   struct oidset *acked_commits);
      +			   struct oidset *acked_commits,
     -+			   const struct string_list *negotiation_require);
     ++			   const struct string_list *negotiation_include);
       
       /*
        * Print an appropriate error message for each sought ref that wasn't
     @@ t/t5510-fetch.sh: test_expect_success 'CLI --negotiation-restrict overrides remo
       	test_grep ! "fetch> have $BETA_1" trace
       '
       
     -+test_expect_success '--negotiation-require includes configured refs as haves' '
     ++test_expect_success '--negotiation-include includes configured refs as haves' '
      +	test_when_finished rm -f trace &&
      +	setup_negotiation_tip server server 0 &&
      +
      +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
      +		--negotiation-restrict=alpha_1 \
     -+		--negotiation-require=refs/tags/beta_1 \
     ++		--negotiation-include=refs/tags/beta_1 \
      +		origin alpha_s beta_s &&
      +
      +	ALPHA_1=$(git -C client rev-parse alpha_1) &&
     @@ t/t5510-fetch.sh: test_expect_success 'CLI --negotiation-restrict overrides remo
      +	test_grep "fetch> have $BETA_1" trace
      +'
      +
     -+test_expect_success '--negotiation-require works with glob patterns' '
     ++test_expect_success '--negotiation-include works with glob patterns' '
      +	test_when_finished rm -f trace &&
      +	setup_negotiation_tip server server 0 &&
      +
      +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
      +		--negotiation-restrict=alpha_1 \
     -+		--negotiation-require="refs/tags/beta_*" \
     ++		--negotiation-include="refs/tags/beta_*" \
      +		origin alpha_s beta_s &&
      +
      +	BETA_1=$(git -C client rev-parse beta_1) &&
     @@ t/t5510-fetch.sh: test_expect_success 'CLI --negotiation-restrict overrides remo
      +	test_grep "fetch> have $BETA_2" trace
      +'
      +
     -+test_expect_success '--negotiation-require is additive with negotiation' '
     ++test_expect_success '--negotiation-include is additive with negotiation' '
      +	test_when_finished rm -f trace &&
      +	setup_negotiation_tip server server 0 &&
      +
      +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
     -+		--negotiation-require=refs/tags/beta_1 \
     ++		--negotiation-include=refs/tags/beta_1 \
      +		origin alpha_s beta_s &&
      +
      +	BETA_1=$(git -C client rev-parse beta_1) &&
      +	test_grep "fetch> have $BETA_1" trace
      +'
      +
     -+test_expect_success '--negotiation-require ignores non-existent refs silently' '
     ++test_expect_success '--negotiation-include ignores non-existent refs silently' '
      +	setup_negotiation_tip server server 0 &&
      +
      +	git -C client fetch --quiet \
      +		--negotiation-restrict=alpha_1 \
     -+		--negotiation-require=refs/tags/nonexistent \
     ++		--negotiation-include=refs/tags/nonexistent \
      +		origin alpha_s beta_s 2>err &&
      +	test_must_be_empty err
      +'
      +
     -+test_expect_success '--negotiation-require avoids duplicates with negotiator' '
     ++test_expect_success '--negotiation-include avoids duplicates with negotiator' '
      +	test_when_finished rm -f trace &&
      +	setup_negotiation_tip server server 0 &&
      +
      +	ALPHA_1=$(git -C client rev-parse alpha_1) &&
      +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
      +		--negotiation-restrict=alpha_1 \
     -+		--negotiation-require=refs/tags/alpha_1 \
     ++		--negotiation-include=refs/tags/alpha_1 \
      +		origin alpha_s beta_s &&
      +
      +	test_grep "fetch> have $ALPHA_1" trace >matches &&
     @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
       	args.stateless_rpc = transport->stateless_rpc;
       	args.server_options = transport->server_options;
       	args.negotiation_restrict_tips = data->options.negotiation_restrict_tips;
     -+	args.negotiation_require = data->options.negotiation_require;
     ++	args.negotiation_include = data->options.negotiation_include;
       	args.reject_shallow_remote = transport->smart_options->reject_shallow;
       
       	if (!data->finished_handshake) {
     @@ transport.c: static int fetch_refs_via_pack(struct transport *transport,
       					      data->fd,
      -					      data->options.acked_commits);
      +					      data->options.acked_commits,
     -+					      data->options.negotiation_require);
     ++					      data->options.negotiation_include);
       			ret = 0;
       		}
       		goto cleanup;
     @@ transport.h: struct git_transport_options {
      +	 * If non-empty, ref patterns whose tips should always be sent
      +	 * as "have" lines during negotiation.
      +	 */
     -+	const struct string_list *negotiation_require;
     ++	const struct string_list *negotiation_include;
      +
       	/*
       	 * If allocated, whenever transport_fetch_refs() is called, add known
 6:  081f904c07 ! 6:  a2d15fa12a remote: add negotiationRequire config as default for --negotiation-require
     @@ Metadata
      Author: Derrick Stolee <stolee@gmail.com>
      
       ## Commit message ##
     -    remote: add negotiationRequire config as default for --negotiation-require
     +    remote: add remote.*.negotiationInclude config
      
     -    Add a new 'remote.<name>.negotiationRequire' multi-valued config option
     -    that provides default values for --negotiation-require when no
     -    --negotiation-require arguments are specified over the command line.
     -    This is a mirror of how 'remote.<name>.negotiationRestrict' specifies
     -    defaults for the --negotiation-restrict arguments.
     +    Add a new 'remote.<name>.negotiationInclude' multi-valued config option that
     +    provides default values for --negotiation-include when no
     +    --negotiation-include arguments are specified over the command line.  This
     +    is a mirror of how 'remote.<name>.negotiationRestrict' specifies defaults
     +    for the --negotiation-restrict arguments.
      
     -    Each value is either an exact ref name or a glob pattern whose tips
     -    should always be sent as 'have' lines during negotiation. The config
     -    values are resolved through the same resolve_negotiation_require()
     -    codepath as the CLI options.
     +    Each value is either an exact ref name or a glob pattern whose tips should
     +    always be sent as 'have' lines during negotiation. The config values are
     +    resolved through the same resolve_negotiation_include() codepath as the CLI
     +    options.
      
     -    This option is additive with the normal negotiation process: the
     -    negotiation algorithm still runs and advertises its own selected
     -    commits, but the refs matching the config are sent unconditionally
     -    on top of those heuristically selected commits.
     +    This option is additive with the normal negotiation process: the negotiation
     +    algorithm still runs and advertises its own selected commits, but the refs
     +    matching the config are sent unconditionally on top of those heuristically
     +    selected commits.
     +
     +    Similar to the negotiationRestrict config, an empty value resets the value
     +    list to allow ignoring earlier config values, such as those that might be
     +    set in system or global config.
      
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/config/remote.adoc ##
     -@@ Documentation/config/remote.adoc: command-line option.  If `--negotiation-restrict` (or its synonym
     - `--negotiation-tip`) is specified on the command line, then the config
     - values are not used.
     +@@ Documentation/config/remote.adoc: values are not used.
     + Blank values signal to ignore all previous values, allowing a reset of
     + the list from broader config scenarios.
       
     -+remote.<name>.negotiationRequire::
     ++remote.<name>.negotiationInclude::
      +	When negotiating with this remote during `git fetch` and `git push`,
      +	the client advertises a list of commits that exist locally.  In
      +	repos with many references, this list of "haves" can be truncated.
     @@ Documentation/config/remote.adoc: command-line option.  If `--negotiation-restri
      +glob pattern (e.g. `refs/heads/release/*`).  The pattern syntax is the same
      +as for `--negotiation-restrict`.
      ++
     -+These config values are used as defaults for the `--negotiation-require`
     -+command-line option.  If `--negotiation-require` is specified on the
     ++These config values are used as defaults for the `--negotiation-include`
     ++command-line option.  If `--negotiation-include` is specified on the
      +command line, then the config values are not used.
      ++
      +This option is additive with the normal negotiation process: the
      +negotiation algorithm still runs and advertises its own selected commits,
     -+but the refs matching `remote.<name>.negotiationRequire` are sent
     ++but the refs matching `remote.<name>.negotiationInclude` are sent
      +unconditionally on top of those heuristically selected commits.  This
      +option is also used during push negotiation when `push.negotiate` is
      +enabled.
     +++
     ++Blank values signal to ignore all previous values, allowing a reset of
     ++the list from broader config scenarios.
      +
       remote.<name>.followRemoteHEAD::
       	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`
     @@ Documentation/fetch-options.adoc
      @@ Documentation/fetch-options.adoc: is the same as for `--negotiation-restrict`.
       If `--negotiation-restrict` is used, the have set is first restricted by
       that option and then increased to include the tips specified by
     - `--negotiation-require`.
     + `--negotiation-include`.
      ++
      +If this option is not specified on the command line, then any
     -+`remote.<name>.negotiationRequire` config values for the current remote
     ++`remote.<name>.negotiationInclude` config values for the current remote
      +are used instead.
       
       `--negotiate-only`::
     @@ builtin/fetch.c
      @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remote, int deepen,
       		else
       			warning(_("ignoring %s because the protocol does not support it"),
     - 				"--negotiation-require");
     -+	} else if (remote->negotiation_require.nr) {
     + 				"--negotiation-include");
     ++	} else if (remote->negotiation_include.nr) {
      +		if (transport->smart_options) {
     -+			transport->smart_options->negotiation_require = &remote->negotiation_require;
     ++			transport->smart_options->negotiation_include = &remote->negotiation_include;
      +		} else {
      +			struct strbuf config_name = STRBUF_INIT;
     -+			strbuf_addf(&config_name, "remote.%s.negotiationRequire", remote->name);
     ++			strbuf_addf(&config_name, "remote.%s.negotiationInclude", remote->name);
      +			warning(_("ignoring %s because the protocol does not support it"),
      +				config_name.buf);
      +			strbuf_release(&config_name);
     @@ remote.c: static struct remote *make_remote(struct remote_state *remote_state,
       	refspec_init_fetch(&ret->fetch);
       	string_list_init_dup(&ret->server_options);
       	string_list_init_dup(&ret->negotiation_restrict);
     -+	string_list_init_dup(&ret->negotiation_require);
     ++	string_list_init_dup(&ret->negotiation_include);
       
       	ALLOC_GROW(remote_state->remotes, remote_state->remotes_nr + 1,
       		   remote_state->remotes_alloc);
     @@ remote.c: static void remote_clear(struct remote *remote)
       	FREE_AND_NULL(remote->http_proxy_authmethod);
       	string_list_clear(&remote->server_options, 0);
       	string_list_clear(&remote->negotiation_restrict, 0);
     -+	string_list_clear(&remote->negotiation_require, 0);
     ++	string_list_clear(&remote->negotiation_include, 0);
       }
       
       static void add_merge(struct branch *branch, const char *name)
      @@ remote.c: static int handle_config(const char *key, const char *value,
     - 		if (!value)
     - 			return config_error_nonbool(key);
     - 		string_list_append(&remote->negotiation_restrict, value);
     -+	} else if (!strcmp(subkey, "negotiationrequire")) {
     -+		if (!value)
     -+			return config_error_nonbool(key);
     -+		string_list_append(&remote->negotiation_require, value);
     + 			string_list_clear(&remote->negotiation_restrict, 0);
     + 		else
     + 			string_list_append(&remote->negotiation_restrict, value);
     ++	} else if (!strcmp(subkey, "negotiationinclude")) {
     ++		/* reset list on empty value. */
     ++		if (!value || !*value)
     ++			string_list_clear(&remote->negotiation_include, 0);
     ++		else
     ++			string_list_append(&remote->negotiation_include, value);
       	} else if (!strcmp(subkey, "followremotehead")) {
       		const char *no_warn_branch;
       		if (!strcmp(value, "never"))
     @@ remote.h: struct remote {
       
       	struct string_list server_options;
       	struct string_list negotiation_restrict;
     -+	struct string_list negotiation_require;
     ++	struct string_list negotiation_include;
       
       	enum follow_remote_head_settings follow_remote_head;
       	const char *no_warn_branch;
      
       ## t/t5510-fetch.sh ##
     -@@ t/t5510-fetch.sh: test_expect_success '--negotiation-require avoids duplicates with negotiator' '
     +@@ t/t5510-fetch.sh: test_expect_success '--negotiation-include avoids duplicates with negotiator' '
       	test_line_count = 1 matches
       '
       
     -+test_expect_success 'remote.<name>.negotiationRequire used as default for --negotiation-require' '
     ++test_expect_success 'remote.<name>.negotiationInclude used as default for --negotiation-include' '
      +	test_when_finished rm -f trace &&
      +	setup_negotiation_tip server server 0 &&
      +
     -+	git -C client config --add remote.origin.negotiationRequire refs/tags/beta_1 &&
     ++	# test the reset of the list on an empty value
     ++	git -C client config --add remote.origin.negotiationInclude refs/tags/alpha_1 &&
     ++	git -C client config --add remote.origin.negotiationInclude "" &&
     ++	git -C client config --add remote.origin.negotiationInclude refs/tags/beta_1 &&
      +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
      +		--negotiation-restrict=alpha_1 \
      +		origin alpha_s beta_s &&
     @@ t/t5510-fetch.sh: test_expect_success '--negotiation-require avoids duplicates w
      +	test_grep "fetch> have $BETA_1" trace
      +'
      +
     -+test_expect_success 'remote.<name>.negotiationRequire works with glob patterns' '
     ++test_expect_success 'remote.<name>.negotiationInclude works with glob patterns' '
      +	test_when_finished rm -f trace &&
      +	setup_negotiation_tip server server 0 &&
      +
     -+	git -C client config --add remote.origin.negotiationRequire "refs/tags/beta_*" &&
     ++	git -C client config --add remote.origin.negotiationInclude "refs/tags/beta_*" &&
      +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
      +		--negotiation-restrict=alpha_1 \
      +		origin alpha_s beta_s &&
     @@ t/t5510-fetch.sh: test_expect_success '--negotiation-require avoids duplicates w
      +	test_grep "fetch> have $BETA_2" trace
      +'
      +
     -+test_expect_success 'CLI --negotiation-require overrides remote.<name>.negotiationRequire' '
     ++test_expect_success 'CLI --negotiation-include overrides remote.<name>.negotiationInclude' '
      +	test_when_finished rm -f trace &&
      +	setup_negotiation_tip server server 0 &&
      +
     -+	git -C client config --add remote.origin.negotiationRequire refs/tags/beta_2 &&
     ++	git -C client config --add remote.origin.negotiationInclude refs/tags/beta_2 &&
      +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client fetch \
      +		--negotiation-restrict=alpha_1 \
     -+		--negotiation-require=refs/tags/beta_1 \
     ++		--negotiation-include=refs/tags/beta_1 \
      +		origin alpha_s beta_s &&
      +
      +	BETA_1=$(git -C client rev-parse beta_1) &&
 7:  7cccf59beb ! 7:  e6c79f0661 send-pack: pass negotiation config in push
     @@ Commit message
      
          When push.negotiate is enabled, 'git push' spawns a child 'git fetch
          --negotiate-only' process to find common commits.  Pass
     -    --negotiation-require and --negotiation-restrict options from the
     -    'remote.<name>.negotiationRequire' and
     +    --negotiation-include and --negotiation-restrict options from the
     +    'remote.<name>.negotiationInclude' and
          'remote.<name>.negotiationRestrict' config keys to this child process.
      
          When negotiationRestrict is configured, it replaces the default
          behavior of using all remote refs as negotiation tips. This allows
          the user to control which local refs are used for push negotiation.
      
     -    When negotiationRequire is configured, the specified ref patterns
     -    are passed as --negotiation-require to ensure their tips are always
     +    When negotiationInclude is configured, the specified ref patterns
     +    are passed as --negotiation-include to ensure their tips are always
          sent as 'have' lines during push negotiation.
      
          This change also updates the use of --negotiation-tip into
     @@ send-pack.c: static void reject_invalid_nonce(const char *nonce, int len)
       
       static void get_commons_through_negotiation(struct repository *r,
       					    const char *url,
     -+					    const struct string_list *negotiation_require,
     ++					    const struct string_list *negotiation_include,
      +					    const struct string_list *negotiation_restrict,
       					    const struct ref *remote_refs,
       					    struct oid_array *commons)
       {
     -@@ send-pack.c: static void get_commons_through_negotiation(struct repository *r,
     + 	struct child_process child = CHILD_PROCESS_INIT;
     + 	const struct ref *ref;
     + 	int len = r->hash_algo->hexsz + 1; /* hash + NL */
     +-	int nr_negotiation_tip = 0;
     ++	int nr_negotiation = 0;
     + 
     + 	child.git_cmd = 1;
       	child.no_stdin = 1;
       	child.out = -1;
       	strvec_pushl(&child.args, "fetch", "--negotiate-only", NULL);
     @@ send-pack.c: static void get_commons_through_negotiation(struct repository *r,
      +		for_each_string_list_item(item, negotiation_restrict)
      +			strvec_pushf(&child.args, "--negotiation-restrict=%s",
      +				     item->string);
     -+		nr_negotiation_tip = negotiation_restrict->nr;
     ++		nr_negotiation = negotiation_restrict->nr;
      +	} else {
      +		for (ref = remote_refs; ref; ref = ref->next) {
      +			if (!is_null_oid(&ref->new_oid)) {
     -+				strvec_pushf(&child.args, "--negotiation-tip=%s",
     ++				strvec_pushf(&child.args, "--negotiation-restrict=%s",
      +					     oid_to_hex(&ref->new_oid));
     -+				nr_negotiation_tip++;
     ++				nr_negotiation++;
      +			}
       		}
       	}
      +
     -+	if (negotiation_require && negotiation_require->nr) {
     ++	if (negotiation_include && negotiation_include->nr) {
      +		struct string_list_item *item;
     -+		for_each_string_list_item(item, negotiation_require)
     -+			strvec_pushf(&child.args, "--negotiation-require=%s",
     ++		for_each_string_list_item(item, negotiation_include)
     ++			strvec_pushf(&child.args, "--negotiation-include=%s",
      +				     item->string);
     ++		nr_negotiation += negotiation_include->nr;
      +	}
      +
       	strvec_push(&child.args, url);
       
     - 	if (!nr_negotiation_tip) {
     +-	if (!nr_negotiation_tip) {
     ++	if (!nr_negotiation) {
     + 		child_process_clear(&child);
     + 		return;
     + 	}
      @@ send-pack.c: int send_pack(struct repository *r,
       	repo_config_get_bool(r, "push.negotiate", &push_negotiate);
       	if (push_negotiate) {
       		trace2_region_enter("send_pack", "push_negotiate", r);
      -		get_commons_through_negotiation(r, args->url, remote_refs, &commons);
      +		get_commons_through_negotiation(r, args->url,
     -+					       args->negotiation_require,
     ++					       args->negotiation_include,
      +					       args->negotiation_restrict,
      +					       remote_refs, &commons);
       		trace2_region_leave("send_pack", "push_negotiate", r);
     @@ send-pack.h: struct repository;
       
       struct send_pack_args {
       	const char *url;
     -+	const struct string_list *negotiation_require;
     ++	const struct string_list *negotiation_include;
      +	const struct string_list *negotiation_restrict;
       	unsigned verbose:1,
       		quiet:1,
     @@ t/t5516-fetch-push.sh: test_expect_success 'push with negotiation does not attem
       	! grep "Fetching submodule" err
       '
       
     -+test_expect_success 'push with negotiation and remote.<name>.negotiationRequire' '
     -+	test_when_finished rm -rf negotiation_require &&
     -+	mk_empty negotiation_require &&
     -+	git push negotiation_require $the_first_commit:refs/remotes/origin/first_commit &&
     -+	test_commit -C negotiation_require unrelated_commit &&
     -+	git -C negotiation_require config receive.hideRefs refs/remotes/origin/first_commit &&
     ++test_expect_success 'push with negotiation and remote.<name>.negotiationInclude' '
     ++	test_when_finished rm -rf negotiation_include &&
     ++	mk_empty negotiation_include &&
     ++	git push negotiation_include $the_first_commit:refs/remotes/origin/first_commit &&
     ++	test_commit -C negotiation_include unrelated_commit &&
     ++	git -C negotiation_include config receive.hideRefs refs/remotes/origin/first_commit &&
      +	test_when_finished "rm event" &&
      +	GIT_TRACE2_EVENT="$(pwd)/event" \
      +		git -c protocol.version=2 -c push.negotiate=1 \
     -+		-c remote.negotiation_require.negotiationRequire=refs/heads/main \
     -+		push negotiation_require refs/heads/main:refs/remotes/origin/main &&
     ++		-c remote.negotiation_include.negotiationInclude=refs/heads/main \
     ++		push negotiation_include refs/heads/main:refs/remotes/origin/main &&
      +	test_grep \"key\":\"total_rounds\" event &&
      +	grep_wrote 2 event # 1 commit, 1 tree
      +'
     @@ transport.c: static int git_transport_push(struct transport *transport, struct r
       	args.atomic = !!(flags & TRANSPORT_PUSH_ATOMIC);
       	args.push_options = transport->push_options;
       	args.url = transport->url;
     -+	args.negotiation_require = &transport->remote->negotiation_require;
     ++	args.negotiation_include = &transport->remote->negotiation_include;
      +	args.negotiation_restrict = &transport->remote->negotiation_restrict;
       
       	if (flags & TRANSPORT_PUSH_CERT_ALWAYS)

-- 
gitgitgadget
