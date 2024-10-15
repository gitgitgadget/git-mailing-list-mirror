Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4D113F435
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728991965; cv=none; b=QA2TALEB6lvPY9L2JqewFoGacQ9A6cHzC/Mw5HsOGEhpP9zYuEsTOfGItPfnEylqYUPKBW2mQw9VmIn/8h41EuFlUGdeCRgzBwAl+vnRqbAqf7XANL3bOIQl4zNf+CRP5Wjfi7LpenWBCnkKXn9xCWGi7U64GTSQiSG71DSRSC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728991965; c=relaxed/simple;
	bh=aeuVDQbuRvjVmcAhnyXz7Pkkvb4FpDYnzmqnlFx7WBA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZh2gWd64eiseedBydwu6XrjETWpRTBHRzg3TtEi/Yiv/upemi4V+XZbSokiGvJbLxDtuLZm+k2Smj/s87vEadvAe5X9k4cKZ965zdMwoIMRi3XILUse8GN/ihUvOIaB1wLcwJKzPsN3lwVZ7E7jIYKzRh5aeQxEOXc50AsIZng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ucla.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b=EDpMkg/B; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail-com.20230601.gappssmtp.com header.i=@gmail-com.20230601.gappssmtp.com header.b="EDpMkg/B"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e5a62031aso1641486b3a.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 04:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail-com.20230601.gappssmtp.com; s=20230601; t=1728991963; x=1729596763; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aeuVDQbuRvjVmcAhnyXz7Pkkvb4FpDYnzmqnlFx7WBA=;
        b=EDpMkg/BTt3vLQ4d87sI0qZ3MSwfgpO3CxunIf1siZsMAXkTlw5HEN3O1zHJV++SiN
         9P/51TKM80Tv2uo/OcB3TmnGhIFnGd+vPRRuJKv5HZ5eHrTnhA+D4Nnta5LjmSMf4Kn7
         LuNidHLuZJzKEJ9w96ueQqVLCJW0aBseMD3uUZzyFmiUQanBGP7Ii+OdCvu67PPcIIhs
         S/tCShw2GwIFbPWfAiNC8k3LH/ZdOfxapPNBBrlxP8CmxB+H2t1Grn+HjXmMoGGMGM1z
         9SXMLQ+HdHnctUemmGrtaQ8n6it3QnSILng088tfVX7YCrqXBcY67wVMwfjAtfZ5KDsr
         B8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728991963; x=1729596763;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeuVDQbuRvjVmcAhnyXz7Pkkvb4FpDYnzmqnlFx7WBA=;
        b=hxEUvgZgybyqsW/8KdXuF7m6rzXbwfPKCZbtaJyLzOpLZePDfGBOLrXnXNuZiyVqtu
         xStI2BeWxbpE94+1XPxuKHze+L3F99rzAbgDt4hqTL5FLc5ULT2UDc3xoA62CwTWZHZl
         J3pAcaGUPADGYAP54wtFkEab4KuKBzguLwJsrvCwG0yy0wmQv+6CBS+g3BZPuPhVudnu
         sHZ64hqx71r0MLhP2iIIJIetrqu/vXyC6ZreNwI2fgHfetJizWbbMRftaxxeraYOeBZi
         t6VmjtO/3wv+FuSC52jhDHlE8F1nvv+/B3GdGU94vxDE65ZNRzzpbbckbLxohs7o83Xw
         Es9g==
X-Forwarded-Encrypted: i=1; AJvYcCWArGGwiu7tlaxJwYBaV5FskO5qNa/tdzfeUjWWh75Sh+LCWKDwmYJfD47W0Nnbmgc32Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhRqSGxAg3c3tR0ekieUTBGqkiBCROtSsz18hF+EwRKwUtbw3
	UlpK71nQ/wsxo3SYBBZKNYypbl/5Fq54WaEUe2Q3IRJ4qVyYHCosENw35U3fefe+SQbp5ouZwSF
	sxc+kOxn1Hmk/yp2OT5eME5eGz98=
X-Google-Smtp-Source: AGHT+IFyUf7c5Np7AoP5iLj30w+lP/kEriY2NKsw8jwzxhBGWPXV2LJ5Qrx9K8AoFVwyUcAsfPzpGDLmchnn3PSC6ZU=
X-Received: by 2002:a05:6a00:1ac6:b0:71e:4786:98ee with SMTP id
 d2e1a72fcca58-71e4c1bfb67mr19483216b3a.21.1728991962895; Tue, 15 Oct 2024
 04:32:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Oct 2024 04:32:42 -0700
From: Linus Arver <linus@ucla.edu>
In-Reply-To: <pull.1811.git.git.1728820722580.gitgitgadget@gmail.com>
References: <pull.1811.git.git.1728820722580.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Oct 2024 04:32:42 -0700
Message-ID: <CAMo6p=Fo0gp6Vgq73E6k=Q+tV0g8EB3L_AEWq_4e85G86QUc1Q@mail.gmail.com>
Subject: Re: [PATCH] trailer: spread usage of "trailer_block" language
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>

Hmm. I just noticed that GGG (?) is somehow inferring my defunct
@google.com address. Not sure how to fix this... any tips?
