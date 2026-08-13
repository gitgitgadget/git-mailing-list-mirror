Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EEE2737FC
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647908; cv=pass; b=OFxfBFXELpeYuLBZ/khmhm9tfT8IzoFI/q692y0b/vOogc4gL+hOHIHMkrOc93W7noz4XE1svp+uzaHR5ax4tFeNUpIP+QO+wJgLwwoy3tbsnyYXKGxzJ+QBxChup52vmftiHME0l9/sFhSDsIkd6zlHPFEHf68+6NW4tb/cxtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647908; c=relaxed/simple;
	bh=80R+ITpDsxAtRR1v/FxXQTK7H/H5sL8sfg/d8G+q5yI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCgLGuzOpNFv/hzmgl2hvuL5r1FTGPCMUgh1t3qfJs5a0l84zFAEu8m6PcOWUtvrEv1E5UNXqqfAF1PegX2W7KMtV7JE1747+jvYmczprgdJLSQWCKgkg6K9mqJxmMK+IIsbhqhQCLwftgD073j/0TCou8mdtehC9NX7Qxf9BX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljqrCuuQ; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljqrCuuQ"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43ccd4f6f6eso185422fac.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 12:05:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786647905; cv=none;
        d=google.com; s=arc-20260327;
        b=UXuBrZQqQEGIPzRQqgFco/fNEcnebmWxVAMCZFJLXAiE3yz/RlJ7t1CT97ATeir3fY
         oIIZpO5zKSOlVvcNGSIMIXMS76N2o3MhL7saKFwUxcxi6ZfwtesQrRhwgrfwxLf4LfBh
         uxtqZ5W3hr8f7MqLV5OQ4z3y4/Q6dnXZ7FyxlRZPzJWIxjkHk/lA0CKYPIxeH6W+ye8s
         mFeSqBrA//ZpOnboyZXOdpB3UXflzUsGtLASwnPqre/PEYcmPZGwkSAqQHLzLGZWQPji
         I4QvngqPtl1dSf/YSeOMZ6rHoWlV1f4KCEgtZZG39qvx7JiymlJsSzBeHKZLpwA5ujb0
         hLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9NYp5AX8bIwY+U1QQ3sok6q1hfn9ON3KoEVAzLxaBRE=;
        fh=sP4evn89UOR807DD0PN+ds1tIzVT+R6B1RM5oIuh9HI=;
        b=B8tbytoxaHX0cLtSvDzJsqP8WPniAEIpIz/JHjJSkPuoRR3NPRDq2OWRPLDHe1ymb1
         wtbQV6bFeHb7rBbsqcxn8w9pGQU42l8B0E9b0LEsESZ6DVNthTQEVATmW1+TbSJYjVpf
         mnTxtx3Q1Jgk84Jc+ByZF8ykuLNCa8Rwd0elbWPKFJucEZFFq+GEYW7xVUkVngbcFMC2
         GWJkBjP1vvKZlLkVLPx6FvspTA0fluPDCR+vgw2II9HtNnaFQyYY0XYRGZsiEYlxUaUH
         j14cQ6O/bB0jRRpL4pTCIL1uZxbI+UDbMegtsw9J4p9XjQJ+zqJ4cwXcEYpx8xrpGLQh
         /T8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786647905; x=1787252705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9NYp5AX8bIwY+U1QQ3sok6q1hfn9ON3KoEVAzLxaBRE=;
        b=ljqrCuuQ6XisxD0rT7zAboX7xOhdW0CrLpXB1iRJAf6qZEVmvdxhYHd6EmBAKiawXG
         1/gRi3k/11nFS4vi6DhojkWUETDXn2LPPU6mO30GOI3wO1y6m5CH8M5vtXBANC2/VTrm
         efqXikKhrcCeGkidFLhQFJpcCu8pHnDnJfAbFFZQInZhb1ZPgE+fHDWIhQqjt71HgqLn
         AspeF7aWfF1YYhHYydV8KpvuJnwyE6OyFLREs67qlaK4xb9XzC69T8hNwcwrSifaU1De
         mwt2a31mXQ6bhuzu5vYpv83eo0CN3fbIsN7WGZS/VNnK98ADeVhJPtseK5SZn+6xCdIv
         m9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786647905; x=1787252705;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9NYp5AX8bIwY+U1QQ3sok6q1hfn9ON3KoEVAzLxaBRE=;
        b=dre+ktA9oQRMUjM9f98rnJG/1Jz8E4q/xAPtVrGSvBfcrrXg9bPO5S7jr5pfXeV3UC
         3ICoDpCBjeHaZwuCmUrKpsqWrI1bdfJzCKS0Yaj8igafmo7oHzylDJpRgBgkngPonSAg
         1FWnEo2HAMXrHFg5R0e1/sDxCdnYYVXKYscevJkWwX/cztSl4X+QugDvsrH5ZE2tOHAx
         wt4fU5Pp+BhjZb+Dn8kUiZnBy9ukfWbtXzezJlJw5UWpVkscYGcEWi0VAkq1Kmxkmruq
         E6+WXPDvGrTMBH/nP0ANLAyrd4McJmzxgVIu6M+oWXFgbxFJHlP8eDQ8/tXpHH/TkDC1
         2xyw==
X-Forwarded-Encrypted: i=1; AHgh+RpPcF9eaZyoH13SdbFvTIRQSyfr00fMS+qOsX3yahKe5UaIG1LRaS1gboKrp3XSIlr9Opk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHs0FHo6uW9rBtodV8Peoqz3xj20BKgycqhGh5p+/jcAN7SVG0
	bugzENQjrR8dO8H/ZIEBZiuhuVh81IbMFf6Lqcnh1Gs8MxDbFQ9bRHBhG8PriFerNeb/6YW77fA
	DxW2eT/hRUvY+pO+U0o+vH1EUfMVfHyI=
X-Gm-Gg: AR+sD11F/JoxARJibx3juJXSSf3NeomDrCkP1n3R5PEmTVRQxeaSRYbA3rBROYL8mSG
	M9X3BstMfwO1QTFBOA70uaM2ZnleKuiE02z5mhv9WOlB5iFV7GTVta83d6ogMAQyniNvt2h0CeR
	5ch/UXlxgdJ3farMpCxXytl5+yjrcrHyRiask55eHJhYO2LdsKaQzUIUJbb4EN4jVExFtcGu1Lk
	J5lKy5uChGZaidzg9myg1s96UxYshvnklXN1F+3CSP1VHFf3oLbiDNrM2KCfJLh21zboPRLg3yN
	ieZz7JvR1NJR+jixdU0UeAvPRKLWCWiwaltc/JORg1gnLtt10OSSfQjlR+EPi9vRe/cyWtEeNg7
	yjiDJrXXlaWCufmzuIbcv1ULmg+5/yIldfwOtahnYUy4uE8rAvUn2qkfcJKb13Dw=
X-Received: by 2002:a05:6820:5701:10b0:6ae:410f:c745 with SMTP id
 006d021491bc7-6b0d690c0d4mr439758eaf.30.1786647905063; Thu, 13 Aug 2026
 12:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im>
 <20260701-pks-libgit-in-subdir-v3-2-5e4860056094@pks.im> <alR9GDNTbdjWB4dq@szeder.dev>
 <2d455ecf-972e-e3ce-54bc-683050c04282@gmx.de> <xmqqjyqpb96n.fsf@gitster.g>
 <ansSg4qsPwh5FcR9@pks.im> <xmqqpkzo39d2.fsf@gitster.g> <antWRHPHHES4a1KT@pks.im>
 <693a61b6-e762-d864-d25b-348485ec039e@gmx.de> <xmqqqzk2t7sm.fsf@gitster.g>
In-Reply-To: <xmqqqzk2t7sm.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Thu, 13 Aug 2026 12:04:52 -0700
X-Gm-Features: AUfX_mwyV1OFxc6JVa1YmUFjvZZTD6iJDgmWmOEfxSUlrUmerNkhYfq4n-R3Bqo
Message-ID: <CAC2QwmKs-TV2f=2BhBNQGtVA4vzciN-Vkh95RkGcVKe=6zwwRQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/2] Move libgit.a sources into separate "lib/" directory
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, git@vger.kernel.org, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Elijah Newren <newren@gmail.com>, 
	Derrick Stolee <stolee@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 7:27=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Of course, it would be even nicer if `lib/` was split up further, but
> > then:
> >
> > 1) You've got to start _somewhere_. As we saw with so many things on th=
is
> >    list, they never materialized because reviewers asked for too much a=
nd
> >    weren't happy to get incremental improvements first.
>
> That is why moving everything to 'lib/' and thinking about the rest
> later will not work.  Instead, moving a specific component to a
> specific subdirectory (not 'lib/') would be a reasonably
> self-contained first step.  Consider 'builtin/' as an example:  it
> is focused, and anyone can easily tell what the criterion is.  If
> it is the top-level cmd_foo() implementation, it goes there;
> otherwise, it does not.  Then, you can proceed to the second step,
> and then the third.  Iterate enough times, and the top level will
> become thin enough that you can either make your final step a
> no-op and leave the remaining files there, or create one last
> group to house the hodgepodge of leftover bits and move them there.
>
> > 2) Naming is hard. As we saw with _many_ refactorings (I am thinking ab=
out
> >    the low-level merge stuff as well as the ODB stuff, for example), it=
 is
> >    unlikely to get the origanization right the first time. So I'd think
> >    that first moving the bulk of the library code to lib/ is a good sta=
rt,
> >    and worth merging, leaving later contributions to chop off further
> >    parts into subdirectories of lib/.
>
> Again, this is because you are trying to do everything at once.
> Instead, come up with one clear concept, name it well, move the
> related files there, and then iterate.
>

Reading the discussion initially, I was inclined to agree with the
"move to lib/" idea. As a newer contributor, I do think the number of
files at the top level are a lot to navigate. Taking a step back to
roughly frame things, points of tension I see are:

  - the level of granularity for a conceptual grouping.
  - the level of conceptual cohesiveness before a grouping should be
    created, including what "cohesiveness" even means.
  - the need to create conceptual groups in a timely, deliberate
    manner without being too quick to create half-baked ones.

After considering these points, I ended up being in favor of coming up
with more granular, clear conceptual groupings before creating a
coarser, general grouping like "lib/". However, I do think this
grouping process can happen in a more timely and deliberate way. The
main appeal of moving stuff to "lib/" is to make progress on an effort
that otherwise has no concrete roadmap and allows us to "not let
perfect be the enemy of good."

There are already conceptual grouping efforts, both ongoing and past,
that might provide useful signals for how to make further progress.
A good set of signals would:

  - correctly reflect the conceptual groups that were already created
    successfully.
  - indicate candidate group areas as well as areas not "settled."
  - be generated by an ongoing, mechanical process that encodes
    the project's conceptual grouping standards.

I'm not necessarily sure if generating such a set is feasible or a
well-formed plan, but I wanted to provide a motivating example to
criticize.

One mechanical signal is how tightly a set of files shares the same
internal headers: if two .c files include many of the same project
headers (dropping the plumbing everything includes), they lean on the
same machinery. Averaged over every pair in the group, that gives one
cohesion number.

The already-carved directories have the following scores: refs/ scores
3.1, trace2/ 1.2, odb/ 1.0, while the whole root is 0.3. The scores
also seem predictive: run at the end of 2020, before odb/ existed, the
object-database files then at the root already scored 1.2, as cohesive
as trace2/ or negotiator/ were and 6x the root. odb/ is being carved
out of those exact files now.

Pointing forward, merging today's root .c files by that measure until
cohesion drops below the carved band proposes these groups, with no
hand-picked list [1]:

  6.9  connect.c fetch-pack.c remote-curl.c send-pack.c transport.c
       upload-pack.c
  6.8  diff-lib.c entry.c read-cache.c unpack-trees.c
  6.6  commit.c log-tree.c ref-filter.c revision.c sequencer.c
  6.3  diff.c diffcore-rename.c merge-ort.c
  6.0  delta-islands.c pack-bitmap-write.c pack-bitmap.c
carved directories, for reference:
  3.1  refs/
  1.0  odb/
  1.0  trace2/

Every proposed group is more cohesive than any directory already
carved: the same measure that would have flagged odb/ in 2020 points
now at a wire, index, revision, diff, and pack group.

I'm not sure these results necessarily provide the best signal, but
I believe it would be possible to mine a signal from Git's history /
existing project structure that would provide a principled roadmap
for deliberately grouping concepts.

[1] the (Claude generated) script:

import subprocess, re
from collections import defaultdict
from itertools import combinations

# shared distinctive #includes for every .c file; "distinctive" =3D not
# plumbing, i.e. included by <=3D12% of the root .c files
pat =3D r'^[[:space:]]*#[[:space:]]*include[[:space:]]+"[^"]+"'
out =3D subprocess.check_output(
    ["git", "grep", "-E", pat, "--", "*.c"], text=3DTrue)
q =3D re.compile(r'"([^"]+)"')
inc =3D defaultdict(set)
for line in out.splitlines():
    path, rest =3D line.split(":", 1)
    m =3D q.search(rest)
    if m:
        h =3D m.group(1).split("/")[-1]
        inc[path].add(h[:-2] if h.endswith(".h") else h)
root =3D [f for f in inc if "/" not in f]
docs =3D defaultdict(int)
for f in root:
    for h in inc[f]: docs[h] +=3D 1
dist =3D {h for h, d in docs.items() if d <=3D len(root) * 0.12}
for f in inc: inc[f] &=3D dist
files =3D sorted(f for f in root if inc[f])

def sim(a, b): return len(inc[a] & inc[b])
def coh(m):
    ps =3D list(combinations(m, 2))
    return sum(sim(a, b) for a, b in ps) / len(ps) if ps else 0.0

# average-linkage agglomeration of the root files until the best merge's
# linkage drops below T; link[i][j] holds the summed pair similarity
T =3D 5.0
mem =3D {i: [f] for i, f in enumerate(files)}
size =3D {i: 1 for i in mem}
link =3D defaultdict(dict)
for a, b in combinations(range(len(files)), 2):
    s =3D sim(files[a], files[b])
    if s: link[a][b] =3D s; link[b][a] =3D s
act =3D set(mem); nid =3D len(files)
while True:
    best, bv =3D None, T
    for i in act:
        for j, ss in link[i].items():
            if i < j and ss / (size[i] * size[j]) >=3D bv:
                bv, best =3D ss / (size[i] * size[j]), (i, j)
    if not best: break
    i, j =3D best; c =3D nid; nid +=3D 1
    mem[c] =3D mem[i] + mem[j]; size[c] =3D size[i] + size[j]
    for x in (set(link[i]) | set(link[j])) - {i, j}:
        s =3D link[i].get(x, 0) + link[j].get(x, 0)
        link[c][x] =3D s; link[x][c] =3D s
    for x in list(link[i]): link[x].pop(i, None)
    for x in list(link[j]): link[x].pop(j, None)
    link.pop(i, None); link.pop(j, None)
    act.discard(i); act.discard(j); act.add(c)

groups =3D sorted((mem[c] for c in act if size[c] >=3D 3),
                key=3Dlambda m: -coh(m))
print("candidate subsystems (ranked by cohesion):")
for m in groups:
    print(f"  {coh(m):.1f}  {' '.join(sorted(m))}")
tree =3D subprocess.check_output(
    ["git", "ls-files", "--", "*.c"], text=3DTrue).split()
print("carved directories, for reference:")
for d in ["refs", "reftable", "odb", "trace2"]:
    c =3D coh([f for f in tree if f.startswith(d + "/")])
    if c: print(f"  {c:.1f}  {d}/")
