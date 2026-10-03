Received: from glass.ash.relay.mailchannels.net (glass.ash.relay.mailchannels.net [23.83.222.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA0C3ADB94
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791065984; cv=none; b=qFNJfFyfS3JIR6Z7R3diLvlnufj8RkJ85XcZCzr+oIDtulMAl3sEIbu3o80cOtvt31REjAz625SV8BbrBjrjHlb6pGOOzdkgPDI8h6kl5NkoG4+c7UDglc7sAYa5jY9CrY2HrqhKDPOBrdW3PQEOD1Qaw0YS3dldj9bg8jEdNy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791065984; c=relaxed/simple;
	bh=gwdwAtUOrlelHEvh65zX19QhsZv8UqgOo0KSv2PfJG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfXFkJEtuXyaKTvs9FFUplus2Pbp6ndDlEGKTX8IYAnHXUuemt8PQSa/O6Hsrpbz3Q4+8MvEoNWnoq0Jy6YxGOnRjGbTNJQlRUCDNp3zC137RjNyQc+6HgXZvqG4qs6reQB5v01vJ3xUnJA+1Rbt0fJk3Z7l4J2B0SQnrQ79pSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=B4gOw3cs; arc=none smtp.client-ip=23.83.222.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="B4gOw3cs"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6DC76641424;
	Sat, 03 Oct 2026 22:19:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (100-96-3-158.trex-nlb.outbound.svc.cluster.local [100.96.3.158])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 35026641215;
	Sat, 03 Oct 2026 22:19:38 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Stupid-Madly: 0b7e448c5f937fff_1791065978295_422466173
X-MC-Loop-Signature: 1791065978295:3987334654
X-MC-Ingress-Time: 1791065978295
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.3.158 (trex/8.0.2);
	Sat, 03 Oct 2026 22:19:38 +0000
Received: from ubby (unknown [24.28.102.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4hy0ST3TJVzS6;
	Sat,  3 Oct 2026 15:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1791065978;
	bh=yuEBLHsVIK7RzArLvYZs9oSwgoAafb2ZuxitYSMkFH4=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=B4gOw3cs/2F2/wdEnxRlbvID9wH7SMjaNcpLvqp9lQc2zUuBXyByXmK3hSUsh/tf9
	 qW9aZ/3npehh8dI5+O4VzZtecJTj8i8Jw0lPFOUUwAO4nxlolDDVFTbLZT9QVcrkdW
	 fpFHBs2S+XE9J09N6mqjdbRaBEoo3gAODif1JhkDUwjr/Y+IlZ6+PSGl5lQDquGvoM
	 29Km1qVLgdPFdFmg2Ziby0fypLaPuY4AaThefAec9NkuexBn1aHoW8NY4sn6n7yGHK
	 pqzo1JPiDPXo79rbGA3pAnSgSMSogL2T19X+nZjE3fioUF7zH9SClHEO44r5qRVbM0
	 3AKPO2TT4Qg/g==
Date: Sat, 3 Oct 2026 17:19:35 -0500
From: Nico Williams <nico@cryptonector.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ben Boeckel <mathstuf@gmail.com>,
	Viktor Dukhovni <viktor@openssl.org>
Subject: Re: [RFC] git-brebase
Message-ID: <asF/d50VkzYSAPXn@ubby>
References: <asFRVdMTpshsazgM@debian>
 <asFoDZKscLKqaIf+@ubby>
 <asFoq4gnl1caJM2U@debian>
 <asFv9QcpLgzPnnFb@ubby>
 <asF0DkNtlnJ9-Sng@debian>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asF0DkNtlnJ9-Sng@debian>

On Sat, Oct 03, 2026 at 11:38:29PM +0200, Alejandro Colomar wrote:
> > I'd have an option or sub-command of the main script that says "do the
> > callback thing", then when you run `git bisect run ...` put in the name
> > of this script as the command and the "do the callback thing" option
> > next.
> 
> I'd need to see some code.  I'm not seeing it.  :)

Warning: NOT TESTED.

Warning: I did not first adopt your other patch to support detached HEAD
mode.

Look, no temp file in sight:

	@@ -1,164 +1,164 @@
	 #!/bin/bash
	 # Copyright 2026, Alejandro Colomar <alx@kernel.org>
	 # SPDX-License-Identifier: GPL-3.0-or-later
	 
	 set -Eeufo pipefail;
	 shopt -s lastpipe;
	 
	 err()
	 {
	 	>&2 printf '%s\n' "$(basename "$0"): error: $*";
	 	exit 1;
	 }
	 
	 fp='';
	 other='';
	 pre='';
	 post='';
	+callback=false;
	 while test $# -ge 1; do
	 	case "$1" in
	 	--first-parent)
	 		fp='--first-parent';
	 		;;
	 	--pre-exec=*)
	 		echo "$1" \
	 		| sed 's/--pre-exec=//' \
	 		| read -r pre;
	 		;;
	 	--post-exec=*)
	 		echo "$1" \
	 		| sed 's/--post-exec=//' \
	 		| read -r post;
	 		;;
	+	--bisect-run-callback)
	+		callback=true
	+		break;;
	 	-*)
	 		other="$other $1";
	 		;;
	 	*)
	 		break;
	 		;;
	 	esac;
	 	shift;
	 done;
	-gbopts="$fp";
	-gropts="$other";
	 
	-if test $# -lt 1; then
	-	err 'Missing target commit.';
	-fi;
	-if test $# -gt 1; then
	-	err 'Too many arguments.';
	-fi;
	-git rev-list -1 "$1" \
	-| read -r tgt;
	-git rev-parse --abbrev-ref HEAD \
	-| read -r branch;
	-
	-# Set up the callback script for 'git rebase run'.
	-mktemp \
	-| read -r callback;
	-cat >"$callback" <<__EOF__
	-#!/bin/bash
	-
	-	set -Eeufo pipefail;
	-	shopt -s lastpipe;
	+if $callback; then
	+	# Positional arguments to the bisect run callback
	+	branch="$1"
	+	gropts="$2"
	+	pre="${3:-}"
	+	post="${4:-}"
	 
	 	git rev-list -1 HEAD \
	 	| read -r bisect_head;
	 
	-	if test -n '$pre'; then
	+	if test -n "$pre"; then
	 		printf '%s' 'Pre-rebase exec: ';
	-		pre='$pre';
	 		if
	-			\$pre;
	-			x="\$?";
	+			$pre;
	+			x="$?";
	 			true;
	 		then
	-			case "\$x" in
	+			case "$x" in
	 			0)
	 				echo 'success';
	 				;;
	 			125)
	 				echo 'skip';
	-				git checkout --detach "\$bisect_head" 2>/dev/null;
	+				git checkout --detach "$bisect_head" 2>/dev/null;
	 				exit 125;
	 				;;
	 			*)
	-				echo "failure (\$x)";
	-				git checkout --detach "\$bisect_head" 2>/dev/null;
	-				exit "\$x";
	+				echo "failure ($x)";
	+				git checkout --detach "$bisect_head" 2>/dev/null;
	+				exit "$x";
	 				;;
	 			esac;
	 		fi;
	 	fi;
	 
	-	git switch '$branch' >/dev/null 2>/dev/null;
	+	git switch "$branch" >/dev/null 2>/dev/null;
	 	git rev-list -1 HEAD \
	 	| read -r old_head;
	 	printf '%s' 'Rebase: ';
	-	if git rebase $gropts "\$bisect_head" >/dev/null 2>/dev/null; then
	+	if git rebase $gropts "$bisect_head" >/dev/null 2>/dev/null; then
	 		echo 'success';
	 	else
	 		echo 'conflict';
	 		git rebase --abort >/dev/null;
	-		git checkout --detach "\$bisect_head" 2>/dev/null;
	+		git checkout --detach "$bisect_head" 2>/dev/null;
	 		exit 1;
	 	fi;
	 
	-	if test -n '$post'; then
	+	if test -n "$post"; then
	 		printf '%s' 'Post-rebase exec: ';
	-		post='$post';
	 		if
	-			\$post;
	-			x="\$?";
	+			$post;
	+			x="$?";
	 			true;
	 		then
	-			case "\$x" in
	+			case "$x" in
	 			0)
	 				echo 'success';
	 				;;
	 			125)
	 				echo 'skip';
	-				git reset --hard "\$old_head";
	-				git checkout --detach "\$bisect_head" 2>/dev/null;
	+				git reset --hard "$old_head";
	+				git checkout --detach "$bisect_head" 2>/dev/null;
	 				exit 125;
	 				;;
	 			*)
	 				echo "failure (\$x)";
	-				git reset --hard "\$old_head";
	-				git checkout --detach "\$bisect_head" 2>/dev/null;
	-				exit "\$x";
	+				git reset --hard "$old_head";
	+				git checkout --detach "$bisect_head" 2>/dev/null;
	+				exit "$x";
	 				;;
	 			esac;
	 		fi;
	 	fi;
	-	git checkout --detach "\$bisect_head" 2>/dev/null;
	+	git checkout --detach "$bisect_head" 2>/dev/null;
	 	exit 0;
	-__EOF__
	-chmod +x "$callback";
	+fi
	+
	+gbopts="$fp";
	+gropts="$other";
	+
	+if test $# -lt 1; then
	+	err 'Missing target commit.';
	+fi;
	+if test $# -gt 1; then
	+	err 'Too many arguments.';
	+fi;
	+git rev-list -1 "$1" \
	+| read -r tgt;
	+git rev-parse --abbrev-ref HEAD \
	+| read -r branch;
	 
	 # Try the target first.
	 git checkout --detach "$tgt" 2>/dev/null;
	-if "$callback"; then
	+if "$callback" "$branch" "$gropts" "$pre" "$post"; then
	 	exit 0;
	 fi;
	 git status;
	 
	 # Bisect.
	 # shellcheck disable=SC2248  # gbopts may hold multiple options
	 git bisect start $gbopts >/dev/null;
	 git bisect bad "$tgt" >/dev/null;
	 git merge-base "$branch" "$tgt" \
	 | xargs -I{} git bisect good {};
	-git bisect run "$callback";
	+git bisect run "$0" --bisect-run-callback "$branch" "$gropts" "$pre" "$post";
	 git rev-list -1 bisect/bad \
	 | read -r bad;
	 git bisect reset >/dev/null 2>/dev/null;
	 
	 # Perform the conflicting rebase
	 git switch "$branch";
	 # shellcheck disable=SC2086  # gropts may hold multiple options
	 git rebase $gropts "$bad";
	 if test -v post; then
	 	echo 'Running post-rebase exec.';
	 	$post;
	 fi;

> > > > and use environment
> > > > variables to pass arguments to it.
> > > 
> > > The callback doesn't really need any arguments, since 'git bisect run'
> > > won't pass any arguments to it.
> > 
> > But you're embedding values into the temp executable script -- if you
> > don't have that any more you'll have to pass those in.
> 
> But why would we want to not have it?
> That would complicate the script, no?

Because I don't want it writing temp files unless absolutely necessary.
Even with a `trap` this can leave garbage behind.  Better to avoid it.

Plus I... just don't like that style of bash scripting, and sure, that's
just personal preference.

Nico
-- 
