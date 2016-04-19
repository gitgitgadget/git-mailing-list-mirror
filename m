From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/7] i18n: index-pack: use plural string instead of normal one
Date: Tue, 19 Apr 2016 12:06:52 -0700
Message-ID: <xmqqbn551kqb.fsf@gitster.mtv.corp.google.com>
References: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Tue Apr 19 21:07:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asazF-0001Bt-BX
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 21:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003AbcDSTG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 15:06:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54246 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753263AbcDSTG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 15:06:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF44313DF0;
	Tue, 19 Apr 2016 15:06:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QWuXCJDT6mdQ0a5YEIxeTd1lkTw=; b=rfivtE
	V8YCedI5phEK9qVJbwZMVBqV06DmodNHjmsoCmTGpRQT5cUAp4JOarkCikPAgOjv
	6SNQdW4yaoBpwBHrX7UhNHfOZ1ebFc7lmAFF2Jz/3bPvCuijayhl/7+OlsTZN8li
	kuZhSfWdHv4eBCnmy4KRnyl2zSgEPq6Sxzekg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fap7EnxUzja3XXbo+0OJrmeOjI6pZajL
	4S/5A5PhrV/D+eth7TqS1gULqrwQhG4OXqte0IyRlkIRds+KxnSDeox03uBEAsPj
	uGH5SDFaptyKQgwhVpx3P/cY5GQ2QV9BlbdLmPQBxJI1hMOgLswMjjAL+crhsoBw
	F1xd+GXTCg0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AE4E613DEF;
	Tue, 19 Apr 2016 15:06:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1587813DEE;
	Tue, 19 Apr 2016 15:06:54 -0400 (EDT)
In-Reply-To: <1461071964-323-1-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Tue, 19 Apr 2016 13:19:18 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E13056AC-0661-11E6-8FFA-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291908>

Hmph, two patches in the previous series seem to be missing.  On
purpose, or by mistake?  Their net-effect is shown at the end of
this message, and I thought they made sense.

Puzzled...

diff --git a/builtin/branch.c b/builtin/branch.c
index 5ab106b..32be954 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -369,12 +369,14 @@ static char *get_head_description(void)
 		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
 			    state.branch);
 	else if (state.detached_from) {
-		/* TRANSLATORS: make sure these match _("HEAD detached at ")
-		   and _("HEAD detached from ") in wt-status.c */
 		if (state.detached_at)
+			/* TRANSLATORS: make sure this matches
+			   "HEAD detached at " in wt-status.c */
 			strbuf_addf(&desc, _("(HEAD detached at %s)"),
 				state.detached_from);
 		else
+			/* TRANSLATORS: make sure this matches
+			   "HEAD detached from " in wt-status.c */
 			strbuf_addf(&desc, _("(HEAD detached from %s)"),
 				state.detached_from);
 	}
@@ -828,8 +830,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (argc == 1 && track == BRANCH_TRACK_OVERRIDE &&
 		    !branch_existed && remote_tracking) {
 			fprintf(stderr, _("\nIf you wanted to make '%s' track '%s', do this:\n\n"), head, branch->name);
-			fprintf(stderr, _("    git branch -d %s\n"), branch->name);
-			fprintf(stderr, _("    git branch --set-upstream-to %s\n"), branch->name);
+			fprintf(stderr, "    git branch -d %s\n", branch->name);
+			fprintf(stderr, "    git branch --set-upstream-to %s\n", branch->name);
 		}
 
 	} else
