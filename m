Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2731E521
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842188; cv=none; b=XTi5vs4xvDJFfA74o2hpuLe5mcVL/ETYIcNzvp0ItmkM/xN4s9qj83l2gYiHREPyNjQSC1uFNARxpYPovSfowCGBA7S67iShRuBhBDiICXmyczVvMBoArhgW0Qe/pY2DeVGdG0GJjHYU5ayqwp68I8dgyIaA0x7m4jt5FoZ58B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842188; c=relaxed/simple;
	bh=sz46n8xmCiJX07+Q3sPVS5vSqt0KCJuU3jO7/3FunyA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okwIAcR1CyrLClHPCmHAfO3qNp7O/f+WXZ0wK7Tal9omgD3Cubm7VAmPXOpDk8Ffqb0aO6KWZrKhZWtRifEHgT0i7wQfeeM3fRl0XrmUKX7oxnh20a97YLZtMrpxtaX1KnQnk+pfutcgYam/8oPRcP1KNfwK+1rLFCDDms4F3kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xoUdTO1w; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xoUdTO1w"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82d07f32eeaso110683139f.2
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726842186; x=1727446986; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sz46n8xmCiJX07+Q3sPVS5vSqt0KCJuU3jO7/3FunyA=;
        b=xoUdTO1wO4OlI0hNlV1YdoO3VGMTbd0+oqQV393d7vHaLFAalRpmYwGaox6hhx3Ec+
         RAmZH9NLY5QMnY/paI39K/vetPR3orQjf5/fWSXu8BXQFaebN1EM3xZgBJ3Ui3iwLA73
         YSiPjEu52Bds0TKckhTOQuBwP7IiCmDSHB+ojBDl75853PBjxLi/AuqyX1jzg2+5a8KY
         KF+Ol8rziBow2/x1xeeYQAgrpQAlpSxHqb3N6sIsvfyfsnQ6ECmWRe0hjcTrp6mxm4nM
         YASCu/qX08k/F33gZbvTo/M5WbQno1Qrj02SWqn5O5X5tpokwBfW82QvGTCfeBhf6Juj
         oTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726842186; x=1727446986;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sz46n8xmCiJX07+Q3sPVS5vSqt0KCJuU3jO7/3FunyA=;
        b=wadFI3q0vPsSTYCHKGO6MwJDPAfRieNC2/sOb8pQ86ur088CD5US6tGcmmuc8TMwyX
         RvAdJ252P9RldeB7xZ31AE4VMfPyT7q/7NStYIzrv+A8N/YZHzSSnMTnPhrCVRUYgMT8
         SECuSST6NV09cLdYN9tpYXlZ6yvysi+hUw47rplgouPwHfsmyhA7z7sO1U12HSv6XlFb
         kqZV5IFiYYvfibrdHijXrKwFjx8t0eQO/CqmRLacvf76h75l47xYCZwNJtzwMC33BI4Y
         b/KWTbEGD7n8pwVv5JFievl5Mr4br3q675s+mBI4l3RhRiHld7TcWCJI+SB2lRR4sbJ7
         UReA==
X-Gm-Message-State: AOJu0YxWZVKRNyhsUYR1WW9fMx0AVOMhWKULb7gMCZ3d6DIiz8pDVC1a
	2Fwo9JcTfsV/elPW2mOz1sgKCkrIql8C5BpBNg94rdkQ5IWdR1px3yXIjiDXRX5jxc65GtgOIOt
	v/QcO3A==
X-Google-Smtp-Source: AGHT+IFivgzQleZqFnXHe3438P9XWFsXoiodWAfCHWDii9zD5yY5Ka+XyFrNS6ao06DD8dGIjBx8IA==
X-Received: by 2002:a05:6602:6281:b0:7f9:c953:c754 with SMTP id ca18e2360f4ac-83209ce0ae6mr304944439f.3.1726842186013;
        Fri, 20 Sep 2024 07:23:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ebf47acsm3600807173.14.2024.09.20.07.23.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:23:05 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:23:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [TOPIC 11/11] git-scm.com state of the site
Message-ID: <Zu2FRo7MJeng41UP@nand.local>
References: <Zu2DmS30E0kKug2a@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zu2DmS30E0kKug2a@nand.local>

git-scm.com state of the site
=============================

* Johannes: worked on a static site version of git-scm.com.

(Johannes: demonstration)

* Peff: let’s move it over.
* Taylor: AGREED
