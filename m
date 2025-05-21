Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BB322B8A4
	for <git@vger.kernel.org>; Wed, 21 May 2025 23:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747871694; cv=none; b=SnByBG4BTwukuMImOVUuVuNh3vi4FT7fM0JRLAmbkUpn6IAlXOzTvakKkA2LTxNIfFUmQQc9FQlcov8FuzPI/fbjIyIXj0wKTZUU0LqnAJtVNL/STnimpZoSG6sa6kl0N8cPWrE4tcWQdwJMPUwnVckaAaEjlC86a87MpC+rMjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747871694; c=relaxed/simple;
	bh=md0z5A5nZKiQCu/6qucJ5vFJll/ZUikEz8pEUJEC0TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvQ4IOm92yNO/KlG9nmF3MaRb0ztiOm2KDOVWPh8qL9xLfxF4Tcp284sLm0AtfvyO+Z2QZcwCk2T7Napay2+30IKWmn+XJI7kO9y3VAsS6GApFOYIHPfvaoiACTuoncJVK6Y2sYltqsbExqZo/Vbqnppa05FEJayVgpsGpxkcoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Aqycmkwn; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Aqycmkwn"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f8ae08e3b3so71729656d6.3
        for <git@vger.kernel.org>; Wed, 21 May 2025 16:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1747871691; x=1748476491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zlVzybWq9Tu0Xt8P3dZg4HTwmp7KcJ/6ZSgNZfzkLYI=;
        b=AqycmkwnBbTXb7HH6VLoldcHt/JXYP9zyebBwf98g/bfvYRFoZ2nnWTWxC84TgWjXb
         tfvGudsDefCG8XUfpEDNAOElf1qu3jRobyYSnb3YInjbFfIcsU0MCSWg02g3fSu6/YcE
         0exH5/uCU/ib5FyW/tYkFZWYjTcyPtOrROkx46S4wE9COdHMe5HEv/cDEDffRkofXD57
         0jUWBVO1mmxO9EjC20Xj7u1sryeXGVIBkMG2mqOg8sRfwJZBZxz3HKiJrLdbkOPPz2yU
         bwQIpzgrZRdsj83osBOgxVj1RUef/6vLM5pwjzrmwZjnuoBDOldkEAnjWzU51N+lg0yl
         JH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747871691; x=1748476491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlVzybWq9Tu0Xt8P3dZg4HTwmp7KcJ/6ZSgNZfzkLYI=;
        b=Qflh351sTlZOfgme7SzolAp0k3NckMHiLPyXYCImM0jGFOq87Pnchm4LL8wZU4L+51
         k2X+PMN8/VzQrNnhb8Gco5SbylaNftO/D5wRgGTpYsbD3C2W3Adx/3ojH/yjH7waSfDv
         dfjWsFIdYQ3+P8zJprVCgQ3nz7bbz2N0250hQOCz/tEIeZQayvMR5lQb+8empis32z+n
         /Z3hdn5R5CpURtl6/IglBofqNc506nKaUCgApHRDmbaEwlrCehRi+xbY2XuA/5LoM12k
         cR9nAYAm2kRqhjfB44tztTrLEnUm0q5h/XBu8SXIk3VR1bfiTK6mT/AiHTJzc4D/U+WB
         T+HA==
X-Gm-Message-State: AOJu0YwY8IkDFywtEyz/9EqhZTiTNUJt8Md3j2phu7KfBpAOH5f/WEeS
	A7viQKpgoFzXWD/1SStBKjqHkQmExU06jPk0wrtJlobprHj4c+n/xnL/sk+Yqmg0d1+vu2uTli1
	mmCjk
X-Gm-Gg: ASbGncu3DIBCJWnrmG0XqX0f90gbaquO2ThAb6M2Go6IwnqqDCEmhI41ym2ud/bc57h
	ZryUbIvpndfW5lw+5cs2jC4ZERIjJaH3bN/eX5s74y5ueF8hbA3nYNEWWbOXLcuoV8DUwfOyBs5
	dQYazcbYFeYobXygrWYKNkvnFbugQpwEuXndFtqXLi3HqY+XXuI2FnwAXO9QJ+hsKabGaYbBCNy
	ErwQFF4HhgLItSn+Pyd51J0z10W2BU6iooWV79Kcs8a9ZH0crmR5rl7O5YMwBHGYCCjDd9CgHJr
	TdrkPcjXNgMKbndXE6crOvZNSJjtmHVnHmBGARP944YjWG2u5lefn2o1g5rtg9o6JIvJw9JlqQ6
	FB9NAlZe8rFCCQbsIYd2SA0M=
X-Google-Smtp-Source: AGHT+IGqhPYtRLA/3x9SruOwL0R0pzGpwjIxc836mpLak3KAxccJcZlfsNMpgRuPPgYevYjTC5ZJ2Q==
X-Received: by 2002:a05:6214:1cca:b0:6f2:c94f:8cfe with SMTP id 6a1803df08f44-6f8b08b7479mr388147656d6.23.1747871691062;
        Wed, 21 May 2025 16:54:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b08bf5e4sm91649896d6.61.2025.05.21.16.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 16:54:50 -0700 (PDT)
Date: Wed, 21 May 2025 19:54:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Taylor Blau via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v2 2/3] pack-bitmap: fix memory leak if
 `load_bitmap_entries_v1` failed
Message-ID: <aC5nxa0uTb+ieiML@nand.local>
References: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>
 <pull.1962.v2.git.git.1747732991.gitgitgadget@gmail.com>
 <b515c278a8fec6c2ab9d11a49261f44fe0f37bf5.1747732991.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b515c278a8fec6c2ab9d11a49261f44fe0f37bf5.1747732991.git.gitgitgadget@gmail.com>

On Tue, May 20, 2025 at 09:23:09AM +0000, Taylor Blau via GitGitGadget wrote:
> Signed-off-by: Taylor Blau <me@ttaylorr.com>

This commit forges my Signed-off-by, but I am happy with the result
here.

I do think the series is structured a little awkwardly as a result of
adding this patch to it. That this and the previous patch have the
subject "pack-bitmap: fix memory leak if `load_bitmap_entries_v1`
failed" make the series not quite as clear as it could be.

I think there are a couple of things going on:

  - This patch is a bug fix that could be applied independently of the
    first one. The rationale there would be that we shouldn't be leaking
    the EWAH bitmaps in 'b->bitmaps', but we are as a result of NULL'ing
    the pointer in the "failed" label. That patch can stand alone.

  - The first patch (yours) is no longer fixing a leak, at least after
    this patch. But it does delay reading the bitmap until we have
    validated its XOR offset for sanity, which is a good thing mostly
    from a performance perspective.

I would probably swap the two patches around so that yours applies on
top of mine, and then rewords the patch message in yours to reflect that
it is no longer fixing a leak.

That all said, if you feel strongly that the structure is fine/better
as-is, I'd be more than happy to discuss it further.

Thanks,
Taylor
