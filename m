Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE13377560
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785586393; cv=pass; b=kk7K5026lHxHNK91ZwvwK+I5Q+PBnFPJ1dh857bBPvIkDd/7FaU308hBojMVtjTVt5uYJGfNAX0SFHgQrX4fosADJRhEfc2tg3wkAa5zGElQicC23OJwoqufLVezayhsQWiv73ZPjXq9eQUkkShzjE2C/WKOv1CXyMQZKZKXOCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785586393; c=relaxed/simple;
	bh=l4REyxNFvufAeobQuGWUsptiSus4Snt6CDSFOv//7sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Plf6HURaU63p54EDhEzVBh0qTOhTFkttJ+BgswZ4FDtjSCM3b91/+9iq7XrlWBrWayP0YX/DShjqyMUNJME7C31lVj3hvnlbBpgf2B2RUSw+Gw6tOxucCIM32sPE1DR0JCDAKpgA6BkKnTrBjXpnmVqWrAtkBCf9yJ+gB1dw3SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EwjqEliF; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwjqEliF"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so3221002a12.1
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 05:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785586390; cv=none;
        d=google.com; s=arc-20260327;
        b=NWbjpY91tUg/RAsKTA91do20k/5pCzDH1Q/I/NnVQmEzX4g/e6ROhVdLzBVv5yq0Bk
         ZyQYiT2oUbIyQYWR6/CndHnN1ssez6zbBfQPutYZPjCeHH/1276t2L01R2Ed4vUjEiKn
         CvmPpUyyjn/o0xCi/OGhKphd5nGi6hAGOKu9iqOlWkLV/19DS1c4YEHQ1Xv0E+P4Vi7U
         F+HTtraaOwWp3Qb+GXtkRlIwmkpmmzKfMupXpPP5j1Nfv81IQ5G2TBXDvbj4FXbjN8Zz
         SuXz/fdHudpBl993P1moein0NBhaf5FAIbvD8Zt8qKjSzbPF2LKr3xNZ/jtHi8W3ZaV7
         mqSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oMVQJnDx0OJjNyD9XwdP2X7KT0Dky4dGrCo0B8Pv+ag=;
        fh=2aAxuZ3FwNf3QcFlH2RvBEmGPgSA32B5xuUzbfpQbOg=;
        b=r/6okQmzSP3m+pVYT9CClG7s8AYo7vbX+G23CYTksz9JENiXtF3Ymt8lkbBjvgfMDm
         lwKc4FHwq6GxFWPr5NxzVRvLJuQSHfXr5nWaK4+F5yr9Q122/tlJ52Y+u/rnEr17/hx2
         XUrixcHUwQSa2dmbQ6fwuboWauWPQ6BN/riMVR7oXZXx+bYrW6HvdOVJEQT4drJ1QodA
         9FQY5znn8+7iy3U2Xjfz9Je8ePnBNZqNMuWF0U5GWafz3hD21FF+l9epyRM4fgSGB/4k
         pMjXFSpz9wlMIp8nQLtkU21Fu+OBlOdPYt5G19tzro1mjkcW/vNtCovjwUYDU40nZIhI
         KH8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785586390; x=1786191190; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oMVQJnDx0OJjNyD9XwdP2X7KT0Dky4dGrCo0B8Pv+ag=;
        b=EwjqEliFlXEiTDTBFjAoR2rjd6KQ28//d8mja74ZDOgEAv1z3OikyGg7/nYgHTDKYv
         QMAt8mNN7u2pWhrC/YuUsNRTNOf0liAn57Fgq+mdSLy5xccOl2XmsyM+JWRZdsFLLRRt
         4ximZnDUHuqQ38HGcdnANjV1No6l4LLHMD79FXBbp3yMU79PVGZ0ezeufxLJ7ZYJCUYI
         3+FMGUXhKC6BchRvm/SdzeTvvkvnF2OqcJLipgyKNbK0h6UtKxarP78RWlxvq0dhdTSS
         mZz1Ei97CAiseMMj4jE8o3dhpHfE6e3FNXAWMqbWN11Y6O1+UnPXSjJ7hzYcc6BTYP6K
         Z3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785586390; x=1786191190;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oMVQJnDx0OJjNyD9XwdP2X7KT0Dky4dGrCo0B8Pv+ag=;
        b=N8yNk6wKVXN87/PsPyAyuHBmMOiVBtG6N4fiGTPnGnzfPtJqujLXBZZevZKym0iigo
         jWBjJUSu3fF+lkdvUaSLPjoSlJOvo+m5zG2TUfCPBSSmZb+bA2RhNGdKulCW9t1c0Q9Y
         6okStyV1J1s3VryiJqK7DXh8P7kKOLkTtdVdLor3LL5X7oxIgJuXDlNriZEr+fRpQNfh
         S7SFgkDZ+x8Jk7i/ZFoWTEEi3/Wi0PSQ2Mnp5hZ/epVZWhNgTFnlXha4FWGhr4gsLdTY
         OLhpC+axsPmT5ehXkgfGr2PyyPSsZrJkF2UEP8TbRzuroygM7xcIP9OFx65RZrrWNi5P
         1mQg==
X-Gm-Message-State: AOJu0YwnNOnuhLKInqqGyWBfftOG4gUD+iZBWR3q1jcrLQURFeuUDAfO
	kLqFE1FDs5U7JVXP83PPsX/eSscWdqUiWrDrMwp0pHVa8YZA3hsd51VW47yeoNbbVOzSPtgsdzo
	d0BxuI6ilbpLBg0uaU4ll4TwPkXgLRFo=
X-Gm-Gg: AR+sD12v57qQZMLf9Y3l2f7RRoqv20360jbbVwQyWpQS4Dt96VE2IwlsppEH1JNC4C+
	IfyDpLGq3+iQ+RF+QMz2KBVfWYnn7/zmrU/Cunf1DV5VRW86rPpqUVgQvKsz07BxxA1pfZ7HInX
	tdMh/9yiyxFo3kalnLodUG7ACMYWyT0OT0ixuC/ENxYCpef94xgs5mHjrXme32oS7yQobd3XBgB
	WfuZoYCup+ubPFxrDrxJMwIpFoh9XKOjToO8/s2gDub5oyLxZMH4Pi4q7v+bGBXEHqw1UCyKHDG
	kLBv2LsOFDUp7wz3C4DNgEUfZLB0+nngpLfxDh706OEe/Q5v2r6l/gFUf9T2TaQqUpLUVEHWTvX
	/l4Rsk7ygD8kLRZIxjPi6F+FhlWcAKpDYTOhx/fQM8xV6NM5eJ6Nu27dHPFo=
X-Received: by 2002:a05:6402:2794:b0:6a0:6249:746e with SMTP id
 4fb4d7f45d1cf-6a0a7ccbfeemr2094425a12.15.1785586390115; Sat, 01 Aug 2026
 05:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-objecttype-support-v2-0-af577461ed57@gmail.com> <20260731-objecttype-support-v2-5-af577461ed57@gmail.com>
In-Reply-To: <20260731-objecttype-support-v2-5-af577461ed57@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sat, 1 Aug 2026 17:42:44 +0530
X-Gm-Features: AUfX_mxIpGHCdQbHJR7n6bRHPHGWxoWK4fHE2T8A2OB_g_q1Q2FmH6gNiS5aZeg
Message-ID: <CA+J6zkQQsuB3LA=Zg_oEaX7Z-AMhyJf2=ZJYZER=XMPiqaea-w@mail.gmail.com>
Subject: Re: [PATCH GSoC v2 5/6] serve: advertise type capability
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

[snip]
> -# This tests depends on %(objecttype) not being supported yet, once supported
> -# it needs to be updated.
> -test_expect_success 'unsupported placeholder on remote returns empty string' '
> +test_expect_success 'objecttype is supported by remote-object-info' '
>         (
>                 set_transport_variables "$daemon_parent" &&
>                 cd "$daemon_parent/daemon_client_empty" &&
>
> -               echo "" >expect &&
> +               echo $hello_type >expect &&

Shouldn't this be echo "$hello_type" instead?

>                 git cat-file --batch-command="%(objecttype)" >actual <<-EOF &&
>                 remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
>                 EOF
> @@ -271,6 +273,22 @@ test_expect_success 'unsupported placeholder on remote returns empty string' '
>         )
>  '
>
> +test_expect_success 'unsupported placeholders on remote return empty string' '
> +       (
> +               set_transport_variables "$daemon_parent" &&
> +               cd "$daemon_parent/daemon_client_empty" &&
> +
> +               fmt="%(objectmode) %(objectsize:disk) %(rest) %(deltabase)" &&
> +
> +               # The hardcoded SPs between the atoms are respected.
> +               echo "   " >expect &&
> +               git cat-file --batch-command="$fmt" >actual <<-EOF &&
> +               remote-object-info "$GIT_DAEMON_URL/parent" $hello_oid
> +               EOF
> +               test_cmp expect actual
> +       )
> +'
> +
>  test_expect_success 'requesting only objectname echoes back' '
>         (
>                 set_transport_variables "$daemon_parent" &&
>
> --
> 2.54.0
>
