From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2 2/3] config doc: update dot-repository notes
Date: Fri, 13 Sep 2013 15:28:48 -0700
Message-ID: <xmqq38p8icf3.fsf@gitster.dls.corp.google.com>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
	<1379107397-964-1-git-send-email-philipoakley@iee.org>
	<1379107397-964-3-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Sep 14 00:28:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKbrE-0003sR-3w
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 00:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755610Ab3IMW2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 18:28:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58409 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755461Ab3IMW2v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 18:28:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CC544162F;
	Fri, 13 Sep 2013 22:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fgCKs68UUOPIJyqHI0aC2RaNKJs=; b=U3itpG
	jOll4br3fBO/ypbyCUBkP8EcUuoK2jJkBbG+Zqe1X5TRKiSDp1TPvOiEEwdxyCWk
	yDkuKDYkh8/sOL34wN2esmhT/Tj6W28jzWqnqLSlEA9BGnBaASBNsr/5CkH2+zz8
	xLvhxJ7S+yRiQScIDmHRV7JSvDMnaLqeCCO9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hHOFNiHjNe4ubV74x1QTgGul3ktHRkrx
	jkyvE3OIo8m6xLJt3TmuTlgha9+WWed/+SLzXOJuEuXATvaOgsoE5RMR9XlOHb1w
	zorz/zgbwoektTRNq0wx6TpAkoMbCXLpjzmXjnH3p6vXPgH5Bc/e5ifxxwL+xg1g
	VTNdutROIj8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 726084162E;
	Fri, 13 Sep 2013 22:28:50 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DDD8A41629;
	Fri, 13 Sep 2013 22:28:49 +0000 (UTC)
In-Reply-To: <1379107397-964-3-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Fri, 13 Sep 2013 22:23:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DCC24A88-1CC3-11E3-B811-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234782>

Philip Oakley <philipoakley@iee.org> writes:

> branch.<name>.remote can be set to '.' (period) as the repository
> path (URL) as part of the remote name dwimmery. Tell the reader.
>
> Such relative paths are not 'special'. Correct the branch.<name>.merge
> note.

Looks good.

It naturally follows that this is also valid:

	[branch "master"]
        	merge = refs/heads/master
	        remote = git://git.kernel.org/pub/scm/git/git.git

and running "git pull" while on your 'master'.

This is because branch.<name>.remote usually is spelled with a
nickname that refers to the [remote <nickname>] section, but it does
not have to be; it can use a URL to refer to the remote repository.

>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  Documentation/config.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 599ca52..da63043 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -718,6 +718,8 @@ branch.<name>.remote::
>  	overridden by `branch.<name>.pushremote`.  If no remote is
>  	configured, or if you are not on any branch, it defaults to
>  	`origin` for fetching and `remote.pushdefault` for pushing.
> +	Additionally, `.` (a period) is the current local repository
> +	(a dot-repository), see `branch.<name>.merge`'s final note below.
>  
>  branch.<name>.pushremote::
>  	When on branch <name>, it overrides `branch.<name>.remote` for
> @@ -743,8 +745,8 @@ branch.<name>.merge::
>  	Specify multiple values to get an octopus merge.
>  	If you wish to setup 'git pull' so that it merges into <name> from
>  	another branch in the local repository, you can point
> -	branch.<name>.merge to the desired branch, and use the special setting
> -	`.` (a period) for branch.<name>.remote.
> +	branch.<name>.merge to the desired branch, and use the relative path
> +	setting `.` (a period) for branch.<name>.remote.
>  
>  branch.<name>.mergeoptions::
>  	Sets default options for merging into branch <name>. The syntax and
