Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402BD493D38
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791058424; cv=none; b=EiLdYuEBsmzmk2T1FwFHOXhYyxh8ioR10CMfZR4AV+dLmlvbv7DJg0y+FXUSecwMIA3p0I/5mhacDmaQaKzw4LcnMewvZyhth79OitYRVpQomV9o7qX9ZNPOjeuGBB+6Nq/XcRQG81eEZapAVdGNla+QvzDLfynL6xl06yq//Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791058424; c=relaxed/simple;
	bh=dgV3fV6bGSj5x0cvIJQCiAZIe2VnORHeNUKMG2IyLek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhP+FI3IIUKvcNR9PO9PX2G5KYLPhik+C8EPTgh1384iRJnVq7kBWjzsc6/TeNmcdRywqGxF44uGefStPF/1hT2sp2ZNuC5Ce6bEBGZtkGRWlb5cKGCnNkKA71Kb7aIEcpCAWjJ4eUoqKlH0OGvX1VH2lMB0PLl4Grbeyuawda8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMaSNBtx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMaSNBtx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E6B1F0089E;
	Sat,  3 Oct 2026 20:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791058422;
	bh=LZiqWQihFrhk9vIBOANK40+1fKN5MLvVxjLGcJUWSFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fMaSNBtx65koTgcbMfP8yoqyDMHnhDSZtUIb3weXyP6MxM7MdPAgTig8OXtNd2ZEn
	 m0t/LJHRKgIUTkgvi7khacSWVzztvbaKKhm0QOK/W6kMXpaWNDPQWKFTjzELgdwebq
	 WptHcJYNGtjDKpKF/SB8UxoTxN8mMyZN27Svj59bCY9m6sclPjXTpfjNljyXG/tB8i
	 NKLbg6dIfLeP+GD6SYPx+or+ygoEBb5tEhMmCcL9IYJH1qgoRAjxFOEG4Q4gd/B4bz
	 hmm91H6QWtY/Ob+Xwr3HrVM7wQEo9YNQKm8ifhkXC1WVcR9OFp4aq9AJnM7P652WXz
	 LJ5y6innxWUcA==
Date: Sat, 3 Oct 2026 22:13:37 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Ben Boeckel <mathstuf@gmail.com>, 
	Nico Williams <nico@cryptonector.com>, Viktor Dukhovni <viktor@openssl.org>
Subject: Re: [RFC] git-brebase
Message-ID: <asFhyVfiG9RTlIG-@debian>
References: <asFRVdMTpshsazgM@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rzl3uygpvtqujaeu"
Content-Disposition: inline
In-Reply-To: <asFRVdMTpshsazgM@debian>


--rzl3uygpvtqujaeu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Ben Boeckel <mathstuf@gmail.com>, 
	Nico Williams <nico@cryptonector.com>, Viktor Dukhovni <viktor@openssl.org>
Subject: Re: [RFC] git-brebase
Message-ID: <asFhyVfiG9RTlIG-@debian>
References: <asFRVdMTpshsazgM@debian>
MIME-Version: 1.0
In-Reply-To: <asFRVdMTpshsazgM@debian>

(I meant this to be a reply to the previous thread, but I somehow
 forgot while writing it.  Here's a link, for context.)

<https://lore.kernel.org/git/ar5KL4_IKXYbx3Sb@debian/T/#u>


Cheers,
Alex

> Date: 2026-10-03 22:11:54+0200
> From: Alejandro Colomar <alx@kernel.org>
>
> Hi!
>=20
> I've significantly improved the idea from the original thread, thanks to
> suggestions from several people (the most fundamental, by Nico Williams
> and Ben Boeckel), and inspired to write it after knowing about the tool
> written by Nico Williams and Viktor Dukhovni (but I implemented it from
> scratch, without reading their implementation, other than looking at the
> file size --which, being under 100 LoC, gave me the confidence that it
> could be implemented easily--).
>=20
> I believe now, after several improvements, it is not only simpler than
> git-imerge, but also more powerful.
>=20
> I've not used git-imerge, but I've watched the youtube video of the talk
> in which the author explains how it works (and it's quite nice, to be
> fair).  First some similarities between both:
>=20
> -  Both git-imerge and my tool support --first-parent (per the README of
>    git-imerge).  My tool has support for this by using git-bisect(1)
>    interally for the bisection.
>=20
>    This feature was suggested to me by Ben Boeckel.
>=20
> -  Both git-imerge and my tool reach the same tip after a successful
>    session.  They differ in the intermediate history.
>=20
> Below goes an overview of key limitations of the git-imerge approach
> (IMO), and which are not present in mine.  If git-imerge supports any of
> this, I'm sorry; I didn't find them in their README.
>=20
> -  git-imerge creates a 2D matrix of conflict resolutions.  This is nice
>    for the case of two flat branches.  However, the branch to be rebased
>    might also contain merge commits.  This is less common than having
>    merge commits in the target branch, but it happens, and in those
>    cases, it's frequent to want to keep the structure of the branch,
>    with --rebase-merges.  My tool has support for this by using
>    git-rebase(1) internally for the rebases.
>=20
> -  One may want to skip arbitrary commits (because they're known to be
>    broken, and possibly immediately reverted).  For that, I've provided
>    a specific flag, --pre-exec, which is similar to git-rebase(1)'s
>    --exec, but which is executed before each rebase operation, at the
>    BISECT_HEAD commit.  An exit code of 125 skips that revision
>    immediately, without trying to do any rebases.
>=20
>    This feature was suggested to me by Ben Boeckel.
>=20
> -  One may also want to find and resolve semantic conflicts that do not
>    appear as physical text conflicts.  For that, I've provided a
>    specific flag, --post-exec, which is similar to --pre-exec, but runs
>    after each successful git-rebase(1) operation.  This would usually
>    build and test the software itself.
>=20
>    This feature was suggested to me by Ben Boeckel.
>=20
> -  git-imerge is limited when rebasing trees of branches.  Let's
>    consider something more complex:
>=20
> 	*---*---*---*---*---M
> 	 \
> 	  *---*---A---*---B
> 	   \ /     \
> 	    *       *---C---D
>=20
>    Let's say M is master, to which we want to rebase the tree composed
>    of branches A, B, and C, so that it results in this:
>=20
> 	*---*---*---*---*---M
> 	                     \
> 	                      *---*---A'--*---B'
> 	                       \ /     \
> 	                        *       *---C'--D'
>=20
>    With my tool, this becomes trivial (I've been doing this all day
>    earlier today, resolving in a few hours what would have taken me
>    days).  The approach in this case would be to rebase from root to
>    leaves, but to solve conlicts from leaves to root:
>=20
> 	1)  Use git-brebase to rebase A until the first conflict with M.
>=20
> 	2)  Abort the conflicting rebase.  We don't want to resolve the
> 	    conflict yet, or we'd have to repeat the same resolution
> 	    later.
>=20
> 	3)  Rebase all its direct descendants into the new A, by
> 	    performing operations 1 and 2 but with the descendant
> 	    branches.  Do this recursively with children of children.
>=20
> 	4)  Once all descendants have been moved below the new A, it's
> 	    time to solve the conflicts in A.  This will result in
> 	    advancing A by just one commit of M, since we had aborted
> 	    exactly at the conflicting rebase.
>=20
> 	5)  Rebase the direct descendants on top of the new A, this time
> 	    with git-rebase(1) --not brebase!-- with --interactive,
> 	    dropping all commits that exist in A.  This avoids resolving
> 	    the same conflicts again.  Do this recursively with children
> 	    of children.
>=20
> 	6)  Rinse and repeat since step 1, until everything is
> 	    successful.  At that point, we have reached the end of the
> 	    session.
>=20
>    This approach is different from git-imerge, in that git-imerge
>    manages in a single session the entire rebase operation until
>    success, while my tool performs each conflict resolution in a single
>    step, and they are entirely independent, and can be interrupted to do
>    other work.  My tool requires repeated invocations until reaching the
>    end point, denoted by a successful exit status.
>=20
> Something that git-imerge has that my tool hasn't is the ability to do
> merge commits.  My tool exclusively does rebases.  However, once the end
> commit is reached, creating that could be used to produce a merge
> commit.  It could be done by first reaching the rebase tip in a
> disposable branch, then perform a regular merge commit with
> git-merge(1), and resolve conflicts by doing something like
> 	$ git checkout disposable -- .
> and then finish the merge.  It's not a critical limitation of my tool,
> IMO.  (Although, admittedly, it's a trick that not everyone would know
> to do.)
>=20
> Another difference is that, by doing rebases, my tool doesn't remember
> the entire history matrix that git-imerge holds while doing the work.
> I see this as an advantage, as once we've finished one conflict step,
> and we've verified with git-range-diff(1) and with proper testing that
> it's correct, the extra history would clutter the
> 'git log --graph --oneline HEAD target current' (something essential
> when doing these operations).  Having a lean history in the process
> helps get it right, being able to check important commits in the log.
>=20
> Now about details of the implementaion:
>=20
> -  The tool supports --first-parent, and passes it transparently to
>    git-bisect(1).
>=20
> -  The tool supports the flags --pre-exec and --post-exec, which are
>    interpreted especially by the tool.
>=20
> -  The tool accepts other flags, and passes them transparently to
>    git-rebase(1).  If some flag isn't supported by git-rebase(1), it
>    will be that program which will complain.  Also, I haven't made an
>    attempt to validate that the flags passed make sense with this tool
>    (for example, passing --abort would be accepted by git-rebase(1), but
>     it wouldn't make sense, and would probably fail at some point).
>=20
>    It would be good to curate a list of flags that make sense.
>=20
> -  My tool, being a simple shell script with rudimentary option parsing,
>    only accepts flags that take a single shell argument.  That is,
>    --foo=3Dbar is ok, but --foo bar is not okay (and will probably result
>    in parsing errors).
>=20
> -  The tool is meant to be used almost as a drop-in of git-rebase(1).
>    It does the same thing, except that instead of rebasing on the
>    target, it rebases on the first commit of the target branch which
>    has conflicts.
>=20
> (It has grown a bit fatter than it was, but it's still way below
>  git-imerge.)
>=20
> 	$ wc -l <src/bin/git-brebase=20
> 	164
>=20
> We'll discuss the exact way it should be integrated within git(1), but
> first it'd be interesting to get feedback about the tool itself,
> regardless of the actual form.  Actually, because of the specialized
> flags --pre-exec and --post-exec, and the --first-parent flag from
> git-bisect(1) --and the fact that it runs git-bisect(1) machinery--, I'm
> not entirely sure that it should be just a new flag to git-rebase(1).
> It might be confusing to have these three flags being dependent on
> another flag, and not being able to use this within a git-bisect(1)
> session, unlike other git-rebase(1) operations.  That might call for
> a new git command.
>=20
> Please let me know any feedback!  :)
>=20
> Junio, since you seemed to love git-imerge, I wonder what you'll think
> of this tool.  :-)
>=20
> Having presented the tool, below goes the implementation.
>=20
>=20
> Have a lovely day!
> Alex
>=20
> ---
> #!/bin/bash
> # Copyright 2026, Alejandro Colomar <alx@kernel.org>
> # SPDX-License-Identifier: GPL-3.0-or-later
>=20
> set -Eeufo pipefail;
> shopt -s lastpipe;
>=20
> err()
> {
> 	>&2 printf '%s\n' "$(basename "$0"): error: $*";
> 	exit 1;
> }
>=20
> fp=3D'';
> other=3D'';
> pre=3D'';
> post=3D'';
> while test $# -ge 1; do
> 	case "$1" in
> 	--first-parent)
> 		fp=3D'--first-parent';
> 		;;
> 	--pre-exec=3D*)
> 		echo "$1" \
> 		| sed 's/--pre-exec=3D//' \
> 		| read -r pre;
> 		;;
> 	--post-exec=3D*)
> 		echo "$1" \
> 		| sed 's/--post-exec=3D//' \
> 		| read -r post;
> 		;;
> 	-*)
> 		other=3D"$other $1";
> 		;;
> 	*)
> 		break;
> 		;;
> 	esac;
> 	shift;
> done;
> gbopts=3D"$fp";
> gropts=3D"$other";
>=20
> if test $# -lt 1; then
> 	err 'Missing target commit.';
> fi;
> if test $# -gt 1; then
> 	err 'Too many arguments.';
> fi;
> git rev-list -1 "$1" \
> | read -r tgt;
> git rev-parse --abbrev-ref HEAD \
> | read -r branch;
>=20
> # Set up the callback script for 'git rebase run'.
> mktemp \
> | read -r callback;
> cat >"$callback" <<__EOF__
> #!/bin/bash
>=20
> 	set -Eeufo pipefail;
> 	shopt -s lastpipe;
>=20
> 	git rev-list -1 HEAD \
> 	| read -r bisect_head;
>=20
> 	if test -n '$pre'; then
> 		printf '%s' 'Pre-rebase exec: ';
> 		pre=3D'$pre';
> 		if
> 			\$pre;
> 			x=3D"\$?";
> 			true;
> 		then
> 			case "\$x" in
> 			0)
> 				echo 'success';
> 				;;
> 			125)
> 				echo 'skip';
> 				git checkout --detach "\$bisect_head" 2>/dev/null;
> 				exit 125;
> 				;;
> 			*)
> 				echo "failure (\$x)";
> 				git checkout --detach "\$bisect_head" 2>/dev/null;
> 				exit "\$x";
> 				;;
> 			esac;
> 		fi;
> 	fi;
>=20
> 	git switch '$branch' >/dev/null 2>/dev/null;
> 	git rev-list -1 HEAD \
> 	| read -r old_head;
> 	printf '%s' 'Rebase: ';
> 	if git rebase $gropts "\$bisect_head" >/dev/null 2>/dev/null; then
> 		echo 'success';
> 	else
> 		echo 'conflict';
> 		git rebase --abort >/dev/null;
> 		git checkout --detach "\$bisect_head" 2>/dev/null;
> 		exit 1;
> 	fi;
>=20
> 	if test -n '$post'; then
> 		printf '%s' 'Post-rebase exec: ';
> 		post=3D'$post';
> 		if
> 			\$post;
> 			x=3D"\$?";
> 			true;
> 		then
> 			case "\$x" in
> 			0)
> 				echo 'success';
> 				;;
> 			125)
> 				echo 'skip';
> 				git reset --hard "\$old_head";
> 				git checkout --detach "\$bisect_head" 2>/dev/null;
> 				exit 125;
> 				;;
> 			*)
> 				echo "failure (\$x)";
> 				git reset --hard "\$old_head";
> 				git checkout --detach "\$bisect_head" 2>/dev/null;
> 				exit "\$x";
> 				;;
> 			esac;
> 		fi;
> 	fi;
> 	git checkout --detach "\$bisect_head" 2>/dev/null;
> 	exit 0;
> __EOF__
> chmod +x "$callback";
>=20
> # Try the target first.
> git checkout --detach "$tgt" 2>/dev/null;
> if "$callback"; then
> 	exit 0;
> fi;
> git status;
>=20
> # Bisect.
> # shellcheck disable=3DSC2248  # gbopts may hold multiple options
> git bisect start $gbopts >/dev/null;
> git bisect bad "$tgt" >/dev/null;
> git merge-base "$branch" "$tgt" \
> | xargs -I{} git bisect good {};
> git bisect run "$callback";
> git rev-list -1 bisect/bad \
> | read -r bad;
> git bisect reset >/dev/null 2>/dev/null;
>=20
> # Perform the conflicting rebase
> git switch "$branch";
> # shellcheck disable=3DSC2086  # gropts may hold multiple options
> git rebase $gropts "$bad";
> if test -v post; then
> 	echo 'Running post-rebase exec.';
> 	$post;
> fi;
>=20
>=20
> --=20
> <https://www.alejandro-colomar.es>



--=20
<https://www.alejandro-colomar.es>

--rzl3uygpvtqujaeu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrBYfEACgkQ64mZXMKQ
wqlWdQ/9EgUIPd5te223MUfC6IGcOHEXLf8b0aGtQtwPsLnlYi4xQgw4u5QzMDaZ
PM2yOOkBNl+3Il6ZYE/SK7AHX5J6A1mw9Uz3pUKMgQXPuDFaqrIrIvYt3nhY/Otp
Pl/x4WYY+Jt/a0rEIXW/KkF9az2yUU4E8bkJ5E5hfHwyObyt1x975WEomFCyBXC+
8pP5esxI9s6qukw+OmYgTwu7sF2ouz7ye9oOQYynd6nvoBcoeFtfc8Ytjs8288+m
hEf+YBYZqJ6RRpdYBCEmsbxxEIhen959Fh1BX3Ag1XdcwcD1LKlB8fzBjSBl/X76
H2XSioOdKZAMftNFSS9NOSn+7krK2VADsF/SddlkHi1r88+WjK8AQmpS/LLMHsBY
FXkjpgkRCNt/yTrO2axoLhMJK4ke02mPbmMAq08rxpM4t+jqFzp+EBwTg0lmem1g
97fSfX+8tsfdgqZb1oA/Ddl9zZYlDQ5Iw0qkKOjVmHeZzw7Ca5NFfP0tNTgWIpG+
+6edbXstBUXzHcC7vf63F3EKCf1WcqhFZKluExyfU53aYTNMBs7zjX0UKFHQFflp
ZVVwEVvumomm4cOitzediuGrPnhVY5J4T4DOdume+VCH61KN82NLxe2lmlp2LjW7
RyGXXvi8elwPNIKJjRZt9t5UdGFVirRokOjAmSr+aXxs0RIHnqM=
=CBW7
-----END PGP SIGNATURE-----

--rzl3uygpvtqujaeu--
