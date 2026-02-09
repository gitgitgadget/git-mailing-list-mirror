Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68C31E7C2E
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627735; cv=pass; b=CtFUknDNaoJZkkCoea6Ghv1Gn7jrikqOxD0o9KIXD7IxZ90l+tRXW0Cr3lxp6icyNQ+eZo121CLG/xk17Y58SSKZBZWfunpC0Y1m6rlVTI3jnLGQk3F4uPZdcD2I8a7H+t3eGWlDzvx+lHWY8yyonaqBvRwmdFrjQ9SuWSp0hTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627735; c=relaxed/simple;
	bh=8kcZb+PnmENFDZ5foYlqeIVT9nTQu9WjmMtr8IpS5pE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPtjf2WFW0FtGqIqdDDOQ/86KkJ+6iUYJS6gBWfv23lEb8YjRYm1eQHbljUvgPKpuMZn7OScdK8lvf74uvTJ6SlZYHxQa9L+VvZbeRJPqPvJiDBX5bmGy9zcps6ZmCpmO+QhW6wyIyQ18b8Tfo+MTui/Xbpi3zBJW48gdu6mnBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAyLt0A4; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAyLt0A4"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94acb3d6cceso670211241.2
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 01:02:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770627734; cv=none;
        d=google.com; s=arc-20240605;
        b=bIbkOvUK0PSow0Xx2EOKonxrv7Xsw5BmjvZc0iQjhP8GVRpr7SuRnR8f1lL5as4Wmi
         Bpx9YMRxt2h7y5nPiC4r8+4vNaV9cl9x5zJfm3Tm/o4wcG9XueZhFb9A7aJ2JwYBC8pY
         VLpmvtJJovcHzAkFDK5hbVOQAMd18fyoVLj7CRcpR9NdGr2doPrVQ8aZPY1ijJDlm2dE
         wHdj4NYDeod8QZzneJMif++/eevapAc8f4wYuu1xEaQBamgY1XqOK0BtXlXVywLawPVm
         U8sBf135udQK3yislFLa7nONX/eH+iwpK6K1H2drBaffaQ9e+JmSliZvVbGtkOhjLQtY
         F8Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=yghgKHSoOv5sGvs6wZ58u4UbyC8WfxfrKqJIy6jMpbw=;
        fh=OKF0WwHv+iEEvf4wXtW8IYLPavoiJm4Et2FBGP1+bQ0=;
        b=luVU5dglZJQ++6zYurQxnaQLxDXMRmQP2weTIALsR85Vo7oU6qWVgMrY7m/sLG7Dql
         Ld9u98wqHo0n7r11tPS8HO54a2PA1hbccmR8o511LifO631hdeSwvvkPfrWDEGYITdZX
         jQDpWEh36d4rn14OJsH3qg6Pc77gLap2SPIKcqogSyzNpH9hNs3cx+njlqrdwVDCPYk0
         ZKKMkJ5h32442B6SgHlNibJHxW7F0AfcN7uGwApI1jUa/dhhasU1eersEgj1DbSgZ878
         4VbYBfv36RCyKQqohkzSY2okJm/bqXXv1N9fI5RKBKwaCAuvWKnO3/56t9KRdOIvsQ7b
         h1VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770627734; x=1771232534; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yghgKHSoOv5sGvs6wZ58u4UbyC8WfxfrKqJIy6jMpbw=;
        b=AAyLt0A41+7dzK/ZH+pCHqd4qCHpJw7Yijsy442Jdh6tj8Dw+yNEy+AGdLae9Ycp/K
         Lo0YjVlZ7rFC8jJE6fR6InVvgDy7JptYvYWQLPF+G94E963R+b2QGoRt507Mt5iupBIB
         Gm/Eoya5oPcma2CRPYC/xzugO4rD1i0yiN5pan4QU/IHYbZZIRB+PpQ0mipR/D5GYKql
         DpIHGkyIv9h3FVHd0LO5dxKCZWjb7NxSnOrmIns0/qPWFFqqOBlgQ2dFv1zUbjK0ulRj
         j1R4pv3oU5mm3CErLMV2IF2rGcKe6E2P9pgixip4bTtBFakCCsPC0xaTUwM+5xu63DTO
         B6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770627734; x=1771232534;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yghgKHSoOv5sGvs6wZ58u4UbyC8WfxfrKqJIy6jMpbw=;
        b=s8J+miEanaz5JMbQ+IIwW1KjBqH5xURQA71LQ9IhaFIONyaFkM3jXkbLVBscdipHAV
         d9M24b5LTMO+0mOUjfUTc1Zv/ZjpNZTfXzCu3/wtbIZfiaHTYubOYyEPbxMP9R/GsyVh
         3N+RB6wsBxrhZ/wX6/2af0gCB9RdkWxWHVFUJNBjTx646x/vroNiYUIgBbmGiXDpuJtx
         BU/6R9rDwNYAwK2Ms2T7UR4EdP0kP+jFIg3c7jRY2moXpgPbuTtS9IVFRa3kGX0XMnck
         JDbCboUdwTWPoKLYCksf+nJBFslBKbYWURwmmuFV/FwXTCQuqDBb2t4lN6HbWmfSAoa8
         rYoA==
X-Forwarded-Encrypted: i=1; AJvYcCXWu9UDzhvEQMom8H5bOJWkPgcIf3oXxIo6S3obq6Tfcb9jEiCWukLVUC2gb9Nv/TRNvkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWHbteO1dKMVJo0Vjc+plFzW6nl9omXHSAwTWZCM5Q5J5js1fT
	cRcVeXW1G3PRp1oAatzNs3wkbL1bBRKnbKGAyltbLs7ZSjEax63yIGA6cFaBp3xji1ajozH5I7t
	ygv14OZ9dQ8KbANpOfOw3pfQ6bl3deYY=
X-Gm-Gg: AZuq6aLd7olPxz2V20QerAMASqzafqVlOBa59j9yhBqxB6t3iF4KbZhZvWFHXxLByYW
	Qg01eJfhVUTfLlKyc7czleoXld4HfFq7TK/MLWqJ87C6A5ZBmAbpFnxz9LUcKmMPVymyDXFkblA
	r9ivQEuWYF9MCw6o6qicxn/Y2Db3SAkElRJt3RW7Qj6eHKZuAQY3KflR2pxw/yy2hg9nOR5MVc7
	PkvvQl2VkcDsb2ohrnGxkNfOkzxUc2D7xxGFOa+obT/JfdJd+AFe6FoBYFf9s8nAZkgoZxgU6/k
	nr2hMmRwpjnh/5HGomBw83Acm9F1tw==
X-Received: by 2002:a05:6102:441b:b0:5ee:a590:6b11 with SMTP id
 ada2fe7eead31-5fae8c12648mr2779849137.36.1770627733728; Mon, 09 Feb 2026
 01:02:13 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 01:02:12 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Feb 2026 01:02:12 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260208152811.73213-1-shreyanshpaliwalcmsmn@gmail.com>
References: <xmqq4inrahti.fsf@gitster.g> <20260208152811.73213-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Feb 2026 01:02:12 -0800
X-Gm-Features: AZwV_Qh4klKyY10ZhkxGr4jCri2Jzd-9rbjzKcAhIn2tCuCW4-_PVEs76KzjCk0
Message-ID: <CAOLa=ZRaWA14sootWSPo5g4Yi4GBXf6HjdkdBY1Tt_+V0szCjg@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] wt-status: pass struct repository and wt_status
 through function parameters
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="0000000000001950cb064a606564"

--0000000000001950cb064a606564
Content-Type: text/plain; charset="UTF-8"

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

[snip]

>> > Actually adding another repository parameter to both of these functions
>> > is needed because of the calls like wt_status_check_rebase(NULL, state)
>> > and wt_status_check_bisect(NULL, state) from wt_status_get_state().
>> > In the case where wt is NULL, accessing wt->repo can lead to issues.
>>
>> But stopping thought at that point is not a reasonable thing to do,
>> immediately after you notice that wt is sometimes NULL.  It merely
>> means that unconditionally dereferencing wt->repo without thinking
>> is not good enough, doesn't it?
>>
>> And what is the case where worktree is NULL?  What are we doing with
>> worktree set to NULL?  Is it when secondary worktrees do not come
>> into the picture at all and you can safely use the_repository?
>>
>>     ... goes and looks ...
>>
>> Ahh, I think the real culprit that needs cleaning up is the worktree
>> API, where they pass NULL to mean "the primary worktree that has its
>> .git/ directory at its natural place".  So it may not necessarily be
>> the_repository we are dealing with.  There is *no* such client code
>> right now, but we could imagine that a program that starts in a
>> repository visits the primary worktree of another repository and
>> asks the worktree status there, and once such a client code appears,
>> we need to be able to say "we are dealing with the primary worktree
>> for this repository".
>>
>> In the longer run, I think we should fix the worktree API so that
>> even for the primary worktree we will always have a non-NULL "struct
>> worktree" object, perhaps with its .id member set to NULL to signal
>> that it is the primary worktree, so that we do not have to have this
>> strange "we must pass repository redundantly even though we are
>> passing worktree" API elsewhere.  Not just this code you are making
>> worse, path.c:worktree_git_path() already is a victim of this
>> misdesign of the worktree API.  It has "if wt is given, then the r
>> parameter should be the same as wt->repo" nonsense, which we
>> wouldn't have had to have if we had a worktree object even for the
>> primary worktree,  Look at how ugly that code is, and weep X-<.
>>
>> And the same misdesign of the worktree API has caused your [1/3] to
>> pass 'r' but yet still depend on the_repository, which you had to
>> fix in [2/3], in this function.
>>
>> So, I dunno.  If you are ambitious, you may want to clean up the
>> worktree API before this series.  Alternatively you may be able to
>> punt on the parts of the wt-status that interact with worktree API,
>> and move the rest of wt-status less dependent on the_repository, but
>> I am not sure.
>
> Thank you very much for the detailed explanation and for pointing towards
> the bigger picture.
>
> From what I have understood, the worktree being NULL refers to the
> primary worktree (as it does not indicate which repository so it means in
> respect to the_repository). So if we want to access the primary worktree
> of a specific repository or even the local repository, NULL does not carry
> enough information.
> And obviously, using NULL as primary worktree introduces extra checks and
> measures as we saw in the previous discussion.
>
> I would be very interested (and the more logical step) to fixing worktree api
> first, and then revisiting the wt-status series on top of that, once the API
> makes it possible to rely on wt->repo without the NULL risks.
>
> So a possible in the worktree api cleanup approach could be,
>
> * Make primary worktree as an instance of struct worktree but seperate
> it by having a marker like id = NULL.
>

I would like to point out that we already have a function which provides
a main worktree, see both `get_main_worktree()` & `is_main_worktree()`.
In short, a worktree with id = NULL seems to be treated as the main
worktree.

The harder part would be correcting all code where `struct worktree *`
is passed and has special meaning for NULL vs non-NULL. See
`strbuf_worktree_gitdir()` which also distinguishes between `wt ==
NULL`, `wt->id == NULL` and `wt->id != NULL`.

So cleanup would require identifying all such spots and fixing them too.

> * Add this primary worktree in the struct repository (e.g. repo->primary_wt).
>

This also is tricky. We currently already store all worktrees in the
repository in `struct strmap worktree_ref_stores`. Here, for the main
worktree we use '\' (see `get_worktree_ref_store()`). So perhaps we
should formalize using `\` for the main worktree everywhere.

> * Update/add functions, then find places that currently pass NULL
> and convert them to use primary worktree object instead.
>
> Let me know if I have the right understanding with this, and also would love
> to hear more guidance on the direction with this worktree api cleanup. Thanks.
>
> Best,
> Shreyansh

Karthik

--0000000000001950cb064a606564
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 841b38bd8e7c159_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tSm9wSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWoyREFDWGRPYWhaMzNoMVRaVHdWRTdaenVvK214egpUaDBJWWQzMmIr
SGgrVUY5Mm8xeWl6S0hYejd6Wk1lNnJrRHhZb01MY1YyVVpWWFExcUoyamVyVWsxNW5ldTJwCi96
ZVplYmZXRHRUTVFIeUdwamlaNkhzZmN6Z21PWFZmamNYaGpjU0NZclVzUUVDUXdqd3dEd0dYUnlX
SjN1UGwKTmJsYytDSmluN0JJSTVqcFgwZVpQeGFNdndqRnYwR2dncUpCdG1kQXQ1WVRHaVo4VDZp
azRBRm50OWRHakxDRQo3dVl2WnhnWGE1WGxUTFIzQnZnK20xMFZiSWxVTW5sclhaM0JqM3h3ejhT
NUN3eHNzdjR1aldZdEdyUFlaOE0zCkVQWU5YdlZCS1doNGNMekZER0RJMUp6QXM3MzgxYjdRNGZu
OHQrWS9ZTEpUbzZ3S2NzK1IvSm1NTTVZbnllSkkKNlpJeHlmbHVpeXdlczVNZTlFVldVZjBoYVh3
b2FNQThDTjlMUlBEQ1BEMGlUTHNYTkw1QVFKcUtnVUE4ZGFmZApzZHBKa0o2Zy82ZHNGcG0rQitz
dXowYVJNN2dJeVBUVmk3WThYZ3lqaEVUZDkvdVBUNlZmOE9HWHY5Q2oxcjdrCkh0dVdtZGVReS9q
a3NYdUxVUnZ5Q0FYT3RHeHBWcTFLWm9rb2FIND0KPTNZL3cKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001950cb064a606564--
