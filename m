Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1829A0
	for <git@vger.kernel.org>; Sat, 30 Nov 2024 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732952967; cv=none; b=XHLCP1bc7kBr6Mha5IVWsyvABwPJ05Z9m/dLwhuHJRL02OLvU8Y4MsRG2ZrxS+p8myhb1eKg5MhvjaOKCAMX6eWTkRca83Z7y7QZkzydMN2wVbDLIszrCQnYD/ZrhxLDk7KssNafDZujEOKiBqNnK4hMgKJMjJAUkuYFqt/3CSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732952967; c=relaxed/simple;
	bh=EOE6qjeVkrSNlGs0WnsD9xa+quhXhVWuYe7QG1H2oq0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=I7TqzBt0QlaU9m2z3d0hwrA+8/pJQHsgFbaGFWt+diejVPtPbsmseZirSPdn6z/1y7JGzvM43hOh2XNBRnVI1Pcl5kDI3nGzMO1NlOn6MPFJ9/DnWaiq2UxPd4UB7pdRF/UIo3hFNHLolchT9Izks90J4XecQ7asHmiNLJDwjoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kA2sQ3OB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kA2sQ3OB"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa55171d73cso648080466b.0
        for <git@vger.kernel.org>; Fri, 29 Nov 2024 23:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732952964; x=1733557764; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4N3MXZrmQYB7Yo+DISVll5j/HVF+yht7bXKI1UKzfek=;
        b=kA2sQ3OBOtMAHwPgXr327s/FoIxDrc4FP9ctqTl13+AabSbzmT1PD1ogcAIDvOIHrM
         jhNavoLuFe85NCLnPgNcMbcVcIGsQ2q5NwA+Wq96lhHI9VKW37IRnXaUGzE2+PcBGDSp
         yzfpxVIn/93VyTDgN4jHFxDedhSOWG0vlOxQg1ibsP+waeJPIv9f3KuU4gfw/uvcgSLN
         Yr4Fgx6FtPhSWwAgGZW/MPDUm23Rphaj555v4+GiIiQp7advfeU77Xbkw/jcbxbWlxEB
         RUzMvXMj1SuFXbV/asxQ0W4AG27qWSNTKN0NLL4szpfZL9CCanzeBlnbjhABHOybhUcQ
         bBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732952964; x=1733557764;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4N3MXZrmQYB7Yo+DISVll5j/HVF+yht7bXKI1UKzfek=;
        b=JFgggneTnXqJ91YUsH1gCftcffjw6YrV9lhzgMc90tLo+XZem+1Zh5kvJyLTXy0sz3
         +ewDzn4rzz/7nv8ZyPDkXTTWNbWvfowvaZrvBNex1776BkB6ofVez/GSIn9jRFv9JXI4
         S9SgJnVnEGJbeNU+xIWZsIPaNo/F+XSHGIsPtKtG1jK0l4pL2Lr1TQkefNvh/HmdGQip
         o3rqImCZz7DiTO2Nu6fi8TIygslg2ModpnNaZAjQOxF+0iYQTztzfjtQmExQXxeVfk7d
         pYyAQSewBA7wh40dRjcP4Qb5MaG6WzZVXX6eL3ERaM1kjXgNV2SahqLMSiBe0Il7sTfL
         P2og==
X-Gm-Message-State: AOJu0Ywx8Jyj09sN3m9wDNul6/PURtyFuSucgIhoqfedCUiXcV+klx4w
	oact0vEddD7ntATuZDMXRxoUlBkUv1M76foChYpQouypMT1LW6msd6b8/c0Djojb8huaFGgmlgL
	a58NzkRSYLtYGv7Pbm/yurLqPt6aBK572
X-Gm-Gg: ASbGncvI3+bcMp+xpwdYTob6EFKO63VJzuJHCl7qMQpVHE6nOXfYj8PcjbK5D07501F
	fpOF+QLBJD6LS30p6vXtpTf7K9X/Stcl1kN9g3bIRA/f3LjbPX3UlrBY9SaAbKdU=
X-Google-Smtp-Source: AGHT+IGZmehISLDFE5Ggd1Z1Tg8R9rw8I0UnXpSshT+ig9refcAaWarfQZ45DdiC7MOs1vOLtE8+pQC4bkyyBHSPFGo=
X-Received: by 2002:a17:907:1c8c:b0:a9a:e0b8:5bac with SMTP id
 a640c23a62f3a-aa594708919mr791561966b.23.1732952964059; Fri, 29 Nov 2024
 23:49:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Nicol=C3=A1s_Ojeda_B=C3=A4r?= <n.oje.bar@gmail.com>
Date: Sat, 30 Nov 2024 08:48:59 +0100
Message-ID: <CAPunWhBQcAifapqxyq7nY+S5WWhZQhBKgeYLL56U1ewRCa7QDA@mail.gmail.com>
Subject: [BUG] Changing remote URL of "deinited" submodule not taken into account
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Recently I came across an issue involving Git submodules which seems
like a bug to me.

In short (precise reproduction instructions below), if one updates the
remote URL of a submodule while it is "deinited", the next time one
calls "git update" the old URL will be used instead of the new one.

Here is how to reproduce the issue synthetically (in a fresh directory):

  git init
  git submodule add https://github.com/git/git-reference sub # random repo
  git commit -m "add submodule"
  git submodule deinit sub
  git submodule init

At this point, the remote URL of the submodule has been copied to
.git/config. We change it:

  git config submodule.sub.url "new-url"

Now we checkout the submodule. I am expecting to use "new-url" as
remote URL in the checkout.

  git submodule update sub

However, the old URL is used:

  git -C sub config remote.origin.url # => old URL instead of "new-url"

The problem seems to be that the clone at .git/modules/sub does not
have its remote URL updated when being "inited" after a remote URL
change while it was "deinited".

Currently I am working around this issue in scripts by doing:

  if [ -f .git/modules/$sm_name/config ]
  then
    git config -f .git/modules/$sm_name/config remote.origin.url $(git
config submodule.$sm_name.url)
  fi

Any insight would be appreciated. Thanks!

Cheers,
Nicolas
