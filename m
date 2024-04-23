Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5138E184
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713832295; cv=none; b=dDCyI5p5Fh+gYiraMUHJiwjeHQpc6DxPKLSHf2gHHxAGeaQRezHt/H3IWqfH7/LvryFJTtevi9KvfqMbwYnAEmabD6nL6zw5FF/StG3qlvjfoNKQ1LFoeMSS+vZyl8BJFGPNeaNyJckC0YAgSyXR53PQrWjLgdJG74ArBqYTouI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713832295; c=relaxed/simple;
	bh=PQ0CG2fwzgux3EePwRO1K2cXdFgaz0wmvbvDOLESKjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hS+x2VbuUXBQOmtZB1mmWB3cLtqGZQdJUchHh8ivp72NpttttxOaReqT6oarFuGsospEVRNGnCQ3SeCb0EmjRkjpSrp+BI3zXDY/DmyXbxSDDYwkKoDoInk1gYJH4Eo8PfmzA0EZyf7gk0dBtZULeqz/wpXQH6SN/KNDlYpWRec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+qrWM7a; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+qrWM7a"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-238fd648224so2717115fac.2
        for <git@vger.kernel.org>; Mon, 22 Apr 2024 17:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713832293; x=1714437093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kA9NjJgve/iEswvq64LjspCDqAF4hlh+BP0W1da7BWE=;
        b=g+qrWM7a4vNuZySUaJ0KaT0Cr9ZPF9P31WaRSwwXyeIe8tGdcB3BXkD6iEkc9grqzi
         GYVvECu9nijwqJ147jhZMN9Xg0LJM6Qq0E4iWZVKioYBgP6+0X7anHvBRUvMTfAnCzuC
         +nN5PcaZC32wA97F819jxyR2X87Jpp4bZozqrUfa9iLg9OLc3c3BAmmP9V8TXc/IkNdG
         gp6kJx/lElzb95PVNWhrQ1aiwc1O8PIS43CpQC7wY1nkuTWZ36rCgS4QIW2aLEEzOTPn
         EDbTIqau8fQpNu83xqaJgBnM4ptLvNrL7pWut097/kKtFYGO7eViVqGlKyjBgHAoBfbn
         C0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713832293; x=1714437093;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kA9NjJgve/iEswvq64LjspCDqAF4hlh+BP0W1da7BWE=;
        b=pDmMwXlgDWSgug28rPk9UcSRA7OgXP+wb7kBmnIaBk4DfL0gbTUkX//veg5H4OUHRH
         RQo5iauObjqUVXcBHkIY9NeYa3+WfvXsnjCSHCGZQdC8KP8aXAtICksnLiKeTQwHkRf2
         XHuSxvauIVD8TvzYlFtvguDi1gy0njBZBdQC8+imTHhn84QT/BIRajo3r8ckz48xnsPM
         FADmxWSVy4kZtuWgwd87YVLIfalsJh3hCWfB6fCBG3TvCLfzmyLYb3ia1/fJYeaH48x7
         jGg+/1lQoA9maFeX/w+iCfCaZT/OtZ933sTQSg2AWC0j5b4Cyj6GmPlG0Ai+BSSR9tDN
         JXdw==
X-Gm-Message-State: AOJu0YwMzJ6NRihwN4QYZRaQ4M1MmKv2iVD5jJ53/1dgbsos8VulRUx2
	3W4mJEGniFZBOo+GB4G0jJnrLJ4xHEPdUQOMYZuE1F4FjOtMbaN/BsMQPw==
X-Google-Smtp-Source: AGHT+IF6grD2enOK85tBpjpYgT0BwtKR+XCpFlmcLLGndaJS66MundHeasa6IZNOfUMmO4A6fJR03Q==
X-Received: by 2002:a05:6870:ed98:b0:239:88f4:45d4 with SMTP id fz24-20020a056870ed9800b0023988f445d4mr12755092oab.2.1713832293370;
        Mon, 22 Apr 2024 17:31:33 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id wa5-20020a056871a48500b002352951ba34sm2203962oab.19.2024.04.22.17.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 17:31:33 -0700 (PDT)
Date: Mon, 22 Apr 2024 19:30:22 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/11] parse-options-cb: only abbreviate hashes when hash
 algo is known
Message-ID: <d2zwlfocsyywyqmwqejcsp6636zjo6e6adfpcoltnqrhkjurrl@spx3ggc6eofc>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1713519789.git.ps@pks.im>
 <5daaaed2b961841d539eb88e104db57ed95809f9.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5daaaed2b961841d539eb88e104db57ed95809f9.1713519789.git.ps@pks.im>

On 24/04/19 11:51AM, Patrick Steinhardt wrote:
> The `OPT__ABBREV()` option can be used to add an option that abbreviates
> object IDs. When given an length longer than `the_hash_algo->hexsz`,

s/an length/a length/

> then it will instead set the length to that maximum length.
> 
> It may not always be guaranteed that we have `the_hash_algo` initialized
> properly as the hash algortihm can only be set up after we have set up

s/algortihm/algorithm/

> `the_repository`. In that case, the hash would always be truncated to
> the hex length of SHA1, which may not be what the user desires.
> 
> In practice it's not a problem as all commands that use `OPT__ABBREV()`
> also have `RUN_SETUP` set and thus cannot work without a repository.
> Consequently, both `the_repository` and `the_hash_algo` would be
> properly set up.
> 
> Regardless of that, harden the code to not truncate the length when we
> didn't set up a repository.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
...

A couple of typos I noticed.

-Justin
