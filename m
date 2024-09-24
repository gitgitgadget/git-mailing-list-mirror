Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909F1FDD
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191392; cv=none; b=IyZ/sv2IhxxErEW0/21hs0BKAnfTb3XXylIcJcbMvljJRgMTv1QYt28ykpUKd11CNIQh0k95lrTCNc4vmoYGiLmHx9jpUgdnMXtZt4ePvXQ1/0u4O+eScI6FeA+1mMeJbQx+FyvF5wbHUWCk1sYm8pn9sk5nqTlyhqFPoKzbTtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191392; c=relaxed/simple;
	bh=V1Yl+fEn1NCBb7O+lWXn4PsHYuhWoZwNRWhfRnRg4b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxOT8WO9DG6Khz8PF1qOnwpVvfk2eno120AsGF3AkZJQGOOxvOTbOwGnWBz/A5MNvtPS4A7LG8Yl4HSFvfKSHfpzaybiFJPnJUJDxOkv7rBMG/RJDKotyD+4eAaEE38FUK5nt34rjVEXUuObQ5atZCAUz0HPKDdfsQReyaAV//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inPT7t84; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inPT7t84"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2053f6b8201so49750215ad.2
        for <git@vger.kernel.org>; Tue, 24 Sep 2024 08:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727191390; x=1727796190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rw/mg1sXL7kob9/8reHFQeHNE5LIexZJoKGWZnX6V5U=;
        b=inPT7t84rf8ewSMy7/1eni6SdWm1nXmj8JigHl1UN9118Ael//0oat2n7JToFpI/BD
         haMC/+tZ5zVYdFrXcm3nAtHuHNDwCdOz1JSCQ4thY2MF3Neeaxy3lvlnXIxKp6TBOpID
         gyFEcbtaMgTB8X579AOhRtglgFmIOvpvkqp1C5BfVTd13cugd0AAHN/Xs+1IdBgyoGx2
         bcRVsZkOxgHKVUKBCm7L0Ue4N8tQR1uC4Bg0rrgJLMiv74XX2oA/WJZ9bmlj5Cpn8qeL
         KLLONvHua2/1NdcyBBDr4reaa7VoysCdHjWtKYyk+YysrfUR+i9RgIqH60J+I9biOSiw
         2adA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727191390; x=1727796190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rw/mg1sXL7kob9/8reHFQeHNE5LIexZJoKGWZnX6V5U=;
        b=qFfU0A4wR0J9n+e5xgDK2tyANEl9kJ+ve0UKpHrptfpNwngXY6bl1WEMCvuddqvCpt
         aasguW6wDGUX7Sjkm4qpQr4U41vVfmBxl8TLpiQWGUy7hjUUehQ5aZ+29mxYRy6iZ9Rs
         XvdgFE9CTxVXHSquPlSiULPLd1VjJpw4Z6yVwA3LKuBn5kpMgmQ3n7yb/2mAmvNOkQk3
         ecpdkS2rh/fJuflUgtkRpsF3vOsToGoDg45JTakK8DrgOosu294dxdj9Kw52JRW6fk84
         Jye+D1Uvkl8Q1dCUL30cxlkwFiepwaz2PaRt5968vF9rAr+y0QqnRr42QdEYxPgffXnP
         3Qmg==
X-Gm-Message-State: AOJu0YzCMvlipbNUcSmhe0nH/Lnj3qe2AHx/LN5VlUNqvZpbizM8S+BR
	U/VVKDOHEbLoLDCURzbqtAEK5q+7oIky6WIczKrXdrs/wOCjU+1yh0nXLQ==
X-Google-Smtp-Source: AGHT+IHNhjIbKRvztoBCr+y6x7EfocxZzN/oOumvOc30tIapZTWb2A5EJQYp43JwjkrbrDdujFsXRQ==
X-Received: by 2002:a17:903:2411:b0:206:cfb3:7232 with SMTP id d9443c01a7336-208d985ea0emr197139365ad.48.1727191390652;
        Tue, 24 Sep 2024 08:23:10 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af16e6f50sm11541935ad.22.2024.09.24.08.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 08:23:09 -0700 (PDT)
Date: Tue, 24 Sep 2024 23:24:24 +0800
From: shejialuo <shejialuo@gmail.com>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/4] git: pass in repo for RUN_SETUP_GENTLY
Message-ID: <ZvLZqIe8rpGZTU0C@ArchLinux>
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
 <eceb2d835be7168081d6eeffbce57bba89b5f423.1727185364.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eceb2d835be7168081d6eeffbce57bba89b5f423.1727185364.git.gitgitgadget@gmail.com>

On Tue, Sep 24, 2024 at 01:42:41PM +0000, John Cai via GitGitGadget wrote:

[snip]

> diff --git a/git.c b/git.c
> index 2fbea24ec92..e31b52dcc50 100644
> --- a/git.c
> +++ b/git.c
> @@ -480,7 +480,10 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
>  	trace2_cmd_name(p->cmd);

This line is a little long, we may clean this in this patch.

>  
>  	validate_cache_entries(repo->index);
> -	status = p->fn(argc, argv, prefix, (p->option & RUN_SETUP)? repo : NULL);
> +	status = p->fn(argc,
> +		       argv,
> +		       prefix,
> +		       ((p->option & RUN_SETUP) || (p->option & RUN_SETUP_GENTLY))? repo : NULL);

This reads so strange, could we create a new variable here?

Small problems, don't worth a reroll.

Thanks,
Jialuo
