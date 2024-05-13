Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528467E0F3
	for <git@vger.kernel.org>; Mon, 13 May 2024 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715631416; cv=none; b=CCkM9s5nlMPRy1U0mUpKwMFHdh+rBLOZgHoXN7B9kv0UcRFeQQlr2OOsPH0aSsNPahVcRmMJYhhoq7N5+RqJ0/ABoIuYtFzxoQWr9OKm2tazIWu9ncIS+y5WWO1HdPWID8RePYkGA+rNqAw8k3tiG/CxJavvo/0+SXxIu0CRihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715631416; c=relaxed/simple;
	bh=s2JeG92ybTSxDGIwf0Ez0YtIVBsmEQrSik0IJ2cYE5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftyPudoNy/rkr5C/nEEV8454Qcq0Tegd9MK66/PTPwIT30RsrFYmqnrrmkztrJDJ18yZ0hn3IE0u+TR+OyohQq6hxXdzQqiY2MuDWEswvoMNRi5X1Goote+BPKtylhanUqNaQ/Prmlef1g+A8Fp54GqqsG703LBJ2tdKTQMsXFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icPfRFux; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icPfRFux"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43e09ff93d3so627231cf.1
        for <git@vger.kernel.org>; Mon, 13 May 2024 13:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715631414; x=1716236214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7Hwru7c74M4x6NWNYMW3/uQgX8nfUy2C0QOkqNrc2Q=;
        b=icPfRFux8bJaDNMGKjMPO90v+izVufoV3uiQ2muWQjTRZOjrG4Tfqw+fSx2z6SpVAG
         AxX7eOjUsKZaXz6Aqq6Lr0mO/5E/P65JNHfEwoMLZPIAateb5vZ62fkUpM9Pxq9GjwRS
         lYROTXiD0+k/dO2DBul4CobaGyo0zEMnKhcyQ1FmmSIRmUqHGEVb0HLcUd/pJtE7FQkX
         YHVnFmSZk3fKKXVeXOth5BVNz8p14blR+bA5LclzOE0ikgPTHl5lh1Ja2i/V4F8cnxcJ
         fpUM8k0OUmWyk8eMIW1aPv55+YADQo2UZhmKMxi9yW9tPZ5Fu2NRX7ISA6MN58M63qvy
         rR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715631414; x=1716236214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7Hwru7c74M4x6NWNYMW3/uQgX8nfUy2C0QOkqNrc2Q=;
        b=vzcAdNDv9CjiZQMay6GH6MLcNuNuEJHj/1bs61SlQhEF1Psf8uUpSELYwn6af0XeLS
         KoT1gg4IeP3TlPgxG7/GPisDb8yLvW94yPQb4THnPx1aL8L8TvoEeJmiutv2EOGiTU+D
         g5b0SdelJEsru6FynTTCBhmssmvRX7Wj4lgVLpMHrKMfuUC8I6KtGacSYMvmg9HS3q6p
         xYzUhyFklr8zMbe6juKPcGt+LBu2zWvMlRJO0UhA2IPZgaxxOL7OkRujlAuPynNUj/Il
         2ivpaY0WyxZ5Xm1GEGY1XhGnIJ/8SesZMvBsrmHEcUoiVE4krrl7WM6y7wjsAc4ApDZo
         A0Dw==
X-Gm-Message-State: AOJu0YxkBIgt6jhv8akG+F3dJTKaMZRRZ15WHP7oZgpsez+HDfRGJOFc
	PSsNPg6LFsDyVSLO/79FribiHtQ1dseAG82HxOvijyr9UfdXT5bX
X-Google-Smtp-Source: AGHT+IErdvLLNcyzbbyAto2vy3oUlL8mEPLwfcWGmQ3AG7F0kGGXR1Xipv3OrePA92/vh9JwCCBF0g==
X-Received: by 2002:a05:622a:1a94:b0:43d:e0cf:a46 with SMTP id d75a77b69052e-43dfdb67d61mr132401711cf.3.1715631414097;
        Mon, 13 May 2024 13:16:54 -0700 (PDT)
Received: from [169.254.204.239] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df56d05a4sm59651721cf.85.2024.05.13.13.16.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2024 13:16:53 -0700 (PDT)
From: John Cai <johncai86@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
 Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
 Dhruva Krishnamurthy <dhruvakm@gmail.com>
Subject: Re: Re* using tree as attribute source is slow, was Re: Help
 troubleshoot performance regression cloning with depth: git 2.44 vs git 2.42
Date: Mon, 13 May 2024 16:16:53 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <1BDD4F51-4B62-463D-A876-FB16E38E86C2@gmail.com>
In-Reply-To: <xmqqzft6aozg.fsf_-_@gitster.g>
References: <CAKOHPAn1btewYTdLYWpW+fOaXMY+JQZsLCQxUSwoUqnnFN_ohA@mail.gmail.com>
 <20240501220030.GA1442509@coredump.intra.peff.net>
 <ZjLfcCxjLq4o7hpw@nand.local> <ZjPOd83r+tkmsv3o@nand.local>
 <xmqqfrv0ds7f.fsf@gitster.g> <ZjPTlrMdpI+jXxyW@nand.local>
 <CAOLa=ZRe6eWJ_ZyH+HRq=6Lh0-xZ=1X2Z2f3HW4+EVXNquaDTQ@mail.gmail.com>
 <xmqqbk5ndiqk.fsf@gitster.g>
 <CAKOHPA==xgRBLXmyURkdZ9X4LqQoBHYy=XD0Q_KTQHbK54DOFg@mail.gmail.com>
 <xmqqzft6aozg.fsf_-_@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


On 3 May 2024, at 11:34, Junio C Hamano wrote:

> Dhruva Krishnamurthy <dhruvakm@gmail.com> writes:
>
>> On Thu, May 2, 2024 at 2:08=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
>>> We could drop [1/2] from the series in the meantime to make it a
>>> GitLab installation specific issue where they explicitly use
>>> attr.tree to point at HEAD ;-) That is not solving anything for
>>> those who set attr.tree (in a sense, they are buying the feature
>>> with overhead of reading attributes from the named tree), but at
>>> least for most people who are used to seeing the bare repository
>>> ignoring the attributes, it would be an improvement to drop the
>>> "bare repositories the tree of the HEAD commit is used to look up
>>> attributes files by default" half from the series.
>>>
>>
>> A hack (without knowing side effects if any) is to use an empty tree
>> for attr source:
>> $ git config --add attr.tree $(git hash-object -t tree /dev/null)
>>
>> This gives me performance comparable to git 2.42
>
> That is clever.  Instead of crawling a potentially large tree that
> is at the HEAD of the main project payload to find ".gitattributes"
> files that may be relevant (and often not), folks can set an empty
> tree to attr.tree to the configuration until this gets corrected.
>
> And for folks who had been happy with the pre 2.42 behaviour,
> we could do something like the attached as the first step to a real fix=
=2E
>
> ----- >8 --------- >8 --------- >8 --------- >8 -----
> Subject: [PATCH] stop using HEAD for attributes in bare repository by d=
efault
>
> With 23865355 (attr: read attributes from HEAD when bare repo,
> 2023-10-13), we started to use the HEAD tree as the default
> attribute source in a bare repository.  One argument for such a
> behaviour is that it would make things like "git archive" run in
> bare and non-bare repositories for the same commit consistent.
> This changes was merged to Git 2.43 but without an explicit mention
> in its release notes.
>
> It turns out that this change destroys performance of shallowly
> cloning from a bare repository.  As the "server" installations are
> expected to be mostly bare, and "git pack-objects", which is the
> core of driving the other side of "git clone" and "git fetch" wants
> to see if a path is set not to delta with blobs from other paths via
> the attribute system, the change forces the server side to traverse
> the tree of the HEAD commit needlessly to find if each and every
> paths the objects it sends out has the attribute that controls the
> deltification.  Given that (1) most projects do not configure such
> an attribute, and (2) it is dubious for the server side to honor
> such an end-user supplied attribute anyway, this was a poor choice
> of the default.
>
> To mitigate the current situation, let's revert the change that uses
> the tree of HEAD in a bare repository by default as the attribute
> source.  This will help most people who have been happy with the
> behaviour of Git 2.42 and before.

This change makes sense to me, and glad it got uncovered. Thanks to all w=
ho
chimed in with this root cause analysis and the proposed patches. Sorry I=

haven't replied until now-I was traveling the past two weeks.

thanks
John

>
> Two things to note:
>
>  * If you are stuck with versions of Git 2.43 or newer, that is
>    older than the release this fix appears in, you can explicitly
>    set the attr.tree configuration variable to point at an empty
>    tree object, i.e.
>
> 	$ git config attr.tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>
>  * If you like the behaviour we are reverting, you can explicitly
>    set the attr.tree configuration variable to HEAD, i.e.
>
> 	$ git config attr.tree HEAD
>
> The right fix for this is to optimize the code paths that allow
> accesses to attributes in tree objects, but that is a much more
> involved change and is left as a longer-term project, outside the
> scope of this "first step" fix.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  attr.c                  |  7 -------
>  t/t0003-attributes.sh   | 10 ++++++++--
>  t/t5001-archive-attr.sh |  3 ++-
>  3 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git c/attr.c w/attr.c
> index 679e42258c..6af7151088 100644
> --- c/attr.c
> +++ w/attr.c
> @@ -1223,13 +1223,6 @@ static void compute_default_attr_source(struct o=
bject_id *attr_source)
>  		ignore_bad_attr_tree =3D 1;
>  	}
>
> -	if (!default_attr_source_tree_object_name &&
> -	    startup_info->have_repository &&
> -	    is_bare_repository()) {
> -		default_attr_source_tree_object_name =3D "HEAD";
> -		ignore_bad_attr_tree =3D 1;
> -	}
> -
>  	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source=
))
>  		return;
>
> diff --git c/t/t0003-attributes.sh w/t/t0003-attributes.sh
> index 774b52c298..d755cc3c29 100755
> --- c/t/t0003-attributes.sh
> +++ w/t/t0003-attributes.sh
> @@ -398,13 +398,19 @@ test_expect_success 'bad attr source defaults to =
reading .gitattributes file' '
>  	)
>  '
>
> -test_expect_success 'bare repo defaults to reading .gitattributes from=
 HEAD' '
> +test_expect_success 'bare repo no longer defaults to reading .gitattri=
butes from HEAD' '
>  	test_when_finished rm -rf test bare_with_gitattribute &&
>  	git init test &&
>  	test_commit -C test gitattributes .gitattributes "f/path test=3Dval" =
&&
>  	git clone --bare test bare_with_gitattribute &&
> -	echo "f/path: test: val" >expect &&
> +
> +	echo "f/path: test: unspecified" >expect &&
>  	git -C bare_with_gitattribute check-attr test -- f/path >actual &&
> +	test_cmp expect actual &&
> +
> +	echo "f/path: test: val" >expect &&
> +	git -C bare_with_gitattribute -c attr.tree=3DHEAD \
> +		check-attr test -- f/path >actual &&
>  	test_cmp expect actual
>  '
>
> diff --git c/t/t5001-archive-attr.sh w/t/t5001-archive-attr.sh
> index eaf959d8f6..7310774af5 100755
> --- c/t/t5001-archive-attr.sh
> +++ w/t/t5001-archive-attr.sh
> @@ -133,7 +133,8 @@ test_expect_success 'git archive vs. bare' '
>  '
>
>  test_expect_success 'git archive with worktree attributes, bare' '
> -	(cd bare && git archive --worktree-attributes HEAD) >bare-worktree.ta=
r &&
> +	(cd bare &&
> +	git -c attr.tree=3DHEAD archive --worktree-attributes HEAD) >bare-wor=
ktree.tar &&
>  	(mkdir bare-worktree && cd bare-worktree && "$TAR" xf -) <bare-worktr=
ee.tar
>  '
