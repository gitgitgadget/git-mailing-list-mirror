Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C65F383A5
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 19:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660002; cv=none; b=YkmguOd1C4gUJqFG8SErT/Lczmt5rL3/MNYOXBebGPmDG3rV55wre76Tdz6enmcnofpMHUs8DYFo+65r9nmOohcC+bclOqEanVN5kBZD2G2e9va6o/Fy2T+GPhr1zZK3/hs23qDV+newiz9PTiOoHeGDFYQXUgdI6xGFzX7JFqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660002; c=relaxed/simple;
	bh=Uq4KG94S4BRoHTyS8UW01Tg5yQpxiW1uQmGNdaRycNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kV/kVK5yCWn3SOwDzFUS15C2rl18zj0XsHBy4x/+wBVNKK2ATH7NDfCqtAYd3cJhtF+wqZpNXQHCoqxoLQfLB1VSjdCqGqOXHlyhLS65JiHID2AtzDcn9h2HAGBModc6L42hDucfQV8DLQAZSsb3HN9rPbmtkVqZ50tMn9sjzuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k09jXw8U; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k09jXw8U"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6049acb776bso56704eaf.3
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 12:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744659999; x=1745264799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MfQUrEXb3XllLk3hiw8U3sx8cFDMBltEx4f54Om+c+k=;
        b=k09jXw8UhdsElayUHYgVG8xG7njrPl8VzUF147FaHjCe9jP6o+21dzmbP9KyX3N8oV
         BW0f83W3jPCYvakUD3HHayPY1xzplvHKDg3Oi9kRznPTtFuj3nw8Ru2nmukb3wFRzZNJ
         /Re96d39HE3D9DW8iXbSZfBdE7dpbfIE5EMML0A3OyNqK9VyCFb/MhCQhS8WX3egLalb
         hL2lhTaBkWvAnlY67KbwZdfTakORrKnz/nlnK+YT2eWSSgRgr1P5yDwWMiMieD+03Zeo
         mEuK5SqueaVQBXxJGJmTWF/xiB0XHshQ72/NOeRCCe8/PgPA2oDrzv0s0inM5TY4NR8s
         KSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744659999; x=1745264799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfQUrEXb3XllLk3hiw8U3sx8cFDMBltEx4f54Om+c+k=;
        b=CmTzY9Gubr2nrxDWFtXYhb1Wbq1ZW7+BjXywAn/3OsGCWb5hCSm84EgEmTSc+Ejd8T
         8d0j0iFHoqN4QH/k5QtJzOhlGLezuQ8iCfLR+OUzYw4WJBxkzpzFrAi8VqDeisMUdzk1
         P18YhMKcSDMu7hiW/CeuaX9lW66GgMtO0iSHKSdcVSiVFLNhWx4IId2jU9+lPowQC+qQ
         u3gIIqG3+zUS4Nb/xJElB9qsnlLrWDTTFWxXjGrFsU1N9tb05wtQ+7ztweB2OwgtunBg
         s43sKUIjwzEO4fiJ2P53ovTxBD9wNjKF+skWgSCd5Fyb5aD2GxfKRqmRITsRXWdY3lFl
         GFQA==
X-Gm-Message-State: AOJu0YzJ5jzHOr7OHCNP4pOHhsQr79CgBPrJsldBInvkkRCMcz7cgt+8
	et55k8nTkbJk1VX9fYOWrtdgB+FbhJrhoMKipV5x+jgjAViKUdP7
X-Gm-Gg: ASbGncsV6AmroBtwdp9SxFZwJfEfMFMp0OSjn14ra/x+YzqxoHglOuR3S3w+c+MsST+
	skR7zuQQG0YgJgfC4ZFfda7zYFHNHXVg6aIyPPaiT1U80c0VpCe1I5vciNu+2gUn7Q1Tut7NqUU
	rjPLvVBzc/u/lkclpBNDMUU/1oAz6hgW89HEREXC6xrU2Ubd0Yh2pYwFejDDQmSqTG3f/zT2taG
	L3nMYUkvj5DjhPn6goZGxAMMgtXyT3spmqy+Y27wIc67lncZyjnTQClTXf7NSoAu/gqw0TjG2D7
	y+VzVDPqqA8ha1POBU+lZ4A1/6J/5ICs0A==
X-Google-Smtp-Source: AGHT+IFB5+tP5J+boALBCC3VCC2AVIDwmJBxXsxkp8ST0uTDWs+I5EMD7ZAKgCNt6go+8dfv8aNQhw==
X-Received: by 2002:a05:6820:1b85:b0:604:2ac:840a with SMTP id 006d021491bc7-6046f595394mr7492590eaf.6.1744659999270;
        Mon, 14 Apr 2025 12:46:39 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-6045f50ef13sm2065292eaf.2.2025.04.14.12.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 12:46:38 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:42:40 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/16] reftable: overhaul the API to expose access to
 blocks
Message-ID: <3okrcl7bdpy75hzyzpmrp7fluan4n3zvsroioq64id4a2kt3o4@fc6fetilb6y2>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
 <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>

On 25/04/07 03:16PM, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series is a bigger overhaul of the reftable API. This
> overhaul has two main motivations:
> 
>   - The reftable library is now standalone and can be used by code bases
>     other than Git, like libgit2. This patch series thus renames a
>     couple of subsystems to have more intuitive names before we gain any
>     new users.
> 
>   - Some of the data of reftables isn't accessible at all via public
>     interfaces. Most importantly, it is not possible to access
>     individual blocks in a table. While users shouldn't need that access
>     most of the time, an upcoming usecase that Git itself has is to
>     implement consistency checks for the reftable backend. Here we'll
>     want to read through blocks and their respective records one by one
>     to ensure that they are sane and then iterate through records
>     contained in these blocks.
> 
> The patch series is structured as follows:
> 
>   - Patch 1 is a trivial global refactoring to fix formatting of the
>     license headers. They have been annoying me for far too long.
> 
>   - Patches 2 to 8 consolidate and rename a couple of data structures:
> 
>       - `reftable_reader` becomes `reftable_table`, as it is used to
>         access an individual table.
> 
>       - `reftable_block` becomes `reftable_block_data`, as it is only a
>         simple container for the underlying bytes.
> 
>       - `reftable_block_reader` becomes `reftable_block`, as it is used
>         to access an individual block.
> 
>     Overall, the data structures are now called after what they provide
>     access to compared to the rather generic previous names. This is
>     also in line with other data structures like `reftable_merged_table`
>     and `reftable_stack`.
> 
>   - Patches 9 to 13 refactor the block interface so that it can expose a
>     generic `reftable_iterator`, granting generic access to all of its
>     contained records.
> 
>   - Patches 14 to 16 refactor the table interface to expose a new
>     iterator over its contained blocks.
> 
>   - Patch 17 refactors `reftable_table_print_blocks` to be implemented
>     on top of these new iterators. This allows us to move it out of the
>     library codebase into the test helper.
> 
> The series is built on Git v2.49.0 with ps/reftable-sans-compat-util at
> 8f6a2dbe340 (Makefile: skip reftable library for Coccinelle, 2025-02-18)
> merged into it.
> 
> Changes in v2:
>   - Rename `reftable_table_init_table_iterator()` to
>     `reftable_table_iterator_init()`.
>   - Rename `struct reftable_block_reader::block` to `block_data`.
>   - Several improvements to commit messages.
>   - Drop unneeded calls to `block_iter_seek_start()` after
>     `block_iter_init()`.
>   - Fix -Wcomma error.
>   - Link to v1: https://lore.kernel.org/r/20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im
> 

Thanks Patrick! The changes in this version look good to me.

-Justin
