From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2B] core.filemode may need manual action
Date: Sun, 19 Oct 2014 15:37:53 -0700
Message-ID: <xmqqmw8rr8hq.fsf@gitster.dls.corp.google.com>
References: <54418CC7.80601@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 20 00:38:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xfz6v-00072p-CI
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 00:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbaJSWh5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Oct 2014 18:37:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751749AbaJSWh5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Oct 2014 18:37:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 65DC017C5E;
	Sun, 19 Oct 2014 18:37:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CdDxkjcDwIm6
	nl89XHbEZPd3glQ=; b=p8swuibrfl9cv1L0BzBbSCQUjXK8ybXF+BhRCBS/Gku0
	jbiU1OolYkwYnC8e2u1xdDducXqsr8/wwgf0W43/R6qnmHXaomwyPpqSMYtYMu34
	heIQjECB0yN2V55Ej1ej1enGpQvdRRqz8hQjQGljGK45Azhcp415S1ZF2pZkbuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=B9OQ7F
	5cbNLbW0o/wSFbfW2j+nOi9cWmtF4cvYw0WzfgRvjqczyj8NyZCRFyZa9ziWPUDL
	RnpmTi4xJVoYyT0t2NCDNliuJZvEzkv3RDnNLRZp7O+owMvfdCO5H3aP5xjuVXT6
	U6NxFBUGOeWA+ld893r9pgq8m710Qt3c05Mqg=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B77D17C5D;
	Sun, 19 Oct 2014 18:37:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D638C17C5C;
	Sun, 19 Oct 2014 18:37:54 -0400 (EDT)
In-Reply-To: <54418CC7.80601@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of
	"Fri, 17 Oct 2014 23:40:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 913C28E6-57E0-11E4-AAE2-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Does this makes more sence ?

Giving the links in-line in the text and avoiding to repeat the same
information at the end like this version does probably makes sense.
Good thinking.

Thanks.

>
>  Documentation/config.txt | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 04a1e2f..3127e5d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -204,13 +204,26 @@ advice.*::
>  --
> =20
>  core.fileMode::
> -	If false, the executable bit differences between the index and
> -	the working tree are ignored; useful on broken filesystems like FAT=
=2E
> +	Tells Git if the executable bit of files in the working tree
> +	is to be honored.
> ++
> +	Some filesystems lose the executable bit when a file that is
> +	marked as executable is checked out, or checks out an
> +	non-executable file with executable bit on.
> +	linkgit:git-clone[1] or linkgit:git-init[1] probe the filesystem
> +	to see if it handles the executable bit correctly
> +	and this variable is automatically set as necessary.
> ++
> +	A repository, however, may be on a filesystem that handles
> +	the filemode correctly, and this variable is set to 'true'
> +	when created, but later may be made accessible from another
> +	environment that loses the filemode (e.g. exporting ext4 via
> +	CIFS mount, visiting a Cygwin created repository with
> +	Git for Windows or Eclipse).
> +	In such a case it may be necessary to set this variable to 'false'.
>  	See linkgit:git-update-index[1].
>  +
> -The default is true, except linkgit:git-clone[1] or linkgit:git-init=
[1]
> -will probe and set core.fileMode false if appropriate when the
> -repository is created.
> +The default is true (when core.filemode is not specified in the conf=
ig file).
> =20
>  core.ignorecase::
>  	If true, this option enables various workarounds to enable
