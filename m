From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] Recommend use of structure options for git svn.
Date: Mon, 03 Dec 2012 11:30:25 -0800
Message-ID: <7v7gozq6ge.fsf@alter.siamese.dyndns.org>
References: <cover.1354324110.git.Sebastian.Leske@sleske.name>
 <5cb2f71bc9be3323e425205020105dcfd948fca5.1354324110.git.Sebastian.Leske@sleske.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Wong <normalperson@yhbt.net>
To: Sebastian Leske <Sebastian.Leske@sleske.name>
X-From: git-owner@vger.kernel.org Mon Dec 03 20:30:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tfbj5-0005x7-2M
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 20:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978Ab2LCTaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 14:30:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50749 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008Ab2LCTa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 14:30:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31E8CA039;
	Mon,  3 Dec 2012 14:30:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=cMDk1M5dVzg1V9W+7ojPJPZVu8Q=; b=fvDePuok/5BTeDm3YJIY
	IaB3rU1m3gZrZzBU+4jJOKqFdh76/aqfX9qBUFQGFHs0JO2jFhDvF66pDcIiUQRR
	jKeiz+pb182g/Z3wjE7rYI5chdwJO6WHw5flytZaw+y1RCXjSb426XK0tSXJjF/D
	QJKZ4BpymDkdNNHIuBxVqaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=sSfGmzAk+ozOreiNVk/Imnk9JbANhItsiDj+ffZOhbNhrT
	RTUBQo4zQ1SUPjdcRQH4LyiihDYPSdXHET2cw9ba1SLQPNxiYbrs415nSHV/C0b0
	w0VO07c0UVtWXZrqeqcUJQt1sCHxRI6Lwc+hZCs0iIzfhvkIA0AK33NkoyxIE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F1FEA038;
	Mon,  3 Dec 2012 14:30:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4298AA036; Mon,  3 Dec 2012
 14:30:27 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4307CF0-3D7F-11E2-961A-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211054>

Sebastian Leske <Sebastian.Leske@sleske.name> writes:

> Document that when using git svn, one should usually either use the
> directory structure options to import branches as branches, or only
> import one subdirectory. The default behaviour of cloning all branches
> and tags as subdirectories in the working copy is usually not what the
> user wants.
>
> Signed-off-by: Sebastian Leske <sebastian.leske@sleske.name>
> ---
>  Documentation/git-svn.txt |   24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 824bf82..bfa8788 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -739,7 +739,8 @@ for rewriteRoot and rewriteUUID which can be used together.
>  BASIC EXAMPLES
>  --------------
>  
> -Tracking and contributing to the trunk of a Subversion-managed project:
> +Tracking and contributing to the trunk of a Subversion-managed project
> +(ignoring tags and branches):
>  
>  ------------------------------------------------------------------------
>  # Clone a repo (like git clone):
> @@ -764,8 +765,10 @@ Tracking and contributing to an entire Subversion-managed project
>  (complete with a trunk, tags and branches):
>  
>  ------------------------------------------------------------------------
> -# Clone a repo (like git clone):
> -	git svn clone http://svn.example.com/project -T trunk -b branches -t tags
> +# Clone a repo with standard SVN directory layout (like git clone):
> +	git svn clone http://svn.example.com/project --stdlayout
> +# Or, if the repo uses a non-standard directory layout:
> +	git svn clone http://svn.example.com/project -T tr -b branch -t tag

These command line, given that the SYNPOSIS section says:

	git svn <command> [options] [arguments]

look strange to have the URL argument before all the options.

Because the original shares the same trait, this should not be fixed
in this patch, but it may be a good idea to fix the order of the
arguments in a separate follow-up patch.

> @@ -871,6 +874,21 @@ already dcommitted.  It is considered bad practice to --amend commits
>  you've already pushed to a remote repository for other users, and
>  dcommit with SVN is analogous to that.
>  
> +When cloning an SVN repository, if none of the options for describing
> +the repository layout is used (--trunk, --tags, --branches,
> +--stdlayout), 'git svn clone' will create a git repository with
> +completely linear history, where branches and tags appear as separate
> +folders in the working copy.  ...

As existing text in git-svn.txt consistently uses "directory" and
never "folder", please match that terminology (like you did in a
later sentence in your patch).

> ...  While this is the easiest way to get a
> +copy of a complete repository, for projects with many branches it will
> +lead to a working copy many times larger than just the trunk. Thus for
> +projects using the standard directory structure (trunk/branches/tags),
> +it is recommended to clone with option '--stdlayout'. If the project
> +uses a non-standard structure, and/or if branches and tags are not
> +required, it is easiest to only clone one directory (typically trunk),
> +without giving any repository layout options.  If the full history with
> +branches and tags is required, the options '--trunk' / '--branches' /
> +'--tags' must be used.
> +
>  When using multiple --branches or --tags, 'git svn' does not automatically
>  handle name collisions (for example, if two branches from different paths have
>  the same name, or if a branch and a tag have the same name).  In these cases,
