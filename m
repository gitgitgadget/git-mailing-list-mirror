Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF95BE57
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 00:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730074651; cv=none; b=IMEPS5SMbze2ttW27EyV/OUrla49y2DU2lyg9KVikkAUSuLSgeM8DvKexZQvAfhDfK/uYWf40YDtYXPWcErzDOiIoX8FhjtQUB22QN3XpboOeTfbZVKcMFVrdc0VYT/LuIJW/JRDs6DDZwl0xJTwfF1fecZIeAg91yIxX6IAkQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730074651; c=relaxed/simple;
	bh=01uGKRxtvU1yu5BRGaboSAGgSi+SuMAw63YzanPSCK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rx2c2L1tcpVSCfEkWz7VaCZpNjSOVPBFnblfMk60mOMEthN1LikaH6tcTZOD1a5hIGDrEA8+XbWMZfcNLerjOB1zSOy88o+skVksZOWLxb1nconaYAsqhChJ8cgEXJ7kICT9PYswu3JtqtHI14Lqclk3ZLPJ0rTLgysChDt9pvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ZMNsBf71; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ZMNsBf71"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ea1407e978so125527b3.1
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 17:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730074647; x=1730679447; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=01uGKRxtvU1yu5BRGaboSAGgSi+SuMAw63YzanPSCK0=;
        b=ZMNsBf71RF6VARXK+AMWQT7dbic22cRyPQiKCJngq0kp54iNyzboCUpx2O2DQLMA+A
         Bi1X0uW2U6z1oJRvGXr1KAtAVtm8c02ziCZuM3Sw3mIB3BQ45KFS1EFOG6jFXRbZow3F
         ZIoGD7M4Zbq+q+kKRClt48/mC/9xeScHjy3RZYH23/hV+Doi2j1JkOGSiDFevqcLwBET
         1c9mv/rJtbv1WPOrJLnJLpDZ7R0rw4xXAUXy8CKokl0g046lZ6C3DH0BI1cRfNl5HOB3
         b4928tCfJWAH1l24B+Cc4zXuv9Pa/MAt40/CCa42hPx3iFUs5uWy+XMErErZ97EqKTXu
         /aLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730074647; x=1730679447;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=01uGKRxtvU1yu5BRGaboSAGgSi+SuMAw63YzanPSCK0=;
        b=W7e/gTjeArEn0k2gZmMCteXqHLIsjlOztqLsA0xAXo73kUy2BvVuGw973v1i4h1sUQ
         hWbD/ksrS6tWxicx+5PKrf0jwwC+rNgyQOx3nMWI0cEG+dM3QbI75Jd2biITRzmydCWn
         Y6meF3SReNlFSYfl+Xx/Pkfbhco581D/oQeAa+fvz/58dye8IG+Be+D3ko1ZtGbNhDE6
         X9JRdvDK58P7tqrs7I9H7zLJSHvxpJkxihZWR/fymGv6qT+ZaMtJdxa/UlrzeukbrEiM
         VSNgSwGyqCZL+QECYVm5TwVMZpCiZpYoazxZxOVRE3DYlxQEptDHRpOE4f3GO4kZbpbP
         aJ4Q==
X-Gm-Message-State: AOJu0YxG91bAFW3t55v89/RUkyjon9fwVYsd7J8vkyeNooPdb9tCrh2S
	y5Fh7nE9mjPjkmMBg7QXbjhlyTfGlfcZ/vNnBCRmTUw8qmtENUSGf0xEAxJ6ack=
X-Google-Smtp-Source: AGHT+IEmWAgBkRAZr3Jcu8+M9CIVLkEX++TQsDDx/UffVutf+rywxRJggykogy3KFMfUC+mkzWJXjA==
X-Received: by 2002:a05:690c:6f89:b0:6e3:37a7:8a98 with SMTP id 00721157ae682-6e9d896fc93mr64708357b3.14.1730074647421;
        Sun, 27 Oct 2024 17:17:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c9739esm11933527b3.124.2024.10.27.17.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 17:17:26 -0700 (PDT)
Date: Sun, 27 Oct 2024 20:17:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	shejialuo <shejialuo@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 1/2] worktree: add CLI/config options for relative path
 linking
Message-ID: <Zx7YFPE5tjr/bn2s@nand.local>
References: <20241025-wt_relative_options-v1-0-c3005df76bf9@pm.me>
 <20241025-wt_relative_options-v1-1-c3005df76bf9@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241025-wt_relative_options-v1-1-c3005df76bf9@pm.me>

On Fri, Oct 25, 2024 at 10:29:37PM +0000, Caleb White wrote:
> This patch introduces the `--[no-]relative-paths` CLI option for
> `git worktree {add, move, repair}` commands, as well as the
> `worktree.useRelativePaths` configuration setting. When enabled,
> these options allow worktrees to be linked using relative paths,
> enhancing portability across environments where absolute paths
> may differ (e.g., containerized setups, shared network drives).
>
> Using the `--relative-paths` option with `worktree {move, repair}`
> will convert absolute paths to relative ones, while `--no-relative-paths`
> does the reverse. For cases where users want consistency in path
> handling, the config option `worktree.useRelativePaths` provides
> a persistent setting.
>
> A new helper function, `write_worktree_linking_files()`, centralizes
> the logic for computing and writing either relative or absolute
> paths, based on the provided configuration. This function accepts
> `strbuf` pointers to both the worktree’s `.git` link and the
> repository’s `gitdir`, and then writes the appropriate path to each.

Looking at the patch below, it is quite large, and I wonder if it would
benefit from being split into smaller pieces. Perhaps factoring out
write_worktree_linking_files() in a separate patch would be a good start
here?

Thanks,
Taylor
