Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03771AD5E
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 00:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749687572; cv=none; b=Qnxo15+ubiN+9sL+PNJOeydXnUOF2W/+27rS9e17fFWJgyKkFPCavvqB9D7Ra0tcdrcBGa3dLE8Jw6YU8KYKk1ROtgECT9xC99wdHleEBU7q5iD6jmVaOTDrA0Fncq2Hv7m4jjdmh5yeO2VPw2vkhRQONGptlWC3ZxO19l2Tngo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749687572; c=relaxed/simple;
	bh=5s8GDo9u3j3Qi7spvSHo+XWlygOvZVy17m0zWHp+vDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z01FXVk4ZFax9xznYjkKGbfmKxmwm7wQhfT7YM+OqDpQn+ogJTgMWm8p4RW2yxUK4q82Ca/w6XfwRjVJt2rlsi2G/0AUUqjERJploSmM4RUvaQ7ShmycPR7XUAKZoNmOkPE6UzrhsPXsdoNyoXXfAk0fnI5dQqF39HqO4S8X4CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlsPxboj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlsPxboj"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-addcea380eeso68081366b.0
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 17:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749687569; x=1750292369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5s8GDo9u3j3Qi7spvSHo+XWlygOvZVy17m0zWHp+vDE=;
        b=QlsPxbojneGnfzlNonLPbKxLy6LB4vxw/DOELGtrhq+PHpkXf3zxK66Kz7Yw6nr6JH
         nEZDGyJf2MvVEKe+VecDNcFUGf6Y09Txh/anO5KkD7uNbLTEp+6Ry6LbiGZbJWEn/8lO
         vw+xQUDtfCxcAtfcwoPR1ZREWmZKKo0rDuCvHpuYK4a8qYE/d0I9oJbVPBZZRIWd73eW
         7+NmcV+HsnmgnPGVt3tY3Jh5DOe+1+luLOFyxA0gQ81tK3YtoidtG9DhTM6AMpmmNZmv
         w0LvK1bJNMkPM0oqjCcNYvOK+HVQhjPqK2WHRjkgJQPoyz/YdPohDOOyaWNaa2o2/1AV
         5SAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749687569; x=1750292369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5s8GDo9u3j3Qi7spvSHo+XWlygOvZVy17m0zWHp+vDE=;
        b=ULIfsrY52dn6frGt0nvmMkl7GXsF4+eEFRGcZln+HkFKFL7iMeK241++N+I3O5A9Yg
         8oGotzbCYGBwgo+mIsq7fyZ7/2vyyJ9u3GgGquLdPm5Dw1/8w+IrCmlpyavrK3+1bXbv
         WuJ/IcuJ0hoCASuXWKPZH+vIk0H/sSxYDvo/J0PsiS7sd4A3nBCnjmT7h0dcLoTa/UPp
         KNJlGCgUdPrV3FjHCEqGG9hqYpAZX9MGzB1HSbaZRYJs2uyUdxkw7xkTVRgxdO+vSYTW
         kKY3sDgvFpyHdmulp7NepJX7QnLkYLSJVwNbbCWKiqHM0k9ltmEsu7HuKThTgNnQemlx
         B7EA==
X-Forwarded-Encrypted: i=1; AJvYcCXzyw9eOXIAEFSVq+de7FlsmKdxN36LXFhLrdKIcoRPiMkEHo2LR0gnpZJMuFBXN1/e9uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0J/gGq6BsahNJ7scgsn7fdcNNef+9KreC/iGFghwl4omiw9T6
	1fcHoUTVVbl/o98zjsjIQTsX9QdI1KcQE/l7W1A1TDUc6+KPCk2+bZXgqo+s5303A2e3/0yjjBG
	Ft+JisVqOr1j6ECx76YOvc6bkAnC+jf4=
X-Gm-Gg: ASbGncvJqgN3XTtrAJcfEBiVHKmrc4a00layzBabI/c6O8wu3S2msz7mKQYDuol5K+g
	XA4NPtjDbVcf6OrFUReoIleavVckRvdBXDbvaIn6+ks7RIgZHVsp+T8QoRB9MZkVyJl35UirHfJ
	9WWoj1eovbQw3B8N4jp1LQI13MuQGyJAehF1pEM2LdGcttdHPcsQUV
X-Google-Smtp-Source: AGHT+IFHcs9wYh7TGh0EkI9hmixe0ti4CIgM0j+flS39F2vN1KcU1BSVfV+ejhBDH4WrT6X1NtEMn8XGNYPePS9EVPI=
X-Received: by 2002:a17:907:9345:b0:ad8:8cd8:a3b7 with SMTP id
 a640c23a62f3a-adea928c329mr91924766b.23.1749687569056; Wed, 11 Jun 2025
 17:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1992.git.git.1749546464346.gitgitgadget@gmail.com>
 <xmqq7c1jmgpq.fsf@gitster.g> <CAEgWtF-fNXaC88FWw5K_3ZpbvQSxAfeuCFy8kkrh_z16vD77=g@mail.gmail.com>
 <xmqq4iwnktyv.fsf@gitster.g> <CAEgWtF_0JzZ24L+H-WoKFGaK6Hho-YYbutxSXRud4SK3HwOYXg@mail.gmail.com>
 <xmqqecvqjo46.fsf@gitster.g>
In-Reply-To: <xmqqecvqjo46.fsf@gitster.g>
From: Andrea Stacchiotti <andreastacchiotti@gmail.com>
Date: Thu, 12 Jun 2025 02:19:18 +0200
X-Gm-Features: AX0GCFu3TAObFmonqZly86howh_XmNu84LF-CWjPyjx9C2XB8kAT374MMWk5Mm8
Message-ID: <CAEgWtF9MRbRASg1Jb3n6Ggvh8viZOpyev+OyX5DSpWQ7bMF8dg@mail.gmail.com>
Subject: Re: [PATCH] branch: move multiple branches in a single --force
To: Junio C Hamano <gitster@pobox.com>
Cc: Andrea Stacchiotti via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

So, if I may ask, is the proposed patch as written (branch -f A B C X)
acceptable and you just need me to rewrite the commit message
or are you not interested in it at all?

Il giorno mer 11 giu 2025 alle ore 17:26 Junio C Hamano
<gitster@pobox.com> ha scritto:
>
> Andrea Stacchiotti <andreastacchiotti@gmail.com> writes:
>
> > Il giorno mer 11 giu 2025 alle ore 02:22 Junio C Hamano
> > <gitster@pobox.com> ha scritto:
> >>
> >> Andrea Stacchiotti <andreastacchiotti@gmail.com> writes:
> >>
> >> > This patch aims to make repointing multiple branches to the same commit-ish
> >> > easier, currently it needs a shell loop.
> >>
> >> Or "update-ref --stdin"?
> >
> > I learned something new, but I'd still like to keep advocating for a syntax
> > like `branch --some-flag A B C X` instead of feeding by hand
> > update-ref commands.
>
> I am personally not interested in such a mode, I do not know why you
> think "--some-flag" is needed when the command can figure out from
> the number of things on the command line being more than 2 just
> fine.
>
> But my comment was targetted against "it needs a shell loop" in the
> justification in the proposed log message, which is not quite
> correct.
>
