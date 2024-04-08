Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75A7144D02
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598661; cv=none; b=HZjmpXjsa6Iqb2umDtNrCvmg61vaewbW60sKo9NZxnRGM3AI2z+0Lb+wfMWv3icR7h73+bXw3BQzNWkkHUDBnS8+mUftyXZS8WoqaKLNDjsHaHh+N2bZ4GeEU2H5oxqEOtmwn9pcurAGqP+hdAuRyGSBmx9DEWX2rOAq7itwiNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598661; c=relaxed/simple;
	bh=O7w/nL0A0vz7JIb4x3Tb2FiYTnIwA2OQxERShEvl+Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5TajCzlKF46USuRw7PvQfr55EWJKxI6x4kt+Gj+CBApLygK+Sks3hoF+ta+VJ8cFe9tk7pnjagqaFzGHxBkHXGh/S/xc4E/Z+0peHshP10MfbvL40CRSswqaCxXzklRVBs5I2cjn9lTmVQxmEGIhhHYa/Agozs5tNFm2Su2LlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+pMOyL7; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+pMOyL7"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a53eda3272so608298a91.2
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 10:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712598659; x=1713203459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ymBXqGL26t3qYXEZ0TFXEQcX+Okq6LPFuRHLxBLYlLo=;
        b=N+pMOyL7QbKlJPXVkC15D3UT3ZIFukLiR4P+y4ydKY1laHX41KFdQXrtNf01FzjWn1
         u76JJTPpQe8AggneaIfMolhOcVGyzjvANmlabzv2JKdjb6BzWvlgcxW5ir9lKpCs1Kmi
         7l5pqv/wJXeyvonjDfyie/hrt5vUWoicdCm9RynBrcIUPHbrypv+PYPkD7rfjPehRRoE
         KCBU03p9WMxzyjw66GtOIo2/PAXKcLA7VEZQxrIDhNISOXyuQToh5cPMiYXjF0sRfvV2
         +z2bcIiGNU1+K+U9X79FZndm7pYlqB9b0PR+FmzBVB0LGvTIV1eru2XxJmceh7fQ0SUW
         sW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712598659; x=1713203459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymBXqGL26t3qYXEZ0TFXEQcX+Okq6LPFuRHLxBLYlLo=;
        b=Lze4QAT9e/gfu9LZ5W0BZA/OSjmvSh0K0oFaD7eMO0wgQVZgj49TvqzdwuN6P+PM86
         /Ch+BRR1AeTkIhPdscu7uyeFzhcKJ/2uaIskAUDRXZlxpzt5VuPwduOxev/m8KPrePdG
         SnZTiQfi7rEIP57ocsU0Ku2/2aVMd3voKpg6ycrRWLFzIuskDV48c8B2+OzbbZL+FsrT
         7s5MaIt52JpWZWGTtFRsqDBZkVqXG/eLEO8sQQap6ORcy8UhIA7VODETQcx2mHx8hUpu
         e/0D0zGSVjMfkkUs5SuCIZtDfcOoD2PrC1h9CV1UDfWu28rnue4IFoGQI2nqDHnkelNG
         TpKg==
X-Forwarded-Encrypted: i=1; AJvYcCXro4DTf8RQxzUZg/6Ux7LZ478l/7vmbTXKxrn+gFwa+7gGCkrioRSy/DUC1C9JWGvWWJx/DJW3/eT7YNMT5vUeDO2H
X-Gm-Message-State: AOJu0YztVvz/MrUyla+6brfz2V9BwaXlGH6R4PZf0Us/pbT2sjmgJTWZ
	Z1n0f+SjzJTCYDJCT0G2sJvdJ9MZFe15Wa3bzIvIYBwdwxamND+MBRmY4w8dfazJcaMUPNocUHH
	jPahBK+PgR9WS/fuphy7KbARmoxI=
X-Google-Smtp-Source: AGHT+IHjxL2gh3E9aSf0HzDehOd2FU4dFwFIBGyYa5YVY1jYBxMhNH1mBBNWvlo9374hXGz9FiHmVH9iHrfn7YSslaQ=
X-Received: by 2002:a17:90a:4bc6:b0:2a2:7817:f591 with SMTP id
 u6-20020a17090a4bc600b002a27817f591mr7205383pjl.48.1712598658954; Mon, 08 Apr
 2024 10:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <963961ee-0f1d-42b8-8dda-5838e7a2ed94@web.de> <ZhOETox9FTIOAShN@tanuki>
In-Reply-To: <ZhOETox9FTIOAShN@tanuki>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Mon, 8 Apr 2024 19:50:47 +0200
Message-ID: <CAOw_e7Z9dGeVU399D6o37L3am0abnYUrZnNQEFKhyUv=A2=j8g@mail.gmail.com>
Subject: Re: [PATCH] reftable: use xmalloc() and xrealloc()
To: Patrick Steinhardt <ps@pks.im>
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Git List <git@vger.kernel.org>, nasamuffin@google.com
Content-Type: text/plain; charset="UTF-8"

Op ma 8 apr 2024 07:44 schreef Patrick Steinhardt <ps@pks.im>:
>
> It does raise the question what to do about the generic fallbacks. We
> could start calling `abort()` when we observe allocation failures. It's
> not exactly nice behaviour in a library though, where the caller may in
> fact want to handle this case. But it may at least be better than
> failing on a `NULL` pointer exception somewhere down the road. So it
> might be the best alternative for now. We could then conver the reftable
> library over time to handle allocation failures and, once that's done,
> we can eventually drop such a call to `abort()`.


I must admit that I didn't think this part through very much; I
believe someone told me that libgit2 has pluggable memory allocation
routines, so I tried to make the malloc pluggable here too. Handling
OOM better for the malloc calls themselves doesn't seem too difficult,

  hanwen@fedora:~/vc/git/reftable$ grep [cme]alloc *c | wc
     57     276    3469

However, it is probably pointless as long as strbuf_* functions do not
signal OOM gracefully. There was some talk of libifying strbuf. Did
that work include returning OOM error codes in case malloc returns
null? A quick look at strbuf.h suggests not.

I would just call xmalloc as default, rather than calling
reftable_set_alloc, because it might be tricky to ensure it is called
early enough.
