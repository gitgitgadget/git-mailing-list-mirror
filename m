Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CE8B646
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 01:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723857101; cv=none; b=svpqpIFnUuccYiGj9y7IAvsT2pxWQiRX83H5oTevieexOWU6l3m0PEsfQvGwRwzT4zCeg8anhoJJuf3LiLBqpvoNBlpHHQDGfQ+wpU5COXansKem/ywPvo2B2ZJBPbYPOJDcyJiU3I2pD58BplwoA/GAGkCMOuNPZP33+Soaiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723857101; c=relaxed/simple;
	bh=hn38+y91xEpUu8B31HHeW2R2YXkDiSUWknyhyJE2pFM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fE0IGiOn8gW2t6yFiI3o4KZDND1GCyUwLgU63pbOdlyAq6kAEI7/BqM8g9Dq0MZe3a2J9sQSbFRaiMWnGgvPg65nUQKcAaN1WojUN5AZtLMYlT4VvEf1t0bRWnAJERemlJ/NJLniOA7Rvyz9wuwVMeEMXIY8iVtSrOcvZvTMcJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cErU9jf2; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cErU9jf2"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e1174a648d4so1612991276.0
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 18:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723857098; x=1724461898; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qTFn3zkFLrwdJe3Q+vpMzErrsqng1cK61jtQqyP5lTg=;
        b=cErU9jf2aGKdUFoJBryQp7kK/q/EIuC7JFPHfWYSpFdyvX/BnalGmX86tjvq55CXud
         1j5FgBUtz0KFYGUqDqkY5oyUic1pxDJ1Gwpgvcl5euXrK0I4/zHClMwXDpjzIYMvhrJz
         XV1QkUz8clWKxAJtwkqxDxZYSTFhqQNIbserIP5l9nV6pHVFfBJM9J2y2hmuun1NuNAT
         YVAzAA5RiRlV6ge5gUanIMzXrfY8R+QIcOfhMY0Nlb8nWqLgekEHJCkIr+8CowZmR4o2
         vSD8nODjNLV2IQICGATuERFo59zM3LnOi6tJD6C96O8aFLJ1d2u3mhV3By+l/KiPt0Qe
         7YGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723857098; x=1724461898;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTFn3zkFLrwdJe3Q+vpMzErrsqng1cK61jtQqyP5lTg=;
        b=O93JXNyHUgGZFxUn6rF8VlH4C5MTm5JRXXUO6D8xPtnBEegY//dpIn+39lfjqN8M5B
         GAojoxK1QlMcy9E43NCght9ddoUINJQ75elIugOZNRYtHzsZq+VJc6WJcKNYhcK+rSVX
         QUPjkgMHZyMIh+fAurah7cjm7w25ZsaXTAk4zH97a9lT13o6ZiTL9WyxanQmWpPIdFOj
         l7qjrd4MCeLPRQyLAQWeP/LjDDAUjVzGD7IOMsYUmjGRNvSVYC+yZVr+6Kgq1e20QP8D
         /EK2/crejCQUdq5BG0TKxGlTb45sZoAJglEeAPgVP3TjewcRjruOXl6u3wj54G8cS+Ie
         jEKA==
X-Gm-Message-State: AOJu0YzkqCk2wij1T5FpsPgpEFP+NysYe5aj24nJqMKL6P56hp3RUuQR
	1GNS56FtTh9NT5xlujtv7W12tGuNj6rJg8TIVdpE9ETCPlyLzjJ4vlrgthvaZgI3jQFmhtQeA4u
	EQ0wPL6QULM4NpVEySlZA31eNR+R8DadL
X-Google-Smtp-Source: AGHT+IEm13h+AYmPx3XER9oqb699oNR+VrSdk3akXsVytys8RJHwd7sZIzU6N1oVV5ILuPVVaiySsVTvMkuP8VJS1nM=
X-Received: by 2002:a25:b102:0:b0:e11:7f9a:1b82 with SMTP id
 3f1490d57ef6-e118c4f5147mr3878498276.14.1723857098129; Fri, 16 Aug 2024
 18:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zdenek Wagner <zdenek.wagner@gmail.com>
Date: Sat, 17 Aug 2024 03:11:12 +0200
Message-ID: <CAC1phya475QkpfLp84sb=2UQs+mFos3OhuHDjmBzboeDBbtjtg@mail.gmail.com>
Subject: git push does not work over https WebDAV
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
git commit
git push

What did you expect to happen? (Expected behavior)
The changes being pushed to the repo via https WebDAV

What happened instead? (Actual behavior)
$ git push
error: Cannot access URL
https://userfiles.math-gnostics.eu/git/mg-software.git/, return code
22
fatal: git-http-push failed
error: failed to push some refs to
'https://userfiles.math-gnostics.eu/git/mg-software.git'

The credentials are in ~/.netrc, git clone and git pull works fine on
all my repos on the same
server, git push returns the same error

Apache error log reports successfull access with the GET method
(clone, pull) but "user not found" for the PROPFIND method

What's different between what you expected and what actually happened?
git push does not work at all

Anything else you want to add:
It is apparently an issue of git which is not OS specific, I have the
same behaviour in Fedora 39
and Mac OSX, both having git 2.46.0. Everything works fine with git
2.44.0 and earlier. I have
temporarily solved my problem by downgrading git in Fedora 39. I have
not trid 2.45.0.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.46.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.9.1
zlib: 1.3.1
uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Mon Jun 24 00:56:10
PDT 2024; root:xnu-8020.240.18.709.2~1/RELEASE_X86_64 x86_64
compiler info: clang: 14.0.0 (clang-1400.0.29.202)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/bash

Linux penguin.czw57 6.10.3-100.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Mon
Aug  5 14:46:47 UTC 2024 x86_64 GNU/Linux


[Enabled Hooks]

Zden=C4=9Bk Wagner
https://www.zdenek-wagner.eu/
