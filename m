Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B2248C8C4
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708570; cv=none; b=RiGEY6GU3pjTKsHH7xmOjuZR6ekovAODwhS0rUT05pre5/AeTddMzqCrjeuqfgkESgYVExrAhShOD58WtJuS+tx7Mt4XoV+O3SyfcOWkaBG0NeLw9OZrcVPaWzWtaGhnK+WaIwswEloqsl4/Ejj4lGnjIQhjf73AACN/Sd0q/P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708570; c=relaxed/simple;
	bh=txrcxJKssvEsx4HMXCM6LTwmzB9Qe2U2zVJzKKtrECo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a76QTzp/24zlyk2I9Fgzw4AkczUHhukW/oOS56li3u/fqJnNRPgq1f/FQJq2EYc+O1bLI9939Y84Dr53Ftq4iNKajC+e7GDY6nZ/Y9pNdwPd+ISQAC1CU75WePyB6k55ibiCqPn3qoKnObJrHWWehBXrf+F5txwgYMQ6a4oRsoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omkTnakL; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omkTnakL"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7e1916922b9so68284757b3.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 08:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781708569; x=1782313369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjAx/5j51JqF+Xw1whPeDohPINddyMmPRcORJ9pETCA=;
        b=omkTnakLEHRX8j0pxqeDXMfTtXAfMTX4MG6eBArh5tX2Aq2/HCz7lZEjmN4YLfY7Ek
         UtcvVqlA3iGt8iwDRe659N3fn5lvhFAliODGPloYSIb2AigAVQzpa+Up06frQc9c0c30
         Y1RL9/7fbG9v5qhHTGEuoIuLzYU5eEc5KyMR3jO5SN3QdUNGq4je1QVe76WIREstRohv
         Ajzu6XG+C7QnGjTQShRevaG0aVfV/Q9F16a86CbcIXnflrB2I7Ml/pj6IIYfxXmvUhU0
         EA/cP2qh8wRgjso87zqRH/8WVim6rjjL9QWWwJi4lHO7+l9SGpL0342TiFmhUYD7lKUu
         8iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708569; x=1782313369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjAx/5j51JqF+Xw1whPeDohPINddyMmPRcORJ9pETCA=;
        b=ROiPDJoGdVlt+7QzXgUgnd2MdINMewwEX1eXPh0/Zkj7IMaBeyknFfXHl0qeVTXJqA
         0hjBMj8WkUVgiyLgf6plwxPU6EBtlvcjmyKui8Y3dEqn78uBHzDMGX2ZkBC8dmI+MmG3
         OjACuzMsiRmafPVxFQ/zKNtSrlJt4RvtyPfFqjI5Nneys3iyBXHVGJTUf6ZGXwPTzrpl
         rEj9t0MgKoiS4K/4QMLunecw8uouxxDFO+uBtpXAIJzpnoYzNHc91J4Ch/PbThythzvp
         k85+0Woml6QWlaUPQaRoFbGVyFgFwHLrUQrinyYr5KoP/E+SUg0htkSD2jMQM9M2fXru
         y2Hg==
X-Gm-Message-State: AOJu0YzSn9I9n07tEgWvsro+Ej4+3/JnZKDzV0kC698pRSrcGIyv97qP
	YdIiVfK8+OlaDvjSkXY5q9NLvEvXuOaZpYyQghZ9+cWDNlIxSNdgp66w
X-Gm-Gg: AfdE7ckB8945r9FRmXP/7QggsjBlMqd3Mx4Y4zO4HpuK2z8EJkqLg1RnPC8wci6G8Pk
	XhZTQt/rGSIhL851veq6ZDTB9pD51IEI+UEs838znuqNVm/TXC28cDjjP6EMtB+FP2DZKJT/ghc
	+Y65DKH+a7aD9I/V6ZjLGBPhHuPjLGJ+2PQcMSDlech2/81ZQApevETcdeutjZeffs9+lXpt0J4
	QkWHlDNyJt1m2LvyS/h7L3OWUle7YKwAVAvQqr9qomcW7uAxum08mBtCsD4Z3nIpJgwWuqoxGxW
	PBkAGZskiDJqYeGUbrruAtW5pyfQ11T/h9YN4J7UKv91+B9crCT+8rLocOOYqDs/CAsJgBFJTTW
	ZqEHeUi6XsrzcrY4qdUFw9CI/UNL/H3tY7phFa0RSaCEn4x6OGYq2LZcyyFsl0jI07G7pDjRtiX
	cXOfTKvw==
X-Received: by 2002:a05:690c:670b:b0:7fd:5297:28c1 with SMTP id 00721157ae682-7fe5f080a6cmr43395587b3.51.1781708568442;
        Wed, 17 Jun 2026 08:02:48 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7fcd3b440d3sm46386727b3.44.2026.06.17.08.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:02:47 -0700 (PDT)
Date: Wed, 17 Jun 2026 10:02:46 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 00/17] odb: make packed object source a proper `struct
 odb_source`
Message-ID: <ajK2QKdW-TdflfR0@denethor>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im>
 <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>

On 26/06/17 08:39AM, Patrick Steinhardt wrote:
>  5:  8eb3cb17a1 !  5:  c9b1e1da26 odb/source-packed: start converting to a proper `struct odb_source`
>     @@ Commit message
>          odb_source`, as it's missing all of the callback implementations. These
>          will be wired up in subsequent commits.
>      
>     +    Further note that we're also registering a `chdir_notify` callback to
>     +    reparent our path. This wasn't previously necessary (and still isn't at
>     +    this point in time) because all paths are taken from the owning "files"
>     +    source, and that source already handles the reparenting for us. But a
>     +    subsequent commit will change that so that we're using the path of the
>     +    "packed" source, and once that happens we'll need it to be updated when
>     +    changing the working directory.

Ah ok, the "file" ODB source already has a `chdir_notify` callback
registered to handle this which is why we could get away with using the
path taken from the parent. Make sense. The explaination here is very
helpful.

This version of the series looks good to me.

Thanks
-Justin
