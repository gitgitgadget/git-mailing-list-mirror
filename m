From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] push: Enhance unspecified push default warning
Date: Wed, 06 Nov 2013 14:55:53 -0800
Message-ID: <xmqqiow56sxy.fsf@gitster.dls.corp.google.com>
References: <CAKYC+eKCsRbF=6HtcY8ZtaafTDpbMFJ1tyWbaZDKrmbzdnOoUw@mail.gmail.com>
	<CAKYC+eLvx1vB1ZDqYK=7Dg68QuCojBdSAVQZMF6HBtfxu_b_aw@mail.gmail.com>
	<xmqqvc08yq4v.fsf@gitster.dls.corp.google.com>
	<1839883487.4893076.1383646619137.JavaMail.root@imag.fr>
	<xmqqk3gl8id0.fsf@gitster.dls.corp.google.com>
	<xmqqfvr98f5h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Jacobson <coder5000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Nov 06 23:56:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeC12-0003bf-Tj
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 23:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab3KFWz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 17:55:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61653 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235Ab3KFWz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 17:55:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75F0350F33;
	Wed,  6 Nov 2013 17:55:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FBDFzd6Ai6p9e++CzfucbSCPRQo=; b=p88fBZ
	jngDkB0POScmsUlN19e4KzNvMBzFCaJkEe6snB5WSXpDBGy27qWmIolShSGc9l3Y
	ImGc34R1yt4IS42dyrftW9N14qJvxSuBlppgJzpefwZdupz5HJu5+bS15IKD52li
	lsJYzve6ZECVkHTxzFMg1yrD584fWqE3GwIg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZfIniqxzqbCLVwyp8GwdV0x5dRpo7K+/
	7WYnPvSLuS0KR0J0hEZKMs4YIGrXXzTe4Ib9GHECXyXCiMhfCrHnflN2xPxXT++7
	CgpBtZEbH15vgEdjYASUqWCK+ZiG37ruC75yN4H+GhwqmIqP7+4WBkkPafiX+2SH
	YpROy7Tc4qE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6895B50F32;
	Wed,  6 Nov 2013 17:55:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D3E750F31;
	Wed,  6 Nov 2013 17:55:54 -0500 (EST)
In-Reply-To: <xmqqfvr98f5h.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 06 Nov 2013 12:10:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 977BC3F8-4736-11E3-A6AB-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237379>

Junio C Hamano <gitster@pobox.com> writes:

> Also applying this will have an unpleasant fallout to merging the
> endgame patch b2ed944a (push: switch default from "matching" to
> "simple", 2013-01-04).  The added text needs to be corrected with an
> evil merge.
>
> I'd prefer to having worry about such a fallout only once.  Which
> arguably we already did when we came up with the current message, so
> I am fairly annoyed by this patch coming loooooong after we
> concluded the original discussion.
>
> Sigh X-<.  I'll worry about this later, as b2ed944a is in 'next'
> during the feature freeze, and I'd prefer not having to rebase it on
> top of the final version of this patch.

Here is a rebase of the endgame patch, on top of the result of
applying Greg's patch (you have to fix the line-wrapping in the
message, though). The only change from the version we have been
cooking since January is the message in builtin/push.c.  I haven't
checked if the result merges cleanly to other topics in flight
though.

It will be quite messy to merge this and Greg's patch to anything
past 3153a9e8 (Merge branch 'jc/push-2.0-default-to-simple' into
next, 2013-10-28), which already has the original endgame patch, so
I'll postpone it until later (I still need to tag 1.8.5-rc1 today).

Thanks.

-- >8 --
Subject: [PATCH] push: switch default from "matching" to "simple"

We promised to change the behaviour of lazy "git push [there]" that
does not say what to push on the command line from "matching" to
"simple" in Git 2.0.

This finally flips that bit.

Helped-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt   | 14 ++++----------
 Documentation/git-push.txt | 10 ++++++----
 advice.c                   |  2 --
 advice.h                   |  1 -
 builtin/push.c             | 37 ++++++++++---------------------------
 5 files changed, 20 insertions(+), 44 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab26963..bb45969 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -142,19 +142,13 @@ advice.*::
 --
 	pushUpdateRejected::
 		Set this variable to 'false' if you want to disable
-		'pushNonFFCurrent', 'pushNonFFDefault',
+		'pushNonFFCurrent',
 		'pushNonFFMatching', 'pushAlreadyExists',
 		'pushFetchFirst', and 'pushNeedsForce'
 		simultaneously.
 	pushNonFFCurrent::
 		Advice shown when linkgit:git-push[1] fails due to a
 		non-fast-forward update to the current branch.
-	pushNonFFDefault::
-		Advice to set 'push.default' to 'upstream' or 'current'
-		when you ran linkgit:git-push[1] and pushed 'matching
-		refs' by default (i.e. you did not provide an explicit
-		refspec, and no 'push.default' configuration was set)
-		and it resulted in a non-fast-forward error.
 	pushNonFFMatching::
 		Advice shown when you ran linkgit:git-push[1] and pushed
 		'matching refs' explicitly (i.e. you used ':', or
@@ -1929,7 +1923,7 @@ When pushing to a remote that is different from the remote you normally
 pull from, work as `current`.  This is the safest option and is suited
 for beginners.
 +
-This mode will become the default in Git 2.0.
+This mode has become the default in Git 2.0.
 
 * `matching` - push all branches having the same name on both ends.
   This makes the repository you are pushing to remember the set of
@@ -1948,8 +1942,8 @@ suitable for pushing into a shared central repository, as other
 people may add new branches there, or update the tip of existing
 branches outside your control.
 +
-This is currently the default, but Git 2.0 will change the default
-to `simple`.
+This used to be the default, but not since Git 2.0 (`simple` is the
+new default).
 
 --
 
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 9eec740..5553f99 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -78,8 +78,8 @@ the local side, the remote side is updated if a branch of the same name
 already exists on the remote side.
 
 --all::
-	Instead of naming each ref to push, specifies that all
-	refs under `refs/heads/` be pushed.
+	Push all branches (i.e. refs under `refs/heads/`); cannot be
+	used with other <refspec>.
 
 --prune::
 	Remove remote branches that don't have a local counterpart. For example
@@ -437,8 +437,10 @@ Examples
 	configured for the current branch).
 
 `git push origin`::
-	Without additional configuration, works like
-	`git push origin :`.
+	Without additional configuration, pushes the current branch to
+	the configured upstream (`remote.origin.merge` configuration
+	variable) if it has the same name as the current branch, and
+	errors out without pushing otherwise.
 +
 The default behavior of this command when no <refspec> is given can be
 configured by setting the `push` option of the remote, or the `push.default`
diff --git a/advice.c b/advice.c
index 3eca9f5..486f823 100644
--- a/advice.c
+++ b/advice.c
@@ -2,7 +2,6 @@
 
 int advice_push_update_rejected = 1;
 int advice_push_non_ff_current = 1;
-int advice_push_non_ff_default = 1;
 int advice_push_non_ff_matching = 1;
 int advice_push_already_exists = 1;
 int advice_push_fetch_first = 1;
@@ -23,7 +22,6 @@ static struct {
 } advice_config[] = {
 	{ "pushupdaterejected", &advice_push_update_rejected },
 	{ "pushnonffcurrent", &advice_push_non_ff_current },
-	{ "pushnonffdefault", &advice_push_non_ff_default },
 	{ "pushnonffmatching", &advice_push_non_ff_matching },
 	{ "pushalreadyexists", &advice_push_already_exists },
 	{ "pushfetchfirst", &advice_push_fetch_first },
diff --git a/advice.h b/advice.h
index 08fbc8e..5ecc6c1 100644
--- a/advice.h
+++ b/advice.h
@@ -5,7 +5,6 @@
 
 extern int advice_push_update_rejected;
 extern int advice_push_non_ff_current;
-extern int advice_push_non_ff_default;
 extern int advice_push_non_ff_matching;
 extern int advice_push_already_exists;
 extern int advice_push_fetch_first;
diff --git a/builtin/push.c b/builtin/push.c
index 5393e28..a79354d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -26,7 +26,6 @@ static struct push_cas_option cas;
 static const char **refspec;
 static int refspec_nr;
 static int refspec_alloc;
-static int default_matching_used;
 
 static void add_refspec(const char *ref)
 {
@@ -164,9 +163,9 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 }
 
 static char warn_unspecified_push_default_msg[] =
-N_("push.default is unset; its implicit value is changing in\n"
+N_("push.default is unset; its implicit value has changed in\n"
    "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
-   "and maintain the current behavior after the default changes, use:\n"
+   "and maintain the traditional behavior, use:\n"
    "\n"
    "  git config --global push.default matching\n"
    "\n"
@@ -175,11 +174,11 @@ N_("push.default is unset; its implicit value is changing in\n"
    "  git config --global push.default simple\n"
    "\n"
    "When push.default is set to 'matching', git will push all local branches\n"
-   "to the remote branches with the same (matching) name.  This will no\n"
-   "longer be the default in Git 2.0 because a branch could be\n"
+   "to the remote branches with the same (matching) name.  This is no\n"
+   "longer the default since Git 2.0 because a branch could be\n"
    "unintentionally pushed to a remote.\n"
    "\n"
-   "In Git 2.0 the new push.default of 'simple' will push only the current\n"
+   "In Git 2.0 the new push.default of 'simple' pushes only the current\n"
    "branch to the same remote branch used by git pull.   A push will\n"
    "only succeed if the remote and local branches have the same name.\n"
    "\n"
@@ -209,14 +208,14 @@ static void setup_default_push_refspecs(struct remote *remote)
 
 	switch (push_default) {
 	default:
-	case PUSH_DEFAULT_UNSPECIFIED:
-		default_matching_used = 1;
-		warn_unspecified_push_default_configuration();
-		/* fallthru */
 	case PUSH_DEFAULT_MATCHING:
 		add_refspec(":");
 		break;
 
+	case PUSH_DEFAULT_UNSPECIFIED:
+		warn_unspecified_push_default_configuration();
+		/* fallthru */
+
 	case PUSH_DEFAULT_SIMPLE:
 		if (triangular)
 			setup_push_current(remote, branch);
@@ -245,12 +244,6 @@ static const char message_advice_pull_before_push[] =
 	   "'git pull ...') before pushing again.\n"
 	   "See the 'Note about fast-forwards' in 'git push --help' for details.");
 
-static const char message_advice_use_upstream[] =
-	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
-	   "counterpart. If you did not intend to push that branch, you may want to\n"
-	   "specify branches to push or set the 'push.default' configuration variable\n"
-	   "to 'simple', 'current' or 'upstream' to push only the current branch.");
-
 static const char message_advice_checkout_pull_push[] =
 	N_("Updates were rejected because a pushed branch tip is behind its remote\n"
 	   "counterpart. Check out this branch and integrate the remote changes\n"
@@ -279,13 +272,6 @@ static void advise_pull_before_push(void)
 	advise(_(message_advice_pull_before_push));
 }
 
-static void advise_use_upstream(void)
-{
-	if (!advice_push_non_ff_default || !advice_push_update_rejected)
-		return;
-	advise(_(message_advice_use_upstream));
-}
-
 static void advise_checkout_pull_push(void)
 {
 	if (!advice_push_non_ff_matching || !advice_push_update_rejected)
@@ -347,10 +333,7 @@ static int push_with_options(struct transport *transport, int flags)
 	if (reject_reasons & REJECT_NON_FF_HEAD) {
 		advise_pull_before_push();
 	} else if (reject_reasons & REJECT_NON_FF_OTHER) {
-		if (default_matching_used)
-			advise_use_upstream();
-		else
-			advise_checkout_pull_push();
+		advise_checkout_pull_push();
 	} else if (reject_reasons & REJECT_ALREADY_EXISTS) {
 		advise_ref_already_exists();
 	} else if (reject_reasons & REJECT_FETCH_FIRST) {
-- 
1.8.5-rc0-343-g6932893
