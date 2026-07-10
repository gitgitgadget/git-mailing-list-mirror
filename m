Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE14374E6D
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706137; cv=none; b=lSVNtCWrbRkm7ahM6IpyAmwPn6L1WxxKGUAjVnbK3OKU1bKl860WAIkSjMC2h2OhY5nSu6rH2XiNBpN362oA/hle59u8IiWqkfgTnXKJKPBYnxv2t/vK5pJXl2XBOgGKIUKxLnCX5RcAoMtG+cbjOK5svhELX/uNJyKOuAIW7bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706137; c=relaxed/simple;
	bh=HrqOlz7w7ZpcnRUztRE+NSxOjCr+oaxV5bHOsoSjU80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLbTOeGINPC6rkhyG45LjmIXZ90MqxTrDk/XgygNtwiz0x8FT1iRYqKVVFzJKyQttnS50Z9nCW8HlCOVq98fwFQI6OwLz8X1GeKPgZoTmZP3yHbBMFrFUfJi3p11tBCT1Gyr0jxQnZbaeTXrITxsFXRCHgxGpMrjV3V52pQ5N+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faFAy+Mi; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faFAy+Mi"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c96c92c0980so725349a12.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 10:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783706136; x=1784310936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qQr8z+rhN3dja4ApIav7ERSmC6Sevh2k85cg0tvk8jA=;
        b=faFAy+MiktchN7GIpIyxdC3pCUcnzeNWqAteYq3/oOah8nyj31n4OMfk5EkHIMxqRI
         dBDv8qGJByEH+hNcvF8jjuZukMfmY6p8vKtRj1wR/FijalBLdpMzSkPuvzt/cYEpoXT+
         ZMK88gWCb7WYyIMtAZ2s+xAWO+IxWlbOSGCb8INbEon2PyHHn0X37WGkcmUNi9IGFl7d
         e8YRCJCauVa5bExfbIXnji8O1T/BsezCrWgcDxc7xnpEIH///ri0uNH1VcDC4dYWo2Ma
         jiqQF8L7XP2J8ISp4LDZxrsd8qllZFgBPDw1M+xuuxd7H+iGJVHE28B4isX6JS9Uu4Ul
         e6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783706136; x=1784310936;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qQr8z+rhN3dja4ApIav7ERSmC6Sevh2k85cg0tvk8jA=;
        b=VOd4HOd2tBgIhR20/SJWo/TTdBrvrIPsDhPTd3GMkgctaRWb2m9r/Aq+uqRLveFQaC
         BqWhuPAeafWbNpLnZYkGnqE9/6WAUh13hXlH/0JpEz1xmCyTsMNQv4VZChDC3XaS3R9q
         vq6q8RNOwqF5CP8gDsOrADtwgRWibjv0IQ7GkvtJBsIfeC/lT4qiK9UOUVAKHKZ8cQyI
         CPf+sXuzK6OFDmvOk2t+nS8LM3or9xaoV8Owqwj+Jv9PPrscsMitwrWP6y7Md0QaZYZf
         CIVerDtTwaQt3TWQNTksCpBF++k4uAB4EIIGAmYX34XONX1UTgE3eW7e/ZypAfMjVX6w
         OvHA==
X-Gm-Message-State: AOJu0YxT3WoUmBmgl+KCGV+i8hkIy4kFZ80RD/G1DAMHOI1+tFwP0kJN
	l02AkHjSiunY07w73itjQ8u7lUeRT5QJDlvXIh2O89BPUzvlD0aMyjm2
X-Gm-Gg: AfdE7cnAPHynJfl8Nr8Sbp6bI77oh/D82P0zj1Va/MH+vZnL8VdPi+dhGyqb/zX+GaP
	QG9mI3hv7Yg30G4RjGKcn1dchXWBqJgmBqlpyw0aTiNIg6qRfe3HrtNw5uXO30vncVVDcYoVB2u
	bF3eLp8N1OmuJ/+l0DiHazRkW62Uin84o2LuTxoUW4kjcyA5rvIcmljRjh8TwEy+ZEmhOduIBfQ
	7UPelMNsqkyDxrjYQAknEwhkdqbHw/XgHrnY047snGe8VCyAkreVFmlB0TlLeHcBcs1nKzXMaCy
	GdOJyqK9UIlWN9DFkEd0ZF42+/tqj4iGnKg+04btgziUFhPy45ADqbmApmFiy2lFr8pH0Wnd48T
	aBtVpvPRd3j+itLPIJnGKw4Azr+iopvGuSUrfeW34TNAkdwCJ7uL4SCJR57H9P4DmMPwlChRVKE
	Ff9CT22J0pANS1B6o2YIqmPl18hAO0teUz8lRMC+dJNEJ3lhZ2j4Nlma8chFzrsjMNfvDCV4KeK
	mCc9mM4BOFwLzidcNb1EKZTns5JXyZjojkpQdsMeFYbXWqtApyitBH/LtNjXQW9k520o0BQwA==
X-Received: by 2002:a05:6a21:140a:b0:3c0:9c19:b27d with SMTP id adf61e73a8af0-3c110cfefa5mr48995637.75.1783706135810;
        Fri, 10 Jul 2026 10:55:35 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ae6cd9sm46484490eec.31.2026.07.10.10.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:55:34 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:55:33 -0700
From: Michael Montalbo <mmontalbo@gmail.com>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] sequencer: honor --empty when a fixup!/squash!
 empties its target
Message-ID: <alEw1Cxl_LkRQrx4@nixos>
References: <20260710-fz-autosquash-empty-v2-1-fa1e277e05f8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-fz-autosquash-empty-v2-1-fa1e277e05f8@gmail.com>

On Fri, Jul 10, 2026 at 10:42:37AM -0700, Farid Zakaria wrote:

>  
> +test_expect_success 'fixup! that empties its target is dropped with --empty=drop' '
> +	git reset --hard base &&
> +	test_commit --no-tag addX fileX 1 &&
> +	test_commit --no-tag changeX fileX 2 &&
> +	test_commit --no-tag later fileW hello &&
> +	echo 1 >fileX &&
> +	git commit -m "fixup! changeX" fileX &&
> +
> +	git rebase -i --autosquash --empty=drop HEAD~4 &&
> +
> +	git log --format=%s >actual &&
> +	! grep changeX actual &&
> +	grep addX actual &&
> +	grep later actual &&
> +	echo 1 >expect &&
> +	test_cmp expect fileX &&
> +	echo hello >expect &&
> +	test_cmp expect fileW
> +'
> +

Just a small drive-by comment. We should switch these from `grep`
to `test_grep` (and `! grep` to `test_grep !`) here and for all
the other tests. `test_grep` provides better error diagnostics,
and bare `grep` used as an assertion in tests will be flagged by
the linting process in the near future.
