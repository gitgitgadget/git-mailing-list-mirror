Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C521624CE
	for <git@vger.kernel.org>; Mon, 24 Feb 2025 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410285; cv=none; b=tx/2dItTGNrjLYpSUsBxlZYoiZ+fOO/4fHDQwKePXJQVpUn1fWZqSo9a1V//GD2+xcOnXTe3kt4j0j6GSEJskSQSGqDC9U8e91xnhhLlSjp8rDqQF7EQ0RAPcA4K+YnOJjIvEfYCgn7ScpWzxvLJ1iam+f9ZtJqtY/2xZDc1bMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410285; c=relaxed/simple;
	bh=eU1kmQb3gR6Bp0VveWd40FZyOrJ5ACpo4MQSyny/qeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5Plg0+NEJ0Mc+I8ApUBGVgmLeM01HxkqtCWoSrXfo0G0BtypnzgRpofZbylPlDrJMMFDM2+9faauuX35Qq2865s87gHUzhdQkqxoOx4aBI2CAZwSvzMs8uPjuH17+TarE1O+UnIwZpcG+JBLxkxVJa1q4jLB5fZyCAoI+vu9WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGumayOc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGumayOc"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so6888349a91.2
        for <git@vger.kernel.org>; Mon, 24 Feb 2025 07:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740410283; x=1741015083; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VB7siLLoUuH100zKntkPtp3NOatMGagkkAuzngwwo7I=;
        b=IGumayOcter64AQaMts3ddNKFyMRJr5Ro+MytAqfJ8GsFwtjZYTs7+urA7ltP0vO3D
         ZuF2zp8SqNFBELsqrs1CTxub1maNaOxvT0y8egTjU8WyTtU/1Gk3AIsO7mK4Qj/mtMar
         I3wkuJDQBKxTnc0/6lS3p7Pcik6S3ZvPfMB3iZSV8DEAsGk3pSJmesi6zlPmVSMbxNtW
         e9WSKm/EeAgEDwCjswfjqLEEUr+KG+JbtWhiPrNnBapf7uG2O1wsQwOmP6XJs6rT4GNb
         lw2B/9sN6t40owWEuZemiR8ITKQJKBrmdzBhZFzWodHd2eV00QybdP+N9QnO0g/A171q
         Sdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740410283; x=1741015083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VB7siLLoUuH100zKntkPtp3NOatMGagkkAuzngwwo7I=;
        b=ViMydHnvmWHo8bwY/S/dKZXe0xxtYQPJ8bK2akGY0HarVTLbsI0PpnsuUDEwfnvTTE
         YJ9sVnlGqPa9z5SDrEfdNpn69qBXi0dURWBQ5zBqHkpdd9FronrPbzcfbNIJ0LLdhlNH
         ck6CDHrHKRpdCAN9BXdfsR5yiTjR8da7pjdYkpbLRy/u9dujwgRT9fnU5RkbB798yqpk
         quwkNHTWhROZzZsRJkn8H92WFsrWcPyOXmy/I5zNiEt306tcSSBE1eQp/xsQr0kT8Eot
         URRQXoiI3Fy8omfmUNbbuGpv6J6hqaq8k/3YM2g7nIpj36DiObUyk5j0ELHqpbaVyPSI
         twow==
X-Gm-Message-State: AOJu0YyiNSfohG7aASEafG9Mw1Yas6fWA9e8+6nkyaFEZkWm3R0AJ6qf
	SW81V2+lPoD54yZgCDU+npzoWAvxvEV8ndb27eCKy4D2wkEBZAA3
X-Gm-Gg: ASbGncs/gRptwPoz/n9egczyfLPWHKwoc/YgNX587u+Wn7KYGtwEDSASbEaTdEjbWBS
	cl3t5cUnaqVPIRQpo8tVNBjq/5oHUIoFvOOnP7JeutozolHxcBa1dN6HeY1ZY8M393K5RldRJ9G
	GijMUmI8MBzflFrVMXzK/omNVqu73bN7lia/UTWiHJfGJ7OJzQKalJYv6tMKIRxA6BfOLPwd41g
	5CgGNRgxNeGy3SWKAjcNKfXvNTtazPmYvw4FtS6Gv0JK5TSKuea81kt4U57w1tygr8VerCz8XPq
	5Hn9ImfOMa8AS6T0wARkzA==
X-Google-Smtp-Source: AGHT+IFoQNeo2x3/8juHVmekKHLUxEEAsHmv0HCFb8xe9QJKYkw9YL1BC7065CrRLw7Nw0tBoxhkaQ==
X-Received: by 2002:a17:90b:4a41:b0:2ee:5bc9:75b5 with SMTP id 98e67ed59e1d1-2fce77a6274mr22366567a91.4.1740410283280;
        Mon, 24 Feb 2025 07:18:03 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fceb12dc27sm6793507a91.45.2025.02.24.07.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 07:18:02 -0800 (PST)
Date: Mon, 24 Feb 2025 23:18:10 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 00/16] refs: batch refname availability checks
Message-ID: <Z7yNsqd_28PE6dVI@ArchLinux>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
 <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219-pks-update-ref-optimization-v2-0-e696e7220b22@pks.im>

On Wed, Feb 19, 2025 at 02:23:27PM +0100, Patrick Steinhardt wrote:
> Hi,
> 
> this patch series has been inspired by brian's report that the reftable
> backend is significantly slower when writing many references compared to
> the files backend. As explained in that thread, the underlying issue is
> the design of tombstone references: when we first delete all references
> in a repository and then recreate them, we still have all the tombstones
> and thus we need to churn through all of them to figure out that they
> have been deleted in the first place. The files backend does not have
> this issue.
> 
> I consider the benchmark itself to be kind of broken, as it stems from
> us deleting all refs and then recreating them. And if you pack refs in
> between then the "reftable" backend outperforms the "files" backend.
> 
> But there are a couple of opportunities here anyway. While we cannot
> make the underlying issue of tombstones being less efficient go away,
> this has prompted me to have a deeper look at where we spend all the
> time. There are three ideas in this series:
> 
>   - git-update-ref(1) performs ambiguity checks for any full-size object
>     ID, which triggers a lot of reads. This is somewhat pointless though
>     given that the manpage explicitly points out that the command is
>     about object IDs, even though it does know to parse refs. But being
>     part of plumbing, emitting the warning here does not make a ton of
>     sense, and favoring object IDs over references in these cases is the
>     obvious thing to do anyway.
> 
>   - For each ref "refs/heads/bar", we need to verify that neither
>     "refs/heads" nor "refs" exists. This was repeated for every refname,
>     but because most refnames use common prefixes this made us re-check
>     a lot of prefixes. This is addressed by using a `strset` of already
>     checked prefixes.
> 
>   - For each ref "refs/heads/bar", we need to verify that no ref
>     "refs/heads/bar/*" exists. We always created a new ref iterator for
>     this check, which requires us to discard all internal state and then
>     recreate it. The reftable library has already been refactored though
>     to have reseekable iterators, so we backfill this functionality to
>     all the other iterators and then reuse the iterator.
> 
> With the (somewhat broken) benchmark we see a small speedup with the
> "files" backend:
> 
>     Benchmark 1: update-ref (refformat = files, revision = master)
>       Time (mean ± σ):     234.4 ms ±   1.9 ms    [User: 75.6 ms, System: 157.2 ms]
>       Range (min … max):   232.2 ms … 236.9 ms    10 runs
> 
>     Benchmark 2: update-ref (refformat = files, revision = HEAD)
>       Time (mean ± σ):     184.2 ms ±   2.0 ms    [User: 62.8 ms, System: 119.9 ms]
>       Range (min … max):   181.1 ms … 187.0 ms    10 runs
> 
>     Summary
>       update-ref (refformat = files, revision = HEAD) ran
>         1.27 ± 0.02 times faster than update-ref (refformat = files, revision = master)
> 
> And a huge speedup with the "reftable" backend:
> 
>     Benchmark 1: update-ref (refformat = reftable, revision = master)
>       Time (mean ± σ):     16.852 s ±  0.061 s    [User: 16.754 s, System: 0.059 s]
>       Range (min … max):   16.785 s … 16.982 s    10 runs
> 
>     Benchmark 2: update-ref (refformat = reftable, revision = HEAD)
>       Time (mean ± σ):      2.230 s ±  0.009 s    [User: 2.192 s, System: 0.029 s]
>       Range (min … max):    2.215 s …  2.244 s    10 runs
> 
>     Summary
>       update-ref (refformat = reftable, revision = HEAD) ran
>         7.56 ± 0.04 times faster than update-ref (refformat = reftable, revision = master)
> 
> We're still not up to speed with the "files" backend, but considerably
> better. Given that this is an extreme edge case and not reflective of
> the general case I'm okay with this result for now.
> 
> But more importantly, this refactoring also has a positive effect when
> updating references in a repository with preexisting refs, which I
> consider to be the more realistic scenario. The following benchmark
> creates 10k refs with 100k preexisting refs.
> 
> With the "files" backend we see a modest improvement:
> 
>     Benchmark 1: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = master)
>       Time (mean ± σ):     478.4 ms ±  11.9 ms    [User: 96.7 ms, System: 379.6 ms]
>       Range (min … max):   465.4 ms … 496.6 ms    10 runs
> 
>     Benchmark 2: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD)
>       Time (mean ± σ):     388.5 ms ±  10.3 ms    [User: 52.0 ms, System: 333.8 ms]
>       Range (min … max):   376.5 ms … 403.1 ms    10 runs
> 
>     Summary
>       update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD) ran
>         1.23 ± 0.04 times faster than update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = master)
> 
> But with the "reftable" backend we see an almost 5x improvement, where
> it's now ~15x faster than the "files" backend:
> 
>     Benchmark 1: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = master)
>       Time (mean ± σ):     153.9 ms ±   2.0 ms    [User: 96.5 ms, System: 56.6 ms]
>       Range (min … max):   150.5 ms … 158.4 ms    18 runs
> 
>     Benchmark 2: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD)
>       Time (mean ± σ):      32.2 ms ±   1.2 ms    [User: 27.6 ms, System: 4.3 ms]
>       Range (min … max):    29.8 ms …  38.6 ms    71 runs
> 
>     Summary
>       update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD) ran
>         4.78 ± 0.19 times faster than update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = master)
> 

This is an amazing improvement.

> The series is structured as follows:
> 
>   - Patches 1 to 4 implement the logic to skip ambiguity checks in
>     git-update-ref(1).
> 
>   - Patch 5 to 8 introduce batched checks.
> 
>   - Patch 9 deduplicates the ref prefix checks.
> 
>   - Patch 10 to 16 implement the infrastructure to reseek iterators.
> 
>   - Patch 17 starts to reuse iterators for nested ref checks.
> 
> Changes in v2:
>   - Point out why we also have to touch up the `dir_iterator`.
>   - Fix up the comment explaining `ITER_DONE`.
>   - Fix up comments that show usage patterns of the ref and dir iterator
>     interfaces.
>   - Start batching availability checks in the "files" backend, as well.
>   - Improve the commit message that drops the ambiguity check so that we
>     also point to 25fba78d36b (cat-file: disable object/refname
>     ambiguity check for batch mode, 2013-07-12).
>   - Link to v1: https://lore.kernel.org/r/20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im
> 
> Thanks!
> 
> Patrick
> 
> [1]: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>

I have reviewed [PATCH v2 09/16] - [PATCH v2 16/16], leave some
comments. For other patches, I don't have energy to review. So maybe
others could help.

Thanks,
Jialuo
