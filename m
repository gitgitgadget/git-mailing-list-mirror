Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555C44DD3B1
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790353558; cv=pass; b=d0j+bznvP01PKKSJZtUqtRK9X4r5v619LzN6uRmrNerg/eYf2ORFdBr0TDAhUwn74QExYJ2OS4+4JhkBvrzZzxdgyXn7v+ap8eFkCh+8BFWkLQ4EDhULgP/5NxBVXHzGmlTz38AoiA/8zxzxaYkqerDRj3Sxed1iUaQSjH3YoFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790353558; c=relaxed/simple;
	bh=iP1D39TQutzlpB6buGtzZ/GBJzuQ6HBvbRFJ+2gXFGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkcNKEVNl1dSWN1Ki7aPAk2QpWcBGSBMKA5II+BaN4432N+XwrUe3PQyiIsb3CdEiYJ8hkOd8PvgTjEnWVV6OShF1Kwx0pQOi39GXdmkRZrFnJVNdvT+QJacg8YXY+uaNjaTovLKg/w3bUKjuVcn6+gLF61+81S0G9vPd/aCrFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOoaASX2; arc=pass smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOoaASX2"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so4981495ad.0
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 09:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790353556; cv=none;
        d=google.com; s=arc-20260327;
        b=rK/2+HJgJmBUtlz4E8dYrS3sT2hZurkqV3pnqKKPV6MW5C7XMvxOzDdzLn2w8/v+I0
         eSc48JrWsEKRqN8sMLH1AUeGzOY8YZcDcwjBwRV7oIkjaeZb/fGULMN4DPKlje2PRqpo
         0p6UTRWu9ZPr0XO33cJpPngmX+0SkmyXmNcKogCNiyeVkVYJQbWMEtedctU8Kk0bZXwz
         Rf//9CKrRN53Bq/HQHJonx1jJNBOM0e9lptC9MuSatN30jlIkgLqXSPLh5DMDCITLsBS
         5ryGb5j9OmhIA/6ArlV+v0944XlGrZIxWlDyrZM+I5DgHbBeFf9D5z8LwjeLgpbPcKPS
         ecqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zBOhlaymB1SeYX+/62oPSHG0jWklDenSUEeP8555XqQ=;
        fh=SMcdeyh5Ydll3uJ2fNj3zdbWH6sdNhaXZDFdUs18jPo=;
        b=anKUt+JrZXgFAk3em0n6/L6dgFbP9HXCUIJbW2AUWfNyhkKKm0m2R04se88LeUGLD5
         bIzoNPAvY0sdTkoabW6AQtc7Hov1YVMzjHcCdJ8T5xqDNKmhzVCcbJXpjJKPQAb4PEkg
         r7H5pbMXI8yw/TGwcgFY6xTDFRQ90d8FpPhTN04E7HgJ03lU0YHIAELYaJ5WR0A4gX4I
         VVV8pZ8SDpoaslar2VfawcOoGEZofP6CQMju8vKWv7YaL9226NDHHkXn6MSEsS+dfeh1
         Bu6oS6xAQeewnuOczj3PUP41h/wtbMRau4Cl4/4XMY18CkVqyAqoDx7+hYlDfsjf3cV5
         C6xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790353556; x=1790958356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zBOhlaymB1SeYX+/62oPSHG0jWklDenSUEeP8555XqQ=;
        b=TOoaASX2ORRoP9bEENWHPwefO5wwHhku7J8oOYg2Euzw3oBEYDHx+LtTsubQ586vTG
         BWP0Az4RkqCaqhzmOQlaY0Thcu3chhfL/4EuFy08IkKSPMpHm7GkXqQmGkF/vARruAzQ
         DVNmIJzNlkpsbek3QAOPRdaNZjt7YZNqbB2akYCRdRX4FX8qsV30Uo/53/vj47aUH2fh
         fS5brQlSzr+ssstGOb5DUZthxCslyqu2I/GYHiyJhxpVwfDJrqtqpUv6gaoRPFxDdTHq
         8SER45HZPH+NUJq4CG+LdcNnYh6226uiYDGnUAbaWg5Xy8xm3I8LOv3oONl2uqCG8yvn
         WEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790353556; x=1790958356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zBOhlaymB1SeYX+/62oPSHG0jWklDenSUEeP8555XqQ=;
        b=LA49YLho1h28nbdC91TJrM3KcnFzqbTC2wl1SF3nwi4SuWmGjsnq0TxbAJquySEz2g
         p//ASi3Pmai8X2F7Mr4rpjdfRmgVFmnZi8CxIsKm8zVcg3Saj3JsUufRFQcaPj742bvv
         MFb99RHE8/EHmcy39KVCjY3fQyPlWKlDObQ2IGJwQA7+TZu+XiFB4S9hnUJ1GE42nIx5
         TrCSi6eFwPJI0XBQTfZOnQYnhbDEYAqhjCyBEGuyKcJhGp1X6liGGo98IP40GQ190JjB
         3ViI+X4xCnLgZb8WDMeP6vdvfF9VIQoNoodCn4D+XCFlpiGarLHzjelhOYS52O94alkh
         cSEA==
X-Gm-Message-State: AFuF++n6ahF3jMRYvaqNMJc6GaSRCfuRLE9MTd/q5237QY8tbRmJ1MuT
	KzUgaitjG0jYOEpudNSCVYg6Dq3lU5L+l43rrMgvGDgXKU7WTgqaMRq0s5jMCahxHJJ/bAkQVjq
	BlzuDcTQRCph7cXeqwIgPh67S7Tufcw8=
X-Gm-Gg: AYBFou0MYBrGCAZUz5RF0Lb+4Sf5cnuvQxU6BjhvQc687+0k62jbluCMLtNxiT09CWN
	tq3mTsKkXCx5wUpmIZ3KWzg9nh94TxiXktZ/cH+maYXzjDoyOBu+KgjhMai7dOAR+MMUSA7EbVB
	OIhqoaPh2mOPvsFLg0to+EuVAoK58hHWjkPF24rA0gc0vNHvw+pHQjGp++tY4Yh4y9XvX7RO2NX
	27cRdseHKlP9kERPt+LyYFpAwbjBVQdt1h0auVvKalzdRT4jLgMVqdXW4g3xDrMLV9n0LEDOB8I
	ONQbA342yAr6HWpAcvtNsKmRZwoEyk2QyGclU/JbpaObAkRdNOn/jkyum2zsOYKwp8XXOkcee3H
	BKUQEohmuD6GJ4pUSsmy2DLD5OwCS+XNrys3yy6ts8e2j6eotlLfpR+5E32Byh6LNgppwrWvBm7
	K1OmyQq5ItjFSPHIasarcvULKaRQILjA==
X-Received: by 2002:a17:902:e74e:b0:2df:8e8f:8d8e with SMTP id
 d9443c01a7336-2df8e8f94b7mr30263655ad.26.1790353556431; Fri, 25 Sep 2026
 09:25:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 25 Sep 2026 12:25:44 -0400
X-Gm-Features: AclHuK8FbYDEnd18A2dOBR8ov4LRPOWxmUDq8P3utvNge-pLTaanjkioHu6zwdE
Message-ID: <CALnO6CA_=OsznkQ4iT0vBMWf3L=bmVKMBdk1MTHQdaKEcKwn4g@mail.gmail.com>
Subject: Re: [PATCH 0/7] [doc] Add new page on merge conflicts
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A big thank you for working on this.

On Thu, Sep 24, 2026 at 10:46=E2=80=AFAM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Handling merge conflicts is difficult, and currently Git's guidance on me=
rge
> conflicts isn't giving users the information they need to navigate the
> process. As usual, the process I used to write this was to collect commen=
ts
> from Git users on the existing documentation, and then address those issu=
es.
> I listed the specific issues we're aiming to solve in the first commit
> message in the series.
>
> This patch series introduces a new manual page, gitmergeconflicts, which
> explains the process of explaining a merge conflict with examples. It als=
o
> links to that new page from the commands which can cause merge conflicts,
> instead of trying to reexplain the process every time.
>
> This is a pretty big change, so here's a list of things I'm still
> considering in the hopes that it'll help with the discussion:
>
>  * I wrote that git commit does the same thing as git merge --continue
>    during a git merge , but I'm not sure if that's always true.

See also discussion in
https://lore.kernel.org/git/CABPp-BEQSx4m3BcT28CpVGCtsH75+x3gmv4OJz_ecLVLx+=
kBWg@mail.gmail.com/T/#t

>  * Right now we're listing git merge, git revert, git rebase, git
>    cherry-pick, and git pull as commands that can cause merge conflicts. =
I
>    believe that git apply and git am can also result in conflicts when
>    applying a patch, though it's a bit complicated because applying a pat=
ch
>    is a different operation than doing a 3-way merge and the tools availa=
ble
>    for dealing with it are a different. My thought right now is to avoid =
the
>    issue of applying patches for now (because it's a whole can of worms) =
and
>    instead just try to not imply that this is necessarily an exhaustive
>    list.

I think that's a good approach!

> Also if/when the git rebase --squash changes land, then we'd need
>    to add git history to this list.

I imagine you meant history squash? I also thought that history had
punted on how to deal with conflicts (rejecting any operation which
creates them) for now, since we don't have 1st-class conflicts =C3=A0 la
Jujutsu.

>  * Instead of creating a new page, I considered using an include to have =
a
>    "handling merge conflicts" section in git rebase, git merge, etc. Merg=
e
>    conflict resolution is complex and it's very useful to be able to incl=
ude
>    examples: this version ended up at ~300 lines and I think that's too b=
ig
>    of an include, especially for short man pages like cherry-pick

Sensible. I have often wished some of our includes were actually links
to separate documents, to keep overall document size down.

>  * Explaining what "ours" and "theirs" mean was one of the hardest parts =
of
>    writing this. From polling Git users in one of my many informal Mastod=
on
>    polls about Git, my understanding is that Git users are actually
>    relatively unlikely to actually reason about what "ours" and "theirs"
>    mean when dealing with a merge conflict, and that most people prefer t=
o
>    get more context instead, for example by using a mergetool or by using
>    diff3 or zdiff3. I heard a lot of "I can never remember which is which=
 I
>    so I don't even try". So I put the information about what "ours" and
>    "theirs" mean relatively far down the page (with some cross-references=
),
>    so that it's easily available but not the main focus.

I think the biggest reason to (ahem) reason about these is if one
wants to restore --{ours,theirs} or restart and try again with a merge
strategy -s {ours,theirs} [rare] or merge strategy option -X
{ours,theirs} [less rare].

But, leaving it out of focus makes sense to me!

>  * I removed a couple of mentions of the various _HEAD references. It's h=
ard
>    for me to know exactly where they belong because I personally have nev=
er
>    used MERGE_HEAD, REBASE_HEAD, ORIG_HEAD, CHERRY_PICK_HEAD etc, and I
>    don't know how they're meant to be used.

My most frequently use is "git show REBASE_HEAD" (which is what "git
rebase --show-current-patch" does, albeit with more typing). :shrug:

--=20
D. Ben Knoble
