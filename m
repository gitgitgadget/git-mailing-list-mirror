Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1153A1F9406
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 23:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730242815; cv=none; b=YNOZDZhbRV1D/JxC8Z8RNamCHePhcgfeHPmpBEXiwwTOSuUOB/7bmnlXg+moUELSzmNcdV9kNfzY8G+5iL2xlmLBdDgkYT8zHuFZXXnePDVCje6fau2K+vsPj82nfok66MDXnDWzkv5PA13nnNrPNm7VfgICIRwqxrR+gZz5CxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730242815; c=relaxed/simple;
	bh=TDUcCoMpat4GBremlHXg39au2y0+VbDW7Uoq8mlih7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ufa1TGhzqxw+gQKnf2AMchuOpYT+M+Jlmk5Qy7VrN0K/wr2Hsz1TM3FeoOxmv4tEfOZSjU1IkJQvzoxGMOyKlTlRhATcBFJcY8Om9cLU0YJtgupWZmYBKsYsMa2DVIxhA1ivJ+BMcdZllb+PQwgvAZcMRuYVfPAZuTENNSBLOTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=MfyUQtsq; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="MfyUQtsq"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e35bf59cf6so3769417b3.0
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 16:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730242812; x=1730847612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nBve7ag3g4F6WT91cy44vHfN62TujrRbAdXSDK6Dr4Y=;
        b=MfyUQtsq1L2fKU8zaXX+uGqulpnovcGn8Gsi/N2pnwZG0pnMZecrJgYXcPJE/DD3J/
         qFUKtqHgySMPqBrzJNGlGpyUAe3z6n+NZtK5dYRZMHZXfDtzD3cr46302cotjnawjgZ8
         MXYVOstCKUvpXxsYSS2GqBH+AZY1/+oSw9pBjcRnXs1HJtBOiBoDR9NDslZWhhd0odEB
         pocCHlb3fmAGGbtYv/19TlOtFNwkHWkswJJQaWwOn8KFtrX4Z4uGz9NMCol//yrXyhwn
         VYNp6bePsryBiMdmp48O0lFxRX5xDDVnuEeEtH955iW582M6hrBVSRFfQIlf1lNw/1f6
         EzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730242812; x=1730847612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBve7ag3g4F6WT91cy44vHfN62TujrRbAdXSDK6Dr4Y=;
        b=D6eB4vOHazFMjMXxU4XvwwWzjzjSwmWp882m4gL7PFi4N4E2cBAEY0sNmYMeJJdIpA
         1crQDpUrj47914A8KGg1XMauwVn0Xo99ET3q2fpAk706+nfc+hDiryl3OQo2oYRDNqE/
         htUsiUdRqprViN/GxgE1HjMtbBqpLIKcZHyAsIa7B/TPx67xglqQZjPDAbU0vaYTkGlH
         VKhkB0vQgLwVqSlqpoPkBt9bast5C2eX5zRkLqKov8eW8KH8HOm811FnEF9urhuYLt83
         dZ28tOuM5jvh554heV5pvx8MMkUvO24TX2EHBMg1Z4K8W6ogId6hH/gXNPG7rjrBvbQi
         X82Q==
X-Gm-Message-State: AOJu0YysOR0sEgeTQ29vqvPRrcfzcAl4naotKzZc3EyLyq0NCn4J3PO9
	DqjIvvTJuRKwdSfNKBs14yjPXUtT7QFF+Ktml51jZSTLTqtuqVvk6PQhtvLjBIc=
X-Google-Smtp-Source: AGHT+IGLENzLYsJhwtBZtyPXTYwGnTKddo2NWz5cNXGO6uCC9QpcTUG2UDDWC1ANLGzYUvF0/yEFdQ==
X-Received: by 2002:a05:690c:2846:b0:6db:da0e:d166 with SMTP id 00721157ae682-6ea2bfa0a84mr25414377b3.12.1730242812020;
        Tue, 29 Oct 2024 16:00:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c778a9sm21849537b3.84.2024.10.29.16.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:00:11 -0700 (PDT)
Date: Tue, 29 Oct 2024 19:00:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/5] worktree: add tests for worktrees with relative
 paths
Message-ID: <ZyFo+e5Vj2TpXNyo@nand.local>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me>
 <20241028-wt_relative_options-v2-3-33a5021bd7bb@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241028-wt_relative_options-v2-3-33a5021bd7bb@pm.me>

On Mon, Oct 28, 2024 at 07:09:52PM +0000, Caleb White wrote:
> This patch expands the test coverage by adding cases that specifically
> handle relative paths. These tests verify correct behavior in a variety
> of operations, including: adding, listing, pruning, moving, and
> repairing worktrees with relative paths configured.
>
> This also adds a test case for reinitializing a repository that has
> relative worktrees.
>
> Signed-off-by: Caleb White <cdwhite3@pm.me>
> ---
>  t/t0001-init.sh            | 17 +++++++++++++----
>  t/t2400-worktree-add.sh    | 41 +++++++++++++++++++++++++++++++++++++++++
>  t/t2401-worktree-prune.sh  |  3 ++-
>  t/t2402-worktree-list.sh   | 22 ++++++++++++++++++++++
>  t/t2403-worktree-move.sh   | 22 ++++++++++++++++++++++
>  t/t2406-worktree-repair.sh | 26 ++++++++++++++++++++++++++
>  6 files changed, 126 insertions(+), 5 deletions(-)
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 0178aa62a41f1606f2382a4a10ab593ccf11e0e8..e21b9aa5e7f4599af8b20165b50896c9a49ba7ea 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -435,6 +435,7 @@ sep_git_dir_worktree ()  {
>  	test_when_finished "rm -rf mainwt linkwt seprepo" &&
>  	git init mainwt &&
>  	test_commit -C mainwt gumby &&
> +	git -C mainwt config worktree.useRelativePaths "$([ "$2" = "relative" ] && echo true || echo false)" &&

Can we avoid using '[' and perhaps split this out a little further.
Perhaps:

    if test "relative" = $2
    then
        git -C mainwt config worktree.useRelativePaths true
    else
        git -C mainwt config worktree.useRelativePaths false
    fi

I think the duplication is more than worth the clarity here.

Thanks,
Taylor
