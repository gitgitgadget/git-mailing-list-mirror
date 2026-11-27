Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795755854;
	b=ursGSp094bkLBYng3bGZC5IPv1Vr0NBB0fc6zBksRcZ/zaZu0ECX+tDLEveznhaRQ81s
	 SnYzuMNIopd7PBCnT69wbv23vlqIPIrY9LD4yz4bobLrqjL9pgyBHP6YPlA0pErcOQT+i
	 rpvcnS7cMmnugIU6MLwX9UlRD5LmXcMhde5+zggGlVBuxXpXWKcP87BmoHoyB0CvQ8+Um
	 S3hL1+oR0x5tnVOqmv/dmvdE8WLSlbafu8EL203QVr2qSzjP9uWgQjM/gN0m3aIHiSR/n
	 v2F7sfzR41o/8lgdzkbtSyUKrSxGEDZh+8Z/Fs2zGCk/5lXM1YkzUPvEnaOoSzDE0LA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CPmrgKVB/hFXmmDMAIpb3Udfn0tYQkjwvrxGrSFYyBs=;
	b=nGY28ZKmQ4FZDDng8xlcKW5fYRIndCjUQ/4Jbmf9F5kDEI9JszOMfHtfBAlHAUVVc0T/
	 jmorj7qxOe6PCrQkfm5mHf3sz0muRjiwkbldT3DuYT0SIY0kW4Ty3cQz/z9gNosFHCgSC
	 mm164VtLi90BNuxpUL9op+raiFPGmxN5c1NN8s4kQh8/m4r0swQ1pJ/uqNxlgyFebGqKg
	 5NugiGDvxmbAkGsVhkujT3Q5/SmoiPE2L0Q7eIEPz8Kg1VGk49WPhdAc+paTa8HaNVKYa
	 POJtB18GhLhz/3OJ+5FncrmgbaNS+M5rD9R+MDXLpXBiwlwNPOU3+RomJFpI9nYGVuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=taBWj9ks;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BEF606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 05:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2BEF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=taBWj9ks
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91c1f548f87so102230716d6.2
        for <git@vger.kernel.org>; Thu, 26 Nov 2026 21:04:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795755853; cv=none;
        d=google.com; s=arc-20260327;
        b=ZEYttrw/NEX94IgHzDb22c4om3hgxmkd0BvlpKXSsZXP94It/LhvOEh5Hb1F+JwsRm
         nuvLjRwcFcmlD4HUjzkQzYXuBskufMfaOpk8GC3UKzbhCieGRDkriFH0iCzla7xM35Ud
         uFBiw8k1bHQKYSqrDKm8z3kcAYIuCgzVU4UDFEIUCPNSm5J4vQJzHFZ46I1w+kr9sbCj
         Ouxy9eRbF+tDCTiPysiVk6EywqyEgLWI4oZqitVTpPUSWbi4Vz156ccjT1nitOQ6lx5g
         bi18J8vvYnqzVEDTfagsFFlIn9SpYcbPsPyne+l1g0tNn7unWlSL5MilLnQIh1JJluuy
         a0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CPmrgKVB/hFXmmDMAIpb3Udfn0tYQkjwvrxGrSFYyBs=;
        fh=6HILABBcUpB6pi/G3nLkNo88znwOx4lWVOxvHj4y9KM=;
        b=X5+7S0sP2hPPgFBlB3Nf1cS5/vs7Kux4Zk7FNVBEvA5zon2kkb8xVhtgJ5AenMCqzS
         SlgydhK2X/j1jhQXGfKS9Ar7K8xA1Yn9uWCpyJaAZShhrMwfJTchBMePweN7/0d7mfrA
         /ppG/d2WVxMbb4dmpfg0ypLBUAM9Lr1d4TD/697iRcoGrMMwLOqf7nQFlvos81zBcGqm
         j5cdaYGeFcKShKZICiu9Rugw77daMdJj2Q5demYftqvhcoeRezsdi2m3TJlzcGZ+5jVW
         sSgahuld6J6ADlxJzfhbyY+IRaY0UOQab//fbReF0gh9R5rEr1e/DRPjj8e9GC71rXmC
         NZ2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795755853; x=1796360653; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CPmrgKVB/hFXmmDMAIpb3Udfn0tYQkjwvrxGrSFYyBs=;
        b=taBWj9ksOjVZRKP5Ku1JsKZegTQT1MHet1HLTr4tLMgvsPoWvRe7/UNavFZmN5KWD2
         yI8p5qr1VXNSHLaMaAvxT8899CzNXuaRNc2l//H7EreItHh4pndVWzstuXFsaRnAOYuR
         bDPBFbCZqyckyb8FogwZqZkJ8ahJzWqmb45+ES/BVHO8rde1H7CxNC54Ax1Ovf2LflWB
         hZ9w667bH1gjCypDQPl6pIi8SEy8lK2Ec4I2nIfZ0SihRYNoibG+1E9WMEJnpOpoysm7
         pLSNF/aRY/lK7ned0x2iECNEwBO22TKsYIaEn+IA9FCP+UTan7qPLH9616gqHB6F1Z+N
         63ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795755853; x=1796360653;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CPmrgKVB/hFXmmDMAIpb3Udfn0tYQkjwvrxGrSFYyBs=;
        b=KFiA4YVECioiIbz+R1lB5WiwhCUsmj+ir7ae+md7oX4sKDsBNgZCsJij+Dl20FVBqX
         SmzkAAVG4C6zYJfuoDEld1QEAzhrgY4Z9KrFb6iPIjL6BHK8pMEjVxQicQ60amBVYbkb
         DZL7QnJ901UahTu7Virl00JM0ZPClZimfTEPH6RSWn0/YqUsu01AtWo3NVyAwnnh3upz
         koFrwZWPJVUyiTzIFgoYijtzKrlEVjQ1/2KOylvqp350vOiUe/dT9Iam2mF+dwpUYgA5
         NGxnRIzovoxb6WcnL3jHOFLTNVnaZENrhTPZI0lZXhTakaMPcqIhAAQIXqp/ubX6fs0W
         xIrg==
X-Forwarded-Encrypted: i=1; AL+hErEN4le32/TGuF0RIViem2YFrqWiiDt/d7NP0zQKOhLbaEPYFk4/S3VCSytHPjHQOUzPBpU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kAAfrQ/UchK5WFbmctVLKpYlPCpfyssjdJU/9Ol7jMLeIrozU
	kKW0rgO8ftuymaLpMqBjAcKVT96ksrSuX0dnbQi1qo3Jdqdk0rwPWqwsQtHJaxMQ88cKXdYYOsY
	xVz2O2eMWhuMeGMjLBLyTk8729L6mXTTV2n3T
X-Gm-Gg: AZFdTZfaODjVVZtTsVlPK1/df0wOVwEPB4NNGJ4xpZyRVBNO1k5oqVJoIxtIvtNbN8N
	EcvxnanL2I/JBVbVE2kzQXJ8VTufOeQYi8uWFTmcQn4dgyC3rsVP67JGhHMZN75UAeGYbfFi/h0
	KkuCs5jwC58DK0QpCUF6oqZa1wwX5FudvmxDZYFerkkn6qYHq3I1qzJITDSvAwu+iI8gaSRmhVN
	/8POdR5reweXCfa16bBgFRhhNTg1oVxK69UrWKS3NV/jZpMVkHBvbJsngDYibmEyA+9Kzjr6ShG
	pzGtZLYbVtbEWRmLKBm+vbN2YZqcph2Xshft/g1yfQ1p9E3MgezbFnxTy9m+Dc9/VFAmE2jNswY
	GazqEZ4fpxnBqT0dcMUP3IV3TUn3Zfax6kS4IIH37K6X6B8FwcLkskR0W1oOvajCePmoYJA==
X-Received: by 2002:a05:6214:4902:b0:921:35a6:1a87 with SMTP id
 6a1803df08f44-92135a630fdmr446098606d6.38.1795755852866; Thu, 26 Nov 2026
 21:04:12 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2306.git.1794484985.gitgitgadget@gmail.com>
 <pull.2306.v2.git.1795273853.gitgitgadget@gmail.com> <435ca42ec99d0eed613621186306cb68def30e6c.1795273853.git.gitgitgadget@gmail.com>
 <xmqq4id6qakd.fsf@gitster.g>
In-Reply-To: <xmqq4id6qakd.fsf@gitster.g>
From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Date: Fri, 27 Nov 2026 14:04:01 +0900
X-Gm-Features: Aa3M54pbmFBZ3UtUFS7lZrOOHfvOPRJ3DMJswPTgW00fCCYqrr3smTmhcIeot4o
Message-ID: <CAF5D8-ve1dtYWUMDeiYYa0FpDOv3c=V4MAS49Awy4e-9iZy-xA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] submodule: make submodule.<name>.gitdir relative
 for worktrees
To: Junio C Hamano <gitster@pobox.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 4:44=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
> >
> > For a linked worktree, always keep `submodule.<name>.gitdir` relative
> > to ensure it continues to work when the worktree is moved along with
> > the main worktree. (This benefit also requires
> > worktree.useRelativePaths to be set to true.)
>
> Perhaps state the status quo first for future readers, that
> repo_git_path_append() produces an absolute path for linked worktrees
> unless relative paths are enabled.  This change applies to the main
> worktree as well whenever worktree_git_path() returns an absolute path
> (such as when GIT_DIR is absolute), right?  That may be worth noting
> here, too.

I'll update the commit message body as follows:

  Currently, repo_git_path_append() can produce an absolute path
  even when worktree.useRelativePaths is enabled, such as when
  running in a linked worktree or when GIT_DIR is set to an
  absolute path. As a result, `submodule.<name>.gitdir` can be
  stored as an absolute path.

  Always store `submodule.<name>.gitdir` as a relative path to ensure
  that it continues to work when the worktree is moved along with the
  main worktree. (This benefit also requires worktree.useRelativePaths
  to be set to true.)


> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index 461b682d0d..c3b3a2865f 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -507,50 +508,63 @@
> > ...
> > +     modules_dir =3D worktree_git_path(wt, "modules/");
> > +     if (is_absolute_path(modules_dir)) {
> > +             modules_dir =3D relative_path(modules_dir, wt->path, &tmp=
);
> > +     } else {
> > +             strbuf_addstr(&tmp, modules_dir);
> > +             modules_dir =3D tmp.buf;
> >       }
>
> Copying 'modules_dir' in the 'else' branch avoids overwriting the static
> buffer from worktree_git_path(), and converting the early returns in the
> later cases 2.X to 'goto cleanup' nicely plugs pre-existing strbuf
> leaks.
>
> However, doesn't the 'if (is_absolute_path(modules_dir))' branch still
> have the same static-buffer hazard?  As documented above relative_path()
> in path.c:
>
>     The strbuf may or may not be used, so do not assume it contains the
>     returned path.
>
> When 'wt->path' is a directory prefix of 'modules_dir' (for instance, in
> the main worktree with GIT_DIR=3D/abs/repo/.git GIT_WORK_TREE=3D/abs/repo=
),
> relative_path() advances 'in' (initialized from modules_dir we gave) and
> returns a pointer directly into worktree_git_path()'s 4-slot ring buffer
> without touching 'tmp'.  Once patch 3 calls worktree_git_path(wt,
> "config.worktree") inside validate_and_set_submodule_gitdir(), four
> consecutive failures across Case 1, 2.1, 2.2, and 2.3 (e.g., if
> config.worktree is locked or unwritable) will wrap that 4-slot buffer
> and overwrite 'modules_dir' while create_default_gitdir_config() is
> still using it, no?
>
> Unconditionally owning the copy in 'modules_dir' (or 'tmp') closes that
> hole cleanly:
>
>         const char *raw =3D worktree_git_path(wt, "modules/");
>         char *modules_dir =3D xstrdup(is_absolute_path(raw) ?
>                                     relative_path(raw, wt->path, &tmp) : =
raw);
>
> Of course, if we go that route, freeing 'modules_dir' under 'cleanup:'
> would become necessary.

You're right. I hadn't accounted for cases where `relative_path` doesn't
use `strbuf`. I'll fix it so that it performs a copy at the beginning.

Thanks,
--=20
Yoichi NAKAYAMA
