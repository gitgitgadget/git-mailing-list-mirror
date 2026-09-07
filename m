Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C29619B5A3
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788819184; cv=pass; b=iQ2OwPbgD2YN5w8h2rPEA6BKEy8BWYhiYGDoOHVquE6Eoysn8CTbHFwYhxu9A2x8VHRAS1jtlVXdeB3qeNa0KMsPFkvp97GzrvrFgj0V/uE8Ni5pgwPyhQchuftTL6txyyXyViZJcRMj77NJYtjwGZAyZuj8jBXnCA+G7P6m2Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788819184; c=relaxed/simple;
	bh=ad/fCbIUyYUkwFiJyzrJqUnI8OL1+v9bc0MRpt+e79w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fjkmEd+vP3iQH0ESBcHYY3ZR2DLVcOwpmxczd3NjKcnhzjdj4Fj/j6TY+qcspyDVGBl25aZp+VwbfFsJiiLjH58am35zRw2zOEjU045NrtabIQd+ghBKXSY90RmWftnLBKQH9hZ0yvGPjnSoDlhi3XII3HtyjOLdYTGQSvns4i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZ41whVl; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZ41whVl"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c28eef361f0so244066366b.2
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 15:13:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788819181; cv=none;
        d=google.com; s=arc-20260327;
        b=GHjOiZAoucwdFT/83C62+r4G9z3j/zqm2xWIzua1Mnz6h5hucKEAHjNS3XblLRJiPO
         b8S5iQUi5qp2oSxQQj/kQtHsCu+MAHVLl46/h2BcM3cL19NazvfxAOs2oZsK6VpNAQOq
         U+pEpj3i8kXVVNzTd69A72mFXIcEpRkTNXvJN6vM4u/hWEDuBidBMYHIeX+9H8X7JWAQ
         Ocm8tc3Rk9wQpRis6ETaD/ud+aqOoaom2NVdxGmmJUk55sdRKpPYFB50pADcF5HfeDHl
         jnLic0KcH9RdvOVbuCu3eHA+YUUJM0D4TLBKpqaHTVq5Zjbo1tDjczlY92aPs0GMwODg
         qfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ad/fCbIUyYUkwFiJyzrJqUnI8OL1+v9bc0MRpt+e79w=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=V7GEUETtdJu1dSb/m8GsQsWLWBOIbouJLGlD0ylNCUYfl4lhUdOV7+uDzAY5M1FNK2
         BWgcxkwZVAc2e/sqYgVutGdYQJp21xrmXBHZH0Jaq4dqyjq70EyXDJ8ucJ9PA+6AcvVM
         lDYdCPjnOTyjJyL09Lnw8atLbsr7kcb32buzycvIvKDdlboQjuXdftf2Wg6BDSyvhdvB
         vSYaaCNc1rLKAxOlKiiGFT/VE7C2/8T/Y+XOF6Wvz9ktL2eLhjuKZMIuxCLHFlKgTOOQ
         HGFpXv3Ew53VJAxZiGVQhpUPLZ9e29DPTeg9QtCdS6SUqxBA8DsWoPUqdDZC/BvXNiv/
         TTKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788819181; x=1789423981; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ad/fCbIUyYUkwFiJyzrJqUnI8OL1+v9bc0MRpt+e79w=;
        b=VZ41whVlY2wRObiWjquseWFrtNJtqL6HsEBCUG2JzgeL8tM0xisupUdiWGqyF3aXvt
         /LoSo88T6rfAf3MydPr39fjg7uteQmiLgbkzavGHzMHWzF+FEz+GLKzOgYjfwtxvjuyW
         76UkQEHzo9mEgYzpG9cu2c6HLOfOH+kZOz52l3Qh/EwolXRtxi48nFpp/gAIzLInOcty
         I9rpdDKIRN9QvcZVKMn6sp6kUgaenhZKYur8wR64GBNN7WFom/5Jz8MUoyzemKLbGoB+
         k0/HA4a/HPbQC7DXP3qqHtwiYYw2xqR/zT+3FTZKylI3yJk+FRn3nSkXzg2TGkQhKapc
         M9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788819181; x=1789423981;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ad/fCbIUyYUkwFiJyzrJqUnI8OL1+v9bc0MRpt+e79w=;
        b=i8xOw06BRabQrrr52MILTVxYKsjyD7yL+ncRjfjUVSodcCacG8b3lEZfUQWRyoenXg
         sYMkCtp9nxPLXLzOInWCHXUIb+sPk4vJ2X3rpNIULSj40UuB8lQnYewKPcdyA3S95+Pj
         dqfgsciJP3uto5xhYXK7cXeICmdRG0eGhVAmEN4FecX/atDGDU/x1iZjEuHcQgu1Iclj
         eFG2pnwIgVlEcyaBPYdBDpJLx6ao6IEX8nS8ODEYtTA9bATJZ81RrwqFUe75RFD7rYFf
         wa8kHEaL+52s6uPUWy4AQrnQi/4a1O7/HL8fYizdA3DxXy1wc2bGC4jWqwsM8hK2NepM
         IfNw==
X-Gm-Message-State: AFuF++mCPUZQ3FJEABlGcA6MWp3GydTy7eM+Dpoj+oEfTCeFGrya8RtO
	MKFFS2CmkQnzeL6KoV3i8AI30/tuY9+hc/8ark0Yz9zQtYfXxx2v/My2F61JDpGnxWQbKtphQo1
	x0zZCg/jNNb1+4D/X2QIu9AvRlzLLBHwg5YGpt4w=
X-Gm-Gg: AYBFou1yNY0Daf3unRHE+vgnOaAMPzCrZSZfyA5uQHOmR3PVTXGVtg6TkiiEuldjDm5
	rNHRZsOi5fKrc9HjAXfMLtojsBoNldwuf9+JnaATZX3KqrRDF4eFI9pwuDT2mPh3ykIOY8YYQeJ
	2LfAfZrqbbP0b4TfeI5IBci45NLdpj4BTVPj5zZJuxwQUjU3emEXx93BI7/bKmKqp+x8WyuYxaC
	fj7yzJChrN2gTPZVmQLP83Zhw6BfqidfI2gpnzW2ZsVPUEuiUyK2dNtrGMrnnwvyobbqJ58TmMf
	HJ/gzhyB5PWqfWpMCtuQMp6CbHGfeqQuEyfWwpRRY+BWxTz23A6HMzo8p62lUqpHK6SCKbXRFAd
	O3w==
X-Received: by 2002:a17:907:3e21:b0:c26:1691:b360 with SMTP id
 a640c23a62f3a-c263356c28bmr554816066b.25.1788819181380; Mon, 07 Sep 2026
 15:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul DE TEMMERMAN <p2trman@gmail.com>
Date: Tue, 8 Sep 2026 00:12:50 +0200
X-Gm-Features: AcwNN1U0Wmy84YdA5MAFmVQcZgNi3fYOEjIX6kElT8OyHMZwGIE9HDk18pCBJ08
Message-ID: <CAN=ULkdkRqnt_TP_pawiuuhod-_XVU=uDovYNMjbgQQ2jXQVpQ@mail.gmail.com>
Subject: [bug] git worktree add deletes my entire directory
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)
git init
touch a.txt
git add .
git commit -m "Initial commit"
git worktree add "" HEAD

What did you expect to happen? (Expected behavior)
fail and not delete my workspace

What happened instead? (Actual behavior)
failed and deleted my workspace (including the .git directory)

What's different between what you expected and what actually happened?
Git deleted my entire workspace and the .git directory.

Anything else you want to add:
No

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.55.0.windows.5
cpu: x86_64
built from commit: 32c4f7689275d233577576630e1ac5b7eb354eb0
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
rust: disabled
feature: fsmonitor--daemon
gettext: enabled
libcurl: 8.21.0
OpenSSL: OpenSSL 3.5.7 9 Jun 2026
zlib: 1.3.2
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Windows 10.0 26200
compiler info: gnuc: 16.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
not run from a git repository - no hooks to show
