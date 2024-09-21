Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A900137E
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726930186; cv=none; b=WlynP7Bi7M5ikKTDMdEnmsJY8l74gvNhdHCiVO9qEPOTeWHUc1o3nFiTqUepKoJf1jkFrXhwJOizW466ZfsjEbs+Y9H9r64f9nOcO2UANhnIAXgAYzmMX68rM9BAuXDJf8MH+Z/lUhefwGoX+XZAou9Jndf4dpHFLP8PTqgVObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726930186; c=relaxed/simple;
	bh=w6JsokqEnjjb+8dVFgqmjAFL9WWTznC7Ro6v9DyTvVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YH2MgDsggBlMsrXN7OFzxraOlgB/uS7Nx1P8IK9cuXn/V702tpGZ+kv+OyD4cpVtmIAu1s/8ZWKSbs2v0z+TocyGqqQB2IAMXY2pg1hBbpqDMcsHsrcGoW85CLpdKiQMUzcr+JGjE/bz1LjzdBPkJc6QAiJQmcIvOsM2ftkONqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToRTRzid; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToRTRzid"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-206e614953aso30072225ad.1
        for <git@vger.kernel.org>; Sat, 21 Sep 2024 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726930184; x=1727534984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DQ70OvfR/zaAxj7OJBkIgH8P2XEowKVFBXZABerwrzI=;
        b=ToRTRzidBNqjtSnaLYYbhpIL9sIzmbHnn9yGFtfBsGpCJwWgM4nyyVin7/dHDbeFNQ
         tiolUJZ9U9af2LjmiTH5AATKFaqOXvWmKqh2dYolp6MGkNKLuOub/bcjtf/j09a+M4a0
         Dz5uO4OGWxICW0NmoRYHlSvc1Tb9AIPptDkmZLKKxf6mLTAsmxyBsOgUM4vJKXBOBA7R
         GlWcFQAtCQZkVC2Jm2/FoDR/kvD/374nAqAwe1q4Ln5DuZgcnjUsciOnO3yb2EPj8FM0
         oTB37XO1wiBipVuBgUeX8Z/EPAtD0WgvYrw2OjAGGSnHQZvAI57JjDjAHVVCm5tDYJl+
         +rXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726930184; x=1727534984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQ70OvfR/zaAxj7OJBkIgH8P2XEowKVFBXZABerwrzI=;
        b=Sg5eDtQJGlTPsfmhSMM2z9rGGif7cIoQopwZBdw7SIlVjnQjgePH0yn9McLcErUwNw
         w9JiLsvTe5rLY26tAdz3lLc/onav7Fl68VRN7MKsut6UhDiiAYPi8lKNdj7jJs/cFSXj
         krT6NT+IzAEUHLk8noCF2qkp/O2eWO48t4gTwXpF0ZBsKjoRMRAysLb3798p8wYRYJ0D
         jBco4h1HhFOghcY8M6zYSyl6F02nLgB9Bt/IOPhkuneiJRz6NdVFrN4gunsrV6F72tMz
         s4C9O/w2hOARyMYixqfkDYX84DDIZQqURAdL5LrO3dEchtYtlC6uUdHuu7n6ngYrft+3
         FjjQ==
X-Gm-Message-State: AOJu0YyhbHl8yoH5Oblc+ldfwRNGb9hlNlrSXupV8vPrOOjoPurpEdtc
	bsP2I2M3gX2DecFh5yHhufOX6WXOm0IyZlrxDmL1RQXj/l8jDbPR
X-Google-Smtp-Source: AGHT+IEcTvvH7cLAJ0EGUBM4pgqtCHnN0un8PoK+WC0GYj5DXwFdEK6whlPDWxYNzliB2i69Q5lJgg==
X-Received: by 2002:a17:902:d4c3:b0:205:913b:d9ad with SMTP id d9443c01a7336-208d80c831cmr99505855ad.0.1726930184605;
        Sat, 21 Sep 2024 07:49:44 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945db10csm109578705ad.53.2024.09.21.07.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 07:49:44 -0700 (PDT)
Date: Sat, 21 Sep 2024 22:50:55 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2024, #08; Fri, 20)
Message-ID: <Zu7dT6Y92g08J3Hp@ArchLinux>
References: <xmqqed5ddexk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqed5ddexk.fsf@gitster.g>

On Fri, Sep 20, 2024 at 05:32:39PM -0700, Junio C Hamano wrote:

> * sj/ref-contents-check (2024-09-18) 5 commits
>  - ref: add symlink ref content check for files backend
>  - ref: add symref content check for files backend
>  - ref: add more strict checks for regular refs
>  - ref: port git-fsck(1) regular refs check for files backend
>  - ref: initialize "fsck_ref_report" with zero
> 
>  "git fsck" learned to issue warnings on "curiously formatted" ref
>  contents that have always been taken valid but something Git
>  wouldn't have written itself (e.g., missing terminating end-of-line
>  after the full object name).
> 
>  Needs review.
>  source: <ZuRzCyjQFilGhj8j@ArchLinux>

I have just finished travelling. I will response to the review feedback
tomorrow.

Thanks,
Jialuo
