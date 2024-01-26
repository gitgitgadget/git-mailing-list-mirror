Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136711C683
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706278536; cv=none; b=I29soQcrn4L04S/CoByIdUh2mlFw+5dywi9BV89sJYXFxaQejY8WI9SLE96/vwGx9s4qp82HqNaDUAlRQthC5WbhtP5ApfszRNnUtSdUsgn0/OkCES89irqHW4My9RSwAbZUR27ZAqWGFmOYWPyxE11sAByl1LNICOM1oehOeAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706278536; c=relaxed/simple;
	bh=vI84Wpgi7PEOMI/ND0JPrmnmjZIUNyJwVDvzlRTpOhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6X5N89/nfuh608hKGV5Eia7byAVQ2q7HxcF+CrkcqrekV/a20C2i5Z9sWXwmESvXQd9IEIkO7U/GXBbNXWUXneUu1mx3bbrOOReAj3KSV9CWXZ01ZmWyafDWP88KZAEOBkB1xO+LMlJnoQYeDSCZUXjwz3T6xzElVMtLqFYLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ddf1e88e51so434191a34.0
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 06:15:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706278533; x=1706883333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYdCDq/EmLdjb6Al/y4XTTGE1HEXOZRY/1RTJ9B3MMI=;
        b=dxfipvH+53FjLvkDCTgOAcWMlxSvnd8d9NIe4Otu4orY3SzPQRROZcZvI/b+oOv1SK
         sXl6zKqEIpkvob24j+ZWoGKOo9dAZFffn4nxjUsc44GzB/wUCp58ilStx5drxkzrHXTk
         6obD/oHyHnM9T16eIJv5TKN/LtNUgBozTUhpNR882jnLn5U5fYsR5KS84ebEts7sWY7L
         GsP+O6ODfLRU46PYh+Dy6qUMkd4jQtthJBdcupOKOkKdfnBGVWyhRxBIObghjWFE74go
         rUTq547acKIQAdbl5NIo7aFWAE+b/Pzg3cALKpHDVsW1Z7WT1Cos/V2VjXBELTr4yaV2
         saCw==
X-Gm-Message-State: AOJu0Yy4PfExpP5qoI7qdpit/UaeWoRnlCKZbKrpFZ4U43OBvJYuiSRb
	fwjRS8AXKtgaDR3r5O5fj/GOiR3Vsk5tAvh0YH9uQFkx0GBneNrrhr82qLCpcosTfQY4X5VQrRm
	j5Olbx2fRsDeCsqflRFRPEPmMTo8=
X-Google-Smtp-Source: AGHT+IEJvat7BPZZgugQQc8kIl4Urf3BQ0VtAdj5q3jtFfMm1+LFtqCHEHIwpiVZF+c4JwmnLHE7HeNUUk0vmvxFtxo=
X-Received: by 2002:a05:6830:1354:b0:6dc:39a:55cb with SMTP id
 r20-20020a056830135400b006dc039a55cbmr1820290otq.47.1706278532950; Fri, 26
 Jan 2024 06:15:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1647.git.1706277694231.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.git.1706277694231.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 26 Jan 2024 09:15:21 -0500
Message-ID: <CAPig+cQUttmKYnUGbcNFXvvw5rWF4VHuE-GLnEbeOCkCwh056A@mail.gmail.com>
Subject: Re: [PATCH] merge-tree: accept 3 trees as arguments
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 9:01=E2=80=AFAM Johannes Schindelin via GitGitGadge=
t
<gitgitgadget@gmail.com> wrote:
> When specifying a merge base explicitly, there is actually no good
> reason why the inputs need to be commits: that's only needed if the
> merge base has to be deduced from the commit graph.
>
> This commit is best viewed with `--color-moved
> --color-moved-ws=3Dallow-indentation-change`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-t=
ree.txt
> @@ -64,10 +64,13 @@ OPTIONS
> +--merge-base=3D<tree-ish>::
>         Instead of finding the merge-bases for <branch1> and <branch2>,
>         specify a merge-base for the merge, and specifying multiple bases=
 is
>         currently not supported. This option is incompatible with `--stdi=
n`.
> ++
> +As the merge-base is provided directly, <branch1> and <branch2> do not n=
eed
> +o specify commits; it is sufficient if they specify trees.

presumably: s/o/to/
