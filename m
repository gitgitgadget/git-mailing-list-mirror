Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233B2DC767
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937274; cv=none; b=i120Na6OosKYjZUp6+OjChK2rlL3weRgrF6/nftJozPBcuPU49jPmgVGKUAaiLCXMr44a2gNutUQghk0Jjgq6UNcN/SGeK3abjFPey2u+rgVgbP0jsEZ0/bnmxaaArghfm5De2BiSvA1CckaAr9juecRg4799mJDjpq8paC2GIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937274; c=relaxed/simple;
	bh=U1S9HnTRTVnVrGqY1gB7r9yvXq6LV3RZJSJGQ+zsnPM=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=GETMiIqB5EhwgyqGvJYsrb0H6N6a6IlubBBungsCJ+W5EdXcJeyI4IshBh9yYbF/KJ2t783OOLtiX1shjWyBKSQ+cfgB9KgVowmiRp5MzlVbP1SL60wbyvzgdsUq14viwNkAV6SEgyiFcxz6tHZMLx89gA85kxRdGjhrvo1a4Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcUcCvSr; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcUcCvSr"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6604df9ba4eso3775769d50.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780937272; x=1781542072; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJvMIyCVQ9yXeyx/nNh0BI//Oyjy8jKEqu6Xx8J87hg=;
        b=TcUcCvSrLCUcFVW1HdfvEnVA0MjfvKbi7J/mYle3Ol14bJyQKf24ch9XyUbxWio/cP
         XqVvmK0SMKdyMHt5NbfI4+cEnzpol0QKH2TBbyz5xUg8fNGAVF4pN2v9lWZLJ7he4TRI
         UL+wn+WGT7j62f4PImQ595dqB2ToK6Al3awkJGZZ2lFX06S6BMurAmvw7xXy3Ik5DLpF
         0NBtqtJ2PzrJw4Lg+2ZwSwNVdUt3ONqHKxHXJF4fJRjhG8C/2qe7ljssJZ+CL62D8F6/
         fF/fJfssd82fYwGGvgCIfN2yqDYPDTHdi+GNX84lnmIYCiFO0/A6Wb65pz7FDI3Q+XQY
         uVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780937272; x=1781542072;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HJvMIyCVQ9yXeyx/nNh0BI//Oyjy8jKEqu6Xx8J87hg=;
        b=oN+bgonKcwHQA85OsNp1j209a9T1EJxPom98CCirhOnXiyyfb0n0Rbw/fzXxMJ6q12
         hSeHrxSx6wQ4BxFX/PmPJFduF7naZks3YX7k7lPb/gIx7Mxg9mVjfL3wP3VjglFcoh2F
         WnSHQGcS29Z+Isrwdo77tzP7H/L9E2mkYveKXiTJ3wz0QE3fygpJgHGExpu6YA5sUrzP
         dTRYxPGIRMSYvOexlM+QcZJVvCgcBIK2O32Fx12bhQnA+kDy/nR4t9SnotgFKahgILqn
         VU9ogqrcv7wcU9/jPlfdiJs+hSZzjw9F4LUzXZBBtKzAk0VDgtRKHTF8L8iRrZ3Ck31h
         3awQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ItFpgpwRmwAhcbSx6gqiax6Gh3f+LNPQ5U+HpVN7vyQ7aq9Omn/y0gGqjf6vfVnuZPl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWb0o6fbji10cJsB2ax7Mki7OzG8wT2+gar309y+eF915/seiH
	+Y2t4waTn1CZjauMbgZlmNU+RleskxqAPTxuLT/5WoCf4HtCGWc7hJNO
X-Gm-Gg: Acq92OGLwlGos4aJKQ67I3JqDeFlnMX6qMAO8s54mo+PzlbUYA4lO/jw2QxKbMEZ2md
	FGilLWry41/O1IiuyQ1+a1BvNW6L7TV5+Dkt2xwTjyWYFWxMQxnHQuCJc2zDlWyut5zNVjCIB0g
	rynmServIQVWufLi9P/H0mXZ5PGh0jyJ3A8XI2Qd+OhZ9uYaeQDLUS75XtH8hBKGIh1E7JM/MzY
	WSi7Uw81gRrU/Vt1R/G9VMK9ku/Ahnr1pJdhVMZH6He9WV1CxI01mIi/uhRcxpK1ub5ETcGPkn6
	tuE6xUeAROkJupGwifaBAwLfi7JBfSwJ+cotyQ55Ujso0rTOuNqrrXcpG0WjiRiwEJNHvgxM268
	YDAyYrD02EcZqMn2pQs7q627tYKz3Qp4PkIFHpWTH6xrSTUzLOV6bQwkXR9YFO0db1mKWO61aGH
	o2dknD/94wnHMly7FTxuIdq0SlGs0vn+bXyZ3U20TYhbMgpcz4urBZpdu3zvxAvbAQUh1/IBCUr
	fsb6gYWj6L5njwnsDwqgQL7vDxam+e3oFwqWWpM6cU0+bbb5BGVJHid
X-Received: by 2002:a05:690e:1242:b0:660:431b:8a5c with SMTP id 956f58d0204a3-6610a624fa8mr10283675d50.4.1780937272220;
        Mon, 08 Jun 2026 09:47:52 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:4dd7:1401:a55e:b40d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea986bsm86611337b3.9.2026.06.08.09.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:47:51 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC 2/2] builtin/history: print feedback after successful reword
Date: Mon, 8 Jun 2026 12:47:41 -0400
Message-Id: <9C91B027-C24A-4D7B-A3BC-5CF3B04D990C@gmail.com>
References: <CAN5EUNQNj86Q+hi6PouOZNWo1T4QTQ6sE5Hs9USZXWpkTedTcw@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAN5EUNQNj86Q+hi6PouOZNWo1T4QTQ6sE5Hs9USZXWpkTedTcw@mail.gmail.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 8 juin 2026 =C3=A0 09:29, Pablo Sabater <pabloosabaterr@gmail.com> a =C3=
=A9crit :
>=20
> =EF=BB=BFEl lun, 8 jun 2026 a las 14:16, Junio C Hamano (<gitster@pobox.co=
m>) escribi=C3=B3:
>>=20
>> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>>=20
>>> Unlike `git commit --amend` and `git rebase -i`, `git history reword`
>>> doesn't print anything, this makes it feel empty for a porcelain command=

>>> and hard to tell if the command did anything without using other
>>> commands like `git log <commit>` to check if the reword was done.
>>>=20
>>> Print a message on successful rewords so the user has feedback about it.=

>>>=20
>>> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
>>> ---
>>> builtin/history.c         |  4 ++++
>>> t/t3451-history-reword.sh | 14 ++++++++++++++
>>> 2 files changed, 18 insertions(+)
>>>=20
>>> diff --git a/builtin/history.c b/builtin/history.c
>>> index 51a22a9a1c..0f1ba3b531 100644
>>> --- a/builtin/history.c
>>> +++ b/builtin/history.c
>>> @@ -739,6 +739,10 @@ static int cmd_history_reword(int argc,
>>>              goto out;
>>>      }
>>>=20
>>> +     fprintf(stderr, _("Successfully reworded commit %s to %s\n"),
>>> +             repo_find_unique_abbrev(repo, &original->object.oid, DEFAU=
LT_ABBREV),
>>> +             repo_find_unique_abbrev(repo, &rewritten->object.oid, DEFA=
ULT_ABBREV));
>>> +
>>>      ret =3D 0;
>>>=20
>>> out:
>>=20
>> Do other commands in "git history" (split is in 'master', drop and
>> fixup are cooking) behave with similar verbosity?  Consistency within
>> the same "history" umbrella matters more than being similar with
>> other commands that can be used for similar purposes.
>=20
> They do not, they are thought with the rule of silence in mind.
> However I think that this output is valuable information I might have
> explained myself better at [1] but my thought is:
>=20
> git history reword aabb
>=20
> Now that I have my commit aabb rewritten I want to check it again just
> to make sure I did what I wanted correctly,

Some thoughts:

- If the rewritten commit is an ancestor of HEAD, look at the log of HEAD@{1=
} or the log between HEAD and the aforementioned reflog entry. (git-range-di=
ff may also be helpful there.)
- Similarly, if the rewritten commit is reachable from some ref R, check R@{=
1} etc.=20

> but git log aabb is still
> the old commit, the rewritten one has a different hash which I do not
> know unless I search for it, if it's far from HEAD I'd have to git log
> --oneline, get the hash and then git log new_hash. I think that git
> history reword that does have the information about the new hash
> should print it to avoid this search.
> What I want is something like:
>=20
> git history reword aabb
> Successfully reworded aabb to ccdd
>=20
> So I can just git log ccdd without having to search.
>=20
> I want to say I haven't looked as much as I'd like to split, drop and
> fixup, but I think it would be a good addition for them also. On [1]
> Patrick wrote about a --verbose for git history, I think that the
> basic information i.e. at reword which is the new hash should be
> always printed but if it's preferred it could go there.
>=20
> For split it can print the hashes of the new commits like:
> "...split into ccdd and eeff."
> For fixup the commit hash also changes, so the same as reword.
> The one that will have more friction would be drop is the one that
> doesn't end up with new commits.
>=20
> [1]: https://lore.kernel.org/git/CAN5EUNSAOMRvmLGVfzQiwWoOn9VGNVU5rVMZizOr=
yn_q2fbCNA@mail.gmail.com/
