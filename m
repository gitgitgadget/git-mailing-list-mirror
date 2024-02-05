Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FA11DFD2
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173420; cv=none; b=IFs6bFQHeYAVKhqEBjxpocNK2Xs18DnzdNOK9VEa/GXTTHrK33+LXhcObNzdMexu7v3HHJkRTAd5gedse74+ceLjoYkiUHjm9CxBpBBRYdcpIRHu7JHXbAV7WNpvQIrwX6q4ABkvSO/QQjbqTsL8Qufdc6LxSGQk0o/xJtD9aH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173420; c=relaxed/simple;
	bh=uLDN45K0E7mxHgWKUYQzLdibjL+20YC9jwsNigOY2dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzYgo53BG+Aomi9cBwVXvggR3ykW+P8bcfoe0p75vJW5IwmHgwNLZgs3+QmjVehlXiURQbTpVegkAV8820G2lVzlDkrZ7/WfdrwVHVAz6WaQi+QjaVp8vfLIcRRGCbwyDUHmoXySpz83ZSppZyb3fSJ3Y8vMbzLf8lDJmGuaNKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BGtwpqXR; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BGtwpqXR"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bfd27d5d1aso1043204b6e.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 14:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1707173418; x=1707778218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3nEeIhwIcco6P4hXejp3QakzX+S9iqgqajN7iFkoyPk=;
        b=BGtwpqXRocWbaxlCn2ssx4VSMTaMj6KbHkl0fynfYF6VYP6nZDmqqfpZm9n1i7E3BM
         rCeyQpM1tKeYLpOc1R6a9p4K6DvEjaJToPYRwji57kWOvNp9eSgSY1D565IDwJlq02Jo
         8QPu9LpwV7uxW7UsgJk/Y8xGoWK394ov77mDBYCCWVBxzJrH0lj22PCmT/sbeiFMWVXu
         Kx095IC2ygIss2GL+3sG5SENScjKvvsNO6sK6wEe6AIQs43fZbHXNqIi9JzVA1qgK5qp
         xltWDJQG4JDsLl0ALSiHY3HW3hoRvJcpcAX+mrQZTZ7Zyg2vzyAYQBqV/9vIMaNEmBiS
         8v1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707173418; x=1707778218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nEeIhwIcco6P4hXejp3QakzX+S9iqgqajN7iFkoyPk=;
        b=bDPLlJb5vxs9wqv+EUjhjnnZ4/QR/3SB+HUeQBYDdYNhCvmZLvxhEn7224lNIu7u3F
         dZ3WCZU3iB+ZsR/QSYytsuSNqLG8c124EO3vWmnY59R0IL+HxTuThiGurnXQyY0lr9Dw
         AIPdi9CAA5fhs7VB5sHhCWReEB6mlyk/MTmz//JlP8k2rU9xv3itxuH6l3hZNq6AIB99
         B5GKgtn0gh8ijmExY7xSN6/Mo0uvflDCS5AeGemAqbPg+XF30+QqRXd2kAoU1Da+cLLn
         W1TjBhCDacx/zzySF0vH0EeH94ww2mb1PtYbMcjxH/YBIIb3b3vWIDsYrfq/IFtPJfdS
         +4qA==
X-Gm-Message-State: AOJu0YyTMxUr6hS3API4JbbaN1Dyrx5Njd4gC4nHqCriFW6MKTxLWYw5
	4xpqAFFQqjGppAEMsBOTXU0arlfat0p2ZqjsAzhfSUr+TP++P2JOVS6BuMOdnsAd8/AIKfE4rKp
	WWF0=
X-Google-Smtp-Source: AGHT+IHMxOcMepTuULrSoaQTRM3BIms/s1j8KaUdJSCxPsK5O9nS7mZolvR4UlmCzd4sbS0CWT/ZOw==
X-Received: by 2002:a05:6808:1987:b0:3bf:cd0b:9dd9 with SMTP id bj7-20020a056808198700b003bfcd0b9dd9mr597257oib.29.1707173417762;
        Mon, 05 Feb 2024 14:50:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUaSWP2wHgJLfF06p3/epppn+Pvjh4xcWThX4D7K1EByzha7NjLOzm3cxjakNDP8zOARDcXRBCK9q/JRlUKt18XIxxKjbgluh9oQvGI
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d16-20020a05622a05d000b004281ce041f6sm366339qtb.21.2024.02.05.14.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:50:17 -0800 (PST)
Date: Mon, 5 Feb 2024 17:50:16 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <pk@pks.im>
Subject: [PATCH v2 0/2] pack-objects: enable multi-pack reuse via
 feature.experimental
Message-ID: <cover.1707173415.git.me@ttaylorr.com>
References: <cover.1705431816.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1705431816.git.me@ttaylorr.com>

Here is a small reroll of my series to teache pack-objects to perform
multi-pack reuse by way of the feature.experimental configuration.

Similar to last time, the hope is that this will expose this new feature
to more users who might not otherwise be aware of lesser-known
configuration options for pack-objects's internals.

The only changes since last time are as follows:

  - Rebased forward onto 2a540e432f (The thirteenth batch, 2024-02-02).

  - Re-introduced a missing `--delta-base-offset` argument into the new
    helper function added and used by t5332.

Thanks in advance for your review!

Taylor Blau (2):
  t5332-multi-pack-reuse.sh: extract pack-objects helper functions
  pack-objects: enable multi-pack reuse via `feature.experimental`

 Documentation/config/feature.txt |  3 ++
 builtin/pack-objects.c           |  2 +
 repo-settings.c                  |  1 +
 repository.h                     |  1 +
 t/t5332-multi-pack-reuse.sh      | 85 +++++++++++++++++---------------
 5 files changed, 51 insertions(+), 41 deletions(-)

Range-diff against v1:
1:  94dd41e1af ! 1:  db3d67bfa3 t5332-multi-pack-reuse.sh: extract pack-objects helper functions
    @@ t/t5332-multi-pack-reuse.sh: pack_position () {
     +test_pack_objects_reused_all () {
     +	: >trace2.txt &&
     +	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
    -+		git pack-objects --stdout --revs --all >/dev/null &&
    ++		git pack-objects --stdout --revs --all --delta-base-offset \
    ++		>/dev/null &&
     +
     +	test_pack_reused "$1" <trace2.txt &&
     +	test_packs_reused "$2" <trace2.txt
2:  a2d0af562a = 2:  683ffd154e pack-objects: enable multi-pack reuse via `feature.experimental`

base-commit: 2a540e432fe5dff3cfa9d3bf7ca56db2ad12ebb9
-- 
2.43.0.524.g683ffd154e
