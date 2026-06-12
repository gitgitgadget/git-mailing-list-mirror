Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C4D2010EE
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781248958; cv=pass; b=FiQCSO4v/93VhXJpdqgFtlEZ9bMie5N6XTFE0JZjLLmvtR7/5RL298hR0ip/TLnVTK7SG5Hfgbdzmk36VKxItBC9YDuof3UJOh+AszPzlFmU92IEm2STdOgR/y1Z6oniPG8y6FKhd8TovckIF+h5aZ3dqN4YLRpnWS/3or7mA2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781248958; c=relaxed/simple;
	bh=JVQqFfVpsIfIMKHmdiiaLpD7F43xgOE/mTqWFMDBw9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+Nuizah2G/16eXGfDCKL7cqjhgECsPUH3ONl6cs4O120nbgnlrW8ttoj5NEWJgiPNv8jrsoeqBiYfDRm7xMpl0sZJRqRmzsiTGSktsQBMB7+jSgW2HMWs8oOzNF6G+ATHtxWNGOAMIF5vKa/dz+4bZl0zbY7wO43UQwGrQ5E9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdKTkE1X; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdKTkE1X"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-43bf95c3f6fso702999fac.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 00:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781248955; cv=none;
        d=google.com; s=arc-20240605;
        b=HifrOwBA/zsSnYMriJEzmpjPI5N15MALPkYhc41Ko5xOw7GJhUAlLbSKeQUQdz4JTm
         m2oQEI9XtONB/HW7xH9ZyBNk8w2gUYOf5gM56jo4W1Ob1pX9hMaVVLPnCMDOTQrngyiS
         mNw8BP8zkILraVY4RDoqlxy8VHFike9xEE3oZniLyhQWJPmVkxmx+tx56fiAzjtrOxic
         haJWYZQsfvkoLeJcn1yx3ZhvDyLn0WPIwS7jcnN8CxOejX7UPJ6qMJUswd5EsxePEmjx
         zE+sD6EFH1d/mmiZKCZcWNtGA3IpVdrqJng5B2Fp6P0nZUG1tJu9M/57HzpLbuC/Cj2l
         6uIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+AUMA2VmDSQwP7g5feP3eWPTKtOEwARYei6PJDo/eiY=;
        fh=IoJHFIZKgJO9lZRRCRKxXATpOWofqQlRnejr3uMMdwI=;
        b=kp4sSvPfuMEW1j//YC5+yGQMDMbjE3zwplXUSz9eYAiOaDYshrD1520Y+sCul9HS+L
         prCKdmyTaFvMZlqjcJT5Lu+TPLUAPbCtCtGAIARVhM9mShfFK+8+NtzPL/Qn49rp2R3S
         xL0Jvx+Pg0oAZKZLQnvwEJJryVHmafO+8Uv91bN0A5vm2p9S3HPJVYC6o3tsIF9bCiDD
         SYTw1M3XaqaBCn0lCRyzRz1TaQoXSvsllwQ8WppytEP2GlyDoBT8IObhjkEClkj66qTL
         HPLYEnQVv8KnKFX69mTvFG+2G8yCw7Dz7Klx17yuuqvA+KwTQjkhl17S/XbdOpevKcPs
         DC5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781248955; x=1781853755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AUMA2VmDSQwP7g5feP3eWPTKtOEwARYei6PJDo/eiY=;
        b=NdKTkE1X9ntUNXRWpHYRwEY1nqOaZOSwfC1BG+XJtDa32vs0U/CqygJIS/CjeiCOhr
         H0QGJov+upr5SqUWQu9ZhUNIXQY+T9hH23vi/wKNAQxJzefrMfY3n4eGurtSB1Drs53M
         9p4AMdzV4Gzj/UCxwgaZxiLcel8V0Vdb7DV5L6ThOeFIg/Wk5Pe47KkmkCw4z6PbEsTT
         XhNQPxzec/joGRhVLw08HG/tqk2oXydt8SYEW061Q+hkVYVdmUi2ngJMaCKbHOtIgKgw
         TZKO6+R/DE8zzNe62B8Nn5bvPr2WxXf765ZRNP//UA5BO0ZEcYJOMsARRhKgcPy2/qmq
         fNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781248955; x=1781853755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+AUMA2VmDSQwP7g5feP3eWPTKtOEwARYei6PJDo/eiY=;
        b=kNSNf3phVeMLJNVWUNMuJALxUuuV2Z/5JsNdcYNI76Bd6U1LZ9ubTnoQM1ylifNQCq
         os34K5/JX0cmJYtpLBrjkxeFxsFOO86qymxZcFSvog5WOrlUzmzUdj2pfx3czs0p25rO
         dlSDb3gGsZ6Qg9uOS/XrGSIsyKtF8ib25mddWNHZmM6Cr3SYt4cSCrN2kUk2BYTR/qWO
         G7HWXWAyM/0SfNdXhSpKZGzPO8iDyla2MHc0NYDr8j0jrmUo0t8vzt5wlom0vYPsrwMd
         Ut/et7X4tFfNrgXuMlhX+/z0SaJkfeHJEcMC3Y13j6Lj7BZsxUcFQOqXuooULtVNAsDs
         0tAA==
X-Forwarded-Encrypted: i=1; AFNElJ9rHjPdcjt/Ub8CaJxcCKO2ptmHaeGdqFO91CL4PXEZUu5JtPQy9J0kK/kEakk7xkmGpH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGEkX/vpgQD+oiaQQ3iXTdJPkQUL6u+4c6Akc3k9poK3I9aIIT
	+lNX9riPjquYY/t+SBLVsE5bjzuhAxGQJI+/xJgXuypt1Es8I/fXCgD61EtAV+L66lerC/uj3vS
	HcpbADa2CA4fWl++3f+zEjZC/RcLkU6g=
X-Gm-Gg: Acq92OHa00LQuLkXLMh01/zdmlJsWsZqKSPpYKYoVifOjxIUs6R3I35uK/j6iuJxUkX
	EDFArek6LQxfu0o3Foyv16KTiKvdfLroycIcbG3Qb8if8qB7tIEzFv6P9rGo+6yOShxxcyg0i14
	nEzx7iRt5xaIoYeWlDU65oyvhJKQTvwtdOdafGyvhcxM/zk4QhvDoUR6Dp1IgKFmBDzh0R3Fv8v
	kAFt1bB/BEIMCD9YhzhhtMaorlrvYDSbWTD4JPV7Xy3mtEE6FuylCBJ18X3AxliI0NQhABfIb/f
	7zGyy8fleVDtCZeTFGPNW5+1EZkAtcJmIvPXZoyKWtlz+a642c2JYSvu4zFGsGsx5Js8
X-Received: by 2002:a05:6871:7b0a:b0:43c:2a72:ab22 with SMTP id
 586e51a60fabf-44267f11cb5mr1113994fac.25.1781248955437; Fri, 12 Jun 2026
 00:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606143412.15443-1-cat@malon.dev> <20260610124353.149874-1-cat@malon.dev>
 <20260610124353.149874-2-cat@malon.dev> <xmqqse6uwdnz.fsf@gitster.g>
In-Reply-To: <xmqqse6uwdnz.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 12 Jun 2026 09:22:23 +0200
X-Gm-Features: AVVi8CfRdBV0m7y43-CSt0e0rTW1WGH0dt902KiCi4IuafHBKgza-cjaabqivSo
Message-ID: <CAP8UFD1UbsXu_7DK2keGLUO3Yh06-YHieZP+On-yjY3SmV2Xmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] environment.c: move 'protect_hfs' and
 'protect_ntfs' into 'repo_config_values'
To: Junio C Hamano <gitster@pobox.com>
Cc: Tian Yuchen <cat@malon.dev>, git@vger.kernel.org, phillip.wood123@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Olamide Caleb Bello <belkid98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 6:41=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Tian Yuchen <cat@malon.dev> writes:
>
> > +int repo_protect_ntfs(struct repository *repo)
> > +{
> > +     return repo->gitdir ?
> > +             repo_config_values(repo)->protect_ntfs :
> > +             PROTECT_NTFS_DEFAULT;
> > +}
> > +
> > +int repo_protect_hfs(struct repository *repo)
> > +{
> > +     return repo->gitdir ?
> > +             repo_config_values(repo)->protect_hfs :
> > +             PROTECT_HFS_DEFAULT;
> > +}
> > ...
> > @@ -123,6 +125,14 @@ int git_default_config(const char *, const char *,
> >  int git_default_core_config(const char *var, const char *value,
> >                           const struct config_context *ctx, void *cb);
> >
> > +/*
> > + * Getters for the `protect_hfs` and `protect_ntfs` fields of `struct =
repo_config_values`.
> > + * They check `repo->gitdir` to prevent calling repo_config_values()
> > + * before the configuration is loaded or in bare environments.
> > + */
> > +int repo_protect_hfs(struct repository *repo);
> > +int repo_protect_ntfs(struct repository *repo);
>
> I briefly wondered what *should* happen when repo->gitdir is not
> ready, as it feels almost a bug for a caller to call these two
> functions before the repository is ready to be used.
>
> When repo is not ready, these return their respective default
> values.  That's like the original code using the initial value of
> these global variables.
>
> IOW, this rewrite is bug-for-bug compatible, which is good.
>
> Shall we declare victory and mark the topic for 'next' now?

I would have preferred the commit subject to start with "environment:"
rather than "environment.c:" but it's a small nit and maybe you can
fix it while merging.

Otherwise the patch looks indeed good to me.

Thanks.
