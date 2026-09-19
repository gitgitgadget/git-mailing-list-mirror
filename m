Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFB1547058
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789848138; cv=pass; b=JTRH0s5SrCbSwYX8chwU2Moe+JX1i9gymjTC+p0ijvbVERzVi0cv317bqLyfr+ZoYWpdcKA9mEM2W/yn7gHyoCEGfyfXXm1LCwJKY+z0bod9JyPI51eRSOZMzDqzuPmRAtAIOtr+Uh7237Foo6bw6E5JO7kO+r2Y4e63p0FNUK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789848138; c=relaxed/simple;
	bh=UaS7Q1TrnF7UUppxvEcHU2QHCYXh4cfF2FtFR/l1WLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZmwRkbJ65X71W+Px79XyNrKiqkzkhNQONEijeizOemfo3bNkHGudTrF0bTATcD5/XzxVJh4RBA6A/FePWxE2VSE/ILSo4gs7dlmYi5SXGjnlMb6ColkGCPJcBG3oPhxVj/VUZYebpJxCp9bv15n3isIbpx1s1zrXDf1LP5DW5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVua1eNO; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVua1eNO"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43f9b11bso13701997b3.0
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 13:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789848136; cv=none;
        d=google.com; s=arc-20260327;
        b=QTr3c29zbCfz79Sp4TBZqagjNao4lNGpta5VcZIpwgfqkEHv/W84UJ/pjAFU45RVHs
         Ch9m+EAbwaXpHR82v8KZATU0SSkVwcxHUXvQtjvEWsrnJwoyxxc77qVpDo6kBzBiHtYN
         mm0EHehQndNCcECUok67yQZ6OSAFSGQl4e4Ydi8KsYts8GWj3UIPfkZSdwMGfK8P/drf
         grsl5ERIeVe62GxeEPVhSnFBgxMOhnedOSEjha2uf7bzLLoIa5Jxqg5JZci0JySvZ3e2
         DgbMxxFt/Qw/EjtlOO5uPrCbP9CgsyQzIJQx1NrPi7LXWWV4JTBE+kWcXiPqOKkI4xzH
         VJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UPVU7OPBuXE9nzmxNQqs8C5N9Q/brOX01IwRiG++qrw=;
        fh=1g5NR+I/vOaQTNio5Twwr80J5U5F5dd9dU+h3yBX5wk=;
        b=Krr17Euy11SpUUYwt3tCAVkGTRqMEAAicu1N7HmmjdNS0qYAzG/4+OjPKQ6ppHSm1z
         VB5vrtgYwJjWDnRprwWydxFF069YGe7fA4fRiXWUyGDLTMaKEOEvJuhffpS+pp77foUx
         lCRHakSsgZfDW4Bg7bfuAIibWxNikyVTW4X8bYp7WlDnhLonbYt6b98OJlHbrY/elFVh
         aKpM7vbnCzsr6v1eYVPy0C5Lx527RwwNJm/0Owse67sriXMgTauUVcAZtncZO//lKH6O
         NGE16nnU341UGerD59/aBI7yK5FYP3Jwz3ylJRE5GmVuOjJPttyGkoImjJe7/BaPWpeg
         w8kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789848136; x=1790452936; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UPVU7OPBuXE9nzmxNQqs8C5N9Q/brOX01IwRiG++qrw=;
        b=YVua1eNOhPL7uO5tAdABSzFkwWmgcG2hQZJw1WjE3YgaU29+0Aegj+UuEhuxg4Xnun
         vquB5mLOtxEFSdCdHZ1drn4jPyftY6xrZQl9XGMglbBDoGy9hV0mulvCbwO1WPsXjS96
         3u/2gDJgxT2+dukb/W93GFVZWwQ/MDoyoeoqYi3tp1FgpLLVBaz1HzezWatKiKzFIBIp
         fqckcmu1HV1m219ziNem+IEIR2xXMVGcJKKhsQmyylUhoiZqFD51mWCEeNOLTt45f7SR
         QvsnQlazqyC9KP2A0xconWVkBU+vKWJS8/zs08qDOFxT2fqhhFbX9qUF4XuuibjJYCGm
         Yw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789848136; x=1790452936;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UPVU7OPBuXE9nzmxNQqs8C5N9Q/brOX01IwRiG++qrw=;
        b=cDzOLfO84HI33GOpAi5tdhm1ivsTSLBZ7hmU9wSzXRn+PPKFbRCNirSRe0ZMNDsLXz
         GBWbXcwFnsiNx9ByEXelGXaqWb/mntZfrk7W7YAHEna4ToEd+BGQC93cVCQLg3eF6GT0
         1gyI6Ei8fenhQGeHVFXnUgUqGPzEjEEw3wWbvWoeq4PaXBDIcZXrLXFMoiAwtcWuBygG
         16XoF8aQXSlieCwrHGFhG3BMEY7EAzb2ilswDJ3b9Zf/qgLGEl9J+ShLzGxkTOtL+OF0
         Yss7weFfjzKNPeLdJJkLegaLTVmMn49hX2hv0sKZtjNlBooZt02tXn0bPvV2FTLNmyMk
         3F0g==
X-Forwarded-Encrypted: i=1; AKwUvBx2NVKt6vMIP5Ktu0rrIfXxQg7XOxoBSUyx8OPNSoY4Kk/QOQvHR0F3zKHtaAa1BtRczf0=@vger.kernel.org
X-Gm-Message-State: AFuF++mbxUA4JB34COFtBzBxOSyKaaMdplWPnyHRbb+exBQbWrYVXVou
	D5RzkK1v1WHSnQoWLCA6rujEwXLRhx2xiDnpKsNWnhHYtYVt7PCbYwPzKMD4QBP2x5SJmXbanmg
	gBTZ8cL/ij2nwbCsRr7jMWdNYtNaIHbs=
X-Gm-Gg: AYBFou009tAVF7pTfNmNb7lZl3g2P0PkaavHrtewXVxjqWQwrZFso8BJRhyV8ruCh9c
	Bhne9K8eqxixzwCPF+X9vA3zRE+OnT3DSKmJptMbrlvsfpM+MVEWQinxuGue+9UvfBgyH3L5xPH
	Z8+YwbAKH7Ildb+rpApXMfFa39dLHzhQbb7kZuV0lTsQt+c8tjRwagxh1eTsOgBVMl09FCgpKE5
	ZDL2TpFtLaEGdZjd4+y1frJXldKN747YWRFq59B62JRoDbgHjJQP6wBf2EMukt9jB69yQo6w00I
	AM9CRHqHBvNwMrh1849JtGuNTyPA0L0+sE8E5e++cg6HwTEcj6z1I6qfLH9d4dQGzCVReCYL9js
	VBOXQfqMxr+WvP8u/jHRvINMreFc/Tli54mcoq/KdVGvViaL1bZNhtSdxfEUvX+lvHlTqZPD7ui
	1m6zckaswAt4DaW7JZGA==
X-Received: by 2002:a05:690c:3:b0:873:5ddf:d860 with SMTP id
 00721157ae682-897346e1aa4mr19718187b3.43.1789848135885; Sat, 19 Sep 2026
 13:02:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <56991232-5d16-41d1-9c7d-ca7ebdd9fce7@gmail.com>
 <0BCA251B-9536-46E3-A6C5-7F917366F92D@gmail.com> <fd4c2cc3-d457-49b0-bf3c-96063e40700d@gmail.com>
 <CALnO6CDfwscMWZktBu3FtXOQVbcBRo76nqK07kMnrzC5cPyZiQ@mail.gmail.com> <44881557-f15e-4ec5-b1c5-4112752f757c@gmail.com>
In-Reply-To: <44881557-f15e-4ec5-b1c5-4112752f757c@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 19 Sep 2026 16:02:02 -0400
X-Gm-Features: AcwNN1VcdsBuJYL_YGPM3rthec0aFGLO5P85mN8JcoJJvBxLyc-Y0cVBKPFRBSA
Message-ID: <CALnO6CBJoiu8Xzx_p9wYYUrR6ZxB93B8-su1Pxhr8WJ+68va1g@mail.gmail.com>
Subject: Re: [BUG] stash.index=true leaves a redundant stash entry after an
 autostash fast-forward
To: phillip.wood@dunelm.org.uk
Cc: Eli Barzilay <eli@barzilay.org>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 11:55=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
>
> On 17/09/2026 14:15, D. Ben Knoble wrote:

[snip]

> > Sans doc comments for
> > unpack_trees() beyond "N-way merge len trees [=E2=80=A6] resulting inde=
x [=E2=80=A6]",
> > I haven't puzzled out what's going on, but it _looks_ like we merge a
> > single tree, possibly with the original index (opts.src_index) and
> > write to a destination which is the repository's index.
>
> Apart from the "git read-tree" man page, the documentation for
> unpack_trees() is basically non-existent which is a real shame for such
> a fundamental function. As I understand it, the one-way merge copies
> across the stat data from the old index to the new index for entries
> that are unchanged between the two.

Up to here, I'm with you.

> Without the "reset" bit it also
> checks that there are no unmerged index entries and unstaged changes for
> paths that are removed by the merge.

That is such a precise check to be covered by only "reset", heh. I
suppose the idea is that if "reset" is on, we don't need to check
because we'll reset those entries/paths? More documentation from
experts in this area welcome=E2=80=A6

> > It's extra unclear what the reset bit is applied to in
> >
> >> It looks like stash has its own unpack_trees() wrapper, so I think the
> >> simplest fix is to replace reset_head() with
> >>
> >>          reset_tree(&c_tree, 0, 1);
> >
> > I'm not sure if that is a pre-merge reset, post-merge reset, or
> > something in between.
> > Unfortunately, a whole bunch of tests fail (6 files) with this suggesti=
on :/
> >
[snip]
> >
> > It _also_ doesn't make the bug go away, hm.
>
> Oh, I wonder what's happening there.

Looks like you figured it out :) When I was thinking about a series, I
thought it might be nice to do the "trivial" fix first, then the
refactor we prefer, but=E2=80=A6 I'm not too sure. Since the other version
works, I might just go with it and omit the intermediate reset_tree
state.

> I had a quick look at the patch, it looks good, but I think we can
> simplify it a bit. As we abort if there are conflicts I don't think we
> need to spend any effort setting the conflict labels (I'm not sure if we
> can pass NULL, but "" would certainly suffice). Does the current code
> print any errors from apply when the patch does not apply? If not we
> should silence the merge by setting verbosity=3D0.

Actually, this was my reason to set the labels, too! I thought they
might show up in any logged messages. I'll take another look at what
happens here.

> Also I think we should
> use oidcpy to copy the merged tree (it probably does not matter in this
> case, but it I think it does some extra checks on the hash function
> which a simple assignment does not)

Great idea, thanks.

--=20
D. Ben Knoble
