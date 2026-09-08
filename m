Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD485540B6
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874152; cv=pass; b=XrB/OVgmcQ1N5Q2lOL0duRD0Y7TZ4OKWAdul4cq/1PACCUE2TyQNPmw9+IEl1EHn/aev9TONqpVjfAEUfPhOHxKQhGcRJWNMIS/TWsAhfpCjgF14GiNDoI9KkpkY1opYJ5C2hT6l/StM05LgExlFLSK5f2g0os3khWQ4ThLRumw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874152; c=relaxed/simple;
	bh=PQgcf86rjQMnc8F8zC9YpqkvLSCZ78oRlME7I3KJEH8=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=B6YCQ+NDZbJY/ja1gb5PM6Koj4lRrhapea/vHuuZY+mTyvFhg9PMPAIuOwD5fj6ZmOzHorm5KsczWXnTXH6ULJa3ERF020Sn8H30z6cobPiBx1KweOBC97H7CUW8T96PC91t96ldySm7VebAy1HgW5G1HsR8Ie0vHXjmxogn3jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=dinHkF3B; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="dinHkF3B"
Received: from fauth-c2-smtp.messagingengine.com (fauth-c2-smtp.messagingengine.com [204.75.18.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmtilli)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hfPsb1ttsz49Q5P
	for <git@vger.kernel.org>; Tue, 08 Sep 2026 16:28:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1788874131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S4aLDOxBcJ2AtODnRSB+i7GuqHFoQcTdiuQFvvb4IaE=;
	b=dinHkF3BzYiNhkNgnu8JhQ1oI17909AxtCeULhnoe+40XsM++ei2lI4eZPpaOvVwDG6SdL
	4c4zXqzhOrEGUZqQiMwBm6Y4kBjkMTPP3tA9LBylivZp1hFwmLXm52/3MDF1x3JQzPXDq+
	uCEbQ9/h1vcgBKXxGSm5LWutJXluLajfQ+zasZfo7kY9kMapd/tNW7HSZr9eUwv6Ko/TO9
	4rWe2p3yXLtjZZCmfuXY+XyIA28DuTwhbfFBnwQ/ACKoXNqO+T1BuwT2H+YQ0q97HHbcpV
	YrmSU2CuTwIooif4vODlTFnypvtIElePhieyzZYChPWmqzWrvT4QvV5CwN/pjA==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1788874131;
	b=JoOAOPO1+V33p1CLtjBb8skEnmvLH6Z5SO3gm7YsINlgOpxpIpi/cqMYZR2lptwUvLKY1S
	6pdv/Z2n4Mz/Rr+q5Mxn4HwwZvpN9wnXDJlxP0Y4vnzUGjOUjst01HPd1KO2w72jfb1Of4
	SmWP4mzMPkYm+kVTdlflpMKGuuNLyNtTqZ0J3XXwaEhI3DW0UelOE3KfzayVba9eOjkfqy
	piIzhpueNQd4zzLHYtyaqk+TbYcwukwXbHV3llvE/TXzmNDoK5dKEQ6XT4Swv646D3wGr+
	h1ugKnKx+Tccp8g54jJhZ0JGYfGnG9tsqRrFFjxwGK99QrKqxC2FKOtCRdSbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1788874131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S4aLDOxBcJ2AtODnRSB+i7GuqHFoQcTdiuQFvvb4IaE=;
	b=kBcl+zwd3aO2+pkfE9riR/iv/6tGD+w2et9QoWTNrQecvs0e0ChtZjachrCmNNpbqSHr1S
	Y7mxDxt5qqKNTyJUIn53H831pmDp/k7IMqyYUZncgdIIkTWSXAJXl8E6DyZtc/QewsoxQU
	hDpMVSeUb2IFSZFWvlfHCKdVZdPyt4SLzSqBLLGvSzAaXdzrDGWpCOWBh5Mw5kp1Nz2O4d
	i/eiWUySkirCW/5kgKQk82eGA3VPUE5puJKLg7zjfnLaDu/hr+FEBh0mJ7QZgJD/C1UCXa
	E8XgaSfHGjTpaSlJ93dUvuelglgGVs0XAflVc6XoNgqVMGshrECvIA5A/M9ukg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jmtilli smtp.mailfrom=juha-matti.tilli@iki.fi
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id 872341980047
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 09:28:50 -0400 (EDT)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Tue, 08 Sep 2026 09:28:50 -0400
X-ME-Sender: <xms:kQ2gajD2zBGV607Ogu3LoseX_93MzJ1zrnyhw_gW15L9gd5wdLsVjA>
    <xme:kQ2gakXGQikrwi64FqJgYUe3IpzIgyOF21ylNyjj0S98FrijvQfiV5oS27-QZ0lAj
    Wq-byap8yrCfqLINjpNkGN3TZxMYFx1pqNVswI--LXNU7m2r_o1EbM>
X-ME-Proxy-Cause: dmFkZTGF1Pu5gO9J4Ip2kSFWdOy4OGNp9mdRMdvLimP0iJwstevDnCN+LLPRhPgTcxMWjK
    +HMPzBU5qM/ZpwhlSdr+A5u452ITQY88B6zt2Yv4L7oOUQc1YYiawIEZ05z6eR67wmVXzf
    E7pueQmb6gFbOpGc0RXrGqO5cBVvu7oizt1AUIPGiO1mskZC7Nzzgv7jGh1Yqkx3Cvdy7j
    q3ZiO3WYU6wN8vN/TWXpuZwdhLSrkQLmzXR71DPKJQ5CSc3Is6eQ5Q+q7RtX4QtTgsnmXT
    Bkt5gKhyfXRzuVltBFx93onnbj5XG+kY35sKBXpJQ9SBAXwRAx+l5k02bVZ7c9EJoh/ukH
    hqUaIiLK9UjwumGoxClEMw0K+qG/sLjiSoe0ZTZT4hgphbr9F71PUk/Tl96tStFgQ79WTM
    4oueCl6GDwGIVXgyLABbHfFsOoz9vnHr3d3QeDivasgjaCAewvW4Wb7WHmlNJmlxaD51C1
    oMi2yGtx/HmVZwIz0gKU1MV6bvMwopjM1mu87XWV1qs/hkaNWyMgAJs3hUKaYp/9FOxGb5
    eEJCpS9vO4lsbnXpeQ5uGjkldwrYg24iZ6QSOqA/Yic0T8wBSkVpOHajouhpKAYwl/yr+C
    7DN3q+7w/SKU7vqaPqXtJ1Ty7kjuxdFH15UdWpkHi13MqXO8hixuVi0sdLhA
X-ME-Proxy: <xmx:kg2gaoSA9F0hFxFYjZKvJSSZhWTY1LRXtBZWQhgTUeADlNESSickcQ>
    <xmx:kg2galvRtgYbCkLWS5rHV3JeZvXscEHb7gGCMGMcnoRZMqxQCKdMBA>
    <xmx:kg2gaivb96a9_DoJdiugjCgaIkBgjFkPnQI1gPX4Hx9c2goG5z-DaQ>
    <xmx:kg2gajzgv90tPlA_rzui_km0d8l1Cjr7WepRjCGYch3IJBxwxwuSrQ>
    <xmx:kg2gaghrd5x7u6PMI6tesvQU0XwgVMMvgX5FKXoa6LWWezzPXhLCCpM6>
Feedback-ID: i02414972:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 9649BF80083; Tue,  8 Sep 2026 09:28:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 08 Sep 2026 16:27:55 +0300
From: "Juha-Matti Tilli" <juha-matti.tilli@iki.fi>
To: git@vger.kernel.org
Message-Id: <394c3f65-80e0-4cb5-b8d1-8d8e2af25d5f@app.fastmail.com>
Subject: git send-email bug, sending cuts off to rate limit
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

I prepared a series of patches to Linux kernel mailing list:

https://lore.kernel.org/all/20260908093145.2492666-1-juha-matti.tilli@iki.fi/
https://lore.kernel.org/all/20260908093437.2493698-1-juha-matti.tilli@iki.fi/

There were 18 recipients per mail and 13 mails total. Then I ran git
send-email, and pressed "y" at every prompt. At mail 8/12 (ninth mail since
counting starts from zero), I got cut off:

4.7.1 Error: too many recipients from 83.150.90.33

What did you expect to happen? (Expected behavior)

I'd expect Git to sleep for a while such as 60 seconds, and ask the user
if the user wants to continue.

What happened instead? (Actual behavior)

Git immediately exited. Then when I continued from the first patch that
was not sent, I later embarrassingly found that they were in a different
thread.

What's different between what you expected and what actually happened?

Git shouldn't exit if the error is clearly an SMTP rate limiting error.

Anything else you want to add:

In the next patchset, I'm going to use --batch-size=4 --relogin-delay=60

But it's too late to fix the already sent embarrassing mails.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.34.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.8.0-138-generic #138~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Fri Aug  7 13:43:15 UTC  x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
