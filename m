Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D386551FCB7
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791907284; cv=pass; b=Wtj95xbrszQmRpohGi6lvHltr8LnK8pu8X6k6xKHogMpHlltHPIYjt7rnX7YxzZqvwiLhFnEdTszL9aDMDS1GgB+ORXO5/vW+5iUKi64f2pHlWx5uQeo1OjyX/uESrPjEFuyL9J/izzRvhXj3aT2CnFbyZup7Roxt5qLQLRYS3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791907284; c=relaxed/simple;
	bh=BJyjIi19oJTiTWuhzlFHM7igBg57qCo69lS6C3epJH0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=plKo1P6LIjz5fZKa/ipTYeJ6L1wo+K833KJ6IRDezpAiDMK+8TQAGe2akm1cDtOW0g1OxqpsWc3x3nsWA/MNwTAPQkj4uOJwZIzjm/lWm+84zni9zCKC6z6re09Zy7xbSIneLmMFk888xviTdgpcph6RPg7453A+pwOaTMJoJcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAEZg3gs; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAEZg3gs"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-5058b105df7so1031088b6e.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 09:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791907280; cv=none;
        d=google.com; s=arc-20260327;
        b=Swxw+T33nve4TR7PpFA04fKDvgEoxyrNxGZCZ4X7mLKPkZneaEehEUPUxhcpTBxryn
         +5ZHbDU97E3WdV4SuJlCrGbqFYcoykDUceh54x7XJc6Hlqp660WcPvUKwdcmtZ8v3Z92
         3aJw22EBx21fkehKxh9bK2h2ZCh/touiKrz3AcaLmyiLUANPsSaVGb+RJuN5vxccKeOS
         1dtsHAzxElRYcCHhwS7h5FZ9y5kZZ/L2UkLQD5hicQ872KKf4+Zcn+8Qx5R42W+qRGDN
         xWWDN4XW2pvxWDZJLCIc9Sh0FlxUUexuUZyLl1ZMp+MqavheOjwwttr0Pl3nkReaKvqW
         Tmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=BJyjIi19oJTiTWuhzlFHM7igBg57qCo69lS6C3epJH0=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=IQl4nU3j5+mhQEqCDcrUmMB+XeNdVyNou/hmjz37rCUEtJZQoY8NbjjeAoF73otiYK
         S8+7ZHORa9A3JIiYa1Fh56tHUrTzeY3qu+nOR8pZINI5Ir5QkeT1UhTbgOyX+w5i6gwD
         82EGR6cOkp29PH79htB3UAz8DXEB9uJTRuuzWX7MYeDmAvUsvWq98CIFuXbkGbYBGEUJ
         wdKljLp6EtLGznq5BUSMbccrrwFYqIRpc0jB5xvzMOMbGfiyBePxTuOQAGXH9tHMKwdB
         W1NLjRP7l/SK+pH/DRGDU+3RByO42uCavEEPaedBuQQb5OIQhvyqSkjUmheB3HXzFzlv
         dfqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791907280; x=1792512080; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BJyjIi19oJTiTWuhzlFHM7igBg57qCo69lS6C3epJH0=;
        b=BAEZg3gs45+ojA49D1tanoS6reD+rFa2fCXvvwD+PshXdhrN5W9ZsnbTwASiD57dA+
         7YUlzSbEaBBFdbnA6ozgIt6/Ohb78KlSJC0eb6q2u6WOBMabCRRvZoZVYypUIcCpAdoc
         TZCweQ9QWquOA6Xw7Fvwsp6QYov0gYXnCmEmmBM18vYd2aVDkMg9oQdjlCaigwHqxeMh
         EiJcAV+hunhDispeIfatXOUihn/Vr3vRolpskq5wia+ixAeGAaaeoNaawOkiBMRSai3q
         LUMq1eBZMqO3LlxUFtHGk/s1Xhb6fwy75yWWYQllqj4uE1z7nq6lFTk8ItcWnFg897Pz
         Lthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791907280; x=1792512080;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BJyjIi19oJTiTWuhzlFHM7igBg57qCo69lS6C3epJH0=;
        b=DFwpg9zSXDkIiHgansHxtqH3++e48LBAUh9xEyUH66IWuH5MFaeXgxakKrmlOFUYv9
         iAYZzrRa+FRdORhB8ws7HcHann3Og1/qZ1vudNygUcv5u7XYRnEJniATEj97ezk0bbDP
         z16LA15aFSigGlJryyb6/ig97RqmViBnc+Ztkg1phQjMt2v/UR88rWWLnLDfZLrTbntA
         oDEFH1aJWNe5uVnwE6afD+DhX4P9Mlvp6MmFBSp8SpU10xNwCTUfuSUObAJfEV6fYAcC
         dxAkwJWeropHrWnK8ROFSvmLgx7Q+VAZcynbTCBnQ61pHuNqDA2rnqXij/5lmMCtYaBw
         xwnA==
X-Gm-Message-State: AFq9FYJXY2TFq+alM8yCsnaAYBMj7kYgAHM5fBXeufvAX2vmyk4d0Enb
	BXczxaENQGGZqgZs2K/iu+dRxmYFejy6S6SoCZ6CVN0/BTxGEk7OGfubLEB915qB7Y5az6Gk3OR
	x2eff1T2zS1dbXHYEnkRWuK97EB0IC/fT9traNY4=
X-Gm-Gg: AYBFou0XXqmaqdCl1OMpIhvrD9PEauGjyiFzov/9Gqlkakg03vNV0GytTR/q4LebTtj
	iQmiL2hP0lIzQHRA+Xx/n1my8nbXMhRIIyNxuYiegm+XQ2of1xKOUqsjOM2w0huTUNPxBcUl+SU
	4jI1g2wUUchmUsHT7la0Jy7h52P0eUdIlFoErOJUBachmiXlyTa7rXik079Q+Sl81uWdHHx+xu/
	GMzjiynKKUGHIRFEEtPTcZcCXs0Ec8BSJei5noGbQ7sAFXhVKJaRje4blU1KxYIuItQz7dnUVHL
	CeZXakt8XqlQ54noWV0U92M2U8eZM0kTdNti2Ld6uPAcm++/YilEQbN5
X-Received: by 2002:a05:6808:4495:b0:4d6:9293:9bc3 with SMTP id
 5614622812f47-50c592a3a14mr10353204b6e.61.1791907280407; Tue, 13 Oct 2026
 09:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: jyotish kumar <jyotishkumar725015@gmail.com>
Date: Tue, 13 Oct 2026 21:31:09 +0530
X-Gm-Features: AclHuK_6kA7h768kB0JuFMXNJ-8Gs3ik63Ae9ZMRk3kAZL9V7gyq6xAFFHu4QhY
Message-ID: <CAGjZMyTQt2XEF69pJWHA=diRjoidixGs48E1vA0ytGUgZYOZNQ@mail.gmail.com>
Subject: [RFC] pull: custom fetch refspecs and fork-point lookup
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

While reading `builtin/pull.c`, I came across a FIXME in
`get_tracking_branch()` concerning the assumption that remote branches
follow the default mapping from `refs/heads/<branch>` to
`refs/remotes/<remote>/<branch>`.

I investigated how this assumption relates to custom fetch refspecs
and noticed a potentially subtle issue.

For example, a remote can be configured with the following fetch refspec:

`+refs/heads/*:refs/remotes/origin/custom/*`

With this configuration, the remote-tracking ref for the `main` branch
is `refs/remotes/origin/custom/main`, rather than
`refs/remotes/origin/main`.

Since `get_tracking_branch()` is used by `get_rebase_fork_point()`
when determining the fork point for `git pull --rebase`, I am
wondering whether this assumption could cause the fork-point lookup to
use an incorrect or nonexistent remote-tracking ref when a custom
fetch refspec is configured.

From my investigation of Git's remote and refspec APIs, it seems that
resolving the configured fetch mapping may be a more reliable approach
than assuming the default remote-tracking ref layout.

Does this analysis sound correct? I would appreciate feedback on
whether this is a real issue and whether resolving the configured
fetch mapping would be the right direction to address it.

Thanks!
