Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9E135DA53
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 17:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772819592; cv=none; b=FkqWe1D7WeGQcZycxXWTZEDJUHakoLdsYK/GJTGOYL67zYP+oHjIw0PNOaj0/6m+Ne0tdde7xkj3VlemKmhuEfn7LjKGJmbxuMxvYs5O145noHfv7hZCwawqyynf8+WNuF1HhxmxKUYdGh+p5v0h5IA1MNJVNczirZ1NogrdMRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772819592; c=relaxed/simple;
	bh=1hOG6KQlAUWUqsc5uZNBou96thwpZixJAgqL9yaTnzw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=n0GnHREpLclnxt86xWl/KIQtc4zm0YX2pncQcRRPHFoqxMYR+/sY/OJtzJiL9Zhc8qvsmavofuYwfflabGPVRfH19vY1VpT51GVSZDpZ/dXAsAmcsra2tliOV+6rrg8rKiZtxEE8ZZ6VJQf4RysBXHoHyZg6aLX7g5MdZgmP05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=joerg.gambihler@gmx.de header.b=JO0RpyvS; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=joerg.gambihler@gmx.de header.b="JO0RpyvS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772819586; x=1773424386; i=joerg.gambihler@gmx.de;
	bh=1hOG6KQlAUWUqsc5uZNBou96thwpZixJAgqL9yaTnzw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JO0RpyvSj5KrZl/8Co2bL5gLakd7ig5ye09IYIfp/KCW45pDtWeVTOjgG5/xUJ+o
	 s/g2MebuPqchbwlCaCjqHNKXMlkcsb1/c7/4QfLt/cAKjaKrv+A2JysII9xUA/TSj
	 AFTH1x4Fymy7KapSyVk3Z+i+M2uOO0gsROvuqHRnUWn3mZDQSRVbo5RfC+Htrca7p
	 0D0txcPNqySqtMhhK3GUpwyRhlQEYKaLYSZ34B3MICCszmivpWDZTtgkeMwFwfFyI
	 OPbrN3CPH9H3u+8F0k+xtKC615KqaGjIklO9FljFGMJoxekfwNVqz8q5oXjqiz/6C
	 SR1f0oet5p3yMrlaZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79yQ-1vbhMr3Uho-00vxhE for
 <git@vger.kernel.org>; Fri, 06 Mar 2026 18:53:05 +0100
Message-ID: <946173d6-3872-4b5c-93a1-08134b6483cc@gmx.de>
Date: Fri, 6 Mar 2026 18:53:07 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: joerg.gambihler@gmx.de
Subject: [git/contrib/subtree] Remote-ref unexpectedly deleted if pushing
 subtree commit twice
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bhzwMsyLJV+chO7yMTpxJZIDBvto9hzazvkoAcvPEUYnfRAyX0C
 qFIgXYWMHRL3r/8h6ffn/kI7sv5oKOeuww7pxCeWuOJfA5fJnCb3frlw/O2p56yNjcwvBtI
 vofaawcCJUXLuRANl6fFXL4+N490L0N/sIcF9mIG5nXq7r5HjYgvauFJcfgWMzKX8QbEHD4
 P7uXCY6zSOfcwaJPBUUQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D61YJUGjPsk=;h6JBHJdoUHKJLkMY2MMGbs3ejlh
 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
 geCy0cvdqC1MxHQejy0sAjk9Xkx4ziUY3MuA/C

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

# setup main and subtree repo
$ git init main && git init subtree
$ cd main && git remote add subtr ../subtree/.git

# populate main repo
$ mkdir dir && echo hello > dir/hello.txt
$ git add . && git commit -m "Commit dir"

# split/push subtree 'dir'...
$ git subtree push --prefix=3Ddir --rejoin --squash subtr subtrbranch
# ...and again
$ git subtree push --prefix=3Ddir --rejoin --squash subtr subtrbranch

What did you expect to happen? (Expected behavior)

- No change on 2nd=C2=A0 git subtree push

What happened instead? (Actual behavior)

- Remote-ref unexpectedly deleted on 2nd git subtree push:
 > git push using:=C2=A0 subtr subtrbranch
 > Subtree is already at commit xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.
 > To ../subtree/.git
 >=C2=A0 - [deleted]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0subtrbranch

What's different between what you expected and what actually happened?

- No change vs deleted remote-ref on 2nd=C2=A0 git subtree push.

Anything else you want to add:

- Root cause in contrib/subtree/git-subtree.sh (branch next, 3824d2c):
 =C2=A0 In the scenario above:
 =C2=A0 cmd_push calls cmd_split in a subshell:
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 localrev=3D$(cmd_split "$localrev_presplit" "=
$repository") || die
 =C2=A0 cmd_split calls cmd_merge.
 =C2=A0 cmd_merge exits 0 without writing to stdout
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if test "$sub" =3D "$rev"
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 then
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 say >&2 "Subtree is already at =
commit $rev."
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit 0
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi
 =C2=A0 With exit 0 only the subshell is exited. Instead of dying this=20
assignement
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 localrev=3D$(cmd_split "$localrev_presplit" "=
$repository") || die
 =C2=A0 becomes
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 localrev=3D
 =C2=A0 yielding a refspec=C2=A0 :refs/heads/$remoteref=C2=A0 pushed to th=
e remote=20
repository:
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git push "$repository" "$localrev":"refs/head=
s/$remoteref"

- Proposed fix (I can try to submit a patch if desired):
diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.=
sh
index 791fd8260c..0951a5aadd 100755
=2D-- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -1102,7 +1102,11 @@ cmd_push () {

 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "git push us=
ing: " "$repository" "$refspec"
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 localrev=3D$(cmd_=
split "$localrev_presplit"=20
"$repository") || die
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git push "$reposit=
ory" "$localrev":"refs/heads/$remoteref"
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Validate localre=
v. It maybe empty if cmd_split exits=20
with 0.
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test -n "$local=
rev"
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0then
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0git push "$repository"=20
"$localrev":"refs/heads/$remoteref"
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die "fatal: '$dir=
' must already exist. Try 'git subtree=20
add'."
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi



Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.53.0.windows.1
cpu: x86_64
built from commit: a5512bdee37ed7142c233d21e2d347ffc4860ff3
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
rust: disabled
feature: fsmonitor--daemon
gettext: enabled
libcurl: 8.18.0
OpenSSL: OpenSSL 3.5.5 27 Jan 2026
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Windows 10.0 26100
compiler info: gnuc: 15.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.e=
xe


[Enabled Hooks]

