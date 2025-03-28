Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C31D14F9E2
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743182634; cv=none; b=HyLxBbgAYASGCpgSB5ocmCRb4bnHFcvs/VOvGCh5r9guWjZgm+lthr0q202t5X69jYRkqsRhb+CGSOJMEQipPpXqSx7f8Ot8sBOZfQXRubh8Qr1L8Zbqevn/n2tFmsaH49YR+gTp3fvLcHrkN9EqGg3uOlx5t8Qnh5T11Pt1XzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743182634; c=relaxed/simple;
	bh=DiaErXgRS/rXORvo/JCamAxc45aMkegOJPd8ig4JdCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reOzCyK2UqJd4JGDyClhEmvPgtydWkNiOuZP3Xw3hs9njZEfzZVWVDcfYeOVe1Qv89CNZ8D/3+1VeKGcXF4xUL9SN4kP+RjYxNP+/P+9t5t99tWgls8qDc+eax50HBKwWdRVaFCObbjTNuYkZxyLowiRIIKBlsLduae4sTz2l4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8f43676b7so3634606d6.1
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 10:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743182631; x=1743787431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qe2LTcXZXFADzszPv1cveMPes/f6kMc/MAVm4aIHbm0=;
        b=CTCimUfvOprRxZ8lt+ioe+P3ewkLc1eXoNclxXGBUsaZOnRo/aFDPsJyQlV2fkWLFg
         3+NnnYTbO7GXb5En/clRz6iym3eNnjnaxf9p6hGGTEq2h6UEmCyrnKt/Ks83jEXuBzNF
         bGRRwVk3uXRJUw237UXq0vZ2i664mKXy0kAZdw2Wz+4wL81I6+cRdI6HCkZy9kdYkkXg
         2af78e/lrz//f1tNY3do7w/52bQcz1LSyBwbr78+qNGyl81SIB4oLWWNeKffG94cx/63
         q+u0NbUMp+rqjBcI0yI7ZUmrf79c+gXt3ciszpBX9AlczJ5PVbNShvm142b0zkR6pklb
         P5Yw==
X-Gm-Message-State: AOJu0YzdvpLNpjOydKRM4X1vbCmpZw2t4/VauYqmQoaO/p1p6lTmE32P
	zqr2Pp7vKD2UlNMnU3WetQjZVSWyiKKlkY3h1mLbNIsJSltg/H9WDRfhtUro3fxiYh5Cdw9SSPh
	0oPPXss5wEFbCua1k54ZFrP33mO0=
X-Gm-Gg: ASbGncsjQLSS05hO6H+YKcmaLUBv7Yt8TRb3xWeiiljwF8Ni8vsiy3B99AN3yihABIW
	G0sknSE+x0Yc8bj2oXNQKAd0hzw+mh4Xx741Tl5bFSaMKfjmEWifr+VHTiI49aJsfBQwhBL33tr
	DDiPL3LsJnMZegFWlTiK4myITMnDSZdDtX6pKD5R4IbCt43k50VIJmxLFrYqM=
X-Google-Smtp-Source: AGHT+IEWEoUpbPYIPO7TJ56of4JTHiUZ+kWQxFpUZzCOvs94QmC/FLz7yU4Sp1dRQ4MaUXPqJFtqgU1VurhnaUrNCY0=
X-Received: by 2002:a05:6214:194a:b0:6e8:f701:f6d8 with SMTP id
 6a1803df08f44-6ed24d957b8mr43052206d6.0.1743182631169; Fri, 28 Mar 2025
 10:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1897.git.1743181401.gitgitgadget@gmail.com>
 <6c8f77cb71c7e0c820704b1725331f4601d8876e.1743181401.git.gitgitgadget@gmail.com>
 <CAPig+cS92W_gYuNsaTvQxiP3xBK7Wpg0__uVkgAU1x0OFJUZgQ@mail.gmail.com>
In-Reply-To: <CAPig+cS92W_gYuNsaTvQxiP3xBK7Wpg0__uVkgAU1x0OFJUZgQ@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 28 Mar 2025 13:23:40 -0400
X-Gm-Features: AQ5f1JppwC1txdi4OouPONlCrEaX7ckVNjvpE_9hDKdsBnRU5TZsOuSFzdjQYRc
Message-ID: <CAPig+cThwsBdumXB3m2ZA-_tmDVTMojkYx7_YxNp49eK6a2HMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rebase -r: do create merge commit after empty resolution
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 1:14=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> On Fri, Mar 28, 2025 at 1:03=E2=80=AFPM Philippe Blain via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> > +test_expect_success '--continue creates merge commit after empty resol=
ution' '
> > +       [...]
> > +       git commit --no-edit &&
> > +       FAKE_LINES=3D"1 2 3 5 6 7 8 9 10 11" &&
> > +       export FAKE_LINES &&
> > +       test_must_fail git rebase -ir main &&
>
> I don't think you want to be setting FAKE_LINES like this since doing
> so will pollute the environment for all tests following this one. You
> can find existing precedent in this script which demonstrates the
> correct way to handle this case. Specifically, you'd want:
>
>     test_must_fail env FAKE_LINES=3D"1 2 3 5 6 7 8 9 10 11" \
>         git rebase -ir main &&

To clarify, by "pollute", I mean that it can impact subsequent tests
which don't take care to override FAKE_LINES as necessary. There
certainly are test scripts which use the:

    FAKE_LINES=3D... &&
    export FAKE_LINES &&

form successfully, but such scripts are careful to override/set
FAKE_LINES in every test. This particular script (t3418), on the other
hand, does not otherwise employ the form in which the variable is
exported, so introducing it in a test which is inserted into the
middle of the script feels dangerous.
