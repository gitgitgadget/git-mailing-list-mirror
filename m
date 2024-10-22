Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C711BCA12
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618782; cv=none; b=nKYVi6ntCCQwkGQJguugimN81AEYzG8pSRT4Tprw104J+NRXQWpuel0saVyKOK/dBnLQlLQ0uWSGflu25A/j/qNUka73p7q/wmnwcvnlqjLwAlYKS3iF/UQNSCgPDKtP7g3e4cnYtDBVjAsBela/ybnx+cFQ1YhFHGa+tEgc/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618782; c=relaxed/simple;
	bh=QUlZyxuCwPMrlnD+SSs22gplL7ULOz8K5gTOISSgbIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvtEu7zczeTdBGgdJTzC6J47M3+blEP0mhmD7d32byOKHbsE55v+tX4rpEJUFmuPU8f6mh/dw95kJAK+3sj2I3AzuSbU+13aDiynmlUlI6diwA2QOYRSb0eSup0L2UwSyWvmwL8oWXawoEKTGk5JZH92Z4z5LkJVc6NOqOSMaZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=bu76Tpnc; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bu76Tpnc"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e3881042dcso52830897b3.0
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729618780; x=1730223580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JEg1gmMke2ywfE8QKK66tmMcDkMnES2vbKf9uFWAQJ4=;
        b=bu76TpncbS09TV84QaBOhO6AfzlCpl6qqpu0FKTyf4X32/r+1quKvDMtbhsi8miwfQ
         dQNz5PJ4vYMvsgZt5SIOUZcpA6Q5OydXu8cIX9EUEBsHemvmB3s+nj8ZrN60UCHOVIoX
         bgzOY4UFELEAMFYvOlG/6880yVL9xjZfe731GiYPm7O9XIIOy5CICfjo1uC77klAzjM5
         ffmuJWaKzL7gN4mcHRO0mgEh3dc6Ft+M0JpxD10kLZdz4VB+fvrhpoIdFLmaPteI7htT
         gsnofjnCUUBzX6Jlkch6WXznEJ5X1jd/We/AzLxWUbCxlRRBf/uT+JXIUDmzxgHrDJ+q
         7uvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618780; x=1730223580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEg1gmMke2ywfE8QKK66tmMcDkMnES2vbKf9uFWAQJ4=;
        b=jXejqVdJrZQYuKav5KZ5sgDXrgH4PEF6GWuJ9trh70zjEHWqo8tG2+COYrBHB4NKRf
         /5fcPVVwzQUjCfP89SCHg3o+AG0250qqj8OZ6aG4oRg6y8djaPuDvqRin/dVwZsVFBId
         +Tg3G4+2POjwvbQm2fQV8SbChF6FEEZcY9SmRwuReihSQYgfzupnnp/LhwaVgdNXnP7m
         t+6Kd8NvRsrysCnQ4UqPwqkgkTA0XMdpaB0s22179PwIyWVknxaXvilEsK0i3sNINaVl
         62nT4E9/Zm08pQlNwf/2HqZjHS5hK0mcqCVfl5/3xClN7KE9KGbAlD4hUdQYK99eGLWL
         HvJQ==
X-Gm-Message-State: AOJu0Yz041NjMXiyREVd5OZgS6jwxTKUz59UBzxyGwUg3d/UM9txsx4B
	LHzGsuWWXIb0p1ktJuCrKIVl8Tbhycy/ZL+G6Ah/cnrpqFtvrPc2uf8rsdzjH/DOdYKb4DNEBQT
	0w/z3fg==
X-Google-Smtp-Source: AGHT+IHIjb3/FDiSpKOlDZPrJKl9QO2gkGbHQYAk8T8XGbMnz4ozTpwUq43i/BJ8Kf6N5Ua/K2h9Qw==
X-Received: by 2002:a05:690c:6012:b0:6e3:323f:d8fb with SMTP id 00721157ae682-6e7ef13b0edmr3790497b3.14.1729618779689;
        Tue, 22 Oct 2024 10:39:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5a4d20esm11583447b3.40.2024.10.22.10.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 10:39:39 -0700 (PDT)
Date: Tue, 22 Oct 2024 13:39:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,
	=?utf-8?B?RsWRdsOhcm9zaSBWw616bcWxdmVrIFpydC4=?= <noreply@vizmuvek.hu>
Subject: Re: [PATCH v10 0/8] set-head/fetch remote/HEAD updates
Message-ID: <ZxfjWnZF4EbtVH12@nand.local>
References: <1088915169.629942.1729445083543@FVRT-HAMMYAS-P.vizmuvek.hu>
 <20241021134354.705636-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021134354.705636-1-bence@ferdinandy.com>

On Mon, Oct 21, 2024 at 03:36:57PM +0200, Bence Ferdinandy wrote:
> Bence Ferdinandy (8):
>   t/t5505-remote: set default branch to main
>   refs: atomically record overwritten ref in update_symref
>   remote set-head: refactor for readability
>   remote set-head: better output for --auto
>   refs: add TRANSACTION_CREATE_EXISTS error
>   refs: add create_only option to refs_update_symref_extended
>   fetch: set remote/HEAD if it does not exist
>   fetch set_head: handle mirrored bare repositories

After applying this topic to 'seen', I noticed some new CI breakage that
appears to be caused by this topic:

    https://github.com/git/git/actions/runs/11449483611/job/31855171514#step:4:2506

After dropping the topic locally and building with 'make SANITIZE=leak'
and then running t0410-partial-clone.sh, I was able to resolve the
failures.

Would you mind building with 'SANITIZE=leak' and running that script to
see if you can address the issue? Thanks.

Thanks,
Taylor
