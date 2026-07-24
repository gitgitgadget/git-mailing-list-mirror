Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130D42377D
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896545; cv=pass; b=UeK/DzybutK0oeVBFjcCt4bOrPOUANxG/rgZOqQVSQaFznrREEWxohqz1McJfiZo6nHYGDsvl+d/fLeqDx0u+FlCvj+sW5EK1nYcYFqED7z0N64ewoQdF3xmrLZ58TXNC0+jOm9O2svAvobgJBrdV53Ftx6PXSvRxjAnvl7GMJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896545; c=relaxed/simple;
	bh=7iOS8P7fF+mbwKVjwtt91QNC6pDUyDe00l2tlX6G4Ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWo61EwijqToXlXDno2v6fC5vnU2jDDLLSNgiR0B84OfF4amjPJb6iIC648Ipay4ElPsexVF/ksI4weUD/pYaRbh/pCUITbXbxwpURdZwS8ga4/gp1gpRTbMeyWEprupuWKYAELr3hJpeBwaT3me/v29XnX/d26ReDhUzXU+kw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hk8a1c6u; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hk8a1c6u"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba320so584894a12.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 05:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784896542; cv=none;
        d=google.com; s=arc-20260327;
        b=NKXPLt0hBXrgWB444gJk3gngJVZ3Bx+a7doYLD+Vdb1He/aXfNfqtxBwGL5/7/MT6+
         Y7mhOilq8yhylMx4iZTn1dM1l2xbgFYW++8APzutum9HqKQW52YoVNZz7iRRc6h69aYn
         LZQpE2qOM1N9wU5kb5QcjuymazCfpPmv+g4dbz+zbuoCGUojyT329Jlvp0FBDHLe4qYZ
         v0NZN7kBPkpSV1RsozSeS7LR0vG2/+Weoyvn8dEaHifJByX/sJtqf7YOt6bLTf0w4doh
         TuYB2ZwQMGngrerrO+2OHF4QYSw5FHmndzTgpLZyQRAvi3vGBvD2LgFbMxw2GdFKLR/G
         qO+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7iOS8P7fF+mbwKVjwtt91QNC6pDUyDe00l2tlX6G4Ms=;
        fh=Ba3OYV4UvFXUDGxQ38hwFx8t292yft3wTYbHshmtWgE=;
        b=aXwTmijxPink91x6QozTR4csinpIa7JfwYEKalemxs4R8t7XdCsgYIJ359Yp2gCcf4
         jtBR8Y+KXoTe1x4G0Q9Z4FtO4f9IZdUcr8wV9XMZaaOJEFe2jFrqzh4MPa5Zac4ebqk1
         XSJABOR1Hbu88nZHr8r69vgxgPih9mVzdH713B80T/JPjnknGU21Bu/AXQsAS2A6q1KK
         PK1v27abiCKiajXFi80p9hEwVvIhKu5JPwMrbCjhYNrM8b5qKm108eyatqaJr7snFnlv
         ehC5gHrbJ6Kxygc5kacpagWaxPVJzp2y44cu5KDPuQ8ZIZtjAufCyADNRGmmSpCQTNwc
         FTIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784896542; x=1785501342; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7iOS8P7fF+mbwKVjwtt91QNC6pDUyDe00l2tlX6G4Ms=;
        b=Hk8a1c6uZQRJcu2fSz29cAfsuQZQYsbfUDoZTLGil+hmkVbOiWofEyEZSIXUt6eX10
         3L90qI4JxMsPJo5/mD3tm2y/mP3byxfVDPaTn8mTtECeU5rJWbRNereD1bVE6KECtfJl
         WjxPvLBczzMKsy3YsDni9WvTUptv4EVCxmj3wK0BxIHhr2zyWVn7Ozm2Fxo8UGWYAK7E
         FtacioTXd6VB8KQ4vRdBCf1eTpSUVnFF1gMjiPseMFO1N/fiiQebUQUkkQhukXifw+Z8
         yR5AiF5bv2zfeeA7ABHRNE8iDCY2Y6PovEaji6OJaRw1tQQ3pGQU19vaM0rYMb+hH/y/
         +U1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784896542; x=1785501342;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7iOS8P7fF+mbwKVjwtt91QNC6pDUyDe00l2tlX6G4Ms=;
        b=gYO7lQ50E+kiAWp2B4NsS1JZAmxsHLgFZwL+sxF9aB6oK1jEIIvJatrmJ9znCVUJog
         6SWnENNz064Ka57FkN6IcAhFyQVw0YqjN7COKdzUzrPIYxrS61AJsOXz/Tybc15qtkY5
         4MjqI+I0DcHWwuGctXKpFAirg8q2yZvM5hKW+WbgaaAy6rJnir19/2lJ3RFwsB+KkogD
         fLgB9Xzw5irpaRsMYKeE6ar0yLc2JhwlYXPLbbhWpDggOTH4GGv8E8UKvFmGT3izusYy
         MJiREIamCKiCuD9rS1RLPveJ1IZosFNchpoGPXdh4++Wp7uUjG+2/U0i/MO2baC4djN3
         f0Dw==
X-Forwarded-Encrypted: i=1; AHgh+RrZThqon4MAqsFt0nyO4Qp/8Q9RwOq5GcIecNuh0dwyeX7UFabLeHSzh9H6R9UEVEFYa9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCZOTRH4Q4RAj4whXdpyrk3CEny7MSsQHwULvLXW/A7MMcuM/U
	2q1SYt5haudOEIr8tR0H6LPUGoNTYCGRkGGzKEqpyNHuYncfyJPzxt8PTE4HbgziVh9IKKxoUId
	jgBM+HO86WvB26TDi1DV57nijMgWuUl4=
X-Gm-Gg: AR+sD10BhxJ5UTvzXOrPQoE6JlzCW0v+mxTuu+WeNp2jS1voHQN//0Z6mEEyfoK/L/B
	AMkr5aX+9NCZgiUu9w0ew7MYxHEj24dOEbvaHKoU03L69emZdheGJ+ten+FZR0oRZLes81n6WsA
	NoCOW0Ukv2e5fifFqblSHwZtjzhy3hVKU7QhwQO/IOspCupTJI+9XvrmoJWVNqoPVMvszgJBSPa
	eV11V6Y6uXnLcI0aPeXJ+H9i4Sq4ugH8w+jkt0AHrwbm/Sad4YUNC3Et3+Dlg==
X-Received: by 2002:a05:6402:312b:b0:69c:13:1e4d with SMTP id
 4fb4d7f45d1cf-69fb1b7a6famr119655a12.12.1784896542184; Fri, 24 Jul 2026
 05:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724091152.27794-2-tnyman@openai.com> <20260724114948.GA825505@coredump.intra.peff.net>
In-Reply-To: <20260724114948.GA825505@coredump.intra.peff.net>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 24 Jul 2026 14:35:06 +0200
X-Gm-Features: AUfX_mx9m2YNknKbxML-I5EomT72irmIfVgvRWh9iHJjO_D0xySyG1fShWp7r1g
Message-ID: <CAHwyqnVNjspjWkiu3Gq-jde_M+hX9x5RfjxoC-3Wzfin_JZuqg@mail.gmail.com>
Subject: Re: [PATCH] branch: avoid slow strvec Coccinelle matching
To: Jeff King <peff@peff.net>
Cc: tnyman@openai.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Thanks for the report, Ted! CI had been timing out on this branch, but
I chalked it up to one of the many CI failures we had in the last few
months. CI is now generally stable again for some days, and with your
fix it's also green on this branch specifically.

Good point, Jeff, probably it can be 'int i' in the 'candidates.nr',
case to avoid a cast. I'll push it to GitHub to verify that the CI
passes there as well, but I'll wait with submitting until others have
finished reviewing, to not overload inboxes after already pushing out
one version today.


Harald
