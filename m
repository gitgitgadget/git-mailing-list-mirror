Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDE278276
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 04:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728275904; cv=none; b=oW/oxVrdcvmPmqXWPU5Eobt3TyhYOP8ADqxFNBzyKH+kSMZmkjvylhPQcvMNsdHflBIjOLk6d33On+xPDg41ZslzqmcGfF3Ywf065NEF4KJUFRERcTW3FvoQfus9LEr72oX9zO2NARgOfbzDT8lTnFDT6hZwBItdlPd0K8c/o6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728275904; c=relaxed/simple;
	bh=9BRZ/0teZdbjHgki7N4wC3HCWhz7K8E8h8IQXm22+Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjXEp0owSL1ZgWB3kiCYa0sw2ktiPPq/WM3cI0prxpMIUhay6jOAWXKcj3t0jrwbmh0Ikl0vWjHwn/g+HnNF6h4ShCTM0wLe1SB2GQKC2joqhz9JAc077S6jQafSIZFFoYl7nuSH8P6N2HmreNT4rSgXamigyonmJouRULjlb/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-458361c7d81so6362291cf.3
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 21:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728275901; x=1728880701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2V1vlq1AP0Hi3J0SrNmF7CEKwTyvMjn8Xk8R0qn8zK8=;
        b=BlNS6dNodq8cINV4OEljznB+Je5nLx6+eI1vWeJCg47NLFqy815aWWPfACkzfO1dQe
         9+nTgFM+iemaO8ZjbXGsW31Rp0qVEYX46AK4eL0gKbAWBuWIVcGOKDs4Z5nQrYXNBPIn
         JDW1zGo6sfxl2ijriixxrm13ls8ufgvhrI/KYN2r96Dxsj2SuoRwFQOvca+I8r5ik3mY
         SIhlxYDWj3F0znBRV/4/QrNljnS3RVjxIvYfnQ2+eHb4LHoVOYKUtfl7e9Q7gKxdwtQ0
         Xkw61pMWWRf2vfMmecGZULWSAPa7a8u4lGFRYbfGxv82znL7SfvXnTB1fuj0xseac0DG
         SKCA==
X-Gm-Message-State: AOJu0YxezpUOQVWkAY5tZyuGNYtYSDBjmhjzqveqn8pchxfVnQu54hxO
	i7+XzngldACkpjdxoKo8iBMVhITD4uZ9OwdRPCezufdbelIo6Inz3tLb4IRbYzaxiCJeFD0zDOZ
	8EDeYGbls9oSt+cWdphiJt7Ycthg=
X-Google-Smtp-Source: AGHT+IHAxC1H+Kxb5kW71OF4+wiPsZwHBSVJmeWbCeMkLXu9pQrV0fuWyrDhqKigVIrG3gYnsNRmHmPJN7t8G1j+fZY=
X-Received: by 2002:a05:6214:262a:b0:6c3:5c78:ee9e with SMTP id
 6a1803df08f44-6cb9a4751d8mr79370916d6.9.1728275901141; Sun, 06 Oct 2024
 21:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com> <37b1411ee2c420f1a8578d27a2f7d54ccd3f329f.1728230769.git.gitgitgadget@gmail.com>
In-Reply-To: <37b1411ee2c420f1a8578d27a2f7d54ccd3f329f.1728230769.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 7 Oct 2024 00:38:10 -0400
Message-ID: <CAPig+cR7w-ZgkN8qDe+_zy_WJi6puoLVk9Wk+9TRuzW_-dAA=A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] [Outreachy][Patch v1] t3404: employing
 test_line_count() to replace test
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>, shejialuo <shejialuo@gmail.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 12:06=E2=80=AFPM Usman Akinyemi via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Refactor t3404 to replace instances of `test` with `test_line_count()`
> for checking line counts. This improves readability and aligns with Git's
> current test practices.
>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.s=
h
> @@ -281,7 +281,8 @@ test_expect_success 'stop on conflicting pick' '
> -       test 4 =3D $(grep -v "^#" < .git/rebase-merge/done | wc -l) &&
> +       grep -v "^#" < .git/rebase-merge/done > actual &&
> +       test_line_count =3D 4 actual &&

Thanks. Both patches in this series look fine.

Let's consider this a successfully-completed microproject.
