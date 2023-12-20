Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9153E3DB9C
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzY1vGyr"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5532b348d30so4668448a12.1
        for <git@vger.kernel.org>; Wed, 20 Dec 2023 07:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703085939; x=1703690739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7anja+QsxuLd9NliG/NA0nK91Oi5yGkF0w/NCnYsqWg=;
        b=DzY1vGyrhC/NYTEeYr2jlGyEou/gRan252UubA8Rf0DgzxQG8K0Kdsvwmc053AHePv
         Jm0bfd7VhFA4y9nbN4BhT7Rqn56nRF1+mhcPzMxZXf7DkAeBN8+63lT2Bhm2oVzFxX1l
         oKPLag1MkYKWABmXx9Cd+f3/LUht3jAVkhtK14GswmlBGNErsvbYBtxEqASboG9I0f0T
         9Gy1r/BoZ4/LRZtKL6fGZlhLn9tQteYztUtD39ormOATnbuv/X5niLP+skJhcp8tCj6D
         jidhzQ3zZnK7C9ThXlPly54Sp4cNSLuxzHV6NovUNwwlT8tX6suDZUn7l8gf85YWBA4v
         9LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703085939; x=1703690739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7anja+QsxuLd9NliG/NA0nK91Oi5yGkF0w/NCnYsqWg=;
        b=pZJFHCoKtsirLPyZYhQNGPdLhgkv7JFR4T4p2jmBDbRcBiaRMhLZjAhGbyqyoLr4TW
         T01cEQFJFQY79LmqTQgsTGaeCvjoDdiJnkMfXr4xlQqYla0VtME75QVUshdAkelXIg9q
         qC6U06fGbLxRkB1SzD/SH9ib5Yb0iS8Lfz2OIj+0BEDaiqjeYUS+cqmjT2RZjQSdepw4
         aaOrHGbVVsgRm4tW3aJokea03ZA4fjMaiUwTIsGFlsi7jXZc07rP+j0HdbLARyK6IO/O
         W5tyUA7I6nHg4sc03gsBJiycF5wPyO95SqUwc8CuDkqkSBuLiJlDY3WyObrE0Cq3rJPd
         k/QA==
X-Gm-Message-State: AOJu0Yx7P8TWYVNryVAsJN0WZbsiHy+61LljXNvtivyiHq2mykNbekqf
	M6p4ouXMVSgztDdctdu3lMlkTlbL6B9jRkayLnw=
X-Google-Smtp-Source: AGHT+IFRUryzDxEG5yt+HoBa04x/olNsH2QDK/IxftujE2ldJUC7C/9aRtnBtOFYZPUF4nFh5tzwMl6ye4W/RBTlNdM=
X-Received: by 2002:a50:8e17:0:b0:553:5648:ea38 with SMTP id
 23-20020a508e17000000b005535648ea38mr2652916edw.24.1703085938454; Wed, 20 Dec
 2023 07:25:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1587.v5.git.1701206267300.gitgitgadget@gmail.com>
 <pull.1587.v6.git.1701442494319.gitgitgadget@gmail.com> <CAP8UFD3FzP6QW4dJ9yiG1BAytLcsk+zGE+CBeArRJBJ8gsaDMQ@mail.gmail.com>
 <CAEWN6q3RTbVuMb0VyCYz196ZL+OGAAHbJLZ2-MnW1RVVabg7Mw@mail.gmail.com> <CAP8UFD19phFz54d8fDM=MBRMSD9Rz4R0_463KgptN8eeFs7MnQ@mail.gmail.com>
In-Reply-To: <CAP8UFD19phFz54d8fDM=MBRMSD9Rz4R0_463KgptN8eeFs7MnQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 20 Dec 2023 16:25:26 +0100
Message-ID: <CAP8UFD3b2y+55j3NMDm89hpVRNxX2TA-AdQS=zsboD30pZ1c4Q@mail.gmail.com>
Subject: Re: [PATCH v6] subtree: fix split processing with multiple subtrees present
To: Zach FettersMoore <zach.fetters@apollographql.com>
Cc: Zach FettersMoore via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 5:06=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Dec 11, 2023 at 4:39=E2=80=AFPM Zach FettersMoore
> <zach.fetters@apollographql.com> wrote:
> >
> > >>
> > >> From: Zach FettersMoore <zach.fetters@apollographql.com>
>
> > >> To see this in practice you can use the open source GitHub repo
> > >> 'apollo-ios-dev' and do the following in order:
> > >>
> > >> -Make a changes to a file in 'apollo-ios' and 'apollo-ios-codegen'
> > >> directories
> > >> -Create a commit containing these changes
> > >> -Do a split on apollo-ios-codegen
> > >> - Do a fetch on the subtree repo
> > >> - git fetch git@github.com:apollographql/apollo-ios-codegen.git
> > >> - git subtree split --prefix=3Dapollo-ios-codegen --squash --rejoin
> >
> > > Now I get the following without your patch at this step:
> > >
> > > $ git subtree split --prefix=3Dapollo-ios-codegen --squash --rejoin
> > > [...]/libexec/git-core/git-subtree: 318: Maximum function recursion
> > > depth (1000) reached
> > >
> > > Line 318 in git-subtree.sh contains the following:
> > >
> > > missed=3D$(cache_miss "$@") || exit $?
> > >
> > > With your patch it seems to work:
> > >
> > > $ git subtree split --prefix=3Dapollo-ios-codegen --squash --rejoin
> > > Merge made by the 'ort' strategy.
> > > e274aed3ba6d0659fb4cc014587cf31c1e8df7f4
> >
> > Looking into this some it looks like it could be a bash config
> > difference? My machine always runs it all the way through vs
> > failing for recursion depth. Although that would also be an issue
> > which is solved by this fix.
>
> I use Ubuntu where /bin/sh is dash so my current guess is that dash
> might have a smaller recursion limit than bash.
>
> I just found https://stackoverflow.com/questions/69493528/git-subtree-max=
imum-function-recursion-depth
> which seems to agree.
>
> I will try to test using bash soon.

Sorry, to not have tried earlier before with bash.

Now I have tried it and yeah it works fine with you patch, while
without it the last step of the reproduction recipe takes a lot of
time and results in a core dump:

/home/christian/libexec/git-core/git-subtree: line 924: 857920 Done
                eval "$grl"
    857921 Segmentation fault      (core dumped) | while read rev parents; =
do
   process_split_commit "$rev" "$parents";
done

So overall I think your patch is great! Thanks!
