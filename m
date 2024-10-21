Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B091E22F8
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729544910; cv=none; b=Qwiitu9n0TljnAzRJKzIDhAYO67Pzt6Mci65bRizJFqInVJ7Ae2BD6Qa2f6TpNR7ESFPeXJ/QN3NuhPBt+obz0Ei2e/4imoukOjEYg9tjRQMxoml89NchAkINKf8opySV/PPSmT0dTVzl29KTRq+xhwsPis/r93O7a5GehtmlZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729544910; c=relaxed/simple;
	bh=oumMrL6XqwEXQyXN+ck1Ca4I7lvM49GCAKWA1KgpxLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiC1OF/UcHJPcGCQJA+cZSyWNVH/545XOKxFgetm0z+QurUpEaoi17wdyrm5eFwwjxcMhqxv1qxQvtoz/ATZ9klgfHggRBIPqtNCM27AUrnTvIkasqOtkGNRbuYjs5ue1ULDOngt0BMuYe4LlExRXd2sJreESXnj+tQ8NHFBMnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=oOfCihrM; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="oOfCihrM"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e290d48d3f7so4326058276.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729544905; x=1730149705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQO0XWYsK3B3JyZzqLWdqzzl/TiIXvytyqmyQdDawaE=;
        b=oOfCihrM4XU236aUPOXoI+chNV0b15vV0WspbfagfR+qwFivhHJmZgkIw/breaAGNV
         cS+wys+YU3C+nF6GxOmUpmCWDDhR1rG/pVidPYoA4T/xQlOhaG79+SGfOMj3jIcDBmE5
         wVjU7IGbOlgaeXdPJnTFCUfxAM7kOWj7C/lfwEw5m2jFMfcZYomWMiUXAfX0ml38hpAH
         RuE0YFcSsXOvB/ZkN7Nqpx+vGAyEaFJOkjAle5pbHsqAIj3VUNtEvEQM0Z9WlqHGEgRM
         GIazy67QtO/bY5Xsuv30C8K3dpzpbQEy1faQPckD48apM2pJCH1ZcV+nQjq3OBJflc2i
         QaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729544905; x=1730149705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQO0XWYsK3B3JyZzqLWdqzzl/TiIXvytyqmyQdDawaE=;
        b=CY4axvxHOjgLWolTXgijobJuo2dikIEbsVrlb4xUIt5sQbtBDsuYkVwHRo3psh3UKB
         jwd1EaYIPGd8zLk79sP9Y57M/LQTAryTNTPfVJ2ve5vqVkgXPFiFrI9Mqu++zB3Xq0C1
         TftWjkhQE1v7b8k1fU4SCP8TUOwCfbXgVUCD0S5R6U94uUslhBDLTe3WskDCwbH+NdwK
         x4qgSXBYwzPX2HhLdHuhFvUFO/3ZFHtpICh1FeKulCP3rHs1l+q4fxjMkTNM0CyVIOOL
         G8v18k1kwsquixiNgM2bYNzBCp3YjLtxYvLGiuxoCkZsqp/dudlXAq4tniu6wZ6Mm/6S
         dfeA==
X-Gm-Message-State: AOJu0Yxk+iL4Bz716hrTK4fSDnmSwmxSkoGf+odH02OL9euKquX4ZRew
	scg31Nnh0xRJNiAwBDYbGZ7IAceqwDsqiYzv4aqesO2K9rdYgJsPcfFJDBMYj34=
X-Google-Smtp-Source: AGHT+IFEYp2dxgvNVWuoiNjKJ2dSPjJs5TSX7oq3MD8Q7nIEJwnsuIeBWWNmxxB8hXEe4a/AqMDYcQ==
X-Received: by 2002:a05:6902:230c:b0:e29:3bb6:d624 with SMTP id 3f1490d57ef6-e2bb16d2978mr10084483276.56.1729544905250;
        Mon, 21 Oct 2024 14:08:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f51easm8123887b3.25.2024.10.21.14.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:08:24 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:08:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/20] packfile: pass down repository to
 `unuse_one_window`
Message-ID: <ZxbCx0xQrmaNeudE@nand.local>
References: <cover.1729504640.git.karthik.188@gmail.com>
 <7ab2d08f354017ae20cc26c7078b7a38a7ab0ca5.1729504641.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ab2d08f354017ae20cc26c7078b7a38a7ab0ca5.1729504641.git.karthik.188@gmail.com>

On Mon, Oct 21, 2024 at 11:57:45AM +0200, Karthik Nayak wrote:
> The function `unuse_one_window` currently relies on the global variable
> `the_repository`. To eliminate global variable usage in `packfile.c`, we
> should progressively shift the dependency on the_repository to higher
> layers. Let's remove its usage from this function and any related ones.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/pack-objects.c | 12 ++++++------
>  pack-check.c           |  6 +++---
>  packfile.c             | 25 +++++++++++++------------
>  packfile.h             |  3 ++-
>  streaming.c            |  2 +-
>  5 files changed, 25 insertions(+), 23 deletions(-)

All looks correct, as unuse_one_window() already uses the_repository, so
I don't think any behavior is changed here...

Thanks,
Taylor
