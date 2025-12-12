Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C379D2D2488
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 22:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765577682; cv=none; b=Rn+JUif5+GVx5/P5ksbGoS5EPfUnHeXlDJvPOpJnHKvbFujEACVcX/gKFBBw/5HdKWe8UtJ0f790HAjO+Q3Cd4YHsIieSwGR/xZDCmApDhx1gJ1BWv7uWP9f+ev5pdzyvHZgOeTxZnapdua/RHGBgz4c/eERn2h8r/XPzQzgL+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765577682; c=relaxed/simple;
	bh=uV1deLpoxP/j6u4wwVLXo5QgVupSa0ipCiXOee0G9qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+WTVUL+wJtTkT7j702wNgfKgzYJTdH9goSM0NZv8cFe8n1IQfpg7GMBDomWeBUWjv+H0Cnd9PnZ5tqXIf8XAaH4nZUehLVz8D0UgdB4uvZBpPp8tUJz94+oDYQRQ0aR+krQRulikdDN01VNWHRCX6VsUAMPVfKHb6zkn6JpFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiLdYH6L; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiLdYH6L"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-298287a26c3so20234255ad.0
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 14:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765577680; x=1766182480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSQAUopCobw+qrA4b980uwmPaiSYFV2PPXXwn+LgEqs=;
        b=HiLdYH6L/r+ERA+PEiTWXt/+eCDnt7moOL+M4LTed6VA6ybdLobDrRu1X8fSkUflAr
         XcPMgtXulzZZVgL6GxJIqt/h6ztXaYh9mxYF3BQEjNufkf6WjVZVzoEz4Sm4+il+gcbU
         Mhi88kyj0szYR5Sui94XgIUSawjBjFVW70+wlIqVSPd3qjPmqxlW1/X/bIpjO4a068ff
         qelGb0kcJbxYML3W6Gx7G6+wcDb5P6O0PX+SMapm1HpbmD0sxMQk37YpbQYXi+YRPQul
         EzJQI6xEmeCtOzr1iW3L3nCEEwvmt32RI4cJAPaxnvJ9oSFTy98GFkPl+ZMnnQp03H7B
         MRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765577680; x=1766182480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pSQAUopCobw+qrA4b980uwmPaiSYFV2PPXXwn+LgEqs=;
        b=Tfi1mjlnrvHAbFkl01rGjvwR3OtP3Y+0Ml0Evhh5SYsSfGi5wbGzi2I6GsJiO222BD
         f+iqqUa3LzYVkuVuURDzFwvHS/L+/FfLWz5LpNEiIqxDgFEhf9Mf6VCPAUacHLD/3NMZ
         s7Z+vR3VXT1RqTJNuJ5LA6/db+d66csbi5bCjidEuB39ZYsN9oULq8DnMmrGniQsS2yb
         +bNsDqxa5zVIWjc092yba6Hg8Qt3I9gQFEVyDPuYSoo+b1A4Gvcg3MDbwqeJEHxK0kAX
         cPwHdAUlOW29dUWR6SphR115PQ2/3vnIdWPg8c7zvv9tSI9lS7jzaILVr4y++tb598vG
         A/rQ==
X-Gm-Message-State: AOJu0YyTFepe2XMgahbD0zLyXCrL5V1PqAEVjYYN9NtfHUDx9Z+HyGOa
	V568hqhVFLWpg7smwrO+lxjWBybsebVhcJDva5aECYClLq1mOO+5G/ZY8omXhSBR195YgPPJEQj
	WcCbkNWNAYiWvjtIiHwvOLfRjBfowD+x1pyD5YQU=
X-Gm-Gg: AY/fxX7cRm52e6gxZzZLHlNBCHHQd663EbPFx3EbnVobSK7uo3uWmCC3dmWIzSfDk3e
	iqaCvmUL2WFBSLLMLCjjxut0+JqAxJqN0Q48EkEcZvuOwNNz9xfoggf3k/o7CMUYDZy9JPdOrlB
	/omUZZb5Q0dv7VWog5Eb7WbsNhYvI9QNykk8s6/c08WEN+aGDesqxlbpHDoAvx5xxMef6nJmEt1
	kBU7NE5l/adLorq5J9Q9gBcSb5ElKLyr7CWfEXjr5LtsLKLMDN5e8Z055I594vapIM2aDu6J2Wj
	waE0h0Y=
X-Google-Smtp-Source: AGHT+IHNLzMNxVMX9UyiZsUqhGPbK9R3iY031yNsjwkTr1lNHWbBNP9YGQ+5LJ2yM4QNpzjvAThsnvwthUwc3rQa5sQ=
X-Received: by 2002:a17:903:283:b0:294:ec7d:969c with SMTP id
 d9443c01a7336-29f23cc4649mr37817045ad.49.1765577679919; Fri, 12 Dec 2025
 14:14:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a5wKtD6Tn0gzcba1IEUhukYnXPHxMwPq6puQKIPywmjNufi5vc6vX-v5BpPJ7qj_zZsuXF5FiS2gbpsurWmVjoWHtMm8A-kAbaZyjMfrTcs=@proton.me>
In-Reply-To: <a5wKtD6Tn0gzcba1IEUhukYnXPHxMwPq6puQKIPywmjNufi5vc6vX-v5BpPJ7qj_zZsuXF5FiS2gbpsurWmVjoWHtMm8A-kAbaZyjMfrTcs=@proton.me>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 12 Dec 2025 17:14:28 -0500
X-Gm-Features: AQt7F2p7P8f1fiRgeIXHBe69phUmIdWc3Npiv7YA3rVJ-4E3K1ZrjpvoAQNH2go
Message-ID: <CALnO6CC=JpKBwJbLDeBkEF5e3SnqzEXwNH_W3S5Bzhz3DD14MQ@mail.gmail.com>
Subject: Re: [RFC] reset --hard: warn before discarding staged content with no
 commit history
To: Koutsouflakis Stefanos <koutsouflakis.stefanos@proton.me>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 10:04=E2=80=AFAM Koutsouflakis Stefanos
<koutsouflakis.stefanos@proton.me> wrote:
>
> When running "git reset --hard" in a repository where staged content
> has never been committed, the staged files are lost. This seems like a ca=
se where requiring --force could be helpful.
>
> Reproduction:
>
>     mkdir test && cd test
>     git init
>     echo "hello" > a.txt
>     git add .
>     git reset --hard
>
> Result: a.txt is removed from both the index and working tree.
> While the blob temporarily remains as a dangling object (recoverable
> via "git fsck --lost-found" until garbage collection), this is not a
> realistic safety net as the filename is lost and most users are
> unaware of this recovery mechanism.
>
> The most likely scenario is a user initializing a Git repository in an
> existing project. They have a folder with files they've been working on,
> run "git init", then "git add ." to stage everything. A mistyped or
> misunderstood command later, their entire project is wiped out.
>
> Proposed behavior:
>
> When "git reset --hard" would discard staged content that does not
> exist in any commit (i.e., the blob has no reachable reference),
> print a warning and require confirmation or --force:
>
>     warning: the following staged files have never been committed
>     and will be permanently lost:
>         a.txt
>     use --force to proceed, or commit first
>
> This would be consistent with Git's general trend toward safer
> defaults.
>
> Questions for discussion:
>
> 1. Is this safety check worth the added complexity?
>
> 2. Are there workflows where this would be annoying? (can't think of any =
but I might be missing something).
>
> I'm happy to work on a patch if there's interest.
>
> Thanks,
> Stefanos
>

Perhaps useful for future readers who are looking for ways to recover
the objects: https://blog.plover.com/prog/git-reset-disaster.html

--=20
D. Ben Knoble
