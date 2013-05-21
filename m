From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/17] revision: split some overly-long lines
Date: Tue, 21 May 2013 10:34:49 -0700
Message-ID: <7vzjvonsna.fsf@alter.siamese.dyndns.org>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
	<1368995232-11042-9-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 21 19:35:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeqSf-0006VI-Db
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 19:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755270Ab3EURex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 13:34:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58547 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755201Ab3EURew (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 13:34:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93D8A1E69B;
	Tue, 21 May 2013 17:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qEffO3UADBft4yd1E9XlmaMtc8Y=; b=UXZkO7
	o9P4OzwyIXjMpi9A34mMkJ32Q73DBCQ3likv5yrrfgNmxeYs/8oPptMhmFu69LfB
	phU4jlr33rhalnNHgaN1ZDZyyQSBr7xW/RgUP2urD4HMIlNpLqXhP1xnMIlxqdS3
	4ZOShI5YGCDMqdZjZURlu/OwdP36C4Ot2TOdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lr51rJANNZ8x0Lisy8XhCHEmhODt8IHb
	oSjtA14ikTXvaDlh6xeW3sNQrPD0zLZhO5GcttBco/kVmsDHW99QOk7Ilb2JCO5n
	r+ZkFpy4doygUtaSvwPMRDMm9IUpSmiwR9XbUpZB3r0DXiaOC1zyHCmcVH7/ELI5
	XbcoKsk9/Ys=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A8551E69A;
	Tue, 21 May 2013 17:34:51 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B95371E697;
	Tue, 21 May 2013 17:34:50 +0000 (UTC)
In-Reply-To: <1368995232-11042-9-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Sun, 19 May 2013 22:27:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD807244-C23C-11E2-919A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225048>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  revision.c | 20 ++++++++++++++------
>  revision.h | 32 +++++++++++++++++++++-----------
>  2 files changed, 35 insertions(+), 17 deletions(-)

Looks obviously good for *.c file, but I am on the fence for *.h
one, as the reason we kept these long single lines in *.h files was
to help those who want to grep in *.h files to let them view the
full function signature.  It probably is OK to tell them to use
"git grep -A$n" instead, though.

> diff --git a/revision.c b/revision.c
> index 25e424c..8ac88d6 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -70,7 +70,8 @@ static int show_path_truncated(FILE *out, const struct name_path *path)
>  	return ours || emitted;
>  }
>  
> -void show_object_with_name(FILE *out, struct object *obj, const struct name_path *path, const char *component)
> +void show_object_with_name(FILE *out, struct object *obj,
> +			   const struct name_path *path, const char *component)
>  {
>  	struct name_path leaf;
>  	leaf.up = (struct name_path *)path;
> @@ -186,7 +187,9 @@ void mark_parents_uninteresting(struct commit *commit)
>  	}
>  }
>  
> -static void add_pending_object_with_mode(struct rev_info *revs, struct object *obj, const char *name, unsigned mode)
> +static void add_pending_object_with_mode(struct rev_info *revs,
> +					 struct object *obj,
> +					 const char *name, unsigned mode)
>  {
>  	if (!obj)
>  		return;
> @@ -209,7 +212,8 @@ static void add_pending_object_with_mode(struct rev_info *revs, struct object *o
>  	add_object_array_with_mode(obj, name, &revs->pending, mode);
>  }
>  
> -void add_pending_object(struct rev_info *revs, struct object *obj, const char *name)
> +void add_pending_object(struct rev_info *revs,
> +			struct object *obj, const char *name)
>  {
>  	add_pending_object_with_mode(revs, obj, name, S_IFINVALID);
>  }
> @@ -226,7 +230,9 @@ void add_head_to_pending(struct rev_info *revs)
>  	add_pending_object(revs, obj, "HEAD");
>  }
>  
> -static struct object *get_reference(struct rev_info *revs, const char *name, const unsigned char *sha1, unsigned int flags)
> +static struct object *get_reference(struct rev_info *revs, const char *name,
> +				    const unsigned char *sha1,
> +				    unsigned int flags)
>  {
>  	struct object *object;
>  
> @@ -247,7 +253,8 @@ void add_pending_sha1(struct rev_info *revs, const char *name,
>  	add_pending_object(revs, object, name);
>  }
>  
> -static struct commit *handle_commit(struct rev_info *revs, struct object *object, const char *name)
> +static struct commit *handle_commit(struct rev_info *revs,
> +				    struct object *object, const char *name)
>  {
>  	unsigned long flags = object->flags;
>  
> @@ -368,7 +375,8 @@ static void file_change(struct diff_options *options,
>  	DIFF_OPT_SET(options, HAS_CHANGES);
>  }
>  
> -static int rev_compare_tree(struct rev_info *revs, struct commit *parent, struct commit *commit)
> +static int rev_compare_tree(struct rev_info *revs,
> +			    struct commit *parent, struct commit *commit)
>  {
>  	struct tree *t1 = parent->tree;
>  	struct tree *t2 = commit->tree;
> diff --git a/revision.h b/revision.h
> index 01bd2b7..9628465 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -195,19 +195,23 @@ struct setup_revision_opt {
>  };
>  
>  extern void init_revisions(struct rev_info *revs, const char *prefix);
> -extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct setup_revision_opt *);
> +extern int setup_revisions(int argc, const char **argv, struct rev_info *revs,
> +			   struct setup_revision_opt *);
>  extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
> -				 const struct option *options,
> -				 const char * const usagestr[]);
> +			       const struct option *options,
> +			       const char * const usagestr[]);
>  #define REVARG_CANNOT_BE_FILENAME 01
>  #define REVARG_COMMITTISH 02
> -extern int handle_revision_arg(const char *arg, struct rev_info *revs, int flags, unsigned revarg_opt);
> +extern int handle_revision_arg(const char *arg, struct rev_info *revs,
> +			       int flags, unsigned revarg_opt);
>  
>  extern void reset_revision_walk(void);
>  extern int prepare_revision_walk(struct rev_info *revs);
>  extern struct commit *get_revision(struct rev_info *revs);
> -extern char *get_revision_mark(const struct rev_info *revs, const struct commit *commit);
> -extern void put_revision_mark(const struct rev_info *revs, const struct commit *commit);
> +extern char *get_revision_mark(const struct rev_info *revs,
> +			       const struct commit *commit);
> +extern void put_revision_mark(const struct rev_info *revs,
> +			      const struct commit *commit);
>  
>  extern void mark_parents_uninteresting(struct commit *commit);
>  extern void mark_tree_uninteresting(struct tree *tree);
> @@ -220,15 +224,19 @@ struct name_path {
>  
>  char *path_name(const struct name_path *path, const char *name);
>  
> -extern void show_object_with_name(FILE *, struct object *, const struct name_path *, const char *);
> +extern void show_object_with_name(FILE *, struct object *,
> +				  const struct name_path *, const char *);
>  
>  extern void add_object(struct object *obj,
>  		       struct object_array *p,
>  		       struct name_path *path,
>  		       const char *name);
>  
> -extern void add_pending_object(struct rev_info *revs, struct object *obj, const char *name);
> -extern void add_pending_sha1(struct rev_info *revs, const char *name, const unsigned char *sha1, unsigned int flags);
> +extern void add_pending_object(struct rev_info *revs,
> +			       struct object *obj, const char *name);
> +extern void add_pending_sha1(struct rev_info *revs,
> +			     const char *name, const unsigned char *sha1,
> +			     unsigned int flags);
>  
>  extern void add_head_to_pending(struct rev_info *);
>  
> @@ -238,7 +246,9 @@ enum commit_action {
>  	commit_error
>  };
>  
> -extern enum commit_action get_commit_action(struct rev_info *revs, struct commit *commit);
> -extern enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit);
> +extern enum commit_action get_commit_action(struct rev_info *revs,
> +					    struct commit *commit);
> +extern enum commit_action simplify_commit(struct rev_info *revs,
> +					  struct commit *commit);
>  
>  #endif
