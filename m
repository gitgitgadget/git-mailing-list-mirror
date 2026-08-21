Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0CF317173
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787314241; cv=pass; b=mtesKHALYhIses7fyeB9R5lOLgzVec1aBf2IKnpJBg8CLTEcw/EXcjKD7EGspO21nnEdQY4eoqtIYZI6QbJGLvJ3DNVMf8PsOs0SO2pNLk12su6WdlOqKHOxxNSd+MdmQUmEfW1057+Gym10VF8yssAlIJtDjJrYeExFsdNHOyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787314241; c=relaxed/simple;
	bh=6Lt77iNMOwn3hGdB5YkvCc6/410wjJilwtdy6T+xvrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZdp2WiP03b1tW8PkmYRkCGgtVgim7OvzdyQr3P9ogPVs+ku4xT1YZv9CAIGa2y7NeOu5T+eG39G/C574i2Z6T8K8VcK78D1UGKREqcLpTBQNcOWc35lnnEUivlDDfI0LNKeLM/+9VC6NGUZr1H4mNlXr7ltfBHVXOu/0fPQrYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCzSoxIs; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCzSoxIs"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d032846c95so10804285ad.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 05:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787314234; cv=none;
        d=google.com; s=arc-20260327;
        b=hZdS4JCftB0Sp49wMQzARm4kE9tAXOLX8Ivn9kHpvUWZ0PEXz2pmQTd82aqLqUSdTr
         5tMnx71SBRSh6bdpzxwxfvDD0z6lo+5Rn2m298tZaMwoAEbYc4KJFSejuHiTYDwDK3jF
         ZESWSXtklRXFhNM+xpckUgswCK8xjlu3c19szsdjvQXtn66zYFHqciuOix+jrI/ntBHN
         kVg6Zl4GIy6+/QLsJEFbElBMQHwXlq67Oi/OoGoooYVlZBqaxaX+FxpGh7JCmaBtRNIq
         MLvea5WkwpRMXB0/GI4fBMObfiSlEX/uZt+HJmD9gOmpW2Fb9LVXmR/8QvjY3RBJyrgg
         h1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EN67GhI4rz42p0woeh+yqtUUyKZ0JW39iGlg/Zpe7t8=;
        fh=4/ZoQpa8Wp2Caw6DAqaBnnd3ntnJLd7IcZ61KXDxvq4=;
        b=ncsM7rhHQsvoZROm3nKh2tzOsU2VKyJ+ozCLnQ4X0v5qoTz3ukllXFm3IuqRX6jad8
         KMUFXEE9c1j9EQIseTBJeojcWr+g92YdtBob5/iiNz30haZBVyJz+53NkMHyAeoS8zvT
         u6xxWExfesAiwKUGdRlWXzWeRMrH1lAjSs2SReC5GNUlkAvwYmvnaMuET31muGZw/SXu
         S0e5HuS7vwC3jdiplFKHYg1Xjp/R2q1ZE45L15Y6cariTz/ocSYmyF+nCJPMGTgssxHX
         XH96rsL9/NiUtefoM9Yfto8P3/7/Hm+IoZAB2FOf5egns8wZuaMuXAXn6PzjbSI/6gi8
         14zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787314234; x=1787919034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EN67GhI4rz42p0woeh+yqtUUyKZ0JW39iGlg/Zpe7t8=;
        b=dCzSoxIsn+/YEa2Z8SUvb5hl2NEwd1jD4PE4pbO6wivef4IkXcPw74tWd6tyTZwB7b
         pnaPvK0cXHH6kAsjd9o8DiLl8krdMYjHohGL8fhotcg6Ah0c+Qe+SNF5fICTTKdyzWqH
         am9VqQ1n/oQ+sxJ9CM6yaO/1Q4spZxya6EZaxzL4QUqsZUZWKj149KgYo86++cAD4Bzb
         EDbgFYTFtLskCA4X6tQ22VbaGls7S4Mrh9EDPbbvy8TKQHxOlg/Sqr3Kx1ftxjZ9Tngi
         z3IaCvEIkXWf8wYlUW6HLQArRrZWUrfQwE73tqAG1Qt4uUP4G5Fb1QtW9rNuIrpSDYJp
         +gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787314234; x=1787919034;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EN67GhI4rz42p0woeh+yqtUUyKZ0JW39iGlg/Zpe7t8=;
        b=LDkITAcoxlPMwrnBDG/WMZ9eBMlVqZ/xUJjXZZyf4ajcyeICs7tdMqYLyUGZbQ+zVJ
         esGJuN6CnwOdsh/D0uDIdSPs+Mz0dbuGy5T+W+VlYUa+qxIMY3WYcSfsznu5a98gDCko
         Cnljvw9+XLrCDbUt5m1CtA3o80OENosQfuuxc7BlhM5GmfAb+Q9YCqgh5iwmwrPf+arx
         Rl/8Je/KBGyGkNKJX79DbSSQ1I0xlAo4gOZCq1ehv5aRbC95KG6CUAM2alYgOiFc8wLn
         j237ytOxbqu5dRjH8A7wmR8J0+UMJkBc1eAF65wrUbgIOX6ZG4tx/eGlGXwIi6H8Dmn8
         B4aw==
X-Gm-Message-State: AFuF++m25PF24KIoEO3FGJVgcsvt1AeLGEmcG5X6H3CWfavG09lbGf3+
	2W53FnwkWAHiBR3H/sm6oF8b3kUWLJq+KPqrunpedXzkAHlF5UiyaUIXtnYLscwNN+GkTd47ewG
	4pLHrWT+Pfqsh8x6kR3hcbFj+u4QnYM1+AM6q
X-Gm-Gg: AR+sD11Bx6w4wXE4YdSmJmdlfVusQHuiyYvPXv7GUzW2P8GNrW1dRF5WPj54ThWOR2c
	2nERCkAPc2ml6X1J1JXvA8wWRSDV+4cn+1TMWFdhMswxvFb3hP8zoJGk25gd4JMuHHbsP3I3liY
	P2FlwQUybF0J9cJxkU/BRp/i+Bsj0mHbiunLx17e4gVEn/XRDS5KB3vwp19oey+PpWTWf+fh/qW
	mrxCYx3hOQwNngmmuRm8cJyR+eWDJFX3K2PULZD9/ipdXpg9XrFFRxRsSoBBT7qwIbjlRzDNRbD
	E0nuSPkeBQpa+TWF3imI78yiVmHSaQcgC2NgepBp3rmWf8YovJH1kD0lAJgI5kxVNRQNB0S0w44
	mDffV2D249b0s+VaAQzCbx4Ld42qiLSFkVOey6OAEMsjj45H59xFyG9tvwp9ZXG193a4sy0raFW
	pwUiQkLnn25BdP3sUZA70=
X-Received: by 2002:a17:903:46cc:b0:2c9:b396:1a55 with SMTP id
 d9443c01a7336-2d64b162098mr122448875ad.12.1787314233748; Fri, 21 Aug 2026
 05:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786103607.git.ben.knoble@gmail.com> <cover.1787231825.git.ben.knoble@gmail.com>
 <5693baa9923afd20333c0eb016cc5949f8dfc423.1787231825.git.ben.knoble@gmail.com>
 <xmqqa4qgsn20.fsf@gitster.g>
In-Reply-To: <xmqqa4qgsn20.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 21 Aug 2026 08:10:22 -0400
X-Gm-Features: AcwNN1W0_kA2n2fHLp6HoZFl4b7gqO4AujX5a9aAZ_Xq3I0xqI58jd4jFMs5O5Y
Message-ID: <CALnO6CC-=0X2r6USab=6MBG-yWYrwrA6zEXnDC91P8q4WDeY8Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] environment: align repo_config_values_init with
 struct declaration
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Tian Yuchen <cat@malon.dev>, 
	Olamide Caleb Bello <belkid98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 1:45=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> > The order of assignments in repo_config_values_init is chaotic and hard
> > to follow, especially when comparing with the struct definition to
> > ensure all members are initialized. As new members will be added in the
> > future, make it easier to validate changes by aligning the two.
> >
> > Refactor assignment order with no behavioral changes.
>
> After reading the above three times, I am tempted to slightly tweak
> the above:
>
>     ... comparing with the definition of 'struct repo_config_values' to
>     ensure ...
>
> Other than that, great improvement.
>
> Thanks.

Yep, that flows much better. Amended locally.

--=20
D. Ben Knoble
