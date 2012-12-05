From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] git-svn: Document branches with at-sign(@).
Date: Wed, 05 Dec 2012 11:27:35 -0800
Message-ID: <7vsj7kjo48.fsf@alter.siamese.dyndns.org>
References: <cover.1354693001.git.Sebastian.Leske@sleske.name>
 <ae56cb0c64972d2caa35743485f251f9d1652a61.1354693001.git.Sebastian.Leske@sleske.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Sebastian Leske <Sebastian.Leske@sleske.name>
X-From: git-owner@vger.kernel.org Wed Dec 05 20:27:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgKdP-0008JN-6k
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 20:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab2LET1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 14:27:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48023 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174Ab2LET1i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 14:27:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 257BE9E3D;
	Wed,  5 Dec 2012 14:27:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cj5QD/G57Q6+Eb9wYZuebuVV0L0=; b=bw6mmD
	nEAxMWzg2Cholfh8ZCQmC8YEJLLao+ryP6fXKl50stQlHQhETc4XVJtdgscxV3Hl
	hOJVqtsJRTxcJirvk0MRqHaFJhwLFAqxaGAzxgY3N6hUaW+YHliupQuBudGLd9lZ
	/o7WwI9zvf6DZLeIRFfyBzMj0czGDLD5wJ9Ew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZbzWyaPmnTZoJDri0ZQqh3CCulNXNFww
	/mztBFckVxnch5mKAjkrdLkCDE54ROPue/m7/si1vB8lcwry6HzUsoBu/SipWiql
	ZKqGsxA4jtQln1VgrzMZaQVhlTmkQu6No9RfiDWm/jUgu8aRyhZOAiWOUSHtolmJ
	QDRo1Pw4Syk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D59F9E3C;
	Wed,  5 Dec 2012 14:27:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41C249E3B; Wed,  5 Dec 2012
 14:27:37 -0500 (EST)
In-Reply-To: <ae56cb0c64972d2caa35743485f251f9d1652a61.1354693001.git.Sebastian.Leske@sleske.name> (Sebastian Leske's message of "Fri, 30 Nov 2012 08:16:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3ABA434-3F11-11E2-8B21-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211137>

Sebastian Leske <Sebastian.Leske@sleske.name> writes:

> git svn sometimes creates branches with an at-sign in the name
> (branchname@revision). These branches confuse many users and it is a FAQ
> why they are created. Document when git svn creates them.
>
> Signed-off-by: Sebastian Leske <sebastian.leske@sleske.name>
> ---
>  Documentation/git-svn.txt |   47 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)

Thanks.  Your hunk header says that there should be 53 lines in the
postimage, but there actually are only 52.  I'll hand-tweak the
message and apply.

> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 8b0d3ad..55bed53 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -830,6 +830,53 @@ inside git back upstream to SVN users.  Therefore it is advised that
>  users keep history as linear as possible inside git to ease
>  compatibility with SVN (see the CAVEATS section below).
>  
> +HANDLING OF SVN BRANCHES
> +------------------------
> +If 'git svn' is configured to fetch branches (and --follow-branches
> +is in effect), it will sometimes create multiple git branches for one
> +SVN branch, where the addtional branches have names of the form
> +'branchname@nnn' (with nnn an SVN revision number).  These additional
> +branches are created if 'git svn' cannot find a parent commit for the
> +first commit in an SVN branch, to connect the branch to the history of
> +the other branches.
> +
> +Normally, the first commit in an SVN branch consists
> +of a copy operation. 'git svn' will read this commit to get the SVN
> +revision the branch was created (copied) from. It will then try to find the
> +git commit that corresponds to this SVN revision, and use that as the
> +parent of the branch. However, it is possible that there is no suitable
> +git commit to serve as parent.  This will happen, among other reasons,
> +if the SVN branch is a copy of a revision that was not fetched by 'git
> +svn' (e.g. because it is an old revision that was skipped with
> +'--revision'), or if in SVN a directory was copied that is not tracked
> +by 'git svn' (such as a branch that is not tracked at all, or a
> +subdirectory of a tracked branch). In these cases, 'git svn' will still
> +create a git branch, but instead of using an existing git commit as the
> +parent of the branch, it will read the SVN history of the directory the
> +branch was copied from and create appropriate git commits (this is
> +indicated by the message "Initializing parent: <branchname>").
> +
> +Additionally, it will create a special branch named
> +'<branchname>@<SVN-Revision>', where <SVN-Revision> is the SVN revision
> +number the branch was copied from.  This branch will point to the newly
> +created parent commit of the branch.  If in SVN the branch was deleted
> +and later recreated from a different version, there will be multiple
> +such branches with an '@'.
> +
> +Note that this may mean that multiple git commits are created for a
> +single SVN revision.
> +
> +An example: In an SVN repository with a standard
> +trunk/tags/branches layout, a directory trunk/sub is created in r.100.
> +In r.200, trunk/sub is branched by copying it to branches/. 'git svn
> +clone -s' will then create a branch 'sub'. It will also create new git
> +commits for r.100 through r.199 and use these as the history of branch
> +'sub'. Thus there will be two git commits for each revision from r.100
> +to r.199 (one containing trunk/, one containing trunk/sub/). Finally,
> +it will create a branch 'sub@200' pointing to the new parent commit of
> +branch 'sub' (i.e. the commit for r.200 and trunk/sub/).
> +
>  CAVEATS
>  -------
