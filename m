Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C570F17C9
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 05:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712467862; cv=none; b=dPIgTVFCVMWqVaUkRI2O8kP8ahJfD9/9J1tzdp/UHi9L2HeUMS2UcwcLvQLz6H6ZwKtoTtAimcSPy3T8VfeyODZigBXyEw3FC1kX1m9YUb5dGnou0iCPC/yNM/4iGB8C9mCypYbJLC0OUsJAQf9tW5Dr9K7z/ILbi3xyZ3NWbF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712467862; c=relaxed/simple;
	bh=1bEXZk6stZnGIGob03ZMiZkM4Sbaga9HpKdSNn89g0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUu/mqPYdarzlsVlqfzZbAoUXN+57bLZbPWwQNbD4afIcAxhYkva8MKMh8RNW7AmoA+2cs53EZGcNpw14RY+Iutcx4aYhcnkDU82NejumuRPFQrlffqh3yEcvj3alkAxrvDnxOXf5mZROyNa4HXNmLEQdR9P4V65CiyXwuJRchw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-69b09576dc1so4999646d6.0
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 22:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712467859; x=1713072659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bEXZk6stZnGIGob03ZMiZkM4Sbaga9HpKdSNn89g0o=;
        b=PIrSLn4pAEEDJ9JEh9uIBF/CkBkkDL6r/LyakiKx3G9BsS8tAaZqQs/IH/0CV781Oj
         3235qQEiZffkUI0qXW7MVwexCKke9qkxuLZbVhUbybDAhQlNuMsrzjqzO0NIDzz/sUnx
         BrHYzet5VU/NQnEwcUxNhjZtHZEO7vMPdFU90rwWGkOJrJ1uKyfCVIRvnN2CZgQXUKEl
         8FnWwuYW85ATzhXlMcr646U20jvcGxy9HQrkfbe2h2yKOZ1tJcjSWKUH3bCjhMXmU7o+
         jD7cPRHuOPjnp4xDUjp7VhnZiIYENybT3fP/xGr0QyVh15Ek9SfyTh1zoBhxPB+0hu9s
         /KhA==
X-Gm-Message-State: AOJu0YxHMLZY0wJ7DELvy9XEoP6j4nQVJw2iUdkqXs9vbkFSMlFy/XfI
	ylv6+xsmQXzcpbBIKZMjULMzLLsoXbCxviPHhyoHzTtXTS58jFQE0HlFZCFLrufxjfVGV9DtjX5
	rwbNUayP0jQGLVfHQBQsgmQ5r7Ao=
X-Google-Smtp-Source: AGHT+IFP1bUsaY7hDtIOw32mPOrcHv3KQXJXC26yLaHsme0K8aAB/HQpVqctq+cerIQ43oR5LF0tsowwYwH/LfSUMfk=
X-Received: by 2002:a05:6214:29eb:b0:699:25fe:a920 with SMTP id
 jv11-20020a05621429eb00b0069925fea920mr6769196qvb.22.1712467859626; Sat, 06
 Apr 2024 22:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407051031.6018-1-leduyquang753@gmail.com>
In-Reply-To: <20240407051031.6018-1-leduyquang753@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 7 Apr 2024 01:30:48 -0400
Message-ID: <CAPig+cQVQrrXrDqys-TyCqFynR6=pmbxs-NK-ca-s0K8mjADaA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Add lines to `git log --graph` to separate
 connected regions
To: =?UTF-8?Q?L=C3=AA_Duy_Quang?= <leduyquang753@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 1:10=E2=80=AFAM L=C3=AA Duy Quang <leduyquang753@gma=
il.com> wrote:
> `git log --graph`, when invoked with multiple starting revisions and some
> exclusions which cut the commit graph, may give a disconnected graph. In =
other
> words, the resulting graph has more than one separate connected regions. =
The
> command currently prints the connected regions on top of each other witho=
ut any
> separation.
>
> This leads to a problem. Say there are two connected regions, each having=
 two
> commits, the graph would look like this:
>
> * a2
> * a1
> * b2
> * b1
>
> which may lead to a misunderstanding that these four commits belong to th=
e same
> timeline, i.e. b2 is a parent of a1.
>
> This patchset adds a separator line between each pair of connected region=
s to
> clarify that they are not actually connected:
>
> * a2
> * a1
> ---
> * b2
> * b1

This sort of information which explains why the patch may be desirable
is not only helpful to reviewers of the submission, but will be
helpful to future readers of the patch once it becomes part of the
project's permanent history (assuming it is accepted). However, the
cover letter does not become part of the project's history (it exists
only in the mailing list). As such, please move this discussion into
the commit message of the patch itself.
