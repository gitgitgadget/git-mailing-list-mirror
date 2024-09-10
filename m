Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8360A189BA4
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 19:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725996819; cv=none; b=Vz73S7kHItLI4HQqgX9FUsH6Y0hSRcvUAi/z1KIoGd7gVKKLJu57RXvw85AbfZ7Gzx3Gfk8/EklVqqhCHWDAoiCcRuMPfml4UWJkjRrfwwUASvo4Fc7KDWc9WRYdfDPcd6uIUQUmKNL1QqOr5C5dRsOszv531ucT1tCRAQRIfFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725996819; c=relaxed/simple;
	bh=6XNfRc1BufkWwHC3pOSbKRevv8O2WtlLM/BZgGNJnJM=;
	h=MIME-Version:From:To:Cc:In-Reply-To:Subject:Message-ID:Date:
	 Content-Type; b=OWawwVjGS3K/9iFXcGjQE8uv3ctzsTX2rlIrtofLcUNHYX1yjRRUBYVsTSEj/O+Vt1qp/VbRhKf0a8gPDx1C3GVOS1xbRxftXsHqR+Mt7oYaAlnmKv5cnz0CPgIpuh4rNG587UPjAisTvoA5mk0JQNh/KAkf0oUpLPM0lwttmBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imt7jxVJ; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imt7jxVJ"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82cec47242eso7061839f.0
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 12:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725996817; x=1726601617; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:in-reply-to:cc:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=72azyyYyTw7dnjQyfZAj4jFYyp0+ot7nyuTheo4nmqA=;
        b=imt7jxVJfEGNClldH+tYtx0JPpO9DjriSiNaHnaidVSfToPVv0t/mrPpnbK9+lsN6c
         C4cVfHWF14XUULdhep4edEm/JG4sdxZjttdam225RtPa0/hCeLlWa622a+U+7GshhkC1
         NiwY8ldekGMbl875H1iurbkLr8aTXs08OrSaIkPQ+mlGiSbK7QebLG9sWa2wdENH8WFZ
         tx8VeTo/cH6FzVw5hnUQn40ANbcQVzzrxYu7+Tqy9e/XsYZnDjOfulNx/GlAnQ7Xtq6K
         GLCYE9GlzcgiGkPjrLCh+rb9aNyKHopRi5KYP9JN9FgzvFP0KdPmNxE2KGcY83eBb5Ic
         4uAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725996817; x=1726601617;
        h=content-transfer-encoding:date:message-id:subject:in-reply-to:cc:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72azyyYyTw7dnjQyfZAj4jFYyp0+ot7nyuTheo4nmqA=;
        b=LeTBAp4naEbroPv4CKOUZNQpTa9Ans0o+TySZouHl3d5zWYNIRt6GdXaF3B6Yb8aFb
         JFuK1X5/oo5DPp743QIpFHSC0PNymmEn51qHr06CjoEsvW8bx1boKVt84nTbPiINkiTE
         Rzzj32gdJ2VbURElseOqeHsVMjAzkCODZlZdObFVJRKYKoFTeMH85DrbvFBl9nlS8Jme
         5P6IAgdHvi5ehaQ5Rystxp8osN2eynR01xvakGiNOxxWPx0HnyLO7WGgQMi2idQF1225
         p3Gq07U5Kkj8Egrf6baBNTAG//ETSwyPhgAGprS/V1W15CYI3/6aEFVdjApbkB2QfNGZ
         WpqQ==
X-Gm-Message-State: AOJu0YytYgFnliw/2b8UIDoIZyAHsPb6bPnttKnNMsU9xvBUMSKiR3OJ
	r7DYerWtBGocsG2zoUHoHDLLFfnhqG0p9LHzWcjkYZOI160llooY
X-Google-Smtp-Source: AGHT+IGf/ObreWgLdsFMklxh1uCm/ulAswrzy4zZmgDDY/GN57XCM4U1zBigSVmfW0P6NExUJbm0dg==
X-Received: by 2002:a92:c24f:0:b0:39f:6f6c:90ba with SMTP id e9e14a558f8ab-3a06b12e054mr38705185ab.6.1725996817355;
        Tue, 10 Sep 2024 12:33:37 -0700 (PDT)
Received: from zivnix (syn-024-241-228-214.res.spectrum.com. [24.241.228.214])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a058fd5c6bsm21673275ab.21.2024.09.10.12.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 12:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: "Derrick Stolee" <stolee@gmail.com>
Cc: <git@vger.kernel.org>
In-Reply-To: <3ace452b-f68f-46b9-b8a9-a175299deef7@gmail.com>
Subject: Re: [BUG REPORT] sparseIndexExpanded hint always shows on sparse worktree
	 move
Message-ID: <17f3f8f5b8a02458.e3447cfa6f132bd0.af4b8bafcdefe090@zivnix>
Date: Tue, 10 Sep 2024 19:33:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Derrick,

Thanks for taking a look, and apologies for the delayed response.

On 15/08/2024 10:25, Derrick Stolee wrote:
> The key issue with this reproducer is the following: the sparse index
> config is set in the worktree config. When you are running this move
> command from the main-worktree, it is not configured to work with a
> sparse index. Thus, when reading the index, Git thinks the sparse
> index is disabled and must inflate the index into a full one before
> continuing.
>=20
> For full information, this happens in the callstack
>=20
>    move_worktree()
>    validate_no_submodules()
>    read_index_from()
>    do_read_index()
>    ensure_correct_sparsity()
>    ensure_full_index()
>=20
> If you add "git -C main-worktree sparse-checkout set A --sparse-index"
> before you create the other-worktree (or move it) then the message
> does not appear.
>=20
> This is a quirk of the worktree config that may be worth updating to
> respect the sparse index of the target worktree, but may also be worth
> leaving as-is because we are running this from a different worktree.

It seems to me that we really should be respecting the sparsity of the
worktree being moved rather than the worktree from which we happened to
run the command, at least in this case. The purpose of reading the index
(in this call stack) is to ensure that there are no submodules in the
worktree being moved, so the index of (and therefore, the sparse-index
config of) the worktree from which the command is running seems
irrelevant.

I poked at this a little bit, and the main challenge seems to be that
`is_sparse_index_allowed()` uses some cached
`core_apply_sparse_checkout` and `core_sparse_checkout_cone` values that
are populated with the config from the worktree in which the command is
being run, rather than accepting those values directly or via some
worktree object. It looks like this would need some fairly significant
refactoring to address since there are multiple functions in that call
chain that would need to be updated to allow passing something more
worktree-specific through, and those functions (most notably
`read_index_from()` are called from several places.

--=20
Thank you,
Brian Lyles
