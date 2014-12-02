From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Let deny.currentBranch=updateInstead ignore submodules
Date: Mon, 01 Dec 2014 19:24:44 -0800
Message-ID: <xmqqa936ohs3.fsf@gitster.dls.corp.google.com>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
	<84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de>
	<xmqqh9yag6mt.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info>
	<xmqq1tpbawqe.fsf@gitster.dls.corp.google.com>
	<xmqq389qam25.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411121208250.13845@s15462909.onlinehome-server.info>
	<xmqqzjbw47vr.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411131123330.13845@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1411131136200.13845@s15462909.onlinehome-server.info>
	<xmqqh9y32e36.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411131850510.13845@s15462909.onlinehome-server.info>
	<xmqq4mu2285w.fsf@gitster.dls.corp.google.com>
	<xmqqzjbuzu6t.fsf@gitster.dls.corp.google.com>
	<xmqq1tp643yb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 02 04:24:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xve58-000245-LT
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 04:24:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbaLBDYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 22:24:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56084 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753893AbaLBDYr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 22:24:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AD4FF23B27;
	Mon,  1 Dec 2014 22:24:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oF918ACNirUOK9hIYOxhbPcPH14=; b=tj+v9q
	IxGaqz1eriReVKszdvwi6AZArSSOg2cxG2U7e6EKMzEGzc6pejtDX4jtV7iTA0FC
	NeC7VDmymHoHB1SEGQJKmuVUT0hSl0aoqOwv/YrVcx/Z7DYCb1v9dfBo/oh5jSc9
	OutSCuQVsgsKaKyFA+WmKop+63vRScbOh09c8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o67ARDFHu+F5ckphXW4/wdcEg7Zb3lqK
	81UiH9YGF84qFh1NH9xg2PBynXnS6VDtvUR2rrxgpDPjr0Em574O4gkyMJYnAwnk
	cMfouk/xXp/hl0ra3Nfkeo8LMbNpduMB5I7HZgqvp2/2JRrJwQ0M27tyRZ5QNR0A
	abm8Znxsito=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F9A823B26;
	Mon,  1 Dec 2014 22:24:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0419223B25;
	Mon,  1 Dec 2014 22:24:45 -0500 (EST)
In-Reply-To: <xmqq1tp643yb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 13 Nov 2014 23:49:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C3A2FA9E-79D2-11E4-BD4C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260526>

Junio C Hamano <gitster@pobox.com> writes:

>> And thinking about the names again, I have a feeling that
>> updateInstead and mergeInstead are both probably misnomer.
>
> Let me take this part back.  After all, I do not think I would
> design the mechanism to implement an alternative logic that decides
> when it is safe to allow the update of the ref and to reflect the
> changes to the working tree, and that actually does the checkout to
> the working tree by using a new value like mergeInstead.  So we
> would only need a single name, and updateInstead is not too bad.
> ...
> The mechanism I would employ when doing an alternative logic,
> possibly looser one but does not necessarily so, would be to have a
> hook script "push-to-checkout".  When denyCurrentBranch is set to
> updateInstead, if there is no such hook, the "working tree has to be
> absolutely clean and we would do a 'read-tree -m -u $old $new'
> (which is the same as 'reset --hard $new' under the precondition)"
> you implemented will be used as the "logic that decides when it is
> safe, and that does the checkout to the working tree".  When the
> "push-to-checkout" hook exists, however, we just invoke that hook
> with $new as argument, and it can decide when it is safe in whatever
> way it chooses to, and it can checkout the $new to the working tree
> in whatever way it wants.

So here comes a two-patch series on top of your series (with the
test update I sent earlier).  As I never do "push to deploy" that
requires no changes to the working tree or to the index, while I
have seem myself in a situation where I have to emulate a "git pull"
with a "git push" in the opposite direction (and work it around if
the target of the 'git pull' I wanted to do were the current branch,
by first pushing into a throw-away branch, because of denyCurrent),
I could imagine myself using this variant.  Having said that, this
is primarily so that I do not want to forget and discard the brain
cycles we spent discussing this to the waste, more than that I
cannot wait to use this feature myself ;-)

The first one here is a pure refactoring.  The second one is the
real fun.

-- >8 --
Subject: [PATCH 1/2] receive-pack: refactor updateInstead codepath

Keep the "there is nothing to update in a bare repository", "when
the check and update process runs, here are the GIT_DIR and
GIT_WORK_TREE" logic, which will be common regardless of how the
decision to update and the actual update are done, in the original
update_worktree() function, and split out the "working tree and
the index must match the original HEAD exactly" and "use two-way
read-tree to update the working tree" into a new push_to_deploy()
helper function.  This will allow customizing the logic more cleanly
and easily.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c | 53 ++++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c047418..11800cd 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -733,7 +733,9 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	return 0;
 }
 
-static const char *update_worktree(unsigned char *sha1)
+static const char *push_to_deploy(unsigned char *sha1,
+				  struct argv_array *env,
+				  const char *work_tree)
 {
 	const char *update_refresh[] = {
 		"update-index", "-q", "--ignore-submodules", "--refresh", NULL
@@ -748,69 +750,70 @@ static const char *update_worktree(unsigned char *sha1)
 	const char *read_tree[] = {
 		"read-tree", "-u", "-m", NULL, NULL
 	};
-	const char *work_tree = git_work_tree_cfg ? git_work_tree_cfg : "..";
-	struct argv_array env = ARGV_ARRAY_INIT;
 	struct child_process child = CHILD_PROCESS_INIT;
 
-	if (is_bare_repository())
-		return "denyCurrentBranch = updateInstead needs a worktree";
-
-	argv_array_pushf(&env, "GIT_DIR=%s", absolute_path(get_git_dir()));
-
 	child.argv = update_refresh;
-	child.env = env.argv;
+	child.env = env->argv;
 	child.dir = work_tree;
 	child.no_stdin = 1;
 	child.stdout_to_stderr = 1;
 	child.git_cmd = 1;
-	if (run_command(&child)) {
-		argv_array_clear(&env);
+	if (run_command(&child))
 		return "Up-to-date check failed";
-	}
 
 	/* run_command() does not clean up completely; reinitialize */
 	child_process_init(&child);
 	child.argv = diff_files;
-	child.env = env.argv;
+	child.env = env->argv;
 	child.dir = work_tree;
 	child.no_stdin = 1;
 	child.stdout_to_stderr = 1;
 	child.git_cmd = 1;
-	if (run_command(&child)) {
-		argv_array_clear(&env);
+	if (run_command(&child))
 		return "Working directory has unstaged changes";
-	}
 
 	child_process_init(&child);
 	child.argv = diff_index;
-	child.env = env.argv;
+	child.env = env->argv;
 	child.no_stdin = 1;
 	child.no_stdout = 1;
 	child.stdout_to_stderr = 0;
 	child.git_cmd = 1;
-	if (run_command(&child)) {
-		argv_array_clear(&env);
+	if (run_command(&child))
 		return "Working directory has staged changes";
-	}
 
 	read_tree[3] = sha1_to_hex(sha1);
 	child_process_init(&child);
 	child.argv = read_tree;
-	child.env = env.argv;
+	child.env = env->argv;
 	child.dir = work_tree;
 	child.no_stdin = 1;
 	child.no_stdout = 1;
 	child.stdout_to_stderr = 0;
 	child.git_cmd = 1;
-	if (run_command(&child)) {
-		argv_array_clear(&env);
+	if (run_command(&child))
 		return "Could not update working tree to new HEAD";
-	}
 
-	argv_array_clear(&env);
 	return NULL;
 }
 
+static const char *update_worktree(unsigned char *sha1)
+{
+	const char *retval;
+	const char *work_tree = git_work_tree_cfg ? git_work_tree_cfg : "..";
+	struct argv_array env = ARGV_ARRAY_INIT;
+
+	if (is_bare_repository())
+		return "denyCurrentBranch = updateInstead needs a worktree";
+
+	argv_array_pushf(&env, "GIT_DIR=%s", absolute_path(get_git_dir()));
+
+	retval = push_to_deploy(sha1, &env, work_tree);
+
+	argv_array_clear(&env);
+	return retval;
+}
+
 static const char *update(struct command *cmd, struct shallow_info *si)
 {
 	const char *name = cmd->ref_name;
-- 
2.2.0-141-gd3f4719
