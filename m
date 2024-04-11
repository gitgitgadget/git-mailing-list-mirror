Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0099A205E15
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712871864; cv=none; b=pF02yMS/sDJl19IH+hq0PqCVF2gFw4rpoaOimFqB1k8qcDOMmHbBeP8HsNH6jcJ2jlShr2Bp+T1lGvFFF9LRco+huJJPRPXSEi/AK/IBRWjApR/qMMsO70qd4Uw8he+2PvaexU2AX+NmWGiktnaiP53WnVidXYbxsRRpXe2+iG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712871864; c=relaxed/simple;
	bh=xvolQ1/0fYhmygKbyhx1pwQBZqR5RopQo8L+hebZFBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQUI65Qt1uNy/kkhd1/HeOIhzNxWy3+011F0+cGQlk0M5/NrVD1cMxz4O5Htk0Wf7bL9T7pME9lRwUGpq9TkJquAJbp6M/KY/wiiQCiu6KsNyCeYI3YCdY99uSnTfq1vLIVrcSU923QJ/0IXHX1Dir2xexXtn05DAJhtnKNVtoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=pYrLDwZm; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="pYrLDwZm"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-614ec7ee902so2455037b3.2
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 14:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1712871862; x=1713476662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xvolQ1/0fYhmygKbyhx1pwQBZqR5RopQo8L+hebZFBU=;
        b=pYrLDwZmksYCXGVnN48oWw0naeF50jvEa4xliWUzb98Xei6AqKk049o0RFntFXfjs2
         1bwEdk8WyxOwLpQTawsWVr2pZJkxbbnCNlgsR31BRwwdZwybN2diciIRVNYo45hWop/D
         LvxAp0ifpR2rVcKxxXrENHA8UqH/dmlb85e4WprR7rdWdq30s0zmoSS622eMJhj+bBZU
         ra1JS0l6D3bNuH1ksoZlK9lX0i2NzJ2mB3N/VDNfGoZjzsp5GxdqCNLd9njrt9Lgnrvh
         DgaAr0rvcnP8P3VdeW1d4QJjSMCwxcD4xrmTFZPTkHx7qRPr7MvhY7KqcyTj/BWgePed
         EetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712871862; x=1713476662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvolQ1/0fYhmygKbyhx1pwQBZqR5RopQo8L+hebZFBU=;
        b=gZ25sDxXN9PUTIbNhdmxrD3vIjTRDWLLlMW8sUeqFUnAAz5wAn6HSf7O43oYIzncbz
         nB7mxcbPHpV4dNx1SRaflBhFGrY+BO99/tu18LB90o2V7qNmDlKTTwQuiTBn76zBU8pU
         yh5C8yEOzYMONCksCyvqRLJ652T/A7RxdzaojwjVjjw06EKZUNx9rCrqDe8OJqwnlb4s
         MrQd1t2CqdsQrkhe1net3OdGGioEWgkg3ftVk1yphZjftdxIHUM+9BRz9i/YLHKfgi+w
         iLl6hagZ4LccGb8witoLnFw3KPiNgbXb2Z0KvOiygf+MaD1PDu3AfRwFfbUdbyrjqi9q
         C8Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUK9J6uRerMpR97AUAKh++PQ5o5+5G7PNKcCpjvkeyfVveezSaLxMIShx+ld/wXngv/sqe7wt7jG/Z1pLiP/pUAtuN+
X-Gm-Message-State: AOJu0Yyc0R6TeUqADU7AJbsCMQl1XutXYgfovNYNeghPSFzuA1+yLhej
	BmvZzSF53FthB8fC+WpTJy3xZggUKlca70MZOjjw8PQwOMer0gNfCz+HwG+uO4hvVH+UvwbKxt1
	e0wY=
X-Google-Smtp-Source: AGHT+IGaQpdNBQlAzTpipmau4gq5q8x7VdAhdxAeKMWaLFL1X6R/RNOLiiAuCv+nC8LaySZrwWGaUQ==
X-Received: by 2002:a81:8354:0:b0:617:d365:dc17 with SMTP id t81-20020a818354000000b00617d365dc17mr750734ywf.26.1712871861904;
        Thu, 11 Apr 2024 14:44:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r15-20020a0dec4f000000b0061447e2be82sm503463ywn.51.2024.04.11.14.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 14:44:21 -0700 (PDT)
Date: Thu, 11 Apr 2024 17:44:15 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Scott Chacon <schacon@gmail.com>
Cc: John Cai <johncai86@gmail.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Virtual Contributor's Summit 2024
Message-ID: <ZhhZr1J7a4X2Jf0B@nand.local>
References: <ZhcBJSP4MxX0AMFM@nand.local>
 <A7406B15-8DF1-4B3E-80F3-BC56A9AC4D85@gmail.com>
 <CAP2yMaLpJqZ+aC=rNPjkw2ybW7PjfbW5QuHnZ9mYs1NhJ1L5mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP2yMaLpJqZ+aC=rNPjkw2ybW7PjfbW5QuHnZ9mYs1NhJ1L5mw@mail.gmail.com>

On Thu, Apr 11, 2024 at 05:37:52PM +0200, Scott Chacon wrote:
> If everyone would prefer Chicago again, then I'm happy to just attend
> and help out however I can. If we think it might be nice to bring it
> back to Europe this year, I would love to take care of it.

Between you and John/GitLab, it looks like this could work. Let's all
talk off-list and figure out what we want to do here.

In the meantime, feel free to continue to sign up (or not!) for the
virtual event, just in case :-).

Thanks,
Taylor
