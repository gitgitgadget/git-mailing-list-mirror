Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44D9125B4
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMKFTjdp"
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BED768E
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 22:33:32 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5bf58914bacso17562887b3.3
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 22:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699598012; x=1700202812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZjVzXYTSVS77UY7BdwkKgOzJCO3fAHqdBrSAsjdSfw=;
        b=DMKFTjdp/CVf2dyrRCmiKm57Ib0/UAaPFKJAw949ebIVys0489jT+zMJxI4NhiwU9T
         BgQ5I/UgyBTOVMrnXsMTFbJqWqMRc6qc4oEGKKE+QVOBY6ZmphdlsegkTqLtrALTZpwG
         rwGKOWnbaYkaGtCjSQSYyqq4Qv5Dgx0sInHa2ev0zt5phpRKBXDT0WkFWRBtGC9bGSBv
         7YQamQ4fLVXLFuZaa1nShCgXSwKa8bwQQzOHoXf2xrzu0ctAA/3VpkWLObbbE6k+q11d
         seVrCUm1Y4jWWHRAZ+RVTE5u64uo6qglNRTDBdlt2YQr+AV9GGfcYpCIByY8iTDbDtWC
         9fFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598012; x=1700202812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZjVzXYTSVS77UY7BdwkKgOzJCO3fAHqdBrSAsjdSfw=;
        b=JAt9ndR3wrQtnb8QqW/krKU9Zvu2NZWCQ8PQFOposdUaH97wj6bALP249GmozxWGFC
         EDm7pWPjG87peH093xPx2FaoG1Tux5fxVQKKO5VTg7t7jTSe9B7d17PzhBOIJ8y7ij/R
         6fVpoTbeYf8w4z+ZIb47gu9CWtPKzMp9LW2uha08T8VaKn5LugQgHBEcpyIcOyqQX0F0
         F8IUT7dDXoifNStb2DesWTPBrvc88uEO78kdPRfdLG5UBIjDKoKKbiKZXzraJexvWosV
         6zt1q+2s48slZeYr8BMML6V7yOhlYTQQFd/zqJwzZDuDfKDo+n73pTnTahOK+RtWn2mq
         mzMQ==
X-Gm-Message-State: AOJu0Ywtm0mOKietFFuV17a4aKu1XxFUCxKZ7QE1oGFCu9Pjfqr1tkkq
	TvQllEhOnNdg0rIpOZTAQEM=
X-Google-Smtp-Source: AGHT+IG+IAFvrd7PG1O3RNYHGwrjcf3OlHESr0wRGOZwrXVjGt8zgYMZxTC/PGfy5uzaPcV6badTeQ==
X-Received: by 2002:a0d:d44a:0:b0:5a8:19b0:513f with SMTP id w71-20020a0dd44a000000b005a819b0513fmr7669489ywd.14.1699598011769;
        Thu, 09 Nov 2023 22:33:31 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.58])
        by smtp.gmail.com with ESMTPSA id h15-20020a056a00218f00b006c3467ae25asm11708329pfi.206.2023.11.09.22.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 22:33:31 -0800 (PST)
From: Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To: gitgitgadget@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	linusa@google.com
Subject: [PATCH v3 13/13] trailer doc: <token> is a <key> or <keyAlias>, not both
Date: Fri, 10 Nov 2023 14:33:18 +0800
Message-ID: <20231110063318.54745-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.42.0.484.g3294bc14.dirty
In-Reply-To: <0b9525db5a0787fdc71834abad9151aa03acc497.1694125210.git.gitgitgadget@gmail.com>
References: <0b9525db5a0787fdc71834abad9151aa03acc497.1694125210.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus Arver <linusa@google.com> writes:

> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 25433e1a1ff..418265f044d 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git interpret-trailers' [--in-place] [--trim-empty]
> -			[(--trailer <token>[(=|:)<value>])...]
> +			[(--trailer (<key>|<keyAlias>)[(=|:)<value>])...]

Maybe use 'key-alias' instead of 'keyAlias'? After checking the naming in some
other documents, it seems that they are basically in the former format, not
camel case format.

Thanks.
