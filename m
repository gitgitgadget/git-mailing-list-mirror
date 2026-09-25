Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45353381E92
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367985; cv=none; b=hx2xBuxEHJXg8H1iwslt7sKo+4AbzD45VVXRNuiS60kdHZfS725m5GM394aZWcBnmkttkgHsPU76QquGh0U202bBBza2QVnJzvi4Ag27UOs+l+styvXIpmiCrvr5ejbwFnw3N9H+GW3/Yxw1bfgqSXtmjZsuXrEJpEUWUKYPbp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367985; c=relaxed/simple;
	bh=sTX+QV8jRGSGcCTK5HVQhntCC0eLZtpU0688VveyO2k=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=bjPCly9n2sd/Z85HyAK25JPLFCIu7hY5yS8NyilmHQOvoJjGo1vj1XdEVU0p0vnTE7aJU3W8wGTK+E+qFvUwZNlfEJB5UxTjfRlC6kmTZp9BXnfcaSNDklPGQZGEufGJglz1K7XT6rZ0hgAwPBFwM6S0gkM8YBK4rvjVuk24JLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMxpU+rl; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMxpU+rl"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895eaf31683so14456967b3.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 13:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790367983; x=1790972783; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yx7J/KTVkLO6BnbDh+NqszbsSkYWQekGwz11+1/ZNQU=;
        b=RMxpU+rleB2+Fczto7FeBDyf9clx1kr6w1qrK76wbAPOLUAJ3YcnmFSyFg50jyHsJm
         2+k/WCEyBA/Sa8yivZ3Xw7X4CB5iUKOUXv/aEII4zHlQjPpyGmPS1gjDuR0keVrW8Djd
         Ur1fyxa9GfHwMrVZKK9V56QkBFYWY5Nfjct+ClDVoI9fXJOBoXObhSJ0DcM8XkT6ihkk
         4OdEgMg/jLW0LYqbBDFSbM4yZGXUGGRGwfC8FBK/u/WQGYOyRV4LGMVMSqfccFlF4kiL
         nnmeX6Z6b3aVQ2M+PIzz3cER/xWOrbWKfyVtALtbGOyGH0Razj/edAuDl4FJxsKRjMXf
         Qzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790367983; x=1790972783;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yx7J/KTVkLO6BnbDh+NqszbsSkYWQekGwz11+1/ZNQU=;
        b=KiQmwSRMLLXvfFcDgJT46Km3tFPX/s2fyhux5LSGbOaM0eyreJF+4lcUSp9bbuHXFi
         k4Rm2qbgixCe2G/3W0mFVIM7czX9z+RXuUaFmIvXtyWCmi4s9qwXzHQw76T7vQ5m4ybK
         mgttwwcR4vrDYn7+KQ7j5PRuALNWI29PaXsqbI/LtnJdegGr5hDXeZ/C56NQMWZHx3b+
         BF1Qy7l2ul1kqX0Ogp8zOAAO4KBrMLT83h1t/HoXotbaczsGm8fmsHVZP1K8KXHirM90
         EUjg8sTkLOzMctHCPx5icsMBkvaD1rRR8HRvMosfcO3F05vAU69YhlAJxwIY4mDfDT/X
         LrHg==
X-Gm-Message-State: AFuF++nLNK4uj7NLECFsoewfrgDNsX/PZB2nrKEP795thzMiW66cSPba
	x/7ALteRqIextWfD50xBUDuPG0abWmzwWYkZmdmwqI5YgB6/Zhgr1WtS
X-Gm-Gg: AYBFou1wseMEUXMqZb6GGRXY52z5dHoRvogY19gIfv5eJCVRyDv+rhzvloPUJ9J2Mvc
	OpYUeYA96WBd6e7bt+EmamI2tkmHK++ZmiAVuYckGf024pj1xrBGQr8p3GyVhQETzL1LkBduzlD
	9QhfKgWXBhkLWKZoP4AYQO593EyM3+XmP5mhtgyuUVLoqoOtSrnqKgYZISKwPeDGHvtm7ojgZHi
	8mOgrHljT/NbRxO3shVxk/HmZ0/XJfBKqq3OC99oineTIdHzq1//P2M+nzXIk5JLwDidQhucf8M
	5xcRLUxmcLfqy8QP+SSt3qcGLKUJAEvRPZbhSMah73DzP2uI7kZZLcgrdJs6NBEOWkUHTrOTeF5
	UvjTv3hZMhiNeewFBJ4be6kDFgHbigcoL6OHeo8XLpeP1GcyJH5Fl5OmZxV6xP2o+yusoNNoNfK
	qjHru3U3gSUxdvfzkIQ4AM0aVOamBIGw1XRgAt/V7JXNq0ueirxR/6zKKeAw2A5bvL0U2Boo6B7
	ULfycSSb092Vruote1GsV3tFxvC9Bt6c3pV9iL6ShnfLC0ke7u54TJ3puwJm7Rxm9EfJcPnh2No
	TciaKlVoROeAevhIGh3A8BoOzj9ukSOsM7pXr4Jwr8Vy51x3
X-Received: by 2002:a05:690c:a753:b0:8a1:84eb:f9b7 with SMTP id 00721157ae682-8a86ca4d1f2mr9259097b3.3.1790367983008;
        Fri, 25 Sep 2026 13:26:23 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:f9a9:65f6:303f:ab61])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860e5b296sm13436687b3.8.2026.09.25.13.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:26:22 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] ci: point leak-sanitizer failures at the actual test and error
Date: Fri, 25 Sep 2026 16:26:11 -0400
Message-Id: <09549A0E-D5FF-465C-A933-F144A19D14E4@gmail.com>
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
In-Reply-To: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 25 sept. 2026 =C3=A0 14:59, Harald Nordgren via GitGitGadget <gitgitgad=
get@gmail.com> a =C3=A9crit :
>=20
> +finalize_test_leak_output () {
> +    test_leak_summary=3D$(head -n 40 "$TEST_RESULTS_SAN_FILE".* |
> +        github_escape_message_)
> +    github_annotation_ error "t/$github_markup_script_name" 1 \
> +        "memory leak logged around $this_test.$test_count%0A%0A$test_leak=
_summary"
> +}
> +
> # No need to override finalize_test_output
> +
> +github_escape_message_ () {
> +    sed -e ':a' -e 'N' -e '$!ba' -e 's/%/%25/g' -e 's/\r/%0D/g' -e 's/\n/=
%0A/g'
> +}
> +
> +find_test_case_line_ () {
> +    grep -n -F -- "$1" "$TEST_DIRECTORY/$github_markup_script_name" |
> +    head -n 1 | cut -d: -f1
> +}
> +
> +github_annotation_ () {
> +    echo >>$github_markup_output "::$1 file=3D$2,line=3D$3::$4"
> +}

Without commenting on the rest, introducing the helpers first might make the=
 important patch easier to read. =20=
