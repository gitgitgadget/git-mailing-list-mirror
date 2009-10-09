From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] Documentation: clone: clarify discussion of initial
 branch
Date: Fri, 09 Oct 2009 14:48:50 -0700
Message-ID: <7vskdsqlvh.fsf@alter.siamese.dyndns.org>
References: <20091009101400.GA16549@progeny.tock>
 <20091009101825.GE16558@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 23:57:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwNSt-0000zk-Rt
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 23:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934467AbZJIVuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 17:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbZJIVuI
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 17:50:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55994 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932986AbZJIVuH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 17:50:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D2F0A710DB;
	Fri,  9 Oct 2009 17:48:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S2MoKt73yxRLjvM45L4WotUTEBY=; b=TtMGkG
	2vkG3EHWrGXxt5azeUkrozHZBvpD9dKfUPLEPJnHMzN6vL1aiJbKeyuYtXLCpF/x
	+QyoVY1+yMSEczw6HJR5IO/JHY4B6wawD8WSg0iUGWdtwRUzb6urOmC/gKpvlMCm
	D+cIFFD+VaIgfsn1daKr2j2dZUNEovhW85Oss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hUfFYAKI3EZB9bS939A6QL+8EiJKXPN6
	ueFfEs/qE0UMzmFJpXWNbDKUPhJr4z53A0/aiD8DuvffGlPOJr5EQJqZ6kB45FLW
	gUQZpisyCsx3WQ6zKvmCA99b2GkzB1TGmLQxWZ98h5VR+uF8/dQaN0QpDksmsJnc
	ObZbqdSuJWM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B5B6A710DA;
	Fri,  9 Oct 2009 17:48:54 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A222B710D8; Fri,  9 Oct 2009
 17:48:51 -0400 (EDT)
In-Reply-To: <20091009101825.GE16558@progeny.tock> (Jonathan Nieder's message
 of "Fri\, 9 Oct 2009 05\:18\:25 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8A517024-B51D-11DE-837F-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129848>

Jonathan Nieder <jrnieder@gmail.com> writes:

> When saying the initial branch is equal to the currently active
> remote branch, it is probably intended that the branch heads
> point to the same commit.  Maybe it would be more useful to a new
> user to emphasize that the tree contents and history are the
> same.
>
> More important, probably, is that this new branch is set up so
> that "git pull" merges changes from the corresponding remote
> branch.

All true, and "with the contents of" is dropping the "history" part.
Perhaps

    ... creates and checks out an initial branch that is forked from the
    cloned repository's currently active branch.

would convey that (1) the initial branch is your own; if you do not pull,
you won't get updated, and that (2) the initial branch starts out at the
same commit as the upstream.

> clarifying the initial content of the branch should make it
> clearer why a pull is required at all (that local and remote
> branches each have their own history after the clone).
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  Documentation/git-clone.txt |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index aacf4fd..7cd06e2 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -20,7 +20,8 @@ DESCRIPTION
>  Clones a repository into a newly created directory, creates
>  remote-tracking branches for each branch in the cloned repository
>  (visible using `git branch -r`), and creates and checks out an initial
> -branch equal to the cloned repository's currently active branch.
> +branch with the contents of the cloned repository's currently active
> +branch.
>  
>  After the clone, a plain `git fetch` without arguments will update
>  all the remote-tracking branches, and a `git pull` without
> -- 
> 1.6.5.rc1.199.g596ec
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
