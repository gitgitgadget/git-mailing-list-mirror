From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] git-svn: Expand documentation for --follow-parent
Date: Mon, 03 Dec 2012 11:30:36 -0800
Message-ID: <7vzk1vorvn.fsf@alter.siamese.dyndns.org>
References: <cover.1354324110.git.Sebastian.Leske@sleske.name>
 <cf118fcd52a0cf7bdf7b08a5a52cd0e285bd056b.1354324110.git.Sebastian.Leske@sleske.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Wong <normalperson@yhbt.net>
To: Sebastian Leske <Sebastian.Leske@sleske.name>
X-From: git-owner@vger.kernel.org Mon Dec 03 20:30:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfbjE-0006Cm-9y
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 20:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053Ab2LCTak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 14:30:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50880 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008Ab2LCTaj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 14:30:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 291E1A051;
	Mon,  3 Dec 2012 14:30:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=OK9twjwTc+6DnyXDtMsHQleXecI=; b=H2aXrWFMUpCjAru4L2nS
	BYQyghKeh0I+ONIphaM8OXdtvGh6YBwuRhnxwJwBSFktDHXnEuXjVsFyIiVx5h5b
	lZS5Wz9r+stBHMMSHdLszJpcCubeDdakTtlEydI+OIqAdpwyw4mRwCT7UA82UNQY
	JkBvBwVQKdFYEpvk/7z39+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=TMY5HeYV08/b6XuDUt4Z7VmllEueFiQWmnuz4F/5Nh7d80
	1uHsuzpfYA5FP6Y5UiHbk/o4aE6yWDEqiLrv4a8QXG2fELKj1Ao4yqlu52MzX6iS
	rFt1RXeLK9wlvcsHQFYiwhpljR1cN61ikmvjGZknMucpoaPFKXsSp4J3oTrEM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16254A050;
	Mon,  3 Dec 2012 14:30:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BE23A04F; Mon,  3 Dec 2012
 14:30:38 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EAD4D916-3D7F-11E2-9E8E-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211056>

Sebastian Leske <Sebastian.Leske@sleske.name> writes:

> Describe what the option --follow-parent does, and what happens if it is
> set or unset.
>
> Signed-off-by: Sebastian Leske <sebastian.leske@sleske.name>
> ---
>  Documentation/git-svn.txt |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index bfa8788..6bda014 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -628,10 +628,19 @@ ADVANCED OPTIONS
>  	Default: "svn"
>  
>  --follow-parent::
> +	This option is only relevant if we are tracking branches (using
> +	one of the repository layout options --trunk, --tags,
> +	--branches, --stdlayout). For each tracked branch, try to find
> +	out where its revision was copied (i.e. branched) from, and set
> +	a suitable parent in the first git commit for the branch.

I also commit this sin myself often, but it is a good habit to get
into to re-read the sentence after writing "... X (i.e. Y)", "... V
(meaning W)", "... A (in other words B)".  We often write these
after realizing that "... X", "... V" or "... A" is hard to
understand and attempt to paraphrase to make it easier, but while
doing so we unconsciously hesitate to remove what we originally
wrote.  The results sometimes (but not always) reads better if you
do not say X, V or A and only used the rephrased version that is
meant to be easier-to-read.

In this case, I think "was copied" and "was branched" alone are
equally good but adding "(i.e. branched)" sounds redundant.

>  	This is especially helpful when we're tracking a directory
> -	that has been moved around within the repository, or if we
> -	started tracking a branch and never tracked the trunk it was
> -	descended from. This feature is enabled by default, use
> +	that has been moved around within the repository.  If this
> +	feature is disabled, the branches created by 'git svn' will all
> +	be linear and not share any history, meaning that there will be
> +	no information on where branches where branched off or merged.

I think the second "where" is a typo for "were" here.

> +	However, following long/convoluted histories can take a long
> +	time, so disabling this feature may speed up the cloning
> +	process. This feature is enabled by default, use
>  	--no-follow-parent to disable it.
>  +
>  [verse]
