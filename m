Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF753E5A36
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790842088; cv=pass; b=L8mAn84FpAn0lll/rTpVHPiqe1oP8bwI5m67d1ZelEe+Q8H4Pk+rg8VqFcLR1WCbdUV1vmyQuBCzgis+Ng3Z8SPZbopXEQwyF3IZw7j6ewJE+p6rB4NZiRuVMU0dhs8Uef0OlpsXByqAGmItrMINfvByOnOLTsvhdc9QRZdxQbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790842088; c=relaxed/simple;
	bh=sIVsUXDS4pM5G5S0qmynBUyGjhDBA7LkoJLCCWKI47o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRNMxltYzi4ndsilU67TQvskjlp+kWVscCvTVtKIrAG83G5atLdgv23gilWdpvptPeQi/JgTYENwGPw+xxlMwmTVslPKhk9wxi+UXehbzhh5+AuGr1bo+Vej8qUhSIF+WZx088PHGvOHOPfBLIpCVZ7CZDnHbGo3aKYWFzcKAVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=y4JFGYW4; arc=pass smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="y4JFGYW4"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ac4967f1c9so16073077b3.2
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 01:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790842084; cv=none;
        d=google.com; s=arc-20260327;
        b=sI8nsFwLOPBWPepk53LGQ/VMMYTzz8KpvmontZ+olyz5a8S9+TrqH01KK3u22qHdq1
         v6bEBy4PWos0hv/OthviNwSMrw8A9OeRSlgoOc+91DkXtZexu/bAikh/fsP1bogXWq7w
         BXQZxmIw7vvl7R3+CgnA2lEZ/zPi6XbkkArAQEHGDQ3lccaBfHeeosbU/4tJRykQl/Yy
         yqweLfmpoy539kYvY2EbJGgatVMH+BfPnnXkZ/vAQGEbtzI1t3rvLFRsLQ2IEFaY2U3j
         7OpgQOzvmakbKgXD5AvUrEa7RMb1vTWzIjhYlpQLi/vIoJwQzIsoRCwSoJ8ZJocAXQL9
         zisw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sIVsUXDS4pM5G5S0qmynBUyGjhDBA7LkoJLCCWKI47o=;
        fh=IbownXiTw9GhuJ3jRrPG3WM+n2MijXFjsTbVegrL4CY=;
        b=P8+PMnUmu3gOrKBew5aIXBrfjictHRQm2JI6jUU5ShkW/54e3ncHS1QmJ16cZDIJuj
         pJ7jmxEJ2AZ0wLtDSGOOVd3yVtn3bmYUsnmBlKnS/vjMDsSuCVxTq3Jgy7ONNnCPWI+m
         5/ZEzuCEf1kWoKQaZ/2rSoWgB/fkuodS0F1+EiLCiRP5P3Iwo6jihZbH868J5ZH/7gtS
         nZfWNUMLCOY9JyrkI2ZEBi5gjD545naYIqmPht3QDOqhM1/7zSwtVH+ODWAEFmk3aosI
         9MA89edbLjie+WYFLVS+N5GayEKPuHyTfMSYI2MJCHONCc3uPGAVWGfslm6lTmwwrEoi
         92+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1790842084; x=1791446884; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sIVsUXDS4pM5G5S0qmynBUyGjhDBA7LkoJLCCWKI47o=;
        b=y4JFGYW4AwFLZBc29dA+VlOB7eVwPpib1aNOgvIlQ4AzWzpvcbp/bUobNOvXTjSExN
         6jE2cOt3d4QIbpcdytad+P3pehnEvQTRTYjgLSmm97Ae1kwXRtWQesrVqAofDDSk0wqR
         pNZmWtVx0LXaAdrpfq1Uk5VQlltB6tN818D2+7wYpYMvwj2L1+kugKyMaRDyTzcKqwGU
         uMMpbT0Rgca5xsC97TRpyN5lyIesEzgaFSJXDhbYMLLHxzHGtTN5XutARiicdES8hykX
         72pvBN/t2AnBch5zMKPiORn7OQUf3eM8Rfh9CW9thbuqQaaB+ZYDl760t6oey9xv1SuL
         66Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790842084; x=1791446884;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sIVsUXDS4pM5G5S0qmynBUyGjhDBA7LkoJLCCWKI47o=;
        b=Jh+8Y7fz/wA+iXl/LXgc7Imq4fIk7tqBHKtt4hzMl0naUbYjKQVZge5+JyAFp7U2T3
         eh4nVT/D5MMf1nvFFCvDLpuLn1PCDh78uQtCci/WHy8kcZ6yhDgpskBPEgxz88Ml+taW
         XKv3XjuMrRmDm1C9l3r7dYk3dgUM+tdoe6lyVTasrOKSAf2vQBBNEGgjfb8FPeEXZ8wH
         h4x0PWyPa1+ZRdl8AU2cMK5aSSf/4o/DTd75j5f+wnrkl71HRgtRd2QfyKuii2FMterc
         XhOQxYQupff/P1WFIW9GinuTClo6hStN7bfKqx6pC4yzWju3b59ltjEw8ADCpvO0ckj2
         hk8A==
X-Forwarded-Encrypted: i=1; AKwUvBw8mUb6LNCuM6idgYzJJAaXn8kS7U6RO3UzhBtCIKTjEBQWtoLWmzWd06X9KhgH8/mrvDU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBsKA5r2oMJjfeq5Xm/FfvAxkNVv0m4NWCmN91504BAGX8k8j7
	Q2a2+0JKyEESJ2g28YBtoieRa8R3/wikK89fVCwT3y0uMzddJg88SXI8gscoIezbSLf+pxA6quJ
	EI0gscNnzD/iizU6r2skdoSMP25rOPFlsF3hq5OnlCw==
X-Gm-Gg: AYBFou1APwW8JpaK06AZGIrD4KL0hUjzyTDJkMMa34cMXdtgAJgxo1700zQls8ga4KK
	VuJUUJNins5Yk2UFxZFCv+Hoz1Y7CTC4OfZKt1UTZrxXaZwWgQV4blRedF7YM2kIL6xAdDC1xBz
	NBcnwqbJ88dlj+XB3jKsEd+QrJkp9WUmBVCjsoDvh6tnpgP5PLa453+sSXXt/sV9mSRGob+WFyx
	DyuqNnHwYtFTcsaUew968+PZl8QdksUw3cUb4bFtBG1qSX3JI6+ybFwV+tdBDbHYH9JiI7mNjBs
	HUOS/uf4U0thjpjzdFV+xCOkf9+UcCOnKpGXcihdYLHXVDeb7cAA9jXiFcvNIxzE1GfpugRBp9I
	s5Bp1MBId5nYdNoJu7XCoH8cnQfmOO861g9Y5qhWbMce8eQ==
X-Received: by 2002:a05:690c:7483:b0:8a8:8d90:a6c1 with SMTP id
 00721157ae682-8ac91f9da6amr15709427b3.24.1790842084483; Thu, 01 Oct 2026
 01:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2243.git.1790606282769.gitgitgadget@gmail.com>
 <pull.2243.v2.git.1790701691022.gitgitgadget@gmail.com> <8b81c508-ac67-498d-b78f-a4b5dab8c198@gmail.com>
In-Reply-To: <8b81c508-ac67-498d-b78f-a4b5dab8c198@gmail.com>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Thu, 1 Oct 2026 10:07:53 +0200
X-Gm-Features: AclHuK99U0m7iM-4M6W93Jh75H4daWnCR1sxHzyfl1yCO3MF4rVc-gFOdlQ0qMg
Message-ID: <CAA0xjtrDQTOGO_6x7fSfHEM_2kBkyy78NcVGtTtUrSBhw=CEzg@mail.gmail.com>
Subject: Re: [PATCH v2] t5520: don't expire reflogs where it matters
To: phillip.wood@dunelm.org.uk
Cc: gitgitgadget@gmail.com, git@vger.kernel.org, ben.knoble@gmail.com, 
	gitster@pobox.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

Hi Phillip,

On 30/09/2026 16:49, Phillip Wood wrote:
> This doesn't make sense to me. The tests that use "--autostash" will
> clear any changes from the index and worktree and so will never need to
> stash anything while trying different merge strategies which means those
> tests do not run "git stash apply --index".

You're right. On Monday I wrote that the merges don't come from the
autostash tests [1], and in v2 that they do. Neither was exact.

They come from the tests that pull with autostash disabled.
test_pull_autostash_fail stages a new file and expects the pull to
fail, and eight of its calls merge rather than rebase, with
"--no-autostash" or with pull.autostash set to false. The staged file
is still there when "git merge" starts, so merge stashes it itself and
restores it with "git stash apply --index" when the strategy does not
handle the merge. The tests that do autostash never get there, as you
say.

I'll say it like this in v3: "The tests that pull with autostash
disabled run eight such merges, each with a new file staged."

> The second half of this sentence is true, but I'm not sure it is very
> relevant, all that really matters is that we're triggering "git reflog
> expire" at a different point in the test run which is already explained
> by the first half.

I'll drop it.

> "With both" sounds a bit strange to me. Maybe
>
> This means that unfortunately the reflogs are expired at the end of "git
> pull --rebase" in ...

I'll take that.

Thanks,
Thomas

[1] <CAA0xjtpzaWH10pHOQ5j-5Hp1yHEKTDFbsicG6E4w=5nxb_irWw@mail.gmail.com>
