Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C18C2356BE
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 05:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774763173; cv=pass; b=JR8eR99TYGbuVwBlVkb1VE9anzmuSOVWI16zXOIoFPhUu6U2TX57Z8DDD7/Az7LCHvWWm7zJ4BWNJwEFZtOiE9mZ4JA9dmsIUfNx5SoXPA3w1FPpKCdTKVDNRjjcHpztlsRDo2UnRBQgixq2wy2573fN383dUtRhjM2zvzfRWzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774763173; c=relaxed/simple;
	bh=b7vmw/lALuuoMHXo/GIl+WzzzA9FRY8TUztvtmMvBSA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=b6w1XyFCSWQiVWAbcI3pUVbcT8XjEOJS5WndwDpvIWaF5Y5jj6w9LeANx3hw7G0eG1hDE+FmjmM7aqfTmcQ4rbHLz64G8+JXFiIfl8I/oNL8fTNeuzmCXZszgRZszM+NBXAWEzmTn9LWLu/RqEhgrWPiqKRvlTuKlp1rBG/ADz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKUqj8HK; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKUqj8HK"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d971fbcddso380992a91.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 22:46:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774763172; cv=none;
        d=google.com; s=arc-20240605;
        b=VhzFOYTqxUEASzuNibRL5HSV/sAIwbhsEV3VYW1Wy8/bCGBbTfFB8e9qaxov0Xp3zG
         5cn3zql23hzKd1gOkanwVp7/dcC65qSnPEN/9SRlrpkzH+BxqYiIFcfCL7WeTgvN2p7H
         0Z8HXhde+XysvK7UEjEs0GqGJKda/Wf04+J5L6sYVulE38Tj4E7fxFSbt5OQwpzxJwqv
         X3hgPKsyVkVStFcRmhSR87nMA3fhUG8T6oQ5LEQMbHeMYn3kAZt9GB3NT1yen6yOWG6H
         xFjD8zcLN5zXTzsaWdqXOVsjQVohs856OTBIWGBD2XFnkS3CgzJNPKQYiKMlX5/sXS6t
         lzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=b7vmw/lALuuoMHXo/GIl+WzzzA9FRY8TUztvtmMvBSA=;
        fh=sdOBzv5tNwYsJRNqYjg0FmMwWLtV8amkofXr5Pii9CQ=;
        b=Ga56TgL16nH6G1/IU8ymsjpYDHehruVMIlsDXuDggJrnyYUuoxccegfYR7ksijO5Ym
         /IlievOpxS/TE3OVj3FZT+yUqFpEfi0Id0NOlRWmq6hdTw6GanC7w9ru3DFvR90Jbw09
         OHyIboCwkY9iZVTNeUjZipQhFDDpRxhodORSDXi+DJvijc62MzXLthy6hTkZIM/voPsN
         2bvBDlnFZY5/cqA+KKfvVQIHmw5DNoV3Rbg4fXpGtKmW5uOlTnNVipJrMO3hBWBFXMEq
         gTCoWBXQPr0wutBTPWGblCNNH+7tWW0DBuvG0a/ZVT4ZNdOH4vf6XLfgSY36M879nAl/
         tGtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774763172; x=1775367972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b7vmw/lALuuoMHXo/GIl+WzzzA9FRY8TUztvtmMvBSA=;
        b=RKUqj8HKORZ2Xc3mdZcgp4w1QaZfxMwheXFT4t1pfkMHR6b14sMa8mnx5sxAOwV8te
         ybe9MJYWXjfYumBLVYy/XkOLzTfHMjrKzk1pTNwrdhj6zqhJGuMLx9O4VwtvHL/TsjP5
         52SJRrqkK0LTVXRDlWQwS29GIUNptLvGSLNUSwlD1nD/5q2aKk/eo8GParkORy0hqplj
         QA5boH5CXyKoupdQy9jdOjVZcwhdvlg1AfaaKe5QxWYtMzwodDpc77NMjBfZ/6Tsj3vv
         WTSeowXkDxjUTCFv3Mfov9Ny0vgtp4CiGqgQMgA6lZIzaB6Ij0KpMKiNgc0BCcYaqG/K
         37XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774763172; x=1775367972;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7vmw/lALuuoMHXo/GIl+WzzzA9FRY8TUztvtmMvBSA=;
        b=c29rAEuPjOvgCgns6Ms+froWOlSBtbGWpAEp4FbJF/R6N1C9qC8ILGAZ5fLWVAq9u1
         n+M7RrjMIM756XBqNRWvvnTOxGx7PoYHXg8OuoXh+GRSAy5/7sAL3DnFZKD4zpNpzvaN
         6SmgZ5iQmZih+KfxLGJU5E4CA84jTi86u8HNCWmB8GbcIpQ75Le7hekMo7kL85B0qnpb
         +Tpzxrpz3+4u3f9nsy5sTOq7XgNpxkrErdyJmozy5+8HdNDDL9DF0praIggQsVRyLIIH
         2zAsXnjjAb+rMGtEQTh2EEIAEt0u8toiaAAr8tgc8mY1iz/6mmA89QPkYhjqw1Bq4cU7
         HTgw==
X-Gm-Message-State: AOJu0YzA1KTzFUHHo0TFYNFk4+TGWgFpkgazQxLoOK7Ot5uBaGl5iAxa
	cZzPxTZ5mLh5/7q6R3Irn6LJBMnUDgbsfGOTWbA6Jqz85nmBNTOHNW1dTDP7C7iIpQV3DlvsnQO
	UbZ3fPYf5C3/Vxhq5v5YveX9Q1wTURKAvNT5vEoz2zaNM
X-Gm-Gg: ATEYQzwaGY8spTt0j8G09wdqWTucChil/tzZTjI3NV43ZU2MUk9YpE6ysOB3/pQXh1b
	6oSFCwfUhAqajo9CODDPNnUmL+iw1114C0uGAfX97U5Y9NRSFYTw2O2QF540DyXaPMQS1ec45li
	7mX4jmYk0RmMFH9u3+MGwgYViUUXWWaLC2L/b3hp+1UCx0WMeVLYzLwI3Kcroh58hx+w1Y6/ucC
	YiMK7PgalA6mVZQczOYtuJvUXwol8MdylvaMo337uaEtvtIUXya6Ybs8opdHMUCPYGoiOENpy/4
	HfS5/DFj
X-Received: by 2002:a17:90b:390d:b0:359:8df1:8553 with SMTP id
 98e67ed59e1d1-35c30d78e17mr6056186a91.9.1774763171471; Sat, 28 Mar 2026
 22:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Noman <necrospre@gmail.com>
Date: Sun, 29 Mar 2026 11:15:59 +0530
X-Gm-Features: AQROBzB2bi3Fqosr-8MHu5q9U7FJVJIrqMSvG9tlJitStbJYdwsL-k9FHMvnAS0
Message-ID: <CA+TqWtVvEyJA0QzsGh1igiRdwufopfpvA-+=_nCOWFHNk25uEw@mail.gmail.com>
Subject: [GSoC][PATCH v2] repo: use repository parameter in get_layout_bare()
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Siddharth Shrimali <r.siddharth.shrimali@gmail.com>, simran@kalvium.community
Content-Type: text/plain; charset="UTF-8"

Hello Siddharth and the Git community,

Thank you for the feedback on my previous documentation patch. I
understand now that 'fileX' and 'fileY' were intended as specific
identifiers in the examples rather than typographical errors. I have
withdrawn that patch.

As a more technical micro-project, I have refactored get_layout_bare()
and get_layout_shallow() in builtin/repo.c to explicitly use the
passed repo pointer instead of relying on global macros like
is_bare_repository().

This change supports the long-term goal of reducing Git's dependency
on the the_repository global variable and making the git repo command
compatible with multi-repository environments.

My patch is available for review here:

I have also uploaded my full project proposal, "Enhancing the git repo
Command for Machine-Readable Metadata," to the GSoC portal.

Best regards, Naorem Ngathoiba Singh
