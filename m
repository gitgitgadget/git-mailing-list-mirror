Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D4926AF4
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788853620; cv=pass; b=qwFdeuaXGMTHHpHkkls7M5Y7dgc/5rxCXVrMnvnwom8LySKjdP0PBiRu1/fo5O7N9aN5DwG//VQyEA89YzIktQ74qYPcy3up5IGmTSS5k1LQv6zD1h4vwNlpbfFinE+iNqBd4iXF0tZm3N1whg9qXhegPeZSwDhCy/q9gQST98Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788853620; c=relaxed/simple;
	bh=V4g8zaCj3het+vzI1MhdJppcefHhc02psm/7aCkE4Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvMXKp+Qt6JbUSkcbT0G8uoygCi+IVzAVghnUiZjwOs3ogg7pvIC146ewpOch34xwOYhCfEpJIiraUrLMyqhTAtsNex5YAeUEbJ0rqeVDu/K2bpukn9VckSnunb0eZRbXRz9qAQ5mVrw4C9Mq2hA8m2aUtt9EAm+Gqc78oPCOBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=gqiCXpO2; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="gqiCXpO2"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-861feb6d61bso37855287b3.2
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 00:46:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788853616; cv=none;
        d=google.com; s=arc-20260327;
        b=H4FeSC1YaCVnwyGP46PRaC/C9ynAXZdvwNA/BO4DyUHv8hbJYnS0gWZKO2CNgcq8Re
         dxHz7KWG/UZdIh5Tft9D99x5lsAskAZVt7sVoEVes9CV708lJSwBSPJHKYdpzNeoAvED
         IfqfAiI8IDZlhzMX4hhwPXyiRXbh8U3janXVQw4BDeOZftfmAhLyx465JT8pZNe4TN8d
         FRFJtqcp+hf5DRyq6SR9EcEo2fxNv+6lrsGsQrJlVcTPQauOPmCipw9fvVv6F3kRWmTN
         qsFuUPNkq9GynkobwL/VGsMQy9+UG8kRJJNGYOH0bTMWPiA+SKx2QOpSZlHJXyeS4P1b
         ipUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=V4g8zaCj3het+vzI1MhdJppcefHhc02psm/7aCkE4Ng=;
        fh=DODnQCqkWDdUbsQb+QVlPbHuCSEyESHAv6/EsgoeJ7A=;
        b=d9XHknaOjbeTkufQywOHeeUzlik/N+vOkF22x0KHDNFINDAbVMX+xV+dJa/hgI4nLE
         evtgiTwmp/CGGW3poQOZhNky20kABBWScFQ9TZguyG855bKUEONk3SORMtLxfmfk85WP
         OEWD1HvN1vsVsh+jHz8IM9cn8dLRs+DQPV9GB9m6ICFt3+ZZPKicyN42aR8CJusLiH40
         go3cD3F+iq9TTCYv8U6+10EcndOJq/92dmHQvjSiVxCRx/ZHw+lg5v/ClUvdAyd48b96
         aQJJjln/eZxv2XO783VT/vZ+HHKyu8xpc/z08RVHpyAacOtjAoIaqx7dmo3Qz8qYnqxo
         H5RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1788853616; x=1789458416; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V4g8zaCj3het+vzI1MhdJppcefHhc02psm/7aCkE4Ng=;
        b=gqiCXpO2TEGyVgnFpjaT5jwJ/gSR+9gJYkFIqUH/ZU1knQLgbFqSMy6lVlXqGeq8pa
         3k+6XLWloaFdVvpDv1qbfzUgJzA+oQpE1IT6BN1aeOZdZAhJjUT83gZfF9gmTSo5KeMf
         ozQqqWvx55B3sUNp1mxiJ2Q+S5PP2NmRwzM2jbBF8zB1qAW8FjTvDMUxXRigCRSxftft
         l/ROfDXwYhpqsycbG31gqXqlK7IIZqCze8B+WY5PINJP2tXyDVf4mvRlsrvqYXEBWLD+
         c1ARboMz1zY1n999/0JkEZatNXpVxE9S6MvDJhdxYhNmJgEAt+OszE+3yW4fNGzqclXr
         DfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788853616; x=1789458416;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V4g8zaCj3het+vzI1MhdJppcefHhc02psm/7aCkE4Ng=;
        b=csdqQpZyG87/biA0USozOMuLca+TPMGy9waCeT+i0SoSn2LCreILqZL5KdZ2wQo7Dt
         5ltOpgYSUyXgz4dzxtCI8hOJMeNfDIMtRU+D51F7Dnf4HV9rG+814hLYRuiLMqKZq/Oh
         4v1w9Jc5lHnLoEDUFr0rewGMbeywPRA8Kq3BXfDr7fufQUlQ5GJOp0yDc3LGWAgOIOGq
         F/htkhNXcAqvV51/3qE69VgOwYdq9tx7bOCQiCVoFOH7A4zDjcmGGX8dZXJ8qGPvfmQ9
         6MDpM/sYUcgu1j+l6iTqiQXy96NI+IkqU/OCzMRzNd00AjV8/BsrOVaxASafuBZwvEEg
         8MYQ==
X-Gm-Message-State: AFuF++lQHQi/XYBy0/lB1lTWFeQi50RxqxdaW5a2QXpdqlEPU84zGrdM
	5lkPBCgHgjeXp6n/eqeGGerDAzLO9f8lgHhNpaylRDLKEa1XWA1oRgvlaSa/GczIJcvs3VzO/aR
	jIExk2F0KN4mKiUW0P60C6Telx69ZIqrX3vYj1oFN8JU1knZWgmxeOc2u/qLE7Vg=
X-Gm-Gg: AYBFou0hudV/ZOdUyjieP49majt2ExNSbZKHvDjy+vuRS/lIbdPfTGJk5Aapryv3xvo
	vLdsStZ7hh2woXjms3jMDVgJ5/py1h8AZv72q+0WbeOzity6PIsbTjlYUXPiOVAuvJwXmFymUdA
	IUckC7MB8t12T8K2gxSdX167+KBdjjsOQgdRUOzwDLN8W2flDWX4OH7IadmdP9V5Kdw96gr5gYM
	70HJBpFKzKn2cRcrdhWEt4zMR98KHcc7lukyxV6ABQ+FZEQeBnRveYqxqkh051phz5cC1U9mWvj
	CozTvKX18pNhihVDQJeiXA8+U+pD6/oiC/cdY7gAQP3q/0Tg1fLa6bSfoEDqnyfS2OdcubNvG4L
	LyME=
X-Received: by 2002:a05:690c:4d43:b0:853:c03d:2f07 with SMTP id
 00721157ae682-87125ff058amr120383017b3.8.1788853615740; Tue, 08 Sep 2026
 00:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v2.git.1788537086.gitgitgadget@gmail.com> <baab8d4876441ea883044c34bb5584631e30e1ec.1788537086.git.gitgitgadget@gmail.com>
 <ap5yVFNEFm2vdP1B@pks.im> <CAA0xjtqy3jOPWAGL9Cr0B+VnHAkZF0=cVCxKNqMiVJpfbdpomA@mail.gmail.com>
 <ap-iEoeY7XKjeZgL@pks.im>
In-Reply-To: <ap-iEoeY7XKjeZgL@pks.im>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Tue, 8 Sep 2026 09:46:44 +0200
X-Gm-Features: AcwNN1UIWIyFxxl7R5XyvACRjSj7GrGSwi94jD0-_foRGNCf7ydOSgPMAvDLO3Y
Message-ID: <CAA0xjtoQ_GjkG2FrhvNgGzaee4d7ypht9NpBSacw2fCO_=i=Sw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] sequencer: run auto maintenance once a sequence is done
To: ps@pks.im
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, gitster@pobox.com, 
	johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On 08/09/2026 07:50, Patrick Steinhardt wrote:
> Maybe. The question is what kind of impact it would have on other
> subsystems. I think the most important part that I'm after is that the
> commit message explains design decisions like this, as it gives the
> reader the required context to be able to evaluate the patch.

None that I can see. Outside sequencer.c the sequencer is only entered
from builtin/rebase.c and builtin/revert.c, so those two are the only
places the call moves to. I'll put that, and why, in the commit
message.

> It's fine to use LLMs to help you with drafting the commit message. But
> what we're asking is that you double or even triple check what was
> generated and whether the generated message (1) makes sense and (2) is
> understandable by a normal human being.

Okay, I'll rewrite all three messages for v3.

Thanks,
Thomas
