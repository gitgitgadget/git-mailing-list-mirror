Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F018118D65E
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286523; cv=none; b=WcVwfzh4FztpAo78EBtkNRtfDdoYXVxNuxBGuFrYyn1AbWh28zDJr63rUlxTGoHIc3cswYFVP/kzwuVzYaHQKel1rX8h0g1r2RgeL4KESLvxwlHJp8sBm6wjp0YLwiptvu1it6X77iEQWvGVQtrESrkzBdA3a7p6nAp75lNMJVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286523; c=relaxed/simple;
	bh=Xz9Ik9dKvhIiblotdMTc6BTTN+qEOBgsALTGat+hBAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRPEGuqkzFV0ErrYZKJGZYmZMCbI5AugqdMx/qN404rwenfuXOsb4hDmSrijiUY9eVn+mE8qM/EQijg5UkfNT6tzcZ8fsrMI4F0Nf8brRwj/sA5VZGc+70TTEFfw57zntHvnriN5jTn1/jIFnI5dGerwnSnMX8kRthFCul+XE6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=IDd7Qv1k; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IDd7Qv1k"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e290222fdd0so2268873276.2
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 14:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729286521; x=1729891321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RBB8JZfgj2rRSnBSqLQ3ch/M6ruEDlPBmurar2eDQzc=;
        b=IDd7Qv1kuA22UmFXuK+UEyTLSRKik9lFkak7ezH3oTudgMxOKeqmEBcFdcsXzFGohT
         3ATY5XCOumS9biU+QxOOaysXFEWUcCaW7FG6lCIhXxJlN2Ot7xFA/Ugsul1Klmu7vNrZ
         SBktjEcogJgHzohmrUmrWFrfgJhOffhH0SMhDbzl6wc6aII8DenaWxaX1xgiiubSA/eK
         g0YtbSagJ059d4CclP1V6MPGWKYysjooW9GdqS4SbBHXBexP5CrA5PoxhnObKYnzLOYz
         6cybQ3N0tZ7/iZ8+fbaQDVCfjkTCiy9K9EA5w7RPmhV9DO2metT0pN1UpJdL3b8sEp88
         NDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729286521; x=1729891321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBB8JZfgj2rRSnBSqLQ3ch/M6ruEDlPBmurar2eDQzc=;
        b=YtcBBKkS4jxZ+vDGUbCEBVjnPFaw+eEGyCnEOMmnj7bOALaGtF3BhmuWZOyTy8GHvE
         nIeBmUyFO7AV6SakdFYakAObIB3mR24aPTBuHipwaRtfjlmZo2ZdnhwWMgDYsiOlqm/w
         w4e7fKpk4IfJcmR0UqDqBdCtaw7ig9BqSBF/Li/kmiDA1EXL0nl1Nq9jPvCcRBgr3PML
         P085PJV+MW/RkGyEEmGa9WR5nVUKQdHhs24xUr9r0FM/KFIdGWEBGwxUVa/HaOHD0i/4
         rvGVbb/7i3FL+nw0HwNXSjc+1vDkrIoSvAVD8O7+xPUtAVarPXe2Zoa7zg9gIh7kDTUo
         Wh/A==
X-Gm-Message-State: AOJu0YwV7jLVgpum8iYwMS+ACHW+8cr85kH/V824dl61d1p85XciPFCO
	rMl74GgJfqtR9Bz1ds1JIHxUCpQ3lQ2Voe251jki4d3WziwH+xMgYcul6vBHMmM=
X-Google-Smtp-Source: AGHT+IH9as/QuNJFpi6QiQYGi/Ei8PIvFyiL+DefloddDRmHMrnrGlnbxZxcnYjyLZwEH/g4u2ddjw==
X-Received: by 2002:a05:6902:158a:b0:e28:e4bd:13f6 with SMTP id 3f1490d57ef6-e2bb14481fdmr3401630276.33.1729286520767;
        Fri, 18 Oct 2024 14:22:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bb020a76asm461940276.18.2024.10.18.14.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:22:00 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:21:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v2 0/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
Message-ID: <ZxLRdu4cPDgPLpCz@nand.local>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>

On Fri, Oct 18, 2024 at 01:52:57PM +0000, Usman Akinyemi via GitGitGadget wrote:
> Changes from Version 1:
>
>  * In my initial commit, I mistakenly included changes from a different
>    patch and commit. This issue has now been resolved.

Should we treat this as a new series, then? Or is this a true reroll of
the previous round and should be kept together?

>  * I have split the original commit into three separate patches for better
>    clarity and organization.
>  * I added corresponding tests for each of the changes to ensure proper
>    functionality.
>  * In the first version, I used the following logic: if (strtoul_ui(v, 10,
>    &timeout) == 0) Based on feedback from my mentor, I improved it to:
>    (strtoul_ui(v, 10, &timeout)) and similar cases.
>
> Usman Akinyemi (3):
>   daemon: replace atoi() with strtoul_ui() and strtol_i()
>   merge: replace atoi() with strtol_i() for marker size validation
>   imap: replace atoi() with strtol_i() for UIDVALIDITY and UIDNEXT
>     parsing

Thanks,
Taylor
