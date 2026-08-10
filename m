Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEDB3A8722
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367291; cv=pass; b=E5VVOD0d7te4407is+l0xT8uzsqldkPa0Ips0mHUrlP+T2vwxVQdQy+Fqbl67uNfmnl4CxCe/ZU7CCLZiRVLVFtu11I4j1F2PVMoYf7v6V2ZvBZr6AzNWLmcfrxLwkJem/9lx/RWHGFnzmtmqvlWZ8ySy5lnzVjiC0yldCSeffs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367291; c=relaxed/simple;
	bh=2NtZVAOHDbiKKOXUghGyW83Ps7YIvjQrnetW5nA8Ig0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omn+IskU3ZOjuOdL8MG8f8BTvhyJ/761bbORBQFP3N8ZqAJ1xvIsb6rJBDHm1e7k9SidxktY2ylshFNfm5jzPz1ftt9MmONJk7TBoXJDcqWMiLcojXriDxFRh7E8WsrjHULBZq8wFhRo1iG12KJeb7tvQWtJW4ouR7aj0ByNT34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCR6wKa8; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCR6wKa8"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so1982794a91.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 06:08:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786367290; cv=none;
        d=google.com; s=arc-20260327;
        b=WJkdqxxRt27z/e8XBH6sbGuziiKIj/386GE0g61jjwXBSTHsxBp1Skt6VsnaGTf5L+
         AdlRxTXCiHOBqcSYf8kwE19LVbepzEQGD6ellWSsu9D3VQUtnyrR1kaJ7efRTeEIOWfj
         3SKZNi1h95CQWlj8mYTuxPNZwiP6TlF4Bz5lt4yi3rC2MEbOk3eUutNnHHvMvVXaLyrO
         oOagWrqGYpxJUCOJstbvRbEOLdLl42+HSDY90qMl1jRNou5P1OClUmFkbHR85x4O1+Ki
         xp1YYHkSsQ1wnHSy+eQQLJLNdAFu1BHo7/tWOfuzeMe8jkArHCXmpVypeNYI6KB3Zn7L
         Xp/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ykY5nxyc3zVITOzubRQE6LzPp2+Jfu+Cfk3kHJP9/AQ=;
        fh=GSIW2gQmy4n7ssjEGJL4D066cv47dR5bl0yoQvPJYj8=;
        b=XF/cLDg8WuG4WvGQC9j2OEeMJh5KXz9GlL6sdYck0kUsZxcTE3wwe8uQYre8OyPgwG
         hEy2yE2Mif3toC/GfGAaybDFOzOqu4q5Fv5i1Eng18nnqOR9ZzMnYc5yDSSbc691KJHy
         G4hJMfzvUY2EpMKh2DUvjU6ibC+kwm5APr/iBVbnFlS6skhVHvuj/omVsXt+/6jwbUkv
         iMUixMEgZzkTErLaN7W2TmPKTUMuWy2+FtfIX0ON3f9haoGwPyVjIfghvj7BbaxcWYuI
         Z9TnEuesYwcj5XKSsxm8gsuoIof8cFXRtlfDUGicr8EJoS3x8oyN5RNEBJokzBynVhn3
         zrZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786367290; x=1786972090; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ykY5nxyc3zVITOzubRQE6LzPp2+Jfu+Cfk3kHJP9/AQ=;
        b=lCR6wKa8NQohxksHDZOin0hZKUIIRnDJ7Wakt0rBG0x+SJe1G/YSE12HwzC3oybYTm
         Ubi+JpEnj3pZw58f9cS28DQVxtgiULl/yPAvw4OaCgn5BLWVE40Hs+hHMHSd73t3gb1p
         fstknMIhZ9EY2ijJjepMZcuT1ZPEvaRTIre9nZ1PgyjIY1e5A3ELMty3dGli/fFSunGk
         2u5crbdwg9uL/lxST9v6cNrBBncd0Ui2Cwtd9phzYycsdSmia5Uulvs4rPp7k4mh9/PL
         0dHf3vx4V6rxM5Qjz/eZNsE9Xw7l+jHxwqcsdufOPN7R0H7WH8JV9Wikyd+UMgrpZY3R
         eFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367290; x=1786972090;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ykY5nxyc3zVITOzubRQE6LzPp2+Jfu+Cfk3kHJP9/AQ=;
        b=CIEvdczsbbzgmqV319I7E1YAEmk5C+bYrdjsWKWLGpbgmprRvQy6R9HYzpnpxWLcK4
         p1JnszRrNjdqK6Brtjjg1SmFCPaqT3QnIyVoEMOvQ81S1bPf1wht5dIOoaOwPviXwZKy
         UwgTcu8MrJr9ZwupmgHizHU1d2yOA4pK4G15my2Nuh4johwTknKAOJ5rIwDk5lwriigc
         rJO10WGaEdLNSSVasaKo6L+dRb0FCu+8oe7wsou4Gwd2XSE+PngpW1g4o/ZrlEopoUtU
         ENmpAMMYfyw0ZdBRowjCeaZQ6F8aZ4KUdbDfbr8izgfzhzVFfdZuAhv96/OuO/8DhVT1
         h1XQ==
X-Gm-Message-State: AOJu0YwJeaMAzmDXLDedQtEV7IBDBrqcLEFd82fGWy6fP4SBlgXmVP0d
	MkxB2vqmXaK3vL5mYMAhdjkPeHlufE5bhJmTqGBt9CuZfkblN81ZzHSRoXnYJbsJo+L110MoJEO
	e+4UeRKdClkFKHejaj+x/5ho+ujZovKI=
X-Gm-Gg: AR+sD12+8alxCHSg4eJgoJdOKUOVLEnO6RK76gj+49Ajdqj3CgE3oXcBMyrL90L4yhq
	9lyQd2Qin6cO400ihhLI3Hvbl90XSyP7IIyVUTlqVkPGAwSxgITgTi5/5AWn6PtPJYy/1Wmc4sA
	89NB03ogYpVH0VXcg26l9HKwFMTuwglmXmLnWv0Yb2IhVh6Yfm7PzSyynf/ebq9eCDm/Es80Rn1
	bfxh8PxmRZDZv7WrGMsbRPEv0u3QJeT2iYxib5An3EPvoH7oJkb7avYE6YmNYyjFMec6LCyl5B4
	wMLlOCOwTdBLdlMOUtPoGZ2I8c9G02U0X8pS8BnQOtFSgaxO9aEbtBPGALEExj3GjtoUEdLlz61
	+HgxcwObuwXALbHewDASmtt/fxQd70vezP8ZEkxl7NHwGjpt+MOZTMAhLXgQcoRQsCJYOUb40MI
	ztZidHyZmPzYUnZZp9iv4=
X-Received: by 2002:a17:90b:578f:b0:38e:6a30:4bbc with SMTP id
 98e67ed59e1d1-392ccad6e4emr1460861a91.21.1786367289598; Mon, 10 Aug 2026
 06:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 10 Aug 2026 09:07:57 -0400
X-Gm-Features: AUfX_mwVulz_IrhkKFJnqHzij-C4KA6pYDy_8R5B8BkamAnMXvnnW3IqqrjNVkU
Message-ID: <CALnO6CAdr0ft8KFgGCFX9ueKUdX9-2DwB+SNs3Q8ykw4ne=54Q@mail.gmail.com>
Subject: Re: [PATCH] worktree add: improve message for ambiguous remote branch name
To: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yoichi,

On Sat, Aug 8, 2026 at 4:21=E2=80=AFAM Yoichi NAKAYAMA via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
>
> Display a descriptive message when DWIM fails.
>
> Add advice on how to work around this by specifying the fully
> qualified name or by setting checkout.defaultRemote.
>
> Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
> ---

[snip]

> -static char *dwim_branch(const char *path, char **new_branch)
> +static char *dwim_branch(const struct add_opts *opts, const char *path, =
char **new_branch)
>  {
>         int n;
>         int branch_exists;
> @@ -781,8 +791,14 @@ static char *dwim_branch(const char *path, char **ne=
w_branch)
>
>         *new_branch =3D branchname;
>         if (guess_remote) {
> +               int num_matches =3D 0;
>                 struct object_id oid;
> -               char *remote =3D unique_tracking_name(*new_branch, &oid, =
NULL);
> +               char *remote =3D unique_tracking_name(*new_branch, &oid, =
&num_matches);
> +               if (!opts->quiet && !remote && num_matches > 1) {
> +                       if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMO=
TE_BRANCH_NAME))
> +                               advise(_(message_advice_ambiguous_remote_=
tracking_branch));
> +                       warning(_("'%s' matched multiple (%d) remote trac=
king branches\n"), branchname, num_matches);
> +               }
>                 return remote;
>         }
>         return NULL;

I suppose the extra warning won't hurt anyone's workflow :) so that's good.

[snip]

> @@ -904,10 +920,16 @@ static int add(int ac, const char **av, const char =
*prefix,
>
>                 commit =3D lookup_commit_reference_by_name(branch);
>                 if (!commit) {
> -                       remote =3D unique_tracking_name(branch, &oid, NUL=
L);
> +                       int num_matches =3D 0;
> +                       remote =3D unique_tracking_name(branch, &oid, &nu=
m_matches);
>                         if (remote) {
>                                 new_branch =3D branch;
>                                 branch =3D new_branch_to_free =3D remote;
> +                       } else if (num_matches > 1) {
> +                               if (!opts.quiet && advice_enabled(ADVICE_=
CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME)) {
> +                                       advise(_(message_advice_ambiguous=
_remote_tracking_branch));
> +                               }
> +                               die(_("'%s' matched multiple (%d) remote =
tracking branches"), branch, num_matches);
>                         }
>                 }

We would now die() here where we didn't before. I'm not suggesting
that is wrong (I haven't given it much thought), but I was surprised
to see it in the code without mention in the message, which I've left
quoted above. In particular, the proposed log message talks about
giving new advice, so I wasn't expecting us to abort.

Now, it may be that this case already causes an error later on (I
haven't analyzed that), in which case dying early with a better
diagnostic is definitely helpful. If that's the case, it would be nice
to spell that out for the rest of us :)

If not, I would want to know why we can die() here without bothering
anyone's workflow that is expecting us to carry on.

Thanks!

--=20
D. Ben Knoble
