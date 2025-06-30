Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DAEAF6
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 02:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251330; cv=none; b=PNYva2ucKlZANobp19TYLXf5Wwt1QMRG08wcNQ8aXAdBAhRHemGEOWm89Iu0Mb7PW8IZqoSG0jMh5OOSPSUS49Qph7k+8glfctX/BThi4op5uA+ljRN4t1+1/yYswzvQ4iNWOyjxtvKoEXT+jRN3fOOYEi4gPUg5AvEmMRdXO5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251330; c=relaxed/simple;
	bh=fmLGsK2T5oIcj19JX9ySBgfuA3aDIJ2R2EwIo2bhfdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnJ1vjZfmtsCddosJk7sXhIXKlfEWXMSD2uzGFak4D8rHEfTIfEdOMZfsEoMeum8N46GGRQ56pEAi2FHA7/+jp7LedhIoZEie9tEDyxsyFoCmsAZYkrJgcdyGfPTy3ePTQk1cbKnjAFWt59iIXIwntWfXEzJcll4M20d0YlShws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdR6a7P9; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdR6a7P9"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-40b71debe9aso223b6e.2
        for <git@vger.kernel.org>; Sun, 29 Jun 2025 19:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751251328; x=1751856128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R2wSge4CVUfdNN9J1Yh7jfiUBfCwdUZ0ijN0+mgGicE=;
        b=KdR6a7P91XGIc4QSo/i4E8xrMhlfXhyqdxdkJMoaPlFCqwdSBBuyUBlngLvMhQ64c0
         x9PAapF42i1TjAXrZO2RJRnpxHBXNMOlKqvwDH/93GTSGQnkQ+lmChE4s82xSIDPfQpp
         sJOOxwB9vaN98PV53TQH07IcWNn9lsU8ueI15iSBC31zACiwU9vTDFK+/QcBvCVHFgc6
         cpAzdmGV0yzWhGshycHrxVVnMi91FIthxt43JLN+JniSuFGUYNOgQ2TQ0q/9R+yRN4Z4
         FPJOLMRmDL3Dm/lKpz3e2yq4WrqZHMR5vd3jocu50bqXBikd63xgKrY5PMYHwVHvMzkv
         uHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751251328; x=1751856128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2wSge4CVUfdNN9J1Yh7jfiUBfCwdUZ0ijN0+mgGicE=;
        b=jrxJ8sLBhCBmgFHTfZPSZXOMDJq8H8W3UTr/3ii36nByj3MiiSfBOqv5XcXm/U5rJQ
         3JP3rLPPZYzohUp3PizCzQ3xNGLBQOjWiMLWyoprWJNsp54eyrARO0DsedizJYUGDubw
         310W0CU1bL7Wb8pdxmHcn8gHmZuzPnojfeB8KwDDwRZsKAA5aUzKOw1hHjImYveXLQah
         cdfdkIajqVXDqQGATmFzeS9MYLeExPbRtUheb4/qkkpQdHYP5G7hGTGDSkJl6CZSek/Y
         2yp80Pwgc45CdR5fVCdIpS+LzyV1bF+scUsMzy3qe2nFg4EZH73ip8jifLbQUGPnEDEK
         v4wQ==
X-Gm-Message-State: AOJu0Yyp3Mbp4O4xGHsbxjw+TUriApXKE6zyyXQZrLSelHxlsrrD/vMe
	KtVh5/b872U3ZqhCqDup/2q4PSyd/zK5jYlQbqSuNNPLhyrD1CyrimdDQKoE8g==
X-Gm-Gg: ASbGncuyIbbcqvvALWlp34YZP/JYTy3Q2ytfqtJr+5aYWUKRRXAPaeFPvY6mnt1dfhm
	liy05rfhCRP/fzXukh7h9Qr1HIOL63Xw2z8nqcGBpfY52OvVNILJxbA/edzqk+tof9eaY4Snt9q
	2WYosY3rpLgj5+cflJCudxBPc3ZW/15uZpsscsbKY+ymcMKvP1vwAsQvVCkqXApTydR4I/orx1V
	ACKywXAhPno1SUbNP6R+KSatJDyQS1Ix9r87eOjQH7HyhXPoVoqvlA+WY3H9t2TUaALSPkJ6u1t
	eAv2zGrMbH8mBJiFyIwUaONQRKqVuUHPDkOS76FlbRVYovFRDm0dSvLMlt2suqBhIA==
X-Google-Smtp-Source: AGHT+IE/DG9prlkB01yEumb8Bw4MDNObBckJ9PHydyzVpnV2Ivs5xZL4L2DidvkHXJY38B+2NawFhQ==
X-Received: by 2002:a05:6808:4f54:b0:404:764:f7b6 with SMTP id 5614622812f47-40b33c469c7mr10600042b6e.9.1751251327658;
        Sun, 29 Jun 2025 19:42:07 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-40b322ae397sm1510435b6e.11.2025.06.29.19.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 19:42:06 -0700 (PDT)
Date: Sun, 29 Jun 2025 21:36:41 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v5 05/17] odb: get rid of `the_repository` in `find_odb()`
Message-ID: <ymga4fqaki4sszepcgbrvco4qinurmc4ebadik5cog4a2qnke3@ihjhtngygpr6>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
 <20250605-pks-object-store-wo-the-repository-v5-5-779d1c28774b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605-pks-object-store-wo-the-repository-v5-5-779d1c28774b@pks.im>

On 25/06/05 08:46AM, Patrick Steinhardt wrote:
> Get rid of our dependency on `the_repository` in `find_odb()` by passing
> in the object database in which we want to search for the source and
> adjusting all callers.
> 
> Rename the function to `odb_find_source()`.

Ok, this addresses a previous comment about renaming "find_odb()".

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
