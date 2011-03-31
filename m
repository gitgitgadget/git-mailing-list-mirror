From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Merging multiple branches in invalid HEAD state
Date: Thu, 31 Mar 2011 01:11:10 -0500
Message-ID: <20110331061110.GA16353@elie>
References: <AANLkTi=tK+J8jNDK4ZWT3re2NyQ4yT5im5JEMVgQca9m@mail.gmail.com>
 <AANLkTik3ip7Ukv56oyEsYX7isTFBGcK3mN367evnvW6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Timothy Chen <tnachen@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 08:11:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5B6L-0006zI-4Q
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 08:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641Ab1CaGLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 02:11:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50797 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab1CaGLT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 02:11:19 -0400
Received: by gyd10 with SMTP id 10so846027gyd.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 23:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=nFW8+ZSc+MjeOAuwYWHFlGeywiQH5PG+0H1zLFLTlnw=;
        b=k9qkxtgHULE7MQMwjcsX7kOA28QS3mikUyLY4z3FNbmduzt21zUWcFK55lFrzAa8fR
         WgFZiJfW9MT/eerC0WtgGpFlaQuG8F50Qtbqok+V4DnK+6OPY2l8me5yPCMqfJcuIjHy
         m4Dj1TpxrncrfqAC1MLQMr7Lv2igSEdMrc5rU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cdFyjPO3WGbFuIIQlRl/i+aN2YePl3gpeMRRs4tjV26LJiSKIT+uqkQQfaJJZISI+v
         T6E9OpVjijdI4CKDBL56D9vPTSPPMjttF08/VkNU1tPRj5FpWpdH29NdB72gvTOQHWug
         sR85d+sDIqx0uj7Q6qRciGy+NqbnmVYAlgkG8=
Received: by 10.146.102.34 with SMTP id z34mr2206178yab.34.1301551878552;
        Wed, 30 Mar 2011 23:11:18 -0700 (PDT)
Received: from elie (adsl-68-255-107-98.dsl.chcgil.ameritech.net [68.255.107.98])
        by mx.google.com with ESMTPS id d36sm871568and.30.2011.03.30.23.11.15
        (version=SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 23:11:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTik3ip7Ukv56oyEsYX7isTFBGcK3mN367evnvW6A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170456>

(+cc: git@vger)
Hi Tim,

Timothy Chen wrote:

> I believe my patch never get delievered to the mailing list.
>
> Can you review my patch and maybe forward it for me?

Yep, it seems this never hit the mailing list.  What mail client do
you use?  Documentation/SubmittingPatches has some advice under
"Gmail".

Quick review follows.

> Hi all, I'm interested in Gsoc and this is my first patch to Git.
>
> Please let me know if there is any format/things to change.

By the way, I'd encourage you to submit rough proposals for projects
you're interested in at google-melange.com asap and to send a copy to
this list (cc-ing potential mentors) as soon as you're ready to
discuss and refine them.

> ---------------------------------------------------------------------------------------
> 
> From a72e72f58c073eccd987159f72d969d6e748aff0 Mon Sep 17 00:00:00 2001
> From: Timothy Chen <tnachen@gmail.com>
> Date: Mon, 28 Mar 2011 23:58:32 -0700
> Subject: [PATCH] Allow multiple merges to invalid head

Okay, let's get the message format out of the way first. :)  These
lines should not be part of the message body but are meant for your
mailer --- in other words, the usual patch format is

	From: Patch Author <a.u.thor@example.com>
	Date: Mon, 28 Mar 2011 23:58:32 -0700
	Subject: [PATCH] subsystem: quick summary of impact of change

	Explanation of the behavior the patch will change, why it
	needs changing, and how the patch changes it.

	Sign-off.
	---
	Hello,

	Additional comments that are not suitable for the changelog.

	Diffstat and actual patch.

where the From, Date, and Subject lines above represent lines from the
rfc822 email header.  So the actual body of the message begins with
"Explanation of..." [2].

Not so important now, but doing that makes the messages a little
easier to read, and more importantly, allows the patch can be
automatically applied with "git am" without editing once it is ready.

> Subject: [PATCH] Allow multiple merges to invalid head
>
> Currently git merge will only accept one branch when the current branch's
> HEAD is invalid (or pointing to null), which it will when it is a newly
> created repo.

At first, this sounded to me like it was about when HEAD is corrupt or
has been explicitly set to the null sha1.  Maybe a phrase like "HEAD
does not point to a valid commit yet" or "HEAD points to a branch yet
to be born" would be clearer?

[...]
> This patch will allow multiple branches to be passed in, and first updates
> current HEAD to the first branch's head then subsequently merge the rest of
> the branches.

Thanks; sounds intuitive and useful.

> ---
>  builtin/merge.c |   60 +++++++++++++++++++++++++++++++-----------------------
>  1 files changed, 34 insertions(+), 26 deletions(-)
> 
> diff --git a/builtin/merge.c b/builtin/merge.c
> index aa3453c..6956d5e 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1052,9 +1052,7 @@ int cmd_merge(int argc, const char **argv, const char
> *prefix)

It looks like your mailer corrupts the patch a bit (by wrapping lines
and compressing whitespace).  SubmittingPatches can help here; until
the perfect setup is ready, attaching patches might be a good
workaround to get patches through unscathed.

I've just made up the whitespace below to get by, so it might be wrong.

>  	 * to forbid "git merge" into a branch yet to be born.
>  	 * We do the same for "git pull".
>  	 */
> -	if (argc != 1)
> -		die("Can merge only exactly one commit into "
> -			"empty head");
> +

Dropping the restriction.  Yippee!

>  	if (squash)
>  		die("Squash commit into empty head not supported yet");
>  	if (!allow_fast_forward)
> @@ -1065,34 +1063,44 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  			die("%s - not something we can merge", argv[0]);
>  		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
>  				DIE_ON_ERR);
> +		memcpy(head, remote_head->sha1, 20);
>  		read_empty(remote_head->sha1, 0);

Also can be written as

		hashcpy(head, remote_head->sha1);

At this point, we have advanced the current branch to the first commit
named on the command line, the "branch" var has the name of the
branch, and "head" contains the commit name.

> -		return 0;
> +		if (argc < 2) {
> +			return 0;
> +		} else {
> +			head_arg = argv[0];
> +			argc--;
> +			argv++;
> +       	}
> +	}

The "else" is not needed, since the easy case returned already.  So:

		if (argc < 2)
			return 0;

		/*
		 * "git merge foo bar baz" from an unborn branch amounts to
		 *
		 * 1. git reset --keep foo
		 * 2. git merge bar baz
		 *
		 * We just did step 1; now on to step 2...
		 */
		head_arg = argv[0];
		hashcpy(head, remote_head->sha1);
		argc--;
		argv++;
	}

What happens if argc == 0?  That case was checked higher up in the
function; phew.

> -	} else {
> -		struct strbuf merge_names = STRBUF_INIT;
> -
> -		/* We are invoked directly as the first-class UI. */
> -		head_arg = "HEAD";
> +
> +	struct strbuf merge_names = STRBUF_INIT;
> +
> +	/* We are invoked directly as the first-class UI. */
> +	if (!head_invalid)
> +		head_arg = "HEAD";

Makes sense.  (I guess if I ran the world, head_arg would be
initialized to begin with to NULL, and this would say

	if (!head_arg)
		head_arg = "HEAD";

so the reader of this part would not have to worry about what
head_invalid means and why the first-class UI is guarding against
it.  But that is really a tiny nit.)

> -
> -		/*
> -		 * All the rest are the commits being merged;
> +	/*
> +	 * All the rest are the commits being merged;
[etc]

These are just whitespace spaces; makes sense.

[...]
> -	if (head_invalid || !argc)
> +	if (!argc)
>  		usage_with_options(builtin_merge_usage,
>  			builtin_merge_options);

What was the head_invalid case originally guarding against?  Is it
protected against now?

It would also be nice to add some tests so we don't lose this
functionality later; but aside from that and the small points
noted above, the patch looks good to me.  Thanks for writing it.

Hope that helps,
Jonathan

[1] http://bugs.debian.org/432558
[2] There is also an alternative "am --scissors" format the might be
useful for sending a patch and maintaining the flow of a previous
conversation:

	Someone wrote:

	> blah blah blah

	Yes, that makes sense.  How about this patch?
	-- 8< --
	Subject: subsystem: quick summary of the impact of the change

	Explanation ...

	Sign-off.
	---
	Diffstat and actual patch.

In both cases, you can add a "From:" and "Date:" line before the patch
explanation to override the values from the email header, in case you
are forwarding a patch from someone else.  "git am --help" gives more
details.
