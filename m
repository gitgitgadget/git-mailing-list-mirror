Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF102286B3
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LiTd95/3"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42786514fe6so4088061cf.0
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 09:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704389765; x=1704994565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D9h41dQtaiJE+Ssl9mN/PlmxJCM2LuI3Sh0T0aLvHjI=;
        b=LiTd95/3GTd5wfGGCAgXcxXV5rotfLfhxQvVbX7LBdWWJgxyTSzyJJMjOlMpocRNQ5
         ywsn8yXhf8ua/zw6Y5K+/KUYQD0I08M/iwTs3JSWjQf69IGUGTsRYdz/zOTTT1rKh/LG
         DtKABU4mtEnqad8iZpLKlrPvMVChmMWGPkC3+9Q3GSh+tRMFjb+HyA8APtWfdZv1XAGg
         w7rfoC2N6thWMlrhC5v9/moc5b2AqNGKB4vkk3H4Q0x3yvTmqTnhweNanVokNv+AIy5x
         73jzGO6Tm7D2O9qgvhRYhbE79LCEA3hSjd1pfyjSJBWDSRBhISFuqcBrT3BDm2Ao5mZK
         CbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704389765; x=1704994565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D9h41dQtaiJE+Ssl9mN/PlmxJCM2LuI3Sh0T0aLvHjI=;
        b=YaLdRbFrCb1Wua9OAsHbQ8BXzaV+QrzgnjWzuJ/eJU/Go9mLlZhcK8sAdzHCcKUVdS
         bLsWhdUh8L4EkCHGMhNfwVruhFKgSiYCaQQjUQT72hoUcRZoBQI6cQdEU+j4pbFFjhCy
         kboJtlkNjyr1A8OdyQgkRKvZ5RGvmCWJ2hSqYXE9HUTFO6HqeRu6bwdeWhVnrtTBjVwi
         yq+Hs1kynTrmDWghstM9uX1GUCziWu0++4stiyU3m7GzMR6RW5mSr9nJADBKJpUbM4dv
         qU6x+CiA2BORfOeoZxwjl41H/KZxU84NuVpj5ccIZyuuRvpYWK1PpvpO9tHt8V88XXdr
         3pFg==
X-Gm-Message-State: AOJu0YwwTxWrCAJGwG0sPCltr43ACAZrnr4LiZYg+lhI3pFMb4pcPGPC
	h29wRyGkY2XCyBPjeZ2bECnYUb4cZCrotg==
X-Google-Smtp-Source: AGHT+IFuQtVb5mLX0Inj3cYKdiH3zdmMTlnHP1JOCqZR9FCMKFpYmfWWWyWw9+LXqCeXMBY0Bm3TQQ==
X-Received: by 2002:ac8:5b96:0:b0:428:3aa9:4aa9 with SMTP id a22-20020ac85b96000000b004283aa94aa9mr1045147qta.20.1704389764855;
        Thu, 04 Jan 2024 09:36:04 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e13-20020ac845cd000000b00427f1d53a37sm8539351qto.49.2024.01.04.09.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 09:36:04 -0800 (PST)
Date: Thu, 4 Jan 2024 12:36:03 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v3] write-or-die: make GIT_FLUSH a Boolean environment
 variable
Message-ID: <ZZbsg6HG36gjXnhc@nand.local>
References: <pull.1628.v2.git.1704268708720.gitgitgadget@gmail.com>
 <pull.1628.v3.git.1704363617842.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1628.v3.git.1704363617842.gitgitgadget@gmail.com>

Hi Chandra,

On Thu, Jan 04, 2024 at 10:20:17AM +0000, Chandra Pratap via GitGitGadget wrote:
> ---
>  Documentation/git.txt |  5 ++---
>  write-or-die.c        | 19 ++++++++-----------
>  2 files changed, 10 insertions(+), 14 deletions(-)

Thanks very much for working on this, and taking some of my suggestions
into account.

This version looks great to me.

Thanks,
Taylor
