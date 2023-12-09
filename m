Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aqk9PvMn"
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01CD137
	for <git@vger.kernel.org>; Sat,  9 Dec 2023 03:58:51 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1e35c2807fso393616766b.3
        for <git@vger.kernel.org>; Sat, 09 Dec 2023 03:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702123129; x=1702727929; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IKppPt88MY/OFOdkwqA2DHKMm/+kAXVKHxirMDeh4ic=;
        b=Aqk9PvMn6nUmTOMVpV9MTn/1XnER0A8U8ccYcLz0mpf10nQeSZw30xd4c0fLK+sssB
         GFz+yLBpOrEax7AVJ/xJ2+Qx+crT1FXnv9aKQHRo3AwvvlNGLmJNXUVPVHBPENzQ2yZ3
         4TzNitHvOb9U1BIhmCJbCiZ9dXAFGTu9Hhq54SooiSGvVj+ispPZgh0NdcZ4yKD79eX9
         AXC05j/ywvCUrjjz7QkUyuB8CKCHHOF/lmbZ0OvETZyLJHG2hzIWvBfeUWCLzWzmiYIB
         p/KrvwKkboYFh4Zdy62zRKtYqBqjrkxe/opevKaU9NaDxSJgiWI/unmhQSUhAWiyiu8P
         T5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702123129; x=1702727929;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IKppPt88MY/OFOdkwqA2DHKMm/+kAXVKHxirMDeh4ic=;
        b=PuRqFStEAAiZZsWtoYNqWQYqEeB5oBLYuBEDZP0Vs5j5eCzO2p1iCT87hwgfssGdeW
         apB0mri8X7PCQeD92XmO9+iydFSNgflBi81vmVfrLpY98j7yC5cIYpxeMSHpbB6Qzvwl
         zGWhN4m2Rxi3AjNqkBgSVneIyd0MODSFz371ZuYFpuLZkvr8nMT4p41yLkrBKVUzCLKq
         nLwTpdQWaGSPx53EsK39DwcE8fzRHSxEId4Y+Q9Hg34yHxHqXRiNhFzuUE6uRl4i3mSK
         Ja6RxjO8JYhjP0LTn13DcvKnNuf5uoZC7wbmwwS6mCLGHSXYEZCAxqO6UlMq5C9QXd9c
         6nqQ==
X-Gm-Message-State: AOJu0YzXNHQLeAJPofbeY7maFO3nU3/isTlXFzS0XWzWRVc2d8lgfinw
	gVtix7UPVhzMCQNqMn+pJW7SCxHsnp557/USqDNL4edPF9A=
X-Google-Smtp-Source: AGHT+IHWDEBLqemAtAMIWtcHgmTkEQF7Z0z5CQ0msUG9NtKYUXdwv/ddGX6Kw+EG5zwgn5XfpxDWL21F++hRf/L4zjo=
X-Received: by 2002:a17:907:cb0a:b0:9e4:a597:ffe with SMTP id
 um10-20020a170907cb0a00b009e4a5970ffemr574556ejc.44.1702123129308; Sat, 09
 Dec 2023 03:58:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Britton Kerin <britton.kerin@gmail.com>
Date: Sat, 9 Dec 2023 02:58:37 -0900
Message-ID: <CAC4O8c9ieZC4SBJf54ZuTfAvnkhGuDaibBQ-m9Zw_n5VhUFPag@mail.gmail.com>
Subject: [BUG] git-bisect man page description of terms command doesn't
 mention old/new support
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It's a very small issue but it seems that git bisect terms does
support --term-old and --term-new options, however the man page says:

    git bisect terms [--term-good | --term-bad]

The description for the start subcommand does document the support for
the more general terms correctly:

    git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]

so maybe it's worth fixing the git bisect terms documentation.

Britton
