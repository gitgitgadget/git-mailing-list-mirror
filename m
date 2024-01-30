Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541871B29
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645062; cv=none; b=fCKk9w+8Xavd34p1Zqao2ZTad+8cyk8Kcc+fWqzMKcOzgmc0MuI2duYXZN1PImoJYlcitn5pPSz8z1W8dG0buffgsS3YdgYR3Y6zFopdaR1gk1vG7lBDpTVziVXoSOe0vAKMxiEbF3+IDCB3cgZ1zL8n9y86E7EnEjYUoOK6KiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645062; c=relaxed/simple;
	bh=9oSLbWba5EKMi4XVkxtGHqj5lsHJ9IjcQfV/8fYCYtM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U1xUGefL9l2kkhnVs4eCPTs0Br9EzHuEvMQflnmI68EjX4kaV6pkVAQnrlYi09rNHL2VqtCIxh1jSI617otUrZ2pAWbY/do0ghuMSPMIRpMcQqNcjC0/VHGHkvnEQJk1EQutdTPh5skCGVMyA8HGrxxEJozpaN+xT2Bi9YjLDFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=iHlNn379; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="iHlNn379"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706645057; x=1707249857; i=johannes.schindelin@gmx.de;
	bh=9oSLbWba5EKMi4XVkxtGHqj5lsHJ9IjcQfV/8fYCYtM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=iHlNn379yjctAFU0E7L3NfIrZ5JFZuFhth2UgRQM9v48pzcObu516VqloDkAEBXp
	 Y+ydLqtxYvTkkxOjt8h6Kc7tlCN8BFxQU0k/yj2uTYH0KWAV0mr3l/nnEW18tGgBP
	 l2NX0LULrc8QrZVPb0Z88Bj9Jd8q3lRAZE96qTmVpAHCip+Mx+vnvxiafyVgbfugE
	 qIbeOr/8+ajDYh2n/rUi4tHDrDAlsf7CKo63FKDmi93GOxzBanbBi+vrBrE/IY/dY
	 WlUgJq6WNZkdafWdx+UOVsWyrLYXvRw+efM5Tl/Goi8WLVeC7KKAZsOgclV0ldch4
	 4w/XXsVlTDLtBLBm3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.216.23]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAOJV-1rKE2d3ihf-00BtJr; Tue, 30
 Jan 2024 21:04:16 +0100
Date: Tue, 30 Jan 2024 21:04:15 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Elijah Newren <newren@gmail.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] merge-tree: accept 3 trees as arguments
In-Reply-To: <CABPp-BFPe_RrX5ZHo7-mMHHS96j_O+1wiEwGC5+zGPP5h+686Q@mail.gmail.com>
Message-ID: <557604aa-dea4-995a-4fb2-a71b515a8129@gmx.de>
References: <pull.1647.git.1706277694231.gitgitgadget@gmail.com> <CABPp-BFPe_RrX5ZHo7-mMHHS96j_O+1wiEwGC5+zGPP5h+686Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1829607030-1706645057=:544"
X-Provags-ID: V03:K1:CyZUFQm7rb7RwL3DpZm5SDVkab9rcL5qqbNOIYMmhqnWTQvDuZR
 xhTZxoCsS4FBlODY9QFk3ie4CseOHXiQhCcTbUjl/Rr+VPShL7Sk3hFJlQAexRvf7wJQt2H
 2v4sJl10AJoNJc9kcOxjMC0vcTijmJ+UVi2mtlMeLnmqDwORCcNzxw16wo51t5NWyu1eqXN
 zyXJtk9IWpHh5HqDVDfNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ulhs7eHmRYQ=;gUGye2AfnKU2ikZE4gGYyWGsYBw
 JZ8Tmj+u373Tk6FkdFo+X9U7+uMWB6prnbKEsJuZ1MrtBw7uoqB4Gm+ojVxSAvl6oCkqzgZNa
 3ShhKZHeVCdqLrmLoyraAPa70mpcNBJ7del8cup3SDEPEwPz6yRRzOygEJxjLbscwu2+pJ0Op
 0smLTANPAhtSARB2aLtdOsBouTRcHuT6ebffsVjg1y2u3S4Sgy6EWRT06BVpweAIJWeIc9Jkw
 C/HISp+QkcUOjSC0E2e5N+deyeEu0hWfT1RsA9uE9qwXGbyVsf0Toa+X4O1Mrz3dJb8JxZhl+
 gfVx69hjAMYQ7zMqhlK0O+xC3ZwCSpEyV6XG9JIZNtDzXo/8vkzH4U+wIwahWB3G0R6LxIFIX
 joEb8z6KSF4C2DA8jTuGle+Xyi6UHno7Yb6NCgY9MtHGjC23/ikr/rs9RdGXJzGwOLvAqvjzL
 mLlHHv7m/SY11ByKe1h/zJ/jfs81Tk7+xciVg1XG6Syo3ckCQmkfbHv5qoGkBA6E3OzVQwxCk
 hZ7fjMFNXqCFcz3nbZJh6BzOHgsQQsKOv0u3kw6DXui9OAgbdivKLY+5TEdkyxTciq8iBSyDy
 ggqaY8JbDnBFoq2SHNuI+bjEV04RaR5674IZgbaqk4F2nr4/9oNA6FL6c0J4uUKYhdzz/4WDu
 naXwG//nC+L8XmHmDwOy7i+Z0xnEInDC4KRdeCrJW35ApUm8uog25LbmOYEumYxP4JrB2a+U6
 MuHU/O917zXwpPPg7ro42YdnCCw3OOK7BXH0aXhyIHiK4lle+dt2qTskwqfR++5TE4YAJ0Jg0
 TzlWxt/UopTizcuec6lnnhvyhzBcsw82bNU+QqDg0LoTecInY9e7PaL1Oswwu8DaULNIWqdRb
 OlvkbQZwVzgVrklsl/EBorBawDBOjdBcxaSi8NDqfCnyZSEsEZZ22+3xqRh+vd/gJ1J9hMkDF
 cs6NyQ==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1829607030-1706645057=:544
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Elijah,

On Mon, 29 Jan 2024, Elijah Newren wrote:

> On Fri, Jan 26, 2024 at 6:18=E2=80=AFAM Johannes Schindelin via GitGitGa=
dget
> <gitgitgadget@gmail.com> wrote:
> >
> >  Documentation/git-merge-tree.txt |  5 +++-
> >  builtin/merge-tree.c             | 42 +++++++++++++++++++------------=
-
> >  t/t4301-merge-tree-write-tree.sh |  8 ++++++
> >  3 files changed, 37 insertions(+), 18 deletions(-)
> >
> > diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merg=
e-tree.txt
> > index b50acace3bc..214e30c70ba 100644
> > --- a/Documentation/git-merge-tree.txt
> > +++ b/Documentation/git-merge-tree.txt
> > @@ -64,10 +64,13 @@ OPTIONS
> >         share no common history.  This flag can be given to override t=
hat
> >         check and make the merge proceed anyway.
> >
> > ---merge-base=3D<commit>::
> > +--merge-base=3D<tree-ish>::
>
> A very minor point, but any chance we can just use `<tree>`, like
> git-restore does?  I've never liked the '-ish' that we use as it seems
> to throw users, and I think they understand that they can use a commit
> or a tag where a tree is expected

That's funny: I asked Victoria Dye to look over the patch, and she pointed
out the exact opposite: I had written `<tree>` and she remarked that most
of Git's manual pages would call this a `<tree-ish>` :-)

On another funny note, I tried to establish the term "ent" for this catego=
ry
almost 222 months ago because I also disliked the "-ish" convention:
https://lore.kernel.org/git/Pine.LNX.4.63.0508051655480.8418@wgmdd8.biozen=
trum.uni-wuerzburg.de/

> > diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> > index 3bdec53fbe5..cbd8e15af6d 100644
> > --- a/builtin/merge-tree.c
> > +++ b/builtin/merge-tree.c
> > @@ -429,35 +429,43 @@ static int real_merge(struct merge_tree_options =
*o,
> >         struct merge_options opt;
> >
> >         copy_merge_options(&opt, &o->merge_options);
> > -       parent1 =3D get_merge_parent(branch1);
> > -       if (!parent1)
> > -               help_unknown_ref(branch1, "merge-tree",
> > -                                _("not something we can merge"));
> > -
> > -       parent2 =3D get_merge_parent(branch2);
> > -       if (!parent2)
> > -               help_unknown_ref(branch2, "merge-tree",
> > -                                _("not something we can merge"));
> > -
> >         opt.show_rename_progress =3D 0;
> >
> >         opt.branch1 =3D branch1;
> >         opt.branch2 =3D branch2;
>
> If branch1 and branch2 refer to trees, then when users hit conflicts
> they'll see e.g.
>
> <<<<<<< aaaaaaa
>   somecode();
> =3D=3D=3D=3D=3D=3D=3D
>   othercode();
> >>>>>>> bbbbbbb
>
> but aaaaaaa and bbbbbbb are not commits that they can find.

That is true. And it is not totally obvious to many users that they could
then call `git show aaaaaaa:file` to see the full pre-image on the
first-parent side.

On the other hand, the label that is shown is precisely what the user
specified on the command-line. For example:

	$ git merge-tree --merge-base=3Dv2.42.0:t v2.43.0~11:t v2.43.0~10^2:t

will result in the following conflict markers:

	$ git show 021c3ce211:t0091-bugreport.sh
	[...]
	<<<<<<< v2.43.0~11:t
		grep usage output &&
		test_path_is_missing git-bugreport-*
	'

	test_expect_success 'incorrect positional arguments abort with usage and =
hint' '
		test_must_fail git bugreport false 2>output &&
		grep usage output &&
		grep false output &&
	=3D=3D=3D=3D=3D=3D=3D
		test_grep usage output &&
	>>>>>>> v2.43.0~10^2:t
	[...]

which I personally find very pleasing output.

Besides, the manual page of `git merge-tree` says in no sugar-coated
words:

	Do NOT look through the resulting toplevel tree to try to find which
	files conflict; [...]

:-)

Ciao,
Johannes

--8323328-1829607030-1706645057=:544--
