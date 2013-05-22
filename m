From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document push --no-verify
Date: Wed, 22 May 2013 10:17:17 -0700
Message-ID: <7vli77j5nm.fsf@alter.siamese.dyndns.org>
References: <bac9440ba0c977f6bd4207ac423f82b716947cc0.1369214470.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Aaron Schrab <aaron@schrab.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 22 19:17:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfCfF-0007kv-8U
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 19:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763Ab3EVRRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 13:17:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47996 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756386Ab3EVRRT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 13:17:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57D01207D9;
	Wed, 22 May 2013 17:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VcQyYWozKCVGZlZjRdps54krBpo=; b=ttVyZl
	d8pE3WVN/zWodFAJ3FYBgt1Jeze2wnM1tKcTZcLGCohzIvT/sg1+AHQaTPoluDGL
	qDgTEMAbqxCO37g80nN4C5gPOMWNjHiSi+wj/VCtzzL41OkIJ4vLUt37y4HouMRG
	sPddLCNGwONQ1k0vI/s7VehSJhipnY/GQLsh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O9tEWpx8t3hyqAfx8e+CgC02nfJ/X31+
	cFQHLYmHU3bWmtQfsL/G2/aIP3f/e+PgTi48bTT3QqzazC+/nC+2mUFiGUjBuWEh
	mN/JP1Ci16+QZix+MypTo94Le3tGsuI3F+iVzwcFYVkSyHxWyxRMAbu7lWpo40lk
	A9xClH95wNM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D887207D7;
	Wed, 22 May 2013 17:17:19 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C1C7B207CD;
	Wed, 22 May 2013 17:17:18 +0000 (UTC)
In-Reply-To: <bac9440ba0c977f6bd4207ac423f82b716947cc0.1369214470.git.trast@inf.ethz.ch>
	(Thomas Rast's message of "Wed, 22 May 2013 11:23:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74E542EA-C303-11E2-9B87-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225177>

Thomas Rast <trast@inf.ethz.ch> writes:

> ec55559 (push: Add support for pre-push hooks, 2013-01-13) forgot to
> add a note to git-push(1) about the new --no-verify option.

Does it take --verify option (that may well be the default) so that
somebody with

         [alias] put = push --no-verify

can say "git put --verify args..."?

>
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> ---
>
> The insertion spot is at the end, because the existing ordering is
> indistinguishable from random.  This should also be fixed, but is a
> much bigger change and probably not suitable for an -rc period.
>
>
>  Documentation/git-push.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index d514813..426b3d2 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>  [verse]
>  'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
>  	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose] [-u | --set-upstream]
> -	   [<repository> [<refspec>...]]
> +	   [--no-verify] [<repository> [<refspec>...]]
>  
>  DESCRIPTION
>  -----------
> @@ -195,6 +195,9 @@ useful if you write an alias or script around 'git push'.
>  	be pushed. If on-demand was not able to push all necessary
>  	revisions it will also be aborted and exit with non-zero status.
>  
> +--no-verify::
> +	Bypass the pre-push hook (see linkgit:githooks[5]).
> +
>  
>  include::urls-remotes.txt[]
