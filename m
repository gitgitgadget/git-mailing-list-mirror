Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DC978F58
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 21:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743630597; cv=none; b=hyNczt91likKocxMSNBDk3xxeTIpBsyAD8V5SEfiaQtHynrB+jods5wTzJP2CppGt4uwXljXlaHkzhXvruUBc7VE/YXrYksitg39yLrrCUgBMmhHo0NrPfxMzfgwNWdLAaYXC5fQyQDq03AwDNOK6Yc3+JkmQPNSDjyjbgfXP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743630597; c=relaxed/simple;
	bh=WXoqMUnHXqGmTN8L/2hT7JnC1SBA45Plq82CxaAk8Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7gE922EhyKx+Xo5JTMeSkEx8yW5Y94nr/ddQ6riXWdxIJMVTUTiMmBIqaN2h0nIPxENZkIAMbxFox37m3ttuU3soqXX4/u74GIGO+8hBKCgCDCm9tiOf18kTWnvWjbaY67CBLRdqBY74C4WI9nD/XXhcjts3fm+0RXzJ5ZbR38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TirLoOB9; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TirLoOB9"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2c1c9b7bd9aso113363fac.0
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 14:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743630595; x=1744235395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXAxdWq/a0jK4nJaMFQHRJiE8Raem4gUdwJNJIX6IP0=;
        b=TirLoOB9+KDy21YZ73n2d07VdTZ+Cb9IYmx2+273wSRDttG03jhFXCbCPjEhczot30
         LMqc69mUvAPPGaaiku2ZELBaRXkiN3XITrLIz8wA9o3X7FNAtTo2ypOax+dr6B48alTD
         BG8RPi39lteXM53vx1aezuzOWECLYAYkDoYh0znNFVsknLgZnJOvdTHSVzRboaWjgjA5
         kolqeZuaK/3BSIeDvE1fxb/Qb8IKLIGgOptuRCcAYIeGg5cQVrA59g0erc14xYUEDWge
         AED7lf3xzXfuc61tOnBGaTfyZ+CCJwNMYUiOn3gf5RvMjgSc7P20d/WgNGi6Nkh3sipV
         F6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743630595; x=1744235395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXAxdWq/a0jK4nJaMFQHRJiE8Raem4gUdwJNJIX6IP0=;
        b=nIaxCjn4b2uuJOdi/QLrdgVl+uUSJ+6pQE0o24FyrlS4H8XWOdTZi2rLD8n7XA7wJs
         usi+NeeaPXW8pZ+O1y1gIepQplq7A2r6RhXTbIhD6OB5ZNuEqv6gMnG7n9nkJLEwvaPC
         aHOOjCfv0nY4mICCRVJs1KHOoV3IqmvK0uK0s2cSIaTyfd0FkWLszDkvRoA2xJRJg9aF
         QHxn4bkk+JUdytz4G+x8pgfgTtbB2rRzTYbZUef+AXaE4p9jaJ5+lZlKibGEQixaR4ak
         Lwo7IPtra/WZRkMZGuS83kQvd0tm8tps/butevwj7DgmAqQodEIKsyQaT9/u7efDb7YP
         0myA==
X-Gm-Message-State: AOJu0YxM1oygtNnzWrXj3SMg1tdwV5DWOxG3wx86HxynA/y5rqYLaiph
	sadaRlyxMgOFaEwNCiX2VQ8F+10nQM6Pg0sWlv1+4nBnOuCzE0s3MRTS7g==
X-Gm-Gg: ASbGncuelnQjJViGonL0MzX0xJB0/h3ibRKVjYki2e9fmIwG7VKcTcLivVQDkkXufkm
	vpJ9uBdd2lZxwcDUGUZNQo5dN1B56JUGBdgJ2fqRhLtB102b7NEm0KaeTm+KUP4oIIE/JmQeSgJ
	eQUz1YxWchTTRLYI/9zRatgvasMm7gN8s6fo/QdpNzl37HwZrkL3Kde/lrNNo+RifmvHMPQVmXI
	JoR4vzNBk2rY6dgsLrFy+lZbBzPgEg0+GYfg9CCGu0WFLR/PpIXbg25wGmA3qftla6GShdVNDIo
	7JJP8taAGI3ZflAYqFvmn+HviW0s0DRzF0SUD1KFDEqRcKoH
X-Google-Smtp-Source: AGHT+IHU4wx2UontyTcvXy/QeN4WNZXLmiVCiAlcH0hByDvIg/56vTxj6B46mF1d80gk1sfvMa7lzg==
X-Received: by 2002:a05:6870:7247:b0:2c8:5db8:f23a with SMTP id 586e51a60fabf-2cbcf5ace64mr10341620fac.20.1743630594970;
        Wed, 02 Apr 2025 14:49:54 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2c86a8ffb5bsm2965920fac.43.2025.04.02.14.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 14:49:54 -0700 (PDT)
Date: Wed, 2 Apr 2025 16:46:06 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 14/16] reftable/table: introduce iterator for table blocks
Message-ID: <q6shqgjoe5vlt3fduj6cq6473plz7mmlmnmyuwft7huuod5hhn@je7sijo3v54z>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
 <20250331-pks-reftable-polishing-v1-14-ebed5247434c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331-pks-reftable-polishing-v1-14-ebed5247434c@pks.im>

On 25/03/31 10:41AM, Patrick Steinhardt wrote:
> Introduce a new iterator that allows the caller to iterate through all
> blocks contained in a table. This gives users more fine-grained control
> over how exactly those blocks are being read and exposes information to
> callers that was previously inaccessible.
> 
> This iterator will be required by a future patch series that adds
> consistency checks for the reftable backend. In addition to that though
> we will also reimplement `reftable_table_print_blocks()` on top of this
> new iterator in a subsequent commit.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/reftable-table.h       |  16 ++++++
>  reftable/table.c                |  47 +++++++++++++++++
>  t/unit-tests/t-reftable-table.c | 109 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 172 insertions(+)
> 
> diff --git a/reftable/reftable-table.h b/reftable/reftable-table.h
> index a78db9eea7e..f0f1784c664 100644
> --- a/reftable/reftable-table.h
> +++ b/reftable/reftable-table.h
> @@ -10,6 +10,7 @@
>  #define REFTABLE_TABLE_H
>  
>  #include "reftable-iterator.h"
> +#include "reftable-block.h"
>  #include "reftable-blocksource.h"
>  
>  /*
> @@ -99,4 +100,19 @@ uint64_t reftable_table_min_update_index(struct reftable_table *t);
>  /* print blocks onto stdout for debugging. */
>  int reftable_table_print_blocks(const char *tablename);
>  
> +/*
> + * An iterator that iterates through the blocks contained in a given table.
> + */
> +struct reftable_table_iterator {
> +	void *iter_arg;
> +};
> +
> +int reftable_table_init_table_iterator(struct reftable_table *t,
> +				       struct reftable_table_iterator *it);

Any reason we don't call this `reftable_table_iterator_init`? Seems like
it would more closely match the other functions.

> +
> +void reftable_table_iterator_release(struct reftable_table_iterator *it);
> +
> +int reftable_table_iterator_next(struct reftable_table_iterator *it,
> +				 const struct reftable_block **out);
> +
>  #endif
