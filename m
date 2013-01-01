From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] Fix Synopsis
Date: Tue, 01 Jan 2013 13:40:44 -0800
Message-ID: <7vwqvw8tur.fsf@alter.siamese.dyndns.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
 <1357012655-24974-5-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Jan 01 22:41:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq9a8-0000GT-Or
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 22:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503Ab3AAVks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 16:40:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49671 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490Ab3AAVkr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 16:40:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC6109A41;
	Tue,  1 Jan 2013 16:40:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=96/brG6SDtQesayvAp0EGEzNqvU=; b=I3BibY
	rKrBIV3WWnHubGYwrcR/IqfgYO9I4i+dWElzP9NYHfFyh6nS9kiKJJZZt3KFU1Yb
	VU5WjoEHHL9qLkgJWYYroWVHzG9DomGaqLquUrpC9mvgvI/a7sGSTQB20j6QUKKr
	M94+1Oy+kTi9/NVQ6+7AmI2EYWjBLEBFmjeM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mrxFQP7SbU3wjA5MLBwjLKT3FESoJgju
	jCJAcpAxfNuTcb9keqsQShFtCOnPSpGLOv0dieUbyH3w+DlpB4fGm8nX+uSRnP0l
	fvV3N4s3OmHS5fN5Zo++6VH9EXBr7yWiAYjH692vFP6nqfym3ZQCcxWSBKPmGbo/
	n8L22Z8w5zY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADE729A40;
	Tue,  1 Jan 2013 16:40:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 126EA9A3F; Tue,  1 Jan 2013
 16:40:45 -0500 (EST)
In-Reply-To: <1357012655-24974-5-git-send-email-greened@obbligato.org> (David
 A. Greene's message of "Mon, 31 Dec 2012 21:57:31 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E685ED1C-545B-11E2-A4DC-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212447>

"David A. Greene" <greened@obbligato.org> writes:

> From: "David A. Greene" <greened@obbligato.org>
>
> Fix the documentation of add to show that a repository can be
> specified along with a commit.
>
> Change "commit" to "refspec" in the synopsis for add.
>
> Suggested by Yann Dirson <dirson@bertin.fr>.
>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
>  contrib/subtree/git-subtree.sh  |    3 ++-
>  contrib/subtree/git-subtree.txt |    3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index b8a807a..ad62dfb 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -8,7 +8,8 @@ if [ $# -eq 0 ]; then
>      set -- -h
>  fi
>  OPTS_SPEC="\
> -git subtree add   --prefix=<prefix> <commit>
> +git subtree add   --prefix=<prefix> <refspec>

Again, this is not <refspec> but <commit>.

> +git subtree add   --prefix=<prefix> <repository> <refspec>

This is given to "fetch" and it seems to acccept any <refspec>, so
it is probably a good change (I didn't fully follow the codepath,
though).

>  git subtree merge --prefix=<prefix> <commit>
>  git subtree pull  --prefix=<prefix> <repository> <refspec...>
>  git subtree push  --prefix=<prefix> <repository> <refspec...>
> diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
> index ae420aa..89c2d6e 100644
> --- a/contrib/subtree/git-subtree.txt
> +++ b/contrib/subtree/git-subtree.txt
> @@ -9,7 +9,8 @@ git-subtree - Merge subtrees together and split repository into subtrees
>  SYNOPSIS
>  --------
>  [verse]
> -'git subtree' add   -P <prefix> <commit>
> +'git subtree' add   -P <prefix> <refspec>
> +'git subtree' add   -P <prefix> <repository> <refspec>
>  'git subtree' pull  -P <prefix> <repository> <refspec...>
>  'git subtree' push  -P <prefix> <repository> <refspec...>
>  'git subtree' merge -P <prefix> <commit>
