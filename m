Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D502DCC17
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490609; cv=none; b=SkB4xjkXYHghGRM5llXZciCSxNdDZZRqFt1KMpt/QZW0cF5Y3UzmEymNfiYcPgCB5FDwPlUoLEz21U8fF5qFZgy1iODiAkeitTs5upZ2jck1kO+6dhdT/JqWprP7yxucejpY5NGpQRcttTISmAO/cCJru4CMcO0DD/+prptmvcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490609; c=relaxed/simple;
	bh=43DULxbwwYAKGwqk73tCt7PiX5pYIxNtY6X5hpttt6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Is3yfeGjV+yhT4KYx44ixN2WWRzfrZRDWy0VWSq0AnzQubc7XSce/EEoRv1KZ66V4uAv5B3A2kNVuyEnGRbvc0tP1E/ydN0JEMpOU5AzLjk4E/MJuOTIUDiSLZtrY6x4C0abuTFg/wyCH0CqI3Mgc7d+FzewIBox9slkZ+EF0NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftCUf5x6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftCUf5x6"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b737c6c13e1so615029966b.3
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 10:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763490604; x=1764095404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7T5v5N5NQ2Sx3O5mcT4P+cLePaUpB1NmqaoT7ZF4wU=;
        b=ftCUf5x6IYMw+f9F/Dv4hzaZ+f8ysDZSmFMnOuFOrXwn5iIxgqqL1nzjUOK20bKtg5
         LkoikGL3guk/N+TwLCDhCl8ojvYeav57RzIZPApeZWgwggT+p3rS8JV8iS8NdShIfZj9
         J5gYcpQsAlTqhmqU86lO+lxVzDPE3gcfv3RZqeYrenZ4SW7ipyvBSmBSvH6qADNkaDKI
         Gx660O5OxxEEocScYLTIUZbGiIUUHtO6U1gTFs1CfnzhM69CxJ3hZXQj+Qlo+j3NXsYa
         MUII+JRt6Hk1o6hdCfic99TQ3/O9rE8UU6su2C4OEDhFO8BwsJCUACnkE8RoYExmyFbD
         jnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763490604; x=1764095404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z7T5v5N5NQ2Sx3O5mcT4P+cLePaUpB1NmqaoT7ZF4wU=;
        b=DYYSsarS2aXcjiDNMyNN42zt5Umh8z/PW5h04btqf6bd6ab6mnPqkrRcuLWUqMhuYU
         itXZ3jtE74kMPFdXRvjTtuAoSipRN3O9U83yKRMKIKsXzBKLPFjoxbzwq8yxGq8yEgCU
         0RiPH2ArKozmBSSZITy7tikbwjDsLRczdCJQhFEScPHp5KfQgWVgJpL8KJcL40yIR+dg
         0/kFzcrUP2WCQ71+y1nYOeLpaklCei3cp/DD86risxi/FNbROxd0esvSurZ9HRZJM9+E
         5milxT10rhpC26G2ME52jxy2W3u6zGuyYjZVLHH+0hJLaDp40kToSUfdDrF5cCgCOLGm
         lIfw==
X-Gm-Message-State: AOJu0YyVE8Vvxt1qWsKEGyelchX1F9/42/fP7sZiLkITbBaZ4pAXZMSY
	d3d8Idthfa9o+HDW2MVP4sphZ+jR/RY9ARWclGmwzm4UC89upd2A3vuNcYxDa4ctO0/j7hnlW23
	A+fUXSbuGpsVgk405zyxReZnI4hwSX6s=
X-Gm-Gg: ASbGncusQ4UYahmELmOw8CKlHyZKktiw9mMIA+wbfWaoyZ8wRliru0LNOdF7mMRIZmf
	jl1J7tKnJ0l7+jTvYAZ6JExAXnpkyXkym5f0i89eEBKN7Byf7ROZnxRJAFgNmSQeIkMf67iTRMA
	VbBUN0Bb25YxtNTcYur3GKHXPPbUZ5c1yQFCr0FEJ0sPB6EXTHBNXkw1jOQaFtMdkf0dHxaI3mQ
	CRkbl/PdxnM2a03vLiakA4CE4RspOuey1Xfh/MQQBQ9KZ+MVVLHXwre46i/RMWDsIil24qAO1zx
	AcdOMA==
X-Google-Smtp-Source: AGHT+IGlJmN5anGzPM9/fReeEq35p8HoU/b2yBYhfcl/tMaAwD6lj0XbeU6N3XTHf59ubM1cPsK3yN8aU7EjpI60izo=
X-Received: by 2002:a17:907:84b:b0:b6d:5a24:f124 with SMTP id
 a640c23a62f3a-b7367870782mr2061388766b.22.1763490604209; Tue, 18 Nov 2025
 10:30:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105061918.3688870-1-christian.couder@gmail.com>
 <20251117043450.322644-1-christian.couder@gmail.com> <CABPp-BHY4SLmWY=V5aHJ6igN0GWeg6V1MoWDwszPe2O38wqBhw@mail.gmail.com>
In-Reply-To: <CABPp-BHY4SLmWY=V5aHJ6igN0GWeg6V1MoWDwszPe2O38wqBhw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 18 Nov 2025 19:29:51 +0100
X-Gm-Features: AWmQ_bkG1l86hAT6PrVzFMy9vn0tf_Oay003jeLWG0wbS3jF3Lcj7sn4CP488Xc
Message-ID: <CAP8UFD03YK47nONVRV_wqOEanC8Oth1iRzsFv=eFhbFs6Q5mPA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] fast-import: add 'strip-if-invalid' mode to --signed-commits=<mode>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 8:52=E2=80=AFPM Elijah Newren <newren@gmail.com> wr=
ote:
>
> On Sun, Nov 16, 2025 at 8:35=E2=80=AFPM Christian Couder
> <christian.couder@gmail.com> wrote:
> > There are no code changes in this v2, only commit message,
> > documentation and test changes:
> >
> > * Rebased on current 'master'. This avoids the need to mark some
> >   strings for translation as a recent series doing that has been
> >   recently merged to 'master'.
> >
> > * In patch 3/3, improved the commit message to better justify the new
> >   feature using some sentences from Elijah.
> >
> > * In patch 3/3, removed tests with dual signatures. This avoids a
> >   conflict with a separate series from brian carlson that adds a
> >   "RUST" prereq that is then needed to run tests with dual signatures.
>
> I'm a bit surprised; from
> https://lore.kernel.org/git/xmqqms4rry7f.fsf@gitster.g/, I thought you
> were going to rearrange the tests to avoid the conflict, not delete
> them.  Are no tests of this new functionality needed?

There are still 5 new tests left in patch 3/3 that are testing the new
'strip-if-invalid' functionality after I removed the 2 tests that are
related to dual signatures.

In "t/t9305-fast-import-signatures.sh", dual signatures are already
tested to work with `git fast-import --signed-commits=3D<mode>` by the
tests that brian's f6581e23 (repository: require Rust support for
interoperability, 2025-10-27) modifies.

f6581e23 not only adds the RUST prereq to these tests, but it also
introduces the RUST prereq itself in "t/test-lib.sh" with:

+test_lazy_prereq RUST '
+       test "$(build_option rust)" =3D enabled
+'

So it's much simpler to just remove the 2 new dual signature tests
that will need the RUST prereq when f6581e23 is merged. We can still
add back these 2 new tests after f6581e23 is merged if we think it's
worth it.

To avoid the conflict I could introduce the RUST prereq itself in
"t/test-lib.sh" with the same code that f6581e23 uses, but then how do
I justify it? What happens if f6581e23 is not actually merged?

It seems to me that if we really want the 2 new dual signature tests
in this series, we would have to wait until f6581e23 is merged or
discarded.

> > * In patch 3/3, improved documentation of the new option to say that
> >   validation behaves as the validation performed by `git
> >   verify-commit`.
>
> Looking over the range diff, the other changes look good.

Thanks for your review.
