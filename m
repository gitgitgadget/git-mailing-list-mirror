Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794250763;
	b=KhphHIJvGJ+AWf0NLslUnnwI+xoiHtc5HSpR/w+7oPCuagG4yu1ahkMSxPHU38kKZPad
	 AUFOcawAJLIrRt20PBdmomVAqWeW0AVRWcxcg4OJ7S617mUvDXAjJDg9MFaJDI4lb2HRo
	 DO92YASLewvURbjErkMOpv2okQQV1QsclupFLVfDmnrGvT/jRAaRsL9t4bH3NkPbIVqqS
	 krvR6Nudeq/NYxXZpkM2i1BP2vmzGj9hvJ8J9xzc/8ZlJffMc9kWBmOel3RzlyFGK916G
	 rfOEZxUMM0x4uCggXcpGiZsFSKevRYFNZGU/q65jPZPdpoZofNwy1wxYriHVQ9rAN1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/COnO9dnKjvbNK9djz5XaFLsfrCcAvuowKtvzFXEA5E=;
	b=Eef9kNVEBRUEBnOCrwETAMgIMLa+Aqd4vygn5ctRu90xlPCgrdixj2HDuTCupXWcurf9
	 FMqSbLpFkMIPHJO4yKcbuNjdb5/g5D9mV2rUt1OGVdrtaK6Lzv0JEjwd1ZHjZKQe1XV8Y
	 PXMv+JPTT7DjpuYcBvNQDipMCs0Wf/Q10Un2ZWjTVKbA09r5tyEcYv0/QfqsPMgJTTEnR
	 hzTbZguBk8qZww27gXTy8pbw0wT5HO4lQrzYkcIa98D7jYSaQ1zimEXeIoPPS6FO2q/Lo
	 coKcZzA1qqf5TaE0srHUwERYT1o1bSO7n0Jd/Kg1xcv0EVmTBbMB0oTx8xh5kKkZQPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZP+pxIYH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B51606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 18:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06B51606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZP+pxIYH
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5366463571cso14651511cf.3
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 10:59:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794250762; cv=none;
        d=google.com; s=arc-20260327;
        b=AYaULdmVQg6m1abqC8JGUQliHNnyCvX+JnjIZ5H8TMPrw1fNfhSl1TCg97BB8oa/HT
         cGw7D+am1TmWxFlpzSLd3TJWGRVARP0+4QegP6B+3BOK1as1UNITHiIyt9ybtf5Mib94
         vUe8188XtGvwARMqvLy8WbvRxY1qJZo1O0pU6GOdjvFhOmVh8J41IpQAlq1mDLue6xyL
         gEzY4kNR/SE0XPI0FHqYyGfxFqD1vUtEaE2C1taejusgXssR7mEA5aINpcZe2epyTgLO
         ruH5jNz6xTCz/6xnUZHjx3bjJDcmb74+wqZss+jOGtb7N1gGYj/6SsxV3iXIN7PTiLKH
         db7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/COnO9dnKjvbNK9djz5XaFLsfrCcAvuowKtvzFXEA5E=;
        fh=TkCkMTSg7nLsSbRYBdn7vrS7QlHCcgz2mDcBjyLFqNs=;
        b=nYXuqW6x5DpFpwKvGIQerTKCmBfYI7laxvGPQ6LK8b+Zn5Xcxy5yhby02kujDyUQJH
         KXzqtkrneznTJ9qTZKqNXgWadNKCCgxlyoEjWeR1H9luDewnASbamMvOOftPxBGDBvtr
         EjrW/jjXomSNdzR27fPqKGP4T/kUe1Yb3slogBDGoaF3XxihMIcLrjvjDo79FnFLng58
         oQ9tqB/t+GnGvL6dOzNDqMfFm5DdTCY1bqPbqzbQDVVB7SnYWuKrJGwlk/r+dKuwwhF8
         0wsBPqX1sJz7SNnddXo2oSmkZ+NbRKTCWIAkhWeE6zXUQt6JAak3ppnyxEKAq5JPa8Vx
         mUPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794250762; x=1794855562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/COnO9dnKjvbNK9djz5XaFLsfrCcAvuowKtvzFXEA5E=;
        b=ZP+pxIYHByY/yx77qsQMGTiP71HYrRqKEXQ23Yl9R4dKa1tXrvW3ONZUdl/MP+UWgi
         z3fZZwMVrt80rbl+BzmJPLPGMvAC6VeiRSGGQzbMDxazzpwWkUj+mI0mUrVHzGAbMr04
         kVInu+CuBQrb15kNGLrggzmEDcHAAPs41h0cSnR5b1cEVJJPyWvhKrNRysQ2fZJAzMCX
         DhV5zAPJBI5Uh7eZ93mJxHArV3oQhu5yXtCJLJ0I7ofTvNGh0Be7lilL9kNUfpDF3k2B
         0LJHuLai4nzzxSmHkGd+c5g74yJcCP0+p7LyLre8QIynURX0Q1ykVIPyu2VZgnfA6d7B
         tebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794250762; x=1794855562;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/COnO9dnKjvbNK9djz5XaFLsfrCcAvuowKtvzFXEA5E=;
        b=JnO+iOyFJMVFriEMX1geL2PbocrfU5xgbFPDGkDTJttnnbsvnIC0roDVDRl0MlzRBc
         tpA+xeUev6eTeFqzqMLvOrUo8Im1lCsyQDNT1fRudnA+O3IevBcQTrFOFt2YjJd0R64B
         Z9VrmVBN5cUCxVf30LHKk/cyoL8YWfzyLfFv8xPcTge20YezwMFhGT25TjV4Dr4ylfxN
         REr3S6PpVK9xUZuLcxhxP6qoBoiwbIP+z4NApP5RKuu1KNXVmTr/sd2lIXm15qJG5xb7
         VdLnLVSzrFeEYULpBYnWCNU399LadpJzzNHzdakQxRAhT9qcbsyoY0WkmCFTYoPanqsF
         TJYA==
X-Forwarded-Encrypted: i=1; AL+hErFIrFQ4SsMNmX7fC+D5FCAePgfE1IJ16Okk2LjxFTVvNeP3l7EL4nS4ePLO0SpmchxIiyw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jwq0Nkf+lAo2YSrajtOcZyqZXxKeGBPHb7WTPgTQNbERX0MmL
	kJVhjh9BngY7issu/K4Rao6N7YsPZal+9SvJGlHJgwcPso8UZ55bDQuBPoX1AJkjO2Ug1HBl5rU
	jUDrtnZdUAO+qZ38HWvek4kB8gpo5VHqgVAjM
X-Gm-Gg: AYBFou2riUa7vUfJFIuA51wPO8XBuUQ98FvB797iTX4iHgL5ZDnEUCqZsWMKwq4plFA
	g5bLdQE0TkjrjT0ld8bl8BrHi64fhg8KFbM1l63rAM+7mG3VyrfwIak7AGQiDOiKuya6pS42RY1
	dMlx4w3vVZZ8ItCPl7wWClC/fUO8BUZoThmEU5ttfE5ut59xpCyjc5mhm92QTA+MnLt6eHWYwTS
	Bs0vOjCPti/dL9XVDOz6bfTmpEYg+rdwgGasjjMcDxCKz7KcGMDEesP99hEVFsbKUvOfeP/WhMl
	CekyZ6VK5ryLt+WABTlR6RpaGg2nMl9LCx5gcCHtVWLQu7EnpIEty4PX7w49vVjHxqzjv+Qwg2X
	QToey8QwZwgG14GWzJx5OyWJfqDgZ/VGvmLPnVjEmsWVQd7Ez8HRdd6YQU5YCFvJKEkfy7Bb8LM
	wzfTNrfEobpxb4SA==
X-Received: by 2002:a05:620a:4593:b0:93e:9834:3863 with SMTP id
 af79cd13be357-9479f2b05f0mr65411685a.15.1794250761983; Mon, 09 Nov 2026
 10:59:21 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2247.git.1791127155614.gitgitgadget@gmail.com>
 <c724ab00-dfb8-4e81-8bd7-89702bea51b4@gmail.com> <xmqqld77uofw.fsf@gitster.g>
In-Reply-To: <xmqqld77uofw.fsf@gitster.g>
From: Ilia K <ki.stfu@gmail.com>
Date: Mon, 9 Nov 2026 19:59:10 +0100
X-Gm-Features: AclHuK_AJbVafaEGmhEioMpS7EzUgarM9Wqaz3UPstqpnpBlrsAso47LY_PF-XE
Message-ID: <CAMmqxguRpCFL2cRJ_LCXaPd9d91zFb-Yo6MVbhSsi57S14xseA@mail.gmail.com>
Subject: Re: [PATCH] fsmonitor: check the untracked cache after a trivial response
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, Ilia via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 4:01=E2=80=AFPM Derrick Stolee <stolee@gmail.com> wr=
ote:
>
> > +             strbuf_setlen(path, len);
> > +     }
> > +
> > +     return nr_invalidated;
> > +}
> > +
> > +int untracked_cache_invalidate_stale_dirs(struct index_state *istate)
> > +{
> > +     struct strbuf path =3D STRBUF_INIT;
> > +     const char *worktree;
> > +     int nr_invalidated;
> > +
> > +     if (!istate->untracked || !istate->untracked->root)
> > +             return 0;
> > +
> > +     /*
> > +      * The index is also read and written by commands that do not
> > +      * run in the top-level directory of the worktree.
> > +      */
> > +     worktree =3D repo_get_work_tree(istate->repo);
> > +     if (!worktree)
> > +             return 0;
>
> I wonder if this is the right response if we fail to get a worktree. Mayb=
e
> we should invalidate the entire untracked cache in this case, along with =
a
> warning that we couldn't evaluate the worktree? Or should we return -1 to
> signal an error?

Fixed, thank you!

> > diff --git a/read-cache.c b/read-cache.c
> > index c4cf08a3a3..00c9960c8e 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -3034,6 +3034,22 @@ static int do_write_index(struct index_state *is=
tate, struct tempfile *tempfile,
> >           istate->untracked) {
> >               strbuf_reset(&sb);
> >
> > +             /*
> > +              * The monitor could not say what changed (see the trivia=
l
> > +              * response in refresh_fsmonitor()), so nothing kept the
> > +              * valid bits up to date. Check them before they are save=
d
> > +              * next to the new token, which later commands trust even
> > +              * when this command did not look for untracked files.
> > +              */
> > +             if (write_extensions & WRITE_FSMONITOR_EXTENSION &&
> > +                 istate->fsmonitor_last_update &&
> > +                 !istate->untracked->use_fsmonitor) {
> > +                     int nr =3D untracked_cache_invalidate_stale_dirs(=
istate);
> > +
> > +                     trace2_data_intmax("index", istate->repo,
> > +                                        "extension/untr/invalidated", =
nr);
> > +             }
>
> This surprised me, that you're computing this in do_write_index(). I supp=
ose
> that this avoids doing this computation unless the index is written, but =
is
> it possible that between refresh_fsmonitor() and do_write_index() that th=
e
> untracked cache is read and used to determine what this index update shou=
ld
> be?

No, nothing between `refresh_fsmonitor()` and `do_write_index()`
trusts the cache because use_fsmonitor stays 0 until the index is
written.

> > +# After a trivial response ("/") the monitor cannot vouch for the
> > +# untracked cache. Even a command that does not look for untracked
> > +# files must drop the stale entries, or the next "git status" trusts t=
hem.
>
> nit: Generally, we don't need these comments because the tests should be
> self-documenting.

Fixed, thank you!

> > +             EOF
> > +             git status --porcelain >../actual 2>../err &&
> > +             test_must_be_empty ../err &&
> > +             test_cmp ../expect ../actual
> > +     )
> > +'
>
> > +# After a restart the daemon sends a trivial response ("/"), because i=
t
> > +# cannot know what changed while it was down. Even a command that does
> > +# not look for untracked files must then drop the stale untracked cach=
e
> > +# entries, or the next "git status" trusts them.
>
> same nit: comments shouldn't be necessary here.

Fixed, thank you!

--
- Ilia
