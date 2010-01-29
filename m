From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 13:35:10 -0800
Message-ID: <7vzl3wh9wx.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com>
 <fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com>
 <7veil8iqnj.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001291256j71e2c95cic21cb5a6a0cc1fe8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 22:35:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NayUz-0002On-0W
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366Ab0A2VfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 16:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755001Ab0A2VfY
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:35:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902Ab0A2VfX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 16:35:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C30795BFF;
	Fri, 29 Jan 2010 16:35:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ep6Owkb8yzmyhT8f1xUG8Kxc9z0=; b=TYKm77
	9Nse4/BVCMXwK3/lTdegISKJN28H66mfiuLcSIeeSY8MgwIaat66vupFBTJCZ35a
	T+lmIg2CGFzsG+7G27+LJHR0HKoZwI+oaiIXPQz7nZBcBvp7SNdPHMzKAMDd5YY2
	mqjl6NNWLnQu3NZhsRqFRMCRCoBdIvwWbfbPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F0d9v9saTXjyg1YiRAGdHoAvP/6KrLLe
	8jKReFSdH1al2dt3XR52rLuNicm3CQwI5N/MmbJ/TpTBNRP2ur1gb5Wtbyfq7JsL
	jYYufYcugE/5fVS+Q3/bJnIbvJ7TmB7Jgc9UQwVXmovidT2LUq/U75JI5WCGygjF
	XuuBc3N0i+o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B8E395BFE;
	Fri, 29 Jan 2010 16:35:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0458E95BFC; Fri, 29 Jan
 2010 16:35:11 -0500 (EST)
In-Reply-To: <fabb9a1e1001291256j71e2c95cic21cb5a6a0cc1fe8@mail.gmail.com>
 (Sverre Rabbelier's message of "Fri\, 29 Jan 2010 21\:56\:30 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3152E904-0D1E-11DF-9FBF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138369>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Fri, Jan 29, 2010 at 21:48, Junio C Hamano <gitster@pobox.com> wrote:
>> I think "not a branch" is a good suggestion, whether the target of
>> checkout is "master^" or "origin/topic".
>
> Mhhh, for added clarity, do we want to change it to "branch name"? Since ...
>
> $ git grep "branch name" Documentation/ | wc -l
> 58
>
> ... suggests that we use that in other places as well?

I think the confusion is twofold:

    $ git checkout master^
    Note: moving to 'master^' which isn't a local branch
    If you want to create a new branch from this checkout, you may do so
    ...

The notice tells us:

 - We are moving to 'master^', but it doesn't say what that really means;

 - That 'master^' isn't a local branch, but it doesn't say why it matters
   if it is a local branch (name) or not.

But what it really should tell new people are:

 - The user is no longer on any branch;

 - What the implications of not being on any branch are;

Your "branch _name_" suggestion deals with another issue that is of lessor
importance compared to the above two:

 - The _reason_ we are detaching HEAD is because 'master^' did not spell a
   name of a local branch.

 - and perhaps how to be on a branch instead of detaching the head like so.

Compare the current output from "git checkout $commit" with output from
"git checkout topic" when you don't have a local branch "topic" but have a
unique remote tracking branch with the same name from a remote, namely
"origin" (that's the UI improvement from Dscho I mentioned in the previous
message):

    $ git checkout topic
    Branch topic set up to track remote branch topic from origin.
    Switched to a new branch 'topic'

which very clearly explains what is going on.

The current advisory message tells you what to do to create a new branch,
but doesn't explain why you might want to do so (or what is the downside
of not doing so) in the first place.  That adds to frustration for new
people.

So how about this strawman?

    $ git checkout origin/topic
    Note: checking out commit 'origin/topic'.
    You are no longer on any branch. You can look around, make changes and
    record them in new commits, but any new commit you make from now on will
    be lost when you check out another branch. If you want to create a new
    branch from this state to keep them, you may do so (now or later) by
    using -b with the checkout command again. Example:

      git checkout -b new_branch_name

    HEAD is now at f423ef5... tests: allow user to specify trash direc...

and hide the lines from "Note: checking out..." to the blank line before
"HEAD is now at" inside advice.detachedHEAD, so that people who know what
detached head is and want to take advantage of it to experiment without
having to worry about cleaning up will have to see only:

    $ git checkout origin/topic
    HEAD is now at f423ef5... tests: allow user to specify trash direc...



diff --git a/advice.c b/advice.c
index 936d98b..0be4b5f 100644
--- a/advice.c
+++ b/advice.c
@@ -5,6 +5,7 @@ int advice_status_hints = 1;
 int advice_commit_before_merge = 1;
 int advice_resolve_conflict = 1;
 int advice_implicit_identity = 1;
+int advice_detached_head = 1;
 
 static struct {
 	const char *name;
@@ -15,6 +16,7 @@ static struct {
 	{ "commitbeforemerge", &advice_commit_before_merge },
 	{ "resolveconflict", &advice_resolve_conflict },
 	{ "implicitidentity", &advice_implicit_identity },
+	{ "detachedhead", &advice_detached_head },
 };
 
 int git_default_advice_config(const char *var, const char *value)
diff --git a/advice.h b/advice.h
index 9b7a3ad..3244ebb 100644
--- a/advice.h
+++ b/advice.h
@@ -8,6 +8,7 @@ extern int advice_status_hints;
 extern int advice_commit_before_merge;
 extern int advice_resolve_conflict;
 extern int advice_implicit_identity;
+extern int advice_detached_head;
 
 int git_default_advice_config(const char *var, const char *value);
 
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 5277817..0719e54 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -522,8 +522,16 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 		update_ref(msg.buf, "HEAD", new->commit->object.sha1, NULL,
 			   REF_NODEREF, DIE_ON_ERR);
 		if (!opts->quiet) {
-			if (old->path)
-				fprintf(stderr, "Note: moving to '%s' which isn't a local branch\nIf you want to create a new branch from this checkout, you may do so\n(now or later) by using -b with the checkout command again. Example:\n  git checkout -b <new_branch_name>\n", new->name);
+			if (old->path && advice_detached_head)
+				fprintf(stderr, 
+"Note: checking out commit '%s'.\n"
+"You are no longer on any branch. You can look around, make changes and\n"
+"record them in new commits, but any new commit you make from now on will\n"
+"be lost when you check out another branch. If you want to create a new\n"
+"branch from this state to keep them, you may do so (now or later) by\n"
+"using -b with the checkout command again. Example:\n\n"
+"  git checkout -b new_branch_name\n\n",
+					new->name);
 			describe_detached_head("HEAD is now at", new->commit);
 		}
 	}
