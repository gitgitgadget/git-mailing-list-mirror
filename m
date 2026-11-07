Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794013664;
	b=OH6mmuDOAhD4L/x1KKqCYnvOmnUeDtPJU8pfn6R/m5FNuWCpsmPDfP1TSn/7dnVQhDqL
	 /+zyg66hAcAywxbyqxXw3cEdIDWNm417ypPgYF7GpAKUS/IEkLdO6BHdrOxUjeRT8lYSb
	 /n9a+x1HctxtWoJC95Pv/dywrd6pZBa8zvx7BapmOiT7UXNh7ZvEAXQEZANBM9+UjUmse
	 wJ8Nc7C6ricmWw0H35Xpt/uhr0+KQhxcG0e31j6k7ax5TD4NacepRwHyg4DHRdHsfBMuc
	 LZN3CTRuRGwi2N4vUAwepYTDyFL7H8olRL5VR0ns5uN65BJJffJG84JuqXl1yLWCzsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794013664;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=WMt2O1m2wTYqqX738OBm2thvwt57I5pwL81RZykJ32A=;
	b=wxh2PCV63KI036La5UKfwXBPTT51gcvrfXZ4gQagCpBkLAx8y7t5k/csQ/YejlU0eLuD
	 JGszf1yUqksykDmWEP1hWBg43sVpDHsvJxJbGl+cxkhqZ/L4Wk0URMVNN0oR0PVMufVtw
	 M6U35wv5OoGXVKpv8bIVfIeCeYBYZToRLwhKJcy2rQwU8p5XfwZPGXXMz+ypc7rUZ9X7J
	 zUNX5uNZ47+HjcBdRtu7rGCgPJLsKkfrvIOrZ2T0hXrIsGrHtgXsbFKZGRVg6k75E/vg0
	 MuMztdnNNEqhGurVyrUMdJ4oPsko+iCss+ftKWJ1oCYvP2mEldT1oytkBpl7UTcCO/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=L+xjXDds;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hs5YoKBc;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842DF606A32E
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 01:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 842DF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=L+xjXDds;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hs5YoKBc
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B3301140009E
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 20:07:42 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 06 Nov 2026 20:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794013662; x=1794100062; bh=WMt2O1m2wT
	YqqX738OBm2thvwt57I5pwL81RZykJ32A=; b=L+xjXDdsAaVAzPzX2OVcTFMjUB
	w00J4vg9Ujzf50WhD0e43ngaYg4kVdOALRYZpmTrrz+sUhrFya8HlJ3Evy/MyTjX
	jZjWX6Dv3BvktjbnIw/sThGZckXdvE9flMR1GJUmK+wo9x5BDGnkd/9NXkcf2TsK
	pkxUNovm89WcD5M2q18hCkx2TDr55IGiTPgGjJ6ZVhqsu8GggE6t6qnYngaRLukp
	K45tEmLgQa2xcZZ85RB7oBAQzBLXcT4NWgJmu6LZQC5ysUqQEamS9kyI0+RCzN1p
	AhXkySoicYE7XSgNskwAwXgU5p7sAJ/Nyt0zM2DS9xioQz2YcoPRffzabx/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794013662; x=1794100062; bh=WMt2O1m2wTYqqX738OBm2thvwt57I5pwL81
	RZykJ32A=; b=hs5YoKBcOhU73Pup2qTp4TJKKxJdpxjgZuytzz6eIAXadVvBUwn
	hyA5lGGct1Qd19z7vQkyjQGmsjH3jTSuKmy6jqgYCTLF5PV9SUCgJlaRWbOfHTjQ
	zLhFDGhzX0Y1BA6i/mSl59eJyQS4riqnCd3vnoNU0+rQrd2fvDDV6jq19HMD+exl
	m97SR3LLeSCUetkn6fPVmFVF+OH1zmUWjwi9j32Llcz5MabfoIbB6Ruit1M56Dxf
	RjxwoxT37lYVNheRnb1mfctnfJXmLI8TrSli0C2r9hb2JLAW/WFYIzRyfa/uU1yG
	GlN/AqQcqNJmOnxh/7ZnckUTrSLjuBJX7vQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794013662; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:W0oA8hSgnzJyUi2xEYyx3k/++UgPGoqWQwmakr9erz/P77E
	I7sqdcfELoefC1T+5XEbelOoFkt9yoOdwtzatf4Pv+EQ19rxzqrNSzbvjYhVMu6a
	cHRCnFTw8X94iYs5UuYpd8KNNCErtm1G3nX7atAcUggS8utdKJZTPjwl6vbbEhgo
	mu3vgxkunnbgnHsBgLjv7LONXttsT4OVZXTFpoxq6Xvb5SWbD6Fc7wP5pdh4MxdC
	Ld9rUkh8ap2r2xm6wyXAQfdkM92w4CEylIgGAGswPwtTK43OUox7i8bqeJbCuiZI
	IOclMdqQGFfjNWHoIhDY8+0te/nGQOroBNfubow==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:8MDazJykbA7guevP9A+g27S3THXC7PGr3YYc3I8zgto=:wfkz/GB+3iUcqvKNKxM0Ux2UdjBnBN1QbOvw+XSrWj4=;
X-ME-Sender: <xms:3nnuan4DBXjhsGdVh_-xCZ4UMo7dDPFzASIG_oZGSTTYKsZWz04k4Q>
    <xme:3nnuar-r1qXX2VjAjbyRDCOP9361Xe3VnA1vYpJj7x48NSBmj5Wph4ibJOnzYZr3G
    b6j_J89uDzC9Drho1c8OcIjX3hyAKsNRcqAxOVOoVZwcr_eqCFyraA>
X-ME-Received: <xmr:3nnuakp4VQQLL-wAx56mShfEU63AjoAKKEtvvasA2fYCYNhjoV-NzaOekUrrprs258SX5W33SqIRfCzzVeslWoUmso15hzusrhgy>
X-ME-Proxy-Cause: dmFkZTF7e2dYQ0IV0sf90m4s24AB5IQ76vE5fUtIOdDxeqIVcGqbUmLe87/uW3mF1luyHD
    MWid5wx3JrZJw8auyq+/QdT06pi/2Cj4TEuKn1r1ymatPRohlfWsjeHsGPkItqimCC5ln4
    n419r6gcrJAXOsC16xAdUpgdQ6j97xPyXh2WfYfZp50mamiyZrscm2cSgTsM6r/B1y7g9L
    +q5qKMAAB7uf+H7dYsPhIeYuAeI+jU4gUCBLPyfplKJa1sWjiwHnHnnzYv4bfiNgq76pzV
    8dBEK+DjLpC1Gxs2rEtJOuE4UJQJMY6AGqsZettV4Tg88OnDiTGPCr9rj7VQDBBJkO2Mt/
    60XIzJw73btNNxoeHUv7KS+W36Lx0lR0mLZdXAhtqVLnLJRxskAQYur7xt6HyjXaVxDLDS
    0NM/58t6ke/4D7ezL0TEiR0F0ryiIjP08ffNYof1VBkZs2cHeG/y9Yc0Cv0kjO3MfegDYR
    Ed1BCywqJh1KnWmfSu1t0rtVeu+y49D5BNJVYATAx46Jpz5Mr0TbJBK+j071MgNm6YyR+A
    QLmoYihXhKvjbuk9eX/fzX+HKDSQ+LAICs+fJ+QVS1B3rQIMohjjX1s08BwBnSVY0TK1Ni
    rFmHtlX61PowaeSiK+HHkJ30ZiJXiVJKpiE/ESzGx790jhfzvEtEv+zwi9RA
X-ME-Proxy: <xmx:3nnuakrRlycm8Z25c4sNygjoevnSWZgd0cYcQF5adTSAAXMkcs_69w>
    <xmx:3nnuav0mI4bvE6vRcb-iz3XFLzlquUf0OtbI1okiSL_UVLozQ_aGtw>
    <xmx:3nnuaqHl8unR0PQD6mHbApg1q0S-yMzRtBT1xVZwVDJMoSlj18sqmg>
    <xmx:3nnuaiG86afbW8C-BMjcATPXh1hI7YecUgwEaHALWuujMw9IvH6-iQ>
    <xmx:3nnuat612LEtrBpwKQNYBMT5LoLTmWIjYj7Q351MlYe-bMdSfo30iOuL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 20:07:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Patrick Steinhardt <ps@pks.im>
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>,  git@vger.kernel.org,
  christian.couder@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH] merge: stop using the_repository
In-Reply-To: <CAPSxiM_2Dd86rBKPj7jaT8Wmazo3PFZajJaaL2bVhB1GFsfnbg@mail.gmail.com>
	(Usman Akinyemi's message of "Thu, 15 Oct 2026 17:59:20 +0100")
References: <20261015142532.48175-1-okhuomonajayi54@gmail.com>
	<CAPSxiM_2Dd86rBKPj7jaT8Wmazo3PFZajJaaL2bVhB1GFsfnbg@mail.gmail.com>
Date: Fri, 06 Nov 2026 17:07:40 -0800
Message-ID: <xmqq33tdcuub.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

>>  merge.c | 16 +++++++---------
>>  1 file changed, 7 insertions(+), 9 deletions(-)
>
>> +               strvec_push(&cmd.args, merge_argument(r, j->item));
>>         strvec_push(&cmd.args, "--");
>>         strvec_push(&cmd.args, head_arg);
>>         for (j = remotes; j; j = j->next)
>> -               strvec_push(&cmd.args, merge_argument(j->item));
>> +               strvec_push(&cmd.args, merge_argument(r, j->item));
>>
>>         cmd.git_cmd = 1;
>>         ret = run_command(&cmd);
>> @@ -68,18 +66,18 @@ int checkout_fast_forward(struct repository *r,
>>         memset(&trees, 0, sizeof(trees));
>>         memset(&t, 0, sizeof(t));
>>         }
>>         for (i = 0; i < nr_trees; i++) {
>> -               if (repo_parse_tree(the_repository, trees[i]) < 0) {
>> +               if (repo_parse_tree(r, trees[i]) < 0) {
>>                         rollback_lock_file(&lock_file);
>>                         return -1;
>>                 }

This shows one thing that I really hate about the current
USE_THE_REPOSITORY model.

This function still calls unpack_trees(), which explicitly refers to
and depends on the_repository.  It is somewhat misleading to claim
that merge.c no longer depends on the_repository because of that.
Even if you pass an arbitrary repository to checkout_fast_forward(),
the call would not work as intended because unpack_trees() called by
it will only work with the_repository under the hood.

Yet, this file now compiles without USE_THE_REPOSITORY defined,
giving a false sense of achievement.

The attached patch is what I did while reviewing your patch, trying
to get unpack_trees.c to compile without USE_THE_REPOSITORY.  This
was done on top of 'seen', so it is more of an RFC or technology
demonstration than a serious patch to be applied (yet).

Note that I did not say that the patch allows unpack_trees() to work
on a repository other than the_repository.  That is because many
code paths called by unpack_trees() may still have hidden, hardcoded
dependencies on the_repository.

Again, that is why I really hate the USE_THE_REPOSITORY macro.  It
does not help us measure our progress incrementally.  Perhaps we
could hide certain symbols from their header files (like the
functions I converted in this demonstration patch to rid them of
the_repository dependency) for those who do not define the macro,
so we can get a more accurate picture of our progress.  However,
an earlier attempt to do exactly that on notes-utils.h in
https://lore.kernel.org/git/xmqqjymt94l3.fsf@gitster.g/ was shot
down by Patrick, so I am not sure what a good direction would be
to provide a real incremental progress indicator.

Anyway, provided that we will someday make the functions called by
the functions your patch touched to remove the references to
the_repository also work on arbitrary repositories (and the attached
patch could be one of the changes necessary to go there), I think
your patch is taking us in a better direction.  Let's mark the topic
as ready for 'next'.

Thanks.

 unpack-trees.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 76 insertions(+), 18 deletions(-)

diff --git c/unpack-trees.c w/unpack-trees.c
index 2e40537dd4..7419793cda 100644
--- c/unpack-trees.c
+++ w/unpack-trees.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -82,6 +81,56 @@ static const char *unpack_plumbing_errors[NB_UNPACK_TREES_WARNING_TYPES] = {
 	  ? ((o)->internal.msgs[(type)])      \
 	  : (unpack_plumbing_errors[(type)]) )
 
+
+/*
+ * Some functions in these code paths get unpack_trees_options, which
+ * has up to two istates, and some get an istate.  These istates can
+ * be used to find the repository to be used for this operation.
+ *
+ * As these are all working on the same repository, they must match.
+ * For now, with a super paranoid check, make sure all potential
+ * sources of the information match before using it.
+ *
+ * Once this proves working well, we could just use the first one we
+ * find in a production setting.
+ */
+static struct repository *unpack_repo(struct index_state *istate,
+				      struct unpack_trees_options *o)
+{
+	struct repository *repo = NULL;
+	const char *camefrom = NULL;
+
+	if (istate) {
+		if (!istate->repo)
+			BUG("istate->repo == NULL");
+		repo = istate->repo;
+		camefrom = "istate->repo";
+	}
+	if (o) {
+		if (o->src_index) {
+			if (!o->src_index->repo)
+				BUG("o->src_index->repo == NULL");
+			if (repo && repo != o->src_index->repo)
+				BUG("%s != o->src_index->repo", camefrom);
+			repo = o->src_index->repo;
+			camefrom = "o->src_index->repo";
+		}
+
+		if (o->dst_index) {
+			if (!o->dst_index->repo)
+				BUG("o->dst_index->repo == NULL");
+			if (repo && repo != o->dst_index->repo)
+				BUG("%s != o->dst_index->repo", camefrom);
+			repo = o->dst_index->repo;
+		}
+	}
+	if (!repo)
+		BUG("no repository for unpack_trees()?");
+	return repo;
+
+}
+
+
 static const char *super_prefixed(const char *path, const char *super_prefix)
 {
 	/*
@@ -345,15 +394,16 @@ static void load_gitmodules_file(struct index_state *index,
 				 struct checkout *state)
 {
 	int pos = index_name_pos(index, GITMODULES_FILE, strlen(GITMODULES_FILE));
+	struct repository *repo = unpack_repo(index, NULL);
 
 	if (pos >= 0) {
 		struct cache_entry *ce = index->cache[pos];
 		if (!state && ce->ce_flags & CE_WT_REMOVE) {
-			repo_read_gitmodules(the_repository, 0);
+			repo_read_gitmodules(repo, 0);
 		} else if (state && (ce->ce_flags & CE_UPDATE)) {
-			submodule_free(the_repository);
+			submodule_free(repo);
 			checkout_entry(ce, state, NULL, NULL);
-			repo_read_gitmodules(the_repository, 0);
+			repo_read_gitmodules(repo, 0);
 		}
 	}
 }
@@ -362,6 +412,7 @@ static struct progress *get_progress(struct unpack_trees_options *o,
 				     struct index_state *index)
 {
 	unsigned cnt = 0, total = 0;
+	struct repository *repo = unpack_repo(index, o);
 
 	if (!o->update || !o->verbose_update)
 		return NULL;
@@ -372,7 +423,7 @@ static struct progress *get_progress(struct unpack_trees_options *o,
 			total++;
 	}
 
-	return start_delayed_progress(the_repository,
+	return start_delayed_progress(repo,
 				      _("Updating files"), total);
 }
 
@@ -430,6 +481,7 @@ static int check_updates(struct unpack_trees_options *o,
 	struct progress *progress;
 	struct checkout state = CHECKOUT_INIT;
 	int i, pc_workers, pc_threshold;
+	struct repository *repo = unpack_repo(index, o);
 
 	trace_performance_enter();
 	state.super_prefix = o->super_prefix;
@@ -473,7 +525,7 @@ static int check_updates(struct unpack_trees_options *o,
 	if (should_update_submodules())
 		load_gitmodules_file(index, &state);
 
-	if (repo_has_promisor_remote(the_repository))
+	if (repo_has_promisor_remote(repo))
 		/*
 		 * Prefetch the objects that are to be checked out in the loop
 		 * below.
@@ -879,6 +931,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 	struct traverse_info newinfo;
 	struct name_entry *p;
 	int nr_entries;
+	struct repository *repo = unpack_repo(NULL, o);
 
 	nr_entries = all_trees_same_as_cache_tree(n, dirmask, names, info);
 	if (nr_entries > 0) {
@@ -940,7 +993,7 @@ static int traverse_trees_recursive(int n, unsigned long dirmask,
 			const struct object_id *oid = NULL;
 			if (dirmask & 1)
 				oid = &names[i].oid;
-			buf[nr_buf++] = fill_tree_descriptor(the_repository, t + i, oid);
+			buf[nr_buf++] = fill_tree_descriptor(repo, t + i, oid);
 		}
 	}
 
@@ -1773,24 +1826,25 @@ static int clear_ce_flags(struct index_state *istate,
 	static struct strbuf prefix = STRBUF_INIT;
 	char label[100];
 	int rval;
+	struct repository *repo = unpack_repo(istate, NULL);
 
 	strbuf_reset(&prefix);
 	if (show_progress)
 		istate->progress = start_delayed_progress(
-					the_repository,
+					repo,
 					_("Updating index flags"),
 					istate->cache_nr);
 
 	xsnprintf(label, sizeof(label), "clear_ce_flags(0x%08lx,0x%08lx)",
 		  (unsigned long)select_mask, (unsigned long)clear_mask);
-	trace2_region_enter("unpack_trees", label, istate->repo);
+	trace2_region_enter("unpack_trees", label, repo);
 	rval = clear_ce_flags_1(istate,
 				istate->cache,
 				istate->cache_nr,
 				&prefix,
 				select_mask, clear_mask,
 				pl, 0, 0);
-	trace2_region_leave("unpack_trees", label, istate->repo);
+	trace2_region_leave("unpack_trees", label, repo);
 
 	stop_progress(&istate->progress);
 	return rval;
@@ -1885,13 +1939,13 @@ static int verify_absent(const struct cache_entry *,
  */
 int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options *o)
 {
-	struct repository *repo = o->src_index->repo;
+	struct repository *repo = unpack_repo(NULL, o);
 	int i, ret;
 	static struct cache_entry *dfc;
 	struct pattern_list pl;
 	int free_pattern_list = 0;
 	struct dir_struct dir = DIR_INIT;
-	struct repo_config_values *cfg = repo_config_values(the_repository);
+	struct repo_config_values *cfg = repo_config_values(repo);
 
 	if (o->reset == UNPACK_RESET_INVALID)
 		BUG("o->reset had a value of 1; should be UNPACK_TREES_*_UNTRACKED");
@@ -1936,7 +1990,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		populate_from_existing_patterns(o, &pl);
 	}
 
-	index_state_init(&o->internal.result, o->src_index->repo);
+	index_state_init(&o->internal.result, repo);
 	o->internal.result.initialized = 1;
 	o->internal.result.timestamp.sec = o->src_index->timestamp.sec;
 	o->internal.result.timestamp.nsec = o->src_index->timestamp.nsec;
@@ -2081,7 +2135,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		move_index_extensions(&o->internal.result, o->src_index);
 		if (!ret) {
 			if (git_env_bool("GIT_TEST_CHECK_CACHE_TREE", 0) &&
-			    cache_tree_verify(the_repository,
+			    cache_tree_verify(repo,
 					      &o->internal.result) < 0) {
 				ret = -1;
 				goto done;
@@ -2137,10 +2191,11 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o,
 	int i;
 	unsigned old_show_all_errors;
 	int free_pattern_list = 0;
+	struct repository *repo = unpack_repo(NULL, o);
 
 	old_show_all_errors = o->internal.show_all_errors;
 	o->internal.show_all_errors = 1;
-	index_state_init(&o->internal.result, o->src_index->repo);
+	index_state_init(&o->internal.result, repo);
 
 	/* Sanity checks */
 	if (!o->update || o->index_only || o->skip_sparse_checkout)
@@ -2333,10 +2388,11 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	struct dir_struct d;
 	char *pathbuf;
 	int cnt = 0;
+	struct repository *repo = unpack_repo(NULL, o);
 
 	if (S_ISGITLINK(ce->ce_mode)) {
 		struct object_id oid;
-		int sub_head = repo_resolve_gitlink_ref(the_repository, ce->name,
+		int sub_head = repo_resolve_gitlink_ref(repo, ce->name,
 							"HEAD", &oid);
 		/*
 		 * If we are not going to update the submodule, then
@@ -2424,6 +2480,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 			      struct unpack_trees_options *o)
 {
 	const struct cache_entry *result;
+	struct repository *repo = unpack_repo(NULL, o);
 
 	/*
 	 * It may be that the 'lstat()' succeeded even though
@@ -2432,7 +2489,7 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 	 *
 	 * Ignore that lstat() if it matches.
 	 */
-	if (repo_ignore_case(the_repository) && icase_exists(o, name, len, st))
+	if (repo_ignore_case(repo) && icase_exists(o, name, len, st))
 		return 0;
 
 	if (o->internal.dir &&
@@ -2652,6 +2709,7 @@ static int merged_sparse_dir(const struct cache_entry * const *src, int n,
 	void * tree_bufs[MAX_UNPACK_TREES + 1];
 	struct traverse_info info;
 	int i, ret;
+	struct repository *repo = unpack_repo(NULL, o);
 
 	/*
 	 * Create the tree traversal information for traversing into *only* the
@@ -2665,7 +2723,7 @@ static int merged_sparse_dir(const struct cache_entry * const *src, int n,
 
 	/* Get the tree descriptors of the sparse directory in each of the merging trees */
 	for (i = 0; i < n; i++)
-		tree_bufs[i] = fill_tree_descriptor(o->src_index->repo, &t[i],
+		tree_bufs[i] = fill_tree_descriptor(repo, &t[i],
 						    src[i] && !is_null_oid(&src[i]->oid) ? &src[i]->oid : NULL);
 
 	ret = traverse_trees(o->src_index, n, t, &info);


