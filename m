Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810341F9413
	for <git@vger.kernel.org>; Fri,  2 May 2025 22:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746223676; cv=none; b=mZ/trXkFmar7i2QDrri1lIGlCKwwXYMcjgMSit6uhG45g+W9MiP08HTRslOYcrMej3tZilsHqkpWoLqge2/80ZkF7RjtaPiIQ5JVVLJhwFkpc0c74Q+q/2B7DXftVdvnQe+DsUZcu5+szjKbJQEzZGMCaTwYz2+S7OBdngNSW8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746223676; c=relaxed/simple;
	bh=mHM/eAG678ZJ36a9AUB6ieDv5eoyxlepb1Yu9BLE7iQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=inBgtmdULp6tFOI3YJnVzPWpcw0RvbR5URZTPrOzm/eC/O6b8PAXgs1qXXyiG6mPv8JMAqlqGzo3iLu5vVy8RKmnaXJt+/S67QOYfmKKrnx83+KJakcJAzZfAHX8SFV2/iH6/+D4muzOfmw3zyCEFH3oYaX+QqPzb4rnZP8gd30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=matthias.vombruch@gmx.de header.b=L6gXu6gV; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=matthias.vombruch@gmx.de header.b="L6gXu6gV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1746223671; x=1746828471;
	i=matthias.vombruch@gmx.de;
	bh=mHM/eAG678ZJ36a9AUB6ieDv5eoyxlepb1Yu9BLE7iQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L6gXu6gVZJyBeDdoSYrEoXTZfkxfhwr/8gkIkIv6L6E8ov7wJXtA904yIs9KP5Ab
	 +fU9SDi12Qwh7oWnNlN2aOsmJH63e+r6JU8SOYEfjjn/ntn2eOhwlayi9yzWGIpLH
	 fhe/d4/m9gAL399FuCWzK9alMIs4s9XVZRGn94Xryh6QQyf4z7OWPdihuuhYwaP7B
	 NcbtnvJYRA141JYyD3NJFkTOA2Xbwi0p6PcxGevl3N0MnjHSklg4kU7pR0sXptpBx
	 nsZk6dZ+iwnosFq4EVmUYLouv9NLhqgCMTItfwvMxZrGUvf5SF1KzqxvBrR5Lc+bT
	 lJjPNiaABt8jLGz6+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.35] ([217.231.170.102]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgvrL-1uglek21dt-00fGm7 for
 <git@vger.kernel.org>; Sat, 03 May 2025 00:07:51 +0200
Message-ID: <dcf355a7-cbeb-4162-82a9-5486d3ce3166@gmx.de>
Date: Sat, 3 May 2025 00:07:51 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Matthias vom Bruch <matthias.vombruch@gmx.de>
Subject: bugreport - cannot clone repo over ssh which I don't own
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R4AosvHrGas5Nhu1seKIIc9BmVbQwa3tKzCrFkMWRTKGjNzVHEN
 QY18yY65tja76mnlY+XR9NkDt5dhKTqm681oeWVWUQ7fICHh+0gQcx67C301BOoKmGXVQcc
 6OjQvCaWyW+QnP56TZVb/mwJs3LXIEdH3HzQ9lf3HAo+UzVzfQXC2Y5aDXFPitHqc6/WLFH
 ZQaskbHCiFOvLLYiM8zDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ivfXsKcJKmM=;k3DEmEbOTKW7eYs5ernbkFEEG9I
 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

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Create a repository, rsync it to my homelab server, place into a=20
directory that is owned by a:a_and_b and has -R file mod of 770. Then=20
cloned that
into a new, bare repository with the same name, say on=20
/path/to/bare_repo. Then I prepared ssh auth via key on new machine, so=20
that user b can lo
g in to homelab without password. Then tried to clone the repository=20
with `git clone b@local-name:/path/to/bare_repo` and variations=20
prepending `s
sh://` and appending `/.git`. Got error

fatal: detected dubious ownership in repository at '/path/to/bare_repo'
To add an exception for this directory, call:
 =C2=A0=C2=A0=C2=A0git config --global --add safe.directory /path/to/bare_=
repo
[The following is a rough translation, as the machine is in German and=20
so was this message]
fatal: could not read from remote repository

Please ensure that you have the correct access rights
and the repository exists

I then execute the command it suggests and confirm that the appropriate=20
line has been added to my git config

Retry - same error

Test if there is actually a problem with access rights by copying the=20
repository with `rsync -r b@local-name:/path/to/bare_repo ./`. No issue, e=
ve
rything gets copied

What did you expect to happen? (Expected behavior)

Firstly, no issue at all, as cloning from a remote (bare) repository=20
that _isn't owned by me_ seems like standard usage of git. People are=20
bound t
o run into this in projects of more than one person, unless they use the=
=20
more elaborate implementations of vendors like github. My understanding w
ould be that this is how git should "naturally" work.

Then, the error being fixed after I apply the command it suggested.

What happened instead? (Actual behavior)
Unable to interact with repository unless I change ownership of the=20
remote to exactly the user that is used for cloning over ssh.

What's different between what you expected and what actually happened?
It cannot be made to work

Anything else you want to add:
This report is made from a different machine that runs a very similar OS=
=20
(NixOS 25.11).

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.47.2
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path:=20
/nix/store/gwgqdl0242ymlikq9s9s62gkp5cvyal3-bash-5.2p37/bin/bash
libcurl: 8.11.1
OpenSSL: OpenSSL 3.3.2 3 Sep 2024
zlib: 1.3.1
uname: Linux 6.6.32 #1-NixOS SMP PREEMPT_DYNAMIC Sat May 25 14:22:56 UTC=
=20
2024 x86_64
compiler info: gnuc: 13.3
libc info: glibc: 2.40
$SHELL (typically, interactive shell): /run/current-system/sw/bin/fish


[Enabled Hooks]
not run from a git repository - no hooks to show
