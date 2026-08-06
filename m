Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B9847ACD5
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036827; cv=pass; b=WPSd4FSjC6GdmMAh16cFCN19I9Z4/ohEcGVZ2YyIrBGMqZMEHX3mrRNi0i8w/qtQ0krLEPuOqxN8CAS+TIa1VJXDX9yNg/qbfdXu271j+L8Fk7+l9YaPo/K16zdJGx0oF9sgEJWzIU1Jcbl/dd1MKsYGVMiBOJ1/+O36BNVN1Xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036827; c=relaxed/simple;
	bh=yrdTYHUv7kZhoAHMgXqfEqLfnJDRe7oR1R5R/FfHKL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfBmXL/dmlysM4EgUYtl8CkAJvE0DMwSlL2b9O5Rb/eLalqmlV+Mg4TEaHvE5kuWi7ggk6OKXEQw9O3K51dUTG2lY5u4GywdHP/EFak821otJGk64/sFMyIiODVYU0jDkqP2WIVYOgQL3ymqPH8vp4VdUOJUEayf9NgjjYj8ev0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=OFhn0nYx; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="OFhn0nYx"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-821106b5b64so24719567b3.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 10:20:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786036824; cv=none;
        d=google.com; s=arc-20260327;
        b=bKVj9IgKU8SkulMip/cXGlCe8umhXt61synqtTAyiXo8IT3+jGLc88gZNe+2gF3M0R
         8bxuZGvZWYsmrhwhdHVpW/MKFFe+fUsNYKLHFaCcq4Cj2Mg9bl51sAzjm9NugeDxJjcR
         Mgm9hPIH9BsFNnFLP9EpmqhplOaE8GH9VHIkHAAsDNMuA6yf+JP9hHYU7wNpiNV08BZY
         nQ/xoW2ZUmSUQUafFPVYdO5OZ+BEi4Nj0j6pQ/bh+m2kQsZzP5UWEekfuwz7gzhZvbeg
         UQFQIqYWmXc+eQktunZm0mK2W+op+3I7V/NKorl5rP0+RF8vUl2ti3YbzbVFVo5K5aEr
         2Reg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wBGhd7s6C5SSx/HOCCQ8ABzPP7UwrbizKdTFGiLct0M=;
        fh=pWTCMAGfV3RyVPT6nxL1S1Sv9uifu1spvd0uu6CXCW8=;
        b=TbmOInMQSqmOvBTbbB3ylljaSP30suopRROK2gw93Pedj3zG5q01pTEQTW6GpkH4W1
         esZxaJ7kHM+sJmkAuZMc/33sLUTG+sv/X5/Wru9/8XKLwvZxP3NAjJUs5TmvEbK8V4+2
         6q5KpgUCMhzz6f1FeiDtrPFZDBctugAZ+60j9E3/THOEheMuSHX8c+FY8Rk5kP04rCcX
         o/5GlADzCxMAM/zhUhB9Ado9IoF1J4KJo4Coch8GVVbiqQWD2IFfbSmEqLZJ9riMAjMa
         X5wRmfvNuuZ2qiZ/NrlOpAccfBJLMah8+PFebCVuhmJeAYS3je24cldrM3Jlt+6mcu94
         yqxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1786036824; x=1786641624; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wBGhd7s6C5SSx/HOCCQ8ABzPP7UwrbizKdTFGiLct0M=;
        b=OFhn0nYxJ8xPcjK1Y+bG0xl7KWy2H4+uhK0aKGbjocwB+CIvuCq8PgrpaXN1Rgd4n0
         vDvfDXuh9sQSOFO9VgNneF1SmGtyrRgbE/fJoYx0e9QUBQCf8g7NCzr9koO7w4YqfZp4
         MNzxtRK74RLdn4pjKpNndkhQ5eOEbOrjBme/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786036824; x=1786641624;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wBGhd7s6C5SSx/HOCCQ8ABzPP7UwrbizKdTFGiLct0M=;
        b=qPW3OPkDPqWURoN6hPJgcqOTpcRxZHKDe8dAwtjaexxq59G/1c9dzhOXQjkTSgw/IZ
         aO01l79GN85Dm2fzeN1oRW+7VmcZfBe/aa492UffwHRtePxmDveaoKD5Ekt1vQmfz13G
         jMaDlUoDPzYjZHynOHWckkxaz4UE/MU2LpWT13CzfgSRoK9EjUxzTOKGXwoGhyVbBj7l
         GnVEdyqM96suWq+G7OSEr4gqK9V+vbyRlCFtYVZfl9MwlvoguR2ys893J0TckiejrMNx
         3/kZ3j9TT/EKkk8NHr1byR8g1Wnxu3F62oBE/wXObRz36fz4f8w2RmBN+n6lV09U7zsu
         Mvxg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0BIYxdVlUByMMgK/1R3+Qz5jrdGjQ8Ec+v/IoR8TwrwDDlNZd7uWcO7YuICfcSLyfQQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYBlsPKK5lRlmIo+LO09qUeagXt4lh6fOriWg7CfGMENnIBGYF
	2z7kUFf/Nedlkv6HaD/E32X95Pm0pnniclsXO4IgO+Lpl9b9FuqZl6fsa6Mfx2XrDQWDpXg/U7I
	kQ/7FtA8mJ+lTkZNmeMcDKyLHANqJ52znzSTQHIlOHw==
X-Gm-Gg: AR+sD11tSSlzSnI4y4omPbcJL56b5VH3DgSEtHVmsv7RROuXcvY1Soor8Ccgi/QasrG
	5Tyr+BBxTHSYDVRJ52Lt4XUPR0qgEtuWySYqmi49uj1sUDZe67wnEAHjaX6OR+nBK15Zt1Eu+NT
	dFe3uN+8HN5DWcYt6p714XyydmYvIed2ZPyNEFBCw6TDzSQrCuJCwHcr5otKeA2jpUxhrpTileY
	TPH08ftJfAsHHdrAUEppGw270dOD/iyqzULDOACRw7K4qct2wO0hGTjhw39ryRQR7+qHWh0VtMs
	9O6706gZR8kAgIdk0PCwQS4JYEeeE8ysCsAP2nuEDrA=
X-Received: by 2002:a05:690c:3701:b0:81e:abe2:e022 with SMTP id
 00721157ae682-8213a06598bmr36958527b3.5.1786036823158; Thu, 06 Aug 2026
 10:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <e8565ce0203e7f94f3f1ac193eb1fd703fe50463.1786013982.git.gitgitgadget@gmail.com>
 <xmqqa4qzmdp7.fsf@gitster.g>
In-Reply-To: <xmqqa4qzmdp7.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Thu, 6 Aug 2026 19:20:11 +0200
X-Gm-Features: AUfX_mycVw3xYJF-zGmp23iqc5BxR1kMQ-7QIv_mE7U5lsUpyT7pLp2f_I7qLSY
Message-ID: <CAL71e4O7HXmNOPJr=RBRRkFgzg04JUWE0qD_Gx3_24d2P-hY7g@mail.gmail.com>
Subject: Re: [PATCH v7 04/10] t6099, t6600: add side-exhaustion regression tests
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Aug 2026 at 18:11, Junio C Hamano <gitster@pobox.com> wrote:
>
> The log message and diffstat contradict each other.  The addition to
> 't6600' happens a bit later at step 6/10, which presumably introduces
> this finite/infinite distinction, does it not?

Oops, you're right, that was well spotted. I am not quite
sure how I overlooked that. Will fix for v8,

Looking back at the history, the commit message was correct
at v4 but when the test commits were split/reorganized for v5 I
failed to update the commit message to reflect that.

Thanks,
Kristofer
