Received: from mail-107161.simplelogin.co (mail-107161.simplelogin.co [79.135.107.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E501632DD
	for <git@vger.kernel.org>; Fri, 26 Dec 2025 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=79.135.107.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766780192; cv=pass; b=IKmeda/oIdJ6EGgzo/yAWhnsycx+PQU8I7hFVF/WI/G2P50Rc/reqqrKyfQcarjYELASGCCkG4vlv5hq51waTieNINvn808MI20ozdQDKmjtffSglnZh20y3FWjc+lcd4Acpls+h+isxnN1BwvwzCdtiSAhpZcIVRhHbT5Io1AQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766780192; c=relaxed/simple;
	bh=mTgU0PaqbBj5qMKIANklkggWl3dSMpaCiOmzbOS64BA=;
	h=Date:Subject:MIME-Version:Content-Type:From:To:Message-ID; b=eCmjJpn/m2LLQ445SQd76nbsI6bpiQbOIsXIzOMPfyiX3GbUC53j3Lo97B7k8oCln6v+jmXIoSEEe0YOLJGkg7mfD6NIYvpeivHXGqva4d02jqUXX7xgGYb2ErX9aoPf9PvkHyvW54cs0XLUdgTh1bPNtc7a7GGDURpxzqpDztg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dietrich.pub; spf=pass smtp.mailfrom=dietrich.pub; dkim=pass (1024-bit key) header.d=dietrich.pub header.i=@dietrich.pub header.b=nzlksXKB; arc=pass smtp.client-ip=79.135.107.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dietrich.pub
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dietrich.pub
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dietrich.pub header.i=@dietrich.pub header.b="nzlksXKB"
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1766779107;
	cv=none; b=vXhdvUd5zpTcYwwYuwrKB65XFGgKrKpkzrWM0WAApnr8w7smtAqtLQrMOX3eV5blWXHh7WBm2ngQYJ1Sk2+0towAX3xyjQSW3fnZOePb9OSQOh1bKsCbVrZQpVbu29AymnK6yq8N3QG1ku+K17DUV+8KI19kmmn8T12kugVWeS398H3RRD6razydIsv+Bw3euaD0HpXMfmNuVcmzwwP+ZHpzP2af3XTOWrLabYGhgtwg+p0rb5Ay8Na0GqBLs0iivT64zOJjYcNqa2nfyDS+3Ny6wvrEnoasd2d9XnvGU3cfz4ChLZBiJ/jpUtq7szQCu9ec8deSJUd/XvKIJ9VPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1766779107; c=relaxed/simple;
	bh=mTgU0PaqbBj5qMKIANklkggWl3dSMpaCiOmzbOS64BA=;
	h=Date:Subject:From:To; b=2r/S9NY3cyBjcTq63OLbSRHAN6p0ad4iof90SAj0O9rkasDBKBg0aw6oILG58zO3lrrW0YQhf/PicB/1v2niTMFiPhTBXeMtE12socEixPH4lhaKxV6ka29wqrrgBLw3j7VgqNElckFT8y9tR0LBmD1OKngMmaQHXTVolyxcJ1KrdV3L5l+g40tO4KQxuyD6V1DQzF0gwTXbzWlphDcmJ6mRRBC4InkNziqi70GSL5DZ4fMGVZE9AzFK/8QqKNTjVDCJB+UILqDRSQoLktEZ+bSySpLoBPga+GLRQYa0x1ZiJc6qgF/WgDb2vrRmfEX0peoME5gcAt39QCe9Rje9MQ==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dietrich.pub;
	s=dkim; t=1766779106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8K3jurFlhe+eT0yg6jETS7PxtWNbSkmetvxXZIKCASU=;
	b=nzlksXKBFZKA/Jjtq2NleI9+wPFE5N85rh+Vs1Nzo3XXxQcQ6/R3kDl0rs4qP7V7TlvNcy
	TqFJvOSgs/EN73fApzdzIWGu5Ystbc3cFdXVJSu4vIomkRGmaa9upvm7nRiWFaQzcU+wHc
	RNMkSIWXR+P2mbolW5cRiTWXh45DapE=
Date: Fri, 26 Dec 2025 19:58:22 +0000
Subject: [Bug] Git subtree regression
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: dev@dietrich.pub
To: git@vger.kernel.org
Message-ID: <176677910605.6.2281395015810449820.1087545551@dietrich.pub>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1087545551
X-SimpleLogin-Want-Signing: yes

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I use git subtrees to manage the monorepo `https://github.com/athena-framew=
ork/athena`.
When using git 2.52.0, I can add a new remote for say the `clock` component=
 via `git remote add clock git@github.com:athena-framework/clock.git`
Then do a `subtree push` via `git subtree push --prefix=3D"src/components/c=
lock" "clock" master`.

What did you expect to happen? (Expected behavior)

I expected it to work and say `Everything up-to-date`, because it is up to =
date.

What happened instead? (Actual behavior)

It fails because of:

```
To github.com:athena-framework/clock.git
 ! [rejected]        0efb3d9858e3bfee65165508aeeacc50417c9a99 -> master (no=
n-fast-forward)
error: failed to push some refs to 'github.com:athena-framework/clock.git'
hint: Updates were rejected because the tip of your current branch is behin=
d
hint: its remote counterpart. If you want to integrate the remote changes,
hint: use 'git pull' before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

What's different between what you expected and what actually happened?

Seems to be a regression of https://github.com/git/git/commit/83f9dad7d6fb5=
988b68f80b25bd87c68693195dd as it used to work and now it doesn't.

Anything else you want to add:

I did some initial exploration and it might have something to do with the `=
clock` component originally being added via `git subtree add --squash`.
For another component:

- git 2.51.1: split produces 92 commits, properly connected to original rep=
o history
- git 2.52.0: split produces 8 commits, disconnected history with a new roo=
t

The `git-subtree-split:` marker in the squash commit body doesn't seem to b=
e honored in 2.52.0.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.52.0
cpu: x86_64
built from commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: enabled
libcurl: 8.17.0
OpenSSL: OpenSSL 3.6.0 1 Oct 2025
zlib-ng: 2.2.5
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 6.18.2-arch2-1 #1 SMP PREEMPT_DYNAMIC Thu, 18 Dec 2025 18:00:1=
8 +0000 x86_64
compiler info: gnuc: 15.2
libc info: glibc: 2.42
$SHELL (typically, interactive shell): /bin/bash


