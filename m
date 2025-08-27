Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19213093BD
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 20:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756328092; cv=none; b=thsJcCCM7DI74eO6odyUMsyuAWo2Qh0NR81xhTAQNKyeESKkHGov6plXuLRXJeKS7KDox7ZoBfkcQyfJrEGzQVA/YP/6jsig0UOu2sgmL+avplb8lBAeBC6gt6iHOa17buLxvoV6jBeRDWk+yT9WpiHWl0ghZ7MSoG04TCJHVVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756328092; c=relaxed/simple;
	bh=rHt4zQ2uefoKN0ZA19QTp36K4CbbaPGcqDAzz18k7Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6v1x3Q4TiDWNKpd7Tc/4gIAODQjnn2eYwTKB7nmetoarRM54XJMgrjrhKF1PCQu5pRs0IyfKVl3Xel7JEGQao11Aa2IHBJEm3ZiI4J1tU0oM5PLWcFRBShhlD3LBos5BKojCI5FCpC/l6uzap/VKzf0PaS/k8jQmEAWAPHW8p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70daf27a54bso535246d6.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 13:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756328090; x=1756932890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gjr2vgkmpfXVpbYxVKwlOQnslDpbpZVee+muGDROfpQ=;
        b=n9QggnuqtI9c58oQtq3XVbwJn+X6PnEK4Ost6wfVjhYEhq6Lq1F969M+TQmz4muQr9
         3HzZgOEYtMTfk6HRVka5plD+LAOsu9jdSUVvEhkvM7Gm3/RNfUiX48WjO5hUMeTagiy/
         yOaykCIRFyx/l0acRUress+1gcBnA8jVCAZA2tMEjloRzXiZescq6Vvwu6V6mwqEcaRr
         toCqOxcrAQCz2+fW8tGqr7tCeiS/EaXyT0AJxQ449194fRd1eQ+hc1uz4Hlg3hptw4/d
         0FV/9y/rlW/lA8LhnzHLWqwYz17pyre7640UiRNU46MF1mz/wF1GKHc6uxEnjRiynkzY
         +ieg==
X-Gm-Message-State: AOJu0Yw1ZC+D577FIFXCZ45Pa6TMWic+P2PZ0vJkBkKYJ5hQ2/HQ8hWg
	Hk/wXe904cRbCHwSZc7EKZn7GETKn31uqsJNsqyFcKUcLgYDc358PUg93jnbZp4+m3/Tww1htI7
	szWD/9QPKC9DZYUTm/UvEIl6unskFBNG+asce
X-Gm-Gg: ASbGncug65vXq3HtmOKTRadhpoA8ggeKYAVJQJ3EZ12Cyg12UnY0Z+1htkZXKxiApke
	x2pcrwQJIJMsrqoakDIuMei500WdnbLEuJnO9hc268WbWnzZwfSG1BidVfDGusRtJt97pfhKNmh
	DJg/CuGd/U0FsbMcA5akCnryWtNPS6PrYFt+INxa0J6gpGPYda33+KHbPsbmbL5WG6YriewI/TQ
	FGjhfdaYE+HvGYc33GMGpzg+rMa3UairaKiec3U
X-Google-Smtp-Source: AGHT+IHH6rjT5nJ9kCXp2ssqd/9IELB4Fxbj0LB7ebLoFH9Y63Ak/xS+VYoNHUf4LxfWjhZI2tpGqK/5g0L6m3U9feM=
X-Received: by 2002:a05:6214:c81:b0:70d:d6ea:b89e with SMTP id
 6a1803df08f44-70dd6eab977mr49549356d6.6.1756328089562; Wed, 27 Aug 2025
 13:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822084910.98308-1-ayushoffinfo17@gmail.com> <CABV7AFFLF6SJEk92Kr9x9z2sOk5nZ7Q0gx=GKR+-JNxSkju=RA@mail.gmail.com>
In-Reply-To: <CABV7AFFLF6SJEk92Kr9x9z2sOk5nZ7Q0gx=GKR+-JNxSkju=RA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 27 Aug 2025 16:54:38 -0400
X-Gm-Features: Ac12FXw1ivRJrs1l-AkGingzsaZDgqylUzgOSyex80kJPPTazAB6jItL_CICgMc
Message-ID: <CAPig+cQ8whwjyuLkUgnxrr4U2F9zm3vitL3gwopniTNXRUqtHA@mail.gmail.com>
Subject: Re: [PATCH] config: add "hostname" condition to includeIf
To: Ayush Sharma <ayushoffinfo17@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 9:53=E2=80=AFAM Ayush Sharma <ayushoffinfo17@gmail.=
com> wrote:
> On Fri, Aug 22, 2025 at 2:19=E2=80=AFPM monarch <ayushoffinfo17@gmail.com=
> wrote:
> > Teach "includeIf" to include configuration based on the machine's hostn=
ame,
> > as returned by gethostname(2).
> >
> > Example:
> >     [includeIf "hostname:work-laptop"]
> >         path =3D ~/.gitconfig.work
> >     [includeIf "hostname:home-pc"]
> >         path =3D ~/.gitconfig.home
> >
> > This allows users to write host-specific configuration without separate=
 branches.
> >
> > Signed-off-by: monarch <ayushoffinfo17@gmail.com>
> > ---
> > +static int include_by_hostname(const char *cond, size_t cond_len)
> > +{
> > +    char actual_hostname[1024];
> > +    struct strbuf target_hostname =3D STRBUF_INIT;
> > +    int ret =3D 0;
> > +
> > +    // Make sure the call to gethostname is correct and its return val=
ue is checked.
> > +    if (gethostname(actual_hostname, sizeof(actual_hostname)) !=3D 0)
> > +        return 0; // If it fails, the condition is false.
> > +
> > +    strbuf_add(&target_hostname, cond, cond_len);
> > +
> > +    // The core of the logic: strcmp returns 0 when strings are equal.
> > +    if (strcmp(actual_hostname, target_hostname.buf) =3D=3D 0)
> > +        ret =3D 1; // Success, the hostnames match!
> > +
> > +    strbuf_release(&target_hostname);
> > +    return ret;
> > +}
>
> Just a gentle ping to see if there is any feedback on this patch.

You can increase the likelihood of feedback by:

* Studying the related email thread pointed out by Junio in his
response[1] to your initial inquiry, and taking all the open
discussion points into consideration and providing answers for them in
your proposed submission. (For instance, one of the open discussion
points[2] was how a user would know the exact hostname to use with
`includeIf [hostname "..."]`; a solution needs to be provided in order
to move forward with the proposal.)

* Including with your patch the necessary documentation update (so
users will be able to discover this new capability), as well as new
tests.

* Studying Documentation/CodingGuidelines (for instance, this project
uses `/*...*/` comments, not `//`), and
Documentation/SubmittingPatches (for instance, avoid changes, such as
inserting unnecessary blank lines or arbitrarily reformatting code,
unrelated to the purpose of your patch; use your proper name in the
Signed-off-by: footer).

* Consult the Git source code to see whether there is a better way to
obtain the hostname than rolling your own (for instance, don't fall
prey to gethostname() potentially omitting the terminating NUL from
the buffer; instead use xgethostname() from Git's wrapper.c).

[1]: https://lore.kernel.org/git/xmqqqzx8k258.fsf@gitster.g/
[2]: https://lore.kernel.org/git/CAPig+cT4fpX7Kczu0+H5TZnmpVqqq0h8nBafj4UqD=
s7Xv2Nf4A@mail.gmail.com/
