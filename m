Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793865272;
	b=AGQDpHtnTp+z5RvUI4i26HNq1td73TS7QBDGPMDCi1uQJEWxSn4BlER2Y0CNyjDKkNQN
	 SHw+WBIn9MUN/F0vWQp4gFf4qwtcLgCR44aklcJmB4OIElpQiQU0+OObs/wOcQI9c6g7i
	 3rMJd3c/ORhiLhAEROGSHi23d701Y2KcqckIa+GW59S5vEtpo/EF6hbNG9Y1tDfDGlqGI
	 K5vG3T+oHn3UCiSsNHCgoj8YCnDvH95DS+BD39KuWeUOEUB8NDYZQwzeMgkn63hm8Bt/6
	 GZFue/9x/453JD8uoroaR0+GiKly3WugGkAECaH2EQxOlkaarv72+aa/e2OHxddxbuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865272;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=hv50wIvXv+OaGhUAypZu0z8OLhCjL81/xRtKE3Z0aOo=;
	b=ve+Vr2WaBHFZDEnSeAjdg1v47kUvcKi2q2/5N5Ndp18FZOxT3GuWrdzx+Pw7l9WlKdWr
	 0Te2MyzpVzwM0TT4LP/Aa+bYT/LgXbeNmrE7gos2ockrjYYyGAMyJRxFrqWKcElMgdSIF
	 B62ulYqNK0xV/iG6Igww2nkjYrT2yxsMTR1wDW1nCw2UuVmVM+LwsdExica3GCYE8WDzE
	 +ZkpdWcqovc68sHfYffggdshdATfC51UMUMYKFAsl+DJzrg40/rS+FovbNdbRvOPiLIGT
	 TU5+HatMkzLq6g74v4+YdqR3MJKwkKZINrRUnxlCxkOAKXVkzU70crH/AbnE75WPfaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uUxkBuQR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D608A606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 07:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D608A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uUxkBuQR
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6b8e2d8df4fso1064703eaf.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 23:54:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793865271; cv=none;
        d=google.com; s=arc-20260327;
        b=fKU/pj81ngGubwTBDJ/DDX2btsQtvH1bXFghqRZKFIYCcyjx7apnxuMBVc4Q653L3s
         Clbwpe5AL7fIw6pBESMyaup6lRdLChK2fRb3mwdF+DM5teITZT282PQMQDk/0/Xuwb4H
         ukUI/E53NNDjVKyPH/PFTKYkvMwiErMaCjMY0v9/DsuFtd1EDieEEQirLtbeWCi8ljsm
         C7+H7EktrT/tR5sB+wb+nyEqVWN3/ADoRwfQwAtYABBXZIxYgY6uElBCuTzP79mD9n3p
         2WocgSyYZ0CDMyCE41S22RIjahflcegbzZjDWIg3KOhnADsDnmxWMhAooTrifd9GBU0O
         gAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hv50wIvXv+OaGhUAypZu0z8OLhCjL81/xRtKE3Z0aOo=;
        fh=EFAbs8bken/lde374C0VbagXTe+Vybowy8xMB0P7EHI=;
        b=ZTjP8/xGoh495vUX2gZKRJiuISiJZHdWQD+LjFKwBCy9/10vfuB4w2OB2f3IN7MFtt
         Jx8jxNc6rKD41Zq8rWkgYRfOgYmPEpk6oQ6g74YsL2UCl4TtsPpT9iBjlTb4zvsSxYav
         37attWIlgybuUFc9R9eg5JvfNCOfs7yDMqhaEzMBZAtTpatdin8xivhDRtj7F/Fg17bH
         MdmNhrLc5+P89z8vFOyIGaeBe8pt1BeNhSuViNufwH5cos2nk7RzwGkaYomFrmC7jeG9
         140NYjJIkVlsfam7W/Pg1x7TaGPgrAkhty0hOd/yWJl4nc3iqHl99kq/aRxhSYzxacZe
         YfjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793865271; x=1794470071; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hv50wIvXv+OaGhUAypZu0z8OLhCjL81/xRtKE3Z0aOo=;
        b=uUxkBuQRsPkpwaDSAgImzd+TvF1omgKMczA7G9XyQvvEjoWAI7iyz+OvzduOPPc79m
         OyNRpH8oV55QLPquAGEoNaw1MBkEZC9Th3Wtym9S6xGLtJiQ23Mbz5BwYJ1GaNDn7J8E
         3nIJyum90p8LBhWLutTCeIczCPgyoMPRiHh8hi38eCpGgpYlyL+GzR6QLIAo0ufhVKcl
         Kjv6zc7rPMqrwDg69QW3mgmBu+SYQ66XVRHbLEFffG249Wts5pD03CVFLJD7BCTYtOKP
         dHY2UIfFd5vR7gqQkyqtPODwchkWbjIF5PNp6jpDTReH9v5AAHM0xqFMUolKTR+CiABF
         anog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793865271; x=1794470071;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hv50wIvXv+OaGhUAypZu0z8OLhCjL81/xRtKE3Z0aOo=;
        b=fZ7mFk29jn3wrdbCa6I/A2o0gtzh7LZQgQPsbJ+L+6qAsbXe1FZLQ0MDaZ2fJX407K
         InTzLJjFhgRr4QD7T89ZlAAjP/IIW3gzlxuKsaoNi6fkpOK1/KMmD/niNM1HCRsc2C6r
         OtkyY5T1DMYSsxYx7tej21mpnWMwrP56/1sBtpjyK8ikvKujvvPpM4/o3yxG66LEBVPy
         vGGlu67HlfCe4BFkB6UgBOjtgkTjL0RhB5hKcqUHlSIcLGhLgz4E/iU3KKK1XDVDn8w/
         uaqG6YVxiLdrh4GQhG6f9Zec53FhD70PuPDQabgzS7W1A0FIX8Ko9ptdmkkTS3VfKXi1
         KIyw==
X-Gm-Message-State: APuU4Z/+DzmLM6EXBFnYalgQMVeFA5t+4qk+0HO1XrHPMFgTlDNtA5S6
	SGg8tMZARDgQBzQKOpiVcpgf2920G+dAPVpQVv3yg7zFpqbkJZ5O3btldP1/JIJ+ViN7mTJMUgg
	1v43f5aF6k9MOypFRLxdd41YE1cFR6Qg=
X-Gm-Gg: AYBFou1oLh7fgiAu2GQ1RZYmlapgxNJD7b6qxjfh1jPkVcv6BrT3oUm73q/7NOOlh2g
	Ezjl2iFF/IBzbpGt/N9dVODpmSJ/4UD9IfsYxTokGrHmX80d8STTF5Q5Bmhn7YCSlgctJ8jBeAX
	O8YhtZmK8TJj6PIAMTzmCRaBWkLNgenP4CeYI/RbSSjSkL9c+bpb5pj3Z5gwATW63NTJsVnYEEe
	fSsbcj5YJf0cTdA0rICfn+X7eI4EU6V/X4A8ZKfr8KY1r4UlXk7ANHtAz0HKYP5lXWMpGvtDVGQ
	edb7wn73N0NlQw8KryM74soShrls9HDyRSzLmOoIfOoFI48/z3l62Ryo74XWH0zyRAOh0EXgBDy
	Ud1xVFjPh5kdkWAJlGqNZzvSwHd9Mi/ucsxhCKqBUAq8Osy+HHMK7vBbKTt71xnUZztQRi3jxGi
	sQE5p7ypYXpnxeV3R1yZKyjoCRx94KSfd896AEs5B0cV+wXipnSFpoADM=
X-Received: by 2002:a05:6820:2215:b0:6d9:979e:22ad with SMTP id
 006d021491bc7-716d26a6714mr1271839eaf.54.1793865270672; Wed, 04 Nov 2026
 23:54:30 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021172458.6373-1-azuama69@gmail.com> <20261026083055.18873-1-azuama69@gmail.com>
In-Reply-To: <20261026083055.18873-1-azuama69@gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Thu, 5 Nov 2026 10:53:54 +0300
X-Gm-Features: AclHuK-FoPJ5VkxtzRjqoY1XQECn4muedt5p7-REa-idqprEEDv1I_o6rPgPmxM
Message-ID: <CAKrRMNrnd2+HxTxadKaha+K9ASWi_oN4h7gdjVYAGmyODwmi=w@mail.gmail.com>
Subject: Re: [PATCH v3] rev-list: skip --grep argument in early scan
To: Azuama Odinaka Maximus <azuama69@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>, christian.couder@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Azuama,

Thanks for working on this.

I applied v3 on top of master (0ffa3e35c7) with "git am -3", because
builtin/rev-list.c has changed since you sent it, so running "git am"
fails. Rebasing on master would help. I built it with NO_RUST=1.
t6022 passes, and both new tests fail when I revert only the change
in builtin/rev-list.c, so they do catch the problem.

On Mon, 26 Oct 2026 at 11:30, Azuama Odinaka Maximus <azuama69@gmail.com> wrote:
> +test_expect_success "--grep accepts a pattern beginning with --" '
> +        test_commit --no-tag --missing-only &&
> +        commit=$(git rev-parse HEAD) &&

These lines are indented with spaces instead of a tab. "git diff
--check" reports "indent with spaces" for all the new test lines.

> +             } else if (!strcmp(arg, "--grep")) {
> +                     i++;

This fixes --grep, but other options that take a separate value
still have the same problem. In a repository whose only commit has
"--missing-only" as both its subject and its author name, with this
patch:

  $ git rev-list --grep --missing-only HEAD
  <the commit>
  $ git rev-list --author --missing-only HEAD
  fatal: --missing-only requires --missing=print or --missing=print-info

--committer and --grep-reflog fail the same way. In revision.c, 19
options are parsed with parse_long_opt(), which accepts the value as
a separate argument (--author, --committer, --since, --until, --skip,
--exclude and others). Should the early scan skip the value of all
of them, or is there a reason to handle only --grep? If this only fixes
--grep for now, the commit message could say so, because its first
paragraph describes the general problem.

Also, the NEEDSWORK comment just above this loop uses "--grep
--exclude-promisor-objects" as its example of what the loop gets
wrong. With this patch that example works, so the comment needs a
new example (--author would do), or it simply becomes misleading.

Thanks,
Tanga
