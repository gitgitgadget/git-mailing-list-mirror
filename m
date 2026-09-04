Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F934CC288
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537339; cv=pass; b=g7pxlClkj8Qlnd6GBOuw80leB9Os81NGGp7eyrE+ozcNWXwTcnXLPXyuV7xYdsZFAb4IdoDi41pmwol0LxYuO+k3hHbYfifjaXiXoeFESus61c2i/N020GG5keA5reWL0Jf1jFW7O0jCuxH+1CeCxfp/01hrzF5t0kjbC+nOC34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537339; c=relaxed/simple;
	bh=Xyw8fLD7tOwB3JZOh2LrGc6jZlRwlPORRq+YQs8F45s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFgmfs/CYOztVeDkkP5/YDsedlDoBdeEzKbMZxIZYExVb2A12BZ6FJJdWIX/Pg6R4WI5kna/qUxHVD7rcekHc5k6UqyrUpDWkvrJ0zufV/mz3c00kgKlSXDS1irxzAOE98w6TYXMAgXydTN1UtCJQTcXAWwa4wtW+rZVvglSpdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=gQpfy/Nu; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="gQpfy/Nu"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66fc2844f0eso409451d50.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 08:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788537335; cv=none;
        d=google.com; s=arc-20260327;
        b=X5tKWJ79HxV4huyb1l0LBJM11XFlypvP6ZA/dxxUaPnQL6hShsk/6hkGmCxW71sNk3
         vfg8gIeZBKxhIrksW2nxBgXmONif9Xnf9giBAL7MK4MCXEoN0IUsf04C9kz35+s7acSr
         ylbWI0TCVbkJiegKOVnCuGmY2ssKGY8xK/gR/8ONN5y3aU/AL2T836bHD7X2TVxOVgle
         FYBBJXroJBMHIZnjhMU9eHt1Ggu2L8v1UIcFyzoZHsi7MuQxCoINBTwoqEzA6PYwepxo
         uozspG1tp5Cf4NjPvTlesdxuFGel03TZ38By7urP2uuiZQTXVCaVnZijbqONRSCGCoCX
         9LgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Xyw8fLD7tOwB3JZOh2LrGc6jZlRwlPORRq+YQs8F45s=;
        fh=1BKdGA8xhg54ZkuVKxu0Tj7CeYn2gka/2Sd/xtJAurs=;
        b=KfKxjEhs8Woi/ecKTHEV1Guy4nmTtIokLDQGjEiJf2KwFe2qW5HGWKz5ppygjq1zN9
         lVHLa04AiVhQSp/h+8xxDPgpkqynmmpi4OTs7TyE9ouEjJc8Y3JwlTMxznd7VWKMPZZ4
         u9dJqwGuzE2RsIbl9TE7lNu8umyYsKHTdrJse8IOLJbkf9hWzSTDab/3Wmb+S0XM9Ja1
         OdgrKVkYa7aBgANsGSwu+bAtF1u83KdrbXRfo11xStDm4fCJ9maQkQLcEg3OfAXDkuhZ
         NlM11GwOHxEd7yDek26UCBU6wErxqFvn4J2SGD8YOb71sihPUU/aXTXTOc8ejYwhWvqC
         rnGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1788537335; x=1789142135; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xyw8fLD7tOwB3JZOh2LrGc6jZlRwlPORRq+YQs8F45s=;
        b=gQpfy/Nuc0M0m+oTsRRbAMNIrd2IHAMw+pnoBl29XaJSEiHIph7stB4urZ5ct4GfUG
         xaaiYrwH7+hBBtVS1Q4E5EDUWlIPgJS4LFdiaN9DWAsltpgklZF3FabsJE/JR21lwmFJ
         afklSg5/ufcfrHknpt7odw1jobEmya4YisJHU5J00PSuWBGxgWgYCQCVCgCdAaz0ghW1
         DGez+PnPNyrPastwMheZfH6Rh6IzqCtRPoudxxE3RidPofJWX6doiWDxGi16eJML57ig
         rD5iiDmvD2bhnmEIth9AF8gFg43jZ19Yp5cjXp3tVom8/conYgXKCZie7O8Mr7W5Vmsh
         ds8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788537335; x=1789142135;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xyw8fLD7tOwB3JZOh2LrGc6jZlRwlPORRq+YQs8F45s=;
        b=MaUh73WjtTfadFM8yv9iOQfoa0CtChzZce2TgSljUrO+D9EM2ChVgggvjNmRqvLeY8
         zZt4Q/k238MQUotZLQ20ituPoFvkPDLB22mTNzAGf5tSYA++t77ibhSEGbAeGibnbGMc
         oTBylOjdIAEn4XK2F9PS/sud9BBBCon3f8FMYEKntdhfvu9X2+dq7hKnJeFWiXCiWBwz
         V28o0tdFCcMs7GmRu2Lq/AoByeSjoN2kVZC8evikGCq1GO7m0rEwmw285ejJgXed2oT/
         GU1YWKGBocmzqeGRu3iFgWxRV7WOgl8cclvSmpiRj8bLMCt7KaJ9pDsx+ouO6klvNBho
         CZcQ==
X-Forwarded-Encrypted: i=1; AKwUvByJmLgJayyo3aHeP1dB/H504oPcI9yAgy+RFe9pAad/+RPte1r1GqAM1kCfCJ8n2eTrjcU=@vger.kernel.org
X-Gm-Message-State: AFuF++md+z0GnA2DXgxT1YXNRr+bACsOmf21qu8dSlyIMiWDdM7pTIIi
	hUXm5/AFfj+XnKF0Ke9Cr6K7+rtye1od9bh2kiz9UKB4fYqBhiCsjVIO1vaiey9MefxmkSXkTlA
	4tHgobXp4k0cUvCqa4JnpiCLDXZjb084WXSoKIz6vRQ==
X-Gm-Gg: AYBFou1it9Lg1smqRfchL2n251r4Mdw/hrVgZdlwUjaYN/zP/8Sm2ZhgnHAGPmGkZUF
	BRTIx14BLawsE99ywX1+A8t193Ijm/I3z5qCawoNhjNLrx6faWJM3SJ04GNL/Iq5fRPijbiuXpC
	xmaL0JlDo2+WkQ9qVOu42SMQSiudvPi11lXfBTpxMOCbblPvcLzjkx3jOb1q3N+aLiWP53CO5fw
	ywoe6Qb/nXyraWA2ZX7eELwK580GnUgNN6eKW2hDXxX7dzEcj5MGNOOjhLVNwJYfqB4vB4oS8kU
	IHZ6dX3KSLLjzCRl+vn6sbTaihczCmi2zIntoQeXF0h+Sdtk3goD3B/H3fZWjKOf4wdMjeH946q
	Auzg=
X-Received: by 2002:a05:690c:319:b0:841:8f97:e898 with SMTP id
 00721157ae682-871288e0f77mr49624547b3.32.1788537330825; Fri, 04 Sep 2026
 08:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <06d2f0f484e2e22178c6a956ec153e3d84ee073c.1788508426.git.gitgitgadget@gmail.com>
 <f44765f2-d04f-4adc-b5f0-56a22658626b@gmail.com>
In-Reply-To: <f44765f2-d04f-4adc-b5f0-56a22658626b@gmail.com>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Fri, 4 Sep 2026 17:55:20 +0200
X-Gm-Features: AcwNN1VJv853Oa7BnLVtKJzS90qQSWere5AOZLdfOPVeGSZKD50QFZiqMku-pJY
Message-ID: <CAA0xjto-UKzHT2he5U25_G1B__z59jHdgit7A6Za7U=htra3ag@mail.gmail.com>
Subject: Re: [PATCH 2/2] sequencer: keep auto maintenance out of the commands
 a rebase spawns
To: phillip.wood@dunelm.org.uk
Cc: gitgitgadget@gmail.com, git@vger.kernel.org, ps@pks.im, gitster@pobox.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"

Hi Phillip,

On 04/09/2026 16:03, Phillip Wood wrote:
> That's what we'll find out when this is merged.

Agreed, and the message now says so instead of claiming it.

> I'm inclined to think that the reasoning for running maintenance at the
> end of a rebase applies to cherry-pick and probably revert as well.

Agreed. In v2 all three end with one run where the sequencer finishes,
and none of the commands they spawn run it, the "git commit" of a
"cherry-pick --continue" included.

> I wonder if we could factor out a helper append the parameters to an
> strbuf passed by the caller so we don't need to know about the quoting
> scheme here. Also it would be nice to cache this in replay_ctx so we
> don't have to construct the string each time we want to disable auto
> maintenance.

Done, as a small config.c patch in front of the two, and a strbuf in
replay_ctx built on first use.

The messages are rewritten from scratch and much shorter, the sentence
you could not parse included.

Thanks,
Thomas
