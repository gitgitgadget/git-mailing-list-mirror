Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793727303;
	b=yg1DzkKv4FjqZrxAY2QOhZP2PmckAgzS9PckmQPZ4mRZ8j955/vF5dFtUFw4nt+SQRto
	 ujVzMliJONrUD/3wR+rAjrBibpq0w2Kcde8uO8pwbiKrkNaI3yVvinx/Xsv34cUpnl20y
	 3EDXajrMiWioR+zgzVhMk1cwNneOZYHPHoPAJR9BjH8dlTWdL+/4jv4cLtsw4P2A5sYFV
	 I9BJ8xP44Vs6sf9l9yvdidKDXR/Bs/mRnFE7hFG4r+e3+9dtxMmPzYvOoqjynG5LXQVHa
	 0afpFYeAjEFlk/dy603kCCkLvv9arRXh2IFxKOn33QLqWXE29d/lPhV5xn4kh070FIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=V/3WQ9gE3QRrqMkA+TkK7fBoymZjU1irAf4mLACfWjg=;
	b=rvl9HXT7K6qkdJl2rpmpFdcgUxk2lITeRndotL34UfmOpEe43GWc0URIkrlnBnFhOuB5
	 5lKeyKNZEngJB19dYLp+lBLfgW4kXimgFzd4Xb+ocX0yojS49S0tyB+Tv1UO8sdxFaVTq
	 7xxDU4aBapRxK20IWIyysbErW4Hmek7gx2WcIKjnqbp3iESpWiHLaaznwvoSSgaUaQX0v
	 kq3FYvuR/TJlVL+H1t7eZBK1c6MVY0r9uiJP6ytSsR5oXMcDsmxsNEm5MTUGepuGwI0CQ
	 TS8mqNm+D+CB/QksV0/8en9+tDeUKJbiHY+9fbZHWphH1oKKI4WTsGbG7rQUnMlzMwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OCv+0tfQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88778606A328
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 17:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88778606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OCv+0tfQ
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-677bc4704cbso3987840d50.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 09:35:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793727302; cv=none;
        d=google.com; s=arc-20260327;
        b=ijN1niZeGLpIqYy7KFUWiCmPWxG3v3rkEoUvK87FPo2J5B77S6MWS14P5lecEiakQJ
         HdEXqIIZ0XZUMSmYiGXzoZGAN15h9rYYu4ESBB7a+l/ZsLDiAmtB4N4J/X1jYYDZSRaL
         +sXMd0fDMve9yFrknoE7xzXupIzj0RYuyQunr6jRZLgTiJEPSy3CW1UbUwT2F8NGimcv
         k/mYOGrl11+LRPQ9q412P2u4rMalxxpeiv1onyAEDw9WyxDhOyUR7EVNXESegijMbVZp
         rFw5xNupnfrN9J3LNg49KSSqnI9pRgox+AAo+1X5bZBcJFj1vlFQFtbu00vApD0Rnutw
         GI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V/3WQ9gE3QRrqMkA+TkK7fBoymZjU1irAf4mLACfWjg=;
        fh=UFgS+MemBBR4Io3o06YEiljwKGXt0sXLpVmBlF/0XOo=;
        b=gs3h27ewKkwq5OcWC1q/4eTjoewHzF8HLwHNDouMKmySRg/HOFaRs1dhtaOtO6PebY
         S/flOa0tJFCtMFK3QCShPxf7RmlQ8yM+6JcKVHNZFEpadn0O1cdIZt5ucysYN/wudFvX
         yv0KXLVfBuTKUXOlNgX6od1rDn7lcpB5a7mV22wXojRWrXXHB3DSpT/Ru2WgpWuiGo7c
         a4uw692In0FjshZJMqI17NjJliAIBzEXxPuyazEluNWWL411VcZCnsrQc8l17f3UXhyN
         keOQhRTFBreLTt6nVyWdRyt7EDN6BWaqpbuUA2Ch6Jmx088b8a6ourm31nQTvVRE49KP
         nxcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793727302; x=1794332102; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/3WQ9gE3QRrqMkA+TkK7fBoymZjU1irAf4mLACfWjg=;
        b=OCv+0tfQK+NT7i58zDrOOniDorhGKX4hIJ4v5vfGmTTjZxBr5XdVQpvu+BMVdKRd2G
         +sU0KQffB8yTTnPKUZ5VAGpB5ZNv2W0xnLZI04x1I53Aenqo/6TPzqamY8WRaSYE1o+o
         eMXbN/KP+kh/V3iJUxTGe7VuonCpb+k0sOIy3SMb1XLsOrskJJi27MTL4zFGhoUQ8PHL
         Y9szoV9LQZLBawy9wasuw7ae6qjoJtue5+lWGCCxY4YAyRQPrczJRikQM+SDdvbwdIhk
         y+QQQP/mQ0vxBSVHp+wF11hA1PT6x2pu1ZAcVtEjmzRliZo8iPKd2vcB28EFfQ9cW/Y1
         8pPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793727302; x=1794332102;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V/3WQ9gE3QRrqMkA+TkK7fBoymZjU1irAf4mLACfWjg=;
        b=vor6WeZiQH06TMsTgQFd45VNgE8YnGInw6kpRhcUAGTq8w2I1MRNKCybBL+Omzk1Zh
         OLB0uj4JK6LvfJpLSEskZlx0WbCFC+SEEoAoGlMB+v7oaqRdUCLMVgo/Kaffh4ryUpU0
         txDJ+BEVo+6M/rKPapI+DyjJws8BnZHgzkCRB3+gV+fVCHqVXP8PsEWxrjabN0ySRqHc
         GN0hKV41ecIFR5c+C221TUpdjpoOJI6l/x5aLgD1Vh2h9p+vichW4WJwd8nQRllF/pwY
         Q8N+HmYCygL8ihEFGHMK2F9OWaGOedNgmdHTcXnBS1qZ/YgXm2q1vuvunmalVcJIvAWb
         BzuA==
X-Gm-Message-State: APuU4Z/rKmujBVXPn+0NZmdNNxvnkrxm9US4m6055JmQ43Te38eTtKQU
	Icuhk+/2hleX00y3a6AMKboTEeLMA+HXVWpdtFkj8cJCOtFW5KVTciNi/Aq0eSl0gnJYGdq08UE
	US7B3eRl3zj4JJR3DVH9trnAQA6hVMRM=
X-Gm-Gg: AYBFou1t8iLOkd+JSHkz3oeZbsrVmFdihxuLHN243haOwBm9PI1O+lOzwF4TTnD386o
	4ZkolkYMtH1aeHlfa2YE8vhaNf+hPSFKnWQRQmfDAJAn9bIfuDeBlOsCdzpSZ9h63BqX1kvUcMU
	uvg1CAPn5qYCYAHfk3jZbI8Vu4RTAti/eyVOGZZRqbmXt5LC8Xi75G5VbpP0xVbVBrY1ql/hqNA
	4NH2CmaaAOa0GvhUZHUwrDN/FkQ7ol1cSwmvDpVylIavE8fUrFhPXr4QHkssVWNOn9Bqpozlv1S
	J5PEjdbwfE3iyK40CfDL274q9EVqAp+oBOXXlrNFxSvswA4WvdUTtoM6FnlIBdwQrrMaEyB3GIj
	ZuSHzOJZCtX8sZkBzJYhu6McOnGWhe7zXJRxJ
X-Received: by 2002:a53:b420:0:b0:679:afc3:b990 with SMTP id
 956f58d0204a3-67ba50e13abmr6250422d50.152.1793727302445; Tue, 03 Nov 2026
 09:35:02 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101105859.25579-2-pushkarkumarsingh1970@gmail.com>
 <20261102122955.143018-2-pushkarkumarsingh1970@gmail.com> <auiHS_439EeHCGH6@pks.im>
In-Reply-To: <auiHS_439EeHCGH6@pks.im>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Tue, 3 Nov 2026 23:04:45 +0530
X-Gm-Features: AclHuK8gTs1kOTaPZNSwSU0c6VQdbZ0EvH1trGvvcvonb4dh4nuFhqLGzZGbJ14
Message-ID: <CALE2CrTHzsMFdae6pTgXQWXKVNw3xUw+fwifz4+4RcKRgLV8wg@mail.gmail.com>
Subject: Re: [PATCH v2] maintenance: improve handling of lock acquisition failures
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, mail@thomasbachem.com, 
	ttaylorr@openai.com
Content-Type: text/plain; charset="UTF-8"

[snip]
> This really should be two patches now:
>
>   - One patch that changes how we handle the failure to lock.
>
>   - One patch that introduces your trace2 string.
>
Alright, I'll split these into two separate patches.

[snip]
> Why don't you use strerror(3p) for both cases?
>
Makes sense. I'll use strerror(err) consistently.

[snip]
> There's some duplication here with the auto-flag case. Can't we
> deduplicate that?
>
I'll clean that up as well.

[snip]
> One note though: please wait a bit before rerolling again so that others
> can chime in first. You should ideally reroll at most once per day.
>
Okay, I'll make sure to give some time for others to review before
sending another revision from now on :-)

I'll make these changes and send the revised series tomorrow.

Thanks!

Pushkar
