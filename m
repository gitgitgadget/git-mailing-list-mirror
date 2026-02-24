Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9C42874FE
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959287; cv=none; b=I6nWs+dG9HA8IA/r1mif75BTfJinw+Qci0oMUEFOhMXaf1h/CEKpeg3DCuj8Ewob88GSiyfvLrchr7cgOBw9dnj7f9cz83PZRfbDUuG0A5t7Cq16zWE8yU0R6Rl95WOt0NL6ErHBrAdcM0ZI50xZ9nKLH8hQr2/P1UXgWqCSMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959287; c=relaxed/simple;
	bh=lYulbqz11FE1v3Kh7T05hrbe9dFHrERewRobuXQDby8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m48thsmP2fie9zz2BqDZ+AiNbUQRm5n0ZCEe89dN95W/4COV7xuhUIea/52VuwPPdQnhE92cAWW7ObzKeBmdVhTpTuiHR08OPMcMT4uXFF1UmFkf/S4KKdakeh8hP0l44m+XCjalnGnroJQPeuMnPgC4cwgNJVHx5DK15Q7mjZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFhjS9RU; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFhjS9RU"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4645dde00a7so137954b6e.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 10:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771959285; x=1772564085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2rYGPXjrYxeL9LYlHx/Xi22tlE5KnImd73S0aAhN8SU=;
        b=GFhjS9RUSm+K3ToIuYxZPTpntLp4GIthJhExZGnSgoMaDlvkQ8ZOUYAyVWHN7F0E7N
         Pd7F0qfFgHcJLyb/iCw8Ob2/Bwf60Z832b1cNv7pJpZr4tXl5PVAA9wB0VwiG+/nPF2r
         yFqogjfttHDClnbKW1euvyYKkQ9SiIYo7LhGYdOSMMjLMYH2YnQe/rrd3r1rPoy/7295
         4/CLcpM8RvdxaIykAXUfsTffpp+evFmPhwjBGQ5oDz/rl2hYDRX6PfSbDHEKGgnqys5O
         Sn18y9nGddGcBs1uw5ZVlpKL0+V9HuELRfCm4eulFSRG0vZ5OA1WKQPPbnlf0V3nJB9i
         wQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959285; x=1772564085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rYGPXjrYxeL9LYlHx/Xi22tlE5KnImd73S0aAhN8SU=;
        b=u/qUt+fxoMECnUHrxDsZKb6M59n8lhk3myd3J5zf3PeYnCdLNsKbeVig8i6LRWGmGU
         jCKazYKEt3HWwv5SDk8eniKb674LN+92NfspueoJInla+PrJJtbN6EGtnQ3bOvVAqpqE
         3SMqksP4jWPj7iIcwNV5BojEJO/Qy6lwK/xaLeyq6paeaantlmUc/MfrcLm1Nm+LSVr8
         pzSQwoEicUn1tfx5OkOL6Dc2vg2BuqJJZprwHiv+DL7EHi6hrx3/jMUDq4NQFwS3JczZ
         AectLyeCE0ypOvIJFGjM/ZezkmLZ4SXAYa5ZpBE61itVkEIa4XgoiiR/WQrjbrWgNW0q
         R3zQ==
X-Gm-Message-State: AOJu0YwIHKnXRXU1j8LyKTrMtteEYMZ61gcsIXIfCWeeBmuswR5m59BI
	BxZgd7pZ7FEaGC20e4Laone8zBQJiQYmtKdB8IkpwXa+DLvF1NkhB3yta+Bozw==
X-Gm-Gg: AZuq6aLjRPulytx6JSNJNzqnpoVEnUNRC2JDhWpwCIA0787QPDOpSyG9hI++tyN4a8X
	0fu4ByEhJys5ptpGR6VGhcK7RkZrtneOzVNkhnKYpcv4uFW+/qoMwAUu8oPPTJAkktel4Hpr6eB
	oco/4qlJoIwKteSoXanPl47lRQMhu7SEY9N3ozxL/BHiFeQCBK7jyjk+Kx0WTDycF9xy4kYWeYw
	FLY1RZPQMs80/XC6yQWKsrU298u4SVgq7oC+nL2f4dP4l7sVxRJaXp9EbT6ZejTf6GzHKhBmZwA
	U7QMnILRwQQOxE+FoBWHzqiNTP70eLKoIW0gYPQ6ub7pKBbdWFoLoilkml3KTkYLH5aRwR5EvOV
	BPCrjVVeqxMsj4de1eBycKDRTRXBhH8bRHqQ8O9MGc3Dr1fzNwIGANtvi2I00Yvm5P2AqNCKRk+
	OQFs69/5HD8hEWknWR
X-Received: by 2002:a05:6808:6508:b0:45f:1c21:75e7 with SMTP id 5614622812f47-4648bd55136mr560431b6e.22.1771959284849;
        Tue, 24 Feb 2026 10:54:44 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4644a1f66easm7489561b6e.20.2026.02.24.10.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:54:44 -0800 (PST)
Date: Tue, 24 Feb 2026 12:54:41 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/8] builtin/maintenance: use "geometric" strategy by
 default
Message-ID: <aZ3zz4m4OJkw0Yfz@denethor>
References: <20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im>
 <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>

On 26/02/24 09:45AM, Patrick Steinhardt wrote:
> Changes in v2:
>   - Document the updated default strategy.
>   - Clarify how this interacts with Scalar.
>   - Explain the current landscape of strategies a bit better.
>   - Leave some breadcrumbs in the tests.
>   - Link to v1: https://lore.kernel.org/r/20260220-b4-pks-maintenance-default-geometric-strategy-v1-0-faeb321ad13b@pks.im

Thanks Patrick. This version addresses all my previous comments and
looks good to me.

-Justin
