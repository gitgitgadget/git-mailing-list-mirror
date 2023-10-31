Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699271DFD8
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nhcuVedn"
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A537791
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:16:59 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5afa5dbc378so43741787b3.0
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698779819; x=1699384619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vpNOIiNZmkr4GBEzs5rW0I+8M2wJzdbflVeYiKPVdQo=;
        b=nhcuVednhQ6v5mjzOuPIVmIodYBj0wnI0YwdVWT3Hu5I+9FjlkpwU0VkUpMiPtt/Os
         qVdKzo0ILKBcUygNDN8w10OCCQgw10IpQQPYiK2ygq1TSGspzqDrqtcu/9MS272hh64y
         eRrrFn56EtQtZLw6E9tpB/K19XsINBnxH6U7V1i7fen5IO7vM2zS3zwD4n0TCjCzBSr9
         OMtGBRO3lQqaGc6Wf/8m8wRygLponoBi7dbOPS35uE9iJJqWFHxD+PpqeTI9AfUo8e0n
         OB4A/qqCNwMk7u0MBUo/XSiUth2tWJdQh+rGEYeOdVUIu8Ms7L955yfm4cWXMMcPU9zs
         WPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698779819; x=1699384619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpNOIiNZmkr4GBEzs5rW0I+8M2wJzdbflVeYiKPVdQo=;
        b=WQJAGt8rRWGM5lHeIQ2ZlCwwfKtcD8Vzq2rQ3KQEcTwmzJBQEmLgKKfNzmcRz8ZJNd
         pTFyRTwxHxkauq4/+XOg3LqjHvqa8MGjUrQcd7qxmEDYFqlB4PGTYOWvpZ87IX2Sl4i0
         UC+7ILDgN0a+vKlnYXFhUyN83DF631DR/I+Bab20tiHMikNzsX28qjchHrWnX52qGmTN
         1SX4YeyPWUrox4d4qZCf1f7ZsLZEmp/hS3fZiY9sHok55pxhuoGPtsE0toIx801rz9Aa
         jJfxzpFmZaYi38DuswfOq38b25rn1WF6AOr6OCAisUbQHlLw86Qq9E6UUdFwDDeuQNKK
         pqNQ==
X-Gm-Message-State: AOJu0YxsPaQcPtvHroXFCRM08bWEmWM/YacaXbGrlCG8Kzh5xpHSqryl
	nBSCYZmhYXlrFLNngsl5qswn1mUxRancyfhAcO1ZSA==
X-Google-Smtp-Source: AGHT+IGkTFAPDG2DTzMPyVJCFXd1zj75n1feu4VAW5oJl8lMs3X3zElMLFH888sOICJg2MYFh+5cRw==
X-Received: by 2002:a81:b143:0:b0:5a7:c72b:812 with SMTP id p64-20020a81b143000000b005a7c72b0812mr10986744ywh.17.1698779818767;
        Tue, 31 Oct 2023 12:16:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j187-20020a0df9c4000000b0059b17647dcbsm1178381ywf.69.2023.10.31.12.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 12:16:58 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:16:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/2] commit-graph: detect commits missing in ODB
Message-ID: <ZUFSqRYXhwsWC+EA@nand.local>
References: <cover.1698060036.git.ps@pks.im>
 <cover.1698736363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1698736363.git.ps@pks.im>

On Tue, Oct 31, 2023 at 08:16:09AM +0100, Patrick Steinhardt wrote:
> Patrick Steinhardt (2):
>   commit-graph: introduce envvar to disable commit existence checks
>   commit: detect commits that exist in commit-graph but not in the ODB
>
>  Documentation/git.txt   | 10 +++++++++
>  commit-graph.c          |  6 +++++-
>  commit-graph.h          |  6 ++++++
>  commit.c                | 16 +++++++++++++-
>  t/t5318-commit-graph.sh | 48 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 84 insertions(+), 2 deletions(-)
>
> Range-diff against v2:

Thanks, the range-diff here looks exactly as expected. Thanks for
working on this, this version LGTM.

Thanks,
Taylor
