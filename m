Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A436F909
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786562581; cv=none; b=qS3xnb9OBTCwGkc4UdueGz8Ws3EHEvsuAe+BPta2ONygksPugQDrETZEl5ha1HWLAsGDrLQtwHPMZwrvyEhtYVH8/xGqunoQBEPGapmlurqHpipA5LKEB6575AoIDmVZsTHXzGHwdxKUyf/gUTI6kdoxKwdG4xbYFVzs6veqRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786562581; c=relaxed/simple;
	bh=0jcckuVsixY06CtzKDkBbEq9qYU8qyVJEQfm2LGcOTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=op6OUYRDub/FS3Zup3Wax8CkEYwtLV2L8yvBOkrGK1bnZXyTnn14unHcF/ihBdylPcbLeHnY5sDjWKz8l0Spp9+ji0DBZ8yXyGn5snlI0W4VbOS4sR7xvgmfkkE/57r/YwSd2OT4lA7OG/tmrG5Fh3+cDIZyUOAthrDpOl2GdGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hzaSpOHC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZxnUMeFT; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hzaSpOHC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZxnUMeFT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 202357A00F0;
	Wed, 12 Aug 2026 15:22:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 12 Aug 2026 15:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786562577; x=1786648977; bh=Z19Dinh9wJ
	YCQHwaiFE/BfDqv/tEXQutVLdqHLjUQu0=; b=hzaSpOHC3+y4xdeOXDITWRjOjQ
	+LBTMflxWYUjtzL9v2ndYTb3gBMqvp22Q/yKg21wbY0rsILQ0Srb0sYxbw8n+h/1
	8XOoxOUgL6fJaoG3DKNzhML9OjihkM9wdFl61+xUjLsV5fOLmCmSPtbrSxUB/2Pr
	U/2aVwZ3k0EdwIz9shbooxzbhgZT5wysCej1WPCl3Wl97Lb7cKhGTL/7jaHbx/4m
	BA96ssr5UicIFHsKmabZ5aQnjCk/9fMQ4PD8RGbH9gnvxEqciKyuF+VvMWMbxMg0
	Xhsg9z3RQrpIivqZdI3o6RuOdFcdzbojsFURZALo1aa5+6hu3F9eNzpXRovQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786562577; x=1786648977; bh=Z19Dinh9wJYCQHwaiFE/BfDqv/tEXQutVLd
	qHLjUQu0=; b=ZxnUMeFT+c1zO7DvuxeJNZKd2m/lxwET9104vpOmuKNDGfAYu4+
	3L7kqp72PgI1XyEDMhl9J0upLGRJKd4GHYopzaHeCBXUSGFIt4zfRtMjkiW6Imku
	Puq32+HzKHr3Gk8q1D/mlzZ2b8kjBluVjMo9RtC6l6P1HJX8nU629mj5vCuvj7dS
	91y4NfSWZBM5QrNBOZ/c4k0h0XxFxkpeBTJkruLvE4/mYvmOvSMY/Pv83xrkmQuN
	Tjbx4mIMn3dmK7knp2NP4A70su0P/H0DMwulaqMCq/bm52pTsHEib2O0Q8KW+znH
	+ubhpvhUsE1Tg2nGZWXEdd+1z2tibbbT95w==
X-ME-Sender: <xms:Ech8agfNAT6ot3fnYVGlnzASsdhvuAZA3U641RmPIbG12OXlMuU18A>
    <xme:Ech8al7X3RAZ_n1ZBeE0pYKWWcewnRKhFB1JTAKj4eXZumG2VRFCgvSWCSky87v9f
    Bl5rP_V3Och_r_9TmT0RSOmfKsZthl6BzZ9IE-SbF_bxFhrRJK2KsQ>
X-ME-Received: <xmr:Ech8arWBXtU7eiG0qOdArjNZWZTspkGDiusYcB6C1AP0aCSwOmk97B7UIPTroyOpPq65WHg8lK9UmMNMFsxSPh4_HvGMWrnb5g>
X-ME-Proxy-Cause: dmFkZTFLFhM3h8x+xsgV4YLzQEQ9Rr2hazmk35H6mPO/BjFiqLokPrLP6BM2ply1PeJRcA
    9XP613LzGwzB4IOOty+ASuZ/j9fRONEjcCtj7CWq6TxWqdVMAcbT4oAArSw7R3R6xkOKal
    IjTp35P0FtyZMfTTS6aNZTq2WCJFDRxCb4xIz2bPfcHp/cNKWmbz2wwUqb9YaxIF3+HEte
    nrNB2+LVNjXIk4x1qMPAqOXMekozoGGzX7vzc5gzfjqIyoMlTU3qUz8OKZ2/WpF48vFH3I
    V1cicht7ehzXyu4VXdZIjFV+98408Lm0lxbP7Yh1Vn7NNrzhTL4SFCjzzmRx7XD1jzVRBn
    PVxYFoKeK3QuoySW1nLDR2cDZc7lXOpXMUjUGib3FeRgjrXQjXsiAX9y1oYzNJNHOKh087
    xbkSIGpHtmlkBdIMxHCF/T+/nuP3pfGdqQc3bsTpoj3gH/PjOnf+u4Hkd/JctOW2vyQFAh
    2LVSPSyFSVAXWYu56zEAuDTJSpIXAwKHSqirjLAIg2s7P2mQ7Y61fzlbfTCKW/lPdS+Iou
    1+ozltBVFJteqsCuaJWApOhIrYCOtO38MiMK1M0jEK++xlLzY2tpawv2TyuGl/7CUIDCG/
    tGSIIITHJC8BIj3ijma5codYNqD4H1EyvkKmpH2gvnHvI9/h+NYPWEjHDQEA
X-ME-Proxy: <xmx:Ech8as5Hjy4nw5K810awsUOr5ZSuqgYviQRZyGnivZZqdnsNCIx_FA>
    <xmx:Ech8aup14slF3msVNR8va8ao5GQuVfTAA-2R0TOADhT-cQolNOYrJg>
    <xmx:Ech8anmPRJoDuQwDBeK8PkxNahe3CekmifE7LHrQcz2lU06Duo4kag>
    <xmx:Ech8aiNDrIfAXFROj-2neWDIFT0_NQ5uD4MLPgpF-TWEgJ0kpd3ILQ>
    <xmx:Ech8apDi-AnvKSkzpxUZmwO_dW3022orW7wN_O3Zxd3eOCz3LCYihzh1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 15:22:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>,  "D.
 Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v3] worktree add: improve message for ambiguous remote
 branch name
In-Reply-To: <CAF5D8-uCjA-MFtdBCa0+5PDb-LFJ7JJ0yK1AtuWCKEN+tKQa_Q@mail.gmail.com>
	(Yoichi Nakayama's message of "Tue, 11 Aug 2026 15:31:54 +0900")
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v3.git.1786395305884.gitgitgadget@gmail.com>
	<xmqqecg55xqq.fsf@gitster.g>
	<CAF5D8-uCjA-MFtdBCa0+5PDb-LFJ7JJ0yK1AtuWCKEN+tKQa_Q@mail.gmail.com>
Date: Wed, 12 Aug 2026 12:22:55 -0700
Message-ID: <xmqqjypvw3cg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yoichi Nakayama <yoichi.nakayama@gmail.com> writes:

>> Instead of throwing the problem back to the user with four extra
>> lines of message telling them how to run 'git branch', I would have
>> expected this patch to teach unique_tracking_name() to optionally
>> return the list of remotes with that branch name, and to use that
>> result in this message.  However, if the goal is simply to provide
>> something better than 'invalid reference', we do not even need to
>> go that far.  Just stating that branch 'y' appears on multiple
>> remotes and asking them to clarify which one they mean might be a
>> sufficient improvement.
>
> Extending `unique_tracking_name()` would also affect the implementation
> in `checkout.c`, and since the goal here is to improve the messages
> (making them as helpful as those in `checkout`), I will hold off on doing
> that for now.

Sorry but I do not quite understand this logic.

Giving unique_tracking_name() the optional ability to report which
remotes have a branch with the given name does not have to affect
other callers of the function at all; that is the definition of a
new feature being "optional."

Furthermore, the goal of improving these messages falls short if we
withhold the list of remotes the user could have meant, which we are
already computing internally to decide that the original request is
ambiguous.

>> Could the original request be aiming to create a new worktree with
>> the HEAD detached at the commit pointed at by the remote-tracking
>> branch, instead of creating a local branch forked from it?  I am
>> just wondering if "-b %s" is too specific to one possible
>> interpretation that may contradict to what the user actually wanted
>> to do.
>
> If the user is aiming to create a new worktree with the HEAD detached,
> one would specify a fully qualified branch name like origin/bar-topic,
> starting with a remote name.

I am not sure about this part, either.  After all, we are trying to
help a user who made a mistake composing their command-line
arguments.  If they specify a fully qualified branch name like
'origin/bar-topic' (regardless of whether they want to create a
detached 'HEAD' or not), they would not hit the 'saying bar-topic
alone is ambiguous' error path, would they?

Here is a patch to show what I mean.  To 'improve the message for an
ambiguous remote branch name' for the 'checkout' command, we can add
this optional feature to the unique_tracking_name() function and we
can do so without affecting the 'worktree add' command.

Regardless of whether we modify unique_tracking_name(), I think
refactoring be_explicit() is worth doing, as the original code in
parse_remote_branch() was badly misindented.


 builtin/checkout.c | 74 ++++++++++++++++++++++++++++++++----------------------
 builtin/worktree.c |  4 +--
 checkout.c         | 14 +++++++++--
 checkout.h         |  5 +++-
 4 files changed, 62 insertions(+), 35 deletions(-)

diff --git c/builtin/checkout.c w/builtin/checkout.c
index 55e3a89a85..8d61973a11 100644
--- c/builtin/checkout.c
+++ w/builtin/checkout.c
@@ -1343,13 +1343,50 @@ enum checkout_command {
 	CHECKOUT_RESTORE = 3,
 };
 
+static void be_explicit(enum checkout_command which_command,
+			const struct string_list *matched_remote_names)
+{
+	const char *cmdname;
+	struct string_list_item *item;
+
+	switch (which_command) {
+	case CHECKOUT_CHECKOUT:
+		cmdname = "checkout";
+		break;
+	case CHECKOUT_SWITCH:
+		cmdname = "switch";
+		break;
+	default:
+		BUG("command <%d> should not reach parse_remote_branch",
+		     which_command);
+		break;
+	}
+
+	advise(_("Branches with the same name appears in multiple remotes:"));
+	for_each_string_list_item(item, matched_remote_names) {
+		advise(_("  %s"), item->string);
+	}
+	advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
+		 "you can do so by fully qualifying the name with the --track option:\n"
+		 "\n"
+		 "    git %s --track origin/<name>\n"
+		 "\n"
+		 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
+		 "one remote, e.g. the 'origin' remote, consider setting\n"
+		 "checkout.defaultRemote=origin in your config."),
+	       cmdname);
+}
+
 static char *parse_remote_branch(const char *arg,
 				 struct object_id *rev,
 				 int could_be_checkout_paths,
 				 enum checkout_command which_command)
 {
 	int num_matches = 0;
-	char *remote = unique_tracking_name(arg, rev, &num_matches);
+	struct string_list matched_remote_names = STRING_LIST_INIT_DUP;
+
+	char *remote = unique_tracking_name(arg, rev, &num_matches,
+					    &matched_remote_names);
 
 	if (remote && could_be_checkout_paths) {
 		die(_("'%s' could be both a local file and a tracking branch.\n"
@@ -1358,37 +1395,14 @@ static char *parse_remote_branch(const char *arg,
 	}
 
 	if (!remote && num_matches > 1) {
-	    if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME)) {
-		    const char *cmdname;
-
-		    switch (which_command) {
-		    case CHECKOUT_CHECKOUT:
-			    cmdname = "checkout";
-			    break;
-		    case CHECKOUT_SWITCH:
-			    cmdname = "switch";
-			    break;
-		    default:
-			    BUG("command <%d> should not reach parse_remote_branch",
-				which_command);
-			    break;
-		    }
-
-		    advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
-			     "you can do so by fully qualifying the name with the --track option:\n"
-			     "\n"
-			     "    git %s --track origin/<name>\n"
-			     "\n"
-			     "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
-			     "one remote, e.g. the 'origin' remote, consider setting\n"
-			     "checkout.defaultRemote=origin in your config."),
-			   cmdname);
-	    }
-
-	    die(_("'%s' matched multiple (%d) remote tracking branches"),
-		arg, num_matches);
+		if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
+			be_explicit(which_command, &matched_remote_names);
+		die(_("'%s' matched multiple (%d) remote tracking branches"),
+		    arg, num_matches);
 	}
 
+	string_list_clear(&matched_remote_names, 0);
+
 	return remote;
 }
 
diff --git c/builtin/worktree.c w/builtin/worktree.c
index 654d27c3e1..22c8e5e131 100644
--- c/builtin/worktree.c
+++ w/builtin/worktree.c
@@ -782,7 +782,7 @@ static char *dwim_branch(const char *path, char **new_branch)
 	*new_branch = branchname;
 	if (guess_remote) {
 		struct object_id oid;
-		char *remote = unique_tracking_name(*new_branch, &oid, NULL);
+		char *remote = unique_tracking_name(*new_branch, &oid, NULL, NULL);
 		return remote;
 	}
 	return NULL;
@@ -904,7 +904,7 @@ static int add(int ac, const char **av, const char *prefix,
 
 		commit = lookup_commit_reference_by_name(branch);
 		if (!commit) {
-			remote = unique_tracking_name(branch, &oid, NULL);
+			remote = unique_tracking_name(branch, &oid, NULL, NULL);
 			if (remote) {
 				new_branch = branch;
 				branch = new_branch_to_free = remote;
diff --git c/checkout.c w/checkout.c
index 1588b116ee..2806b783ec 100644
--- c/checkout.c
+++ w/checkout.c
@@ -8,6 +8,7 @@
 #include "checkout.h"
 #include "config.h"
 #include "strbuf.h"
+#include "string-list.h"
 
 struct tracking_name_data {
 	/* const */ char *src_ref;
@@ -17,6 +18,7 @@ struct tracking_name_data {
 	const char *default_remote;
 	char *default_dst_ref;
 	struct object_id *default_dst_oid;
+	struct string_list **remote_names;
 };
 
 #define TRACKING_NAME_DATA_INIT { 0 }
@@ -39,6 +41,8 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 		oidcpy(dst, cb->dst_oid);
 		cb->default_dst_oid = dst;
 	}
+	if (cb->remote_names)
+		string_list_append(*cb->remote_names, remote->name);
 	if (cb->dst_ref) {
 		free(query.dst);
 		return 0;
@@ -48,14 +52,20 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 }
 
 char *unique_tracking_name(const char *name, struct object_id *oid,
-			   int *dwim_remotes_matched)
+			   int *dwim_remotes_matched,
+			   struct string_list *dwim_remote_names)
 {
 	struct tracking_name_data cb_data = TRACKING_NAME_DATA_INIT;
 	const char *default_remote = NULL;
-	if (!repo_config_get_string_tmp(the_repository, "checkout.defaultremote", &default_remote))
+
+	if (!repo_config_get_string_tmp(the_repository,
+					"checkout.defaultremote",
+					&default_remote))
 		cb_data.default_remote = default_remote;
 	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
 	cb_data.dst_oid = oid;
+	if (dwim_remote_names)
+		cb_data.remote_names = &dwim_remote_names;
 	for_each_remote(check_tracking_name, &cb_data);
 	if (dwim_remotes_matched)
 		*dwim_remotes_matched = cb_data.num_matches;
diff --git c/checkout.h w/checkout.h
index 55920e7aeb..0b185a0fc9 100644
--- c/checkout.h
+++ w/checkout.h
@@ -3,6 +3,8 @@
 
 #include "hash.h"
 
+struct string_list;
+
 /*
  * Check if the branch name uniquely matches a branch name on a remote
  * tracking branch.  Return the name of the remote if such a branch
@@ -10,6 +12,7 @@
  */
 char *unique_tracking_name(const char *name,
 			   struct object_id *oid,
-			   int *dwim_remotes_matched);
+			   int *dwim_remotes_matched,
+			   struct string_list *dwim_remote_names);
 
 #endif /* CHECKOUT_H */


