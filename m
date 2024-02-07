Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDA1823B4
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707326714; cv=none; b=eHfglgT2rHK53bM5zq1h5mdjqc2KCSCJ1UiIbW0GadxoasCSZ4/mTBLaAWkixczTFCiOTw+vQ2XwYChoT3Yz0QbKkrO/RrGRlRhUFR5tfM08y49GAWnRBSIZRFoDE8TKv0tgvfQau+GE0DED9WbAArAo4Gc1D2nPA+ZW3jkX8lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707326714; c=relaxed/simple;
	bh=1ad++tQW9ovlImzAZ8oYr+S+GYkJCm/YnXQEoHrxlxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2fKUop0BVwPde44tEynMLFLC7Afc9bU2cbhSwfen4xJOreoxD9IOr9eUylHirezWC+q6PE+GUOv+QWpqcnnHdWI2bgO+jbRHPlcz+LH6vGVMsHAXzyEr1Wbx3VFQ/wuH7TENl8t4sYygzeHO/7jh4IChKdYGEd5U/4769NJKxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6e0fe3195so924305276.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 09:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707326711; x=1707931511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1w/ch6QseNeQQRU5Jhw4T2tFCh2N7l7kOvYalpoDAH4=;
        b=ppSxpG/V7OprXZlcwYJKSgqhdrNgVA5VnE9hP+cIb75MVINj7Al/t6kRTNzC/qO9DM
         F5m60C/80N//Bu+g0PJxlHbGy1bechP+7V/ITPd94fIZNT38uWYyDVcr2UIlJjh/zkoo
         llSJAhCf1MBScc/U14FpK7V3FFmzDCf+BZ4yaA1oNLAMPbfXbCPXWs27ZJzSDrvnURtH
         zTHGg3IPByf+4VdGy3ICb3eeLOBLUYOcXW0ekdgpiHrqZt9AninpHbw+VNOWm7/bbSrq
         yPz/w3mKKXgS4RfYoI5oQ/XRS9OAInAfEkEYCqj9yFXyOEx0gqxzcT97GH8xxmsXTsTd
         gU4w==
X-Gm-Message-State: AOJu0Ywnl4+5DLqaJ0D1djguqcgp0214G5mtqdbAyMYbg99itb6UyEOx
	5xXDyupSeDC5Uck2SJ8Z1rpuoWeKxwhbUkykjsNngzw3qHwlAYBm+CGAp6zHulRw//fjCz6Zi7I
	4xGah2EvdYj/m8OZz+bHTkHqH1eY=
X-Google-Smtp-Source: AGHT+IE1Wvl95kiGgoDtm/cBkQQnApiZ+Illjd1ctUvTIjK61hSFOPRqCIk3AU0xkF4iF3kMxykOrudOQ9qxL4FDsbM=
X-Received: by 2002:a05:6902:220f:b0:dc6:d2d3:a57c with SMTP id
 dm15-20020a056902220f00b00dc6d2d3a57cmr5889976ybb.59.1707326710925; Wed, 07
 Feb 2024 09:25:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
 <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com> <be1dadf28502fe3e9662fa61523e8c57ce3352f1.1707324462.git.gitgitgadget@gmail.com>
In-Reply-To: <be1dadf28502fe3e9662fa61523e8c57ce3352f1.1707324462.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 7 Feb 2024 12:24:59 -0500
Message-ID: <CAPig+cSJz3U+vT==NhX5hcrTjsCggnAzhzQOvZcSXbcEGuYaKQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] t4301: verify that merge-tree fails on missing
 blob objects
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 11:48=E2=80=AFAM Johannes Schindelin via GitGitGadge=
t
<gitgitgadget@gmail.com> wrote:
> We just fixed a problem where `merge-tree` would not fail on missing
> tree objects. Let's ensure that that problem does not occur with blob
> objects (and won't, in the future, either).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-=
tree.sh
> @@ -961,4 +961,18 @@ test_expect_success 'error out on missing tree objec=
ts' '
> +test_expect_success 'error out on missing blob objects' '
> +       seq1=3D$(test_seq 1 10 | git hash-object -w --stdin) &&
> +       seq2=3D$(test_seq 1 11 | git hash-object -w --stdin) &&
> +       seq3=3D$(test_seq 0 10 | git hash-object -w --stdin) &&

Is there significance to the ranges passed to test_seq()? Or, can the
same be achieved by using arbitrary content for each blob?

    blob1=3D$(echo "one" | git hash-object -w --stdin) &&
    blob2=3D$(echo "two" | git hash-object -w --stdin) &&
    blob3=3D$(echo "three" | git hash-object -w --stdin) &&

> +       tree1=3D$(printf "100644 blob %s\tsequence" $seq1 | git mktree) &=
&
> +       tree2=3D$(printf "100644 blob %s\tsequence" $seq2 | git mktree) &=
&
> +       tree3=3D$(printf "100644 blob %s\tsequence" $seq3 | git mktree) &=
&

I found the lack of terminating "\n" in the `printf` confusing,
especially since the variable names (seq1, seq2, etc.) and the use of
`printf` seem to imply, at first glance, that each git-mktree
invocation is receiving multiple lines as input which, it turns out,
is not the case. Adding the missing "\n" would help:

   tree1=3D$(printf "100644 blob %s\tsequence\n" $seq1 | git mktree) &&
   tree2=3D$(printf "100644 blob %s\tsequence\n" $seq2 | git mktree) &&
   tree3=3D$(printf "100644 blob %s\tsequence\n" $seq3 | git mktree) &&

Interpolating the $seqN variable directly into the string rather than
using %s would make it even clearer that only a single line is being
generated as input to git-mktree:

   tree1=3D$(printf "100644 blob $seq1\tsequence\n" | git mktree) &&
   tree2=3D$(printf "100644 blob $seq2\tsequence\n" | git mktree) &&
   tree3=3D$(printf "100644 blob $seq3\tsequence\n" | git mktree) &&

Alternatively `echo` could be used, though it's not necessarily any nicer:

    tree1=3D$(echo "100644 blob $seq1Qsequence" | q_to_tab | git mktree) &&
    tree2=3D$(echo "100644 blob $seq2Qsequence" | q_to_tab | git mktree) &&
    tree3=3D$(echo "100644 blob $seq3Qsequence" | q_to_tab | git mktree) &&

> +       git init --bare missing-blob.git &&
> +       test_write_lines $seq1 $seq3 $tree1 $tree2 $tree3 |
> +       git pack-objects missing-blob.git/objects/pack/side1-whatever-is-=
missing &&
> +       test_must_fail git --git-dir=3Dmissing-blob.git merge-tree --merg=
e-base=3D$tree1 $tree2 $tree3 >actual &&
> +       test_must_be_empty actual
> +'
