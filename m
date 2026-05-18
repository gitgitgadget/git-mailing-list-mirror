Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3423172631
	for <git@vger.kernel.org>; Mon, 18 May 2026 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135580; cv=none; b=nl/5h9/6v9a4XWBEqNKWU6Wyi9wv2hByytA86D1ANf9CUvuFLqa8EEJN3gVKA9HbefaqrpX6BrXriEG9frRIpCyOEJDSbvdrVCVAVaC86c/vths0WcKZpBOtxlcBpPLvw1pz7KqA9nRQqheA0TFE+Q4ZJlNBGJxxDTnCTiOf0O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135580; c=relaxed/simple;
	bh=xdXSTioaIA+U8itwBECnp9L0j7DC3MHy175pfaYndQY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tTvjAFfDIlCoqMeSLRP9FjA1IBfq5wHiyNUb3K9mJiGIf757pAcaLbqdxv6UD8hQPHXdfmL94XnsAUc3JIyJFjAwaCVuCtO2QYRbXY4l7unNHzH05LNfETwoH16FOnw0rqJ2IJ3cwFkCFZY4f+tBQbJZhyhrGaCfxDKArIYdup4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJLAEu6T; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJLAEu6T"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-90ca6f20872so476714285a.0
        for <git@vger.kernel.org>; Mon, 18 May 2026 13:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779135577; x=1779740377; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JffcMHYgkVaPWN952MIknyduPcTwphooYYAbw7N9l1Y=;
        b=EJLAEu6Tsjhi3EdU5Y/+stMS6dmfzRyX/2T/uirB+8NnrXCfonupA5UfqqgeKMCWJ7
         dsGqbOGqu9Krvrmnx8vI6UGQk6TpsffPnGmkv+YyrSAMOBf146HLSDON+YFdb1WTdS8i
         Z8N2Ze89aCilf1W3xSxJCL4NRUzCJXp4JiKx8WXj+6XPOXv0xyoBVLDgCdT/aGLO8teS
         vS9imvL2SBc9SBnCkwY49OlSaoMSR2MS9/X5uJCxZ3kaWT3hrqUAlUXynD/OF22J2SU4
         NsortL8tps1NSI7N4l/P4r6/EGgj8JGaeHpoTqiLJspfdysMlMLZ2EdAcrlCf+A1MHmN
         Nzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779135577; x=1779740377;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JffcMHYgkVaPWN952MIknyduPcTwphooYYAbw7N9l1Y=;
        b=UrHqT8CG5LwY1L72aIs0KUGwjT3B36lbqL/23fHveTyPMya1tjSaIHIu4KSZnEGlNl
         u6wIz7lGFcXVjObHP3MAiJwlcHxi6KcJlA6d6TijO/BuaeYL/ct2DsHV7dpbDftZ7tPf
         tkir7GpEMzVdahn3K1U5rwXOZ91+O2RDLXug7p+Qxg3UpULuZwMvNyFnWNpQ3YKxpU4w
         XLnPOxZ5xv2kUkBNawiY6MyJsIUJVaNXsqy4Osg0Z7ZxxxpSZaHPHITaZj3pZ8UY9dHn
         BTuCH8PffOy2w0YicCq93Txs9B/o5zKYgoz6biva/NhGDcWl9wsb4yKljriVHEkjKfa8
         L84w==
X-Gm-Message-State: AOJu0YwmMtiYRhOpJsQu2crIS8lURB1yUpXT1QVhW4zZcBSn4fcGFsnq
	S6ZOrQ1kL8tOvRcFa2Hqx4TKCCHl9pq2oSYm2n8qTFJrbzLqW2cA75TrG5PC7g==
X-Gm-Gg: Acq92OGbuB2Hz82SnGuQWoCpDt58Qwxc1g7IEEQnPxYfS2+2fWUl7iQstpmR1CHEwoA
	2XmeTw3FciYuUI3lX0TmWCu+iwoPPmdnD9TccADolApAElIzm7QeIFZvl1g8+R/hmnWIwYsoGJf
	Fn/alIO8xaP4B+hs9WItzrIBNcwp5AKMucfPDbC1/YpKwR0QlMc5hbf+QUKHLLWnRW57teVJt1N
	XGip7sqshJSJVPwpnVDO/f8p1jXhH8QkEKMehVvU+fNHWWee/6eaS3utoPhZ0jxxriJofePcxyU
	ynU1xxG8Qfb0AMOyjGm2ffYRmbbBlVYwROSrsNpZQ6nXhUQMmnxWVHiXCOBJbFq0GfeI20v9kRG
	URLaLtIAADrO772/ihEk2L+n9dl77SqzdF5M4kS701Q3zfhUDiGMrrNGkIDURyYr+klni/gN+09
	11tkE+hDHfORDJBObunsMyuxjz
X-Received: by 2002:a05:620a:1a1f:b0:912:671b:d0b1 with SMTP id af79cd13be357-912671bd4femr1805363385a.2.1779135576442;
        Mon, 18 May 2026 13:19:36 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.36])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910baf22315sm1636031785a.21.2026.05.18.13.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 13:19:35 -0700 (PDT)
Message-Id: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
References: <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 18 May 2026 20:19:26 +0000
Subject: [PATCH v5 0/8] fetch: rework negotiation tip options
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
    Matthew John Cheetham <mjcheetham@outlook.com>,
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


Updates in v4
=============

Thanks, Matthew, for the detailed review! There are some big changes in this
version.

 * Expanded commit message to cite the commit that introduced the bug
   (3f763ddf28).
 * Renamed --negotiation-tip to --negotiation-restrict throughout docs/code
   (including send-pack.c, transport-helper.c, builtin/pull.c). Added
   OPT_ALIAS in git-pull.
 * Switched config parsing to use parse_transport_option() helper. Removed
   git push from docs (not implemented yet). Restructured --negotiate-only
   validation flow.
 * NEW Patch 5: Added have_sent() interface to negotiators, so included
   haves can be de-duplicated properly by the negotiation algorithm.
 * Replaced COMMON flag hack with negotiator->have_sent() calls. Moved
   ref-pattern resolution into builtin/fetch.c (add_negotiation_tips()) so
   fetch-pack receives pre-resolved oid_array instead of string_list. Added
   test for --negotiation-tip ignoring missing refs. Added
   duplicate-avoidance test for v0. Accepts commit hashes in addition to ref
   names/globs.
 * Use parse_transport_option() for config. Updated docs to mention commit
   hashes. Removed git push from config docs. Fixed test to use correct
   restrict/include combinations.
 * In the last patch, add doc notes that remote config values also apply
   during git push with push.negotiate, now that they are integrated by that
   change.

Thanks, -Stolee

Derrick Stolee (8):
  t5516: fix test order flakiness
  fetch: add --negotiation-restrict option
  transport: rename negotiation_tips
  remote: add remote.*.negotiationRestrict config
  negotiator: add have_sent() interface
  fetch: add --negotiation-include option for negotiation
  remote: add remote.*.negotiationInclude config
  send-pack: pass negotiation config in push

 Documentation/config/fetch.adoc  |   2 +-
 Documentation/config/remote.adoc |  49 ++++++++
 Documentation/fetch-options.adoc |  29 ++++-
 builtin/fetch.c                  |  87 +++++++++++---
 builtin/pull.c                   |   6 +-
 fetch-negotiator.h               |   9 ++
 fetch-pack.c                     |  99 +++++++++++++---
 fetch-pack.h                     |  10 +-
 negotiator/default.c             |   8 ++
 negotiator/noop.c                |   7 ++
 negotiator/skipping.c            |   8 ++
 remote.c                         |  10 ++
 remote.h                         |   2 +
 send-pack.c                      |  39 +++++--
 send-pack.h                      |   2 +
 t/t5510-fetch.sh                 | 191 +++++++++++++++++++++++++++++++
 t/t5516-fetch-push.sh            |  32 +++++-
 t/t5702-protocol-v2.sh           |   4 +-
 transport-helper.c               |   5 +-
 transport.c                      |  20 +++-
 transport.h                      |   7 +-
 21 files changed, 564 insertions(+), 62 deletions(-)


base-commit: 6e8d538aab8fe4dd07ba9fb87b5c7edcfa5706ad
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2085%2Fderrickstolee%2Fmust-have-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2085/derrickstolee/must-have-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2085

Range-diff vs v4:

 1:  7409a479d6 ! 1:  538913a327 t5516: fix test order flakiness
     @@ Commit message
      
          Use 'sort -k 3' to match the actual number of columns in the output.
      
     +    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## t/t5516-fetch-push.sh ##
 2:  7836a2d6a5 ! 2:  580aa58943 fetch: add --negotiation-restrict option
     @@ Commit message
          translatable with the option name inserted by formatting. At least one
          of these messages will be reused later for a new option.
      
     +    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/config/fetch.adoc ##
 3:  401bdaff7c ! 3:  eee0543647 transport: rename negotiation_tips
     @@ Commit message
          Also update the string_list used to store the inputs from command-line
          options.
      
     +    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## builtin/fetch.c ##
 4:  a14c568a1f ! 4:  63c675e93e remote: add remote.*.negotiationRestrict config
     @@ Commit message
          An empty value resets the value list to allow ignoring earlier config
          values, such as those that might be set in system or global config.
      
     +    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/config/remote.adoc ##
 5:  94b79784fe ! 5:  d423c56283 negotiator: add have_sent() interface
     @@ Commit message
          common, so the implementation is quite simple. This logic will be exercised
          in the next change.
      
     +    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## fetch-negotiator.h ##
 6:  b4cd458fe0 ! 6:  e86c9791e2 fetch: add --negotiation-include option for negotiation
     @@ Commit message
      
          Also add --negotiation-include to 'git pull' passthrough options.
      
     +    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/fetch-options.adoc ##
     @@ builtin/fetch.c: static int add_oid(const struct reference *ref, void *cb_data)
       
      -static void add_negotiation_restrict_tips(struct git_transport_options *smart_options)
      +static void add_negotiation_tips(struct string_list *input_list,
     -+				 struct oid_array **output_list)
     ++				 struct oid_array **output_list,
     ++				 const char *argname)
       {
       	struct oid_array *oids = xcalloc(1, sizeof(*oids));
       	int i;
     @@ builtin/fetch.c: static int add_oid(const struct reference *ref, void *cb_data)
       			continue;
       		}
      @@ builtin/fetch.c: static void add_negotiation_restrict_tips(struct git_transport_options *smart_op
     + 				      add_oid, oids, &opts);
     + 		if (old_nr == oids->nr)
       			warning(_("ignoring %s=%s because it does not match any refs"),
     - 				"--negotiation-restrict", s);
     +-				"--negotiation-restrict", s);
     ++				argname, s);
       	}
      -	smart_options->negotiation_restrict_tips = oids;
      +	*output_list = oids;
     @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remot
       		if (transport->smart_options)
      -			add_negotiation_restrict_tips(transport->smart_options);
      +			add_negotiation_tips(&negotiation_restrict,
     -+					     &transport->smart_options->negotiation_restrict_tips);
     ++					     &transport->smart_options->negotiation_restrict_tips,
     ++					     "--negotiation-restrict");
       		else
       			warning(_("ignoring %s because the protocol does not support it"),
       				"--negotiation-restrict");
     @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remot
       		if (transport->smart_options)
      -			add_negotiation_restrict_tips(transport->smart_options);
      +			add_negotiation_tips(&negotiation_restrict,
     -+					     &transport->smart_options->negotiation_restrict_tips);
     ++					     &transport->smart_options->negotiation_restrict_tips,
     ++					     "--negotiation-restrict");
       		else {
       			struct strbuf config_name = STRBUF_INIT;
       			strbuf_addf(&config_name, "remote.%s.negotiationRestrict", remote->name);
     @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remot
      +	if (negotiation_include.nr) {
      +		if (transport->smart_options)
      +			add_negotiation_tips(&negotiation_include,
     -+					     &transport->smart_options->negotiation_include_tips);
     ++					     &transport->smart_options->negotiation_include_tips,
     ++					     "--negotiation-include");
      +		else
      +			warning(_("ignoring %s because the protocol does not support it"),
      +				"--negotiation-include");
 7:  7bd70a970b ! 7:  e5714115b5 remote: add remote.*.negotiationInclude config
     @@ Commit message
          list to allow ignoring earlier config values, such as those that might be
          set in system or global config.
      
     +    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/config/remote.adoc ##
     @@ Documentation/config/remote.adoc: values are not used.
      +This option is additive with the normal negotiation process: the
      +negotiation algorithm still runs and advertises its own selected commits,
      +but the refs matching `remote.<name>.negotiationInclude` are sent
     -+unconditionally on top of those heuristically selected commits.  This
     -+option is also used during push negotiation when `push.negotiate` is
     -+enabled.
     ++unconditionally on top of those heuristically selected commits.
      ++
      +Blank values signal to ignore all previous values, allowing a reset of
      +the list from broader config scenarios.
     @@ builtin/fetch.c: static struct transport *prepare_transport(struct remote *remot
      +	} else if (remote->negotiation_include.nr) {
      +		if (transport->smart_options) {
      +			add_negotiation_tips(&remote->negotiation_include,
     -+					     &transport->smart_options->negotiation_include_tips);
     ++					     &transport->smart_options->negotiation_include_tips,
     ++					     "--negotiation-include");
      +		} else {
      +			struct strbuf config_name = STRBUF_INIT;
      +			strbuf_addf(&config_name, "remote.%s.negotiationInclude", remote->name);
 8:  5b968245eb ! 8:  ed0be32e2c send-pack: pass negotiation config in push
     @@ Commit message
          are passed as --negotiation-include to ensure their tips are always
          sent as 'have' lines during push negotiation.
      
     -    This change also updates the use of --negotiation-tip into
     -    --negotiation-restrict now that the new synonym exists.
     -
     +    Reviewed-by: Matthew John Cheetham <mcheetham@outlook.com>
          Signed-off-by: Derrick Stolee <stolee@gmail.com>
      
       ## Documentation/config/remote.adoc ##
     @@ Documentation/config/remote.adoc: command-line option.  If `--negotiation-restri
       Blank values signal to ignore all previous values, allowing a reset of
       the list from broader config scenarios.
       
     -@@ Documentation/config/remote.adoc: unconditionally on top of those heuristically selected commits.  This
     - option is also used during push negotiation when `push.negotiate` is
     - enabled.
     +@@ Documentation/config/remote.adoc: negotiation algorithm still runs and advertises its own selected commits,
     + but the refs matching `remote.<name>.negotiationInclude` are sent
     + unconditionally on top of those heuristically selected commits.
       +
      +These values also influence negotiation during `git push` if
      +`push.negotiate` is enabled.

-- 
gitgitgadget
