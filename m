Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1570132B126
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357895; cv=pass; b=JSfBUB/cRx3Gb2Ao3LDzHWIqPUsSFMmu5+zDsXQorz7xB8MjYxeteuo1RqR7QIxT7+FU0fvxeoxcuO9/2vAESJymjQ2755lCiHEi+FoV3gFdPiIdXfLIHY+5cjZLy/5v6TKqy6XzeOsAUgrkK51Q8FPx32MMKYqboo/dazlRZTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357895; c=relaxed/simple;
	bh=rHDsrgHnwuhjD5ynJimm8etB/5q2NjvlvaDnlGDdkPs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NDnTXMqyYxjwej6CakrnDGtKSPG9TArIYGPJt6FYwExCu1P7qdvCmLW26pmky6P0o69jiFxD5wf81SKNHoDwU2FtdliqXJeiKKysuqShCBPokFfOmixDkMepLtYtdblS+fEx/25eXnJjzUzH1NwqF+NHzSjGCPyHKtGufYtBRRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMQoL7r4; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMQoL7r4"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5c65d654c23so438632e0c.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 07:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788357893; cv=none;
        d=google.com; s=arc-20260327;
        b=VMNR5I6QZio057FPSZcGo2jDSYoEBIhIGSpp0SqXTiM9VcDmOXDz6futz37Mi5ffgS
         Ibhfs9FsMsN4JftMVq2WqUCGfBRaKY2Ozcvhl3vIH/zvxQog3nC4/83wM+Acm5q7BQ6S
         V7nFmye06v+7fUzhr1CbV3I9UuqOfIXNlKgmO44m5pO3l7xnvpdDOY0RXSEZmqk0WND1
         nyi1PawXvn5W792gca1urMB9MLA6QxufzMIJmw59wpA4JrqpTuy5SAxpip04J74SIFXE
         frC6Pue+rOolDBPigWeSyJWDFA52sYQ6QECfq5BREJL56qo+prQn6LcL1QUxwum4ERVF
         Tcig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=rHDsrgHnwuhjD5ynJimm8etB/5q2NjvlvaDnlGDdkPs=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=OxzxRE9gSC7lcTzjY3RTq5KyyuveMXV6wAzgU/cKeoAPsaqz1Uqd9feLh5IPA+bHqY
         dIJzHvtdfmzgLyQrYobQhukeq4aGq3z2HjAdR2uTzRS3HLBUxaNhOAFm6di/HV7TRSzU
         KVimhR8qb82sbCSdKvnEoFQJWmPC9nwFhbTMoZu/oY+rrADZigCsakuZHxphdTpD7MHm
         a81Q6iZzYiXB9iZaQUmH6IWhx4vuGrFBjV93BC3TrF6r3j+MJ9OMYLfThDMYdpewTzHw
         SUwdGatFLe8aA+CRk2b8Z6FF0MN3IU4vF/h6furM3wcy+M4WkXJaOEC+MVmix2oZupb1
         VM7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788357893; x=1788962693; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rHDsrgHnwuhjD5ynJimm8etB/5q2NjvlvaDnlGDdkPs=;
        b=WMQoL7r43Qi0kRyI/qXnrAuyjSvswUlZ72MlPgzo3B2cQf0jqAtTFD/ASbxjWMdZlW
         FVc4+8y5wnUHlYET2pWcIEn7p3WNoDjb5rZxJmOo+YHJ6oOz4eqAzPxEkwSpfEvDz2ez
         VfEwDf+bDGWY30FRUKToRVsWLNjvZoQDEqQHpG9Aa47V9yUC/2eRiZ0Nc79eAN7Z+9EH
         Ume94D0MMf1XTqLzyf64yPt4l2Mu8KseSZ6pbAKm3DoCWe9kd2wRFKhmKIsTkqEqfiVS
         fapQaXl2gPfjj8akXNyLdVbSQrDmCnCl8oSE6GXuCf7V4DDUqfuwP+k6qkhdJA2VDJaH
         MHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788357893; x=1788962693;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rHDsrgHnwuhjD5ynJimm8etB/5q2NjvlvaDnlGDdkPs=;
        b=Db9KGlRdfNu0EWzklY6LITiVgdsgGZptL+4FvNO4jbaBM9KLtEPSPhNrQCn5n5EBhI
         mWR18YuE1oFPYPJCeRASPpgd9o8IE0qOPDedHNXP+5AZrP+9QfWtmoXYwmgecxMKwNTN
         FDpVDdsUFnQHZ6qpVETDvuNy2bxSNZJJW4FkpRv4bM9xUS3bSCTa09kPu8sFi3HuwA5Y
         aJmb930N7HbRdyNAf8ZIkJip3iDE6Be06kPdIwHAX0me5fT0S7byys/fbqHPkLHMb5FE
         A+7A/QQYvoIupeaUWQb2dey6vuGKMjq6Z49iIqor/QLCSjcEtafstzH8PLGvUkj90hWz
         oTTg==
X-Gm-Message-State: AFuF++nw8q+3anPju/70oDJxGpvhoDVjNLCX2xfZKJIAnzYaqsJHZqAK
	+PSk8ipXk/SVVmwJSkXNPTSC6kCk/PlfoNqPgBTFTBbpm/A6Lxl3R2XRoPKS+Ce+YCzvbdn7LG1
	M+sECSoB8bTw1vQ03UEKFAT2FChrXtmgx8IewlgasmA==
X-Gm-Gg: AYBFou0/v+MfswGvlMjh46NZq+g9CRVSxPIZ/QshBkb32SNYaFMZmr1yDWIO60EH4DK
	GmJP4lWmxcLD5p1cVIDnQoAmGiF2aVczurqPVk7y9veLpQUDMvHgSQLT3jNuq9gCPhiuoUUPx+M
	PzQSk/u6i8tAb45tjHOzPTjw01YBEGDuNG2hncSNceXuLeLAKjP1wFxdq4GQHRLV3lo+whZudxh
	eyvVODkqcFdeYMcfBHM0te9EgXGt85/AVj+YPA7dnkE8EA9XERwCfzB41QddNFe8E/cODoD71dg
	6oQyj3hnpFJO6cSIHbvHnifH/I1JQ0FTV4Z1B93e3NyYCJY=
X-Received: by 2002:a05:6122:3284:b0:5bd:aba5:3830 with SMTP id
 71dfb90a1353d-5c7d23a6cf7mr1923840e0c.0.1788357888016; Wed, 02 Sep 2026
 07:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Simon Cheng <cyqsimon@gmail.com>
Date: Wed, 2 Sep 2026 22:04:37 +0800
X-Gm-Features: AcwNN1UAijhBTYFbp42NglBdWQFkqrJUA-BlseVR8giI6co3thMmmka9B9h4pzE
Message-ID: <CA+itcS2ViLXMdXHFZpNah=jnEBc3sf-Zympb_f0GzftN99Lppw@mail.gmail.com>
Subject: Inconsistency in commit message handling
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When creating a normal commit using `git commit -m MSG`, an additional `\n` is
appended to the end of `MSG` before going through cleanup. However when creating
a merge commit using `git merge --no-ff -m MSG BRANCH`, this additional `\n`
appears to be missing.

Under default configuration this has no impact because `commit.cleanup
= default`
is equivalent to `commit.cleanup = whitespace` when non-interactive. Therefore
the additional `\n` simply gets cleaned up and nothing happens.

However in my case it does cause some trouble. I use the
`prepare-commit-msg` hook to
inject some comments into my editor to help me write during interactive commits.
This is the hook, with all irrelevant fluff removed:

```
#!/usr/bin/env bash
COMMIT_MSG_FILE=$1
echo "# My additional comments" >> "$COMMIT_MSG_FILE"
```

I also set `commit.cleanup = strip` so that these comments also get
cleaned up for
non-interactive commits.

And this works for normal commits interactive, normal commits non-interactive,
merge commits interactive, but NOT merge commits non-interactive.
Since `git merge --no-ff -m MSG BRANCH` does not append a `\n`, these comments
actually clobber merge commits. `git merge --no-ff -m "Merge message"
BRANCH` ends up
having a message like this: "Merge message# My additional comments".

I hesitate to call this a bug because arguably it's just some behaviour quirks
that my hook script should handle. But I think it is fair to call this
inconsistent,
and it creates surprises for the user as it did for me. I would prefer
that `git merge`
adds this `\n` too.

---

What did you do before the bug happened? (Steps to reproduce your issue)

1. Add the aforementioned `prepare-commit-msg` hook.
2. Set `commit.cleanup = strip`.
3. Run `git merge --no-ff -m "Merge message" BRANCH`.
4. Run `git show`

What did you expect to happen? (Expected behavior)

The merge commit has message "Merge message".

What happened instead? (Actual behavior)

The merge commit has message "Merge message# My additional comments".

What's different between what you expected and what actually happened?

My injected comments did not appear on a new line, and hence failed to
get cleaned up.


[System Info]
git version:
git version 2.55.0
cpu: x86_64
built from commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: enabled
feature: fsmonitor--daemon
gettext: enabled
libcurl: 8.21.0
OpenSSL: OpenSSL 3.6.3 9 Jun 2026
zlib-ng: 2.3.3
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 6.18.48-1-lts #1 SMP PREEMPT_DYNAMIC Fri, 28 Aug 2026
11:47:30 +0000 x86_64
compiler info: gnuc: 16.1
libc info: glibc: 2.44
$SHELL (typically, interactive shell): /usr/bin/bash


[Enabled Hooks]
prepare-commit-msg
