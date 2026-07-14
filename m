Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FAB3FD122
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018363; cv=pass; b=FISkACkeqUTU/3r8wIwOi+FUXFTR2qDRZQX7wgvTODnU+f95leMjisD3IN0uAgkly/ELvhRisixOJSaeHbu9fOJNxAGU/ECWb6v2uhCXqq/7/0wWxoaXkMpAujwt4igcaoquej5Duyb8o0l2HHrHSP0TNPLNir3ub7DI/hMCuaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018363; c=relaxed/simple;
	bh=83HARVbQEAM/XpuCsnyzhczgbRUPf86p2MsA3h5OWDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e9gZTQnmHXpm+NN4IomZBBYeDatosIDPPJ8fRahse3Jtx9C2H+9uiqHcKl0SdgeaXSgoX9ytAJW5+Rb5LdHjxjGgGWItC8+EdIPqpqzWzGDOn1yIJh3EUWDdHJUeleKiVEJSEkOaN62+IkwVcO+05AfXDDNXoROglvn4KLMzMtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GI3bEoxo; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI3bEoxo"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-697de23bd7dso938963a12.1
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 01:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784018354; cv=none;
        d=google.com; s=arc-20260327;
        b=pjdEk/iqshlg9q2SrvlwX1hLSQ8V43lb9qk2X00z+18VwrDOyuaYk1XdMJbnUYcPK3
         Mq039Y7xAeYs+5uJlv90dksx96ixXBaUKmDboy4LpNDDCeOaMz/UT+BVgsQsrdl6zd8x
         nVfXD+zFpC00avNHtaxOY29ojgj+ihUxhOQzvD5uyWNIwOdcQmjqWZ902WN6RjLlKuaf
         EyH92unbHzuAza48NEcA3exto6oQKmuQjVbL9N8w8bAXC6AtnIa8VjKpodNnOdmzEyRs
         Xt3t647OAXVB3WpZNRYVCQwQQXGu2wxbheGfjStcz/u4yxMt2XUGn3bNEDRuA6WVdcbO
         lkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tjV2M+5+orVfS/OAI6varhK1ATN1ZquhXbaVOnTTvmc=;
        fh=ayBK/zvxnSCS1xlJxvXb/e09F9tHSiZpxzr0ykCeYiU=;
        b=FKq8IsVLBAXVL4fpl0L8co5Uocm3sclDEc8By9pmQG3TR5S2t/ulsNX2c+ORai56Um
         R4MMunh/sITJiXQaYW2TMLh7inKp1knW1Q6qdTGnm6EeunHjDcFVbevFZqAJpOQl8t2T
         O0fl5GptNd5tZQOX/68kp7ImRAL9jlFT13HV+FOInCKDtNBm7NHkVDFL/jUEsoZxpu5H
         mEdH6b9UrjBal4X3ZoQ3q3V5cSn69/fu6OhbQGw3lvSs4SpZrM0FFnFfM9lvUUjCKa2o
         kcA3rA3sbWYuEtOB2owVXX7JwEYtiVSQysxKzn1FroGCQ30kDwM1xm1uDv2aS/5UDOaE
         MJvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784018354; x=1784623154; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tjV2M+5+orVfS/OAI6varhK1ATN1ZquhXbaVOnTTvmc=;
        b=GI3bEoxoiPSbjY0eD1sHVgUcb0WvhEIvliarp0NRs5RdePVdeISqsvfUTnwwoaQATI
         z0qLhQNzBTFNaScqF35WZUAh1lqKiS1hlr4VNbZl/KTyDcwb5jHGAP8uyyKwFWDO9bUx
         F9a+FSYJHhsXh+zTnsr/ouoErmN2VbS7vqLTOnInN1R4qfdgIo9dW36Fh3aQrjB/Nj7k
         fBcm7YFLuwCND+gVRIvDbCMxXKbQGCMROPOnxdtWK8pfBf5c8h7Eee7LF2WxS9fhH4iZ
         JA42GTNuSvXIyYOvanzYFBlLWdUykYifaBGsPvFLS3O5uGq7rHUVyqwRjnetLZoAjoq1
         rINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784018354; x=1784623154;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tjV2M+5+orVfS/OAI6varhK1ATN1ZquhXbaVOnTTvmc=;
        b=WOdozHFyeNiH9EZXr+mqbog2Yyby7e7LKlzu+UO4uRXvZKy7SRx0LI/uJ+ZTBZVaOO
         tB1NqMM5ZoBDn/71TZjzho/MdcIMKbekCtJXgCo4BcvS6fRxHA1e8qFyhVJfNXGyXb11
         4vxaKYSmuIJsnbuvoH0ORoNhOoBw1gsIfhpF1SB2kPhSLOyJOAs2aTTYZ1V54aymJ42k
         +fT6L0KLL9oDhrh7tKIKMgaWERHb4X4stBnp8Svj5MtZuSNTeky9he70Nb0HU9AiCE/e
         Qwngc3fzQnB8Yf4y98o0DgnjR5aNcuFT31WaxGw5QnlOxdNhAbRxKqmFrw4jKfT8a0lM
         F6NQ==
X-Forwarded-Encrypted: i=1; AHgh+RpliWdoBMhSHOjgXWLSGS1ANUThDk6qBz45UuklXyTaPkAqyXMw4D40VR4ffkcg+Hfkn2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh1Ql1TfbtIVjHfIdu9EoBQZazyX7Rr3ljAI3n+QCc/DgWkFuy
	p1OVuwIeg749z5bldByuLzE5P98WTW1TFSKe3wUPbfIqJY94icW4XiDB/Qr1jXzRW2TcjvAfr0U
	eM4L4KeOkURmgGu2UKKowk1423ZfjaB4poSwicJE=
X-Gm-Gg: AfdE7cn1XMxidD6ATuZM2I6NAlrzN82b3XAWjCPTPY5PRLuiO0k0c5MhlsugnrLkFjk
	5trqHPv5BRbwhp4sMMmKOsdSRt1JNSpQtmOoRfo9kvFXhlfFGfUFW2SvAUjZucku1KdmKf4kNi2
	VPucijWbGxj31iier5hUULji7aw5WpbeDQHycVtC6nNw+Lz1SJN7R14TQXxH7rTBW+bOrzg/EPn
	v4JJtwNxWY2BV3laXYEgiZaWkntKJMZUoLJVv13gXTLGR2OxwowhBUrsgD82tCnU8WKQpOR
X-Received: by 2002:a17:907:1ca7:b0:c12:9b98:209e with SMTP id
 a640c23a62f3a-c161ea32f77mr558253966b.23.1784018353937; Tue, 14 Jul 2026
 01:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
 <pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com> <DJY0QSJYNG0J.210HZQH198Y1N@lfurio.us>
In-Reply-To: <DJY0QSJYNG0J.210HZQH198Y1N@lfurio.us>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 14 Jul 2026 10:38:34 +0200
X-Gm-Features: AUfX_mxmZdl9q-abdEuun9zZXRRZQjvnZXKnOady0xwZlhhIWA4u24XgNt-wy1M
Message-ID: <CAHwyqnVVYMqYTD=Hri1gYW6CvkjKgTMv8AGP59bkOOd+-huwbg@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] history: add squash subcommand to fold a range
To: Matt Hunter <m@lfurio.us>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood123@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

> This feature looks like it's coming together pretty well imo.  I just have
> one observation I want to comment on:
>
> I noticed that 'git history squash <range>', when --reedit-message is
> omitted, will ignore any amend! message in the range that targets the
> first folded commit.
>
> On the surface, this makes sense.  The feature is pretty explicit that
> it will faithfully stick with the first commit's message, unless
> modified by use of --reedit-message.
>
> However, this edge case is a little surprising, given that
> 'git history squash' seems to be aware of the semantics of fixup!, amend!,
> and squash! messages whether --reedit-message was given or not.  For instance,
> the default command notices when the range contains a squash! commit whose
> target is elsewhere (a useful feature).  It seems consistent then, that the
> default command would incorporate an amend! it is aware of when placing the
> "first commit's" message in the resulting squash.  This seems useful to me
> as well.
>
> At the same time, I can understand why the current implementation does
> what it does.  So I'm not entirely sure what the correct answer is here.
>
> I'll mention as well that I really like the decisions made for how this
> command handles squashing a bunch of related fixups.  This "fixup
> consolidation" is a use-case that this command may steal away from rebase
> for me.  And the way a final amend! is handled in this case is what got me
> thinking about it in the general case.
>
> Thanks for the work on this topic!

Thanks!

That's an interesting observation, I'll see what I can do about it.


Harald
