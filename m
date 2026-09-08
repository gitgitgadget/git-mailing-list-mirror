Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A575964E4
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 22:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907706; cv=none; b=DxNWDg3OmO9IKk4S3OM1l/sKz7K2AHvn8hMJy6qKVET41jJD3rvmRJ3JjmsMeLlLwlvk4ttArvTztLE+v5l21xhBWI5TM0NgH19Wbrt2ZDzOiHkKh9aJ/mxUhIXLjctILFOWBVpkIDK/cPpz9lGWqzFfJAivB0QiZ2qVxZRoIZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907706; c=relaxed/simple;
	bh=IM+TgDjL56La1yILG9ODNvHuaKgHjXs2RMtQsT+xkJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9zX7bSNXI/VOvVmQ5CXmkWPjpJqOwrR/qgWK678I+04r9nhPQEMCHfpPKTsZ3DrRySc00gpNOr/Q+pEvGJcNpnXUVpjMySHLBiCxab4chOomKA4Ad5jCLuDkYN9glWsEVkkL0NlMTfBq1q+b3TSTKyxce/MxkmzE3GDYRqhHCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUxazhiW; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUxazhiW"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6b12ada8befso2970072eaf.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 15:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788907694; x=1789512494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+NIww2NAp8i1sPMF4YUl0qjXfGjrGAZqodt46gEJrxc=;
        b=CUxazhiW89yLyP9PHBEnJ8cAwJ/0+dLS2Vu/exTAgBJ9/1jCNDf4uaRKECYUJBwojF
         2bF9RTrYVHk6hupZw6mePP5VTO5vhZeh/kFwGEVEsMz/+v4xbPwXgtGYMhpXmi15y9L0
         B7ioyP3rIqm8mzU9o1UNC2wF9fqyPPDLN4BIshhg/MZ9MQvde3w4x1Z/OOLdVsNT6MQU
         PhqUCXsEuQ5odQDhuj6OkieEyErqZJn65X1OXjA75K9+mCsMx4GVPxqznowMdS71QA1j
         zT1Rusina2mJxuynHlki7Zcilqkv/nBYQ+HeXiHdTn/1Leg5+ooNZR2BnzIulrtpO8hi
         sUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788907694; x=1789512494;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+NIww2NAp8i1sPMF4YUl0qjXfGjrGAZqodt46gEJrxc=;
        b=B0kIWuUoy1eUCXw4nw40iri5FrG4OOwk6jpjJV7aKXFmGukFRO8FU9BsGJAfskIY+x
         HokSSZwvF1Gr9za5JvOurFS64olWWW4ykOsz3ePlsbBygnTYs3mx86lknNp8L2hmlIPL
         0CDy5RNarbqp242Z/Cj/vQa+f0FpImeCPL81G0qSSG0yDw7qGupRPIVh4J2Y3XkzcwEj
         3DvePAKZAaLvuOJq0/fElqglLKTVHaABqzpgE7y0QstVDm8Rnuzg7Xb4CHTse6kOTL/g
         /7iapV47abcq5coTPuDDZlP4imdMeKaqPLtbkEbnEkrrDCo2iK63BAbhhbJS6qKZKYlD
         akog==
X-Gm-Message-State: AFuF++lhaf+a6Dikz/AhZyu0eKBkqZEmhJwU6bozunmFn29P9jsXmGbI
	XIGh99kTIE6uvAIOjMW1PqH86v6HfN7jlLpkA0B212lN//jzXZjBSAqa
X-Gm-Gg: AYBFou0zE2/55COYg/QEpNY0jN21q4A+yUKFSHQJKzTF5IHlP8vR6fl4gPLdsK27PYq
	Q0fKF5HioCBvkqLkjPDw/u8sQVDScF3IGQfw5ap/eelowSjW3CEi2Q0jwnZUYht7tHFrBhgUuhW
	IGEpqYObzH0Dp3GIadmpW2oJOrsETD7tNzhIxFWmmoYKkofIvdzw7gpnxtA4krIyf5VhTR/rquF
	S6G80lOCnrkFGz/XCxo5G2n0MQjBWy78g1lPpOMWVkLPzUYcuVHR/hMIAbxVmwXXQ/9Ol7vgKUT
	Nk9TXNOAAKHOjb30hxfpsmU6XmY4pSawgaVdq4BpfXai5oDnGCakdpS4St00A4Sq53Uv8ELLCDA
	nE31PBq1P1J5ZztXxZhJj6GuXNdv7/02zA6wtSKU8QQv9LvoNNBCoMQE+IcPbhV0hU14ZTNJ7fX
	dGnDxXwYHN7eePKpDIjM6TX+/FsViu9rcant6Op0SlvANME8vbkdvHSvLyrYitnW0eazhigex2H
	3Zx/kz2irzK3KZT1ZEeTjUG
X-Received: by 2002:a05:6820:c8b:b0:6b1:a812:987b with SMTP id 006d021491bc7-6b6fc7d6fe9mr29902061eaf.14.1788907694182;
        Tue, 08 Sep 2026 15:48:14 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-475544fc87asm12564184fac.10.2026.09.08.15.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 15:48:13 -0700 (PDT)
Date: Tue, 8 Sep 2026 17:48:12 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/9] builtin/clone: move setup of alternates for
 shared local clones
Message-ID: <aqCQYbHm_0TVagTi@denethor>
References: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
 <20260907-pks-odb-write-alternates-at-creation-time-v3-5-735d0b5b3e00@pks.im>
 <aqCOe7cf_uSIz_Eu@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqCOe7cf_uSIz_Eu@denethor>

On 26/09/08 05:43PM, Justin Tobler wrote:
> On 26/09/07 10:25AM, Patrick Steinhardt wrote:
> > +	if (is_local) {
> 
> Could this condtional instead be:
> 
>   if (is_local && option_shared)

Ahh nevermind, in the next patch we handle `!option_shared`.

-Justin
