Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4893B380FD7
	for <git@vger.kernel.org>; Sat, 12 Sep 2026 02:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789179155; cv=pass; b=iHnr2//rRn4uq4zdWV8iDYJHVPmvzaxAsbTU6ReKqSDwTIdgXNDPlQb4rUZ+DUBDRT6uriz/8BJDDX/fuxDCNOuBHtufdCjdM9Gs9hqM0uw9WrQOLkqx/R77Lz6PlaL6B63rkXWjOCnoQlOw2gUtOil+/2bBY+Bgzjjuj+kOxww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789179155; c=relaxed/simple;
	bh=cwtRZFdyD7d+PrBWw2hRGkaooBdsIraZbaLo1SEj1ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fcAgR6FkmXNG6JkS0qYKNqTyO52HAfscJfCQDl918HfYzNaZFFK3bYQUUFRDMYDRfa13Wxtuu6U2RKV/ZYgsL1Ao7ONf5rE1Uix8pvtDswTkDdXtto1xHkedpfKNjQ1LSVRLv8AW/dZ/2K+65qAI2jiJZp4cogiM+WHRQb1g8ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOqQ+Oca; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOqQ+Oca"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67124ad7615so1665593d50.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 19:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789179153; cv=none;
        d=google.com; s=arc-20260327;
        b=YPKA9L4unNv0hXvjRlb1LIa7Yv5Eiels+P4zNTAkUOOjHyJNj4O4qqY/2cOs/hbYmV
         SPcNP/+pdjkkdwHMubhwpnzdsz44thaJFon+WLEzwS8w7H2X0LJqjmsGwTlJl1H/Pcug
         1KjFaTddfz+C7Ps1qu3ZNMF9s7TfI8RGx0mQ2dmDjenyBc3HEC9wd8lpneQUQe1dlXWP
         KLWbp1rm+x3tqGpZPkwxsjUu/ZKaXTWt24N3QS/N3kaNrcS1unqGqxzwpnkEGJTRGGqU
         KnWE3ckN1/tQ/ZEOgkHSDhVkTAo9MersWu7+5XzMjXzbrPGU4C0BVm3peStfoiEpBbbv
         kGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W7AySjidtzbIWqqmW3BS+dS1+kfB37mxbuzOJHDW6sw=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=MKHMTf1d2neUBZlZ9BxtMYC1P6UJ9GhXq8kXKwDx6vcHGNC5cPhE6MibEcV/azCt6y
         mFl4fxcieBn4g9m3gUn4HrfAwZQ1seFdyXDvDRJqa66CYnwmElvh4GtUia2yE6Bf/I0M
         CvcA8HxfpJLx08xiAJD92lMhUbzm1qNvl0WP7ZxaixT/7v2+DDDCBI8BbFARNIe3WlE9
         DuXWVBe8tZAM1UcwxkadaOu4fnN4r8ACgzZcXuyUsWX28pmBWrUOLmoBSFDUWKAmJamW
         fbgJCzvFSJS/c5J/yy3MvxrlLzLoPQU3VQerx/I7zZ5gQNyS/foZh8RTOH3CEXsRCB8u
         LMDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789179153; x=1789783953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W7AySjidtzbIWqqmW3BS+dS1+kfB37mxbuzOJHDW6sw=;
        b=FOqQ+OcaaXrein5dyQUSI7jWW2Fd32cD0uD+ooN1jbzkmjoPleByb3SVbzQV/ejRAs
         SWzmNkx2Ooif2PQQoUTJ2me1w+MO1V17ZxfCXg+IEfKbjdMJZ7QOPiUUoYLhcMOal/oi
         9SsLGaVyu/EQ8KTP7fpaeY56WPR4CCoLPGUHgMQm/fQWHzLX70t94SDFnl80NdRkkv0Y
         NcRaW4ocX+86c6Wzk6Fk0+n7zhkFJfuE/x887J+ADDQQiin2HdFArwUUvnKv4ianHKsM
         7T/z53MgapWMbDtSL6LowsD2EI2isB1s2KCvdowA7DcKCl3wXLabcCnbrA1Et96XlnlW
         6kMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789179153; x=1789783953;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W7AySjidtzbIWqqmW3BS+dS1+kfB37mxbuzOJHDW6sw=;
        b=m8Svoiqrk90njitQqVIqIkFrLJANeCMKqNJlzpNvWcx4nxzTIlL9KmS4Mp14g7CC9e
         x6Ed7qxlletR3q5e7sLNNNGajrSoaG9AAxo+iiZ2L2FCnG3icRBt6/+0DfONwJ4vlq9v
         dj48tlK+gDOu79zu+o/SJAxojJ8rHwyAD8EMZa2opC+qLwiu6h6RR9z3S1doTuPTen65
         Cj2HLrVVE5d4uvM98mZ0tO2Nw0KH/TSkJ5iY4uIHtrffqPpiF0lvbOVPIUcP+N7KpZEy
         N2j5MVX2CLyHTFoRpFUF0pCZh9dsK6rdnJBb+OHt3UQmgakXtjB5GuW/P+vv2CI4nkkG
         eQIw==
X-Gm-Message-State: AFuF++ldA0Tf8YVBLFNZdL1FWiJcmKb2Vklu3raPgAzvdlvV2nqlUE+h
	YS5CsgyrycLeHDPbhnqkL4zWt5AhDvoU/6uY1fAUMoUBWwdxDg/t0CwvIu7eHovO8jZ25bdAxML
	2bAw5CSYHjylhDMCwJm/t6xWGJdcc9m0+3StJ
X-Gm-Gg: AYBFou1zEl9Qpeue32/vRQ0i0ji2brpUsBzhIloh7YSh9l8IgDDOUiplppIeZNr1J4K
	GRSbbVtH55baUpvbizwtrzP5aOeJxvD9eoYzqF8xqIWn0m2uY1WM7whM7AoLoVnwHNHl+DC/81R
	27UoTJM/LmUc+BKbDGvVTBMIGaQAtO4oB3pp09XO0HOPLc4kSf7FFfCXgbYY1HrPBde6ckguQO2
	GwB+XosAP1hyMx9BoX7FpGvttsR+p0AP+iIl8PAQ45gFuLdd9zJRwSaXxFnwCM8CJT1/K4v39Oq
	pS4/XjW4pntW5DWrFD9DHQdQiUAn+iLZ5izmWyNaqpB1CGTeVuJAO55eweo+G0zPk6f73oSZDVr
	BZdednr/NZdd+yW4acWuSdzd5vw==
X-Received: by 2002:a05:690e:4882:20b0:671:b05:7296 with SMTP id
 956f58d0204a3-6712455ccb8mr1798127d50.17.1789179153106; Fri, 11 Sep 2026
 19:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aqJr0ZB8qpthTEGT@pks.im> <20260910145528.309340-1-skariel@gmail.com>
 <aqO4OukzSa4SWcGG@pks.im>
In-Reply-To: <aqO4OukzSa4SWcGG@pks.im>
From: Ariel Keselman <skariel@gmail.com>
Date: Fri, 11 Sep 2026 19:12:22 -0700
X-Gm-Features: AcwNN1VFpD9pPPqtVzjsmBDYzMuk2oQC-MdWr_PKVk9NI_naaLfW1B3S8GCqmvU
Message-ID: <CAMuXvLCN9V7SHm-wWpZK6eFF6DzNr57Dj5=KpiFWK51a83duOg@mail.gmail.com>
Subject: Re: [PATCH v2] refs/files: avoid packed-refs lock for root ref deletion
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I accidentally sent v3 as a new thread. It is available here:

https://lore.kernel.org/git/20260912014609.535922-1-skariel@gmail.com/


On Fri, Sep 11, 2026 at 1:13=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Thu, Sep 10, 2026 at 07:55:28AM -0700, Ariel Keselman wrote:
> > Deleting a root ref queues a packed-ref transaction in the files
> > backend, even though root refs cannot be packed. For example, holding
> > .git/packed-refs.lock makes "git update-ref --no-deref -d AUTO_MERGE"
> > fail, whether or not AUTO_MERGE exists.
> >
> > This also affects post-commit cleanup, which deletes AUTO_MERGE after
> > updating HEAD. In a linked worktree with read-only shared metadata,
> > commit succeeds but cleanup reports a packed-refs.lock error. Deleting
> > CHERRY_PICK_HEAD and REVERT_HEAD is affected as well.
> >
> > Skip the packed transaction for root-ref deletions. Keep loose-ref
> > locking and packed-ref deletion for other refs unchanged.
> >
> > Test deleting a root ref with packed-refs.lock held, and check that a
> > transaction deleting both a root ref and a packed branch still fails
> > without changing either ref.
>
> Nit: this last paragraph doesn't really add any value, as it's trivially
> visible from the patch that we add tests.
>
> > Signed-off-by: Ariel Keselman <skariel@gmail.com>
> > ---
> > Thanks for the review, Patrick.
> >
> > Changes since v1:
> > - Keep the packed-ref deletion comment focused on its original purpose.
> > - Use one existing root ref and include a packed-refs file in the test.
> > - Drop the timeout overrides and redundant individual-ref cases.
> > - Add a transaction deleting a root ref and a packed branch together;
> >   check that a held packed-ref lock causes failure and preserves both r=
efs.
> >
> > AI assistance was used to generate the patch, tests, and commit message=
,
> > including this revision.
> >
> > The root-ref deletion regression fails without the fix. With the fix,
> > 123 test scripts / 4078 tests pass, along with 249 unit tests and t0600
> > with SHA-256 (one platform skip in t0600).
>
> Huh? I hope that _all_ tests pass with this, not only 4078, and I would
> assume that you verified that this is the case at least on your machine.
>
> > diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
> > index 74bfa2e9ba..65ca19e84b 100755
> > --- a/t/t0600-reffiles-backend.sh
> > +++ b/t/t0600-reffiles-backend.sh
> > @@ -519,4 +519,47 @@ test_expect_success 'symref transaction supports f=
alse symlink config' '
> >       test_cmp expect actual
> >  '
> >
> > +test_expect_success 'deleting a root ref does not lock packed-refs' '
> > +     test_when_finished "rm -rf root-ref" &&
> > +     git init root-ref &&
> > +     (
> > +             cd root-ref &&
> > +             test_commit initial &&
> > +             git pack-refs --all &&
> > +             cp .git/packed-refs expect &&
> > +             git update-ref AUTO_MERGE HEAD &&
>
> For added benefit we could even execute git-pack-refs(1) after having
> created AUTO_MERGE and then execute `test_path_is_file` for it just to
> prove that it really doesn't get packed. But other than that the tests
> look good to me.
>
> > +             : >.git/packed-refs.lock &&
> > +             git update-ref --no-deref -d AUTO_MERGE &&
> > +             test_path_is_missing .git/AUTO_MERGE &&
> > +             test_path_is_file .git/packed-refs.lock &&
> > +             test_cmp expect .git/packed-refs
> > +     )
> > +'
> > +
> > +test_expect_success 'deleting root and packed refs in one transaction =
requires packed-refs lock' '
> > +     test_when_finished "rm -rf root-ref" &&
> > +     git init root-ref &&
> > +     (
> > +             cd root-ref &&
> > +             test_commit initial &&
> > +             git update-ref refs/heads/packed-branch HEAD &&
> > +             git pack-refs --all &&
> > +             test_path_is_missing .git/refs/heads/packed-branch &&
> > +             git update-ref AUTO_MERGE HEAD &&
> > +             git rev-parse AUTO_MERGE refs/heads/packed-branch >expect=
 &&
>
> We could strengthen this a bit by listing the state of all refs:
>
>     git refs list --include-root-refs >expect
>
> > +             cat >stdin <<-EOF &&
> > +             start
> > +             delete AUTO_MERGE
> > +             delete refs/heads/packed-branch
> > +             prepare
> > +             commit
>
> We can drop start/prepare/commit here, those are optional. We can also
> drop the extra file and just write the data into git-update-ref(1)
> directly via the heredoc.
>
> > +             EOF
> > +             : >.git/packed-refs.lock &&
> > +             test_must_fail git update-ref --no-deref --stdin <stdin 2=
>err &&
> > +             test_grep "Unable to create .*packed-refs.lock" err &&
> > +             git rev-parse AUTO_MERGE refs/heads/packed-branch >actual=
 &&
> > +             test_cmp expect actual
> > +     )
> > +'
>
> Thanks!
>
> Patrick
