Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77889184
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 00:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713832593; cv=none; b=oOMsnEItTDGaLYxg2tpHaV6kEKuEhPWoy6+K8kwM1AaM1syIiaGMDiZB9bMQNHIz+X9MRyQG1Vum0dq/xmctHthsA+hw+toaHtrCCz9pbzKeoy9eJ/a91F+avcPwPMLXNROL4TYnTEZFUsv/G4TmNbNCOgWpAU3P7h3mSltv/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713832593; c=relaxed/simple;
	bh=vYmvjl2yJcj3GQctvM9mEc2lkrRm+K9BVjlfCUGZNuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNQY3xZtc2gXE7oFprSVIYyFEPosSE61cbcy72W6bj4KocOm9SqnL4T5Z9Z4V8+YUqSWP53EAT707EBGYgryUfBAoZiz1J7PYbJZicko8CII2pc4T8kEgRaosIvl1/GdfX3JOgj9kXc9LQbYBPLm+B9VTpGewkWZfwTtLTqcXSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgglQLoM; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgglQLoM"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ea2f95ec67so2372634a34.2
        for <git@vger.kernel.org>; Mon, 22 Apr 2024 17:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713832591; x=1714437391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XlzrYXqnf3O7z4c7VxpcuJ01SDmZgvmVHQ7hiBMzCIA=;
        b=XgglQLoMDvUVJlAaKOKlMR2BaahEess5p4dQ62i7pjNxzb1/0LdFGaR4JOKUWKup4t
         XgP8wrxxSM9vzeONyERYkVqJymxcLVcX3V9fOl7OfNWT59wGdg7mjD6vs3gI57pn8kQl
         qvVJ0ld+tyO+vsoa9lfwSmgI06l2QLrcX/tmaWz8RsJfnFR6/qVbsJr20zOJ+V62XwFu
         iboQ9eyj4GsF1eb1MjYrenXuEEMZxJREhXNoAQUY9AGRBTBoLvXK8iXelDkaX6H0DZ7o
         xpidBsq6u0+emi8ALAyfZX00Gdn0FJfGQgYyvGTAB9+5TTRtNGc3X6nqX+qMtroovCs9
         bGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713832591; x=1714437391;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlzrYXqnf3O7z4c7VxpcuJ01SDmZgvmVHQ7hiBMzCIA=;
        b=vYBTHK1vxAnlHfFHoIxo+EpYLXAw5J7sY4eC0OijZEVRz8o0OAv0M3LiCc0iwMrOdF
         cfZYxCtqcv/kozXabbnqD8K2olhvIGopzjDQ1dupWwa2r+Yp+XWpwlgU4J5AC7Ek+iw+
         OvjU3nmEiw1/jOVE11HglbA0aC1hYduMGyS3g/+/keLk5dJcLpzYPb82H2qMM7KXcvQf
         XU+q3BzZAFGWFkbBm46Lnpnq6o87bs2RUv+N7fZ4w+acyDm4CMT6UbzafwLJUIx4lUlM
         lF4b49fAJKXfXTmQz4bYNs8sGXdE3zAOD9fOFbM9IU6z0HnclqszllAtyX1Iudv/NsDh
         haQA==
X-Gm-Message-State: AOJu0YzXjGl1ER6CQoCt6BMMB3wNdgCuGpaz7fxtJ/olS1QgUihb6mnY
	AyBt2v1JUCIQZ+GYn8vl4Z5yyznQFPCiKYYDvoO3GgGJkdtlZxor
X-Google-Smtp-Source: AGHT+IHCf30sKl00speCvToqIjsy8mM54hdABAitc3hB9tl/mIBdzXV9I6x2U6iuTDv+c3zYTM8SEw==
X-Received: by 2002:a05:6870:1641:b0:232:f991:8fc4 with SMTP id c1-20020a056870164100b00232f9918fc4mr17538779oae.46.1713832591576;
        Mon, 22 Apr 2024 17:36:31 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id lu11-20020a056871430b00b00239541760e2sm1594703oab.41.2024.04.22.17.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 17:36:31 -0700 (PDT)
Date: Mon, 22 Apr 2024 19:35:21 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/11] builtin/shortlog: don't set up revisions without
 repo
Message-ID: <sy5j67uqsqepg3blhsioiustxvb6j6cx2ghlcsfrn6wjrwduzs@6qfhdbavsz35>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1713519789.git.ps@pks.im>
 <508e28ed1e21e9c646cec8473a65137d33f1df23.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <508e28ed1e21e9c646cec8473a65137d33f1df23.1713519789.git.ps@pks.im>

On 24/04/19 11:51AM, Patrick Steinhardt wrote:
> It is possible to run git-shortlog(1) outside of a repository by passing
> it output from git-log(1) via standard input. Obviously, as there is no
> repository in that context, it is thus unsupported to pass any revisions
> as arguments.
> 
> Reghardless of that we still end up calling `setup_revisions()`. While

s/Reghardless/Regardless/

> that works alright, it is somewhat strange. Furthermore, this is about
> to cause problems when we unset the default object hash.
> 
> Refactor the code to only call `setup_revisions()` when we have a
> repository. This is safe to do as we already verify that there are no
> arguments when running outside of a repository anyway.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
...
