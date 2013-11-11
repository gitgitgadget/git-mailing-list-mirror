From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-fetch-pack uses URLs like git-fetch
Date: Mon, 11 Nov 2013 09:44:55 -0800
Message-ID: <xmqqk3gen888.fsf@gitster.dls.corp.google.com>
References: <201311081854.06201.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 11 18:45:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfvXt-0007Je-HJ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 18:45:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650Ab3KKRpA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Nov 2013 12:45:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753975Ab3KKRpA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Nov 2013 12:45:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3113D4F4AC;
	Mon, 11 Nov 2013 12:44:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AXj2HgDVIlLP
	uyu7QssuqxKLMwA=; b=K2zybAuSYVjPZBaW50kEPUtT6FNXgITsYkKBzDdDmTFa
	LeqEz6XWqJ8choQPRjpkUEau6gk2eOAmXdmPxTYQL5VroTu7BZbz6KCd62QKWoNN
	8AJjuqMhytaoUbj8A+wr9iUW1RhEnmX/71FpLzqUpHC3GFCphMNXHE3MiSJ4T9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LiMrLm
	vyNe7qj6T3IBq5HKMLoz94MkZx45VDCKCjCrNygjJ6wAkEmUPktBgC8f9pCzmOJ4
	a3aJeu6krlDyyuX59Tcg2uMaM+pZ518CqH7MEuLJ/iX8R+T38fbI6KwmklNMhfBo
	y9GyVwhNxgTNH1UulgNfPlMmsBo6x0B6Sycy4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F4F54F4A9;
	Mon, 11 Nov 2013 12:44:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60AF24F4A5;
	Mon, 11 Nov 2013 12:44:58 -0500 (EST)
In-Reply-To: <201311081854.06201.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Fri, 8 Nov 2013 18:54:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FB8F263A-4AF8-11E3-A5CC-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237620>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> "git fetch-pack" allows [<host>:]<directory> to point out the source
> repository.
> Use the term <repository>, which is already used in "git fetch" or "g=
it pull"
> to describe URLs supported by Git.

Sign-off?

> ---
>  Documentation/git-fetch-pack.txt | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fet=
ch-pack.txt
> index 444b805..93b5067 100644
> --- a/Documentation/git-fetch-pack.txt
> +++ b/Documentation/git-fetch-pack.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  'git fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--includ=
e-tag]
>  	[--upload-pack=3D<git-upload-pack>]
>  	[--depth=3D<n>] [--no-progress]
> -	[-v] [<host>:]<directory> [<refs>...]
> +	[-v] <repository> [<refs>...]
> =20
>  DESCRIPTION
>  -----------
> @@ -97,19 +97,18 @@ be in a separate packet, and the list must end wi=
th a flush packet.
>  -v::
>  	Run verbosely.
> =20
> -<host>::
> -	A remote host that houses the repository.  When this
> -	part is specified, 'git-upload-pack' is invoked via
> -	ssh.
> -
> -<directory>::
> -	The repository to sync from.
> +<repository>::
> +	The URL to the remote repository.
> =20
>  <refs>...::
>  	The remote heads to update from. This is relative to
>  	$GIT_DIR (e.g. "HEAD", "refs/heads/master").  When
>  	unspecified, update from all heads the remote side has.
> =20
> +SEE ALSO
> +--------
> +linkgit:git-fetch[1]
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
