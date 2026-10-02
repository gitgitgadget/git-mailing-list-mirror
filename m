Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C44470438
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933044; cv=pass; b=uEdJ33qDZOcnjThkGDdpOGWh6b+xbDeENNYWySfniV+1A/XIonCI0qZ1bfb/N8zbwpAo2dX4UqZf8rLP12yeELeF/wTFDZBdgYFWZM7VxRy1jbsJgsdLhVg7o1czBX2RqG+9kzpkFXVyi6JgHVGRsZMDrXnxTlZrMZ/msnz/5KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933044; c=relaxed/simple;
	bh=SfZ1qbV3gszADcBAdFHrWI9cOkurD/bxPWEdpt0r5eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hj3szvdps0BRqnZGgsg/nwphsQ1Z04+9jh+gL5oJUu2d45c1cyqIPw6hGaY1mCs9gTnH3jTV4e6XNdCHfzl30adaf/M2NmmpqLnrowh35r3lC34L3M4ENkJ4U3h0zRACyACiBKMTJHtznnKZOblvcoZJGOcf/FlxzFJdjZOyy1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=WMl+9YjY; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="WMl+9YjY"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-67375a844dfso7048377d50.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 02:24:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790933041; cv=none;
        d=google.com; s=arc-20260327;
        b=Ls7gYsQTVrMvxQQkUqfI96aVW5WEw0PzjIoPsIAZbt4rOAHCW79tJkJFCpRzk26w+8
         hn1vm2k3HCgo4HP4M9/UeL1hp2h04iO4qRMbmJIdUMysvtUxeOiO5Cy+hh/0eZAfWVJZ
         HkJ92ml0HHDzToFtqDOYy7hNNlqUTiD4PgLSn6QVGaVcAYsEcvEBh08dL7hJgQreZ4dL
         47RM7TiCZAukMYdtsCS6IxIp/Jgt+E/TRe0QtrdJ22/aWUsYyuuLJjczLRp5YuzmYhdl
         4kiVO9F+vXBX8rlu7j2TOX5vQzoRD53Zb257SQgyCteMvU/TVTj4tUe/ori2j+ypL1Nz
         n60A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SfZ1qbV3gszADcBAdFHrWI9cOkurD/bxPWEdpt0r5eg=;
        fh=FjyrIvil5ZczR1P5AqAaM+JROYT/ghX9euGN5tQAPrY=;
        b=fQkMSL7J3uXK+hnedhP+lScfIWj9K5OKaBzGwwyfiqCOQR76FbNFz2c1sdBA6VbtcY
         KeUEeAirRkoI3ND/OWE8lOflLAg6mQhQN4AHI4bq3dqa1fr0jCL4S4lMZvfDTZcHgS83
         FcP0YocBO3tyis3zQJL8VKyBW04UXI2bY3z9JmFrnxMcL5cOrEH00KStI32JbW8uXRsh
         BL3khLZ5h1sq+ANqTO9+RSccjKugRCXGVa07Oab6seiVP3tLzlXtRpbn0uyfOVatq61G
         Ickoe1bkd9NIOrT/mvLTphaPXKAq0MGFpHbZVFPRESnnGad+/RxCa1pesg/JRV/67I4i
         wBqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1790933041; x=1791537841; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfZ1qbV3gszADcBAdFHrWI9cOkurD/bxPWEdpt0r5eg=;
        b=WMl+9YjY+xtlgUFglQbvEB6ksRa1ZuiM3kZoAFNgHNS4NETlsYk1jPUP8HmT1v3ivg
         sbT1wP0FRi9zh8uW8p2AYtq5FfM8MWHtu1zQrOtFz8VCb/NivxF3IZotCiBiUGxjUEvi
         lf4OdZRQrAHG3QeQYdfECYTW0FVlVU5JPOqr417bCDQeqvoH+NZLqQTJTOnIVnQX/Z8f
         bYHPHTdToBm2WuREuiAt4YCGxGde+5Ow68zg+maWaY2qzFYuzbkSR2+1VfyfcyG4xfKo
         Z3fTVpPf1KwZ4L0+UL+Vx8eBc9Za5NffmcKu1cMjGRIya2EAoPYsU3gyCIz05yd9nrED
         pA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790933041; x=1791537841;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SfZ1qbV3gszADcBAdFHrWI9cOkurD/bxPWEdpt0r5eg=;
        b=2lZlIoKy3ys8r+HBrtqxfCY46tiSCUncC4Nc0yr662dWahK3IyUIu9vhryPV421QKe
         MDqchZ5C3EzWjMDXM4JQ41PUig+BSJ8jrjdnHy9ZT3cv9F/8HC/O44cvEkxuxnV4sw+H
         oYjrcJx6bbd9RspBFiBD62T3L0TFGSXYlbNdznxvD5DKmTT4pAer2jBejseDQRYlw2vh
         wfv58h9jtG76RGUHK8hO2BvFPcdooE/hp5GLIInj7VfTDkDN9PQ6FI9B/id5ivhYTUa5
         zrE4rj35TxGczQzEVQn9I+Ez3v+jJ2bShvJEGC24w1LgVuUzUpmW8FTyJb5npMc6unPU
         tA8g==
X-Forwarded-Encrypted: i=1; AKwUvBxsAUNhr9Hsg3OytBSc+tw+zU78GX1f8ce3hFBd9hbla0HroBkxYum4kSU0QM/hMDMETx4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJntFVHPmIw01UIVq6HVDgAdzxCqH4G2rDNOm7Tx5JImLmHfJ0j
	ZAV2sIGgi8qv4aALmIjdBzwU2M4LG0+0Kwp92FOS3XT/l+2qya2X+r+DW8MkSGpPWR1MRXx357M
	ybt6QJBTpwBXbTn5u++9f3HooXELLrycaI/3X+FY9zg==
X-Gm-Gg: AYBFou3m+swZ3dTAfhZFvd8W2lFwZYNuFcbonPCDfC+5H+POtoWHJwOIALudaytJovV
	xT2YgkNuzhQiPTfasBqx4wIXKl//XmyhlBQUa/seFcQ4QGhfQ5n6k43DsLI8QQiSbGOVBVFSEfu
	RHamG4pJKYtuGmr2xuGiEGcz8sT77hPnW6E+DuY2XrBXWpKCEIHMgaoZj7oH2NF3vt/SETkt5Ew
	+SNU5yskQrJTt2upP9VuVQ4Pez8HqdYMbuSbsKzf/niEhZUwucNAGfxdsAHSq6sh2w9oXhK6E1W
	oUmx7ybBssp7MHZ0VvrgOi5vQ9DT5x0fUxW2hz/Ytd0Y+I6SEp4R4I3mVuoEMOFw/gwkFkJDvzp
	GYldyzlha0etv74pcYlTthei/W4SFcOfh4AnBFcsODuJ+Pk6o5KHd+wOA
X-Received: by 2002:a05:690e:1913:b0:677:aedf:d296 with SMTP id
 956f58d0204a3-677aedfd46emr552520d50.7.1790933040508; Fri, 02 Oct 2026
 02:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2243.git.1790606282769.gitgitgadget@gmail.com> <pull.2243.v3.git.1790843056949.gitgitgadget@gmail.com>
In-Reply-To: <pull.2243.v3.git.1790843056949.gitgitgadget@gmail.com>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Fri, 2 Oct 2026 11:23:49 +0200
X-Gm-Features: AclHuK_lMYvK64lHw0-aFOp0Bl8is9HUywsfwQ_QrnbES2Vi4kLyQSnq3PPVsgA
Message-ID: <CAA0xjtpM6t-Ga57UF0yrv7=ggz5GChHSk7hTQnGbVfAykhVmQw@mail.gmail.com>
Subject: Re: [PATCH v3] t5520: don't expire reflogs where it matters
To: gitster@pobox.com
Cc: gitgitgadget@gmail.com, git@vger.kernel.org, ben.knoble@gmail.com, 
	phillip.wood@dunelm.org.uk, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

On 02/10/2026 00:48, Junio C Hamano wrote in What's cooking [1]:
> The t5520 test script has been updated to disable reflog expiration.
> This prevents test flakiness caused by auto-maintenance running
> geometric repack which would otherwise immediately expire the test's
> reflogs due to them carrying hardcoded timestamps from 2005.

It's the reflog-expire task of auto maintenance that expires the
reflogs, not the geometric repack.

Thanks,
Thomas

[1] <xmqqv77l2g2e.fsf@gitster.g>
