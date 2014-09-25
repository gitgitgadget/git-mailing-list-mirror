From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-quiltimport.sh: disallow fuzz
Date: Thu, 25 Sep 2014 15:48:43 -0700
Message-ID: <xmqq7g0r9v04.fsf@gitster.dls.corp.google.com>
References: <20140924213512.GA7619@logfs.org>
	<xmqqwq8sb81e.fsf@gitster.dls.corp.google.com>
	<20140925220831.GA14433@logfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?J=C3=B6rn?= Engel <joern@logfs.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 00:48:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXHqK-00057e-VA
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 00:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbaIYWsr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2014 18:48:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51942 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752861AbaIYWsq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Sep 2014 18:48:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6D12E3EB01;
	Thu, 25 Sep 2014 18:48:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wO7L1Qbzvq/C
	iAYHdvT9BsA4+8Q=; b=oY7X7fOJ04BtSQ0DBWlzcL0Ib+qLu9q/CHr53SVcPNIZ
	vS6z05iVUKgZqnV20Qq5qXLkx8jqU5QDzZh0wVTb07ufTGnc5qI7Azv8NyIbvWJt
	cwxzmofz6F7Y5TqC8jbEtl2eJqc4v80Ncx3PD3E/cHiibRq569i/QYMeOzedyPE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Vmhp9G
	p2hR9Hzlywx5aNvbSA/TVDQPw9QJNiJwu1e9CODgoYPUYCKS1B1tQ4ZmVNAxBs+s
	SjklioxFebV+RY4bA2XBgbIcwAy3+FCzMRe7cRs1IKSDefCvoN6sb4nl6RZZQL8Z
	NhzW1OFDfAVOK0NjCwuIs3uUqidByuo65cfxM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 63E5B3EB00;
	Thu, 25 Sep 2014 18:48:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D93483EAFF;
	Thu, 25 Sep 2014 18:48:44 -0400 (EDT)
In-Reply-To: <20140925220831.GA14433@logfs.org> (=?utf-8?Q?=22J=C3=B6rn?=
 Engel"'s message of
	"Thu, 25 Sep 2014 18:08:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1AC1E9CC-4506-11E4-AB84-D931C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257501>

J=C3=B6rn Engel <joern@logfs.org> writes:

> When I am working on a problem I never think about beauty.  I think
> only how to solve the problem.  But when I have finished, if the
> solution is not beautiful, I know it is wrong.
> -- R. Buckminster Fuller

Nice quote, but does not belong to above --- lines, unless you have
a -- >8 -- line below or something.

Now is the patch beautiful? ;-)

> Subject: [PATCH] git-quiltimport.sh: disallow fuzz by default
>
> git-quiltimport passed "-C1" to git-apply, supposedly to roughly matc=
h
> the quilt default of --fuzz 2.  This is against the spirit of git.
> Quoting Linus:
>   Except unlike the standard "patch" program, "git apply" doesn't acc=
ept
>   fuzz by default (which to me is a huge deal - I hate how "patch" tr=
ies
>   to apply stuff that clearly isn't valid any more)
> Users that want to want to emulate quilt defaults can pass "-C 1" to
> git-quiltimport now.

Things might have been different if this were mid 2006 or early
2007, but I am afraid that "the spirit of git" with a quote from
Linus no longer carries much weight on this particular issue.  A
backward incompatible change is backward incompatible change that
breaks existing users no matter how loudly you (and I) shout that it
is the right thing to do in the long run.

Let's have it the other way around, keep the same behaviour for
those who run the command without the new option, while allowing
people who know better and are aligned with the spirit of git to
pass the parameter, at least for now, with a note in the
documentation to warn that the default may change in the future to
allow no fuzz, or something.

> Also note that -C1 and fuzz=3D2 is not identical.  Most patches have =
three
> lines of context, so fuzz=3D2 leaves one relevant line of context.  B=
ut
> for any patches with more or less context this is not true.  git-appl=
y
> has no option for fuzz, so any emulation will always be best-effort.
>
> Signed-off-by: Joern Engel <joern@logfs.org>
> ---
>  git-quiltimport.sh | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/git-quiltimport.sh b/git-quiltimport.sh
> index 167d79fea809..f45ee5ff6599 100755
> --- a/git-quiltimport.sh
> +++ b/git-quiltimport.sh
> @@ -4,8 +4,9 @@ OPTIONS_STUCKLONG=3D
>  OPTIONS_SPEC=3D"\
>  git quiltimport [options]
>  --
> -n,dry-run     dry run
>  author=3D       author name and email address for patches without an=
y
> +C=3D            minimum context (see git apply)
> +n,dry-run     dry run
>  patches=3D      path to the quilt series and patches
>  "
>  SUBDIRECTORY_ON=3DYes
> @@ -13,6 +14,7 @@ SUBDIRECTORY_ON=3DYes
> =20
>  dry_run=3D""
>  quilt_author=3D""
> +cflag=3D""
>  while test $# !=3D 0
>  do
>  	case "$1" in
> @@ -20,6 +22,15 @@ do
>  		shift
>  		quilt_author=3D"$1"
>  		;;
> +	-C)
> +		shift
> +		# ensure numerical parameter
> +		case $1 in
> +			''|*[!0-9]*) usage;;
> +			*) ;;
> +		esac
> +		cflag=3D"-C$1"
> +		;;
>  	-n|--dry-run)
>  		dry_run=3D1
>  		;;
> @@ -130,7 +141,7 @@ do
>  	fi
> =20
>  	if [ -z "$dry_run" ] ; then
> -		git apply --index -C1 ${level:+"$level"} "$tmp_patch" &&
> +		git apply --index $cflag ${level:+"$level"} "$tmp_patch" &&
>  		tree=3D$(git write-tree) &&
>  		commit=3D$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-t=
ree $tree -p $commit) &&
>  		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit =
4
