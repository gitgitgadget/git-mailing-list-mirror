From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-commit: reword the --amend explanation
Date: Wed, 03 Apr 2013 08:01:29 -0700
Message-ID: <7v4nfn7j5i.fsf@alter.siamese.dyndns.org>
References: <1364994441-15961-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Apr 03 17:02:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNPCN-0003ak-O7
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 17:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761357Ab3DCPBe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Apr 2013 11:01:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62682 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759624Ab3DCPBd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Apr 2013 11:01:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D504122BF;
	Wed,  3 Apr 2013 15:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=68NXW4X/MgAK
	pFlDMrMvdAJAxgI=; b=U1447hau6Xdw72KbPNXLSoxc4e7JMqJsLaaeAAwFQ5FB
	ufg8UC1k6rc5vzGL0AJXK6tamHFhfwKSRUqCs8iQjgDHRUfViNoCw6iyIad9hPv7
	KGUmluOav+lpSJAKvnHeSeKICTm0kHqNSLOqQnskjm5nSlAEZOI3E+bjxe7f4pc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=X5Sxjf
	200EYmdbd7CBWGmj1CKXfscE3IqA6BLSf78pbu326vK1sEbfkgMdizrgOrqWTSU0
	1DsRXivEHSANNS0xhT3wiDWszMf+3re5tFy71QCMF028qnWRN4fHVXZD762Iay2W
	8UQCbe8QNAEzD6ZxcDmOWz+X4UjC1eUyhBrWE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12E91122BE;
	Wed,  3 Apr 2013 15:01:33 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 871CB122BB; Wed,  3 Apr
 2013 15:01:32 +0000 (UTC)
In-Reply-To: <1364994441-15961-1-git-send-email-cmn@elego.de> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Wed, 3 Apr 2013 15:07:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F1DBF06-9C6F-11E2-B3FB-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219942>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> The explanation for 'git commit --amend' talks about preparing a tree
> object, which shouldn't be how user-facing documentation talks about
> commit.
>
> Reword it to say it works as usual, but replaces the current commit.
> ---

Sign-off?

> The current text is from 2006, which I guess explains the wording.

Yes, and since then we gained --no-edit option and such, so "editor
starts off" also needs to be rethought, no?  The original wording
with "seeded" may have a better chance of survival, I suspect, but
still needs some adjustment.

Thanks for looking into this.

>  Documentation/git-commit.txt | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.=
txt
> index 42c22bb..48dac29 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -198,14 +198,11 @@ OPTIONS
>  	without changing its commit message.
> =20
>  --amend::
> -	Used to amend the tip of the current branch. Prepare the tree
> -	object you would want to replace the latest commit as usual
> -	(this includes the usual -i/-o and explicit paths), and the
> -	commit log editor is seeded with the commit message from the
> -	tip of the current branch. The commit you create replaces the
> -	current tip -- if it was a merge, it will have the parents of
> -	the current tip as parents -- so the current top commit is
> -	discarded.
> +	Amend the tip of the current branch. The commit is prepared as
> +	usual (including -i/-o and explicit paths) and the editor
> +	starts off with the current tip's commit message. The new
> +	commit has the same parents and author as the current one and
> +	replaces it as the tip.
>  +
>  --
>  It is a rough equivalent for:
