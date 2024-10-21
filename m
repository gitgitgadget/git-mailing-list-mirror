Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C171E908C
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518247; cv=none; b=jYCkwGVw8OrUtq6tIDPRG8wE7WulEH3GMyGMdRF8R5K5I8dbJQm0/KJjkbwb0mhkf8Jq3Dbmk1aMaNtZ87mkSwOVU3G62/W+RXzcMZ2s/v+UopzZsjOdvmK/h1ANd1MNTLh7h3vPqDKMIOcEhSOMqg6UjL4pwoeawmcKkKOOxO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518247; c=relaxed/simple;
	bh=yIL5B0+q/twhzRm6UZs07jB8n7MzugikkrllJ97LCyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duRrPUlamnRw/uG/6Rdf+Oa2dLHJSZ7WP3UJyHTbtTF3NJfZj1PmHYAt6LoxhBJ5hB1j7/tpkBplYknkLev31WS7qMO03WMT1dV/apPEA+9Zt3fVon1xqmmgnHoCgV5f/MTmuH5lA2FnhKI2Jy3BLoVXQc8fnPNHASYMQQSKRBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQ9acyAH; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ9acyAH"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-84fdf96b31aso1379722241.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 06:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729518244; x=1730123044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtZa+QkKHubAiAvcurtgNm6sIHnLhm8H5WgqriaTtEo=;
        b=VQ9acyAH1bksoA9whzwkOv/6bm6aVAZvoKlSjGai9sW96tKQyHFFaXmzU7unoIAwxy
         pnCWz5gjPAQt31izXrXp12Cur1TlTyjJ2Bu2GXlYWwHWNSB5xjeGnGoUjSAQCkgmoUyp
         W/D9UkmOMtXDiJDLOKcvLYopzRRPH3IpI19yN0VXSa0h2Ug5b2gYYPITsHR9/Lt4f37T
         CYIOfbOKiXvctu0+5Vo0wu8K1RR+LYaVSv6Lq5BhQ3tOv5B9ByG9n7qAHY3Y6rDdhniX
         XR8syc0PBclemfsxsMle2ndxAZm1wcYgjvZPwMwFFlPoiF1YQxGbcE/qd/LjWyYZawsf
         JQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729518244; x=1730123044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtZa+QkKHubAiAvcurtgNm6sIHnLhm8H5WgqriaTtEo=;
        b=E5vYF3mwYi/k616P5BnSrlc3ss1Eyo0z4Ss5VNfMORBTiKI+p+MeUQgFNabkq+Ivua
         hC79zLQ9I/ztpNir7KQtJmo39BRdbu94kYLh4Bti8aT7p1RHFlxluOxFI/u3qwTDlGNj
         MPwy3/IpJS8/6ya35DQLl8cz48PKolWzVgqiMGk9hR+f3vkfsMbgKfwk8ISKxYgPnblY
         HWIgNYI7F9t6IQdVErSi1rlyoDXzCnIZNkPCpkZLTfimriVvno2LANaZ0S30C1lC/k4z
         Jm6gpMFGzck8YxXOqBGvj5l/zJgcedj4sxahkNvSbjuUfpg+CBi5Az0YQeyslDgbmvp0
         xLiw==
X-Forwarded-Encrypted: i=1; AJvYcCW9uflIV6GNhwoSPJ3d0grN8cKf4qA99dtbs+8I205nu91DHVTq5ku0GT8HGPYWsBYX2YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznI4oafmEtqmByC6HH7kuIWxZrGpV6DfarY1AAWtmDevS2WCur
	aLminRuUXLJ3XE4ja7O3reu4qfnWvtELg/uj/UtN11OAKbKzHqb1zVzSZ8PxmAGsOLKe4+wO1fY
	r1BOPQ1z0puT0nFu/eRpnJ8l2Xfq+Vw1T
X-Google-Smtp-Source: AGHT+IExKlaXBPTj1Q+n/js1j1khTbCCbqmJsL1Kr86e5JhLK2oqpMhn591XmFIKNumdhP/Q0UD5QTvE8a7WQiAUEGs=
X-Received: by 2002:a05:6122:552:b0:50d:39aa:787b with SMTP id
 71dfb90a1353d-50dd98d4f15mr9194320e0c.0.1729518243908; Mon, 21 Oct 2024
 06:44:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com> <a333d8a40134f4a06812fdbf85c2b011e9d3e472.1729259580.git.gitgitgadget@gmail.com>
 <ZxZHFY4cXQ1lA4QU@pks.im>
In-Reply-To: <ZxZHFY4cXQ1lA4QU@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 21 Oct 2024 13:43:53 +0000
Message-ID: <CAPSxiM_+4ZaaiyvWDVwXf3tnt08otsx=1dcJJtQsL7h59dO8kQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] daemon: replace atoi() with strtoul_ui() and strtol_i()
To: Patrick Steinhardt <ps@pks.im>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 1:36=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Fri, Oct 18, 2024 at 01:52:58PM +0000, Usman Akinyemi via GitGitGadget=
 wrote:
> > diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
> > index c5f08b67996..c73c2196981 100755
> > --- a/t/t5570-git-daemon.sh
> > +++ b/t/t5570-git-daemon.sh
> > @@ -1,6 +1,6 @@
> >  #!/bin/sh
> >
> > -test_description=3D'test fetching over git protocol'
> > +test_description=3D'test fetching over git protocol and daemon rejects=
 invalid options'
> >  GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> >  export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> >
>
> Hum. I think the test description can stay as-is, as we don't typically
> mention all the exact details of what we test in a test suite. But I
> also don't mind this too much.
Ohh, noted. I just thought the test description does not have anything
about merge.
>
> > @@ -8,6 +8,31 @@ TEST_PASSES_SANITIZE_LEAK=3Dtrue
> >  . ./test-lib.sh
> >
> >  . "$TEST_DIRECTORY"/lib-git-daemon.sh
> > +
> > +test_expect_success 'daemon rejects invalid --init-timeout values' '
> > +     for arg in "3a" "-3"
> > +     do
> > +             test_must_fail git daemon --init-timeout=3D"$arg" 2>actua=
l_error &&
> > +             test_write_lines "fatal: invalid init-timeout '\''$arg'\'=
', expecting a non-negative integer" >expected &&
>
> You can use ${SQ} instead of '\'', also for the other two tests.
Will make a change now.
>
> Patrick
