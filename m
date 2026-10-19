Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792427947;
	b=k3WaIhMjambs26wrjQygA/JZRW8NYn3syrRNTU40ne751tqXcHBoV3Cx8XtgLFpcBxbM
	 VA/+bs+Wz8mBI+RI5Z3tPtvxpdfpiAMqf0YwjqTH3svCFNcKsBkgLasZjq5cgTIEErP2g
	 gRRfY6ZD4MMonSCf5Ce2Z2IGu6IRedl1cZ5r1zy7ZEaj6v0Fnq6eWf97orylDCMkjRSnH
	 9QnRzcYwSu1MDgc0/PWtJ3J4nCEXklMkBzLXgPKdRwSl13Coj+ueBddL5FAPecp8XgLH9
	 DDEbIvjAkg4CNLV0B7kOz53TKJRDeYrEU3YlSqqr/p+M8FPm3YQsWj7agOC24q/Aedg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=wZWj63DDMLOUEKSUDtdpBBVTKcJroiiBMg5XfRaPcDs=;
	b=nZXhD8DuOjgjXe9NPV6D52Xh9JEuMMGrDveGcVWWF8xhM4wonxm8xRhRgWfvHzx7LrWP
	 NM+sevucOvM+Aekjmb6eiiMcnyZvlSIV+ZUsIXaJnxDet/Z1yJ9NX4LJwjxh6eJShxgOp
	 m2LWPZea+JnChW33gsTamXfSMis3WQGCz7vmtxIPVS+5tM5m9dFZj8vxyEUYiBpXBguw5
	 keAYwwW/iBDMMVHSuWIx+EVE2rx5e6ENHJjQlmXn4t0qMGvqZ43WPk3zcUf/dzun0SFmS
	 +taNiZmmn1mrjGtvZW7JjGA1gRPs5bPBpLXGjodQi7pbW857nb+U3/t6RMPr3h2TtDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NGtNN7wD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D154606A31A
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 16:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D154606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NGtNN7wD
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7c03a445cb8so1661457137.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 09:39:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792427945; cv=none;
        d=google.com; s=arc-20260327;
        b=Ukn9ekmnPaAz4ftFqXyv7d/DbddWQNS6fvTfKpql7jnH2ny92hmSFEv8h/m3fwFUsd
         gBZ9SBCT6RSo/DymVfnENOOsZHq0I3RU9IX57cJjkIJ4GJz0mxK+puQOLX/JXyeunDVt
         oiV3VxljVwqYi7JLLzSHxEZofvg2aMf+MKwLsw3WGeDwEJpCQjrP+k5+0riOZ5gOhwbB
         AysnsuI+BQBC3L1cTBCQDRtn/G/VlnI1vKFi+VU6F3C+S7XR7U8Ph+kekJhzVGvkKRsD
         CeMDOj1bEZ18Hclu9Ap2FY8qcjwdaAbI4y1Hh7kOQ+ENbKvF+nml8h6QFio85D+fiz21
         sKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wZWj63DDMLOUEKSUDtdpBBVTKcJroiiBMg5XfRaPcDs=;
        fh=2BH7DRhxtn9nK6Btx+Qbsdd5Rj4kcqHg57UxxPU2FJA=;
        b=Dabpe8FxXyXhkvjJ5D4ENuRQOPQxnHqXCbBcZx9SIZIKMWsSIrsVNyIXOGlLx5vgQd
         4fs9e2WqHlL69V2QX/SgX/VCL13Pesm0WFCVT5Wfpyk0xT1EQyzMgXyrs8khUzl4D8c1
         r09rG5U/oZYKuGje0RXJ360QjHAGj2eAuyAMHDExuS4udzExHRy6t1zf2vUxP6pygU6i
         i9tOp+RHc7A+tRMdKmE5YIy3tv+tbNq9/tulH7G6KkjlF/Ism2APzAjnaUdzTXkrxFCj
         8bG8bBnz/BsOBaFtTroQHY7kN1lVNA04G929TRctGBuinFeZKfq2273Xjt9DnXRuonSI
         pIjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792427945; x=1793032745; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wZWj63DDMLOUEKSUDtdpBBVTKcJroiiBMg5XfRaPcDs=;
        b=NGtNN7wDdbPUMV0P9T0o/ijNrWpBNC6ksN7Qe99MNgahlAwY9UigGlhUC4Fhah9Zvn
         KcNF2kp9dubiKE99GTnti00h/0kJnzapNZjaMjTme268Hm3AIbdpRx9xHK3Uexa2/mmK
         yKzKUT2uDY/sO8+VpbsQNbZuXnu2CFdZFg0oYDydwWMUsgJkKwt6R0Veh58heKFUyT5e
         6GVx6fmnwzFkfQn4HXkeCdu6YJScF4B4e4emiYiEEPlrCTElUY+6nbaP3gh/7vd86Q9p
         xKPJmHZ3h6eeBI0cgrLSubdOVZPGE4Xsehzs2e49x26cIu48LOxmBC+qTKktWs/w01Ll
         LtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792427945; x=1793032745;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wZWj63DDMLOUEKSUDtdpBBVTKcJroiiBMg5XfRaPcDs=;
        b=oYbus1DlTdnH1OpTSLzKKOYvGd2t94qfNH894Xjk9E8tkqcIG1ETqjWhUJsy44whhl
         LFkZ+7PWD4S8sSmDCH3zdJmZcOlo7A6i3agn432d5vbnSG+WqK9JufVsJ+W2VzNdIzJv
         33X3BZ7sQiJH18IcZCFNiOFRvx7EOmWToGfE5vy2aV+RMJwOd13jSpERMW7KtVmK2kXQ
         NGK1aSSnDap8Xzw1mV9mirwlDEW1J8zLSddiZzr5+DS3o0LCJrJxNdQca9CH7VLl/Eaj
         sxhXp75UcOKkMu17EwiCyjkLvY3xfv/tOBqJPZneWmA7tbThuLR6DKR62xESTZa8MzPe
         Blbw==
X-Forwarded-Encrypted: i=1; AKwUvBxmMD9lvyURWrgpQ9ICmTJMi0kCDsA4f3IzzUxzPzFHrC7T//p4O/8ygwnHjpvT6uie8vw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrgUy2fGVVyo9hn8eSiRzZFRGk4pnBJk7/tg2NJWjavcTGykQT
	inF5u+UPoecRVJt8rP0ADSd1Lg2dNIAnmQfd9grjgB8NxT/QMZim+GChoiFLdgQmdJNewnqSxtz
	zQd0q2ToADZnffH2RVqiWaeGbcOJ8SnI=
X-Gm-Gg: AYBFou37iGhOKtcGL8wY9i34WpsLIsh4xBxroA1G4Zd58uSSnsSK8kGSiDgmtcOKuQ5
	fZ9XJ6JwPdOInzzIYDtGZ+e8R66h48InR9gUt6DZgnUcgUWFnIY3fcLjqKUXgu9jcqcq389cVwG
	7L1wvyFGb7zymmZod2AU8v9SdJuhdTjpQqlx7Py8yx4RJsg/B+aW29vNF6qXzxQO5LJANiLEssZ
	rqPFG3D5f/YHV9z5H03EAq/SpXEch/fqFLpQZBkufe0wEKHxd0ZYU/kNL2CWuJd2kFd0LvB+Hql
	Z5oizDriTeMZLWhK5j1Tm1P6tabbXgTlnLmhPPbw0n8pHwfp+1OQrEB7
X-Received: by 2002:a05:6102:509f:b0:7c1:62d2:e18a with SMTP id
 ada2fe7eead31-7cc3697cfb8mr2605239137.16.1792427945478; Mon, 19 Oct 2026
 09:39:05 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2266.git.1792341073005.gitgitgadget@gmail.com> <atXCFxxe3Lg7fV2W@pks.im>
In-Reply-To: <atXCFxxe3Lg7fV2W@pks.im>
From: Shashank S <shashu8660@gmail.com>
Date: Mon, 19 Oct 2026 22:08:54 +0530
X-Gm-Features: AclHuK9MQY3BXx7eDU6ZuJqK_bvBw3iMrY_RrNr0NrTqvdOJPawKcfCf93Z0sSs
Message-ID: <CANHmUQTj8nR1GmPD2FW3+yfsgdgNh_vwRCcxRhS8GcY4VHDb8g@mail.gmail.com>
Subject: Re: [PATCH] prune-packed: remove USE_THE_REPOSITORY_VARIABLE
To: Patrick Steinhardt <ps@pks.im>
Cc: Shashank S via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Christian Couder <christian.couder@gmail.com>, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Oct 2026 at 12:39, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Sun, Oct 18, 2026 at 04:31:12PM +0000, Shashank S via GitGitGadget wrote:
> > Right now, the prune_packed_objects() function uses the global
>
> Nit: we typically refrain from saying "now", as it's implicitly clear
> that you're describing the status quo in your commit message unless you
> explicitly refer to an older commit.
thank you for the  review and point the mistakes i have done i will
correct all the mistake and i will submit the changed commit in the V2
patch.

> > in these files, we can safely remove the UNUSED macro from them.
>
> The question isn't really whether we can safely remove the UNUSED macro.
> The question is rather whether we can assume that `repo` always points
> to a proper repository. And for that you need to research whether these
> commands can be invoked outside of a repository, because if so the repo
> may be `NULL`.
>

I have checked git.c file in that file I went through this commands .
prune , prune-packed and repack which are .
{ "prune", cmd_prune, RUN_SETUP },
{ "prune-packed", cmd_prune_packed, RUN_SETUP },
{ "repack", cmd_repack, RUN_SETUP },
All this commands are all registered with a special flags '
RUN_SETUP'. This flags search for .git folder . If it finds a .git
folder Git successfully initializes the repo struct and passes that to
valid pointer to your builtin . If it does not find a .git folder (if
they ran it outside the repository) Git immediately stops and shows
the error . It never run the code .

> > finally, drop the USE_THE_REPOSITORY_VARIABLE macro from
>
> s/finally/Finally
i will change this too.
>
> > prune-packed.c.
> >
> > Signed-off-by: Shashank <shashu8660@gmail.com>
>
> We typically ask contributors to spell out their full name, see
> Documentation/SubmittingPatches [[real-name]].
>
> The changes all look sensible to me, thanks!
>
> Patrick
Thank you
