Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368AA19DF8D
	for <git@vger.kernel.org>; Tue,  6 May 2025 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746554777; cv=none; b=QtcZE9QBsDNr2mcFk6YlK++o92qkhgwDzc3WejClVr0D1JuOLTQoYZ2WK5S4isEYitcQR5g3MRqUgds/Y1RKkzEZLSJU90aCgs1chPrlKJvD+L8LHlI79tunavaR9TJTqJQfwxhjcPNGTu6FGu5XWLijndyvZGafBZ14A2PWHI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746554777; c=relaxed/simple;
	bh=ewHbEZvPMzwc3YBLY7PDbCFC6hcYw7ENLd6kxPn3XSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G1XQgSETZTQtDs10CbN7OOuXBDO3AYFxSd8zVjipCubs5PVClLflI+p1o/1wweheRhTRnUjW0jK34dgNq0qV1sybRpY8IDbHZZRhmuVBDllv23fufD9Fwi3Y+IEKbRRWv0gDV3XnGmIJzJ9limmU+vdg3YZkWfi0JUpQBQ4j3sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KB35FoXU; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KB35FoXU"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ff4faf858cso41276817b3.2
        for <git@vger.kernel.org>; Tue, 06 May 2025 11:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746554775; x=1747159575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ewHbEZvPMzwc3YBLY7PDbCFC6hcYw7ENLd6kxPn3XSo=;
        b=KB35FoXUwsxtZNKkmVf59HWCwZjcJCTlwEYLtgx4xG7dMo5mHGrQUFrxAHbUpnaRMs
         aAL+lTNWgkvu6s/Nhi4XodWuCBCDxCap7H6fVV++y3lhFl3nixtOMButgBLRx3I6cDPP
         hBnGFUO3EZFfakBko97/fTEfsXM/rX7xGctRO2ivFkfqyXyYIRuPmlDq4BHXeIBFtGHz
         meezhho7KfdUAsvKZJhZ1Naa48e13Rtjm7VVhfIZpj8kQasWGV0WNSYr7Lraz0mANfDl
         z8Tug2E3jo1MJfW1BwdxHKFFxuA2DWtluFy9Bak7e85hthMIBGBHPeBE0V4p/yhWRtgA
         gx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746554775; x=1747159575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewHbEZvPMzwc3YBLY7PDbCFC6hcYw7ENLd6kxPn3XSo=;
        b=c/dsM9zbPzzxeJCiI5lluoinOkDT+NbYodiBsU5iLghM3xdiFI4+8gCETp44cZv5L4
         434RKifh3QDDDLGs/GpXQE/A4MS6PI7d9xFT1C30O7ACzp4K6wQiUff7dRn0woNntJCr
         WIEtw0qTYLzB8cDvppJdk1v41krVp2YcH8TJNuITSeDX26q9P55zzrC2eDJbPqSL8NB/
         /m25nMA/Utd8nTf7Qx07hPBlWf5DA4cYQKnS0iF3dB4f4lOWNonroK5oFG6BUJrYt0HN
         Wk6Jl1sdNXq46GcBsLqK+8k4XkWmMaVp0d/3xcw6hjzFEmXt0KMmuj9aAQpQzhMwWehV
         xSkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFNmIjLcGA7fUFRC485HoFD7ofqmbbgeshvALtmiqdrh2VTIstTyaBhMr4M7Wvc0lGpj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUeM2UUTDnaiUn4hwOcKEG9Lyg/yrW064+VJPk/yDxNaEp6LD+
	iCv7lIMLWGffBjZKwqSI73Wo3DyOW8KFS8wLg9uAQR97av3MV10b
X-Gm-Gg: ASbGncs0h6FX2ZHY9lQWT9fNGC6L21WItlz9PZB0Gzf2XwuovUDOblEdZIFY5ddhl/2
	cDoXwrjBUGuDNhcT/anDtighBdoo9mxsWYpkMLtWOA7/BV+ONNX5N7FesqWfj3mPnZAJfNAmHsO
	PHdXTUoEenXrwdzH/UP5PCJMYNoBJ1ESkRSVqnfkNi7V3RX9iAFbO9Xf2YburxVM4D83Fv6MNOU
	t1AHTcaCi8oKfbU+sbY5KcDlcIONXcs7lEscNjnSbS2tZwQvVtMQDMhC6HZxZYeJUWN1RyuJ+U6
	2QLOLJTzS1HvphcGDkzD4icqWPxfprUTDfpzjF0UD4W1Z0uXNopqMY0UPX4J6gSgDjnAL+tp6pQ
	A/0/5OZY3wh3FfdLbusPSU0778y0=
X-Google-Smtp-Source: AGHT+IHnd0d/SC20EzCvsi2AffTjeLKsg0gRwUIl9XzcrgBAazI2K3Dr3EO479FljKjNWsOtUgeTJA==
X-Received: by 2002:a05:690c:4587:b0:700:a6be:d6b8 with SMTP id 00721157ae682-70a1daea35fmr5503887b3.35.1746554775063;
        Tue, 06 May 2025 11:06:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:d190:934d:4c0f:2336? ([2600:1700:60ba:9810:d190:934d:4c0f:2336])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708c46b9e38sm28628967b3.103.2025.05.06.11.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 11:06:14 -0700 (PDT)
Message-ID: <a6b1bb83-02e1-4589-92b2-e005673a3c42@gmail.com>
Date: Tue, 6 May 2025 14:06:14 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] object-store: rename files to "odb.{c,h}"
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250506-pks-object-store-wo-the-repository-v1-3-c05b82e7b126@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-3-c05b82e7b126@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/2025 7:09 AM, Patrick Steinhardt wrote:
> In the preceding commits we have renamed the structures contained in
> "object-store.h" to `struct object_database` and `struct odb_backend`.
> As such, the code files "object-store.{c,h}" are confusingly named now.
> Rename them to "odb.{c,h}" accordingly.
While I appreciate the goal of this series, I'm not sold on the need to
rename these files. Not only is it a tree-wide change to the headers, but
it now requires tracking changes across the rename which can complicate
history spelunking.

At minimum, the method renames are likely to create semantic merge issues
with parallel work. If the rename is truly valuable, then maybe it could
be done in an isolated change after the method renames are landed?

Thanks,
-Stolee

