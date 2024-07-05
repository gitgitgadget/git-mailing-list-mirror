Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC7B1F61C
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 22:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720217278; cv=none; b=cbhaULtnu5eLvEUh2G5jqVnc8rijsNJ6EcMBx1T9qwthBFcu4Ftici38fJRT5JiQqI0hIFsNksi4VhA5/VD4iSmi7tya4TlgHlZwlsFxbS/nX1IPsDaIk+rTs+pIy5Q8Ec4pmOUaYWOvkPDOZUCWm0fv/lNSN/TlxIIRgIKjAdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720217278; c=relaxed/simple;
	bh=bFIMVElsxsUZmguPHNIBwoLScWLlE6iNdXLJzuuYf7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1bJmvtqKQvwZLcH9ZRoUOb5pP9mMitT5HW05ywOoEHQMKk8Mgn8+DnyJC3T1FsUE261ainfvL1wKn3ptliRXnY1GhYFveO77YV/BQQ62TPCzja8H/2wzUJ8HZm9SUlRvPv7CQ2+YZ95Jw+8P32SKqLE8AY6HcLquDVFC5yvwVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRXrsopv; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRXrsopv"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7035a3b396aso446738a34.2
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 15:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720217276; x=1720822076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bFIMVElsxsUZmguPHNIBwoLScWLlE6iNdXLJzuuYf7s=;
        b=IRXrsopvVs8D8Ng1FjvqbuJ1TtNtg0gTM2JdkwlvwEMmrw4lVbykrgp7ngdwEp5nlz
         4zh8HzHot4B2yYECLkhh8wcePmymfXyqyGbBnNUFHP+Q5j2H46VA/hKpMZH900lPiNpB
         0tUymfF85EhB5NKLCnBAfKapwLhLXppJFEcyk8mvQX0wbdMpQSLc5nYpbVdHBe11TvMg
         to5GfuCgHtinRDx8HqC2l4Suw7BldYEBocmF9a4s1DvKiTx6Y92pWYaD+eskypRpCipm
         SIG+9IhHAyqdAXeVS9IDlH6CW91U/L+p+6xeNGgbBXuyIxQ0eefoYEf23St53y9o/zIf
         VWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720217276; x=1720822076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFIMVElsxsUZmguPHNIBwoLScWLlE6iNdXLJzuuYf7s=;
        b=KJTx2Aue8SSs8ReWG2B/iwt7EaaO4RzGiwrsK0QFgNU9auYB2vN2+pvDJ8+oOb1AV4
         u1G6Xa3xhCVmHaGR2DqjeA2Lm/N9ug3TZlZo285RUSjmOXHjZueET+PrI3gFiZeMjIX4
         B9OHK62Yzv4DgM6kNoP2LmhbAAR9UtCkkvKXIVqxTrFgZdssg3pUO4Oy2r72kpggEsN3
         mbbpYhwcYH6QDefDy7tRfLwIYKQgwkBWjXhnCQVTCSEU9/dxIRs1yvFafX5QGsvEepvc
         MSYQNJcjGkDCCbhktnm/y4WzT94vYLCzWc4NX3fRlmuUdoIpFBaRC3S1FhBLdpnZQCyB
         DRkg==
X-Gm-Message-State: AOJu0Yx3L9TJkpl0KlopzriP6LrCT7fULaHSrS2CNq76pHwWc3LVcTMu
	36WtbYERI7egUhXdrAdKNeug3fhsykrRkYS3+zQ/uRtabjFZyAfq
X-Google-Smtp-Source: AGHT+IFiMgSYo7fCh0ZV1r/NlPVxWEqazBMDR0Efk5gs9+sbEMSMBCAjQzsejDDTC1ybw+SAc1PImg==
X-Received: by 2002:a9d:7cd5:0:b0:702:2637:6a6b with SMTP id 46e09a7af769-7034a808c8dmr6884149a34.34.1720217276078;
        Fri, 05 Jul 2024 15:07:56 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7035fdd1f79sm34119a34.22.2024.07.05.15.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 15:07:55 -0700 (PDT)
Date: Fri, 5 Jul 2024 17:07:29 -0500
From: Justin Tobler <jltobler@gmail.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC][PATCH v7 1/9] fsck: rename "skiplist" to "oid_skiplist"
Message-ID: <ysrjjyksfwto35ug7o6xbgbu53vvjso6nov3u2q6vvdprolqwh@vjhcc4x45j7t>
References: <ZoVX6sn2C9VIeZ38@ArchLinux>
 <ZoVYjrfCFO0_K4Ry@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVYjrfCFO0_K4Ry@ArchLinux>

On 24/07/03 09:56PM, shejialuo wrote:
> Because we introduce ref consistency check. The original "skiplist" is a
> common option which is set up during handling user configs. To avoid
> causing ambiguity, rename "skiplist" to "oid_skiplist".

I think the commit message could be expanded on to provide additional
context and reasoning for the change. From reading this alone, it sounds
like we have already introduced the ref consistency check and are now
looking to rename a variable. When really this is a preparatory change.
Without reading ahead, I'm also left wondering why this name change
reduces ambiguity.

-Justin
