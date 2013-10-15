From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] symbolic-ref: trivial style fix
Date: Tue, 15 Oct 2013 15:16:38 -0700
Message-ID: <xmqq4n8ich89.fsf@gitster.dls.corp.google.com>
References: <1379780993-4190-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 00:16:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWCv3-0001ri-VX
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 00:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759838Ab3JOWQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 18:16:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57058 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759587Ab3JOWQo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 18:16:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39DF84A564;
	Tue, 15 Oct 2013 22:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ShdJahJyLdhdkXVxRO+VqLighdk=; b=V9uuyy
	fJ8AaZJRHeL+Ftl+lEwnRlB7G8rD81wNXhYLaWB30XGn8AhoMi/erHzrmDKFzWO4
	vm19aS2q6iVCRVH/jNsVxRar2dtlnCdvmsp5G4hptpf3HDXut1QeoBQ33VccFHHY
	KI1UTgT+MyAK8XiIdCmJEstiVpTv1pW2M2pgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y8kL0wWwwm6+TwpR5X6GQ4JU4G0Mx079
	GuGCI0HX5pqWsUHlwyXakhOL2duy90xr9FboNIzxE9NAI4YmIiJrCnTQNgPB3QYF
	B7VWMl46SKucLwTFhEercEGRzI1tE77ElnkjYCAjoqOa8GcrJcUHzSEsAg1W5Fay
	NJ37snp36ig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AD414A563;
	Tue, 15 Oct 2013 22:16:41 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 870A04A560;
	Tue, 15 Oct 2013 22:16:40 +0000 (UTC)
In-Reply-To: <1379780993-4190-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 21 Sep 2013 11:29:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 773F831E-35E7-11E3-8B04-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236205>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

Let's do something like this instead.

 - We usually refrain from making such a tree-wide change in order
   to avoid unnecessary conflicts with other "real work" patches,
   but the end result does not have a potentially cumbersome
   tree-wide impact.

 - We also tend to frown upon an "I fixed it here only because I
   happened to notice this one, there may be others but it is up to
   the readers to see if there are other instances" half-assed code
   churn.

The point of the proposed log message is to tell readers that this
is a tree-wide clean-up that is worth applying.

-- >8 --
From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: C: have space around && and || operators

Correct all hits from

    git grep -e '\(&&\|||\)[^ ]' -e '[^	 ]\(&&\|||\)' -- '*.c'

i.e. && or || operators that are followed by anything but a SP,
or that follow something other than a SP or a HT, so that these
operators have a SP around it when necessary.

We usually refrain from making this kind of a tree-wide change in
order to avoid unnecessary conflicts with other "real work" patches,
but the end result does not have a potentially cumbersome tree-wide
impact.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/read-tree.c    | 2 +-
 builtin/rev-list.c     | 2 +-
 builtin/symbolic-ref.c | 2 +-
 compat/regex/regcomp.c | 2 +-
 xdiff/xemit.c          | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 0f5d7fe..0d7ef84 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -178,7 +178,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 
 	if (1 < opts.index_only + opts.update)
 		die("-u and -i at the same time makes no sense");
-	if ((opts.update||opts.index_only) && !opts.merge)
+	if ((opts.update || opts.index_only) && !opts.merge)
 		die("%s is meaningless without -m, --reset, or --prefix",
 		    opts.update ? "-u" : "-i");
 	if ((opts.dir && !opts.update))
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 4fc1616..0745e2d 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -322,7 +322,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		revs.commit_format = CMIT_FMT_RAW;
 
 	if ((!revs.commits &&
-	     (!(revs.tag_objects||revs.tree_objects||revs.blob_objects) &&
+	     (!(revs.tag_objects || revs.tree_objects || revs.blob_objects) &&
 	      !revs.pending.nr)) ||
 	    revs.diff)
 		usage(rev_list_usage);
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index f481959..71286b4 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -47,7 +47,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options,
 			     git_symbolic_ref_usage, 0);
-	if (msg &&!*msg)
+	if (msg && !*msg)
 		die("Refusing to perform update with empty message");
 
 	if (delete) {
diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index b2c5d46..06f3088 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -339,7 +339,7 @@ re_compile_fastmap_iter (regex_t *bufp, const re_dfastate_t *init_state,
 	      p = buf;
 	      *p++ = dfa->nodes[node].opr.c;
 	      while (++node < dfa->nodes_len
-		     &&	dfa->nodes[node].type == CHARACTER
+		     && dfa->nodes[node].type == CHARACTER
 		     && dfa->nodes[node].mb_partial)
 		*p++ = dfa->nodes[node].opr.c;
 	      memset (&state, '\0', sizeof (state));
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 4d86458..4266ada 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -108,7 +108,7 @@ static long def_ff(const char *rec, long len, char *buf, long sz, void *priv)
 {
 	if (len > 0 &&
 			(isalpha((unsigned char)*rec) || /* identifier? */
-			 *rec == '_' ||	/* also identifier? */
+			 *rec == '_' || /* also identifier? */
 			 *rec == '$')) { /* identifiers from VMS and other esoterico */
 		if (len > sz)
 			len = sz;
