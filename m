Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A419361668
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771333956; cv=pass; b=df1z1La260bNb0Oo0AUV3LMItMJSCwjtgpOoSNFDAFG6nGxoL3V1uJqFhhDgKQULoG0cbWfupQn27bPkuB6x1LMmwyTt84x825VprfvkJdOzl/7P+UI4Gh78LWjV8J1d/PyFRwTa7ZgmvcG8maUK95gxtHo9Dj12bUrvlmjbZvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771333956; c=relaxed/simple;
	bh=JAIM/Y+nim8z3hOy4wN2FhcOr+ytzmn6Sb3cvMco8S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRJ5kKFdJQ3gw3NcfjQRAmSdBaporJF+U2flPCArMT1xGUjUlWGD1UANEOsPaPiFXBwA0GdfAEqZven/5vXBBnqRzCo+s3s+ERjVusWpZCLPJz3ArN+7hB97Mq5I8sOhUFD7QJ8pNqLqVcoKwjPRqVBusVfDvtVQnPd/xHrzfZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbCwlwGL; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbCwlwGL"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-354a4ef0c1eso2440723a91.2
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 05:12:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771333954; cv=none;
        d=google.com; s=arc-20240605;
        b=gHdcOdarKue3QjhK1cNmIz+pXo3On44kvex+6u3KeYGLG2P0C5JR6/lBgOJjc/D7oJ
         SPeqRq+1aSszqhVq9hs+vzP5+ttvSDoYF63XppuNFywwHSpMy9AjGRvPhaq+uqQL3IEa
         9nA7vUITHtrPp5173u+oymnMUhgk3SdBXsbWlvOfKSxAHJyF0wjCyTAv5x0fKrAUMLa3
         GakK7JHiTw5vXbeyRbYORMPjCjpWNRtZb5TeeRC6dx9Zj8h68eNKE/sx54jabkKQUTID
         y3/MX8XZnuEtgOsHZ9wd8eDDIbL4gpwWh686XxURHYPqEn8b4L19pU1MZLOMF+DBrK6i
         WNKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TiIZ4upDgIWT2FOKFmODv0ftoVcFQsd3SmxeKHUIWdY=;
        fh=OLsKt0CEyd6vb/JqD3eGnckviA0qh7kFb/48PGFqG/s=;
        b=i+oCfUpCcsZitxRbYiHf39AI+VoqRGIDOMMvPLm2pg6rtJLQwmSspGA5qWG/MYhvqz
         RX1xBOdAfL0/x+c3jEzg075z28E3Dgwb3Ke+esqYprstnf/0VUnmtEj/FXa1LhN/JHBz
         p0kuugqbLh2GhCWl9C5GpMsAjSyqplm/MnQs9tHsHtBbXdYKC5gO+Vzv24tGqoFxqFBd
         N0eBQ8YCob4JdR/L/7OhBt/iVcNjvTt4ZSX2W9GTOj3Kw40HSsnTZQg6JlOi+Z3PUJD5
         1/4zXLrqwDyJbt2kl9uM+UMBKC582OK4lbK7cWA7m75nTBxlx7Ou5UXUM5+Kp926Foe6
         DylA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771333954; x=1771938754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiIZ4upDgIWT2FOKFmODv0ftoVcFQsd3SmxeKHUIWdY=;
        b=jbCwlwGL6s+Frut+AKXh5T7wHY1gRbpYfP01iziPXVKPU2isEtmCNt9+GAHCQK9eQy
         JJ0dKNbMSXClhUCy8NucGU6NB0iimsJJIA6iGVb9yhPy+t2Hx9y+pkziJwVkLLPON2ib
         8BukdmLo67OIx2oZKsku2B/ij+R+7cQfrFe8VhTVYmdr9l2J6ro9HDQxQ3NzMV2o/PU/
         usul74DSfq5L0zn7QKhY1+QXnhDgNPMlL2GmjWXT5OPNNUZy4G1Q33OTDUrs4dhotbdN
         TdVEuCPSF/pUtQHgm1AVhmB09xNme2f6CjzNPT+4JzVfrRqrJj3Ew+qcMNv+d/mnPOrZ
         ZGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771333954; x=1771938754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TiIZ4upDgIWT2FOKFmODv0ftoVcFQsd3SmxeKHUIWdY=;
        b=hBh/zRPj5ftBqWlYyjBarndu75MvqT7EVJJnY9A073yzu6lE+fCZL9iDZqWVi7XNqa
         ceEmogKv1+w5QZ2vupL/1KtDtjeFJLVzphG5oysLAEbQ+ihfZVGy8bkT3Sdvt0lcyoR/
         SuMvCt2LxJO2pCSOXrLeRv6pCRzblTxSankSko9xkQqpQD/LT2EtgqYIq+qiTrg/XImB
         RUCLjHsDw2NGJgzM+UYyl3wuEVrI7WgFFvFQhEZBN7IQBFXJW/d+qZPQ5A+wQp1JY1NB
         oKMTnUDqSuRxzVo5wIIx08ACs3ZExI/s/KLNzbEzOMVQJGHNSRm07Y6mNGO7QFA8p3m2
         5Qqw==
X-Forwarded-Encrypted: i=1; AJvYcCWgXPdgwagAGwkQBcbaMoIa7h3K5IoTJrRijDogn7Dhk+l37rbXPdG2RQA+5P20OzuUlAA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1nZlb9Zdw9LJQaIMgMxgKD8cfKo2jBvpYsI6sNGrMbI2V6SYn
	raoHzegBRF3MLpLtTR14iarmxYJTcgiiKw9amKAegQGrcy7nqlewaIhAZBYhgJOt26+OaiBzaW2
	HNriasiLnxASG6tfOHLV3ZEDbGbeTqlQ=
X-Gm-Gg: AZuq6aIffgevwPPZuzOPMNrnXlfwxlnEiDvDW1i22LdM2kCrIoPxdz8inRcc/lbfdvC
	HCzSeS7G+ONIYMcTDjmY34pKFc5JjXGRsZ3ZZ4J0h6QfVJ0WaxqYvP2Q70avFA1X6Yhc8CEterH
	6ejn34URy2TpjrFPpufEfQOk0np5JCMh1L5GWj4fkbRmfXvJ4xEzoqJqwnske9fbuktBZ6HakqH
	yzJtFKMv/Q+yTqp1uEn3Y8b+VNlkjd9TsgMVpI1M3qUcBWbgDtIBPjtFWY2+fThBoHx6zMtlf4n
	XJwi6CAbie2I73HuSswXeDsE/59Slmmf5a8nOBuiumJF8cvPv0bCBpIuABQdGey8cQvoBIIA2Z4
	1DfRsSotEgXWbUHRm/B3Kcikrx23vVkv/7Ct2
X-Received: by 2002:a17:90b:33c1:b0:356:2872:9c50 with SMTP id
 98e67ed59e1d1-356aadb1125mr10776185a91.35.1771333953652; Tue, 17 Feb 2026
 05:12:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2046.git.1770746461307.gitgitgadget@gmail.com>
 <pull.2046.v2.git.1770775169908.gitgitgadget@gmail.com> <xmqqms1fwasx.fsf@gitster.g>
 <CAOTNsDz0ZtdsM8Z2NW0WBMGs8xyWz5ROS6pf8DKQAx26LU4xRA@mail.gmail.com>
 <CALnO6CARu8HSYh9=z6FAF=84q1qA4Oan7_DLMbcK+1rth8B7cA@mail.gmail.com>
 <CAOTNsDwMeszCC6wunkkx_vhKYx9OvRWXB4VxedypOTQJ6Qs2sA@mail.gmail.com> <CALnO6CCYorpEzmZwLrb7O-ucKLTOCLp6zXxZr0Qv73tOBqKKig@mail.gmail.com>
In-Reply-To: <CALnO6CCYorpEzmZwLrb7O-ucKLTOCLp6zXxZr0Qv73tOBqKKig@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 17 Feb 2026 08:12:21 -0500
X-Gm-Features: AaiRm51qV-JwSujYg9MRxP4lQSnezL0cAcmClWMJgkGWZMNWgWFgGVm3DL_yBUM
Message-ID: <CALnO6CCys8hDtSe4=gFjaz7x410TH-7LFGRs0UU5e7XCSWuOQQ@mail.gmail.com>
Subject: Re: [PATCH v2] osxkeychain: define build targets in the top-level Makefile.
To: Koji Nakamaru <koji.nakamaru@gree.net>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 8:10=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> On Mon, Feb 16, 2026 at 8:09=E2=80=AFPM Koji Nakamaru <koji.nakamaru@gree=
.net> wrote:
> >
> > On Tue, Feb 17, 2026 at 8:45=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail=
.com> wrote:
> > > ...
> > >
> > > Homebrew picked this patch on top of 2.53.0, and on a recent build on
> > > older macOS I needed to
> > >
> > >     mkdir contrib/credential/osxkeychain/.depend
> > >
> > > in order to make their build work, since otherwise:
> > >
> > >     error: error opening
> > > 'contrib/credential/osxkeychain/.depend/git-credential-osxkeychain.o.=
d':
> > > No such file or directory
> > >     1 error generated.
> > >     make[1]: ***
> > > [contrib/credential/osxkeychain/git-credential-osxkeychain.o] Error 1
> >
> > I tried to reproduce this using the current Homebrew formula for git [1=
]
> > on macOS 15.7.4 and 14.8.4 (both relatively newer) with the following
> > steps:
> >
> >   brew tap --force homebrew/core
> >   cd "$(brew --repository homebrew/core)"
> >   git checkout -B main origin/main
> >   git pull
> >   HOMEBREW_NO_INSTALL_FROM_API=3D1 brew reinstall --build-from-source g=
it
> >
> > In my environment, the build finished successfully. The patch doesn't
> > seem to trigger any issues during a local "make" either. How exactly ar=
e
> > you performing your build?
> >
> > [1] https://github.com/Homebrew/homebrew-core/blob/9ec3da0dcd3ccd1cd4d8=
92a71377b251770212d7/Formula/g/git.rb
>
> macOS 12.7.6 ;) hence tier 3 Homebrew support + all packages build
> from source. So just
>
>     brew upgrade git
>
> built 2.53.0 + patches from source. "brew --version" says I have
> "Homebrew 5.0.14-59-g45db1ce"; it doesn't print a homebrew-core line,
> so I'm not sure off-hand if that includes the core tap version or not
> anymore.

To rule out differing versions, I also diff'd the Homebrew formula
from GitHub against "brew edit git", and the only difference is the
bottle stanza on GitHub.

> I ended up having to use `brew upgrade --debug git`, fix the build
> error ("mkdir =E2=80=A6") and manually perform a few steps when it arose,=
 etc.

--=20
D. Ben Knoble
