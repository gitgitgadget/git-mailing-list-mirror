Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE171C5486
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771695028; cv=pass; b=OvjQPMNJKCfT+BlLGnY6zsGAoirs1aJBh391ZlZ86nt9weWikU/jWTgcNnUZAbBoHFkOQ3+5yq4z8HmCtNhAieMAgUzcvvZ2/v8Wm0pFoJf/nNgOnqWJhE5fb7r9ZdHbcfk1gk+G+gw9Xx3pEUWzikWK3E111zweuETu5g6cf+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771695028; c=relaxed/simple;
	bh=3BrYCFEG+SZAFrL9TAwE6NzuCiRFdEMwgda9B7rn4S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLLTtIYx/NSbkuaiz8DR6YhyxXb3cA9fXSkG42L7m0MyhE+/XOYhjQ5jy5/iO3v/xIldzTqQk1Cp8dCKjCBiYo+lp/TIVRA9q+uTm+NWtW8uc46CyZxPdpq00NNdeKIAv0mQP4Sk1zI6knLhtlPuJxxamyCir53HlpVcxxXQTuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSrY4Dt7; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSrY4Dt7"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-94ace5d0e39so984890241.2
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 09:30:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771695026; cv=none;
        d=google.com; s=arc-20240605;
        b=by2TvI++9YnuVRG+9FL/GAx1hZ6d7RYTeUkThNUjsr+X0sWqCSFtQ1ycKdaW5/J+4r
         LVnBqPkTxKM4uIWS8SOsYMxcKYTKdxzqgb8W3uZCvNB0stB4N9ikd/a//ioLLKd2j2eM
         MwX/xjchzbgy1G2TOG96XSDmja+7DUoRjgbTivhLGV+fwmX8iAjT3vP00Rp4/x9lCD8k
         4O5nemDRYdEjbCjLsyBMgr88yBcINIZMTt6iJ6AhqUjT8n1IQUa+Zp3oYySxQwJQbEBf
         NHMqtK0lNjvXF+CbcU3HOyMY+ESs7D9fPpjx4XiRD3jZ/5DpCoWGoZTjnHJCJWFVA3+8
         JeKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3BrYCFEG+SZAFrL9TAwE6NzuCiRFdEMwgda9B7rn4S0=;
        fh=gCYhJJQ6yqSuiQ4WpGYbuWbDC5XxyZrcy6/BxvrOLBk=;
        b=U7qqugyXmn3m9zjkPf7lfAZhEBa1JppPIAi9DeIi7mnQj+/IsT02Lm2mYvEZZxny0x
         Miq8D3rA0wSOt6DpelUcnufqjlepTBysHt1WWKqe3BjRMpVxBY0Kq6GRsKFXnunraAMt
         6+hGWB/XN4SaCx1AOmC2O5s++gsskWpt0jz43LcHd0YcQ3IApV92svG21Qn+nk6Uggnc
         /qo9Cfp8tP3bp5QC3QvqAan5RRRdeq+vf4gPsGdC3xgCUJSk9BiZHC/FST/G/Dm8m4Ii
         Qw5K8r7GjyhAUH/JI8+WI39ty4FK/brbOFeXIiWyD8ujF9zNxcIgHaSVaQ6zfnTJNxiB
         vv4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771695026; x=1772299826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BrYCFEG+SZAFrL9TAwE6NzuCiRFdEMwgda9B7rn4S0=;
        b=RSrY4Dt7+sXLkNytnUa0e97Cjk5gY8KbhDWziifYirhONaSqACPwPVi3N6wasl7St4
         Jz6wJO4xX0W7zf+Gwzoy2+GsvYOfZp0nPFxmWDWvQxwxC8kWn6c9ToNb0JLALsQ9UlAN
         tlYC/wcdVnyjFlMWmAWJ6pM0EMtKskYcLVfettBFDBe+QGW7bs5EY/5ZEBTcJSe1J5le
         ltLC6TjXtgIE46d5l+9ux0SBcanuv1XaWK5Gyc5h0pyqS8RVJPItOXuG5i8ZtW/mWLiJ
         3FnXnr/OIBVgPn11NpRh4r4EV7b6ZdijfzVa5ykHE43gV5IIWX3ffTj6cujiGa6SXBZB
         kFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771695026; x=1772299826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3BrYCFEG+SZAFrL9TAwE6NzuCiRFdEMwgda9B7rn4S0=;
        b=Ectj3UDVYUyRtCC6V+srT9qRSbRKL70V3Y9WupKXCMU+ZgZjcqjeelVtv8mLDmIoDc
         8kYZHJWOHoe+FHxGw+uLTPk8YIYzFIRb3uQSlB6nDBRXvUVPItMhS0D5cbFX1q1pScD6
         Rgo6elvX++LNaOiYw89aJHdhCu4xUSFyuSa1LCrNb5+btd6NyUv3MW3Jz2jJ/tcbgRKY
         ZrE7HAGFjGkEWnuejRd50xRQvD1vwUOusp+dBabM3tAUr5Cmyl7lqGPatd4Zjh7mHFOH
         +0kNMu1m+iz2trmN9te4qqzvUCpqgUnHx/EG8zjYDv1uKSO01ZgrYKLLqZHKUWlrQ2/t
         v4hA==
X-Gm-Message-State: AOJu0Ywpo5sbU1BEmmIjd0fVHf6miDCx2wDl14yCdbQlzalbKzcEs761
	aW9EE14bp5u3kqV7FUQM5D1lqTovL+8jKCWOaadxm7qD2TkdUdjXs8ZTG74gCRkV2fSOgREr+lj
	ia5WS/D8S3jjT7n3YoIA7+aNK24Vfxw4=
X-Gm-Gg: AZuq6aLTfv2aaAidQFZlpoULhD7cIi2kfgaML9PAE3gjnzhU8IYotJFcX+FniDAY63v
	Fbwymrt3Xfu8fl1rkKpjfa6clUCwmjPdCqD/ySHlIxn1iW0M6gKBDSU3M2poXu+WRBnVnIe64Gz
	r2puTI611jKqd584U4eRTQFwVVRNagId6e+CaRssWQ3M/GFbYlPZKpYAxB/ijIlAoQ3CcxXkfHX
	jM3Vbe5qM9gL7PSBpJUwDFNXOm8Ef+YA325j+jr7UIp8EKYG1NN6gbD3ZZojT6VdNiNi+LhZ+P+
	EKOR9DZEaCCS4HhL+HR7INmT2hmxNw9vaoHsmpIKj6rhfpbtTw==
X-Received: by 2002:a05:6102:441d:b0:5f5:867f:3507 with SMTP id
 ada2fe7eead31-5feb30bb9e6mr1546362137.31.1771695026182; Sat, 21 Feb 2026
 09:30:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHU-3nJVDmdU9FGiPTxR=rL7nZEC3K=0Xyc5gAZNCRYrQMG4uQ@mail.gmail.com>
In-Reply-To: <CAHU-3nJVDmdU9FGiPTxR=rL7nZEC3K=0Xyc5gAZNCRYrQMG4uQ@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 21 Feb 2026 23:00:15 +0530
X-Gm-Features: AaiRm520s4USeFOyrsQZTpi9NoyOl93KKXt0t0QFjBmkF5Qz7s-TIYhkFt9nd0U
Message-ID: <CAPSxiM_k8utRBS7SyHTMfH97hC62CtDguiV1SDXGB3M3JkdJ0A@mail.gmail.com>
Subject: Re: [GSoC] Lambert Presentation
To: Lambert Duclos <lambertddg@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	lucasseikioshiro@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026 at 10:27=E2=80=AFPM Lambert Duclos <lambertddg@gmail.c=
om> wrote:
>
> Hi everyone,
Hello Lambert, welcome to the Git community.
>
> I=E2=80=99m Lambert (he/him), and that=E2=80=99s the name I=E2=80=99d lik=
e you to use. All
> co-mentors are included in To/Cc as suggested.
>
> I can confirm that I meet the eligibility requirements for GSoC.
Good.
>
> So far, I=E2=80=99ve:
>
> - Read the community documentation, including MyFirstContribution.txt
> and the General Microproject Information guide.
>
> - Built Git from source.
>
> - Submitted my first patch using GitGitGadget:
> https://github.com/gitgitgadget/git/pull/2049
Git uses a mailing list and GitGitGadget is a way to send patches to
the mailing list
through Github, there are other ways like through the terminal.

So, your patches are on Github not yet in the mailing list for review.

You have to use /submit commands to allow GitGitGadget to send your
patches to the
mailing list. You can use /preview to see how your patches look.

Also, you need to read [1] to understand how to write a good commit message=
 when
sending patches to the Git community. You should always sign off your
commit and that
is missing in your current patches.


[1]: https://git-scm.com/docs/SubmittingPatches
>
> I=E2=80=99m really excited to keep contributing and to learn more about t=
he
> process. Please let me know what you think would be a good next step
> for me.
>
> Thanks!
> Lambert
Thanks for your interest in contributing to the Git community.
>
