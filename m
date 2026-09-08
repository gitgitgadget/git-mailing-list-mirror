Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EEE2D3727
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788886947; cv=pass; b=p3+Fv4IM1GwGMOQARu8/hEjeoUNkzsEmKLY8zUVMATzj4randyh4JqEFd6InBcM6U6es8XxF47gHWjnpTbw6NotNFsKvv89g09MsR9nE5RWVeXeRiR9v16uz3o3TPD0s15APdfzgDuGRbDK/hiSbcccPIug5aodKq3CU0h3iyVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788886947; c=relaxed/simple;
	bh=cE8bi38q0bgL8QtikTwv8T6/mFLMalxG8otY6CHtL08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=id6p3+mNnTH7Sz8dVozd7f+lyO60nFzcKMpl6PYJ4uCrnUugB8LfcItQd53PzLX7Bq+BpZYh+GfVw4sfR2DQibe/l6r5kp9NRtG3BNF/bCG7mF2MsDkCYtcixkysMEeQwWem5o0o6XiFTv5HBb3WELz+sq/+RhXvnjPIkMPeEIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U91ID4kt; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U91ID4kt"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6b35cc0a8c3so3930406eaf.0
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 10:02:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788886944; cv=none;
        d=google.com; s=arc-20260327;
        b=FXw6olm/7sSHx7LPc1/ISRyGY3cjkxTj1S/yFS6Nveico6PT4tR4nRHAE0TMrZ2rhF
         9Hu5jjhekiVmPuYT8p4yGEFgB9YpZDSFKnKNoYsniwnVmvYz+1f0WkQaohMSTmzfm+pd
         j2PM3iAMILxAvdfEMpJ4YFGEJjRr7PbMMnSIApnYawCD9RGKzkN9sO6AJaV40sT9Voud
         6NJEYVnlZok1VZxU74TfnIdbXu6Ckkz9MfZn/Ut0ZcMRleK6ZheTn/kszcHIOgaQXbsO
         yDZyzlR7D9ysS97aEcHczttBxp5TeVfmoC1SLMVXH5jSm7Ps2c9JQ6BHQMW+VnhvmHMD
         sVFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ZFPH9pH3SXW/FToLKS+vBNK0lj5MStra9TcfIqvmLw=;
        fh=5nZn0HRpP9ZszniLRQU6Iy8lvPX91CYXGnNouZ7Jmpo=;
        b=TMVmpUNhxn1SBvyAl05f2So7yhpEzUWKH988f09kETduAb8PpC2q9plzmjVgXiAonW
         ae74YdAI2gZ6Z9G0JptHVqt3sLF4au5qr/oYhvvHvLZ4QvwyrJZWYRtPMThMSwthuW/w
         JkC3OWKwhBxbpQe0eNu9Vh1NspBS/I+1WnvUxq2BftzpiV20cSvJfbvobZf0x8dyp0D+
         Eq0GIUNTn8Stso1grdQGGxp5O9gPKd+IDWTSI63xCcc+fu1ogWLC8yaFjLzSiyRh9cca
         RWkkIO0PYSldqe6ux0/OR9EFetJs8SFJJRJWJrZHxCr+XIRu+iBDLbUo8saK95o8Maae
         xHAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788886944; x=1789491744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ZFPH9pH3SXW/FToLKS+vBNK0lj5MStra9TcfIqvmLw=;
        b=U91ID4ktpxYx2RO2DD4v1s+EnfEseXTyRsyok4Ied9E2a70I/TTmqflSnswW8vg2Bo
         WLs0JL1VYkIs3OlyRlnIfpeUMlcofjbUo02Dd2kRazvq//eREk+5dyipbqb5yXOisfK+
         znScYb/KPIsO4Tc8vIumvei7PajqB0kYdbCq7Bcv6NOqX9zbWNMJ3WxZ0GKqPGryqSyX
         ApEf73cEfW4zlIdt4DXHBIkRo9nx/yZL1HnxTUfyHC6H95tTtY1sPYV8xda7IzBlTJQl
         OqJtxeh9H1NrjaAtRcKails4hGD6hpocht1VsE5hxTkrX9PTeuTG9Rla0aAcgs5TT0pW
         aIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788886944; x=1789491744;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ZFPH9pH3SXW/FToLKS+vBNK0lj5MStra9TcfIqvmLw=;
        b=PCAcRFgjPh1UhcAPyWWKtMhvE6HCbYsz4OaW2HooRGEJogaLUVm2/gnID9lifUwMJS
         u1Q+4Nq15bu9nt1z6CZemjn3aaGoLvNf7XDNRugtwzw1JV3XeYLosa24YcinJQcJhQ16
         jnl1MhJzkcYBlRMmIuEunBfF6tW/Bjm+yiBnKqc2Q406mHOAIdgv0HulR55FFrtFLgOF
         Hf4EWUaIuMO5QcJd416WsGP6MZ/0Ugin3dB1Jiaw+supAcTD1Nt9AlkVgitsovhaJrVo
         M46vBAPgGlRAEKfuLh64oF47lzYF1ZuVhEJ9M1rjopbOHpFU8NB6KZ0Pbzjws9rnK5zt
         GkwQ==
X-Gm-Message-State: AFuF++k6xFBZ4DjwXJGMzKYNMl/+w9UqFtVeYzlf5OosefOoMiDTHpXV
	UjJPPor9vwcCjAMVcaUe745pA1z+Dc+HUjdbJwAR/5haubcLWAzd2E2AiUgiqX+X/STVr9sDJjV
	CwmfkWpwMODQEDS6Cf7hcO/yFKk/SgeE=
X-Gm-Gg: AYBFou2VEMjClYW8dTvK5AVb2UmAQf5zyU0XgTuLEyzpayeZ4jK56m76D8ZBTVCaZMV
	Sz1zXEG7KTOQE2/aXcKEIVHcoVYEmLxyqz9T7tTA3LgElg2bj/isTO/DfvC2HE/YxAhq6pEcAat
	JN/3HJ6G7FwuZt6jy+K4XewdHskl5IvVAhlUFIh6DnXP4k+9Mlev8lrcsFab2clh8PTaAf4G7bG
	/PU9bdXS5MIKjUuCTsR/0RQkTAuABn0Jkl+q+f4ju5lGIobIgTsr+0ebwmiGWElamiXJY+5ji5m
	ktiSG1C3x9ah6HY96BuDpal/eHP7ydWuxw0R5QItYtqzLWn2uPmOQ6dpCaLRYdEk6lgcFIuPetm
	wm5S49BmRcL17aWDPaA5aG9/AYxpbfoQugTS30kRqdgveSZmKmIrj7cOXFa2/xq+1XIu1K3NuJI
	2GEWqYCgBry3EtrOUznRkcZTT5skhI
X-Received: by 2002:a05:6820:16a3:b0:6b0:d7aa:5c18 with SMTP id
 006d021491bc7-6b6fdbbf6acmr16631658eaf.29.1788886943629; Tue, 08 Sep 2026
 10:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807135511.1818458-1-christian.couder@gmail.com>
 <20260813154748.2378747-6-christian.couder@gmail.com> <xmqq1pc0mr5i.fsf@gitster.g>
In-Reply-To: <xmqq1pc0mr5i.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 8 Sep 2026 19:02:12 +0200
X-Gm-Features: AcwNN1Ua1krZqj4tJ3wtxGyKPBTG1JV5q6jfsuESgMr-y8dQHA2ayzF2nTR9pAc
Message-ID: <CAP8UFD07ssLAAsc_00W3Q=vzPXry-=nK-mO66_eoHxEGTEYAgw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] builtin/upload-pack: set GIT_NO_LAZY_FETCH to 0 on
 trusted repo
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 9:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> To somebody who designed this mechanism, it may have been clear that
> you are talking about multi-valued configuration variable, i.e.,
>
>         [uploadpack]
>                 lazyFetchTrusted =3D repo1
>                 lazyFetchTrusted =3D repo2
>                 ...
>                 lazyFetchTrusted =3D repoN
>
> but the "config entries specify repositories" can be misread to mean
>
>         [uploadpack]
>                 lazyFetchTrusted =3D repo1 repo2 ... repoN
>
> especially combined with the use of verb "list" in "Listing a
> repository here tells..." we see below.
>
>         A multi-valued configuration variable, each of which names a
>         repository that `upload-pack` is allowed to ...
>
> or something, perhaps.  Say that upfront to make sure readers won't
> waste their time wondering what the syntax is.

I have used that in the v3 I just sent.

> Also, how would one specify a repository?  A URL?  Remote nickname
> used in
>
>         [remote "nick"] url =3D ...
>
> configuration?  Local directory that houses another repository?
> Something else?

The v3 has improved regarding this as I think it makes it clearer that
repos are identified by having their git dir, or a parent directory of
it, in this config variable.

> > +     allowed to lazily fetch missing objects for. By default,
> > +     `upload-pack` refuses to lazily fetch (see the description of the
> > +     `GIT_NO_LAZY_FETCH` environment variable in
> > +     linkgit:git-upload-pack[1]), because doing so would run `git fetc=
h`,
> > +     which may execute arbitrary commands specified in the configurati=
on
> > +     and hooks of the served repository. Listing a repository here tel=
ls
> > +     `upload-pack` that it is trusted, so lazy fetching from the promi=
sor
> > +     remotes configured in it is allowed. This is equivalent to settin=
g
> > +     `GIT_NO_LAZY_FETCH` to `0` for the matching repositories. An
> > +     explicitly set `GIT_NO_LAZY_FETCH` takes precedence over this
> > +     setting.
>
> It would be interesting to set it to point at itself.  A client asks
> you to serve a pack, you find some objects you yourself do not have
> because you fetched lazily from the upstream, and you end up asking
> you if you have that object (U+1F61B Face with Stuck-Out Tongue =F0=9F=98=
=9B).

Actually it happens that it could recursively lazy fetch in v2, but
this has been fixed with a new patch and a few tests in v3. Thanks for
the suggestion.

> > +Note that this allows lazy fetching from any promisor remote
> > +configured in the served repository, not only from the promisor
> > +remotes that the client accepted using the "promisor-remote" protocol
> > +v2 capability (see linkgit:gitprotocol-v2[5]). The served repository
> > +is trusted as a whole, including its configuration, so the promisor
> > +remotes it configures are trusted too. It is the server operator's
> > +responsibility to make sure that the promisor remotes of a trusted
> > +repository are also trustworthy.
> > ++
> > +This is a multi-valued setting, i.e. you can add more than one
> > +repository via `git config (--global|--system) --add`. To reset the
> > +list of trusted repositories (e.g. to override any such repositories
> > +specified in the system config), add a `uploadpack.lazyFetchTrusted`
>
> a -> an before `uploadpack.lazyFetchTrusted`.

Fixed in v3.

Thanks.
