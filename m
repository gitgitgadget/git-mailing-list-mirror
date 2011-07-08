From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-rebase.txt: clarify that --abort checks out
 <branch>
Date: Fri, 08 Jul 2011 09:07:25 -0700
Message-ID: <7vzkkog3ia.fsf@alter.siamese.dyndns.org>
References: <1309574324-6833-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1310092069-19708-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Drew Northup <drew.northup@maine.edu>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 08 18:07:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QfDab-0007OY-NU
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 18:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168Ab1GHQHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jul 2011 12:07:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726Ab1GHQH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2011 12:07:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DFC54619F;
	Fri,  8 Jul 2011 12:07:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YRFbfHAb4LcUAhrTy7BOQx626I4=; b=aPMghs
	hntzyNeuOHNEXCf5nY950npVCVijXZtt45ouy4Hvx7hd81yYRCgLAioT5i1Oc/7G
	C3bxDHPh7tQtrG2YVPcmbo8a6q1xcTlunMIfp/JNAZPx/8v8+fuuY8vYeC5EQMvT
	qs90FjHuCGmUPJiyV21bk8BeInKy2DakuCVf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s7OcKd9/L3sTfgu4OBYl4kbe3obRyzbl
	sNzIzAhsCGDBo58RErInfSx8GbRFLk63HIFKSzxoqBgltV16WwqCsedxPVsiVCDY
	12CiLtSr/+H59JMB0JDpF8/01HP95QePzqBBMQLchmJtAD1O9Adgmm2m2i+wej0C
	G7EUj9DOivY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D81E4619E;
	Fri,  8 Jul 2011 12:07:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0CC69619D; Fri,  8 Jul 2011
 12:07:26 -0400 (EDT)
In-Reply-To: <1310092069-19708-1-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Thu, 7 Jul 2011 22:27:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5FDF12A6-A97C-11E0-AAF6-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176799>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> The description for 'git rebase --abort' currently says:
>
>     Restore the original branch and abort the rebase operation.
>
> The "restore" can be misinterpreted to imply that the original branch
> was somehow in a broken state during the rebase operation. It is also
> not completely clear what "the original branch" is --- is it the
> branch that was checked out before the rebase operation was called or
> is the the branch that is being rebased (it is the latter)? Although
> both issues are made clear in the DESCRIPTION section, let us also
> make the entry in the OPTIONS secion more clear.
>
> Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>

While I agree that there is a problem, ...

>  Documentation/git-rebase.txt |    6 +++++-
>  git-rebase.sh                |    2 +-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index a9e0e50..d2f2cd9 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -232,7 +232,11 @@ leave out at most one of A and B, in which case it defaults to HEAD.
>  	Restart the rebasing process after having resolved a merge conflict.
>  
>  --abort::
> -	Restore the original branch and abort the rebase operation.
> +	Abort the rebase operation and reset HEAD to the original
> +	branch. If <branch> was provided when the rebase operation was
> +	started, then HEAD will be reset to <branch>. Otherwise HEAD
> +	will be reset to where it was when the rebase operation was
> +	started.

and I think this is a vast improvement, ...

>  --skip::
>  	Restart the rebasing process by skipping the current patch.
> diff --git a/git-rebase.sh b/git-rebase.sh
> index d7855ea..f2d4c72 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -58,7 +58,7 @@ ignore-whitespace! passed to 'git apply'
>  C=!                passed to 'git apply'
>   Actions:
>  continue!          continue rebasing process
> -abort!             abort rebasing process and restore original branch
> +abort!             abort rebasing process and reset HEAD to <branch>
>  skip!              skip current patch and continue rebasing process
>  "

I don't think it is quite right to use placeholder notation here, unless
you are talking about "git rebase --abort <branch>", and you are of course
not in this case. Perhaps

	abort and check out the original branch

might be slightly better. I dunno.

As the user knows these help text are all about "rebase", I do not think
it is worth repeating "rebasing process" over and over again.
