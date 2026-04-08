Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4116530F7F3
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775683459; cv=none; b=kgkGzI2dgRX1vE9yze6wF8+DDO+C050tQtyupGc0iEXHZZ164U1mRt790a/78WXo6Dl4yeJ4k66AeMpR19z2Bsz+zWNczVZ5/UEOR94YdA0LwjjJyLckrdRmvYnvk+5PP4tNhtKJwEwMmHOSvEGPSRVMX/q13THmMpT/XQFBOks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775683459; c=relaxed/simple;
	bh=hV9OxBGunrtA3ZadQyG2jKTQKJUkimaghyN9wRqWLek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/Aesnj1k4SOv9TcODVOa0dWOPMiuwEI8Xe99mTuugQPk3eKTXZnLpKv+9bCPmm0FxrICjsNlbKOLKlR8WvdBAcx6hhroKuUlU/WcTEOVWDUubWIWHCRDfkim2b/Gu8WLG+CPq2E42rvWH1mSg0vy2jmOoLnQR4uaIYj8QAOipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQcXkl2v; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQcXkl2v"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-689f648d0adso85215eaf.2
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 14:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775683457; x=1776288257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hV9OxBGunrtA3ZadQyG2jKTQKJUkimaghyN9wRqWLek=;
        b=pQcXkl2vR3UAPZGIoloDPBRFlcRpjjp/wVPVrtDeGy4XMIPMEplu4j6lYWM2ifQaax
         Zpll/uc4MKEduCE9fxr9gNCnHoZ/VNSWbebHkRJ5QFw7lCFzG+agUBZJ6GQbIma8mnuV
         MmOFriid9qqmJo1MOnN0YQQ4M9UV0jHxUyhoGrLxjlbpu8UbSPtVeqeVo+CUxYlgDPXx
         VYL+ipdaepaNM5jpfq+PB0PPXzrpo4DjXTClK1wxbg9VtIufXH2Fn2lvxnakuzFO84G3
         4bW8SfJObO2DPXPYqQDw1AhYCjxtfsh+YFmJsI18q9mjdoHX8nRXLPsnmmd4vIEn9KEq
         NepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775683457; x=1776288257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hV9OxBGunrtA3ZadQyG2jKTQKJUkimaghyN9wRqWLek=;
        b=K7MFrUznnA+UEu4B7L3lN4IvxdBpxsbt45S9l8GyS5bjmqDFBC2rnhN0nnCksEjiFa
         wjwB+1u1gtV5xU+63Qg6G5+3u3hdzYcxb1JudCjiYJnMiKrQ2Wdexqt+kHBrv0H6pRtA
         D3KjxIiCGHxoMDAHJp++QA9/IsgsiYJt+Zxh82pErJz0iHY2A3L8FLN+l0pGdnQOZVLy
         0sUTMZG1rnkVhpziddFP3hFKI77lLDlO6mQFluPKF99uCw1OTtTCfj9dWCbUzhg45edi
         GPhkKSlJvKXMaXKg6Ur9p3iY/lqYdr7ZvyHXzCeiYFqYgI9o1LoTqPNGiuyKRhFrpn2d
         ctGQ==
X-Gm-Message-State: AOJu0Yzrtl5NTkiXJhWtvZ9Rz8jQK6ynFvSxA8ZCnSZ0kUubJ/r6QPlZ
	+Vqjb1Gl08GiccThwP8KtrZzWuAZ8/cgSNerHo41pzYjSAyfku+OoXM6S8eDgw==
X-Gm-Gg: AeBDietpwCQf7xZH5EJdXTbp+YsgGDgVqqz4aiNaubq1xSJEohSd6YrWzDQZWVlupcA
	/V46Zp2hC0JwmLcqCjlbCG7RgoCLtVqZnYGF943YJHrp/0JGX6wNVGk9ayWcGO+e7RYy+ahI0VB
	dLczuhTH1NqrfQPcn9bEFs4YjuCle6YoKEax/HGfR/1xV+4m82GeB4oCst6LophDpwKF8wbucTI
	+qSCbZfY6D6QsWxz8Qx6JfCceuIDYtySgy+uGYogOVJ4WRwpnmePa81qJn8DZp8Px8QUph9Nmj9
	vc+8zw8tIgOzU2ygDqdx4Qq4ClQD8TmLruBMTQfa5JkhD3w6vdYIKatX9PZpsj4bZF19uA3twfe
	Ay3zkdJffxytmVQDdKSzaUZpd7g7rYvHjcwGQFryyQgmSwScESXQ6yT1Munl6hpp8D6Cgk+QBYM
	s8EQjU/CZOYllRaql/lJbLhxxU0cg=
X-Received: by 2002:a05:6820:822:b0:67c:1fc7:daa6 with SMTP id 006d021491bc7-68a6177f956mr616967eaf.10.1775683457293;
        Wed, 08 Apr 2026 14:24:17 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb3c9e06sm15312813fac.15.2026.04.08.14.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 14:24:16 -0700 (PDT)
Date: Wed, 8 Apr 2026 16:24:13 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/16] odb/source-inmemory: implement
 `read_object_stream()` callback
Message-ID: <adbG1gIAALhMINlv@denethor>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
 <20260403-b4-pks-odb-source-inmemory-v1-5-8b8d1abaa25e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-5-8b8d1abaa25e@pks.im>

On 26/04/03 08:01AM, Patrick Steinhardt wrote:
> Implement the `read_object_stream()` callback function for the inmemory
> source.

Hmmm, if the whole object is already in memory, outside providing a
complete ODB source interface, is there really much reason for streaming
the object in practice?

The patch itself looks good though.

-Justin
