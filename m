Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9DE175A6C
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 03:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784430242; cv=none; b=Yrn16DchCnFW4Sc5bx+i4KCSz0U57Ax3mUsu8y/hRKHbHBYLSP0rgQtML40EazyTJu7yf3epBdDFUNR28FEH104RORECLHJgj7wLo5XuYvxEHVLf9+48MjInNXgJQ4vsvbzb1oEUI6V248ukqnMtSeti4+WZgxAJkFbZSjj3oaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784430242; c=relaxed/simple;
	bh=efeaCEiEj3tEeBREDH0lyYbMHm+60W/KTmvPd/KaCg4=;
	h=Message-ID:Content-Type:MIME-Version:To:Subject:Date:From; b=R4vKiuCGdQHb2VtehrMZEFfKer0bRdqLvyTtkKSKWnf5R6AXPULhfFQi3pPXwmf4i6g1+2i4Kt8gE2TewYTEqnYTrAj4O8IaC8prZy03j0WWl//J5Doj5RlxAEz5doSCtY+0i/8y2Ge+kGctJKTJqYhofQ+letD3/KcSwuU/ZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkKv61/h; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkKv61/h"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81ec29f1d07so68040797b3.1
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 20:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784430240; x=1785035040; darn=vger.kernel.org;
        h=from:date:subject:to:mime-version:content-type:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=efeaCEiEj3tEeBREDH0lyYbMHm+60W/KTmvPd/KaCg4=;
        b=gkKv61/h7NG0j1Ievx8V0A8OawCTvBMnF3e8vj2+K013dXXtji/pag5VXQDbPVpY0j
         6ypWL/xvKZsZDXickhwqzS4X1M/QYIBUtMUdc0zQLhxgwX9pZZGn3yJwUwqZukw+HQ0o
         ZXFNCuGnSOry9LKoGr6FgdPaTUXBemOvmf2MqVFPAw06T8SgZnPR8+YSLhjFZVcvu93A
         mZCIwf1jyPmXrZ6KE2ufVuiEoHkR67ao85xF45+HnIRHiJSkMHfPldwpha/V+L2Kiecf
         8ROw448hLMdCYAGlJnFNvOyJiXIMjD76UP/jccvaM42jUOsZ9rfAWw1Bo5ZIcHN5VWOQ
         2zVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784430240; x=1785035040;
        h=from:date:subject:to:mime-version:content-type:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=efeaCEiEj3tEeBREDH0lyYbMHm+60W/KTmvPd/KaCg4=;
        b=EYJ9irm15vYRy6ZfeW9D3oDTR8F7RwIsrYLANfjc/4c2g2br5+8AJFbEh9GEDWHL0C
         yh42wgBuu3vaynNeu9v+t/7MNVN8+6fF5jf/NH1CJZ/MA4gzAawVmiSDvxAvsxJNUSZO
         GJKLcjLvo3gxoqYElW6EL5bjj7Kj2c6+HvCEAr8lZI6NKXdR0ea8gct0GNYmNFITyw0p
         Y4I1w1LjeQH26mYDl9ymp4S/Cx2wiH3SsXwOC2XB6is9NcGyqjpngkLF0ZmB7D/LD17+
         w5o3ltl9EKjH+01MNRF1yViW9+1pv5int3dsQs0eDUDu+zu3Me4ObuLm5488TZGB3OiE
         iwDg==
X-Gm-Message-State: AOJu0YwMFu4xnGcI08MZ/0BgZVepzVGrtaUxrpGdzgVNlCMkPvNWNprF
	dSWjKo6i9w5+EU5aYCXEEzJrVoq2kpR5sRkL11NwYXSyCpBvOqNmsAsK748s1A==
X-Gm-Gg: AfdE7ckP1EQsdPPp2SZqwaZ9wBjZipdZSN3nZRPzcDy8zoT64bv5TmIeKyTX74NoRpf
	JRRlCPJ8JzHlKSzK++RTnB6fyyeg+932HUmcReus9yzoZ7Skm17z+88GQTl49Zwi58gO3fhMyPs
	m6Vx8uO/plylftj7lwOsWESPgL7ikPAKqeKx+GHlVguGH4dXjf/emj79aoephXYAZLORe9W2ecl
	GZMb8LcydpA+5uTzUUSKD9Cs5RpqPIQ2ezSMPnCfPxWYFgnPwz91Ysrw/0WzYUPYrIu1mcZhwrC
	8JSkvJ50MUkDJz2XvPoy1WjnsQugulV4e+6Bfk3l7840R0V3+LP+3jSoUZc+/JFmf2XHiAjO+P0
	odOfu0qVHl/HzbPaB6V2lE+X+zisdTuDN/l+rev/Pkpsq8m6BCERUhYOiAw0OTniNhIaCFk4N1a
	aJ+X+HoC6QHb40tvO5iY61CLfU3JtmqdmLiuT9QGyph+Vbm4LoC14Hkj/LT9ik/2zHSzyBuokBW
	uly9MZBbruIJH8bO3YDNfeylPgdl+QiIsO99ePh
X-Received: by 2002:a05:690c:c1c:b0:80b:bfee:c427 with SMTP id 00721157ae682-81ef25a3bc3mr28750357b3.13.1784430239809;
        Sat, 18 Jul 2026 20:03:59 -0700 (PDT)
Received: from [10.5.0.2] ([74.221.178.247])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef4012c89sm37468187b3.1.2026.07.18.20.03.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 20:03:58 -0700 (PDT)
Message-ID: <6a5c3e9e.ddde9de2.aefa6.3878@mx.google.com>
Content-Type: multipart/mixed; boundary="===============4825411221471200695=="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Subject: Thought your community might enjoy this - CodeRaider
Date: Sun, 19 Jul 2026 03:03:55 +0000
X-CodeRaider-Segment: rust_discord_communities
X-CodeRaider-Source-URL: https://git-scm.com/community
X-CodeRaider-LLM: yes
From: CodeRaider Team <bobjim8889@gmail.com>

--===============4825411221471200695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hey! I'm Eli, founder of CodeRaider (https://coderaider.net), a code-raid calculator and strategy tool for Rust. Enter what you know about a base's locks and it gives you the optimal sequences to try. I came across Website and think your members would enjoy it. Would you be open to us sharing CodeRaider in your server? Happy to set up a channel or bot integration if you're into that. Cheers, Eli Young Founder, CodeRaider https://coderaider.net --- To opt out of future outreach, please reply 'unsubscribe' or 'stop'.
--===============4825411221471200695==--
