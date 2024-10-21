Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D040716A92E
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543613; cv=none; b=ghzOxfa0eFVQdq+U3SkZ8jlLpa4DxTk29azAN+yCtAhBEJOptMm9TeNmuUX1HBK1jH8Zp9ibteiqUJB16JvNkoBtT71rAY1OxIFyVdQ+u1uXRM3IWs10SV8nIT1/qH62pe333rtQO927wBLy3CIttVOXcrQRE0HJEZtnc6fcRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543613; c=relaxed/simple;
	bh=28IfgCSBB3QJTuWN3UlPEJ0nmkSv2cuGnicxkWxDoKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORXeqEQnvgyPxZZWrVi464tzxuzf1eJcQJ5LYjhoN/qpcg5N64NWUvfH/tkPmk6oLPxrwvpZjvWqTyG2Y/IawIWxKa4RRzKVj5fvcBwr0fO7rAoFnScJLkn/EsyFKqYIIcNlivj1oqmq8W9kBRQEo3F5uYdbscGcHAmvq2+uAyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qrcvxypW; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qrcvxypW"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e34fa656a2so45777087b3.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729543611; x=1730148411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8yCT+CfNQqYRuOHD8jYBEtOo3hs6/zA82X6oqV39XVM=;
        b=qrcvxypWZ2hx0tkyWgNrYbtVU2fCt46nnsc48BzMvQf35JGdZoQ7SdsxVPvbiVwMJP
         sDmgIHdQVlAqcgtxu4Bn5twhF4rSCJrHRKq8fAeb9kO4iea7/34pzaHdwXPECYHamYA7
         0TVYVs7yPUT9XYvZZVYMRj4KaHlIfR1poJIxl+y4czbYRbhD+fQOT9U7FaSMoE1umiWs
         AZng1gAkVw1VcTEwBBYBD8rrkiZnlyvrww50+PyJp7z/hl/8LTV632gr+lb6NRwZG3/f
         5WDIbBEzFgFBLMwvfXjd09oMzikJydNcEyxNleEW72TsYXcQvNwdMrLWzOxSXEWHxDa4
         cQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729543611; x=1730148411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yCT+CfNQqYRuOHD8jYBEtOo3hs6/zA82X6oqV39XVM=;
        b=ElcJVIbNAQ4WEW0H/4YQrBaLcwvvlda6mlIXRWnE4zlCT8HGM2DoIFPYYg95/Tw0Rl
         v4PbBAMFGEAXrbYrPy9gc6Y84EKqGIxCU0m6zIpeEDCgA4IWErHhsJcu8ZHlyb/YDJ5l
         LBUZAlgDaqQKcgK8dO/Gt9FlCtYnY25cysc22EB8NwvL056xUz8Ryv/qFd+wBbDDPggV
         95kewaiUroe/7ZDymyHFWcua5AZbYQX7NSDohnN909b9ySEfPEBG0hoDuriA+e3vFCdA
         Xef0jmPKJfqID+JQueiHDPWybDMNdE1EerqNRR5DIeooi0x0/nTJNsXMDH0UdLl8/DCp
         uD2A==
X-Gm-Message-State: AOJu0Yx9ZrrIGcCyVEVqC0I3+8JzbNBPIQFaxbxOKVtynZjR6hwQ/zIT
	jYLG5f69XGt0VYGmywAbGZnwLhkfgBrZ4eZ2F6epMda8pjSWU0cV8Ov9J5OxT0g=
X-Google-Smtp-Source: AGHT+IGfkw0EViLWkKBr9JRHlNhsugn9a24B+Rmw02Wd5qjuvF3otp/n4eB2T2fWcmjc6+2r4TtApQ==
X-Received: by 2002:a05:690c:d92:b0:6dd:ce14:a245 with SMTP id 00721157ae682-6e5bf74391dmr123190247b3.6.1729543610771;
        Mon, 21 Oct 2024 13:46:50 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d6f999sm8101127b3.143.2024.10.21.13.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 13:46:49 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:46:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v3] ref-filter: format iteratively with lexicographic
 refname sorting
Message-ID: <Zxa9uD2eZK8PxMP0@nand.local>
References: <a873ed828ccae426214cc8f87610df97ff9a269e.1729055871.git.ps@pks.im>
 <d23c3e3ee7fdb49fcd05b4f2e52dd2a1cfdc10f2.1729510342.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d23c3e3ee7fdb49fcd05b4f2e52dd2a1cfdc10f2.1729510342.git.ps@pks.im>

On Mon, Oct 21, 2024 at 01:33:23PM +0200, Patrick Steinhardt wrote:
>  ref-filter.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)

Thanks, as you note this is awfully similar to v2, which was already
looking quite good in my opinion.

Thanks to those who have participated in reviewing this topic. Let's
start merging this one down to 'next'.

Thanks,
Taylor
