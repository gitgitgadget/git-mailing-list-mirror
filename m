From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: clarify advice for the unconfigured error case
Date: Wed, 02 Dec 2009 15:08:33 -0800
Message-ID: <7vk4x57z4e.fsf@alter.siamese.dyndns.org>
References: <48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com>
 <1257965806.26362.132.camel@heerbeest>
 <D6B0AE61-6CA3-4F79-BB50-B8795415BAB7@dbservice.com>
 <1257968052.26362.155.camel@heerbeest>
 <AC99BA30-A36D-4798-8E7D-9D69EFE99D55@dbservice.com>
 <1258035449.26362.273.camel@heerbeest> <20091112155310.7836c388@perceptron>
 <20091112150626.GA24848@coredump.intra.peff.net>
 <20091112170814.1858aba4@perceptron> <20091113040754.GA3255@progeny.tock>
 <20091127141704.GA24080@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>, Jeff King <peff@peff.net>,
	Jan Nieuwenhuizen <janneke-list@xs4all.nl>,
	Tomas Carnecky <tom@dbservice.com>,
	git list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 00:08:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFyJd-000810-DV
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 00:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbZLBXIp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2009 18:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754856AbZLBXIp
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 18:08:45 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55653 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754649AbZLBXIo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Dec 2009 18:08:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 95258A3B25;
	Wed,  2 Dec 2009 18:08:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AzdydVdZNtoT
	1L5kMEIbzf/AFoU=; b=kkFBa1vLyWUnSqP9TIKIVJDUK8p+iWK2tnwvidEauBsy
	X7xU2xRfNUpHqMYDuHBmIy2O0Qv3askGFq784F2YAUbHZB+H/sHHNjM+ekQ4gATV
	5tC7oIDWXI3ngrjVggPDAwUzY+o2JknqgpN2YWMuVrMNBfCHWgEONGAbhdV4Dig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Ks9j6m
	adYuonxq+1tozdQoK6S4CmE/gYK+mb0KOWMIOzuMeLIYbIEzfR2QoL5AaMOQCQD1
	v4sZM7GYAPFfc3oUKrKy+O2cIfpm6nwhSzgOVtF0hoL4U2FVs3a5SfkGzT9Fvrip
	0WIpIDJxPwYMjH2wwQtVKHg3knZgqnXbhfTOE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 381DBA3B18;
	Wed,  2 Dec 2009 18:08:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 976B0A3B17; Wed,  2 Dec 2009
 18:08:35 -0500 (EST)
In-Reply-To: <20091127141704.GA24080@progeny.tock> (Jonathan Nieder's message
 of "Fri\, 27 Nov 2009 08\:17\:05 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A36160DE-DF97-11DE-80D2-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134418>

Jonathan Nieder <jrnieder@gmail.com> writes:

> From: Jan Kr=C3=BCger <jk@jk.gs>
>
> When pull --rebase fails because it cannot find what branch to
> merge against, the error message implies we are trying to merge.
> Say "rebase against" instead of "merge with" to avoid confusion.

I was going over the mail archive to see if I missed any important fixe=
s
that should be in before 1.6.6 final and noticed that this is not appli=
ed,
and there was no follow-up to this message either.

Is this a good replacement for 31971b3 (git-pull.sh --rebase: overhaul
error handling when no candidates are found, 2009-11-12) that is on 'pu=
'
and does the lack of follow-up mean everybody involved in the discussio=
n
is happy with this version?

> diff --git a/git-pull.sh b/git-pull.sh
> index 37f3d93..2c384c4 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -91,45 +91,63 @@ error_on_no_merge_candidates () {
>  		esac
>  	done
> =20
> +	if test true =3D "$rebase"
> +	then
> +		op_type=3Drebase
> +		op_prep=3Dagainst
> +	else
> +		op_type=3Dmerge
> +		op_prep=3Dwith
> +	fi
> +
>  	curr_branch=3D${curr_branch#refs/heads/}
>  	upstream=3D$(git config "branch.$curr_branch.merge")
>  	remote=3D$(git config "branch.$curr_branch.remote")
> =20
>  	if [ $# -gt 1 ]; then
> -		echo "There are no candidates for merging in the refs that you jus=
t fetched."
> +		if [ "$rebase" =3D true ]; then
> +			printf "There is no candidate for rebasing against "
> +		else
> +			printf "There are no candidates for merging "
> +		fi
> +		echo "among the refs that you just fetched."
>  		echo "Generally this means that you provided a wildcard refspec wh=
ich had no"
>  		echo "matches on the remote end."
>  	elif [ $# -gt 0 ] && [ "$1" !=3D "$remote" ]; then
>  		echo "You asked to pull from the remote '$1', but did not specify"
> -		echo "a branch to merge. Because this is not the default configure=
d remote"
> +		echo "a branch. Because this is not the default configured remote"
>  		echo "for your current branch, you must specify a branch on the co=
mmand line."
>  	elif [ -z "$curr_branch" ]; then
>  		echo "You are not currently on a branch, so I cannot use any"
>  		echo "'branch.<branchname>.merge' in your configuration file."
> -		echo "Please specify which branch you want to merge on the command=
"
> +		echo "Please specify which remote branch you want to use on the co=
mmand"
>  		echo "line and try again (e.g. 'git pull <repository> <refspec>').=
"
>  		echo "See git-pull(1) for details."
>  	elif [ -z "$upstream" ]; then
>  		echo "You asked me to pull without telling me which branch you"
> -		echo "want to merge with, and 'branch.${curr_branch}.merge' in"
> -		echo "your configuration file does not tell me either.	Please"
> -		echo "specify which branch you want to merge on the command line a=
nd"
> +		echo "want to $op_type $op_prep, and 'branch.${curr_branch}.merge'=
 in"
> +		echo "your configuration file does not tell me, either. Please"
> +		echo "specify which branch you want to use on the command line and=
"
>  		echo "try again (e.g. 'git pull <repository> <refspec>')."
>  		echo "See git-pull(1) for details."
>  		echo
> -		echo "If you often merge with the same branch, you may want to"
> -		echo "configure the following variables in your configuration"
> -		echo "file:"
> +		echo "If you often $op_type $op_prep the same branch, you may want=
 to"
> +		echo "use something like the following in your configuration file:=
"
> +		echo
> +		echo "    [branch \"${curr_branch}\"]"
> +		echo "    remote =3D <nickname>"
> +		echo "    merge =3D <remote-ref>"
> +		test rebase =3D "$op_type" &&
> +			echo "    rebase =3D true"
>  		echo
> -		echo "    branch.${curr_branch}.remote =3D <nickname>"
> -		echo "    branch.${curr_branch}.merge =3D <remote-ref>"
> -		echo "    remote.<nickname>.url =3D <url>"
> -		echo "    remote.<nickname>.fetch =3D <refspec>"
> +		echo "    [remote \"<nickname>\"]"
> +		echo "    url =3D <url>"
> +		echo "    fetch =3D <refspec>"
>  		echo
>  		echo "See git-config(1) for details."
>  	else
> -		echo "Your configuration specifies to merge the ref '${upstream#re=
fs/heads/}' from the"
> -		echo "remote, but no such ref was fetched."
> +		echo "Your configuration specifies to $op_type $op_prep the ref '$=
{upstream#refs/heads/}'"
> +		echo "from the remote, but no such ref was fetched."
>  	fi
>  	exit 1
>  }
> --=20
> 1.6.5.3
