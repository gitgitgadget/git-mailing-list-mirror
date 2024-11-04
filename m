Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AABB1FA270
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 22:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759593; cv=none; b=Nqvh2D11nkbWGH/vJRS4eLjr3DDFEsO+69IUSw73gbmgL0oL+BNQ8Fmglh7ls69nKOTcVg7usVO+gzWPxW5UXDrncMxqqNgTfJ8U0CoiZ3e2H4jVqGGTTCbdCHsYbgBes0BzlYUdOgvFkqb5Orc/k+NZEnvyacfJNCssyLo8KHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759593; c=relaxed/simple;
	bh=5Kh5tSjQ+vjkodhWcxbrxIjTM99O/+cBtcTMgbOsR58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgnX4Sec/HEsGgnoY4yrQMnSdox+9ttrhLy6nHi/lya4CIGfsJ7Wx3Gaj7s8F3NDUlc1BMjJWCYmxl9/Sd3Ee+gh2Tih8xt15/NYm8u4J439Ac0HBkx5bxVRMSXg0DZpFwlgHzOeP4zfmUOx0QUVcWSOZCOCyl3K6Zo3LzbyTVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4/dQE+z; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4/dQE+z"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7181b86a749so1772011a34.3
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 14:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730759591; x=1731364391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Kh5tSjQ+vjkodhWcxbrxIjTM99O/+cBtcTMgbOsR58=;
        b=e4/dQE+zfYmVduBELTHb5Mk/lcdk8mRNAeuJjGX5JRQtMOXx9Te1xJDHUBblmTUNRY
         Pg9TRl2zwhL9kbbVfsgzhSmVZACzMsAF4HqxboYgDHtfmx2C9qZnISDtdpV1rJySB7cp
         0XppwVAQXDlKp8589DV/1QpNE2ZHgl1YD4UsfILngWEb0UOlpiBNTCFQ7Ak1CprmpotQ
         3uGBcf9aYOwkp8esBv8uOXgIZutGpqYJCjdWlGzLCN1tm5CIWtP8Oe2oMNRbTjhMFNH/
         l6ETfD18cavzn9pAVFQqfinDPmVCfwBj8dLEvI8sf0ar2mbGRCnN15Y4l0rfIacRVwlP
         PVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730759591; x=1731364391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Kh5tSjQ+vjkodhWcxbrxIjTM99O/+cBtcTMgbOsR58=;
        b=GBC97rgyclGfBetCvCNYiOkyon/5ftou3gSQOgIhlZMbmn/1rmbgibi+Mv1uBrwESd
         VOAzX5aSyaif4G8q42tJQ/hDsgJg6oJJd5aHqhHY4dbr4JDuZfOmrjFiLSZ6C0hAj3Dq
         HxeZcSi9Ue3lJYU/3ViWVskiw9KJRm8G7aP8iOVC0b6ytDgvKxseAuUi8FFdwPwFymgG
         IAw+nyoZ0DWiIaT620pC4eizFqH4hOm2NjdzGgNMkyRnhFj+NCXjEhdTvMvhKK6eo4TO
         4ARinOvX1NIo0W0syHZWAXXiAteFDozMqCtT+om1K2dWea77frFVb2K2qOlYtM2U2NFs
         OxpQ==
X-Gm-Message-State: AOJu0YyK0mfCzLiTC15J1+eH30I57J9rxM4lrgXrJBk1aiBy88SYPP5j
	eZ7TW/5Nv05I+b55+tUX3G+LK30EbNnlU66Z1ajZbusneMPAOsgPWPKVjnCP
X-Google-Smtp-Source: AGHT+IGpNKc5e8l8LgGJkkUu35VPvw5+hvkk7aeChHcq3ALSCUsGN3+w5AdVMbqMumEX9CJCiERNSw==
X-Received: by 2002:a05:6830:348d:b0:718:123e:9239 with SMTP id 46e09a7af769-719ca1aca93mr9666251a34.13.1730759591372;
        Mon, 04 Nov 2024 14:33:11 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7189cc59b50sm2203568a34.5.2024.11.04.14.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 14:33:11 -0800 (PST)
Date: Mon, 4 Nov 2024 16:31:34 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 11/22] trailer: fix leaking strbufs when formatting
 trailers
Message-ID: <ye7hagpn5xmtlndgk5usx7i4xrg2s32eyukcy6fapxitye24ws@ddrg5zrnxkn3>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
 <5b851453bcea945f95c3f29138e510d8448e96e6.1729502824.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b851453bcea945f95c3f29138e510d8448e96e6.1729502824.git.ps@pks.im>

On 24/10/21 11:28AM, Patrick Steinhardt wrote:
> We are populating, but never releasing two string buffers in
> `format_trailers()`, causing a memory leak. Plug this leak by lifting
> those buffers outside of the loop and releasing them on function return.
> This fixes the memory leaks, but also optimizes the loop as we don't
> have to reallocate the buffers on every single iteration.

I see that we were previously calling `strbuf_release()` inside of the
loop. In practice were these never hit? Or just sometimes skipped my the
"continue" in the loop? The commit message makes it sound like the
former.

