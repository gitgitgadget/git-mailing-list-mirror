From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: remote set-* <name> and <branch>
Date: Sun, 19 Feb 2012 23:58:17 -0800
Message-ID: <7vvcn2lyw6.fsf@alter.siamese.dyndns.org>
References: <1329571973-20796-1-git-send-email-philip@foolip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Philip =?utf-8?Q?J=C3=A4genstedt?= <philip@foolip.org>
X-From: git-owner@vger.kernel.org Mon Feb 20 08:58:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzO8i-0000kg-Cg
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 08:58:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293Ab2BTH6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 02:58:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40229 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553Ab2BTH6U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2012 02:58:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A170D3A02;
	Mon, 20 Feb 2012 02:58:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FQsIsHlmEhRC
	Dx2VuYdeBxt7kUo=; b=tDQnxWWA/YRETPejrMf8DB9XRkQARlTzvgalS8iElO8w
	yOoTpXn7YXKWbEEq8kPo0i1/gzg995qYR/XeEqD2CRjjtqxeo7iGA8rAsc/XnBN+
	AVUUkD70b6oTjU8e5qTW9n/Zsx/Z3GN84lVs+uQXm01bRxGP4X29mSV7GcL100Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XM0Gwm
	GST37oSiCEaGSzpUJiHPruSk5Ab7MupY++PRrxLpXNLx3P1lG0FhyrFCIEvPt1EW
	X5R8G5yiJxv8xdZPpojnjOvUpLlC/2RfzCzmpvxQerOWsLyve4S9SYkU6OYue9jI
	SYRhTBGzozO0N3ZYQXQPac57y/wmG1ozapCDI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 993EC3A01;
	Mon, 20 Feb 2012 02:58:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0CD9D39FF; Mon, 20 Feb 2012
 02:58:18 -0500 (EST)
In-Reply-To: <1329571973-20796-1-git-send-email-philip@foolip.org> ("Philip
 =?utf-8?Q?J=C3=A4genstedt=22's?= message of "Sat, 18 Feb 2012 14:32:53
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6DF9224-5B98-11E1-92C1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191049>

Philip J=C3=A4genstedt <philip@foolip.org> writes:

> Complete <name> only for set-url. For set-branches and
> set-head, complete <name> and <branch> over the network,
> like e.g. git pull already does.
>
> Signed-off-by: Philip J=C3=A4genstedt <philip@foolip.org>

You addressed your patch to Shawn, who originally wrote this, but

"git shortlog -n -s --no-merges --since=3D9.months pu contrib/completio=
n"

indicates that he no longer is involved in enhancing this script, and i=
t
has seen actions primarily from three people I Cc'ed this message to.

>  contrib/completion/git-completion.bash |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 1505cff..8e7abb6 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -738,6 +738,9 @@ __git_complete_remote_or_refspec ()
>  {
>  	local cur_=3D"$cur" cmd=3D"${words[1]}"
>  	local i c=3D2 remote=3D"" pfx=3D"" lhs=3D1 no_complete_refspec=3D0
> +	if [ "$cmd" =3D "remote" ]; then
> +		c=3D$((++c))
> +	fi

I don't know about others, but auto-incrementing a variable and assigni=
ng
the result to the same variable, while not wrong at all, hurts my brain=
=2E

	c=3D$(($c + 1))

is far more readable and does not suggest there is any funky magic
involved.  Also it is a good habit to get into not to omit $ from
variables inside arithmetic substitution, even though bash allows it an=
d
this script is meant to be consumed only by shells that understand this
bash-ism.

I do not know offhand if zsh groks it, but the point is that you do not
have to worry about it if you write "$(($c+1))" instead of "$((c+1))".

I'll let the area experts to comment on the remainder of the patch.

Thanks.

> @@ -788,7 +791,7 @@ __git_complete_remote_or_refspec ()
>  			__gitcomp_nl "$(__git_refs)" "$pfx" "$cur_"
>  		fi
>  		;;
> -	pull)
> +	pull|remote)
>  		if [ $lhs =3D 1 ]; then
>  			__gitcomp_nl "$(__git_refs "$remote")" "$pfx" "$cur_"
>  		else
> @@ -2289,7 +2292,7 @@ _git_config ()
> =20
>  _git_remote ()
>  {
> -	local subcommands=3D"add rename rm show prune update set-head"
> +	local subcommands=3D"add rename rm set-head set-branches set-url sh=
ow prune update"
>  	local subcommand=3D"$(__git_find_on_cmdline "$subcommands")"
>  	if [ -z "$subcommand" ]; then
>  		__gitcomp "$subcommands"
> @@ -2297,9 +2300,12 @@ _git_remote ()
>  	fi
> =20
>  	case "$subcommand" in
> -	rename|rm|show|prune)
> +	rename|rm|set-url|show|prune)
>  		__gitcomp_nl "$(__git_remotes)"
>  		;;
> +	set-head|set-branches)
> +		__git_complete_remote_or_refspec
> +		;;
>  	update)
>  		local i c=3D'' IFS=3D$'\n'
>  		for i in $(git --git-dir=3D"$(__gitdir)" config --get-regexp "remo=
tes\..*" 2>/dev/null); do
