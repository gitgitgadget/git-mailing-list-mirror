Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C14A5D479
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052137; cv=none; b=H1P4LXOAPP7tgsrSFswRUAKBURq7dvFWpiZvLZFhtxvqQcInYTg4u2Ku0V8Hjt6QNmSed1K8xAj1yd31+l1nnBFWastN7WMZ8TGCkhg4jlXB3xAqCthts0SifEZtXtxp48BUsUobgtmRD4c1EcP6eiVaub0IqAcvkNZuAqcDzko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052137; c=relaxed/simple;
	bh=QFejOxEfnY44w825jrB24oPgVXQ+/o9Qp5eGb/OS6YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjN6wBXxIp3rNmgT3qlBUMcYL4Ix5OfQtKvd0ojHYqvPtYaebDcaGHIPN5rIO4dZU1eBk8hefiP39AmtkoDF8URrwidr6UOMj6UV5QdM3rf5h5vC08OK+ditZ6fuDill+HksJOiMidtivq9DUD32YG2Wk3DRrRewbL1jzGl6Mu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYPZirPt; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYPZirPt"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso5528249a12.1
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712052133; x=1712656933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjEbYblZKrl0CG+m753a58lhpGKTv+P90XqbAa23qmU=;
        b=mYPZirPtf6KJLrck9evyFoeiF/7GAzufOAtIu5Zzzit9Mzfogg+q79Z4C56uHuAbmP
         o2vZ2Z5lu2OcKCAwX/JFAiSXMm/rWCZvAgP/JlJNiSKjz+UZcdU2Gx9eVIQAsKOVqozQ
         D4Xsqj9vu5wOWkjA6GsTvCTJN8NX38QPl6HPNvYmIcFzxNW9hL+MipTvuBqp9mPGLB5N
         xBlLa7CrssWX7vLCBC1oSUtibvg0ttPavKAjhDBAccZGKUdqoRD3ibSxBIt3ZnsH+FqN
         iuXAwuFGVUEyJXMRKVIjvELPPpEp7cDJaebZVZeGRAkhmEFAXUhKn8rWH8FOuLINEpZu
         yKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712052133; x=1712656933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjEbYblZKrl0CG+m753a58lhpGKTv+P90XqbAa23qmU=;
        b=k/BhnRFYmZD1YbI6dBY0BY9FmVgfzce6AW0FuGU+FXH+hGepSzCm+sSZs+dx/soJOd
         JgOUzX8Cy8BZw5WI69eQaTlEUKFpIQrcFVIgXxY1TATuFzdShYdnJhmynRteGmXZ1CKS
         va+3n89+ILJ21DbtItGo58P1LtKzFvlF/6byYlONnPUfOC5yQuSeiULnnjeUwjmNZkEf
         jeTt8MezS10VzDTUh2+uoA/rQeEQMen3k6GRRWp23Xa44Cdfpayca9lhCHmrw/kYjtWD
         XyFbXnPWfEFnGZJQrez/XZcqLHmw81WAeqN8gbgq662K/SVMY61lrIeJd9CRJ14OX6B6
         yV6g==
X-Forwarded-Encrypted: i=1; AJvYcCVPVrD1opcOojVFkGUUhijIFLUk+oTglaiP482r73KP9bud+VoDsgpdO4QiMhM9TPHj2D41zx/6HN/fKpBMJvdWEgck
X-Gm-Message-State: AOJu0YxlAkr/rGkLtERdL/dYD/4BjvHZRcRwO/J/1y5rlvmIE32JVkLj
	7uGrzXcfBDrkbKa4D8gffDKkYbR/wHgxYMKsglc/3+YhK23xzbcFT+LReVNwB4OLhwmmepQ7z9O
	uzu+8Opq1X6m3X2Oa63uOSOSH2/M=
X-Google-Smtp-Source: AGHT+IE8zvd0/cWAn12AS2KgoJgkOT40LvJUJA98VA4dJjZ+D/hqTCBFs3HAixVvQIxsSR/NpD2oGW/PIrDjKWSCCps=
X-Received: by 2002:a17:906:274f:b0:a4e:2178:d91a with SMTP id
 a15-20020a170906274f00b00a4e2178d91amr7823038ejd.59.1712052132317; Tue, 02
 Apr 2024 03:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6f0a3c13-c8d9-4f89-8c62-9c031f0a064e@gmail.com>
 <CAP8UFD3Rb0kN=g=EPcSqYBb3U=OgW_06jqwafF=vRYhetZ9hdQ@mail.gmail.com>
 <ZfwnrL6Zl_lcV09y@tanuki> <63059d3b-e883-4fa2-8364-64f7bbd064f7@gmail.com>
In-Reply-To: <63059d3b-e883-4fa2-8364-64f7bbd064f7@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 2 Apr 2024 12:01:59 +0200
Message-ID: <CAP8UFD26BzjOdJPjcbVy-xGD7nBhFsfSu9CyureCLdHp9eUMZg@mail.gmail.com>
Subject: Re: [RFC][GSoC] Proposal v2: Move and improve reftable tests in the
 unit testing framework
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>, 
	karthik nayak <karthik.188@gmail.com>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 8:08=E2=80=AFAM Chandra Pratap
<chandrapratap3519@gmail.com> wrote:
>
> Thanks for the feedback, Christian and Patrick! With your advice, I
> decided to split my original proposal into two to conform to what was
> suggested by the SoC 2024 Ideas page.
>
> This is the proposal for the reftable tests migration project. However,
> I am unsure of what would be a good project size for this project.
> I have quite a long summer vacation and don't really have any other
> plans other than GSoC as of now so I decided to go with large project
> size on GSoC's website but please let me know if another size would
> be more appropriate.

On our Idea page, we have "Expected Project Size: 175 hours or 350
hours" for this project. So it's fine for us if you pick one of those
(medium or large).

> Before GSoC
> -----------
>
> -----Synopsis-----
>
> A new unit testing framework was introduced to the Git mailing list last
> year with the aim of simplifying testing and improving maintainability
> by moving the current testing setup from shell scripts and helper files
> to a framework written wholly in C. The idea was accepted and merged
> into master on 09/11/2023. The choice of testing framework and the
> rationale behind the choice is thoroughly described in
> Documentation/technical/unit-tests.txt.
>
> This project aims to extend that work by moving the reftable tests from
> the current setup to the new unit testing framework and improving the
> tests themselves. The difficulty for the project should be medium
> and it should take somewhat around 175-350 hours.

It's fine to give information about the project that is already in the
Idea page (or even to just copy from that page), but we are more
interested to know how you approach the project, and how you want to
work on it. So if you give information that is already in the Idea
page, please say it clearly, so we can easily skip reading that if we
don't have much time.

As we prefer that you give information specific to your approach, I
think it would have been more interesting to say that you decided to
go with a "large" project size for example.

> In GSoC
> -------
>
> -----Background for reftable-----
>
> Git=E2=80=99s internals consist of mainly three objects: blobs, tree obje=
cts and
> commit objects. The blobs and tree objects are responsible for storing a
> repository=E2=80=99s content while the commit objects store information a=
bout
> commits in the repo and are responsible for capturing the repo=E2=80=99s
> history.

When explaining refs with as much detail, I think tag objects are
important too, as refs often point to them too. On the contrary, blobs
and tree objects are very rarely pointed to by refs. So it's a bit
strange that you don't talk about tag objects, but that you talk about
blobs and trees which are less important than tag objects in this
context.

> Every one of these objects can be accessed through a unique key
> generated by a SHA-256 (previously SHA-1) algorithm.

Actually both SHA-256 and SHA-1 are supported.

> To make life
> easier, instead of remembering the hash key for commit objects, we can
> assign a simple name to them, store these names in a file and use that
> file whenever we need access to the commits. These names are called
> =E2=80=98references=E2=80=99 or =E2=80=98refs=E2=80=99.
>
> Since a repository can contain a lot of commits and branches and hence,
> a lot of refs, Git used packed-refs to save space by storing unused refs
> in a single file. However, this arrangement doesn=E2=80=99t scale well in=
 terms
> of both space and performance. This is where reftable comes in. A
> reftable file is a portable binary file format customized for storing
> references. Some objectives of reftable are:
> -  Sorted references enabling advanced scans like binary search.
> -  Near constant time lookup for any single reference.
> -  Efficient enumeration of an entire namespace like refs/tags/
> -  Combined reflog storage with ref storage for small transactions and
>    separate reflog storage for base refs and historical logs.
> -  Near constant time verification if an object name is referred to by at
>    least one reference.
>
> -----Plan-----
>
> The reftable tests are different from other tests in the test directory

Not sure which "test directory" you are talking about. I guess it's "t/".

> because they perform unit testing with the help of a custom test framewor=
k
> rather than the usual =E2=80=98helper file + shell script=E2=80=99 combin=
ation.

There are actually already unit tests in t/unit-tests which don't need
a shell script.

I think it would have been clearer if this paragraph was started with
something like "Compared to unit tests that use both a "t/*.sh" test
script in shell and a test-tool helper in "t/helper/", ..."

> Reftable tests do have a helper file and a shell script invoking the
> helper file, but rather than performing the tests, this combination is
> used to invoke tests defined in the reftable directory.

It looks like you are talking about the "reftable/*_test.c" files, but
I think it would be clearer if you spelled that out.

> The reftable directory consists of nine tests:

I think using "contains" instead of "consists" would be a bit better,
as there are other things than the nine tests in the "reftable/"
directory.

>
> =E2=80=A2  basics test
> =E2=80=A2  record test
> =E2=80=A2  block test
> =E2=80=A2  tree test
> =E2=80=A2  pq test
> =E2=80=A2  stack test
> =E2=80=A2  merged test
> =E2=80=A2  refname test
> =E2=80=A2  read-write test

Yeah, this corresponds to the output of `ls reftable/*_test.c`.

> Each of these tests is written in C using a custom reftable testing
> framework defined by reftable/test_framework (also written in C).

Using "reftable/test_framework.{c,h}" would be a bit clearer as there
is no "reftable/test_framework" file.

> Since the reftable test framework is written in C like the unit testing
> framework, we can create a direct translation of the features mentioned
> above using the existing tools in the unit testing framework with the
> following plan:
>
> =E2=80=A2  EXPECT_ERR(c): Can be replaced by check(!c) or check_int(c, =
=E2=80=9C=3D=3D=E2=80=9D, 0).
>
> =E2=80=A2  EXPECT_STREQ(a, b): Can be replaced by check_str(a, b).
>
> =E2=80=A2  EXPECT(c): Can be replaced by check_int(), similar to EXPECT_E=
RR.
>    E.g. expect(a >=3D b) --> check_int(a, =E2=80=9C>=3D=E2=80=9D, b)
>
> =E2=80=A2  RUN_TEST(f): Can be replaced by TEST(f(), =E2=80=9Cmessage exp=
laining the test=E2=80=9D).
>
> The information contained in the diagnostic messages of these macros is
> replicated in the unit testing framework by default. Any additional
> information can be displayed using the test_msg() functionality in the
> framework. The additional functions set_test_hash() and strbuf_add_void()
> may be moved to reftable/stack.c and reftable/refname.c respectively.
>
> The plan itself is basic and does need improvements, but using this plan,
> I have already created a working albeit primitive copy for two out of the
> nine tests (basics test and tree test) as can be seen here:
> (link: https://github.com/gitgitgadget/git/pull/1698)

Nice, but it looks like "unit-tests/bin/t-reftable-tree" sometimes
fails, perhaps because it's missing a call to test_done().

The rest of your proposal LGTM.

Thanks!
