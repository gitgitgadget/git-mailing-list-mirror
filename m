Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F356A2AE78
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777138922; cv=none; b=C3M+aEcyGZR8w8KUgEJN6ZimhLtdpWqj1pXdPnULR9z5D4+vvo+ac3HHOmDaH/xJSWYndpTW8xhKiETuBJ4p+FcjGuOw9i+1xaCqfuHJHyO/9o8yrQmDteCNrnxIaoeHc2P4DAhL7OaKNl0g4RFqPZ+PHswoaZv2ictFG5HO+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777138922; c=relaxed/simple;
	bh=qa4iT35RdqZoFH2zGuuT67CcMySZ37D2aqFdT7kZHvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLHH9SQfVdXSKEJN3KD2+uDJVZ0rZ5fQUyFsdTHoHwxmhZh+TSJrDGOUQzLruZG3HXHum8KDdoXMPLBFn8Kd1mdGn/le5yfl/s8Hem4W+vt/Ccn6F8nqHbnutWlaQs2kAcmr1juOUm91bl+mK0jjwNT60Lh/2eHkJ6i3cVVAOrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nc5EozIg; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc5EozIg"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38e800deae4so75471601fa.0
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777138919; x=1777743719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjQgwOIbb/W7B1CDriEVOpmKmCt5wu00CQ6nskASq5Q=;
        b=nc5EozIgcgLJPK1S1x7TBeNNdZct2p5PaHF2Cmssm+K1/ckkzFLgT94pE6733I+6Gw
         SXGkWKWa16zTEH0uAG9uqyTFmqzqgVlXgcAfUd3IHslHyyzPkQf7gk3vBLcOBCxff6R3
         jODZPF1TKpEgog5WPS0GON3MLaH8bup0jex3ZEtmU0lEVYJrklCpcF4Czw2vIRWKBzX1
         nqbyVLqyqLs5dVV9+3XjHzkWgANnvNm6UFX3l44JYdR1EfljoMrOI9d/WYZ7FSS1m5/d
         PE3UeWs6Nfa9u+2fajZvES5BSzAptuQLw5DwpEyJqIwoxphfb6a9zMRnR17Um3q2BZZt
         kJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777138919; x=1777743719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IjQgwOIbb/W7B1CDriEVOpmKmCt5wu00CQ6nskASq5Q=;
        b=BX5dojHxqjwZYKkytRV5wxvQm2D/CL3on0qWHFHB5hHfztmWGtDyGz5LnSiqV0mgkQ
         5/uylXZz8msTPp3iH269vm0lwIhzp5oNIXkALSR2Y6vZI4v5iShypFiE1VoKR/czIE1I
         nYPMZe6UnZp83xumVeTyGeH6c61iyCckguX5RmTfduBg4X2Gu/cpThFLF+YF69DyBLhT
         ezWKKzSMGt3QfudKlFOuGxvKNZShgW0c7CWqMWlTWH7fm7Ms0D2AdwFTA6CXLibLiCtp
         g/pDXc6nApLmjKjAJoNpzKG8gOO6h05rLhh9rSq36ygffbtQKAl4WQULy4s5U+6Xv9kR
         DUaQ==
X-Gm-Message-State: AOJu0Yy3rfrLBSwIX/8PUI1yb19CX2UiEPVCrgiQdgT1+opbQU+I2TaC
	sCkTL9r9Rwob/m67yOQMFfP8MoFwXy0i5xG6LUPKdXMNYqfNWKIna55l
X-Gm-Gg: AeBDievOpH63Dq1/s0WIKRXk5561mAQlOd8fUFP64T/dDZZy0aIvcXAQA83pA0gHLWT
	by83gIAYLTVDwac23b940BoVeIW/pl7pRpNUSab229Lzw2ewh8JDq0ZFn7QnIargks1OmLnV5Bv
	+CbYCSxeIgR1XBbOzSdLhHBj7ss7XmmkFOl1xxIJklP+LzMWl+6FzYVj9mCcnm6rwxiVGVjU+u5
	dg9La70M8C4vCCvBHsxk+PKkA/LEyk8V+bPPcX+CAUgKlvHtRRgiqj5bF1TvepgUR0TyQdnrA7S
	4M+HKSnZ15yZhPXf7vc2UQeAejQ+XjCP50BP+hKp5jpzctWUqob1XMMe6GkpRDL/m7chqQmzUHm
	HVuKWm7YrZYeYAnM90v4Du0nIOthyCMH0ILmvE9Bot16V9sE5dUx13X7CWCNZxJehZM5ZLCxjm5
	17jguwGnnBlC3QGWPO4DoNe+AQZF3cJWZOksOPTYOfxjf0AtGTUziiHngFKPXbPpvLp1S9NdquV
	a7gxnEEQ4TV/RHDBmfYq9fadmY=
X-Received: by 2002:a2e:bc26:0:b0:38c:13c8:a4b2 with SMTP id 38308e7fff4ca-38ec7ac9142mr129530061fa.17.1777138918768;
        Sat, 25 Apr 2026 10:41:58 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb73de2esm55720651fa.36.2026.04.25.10.41.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Apr 2026 10:41:58 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Comments on Phillip's review
Date: Sat, 25 Apr 2026 19:41:57 +0200
Message-ID: <20260425174157.44868-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0-rc2
In-Reply-To: <89f923bf-e5fc-4557-a2f0-d240db07eaf9@app.fastmail.com>
References: <89f923bf-e5fc-4557-a2f0-d240db07eaf9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> > Add a --fetch option to git checkout and git switch, plus a
> > checkout.autoFetch config to enable it by default. When set and the
> 
> Why is the config not `checkout.config`? So it’s named the same as the
> option (modulo snake case/camel case which is not relevant here).

Will rename the config to 'checkout.fetch'.

> The motivation for why this is being proposed maybe might as well go in
> the commit message. Maybe that’s just me.
> 
> The commit message just says that “this thing is added”. Not why.

I will update it.

> I guess a later version will have the changes to the documentation.

I forgot that, will add it!

> s/remote-tracking ref/remote-tracking branch/ ?
> 
> git(1) doesn’t have a namespace for tracking refs in general.

👍


Harald
