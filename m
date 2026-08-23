Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791982798F8
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 19:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787513899; cv=pass; b=dh1pyxbtWHOVbCTQOhJeJRsQhkZJRhtAgVt39cNZM4oagq39qP6o8LGkaiNW9iQEbIRmTcoGa9+ta4ENbMbTPS7ZP9YWC2AL3rl37xjkVL91duUa0KV6UBdPxw1b20uxrwp0Qlt7Jmt4KHS2iYNwsD4Tc42ZS2A8yaZeJ2ZiqWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787513899; c=relaxed/simple;
	bh=x1K2SBfN0vyiT3wFV0Rb8y5RZtN9MHTBzCrbmp4hLqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpBXy6HZgCQ0U+sYNSsuDVb+IT90TkkTX9s2Yt6ubLkvTwfxMhb8c/jCe65ApN706cp2hnToUbkBzJBSyC6TjxlovXNc1hI17KXY2OBEFFYk45BaIwIyk/xyiwdf/TLnbdIhOf6l3V21z3plM5ULlSBjuxALiBJ3WxdUj8m2Xe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hzd9xguI; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hzd9xguI"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb63dbd229so2464482a34.1
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 12:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787513896; cv=none;
        d=google.com; s=arc-20260327;
        b=KJW4QIGcBQre/V+s39IkLNDUvsNVnc/CqdBqJevoh2YZAVnHbw3dUZOHVAq7tdtfGA
         JcgXTpLAAscDnxntL2L5iD/0ny6HwiVJYGaPrTJE/RANv/Ll5C6CLAHm2TiRbxYIrVV+
         +slM+a7nwjtOjpD8EWFWKIBkLgqcHSPEUykH5oFM4Y29EIIMEJCFRgfSVR5kzCT/KTq3
         hQqCOFAAMAJj+inreCmRGkd5S8c8kIRiFuyM/GnybN5Mme87d2XiHcbcTNPUmUvSLp1z
         ZKzKUUuKH3fD4wAeoumVacNrdNv0ZtPGiH6wUfmfGsFZm4rbUYf34UlbLS0yH8CGSLPl
         c5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GeNOix2Ot/y4ev1GhCpZSYQOtGev8glAVYf5ddJeG+0=;
        fh=V36/MSC+8fjQ6F16seCarl/St4TrYYHDdMirMHcX0Sg=;
        b=VG0F+geC9KwjHabSHaBaiCAX7hC/AK/txIL+bX/QNBPOBuEJVwFRUo8utgU2yNLXbN
         YV9PmRKRVYrO57Ek6xVS5jg4mK2ige1F3TPYg77NQQOChoGipGpLcL9eXdmxC2uikc8Y
         IdV0ZUQ47mWbDdOIHENbQr/vBz8dTzbUx5H0eneO48hlaL4/I6VTjbwijUT7SrWQNIt2
         Rj9IikxRtV/T0XpDWRJyGKzfDi8rAOgZBnHUj4YFF4a7m8qnnItSj8V5/zwqp1AFLI/D
         KhQNTcaXaAi0O38N2kjpHvfVpitydupIkNcf+6NOVYDFj0j8SX9QfdTjsF7drC9PwH0d
         mpTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787513896; x=1788118696; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GeNOix2Ot/y4ev1GhCpZSYQOtGev8glAVYf5ddJeG+0=;
        b=Hzd9xguIRYuFlAXpX/bFZ/Kr6et2SV2NdtI7frkObBc74V3n9wi7fGj5/TQLICSHQY
         +NnykQZEEUZ1aVHQuzaThYPdnmYRKK8BN+0IDqyJb3cMapdBBXIhstRs1GpDdkSaRf3m
         mY7IMagu7As8KeV8EY8Y+6KUlNl6t7TOI3FhgTm/5qFaQtft+Cd0gYdcVV315TacZFMa
         YwRBCl3BDBVKH4nj9Z2xD+kodQ0DMKt7DkBYuj11cNngZL5TjOJH30lvLE+sIbD9kDuK
         TtJe15vgT9uSSUnqGUZze9mR3WZpDXfeK+2+ZuAZjYqJQzRYQKdVdMoeXHhO0qlgo9DV
         KbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787513896; x=1788118696;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GeNOix2Ot/y4ev1GhCpZSYQOtGev8glAVYf5ddJeG+0=;
        b=UoMGfOtXF/6aR5FfDk2jkv+xxt/oO14DVwhl8a5mV72/geEydi9shw5QFeSaJj4tGP
         vUhX4J+ceDfkdfJu2r1WlxQovZxIxSyb7wRzH2IRe4nkrJzD9y6JJ2YNMvQu7K3B+uql
         cbhUSHvMjDdMRJ6k5VStrMMTIoq6ya4mpGMuN5+UsgjbLgIpkajs3ZxUZOxqr8paNf5v
         32kXFI9VnTdcw8hlxwxkEyoIPUpYva2D9yAcI2R3SuNB2t6Q88pqCF7z25WFwagDE+oI
         jQP5K1ahOK9QUAVWSzfMNplmueq/0tOUOfxDUzIzEm6S/VhMKOxIFVdqPpx54d5aIlzK
         30ow==
X-Gm-Message-State: AFuF++k8U7XbP74UTqJBtP5Jf5ayYP4SKCEPuqw1j7fP2wot626HrPbS
	6lS3lVsv+9dOXShxSrp12qPsyp1TFLTbQol2yfzHkyNCldio9VAlNjXmDK4jK7Fjtm0crxtCm8m
	oj6lgA+bqvRYUtqBWR3K0HyRGsifiCcg=
X-Gm-Gg: AR+sD12B+QEuuf0PkeB9UTyhatZtBwS3draoq6ZKmwabXbRBWi3dUCD7h+1Vj34038Z
	pnohxm7fBZ7rGLgK5f98PHrd/7LWi9ead0DA232cyjojunkNsrYBf0pjIImRER3TNgqbmIbDw5j
	6eYcy1uRXuqZt/8s/5MgQMAVLoaQeI+ZLDwy0sP0bDTmbiDyXkORTl8nNAvUlA9yGKAIbyTJZVW
	VqMcqRwdDiCB2zKlOBMyWpEtO+mt7mPmNC/tcUD6fKGHA8MYaZ8GHQGT2JfoBYBK2RRyqAnYA8Y
	oKXfTd9ldIETfxabFehlwgWqXPRGhqigtA+T05lIhUwowt+dKs6kwTsiQCDQ+pfqYT71ZO72Rhd
	D/GAYa5NoFokq/73kNkciBPQBCryEaSX5rcpWDC2rvIVYqeSY3t3DtSYL5WSSvzw=
X-Received: by 2002:a05:6830:4492:b0:7f4:3902:3a26 with SMTP id
 46e09a7af769-7f46271389bmr19740589a34.1.1787513896067; Sun, 23 Aug 2026
 12:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
 <20260801174156.2998808-1-mmontalbo@gmail.com> <1f8fe709-ef19-496e-9857-8c2d24b29c56@gmail.com>
In-Reply-To: <1f8fe709-ef19-496e-9857-8c2d24b29c56@gmail.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sun, 23 Aug 2026 12:38:04 -0700
X-Gm-Features: AcwNN1U1_EmQTKLERIu-3UoJMA0Olz3jDtfdl1xp1wCXW2vcnOlgkZpC70dUdtM
Message-ID: <CAC2Qwm+kzT_3_GKrpay=JLGYsxS10oWCg2MJPHrCVogFHA0OdA@mail.gmail.com>
Subject: Re: [RFC PATCH v7 0/10] diff: add provider interface and initial providers
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 6:52=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>
> Hi Michael
>

Hi Phillip, apologies for the delayed response, and thank you for taking
a look!

> On 01/08/2026 18:41, Michael Montalbo wrote:
> > Every in-process diff in Git reduces, at one point, to a single
> > question: given two blobs and the settings the diff runs under, which
> > line ranges changed?  The answer is the diff's hunks: for each change,
> > the position and length of the range on the old side and on the new.
> > Each consumer asks in its own shape:
> >
> > - blame diffs each suspect's blob against its parent's, taking only the
> >    coordinates through xdiff's hunk callback;
> > - the stat formats keep only the added and deleted counts;
> > - patch output emits from the hunks, with xdiff interleaving context an=
d
> >    content around them;
> > - log -L maps the tracked range across each commit from the coordinates=
.
> >
> > In every case the answer is computed the same way: load both blobs and
> > run xdiff.  That is the only source, so nothing that already holds the
> > answer, or that would answer differently on purpose, can supply it
> > instead.  Sometimes that is what we want, which is why patch-id and
> > format-patch stay on the builtin computation throughout: patch-id needs
> > identical hashes on every machine, and a format-patch must apply for
> > recipients who share none of the sender's configuration.  Other times
> > another source would be useful.
>
> This explains the mechanics of the existing implementation, but doesn't
> really explain what the advantage of the change is beyond having a
> unified interface. What are things that are unlocked by this change? Are
> we doing it purely to cache the hunk headers or does it (as I suspect)
> unlock other features?
>

After thinking more about this feedback...

> > This RFC sketches a direction.  The unified series shows one interface
> > carrying two example providers and their interaction; it is not shaped
> > to merge as one topic.  If the direction holds, the work returns as
> > separate reviewable series (see Roadmap).  The two examples are
> > demonstrations, each an RFC on its own: diff.<driver>.process, the RFC
> > cooking as mm/diff-process-hunks, lets a configured external process
> > answer with its own notion of which lines changed, and the diff-hunks
> > store, new in this thread, remembers what xdiff computed and serves it
> > back.  One is authoritative and external, one a cache and in-process.
>
> What does it mean to be authoritative? Why isn't the xdiff code
> authoritative?
>
...
> > Chain order is the authority,
> I'm not sure what that phrase means
>

...and the concept I was trying to express here, I realize the abstraction
introduced in the latest v7, a "diff provider", is not ultimately helpful a=
nd
shoehorns several concepts together that should be addressed separately. Th=
e
"chain order is authority" was (poorly) trying to describe that diff_provid=
ers
occurring earlier in the list of providers would "override" the default
"authority" of xdiff. The concept "authority" in these terms is unclear,
though, it could mean "who gets to answer first" or "who gets to answer
differently than xdiff." It also could paper over how each current caller u=
ses
xdiff in its own control flow with a "chain" of providers.

> >    terminal provider is the builtin computation itself, so the interfac=
e
> >    never exists without an implementor: patch 02 ships it answering eve=
ry
> >    request the way the consumers did before.  A consumer states its
> >    request in one struct and reads one set of outcomes (answered,
> >    unanswered, or failed); it never names a provider, and a provider>  =
  added later maps onto those outcomes inside the interface, so consumer
> >    code is written once.  Because every diff now walks the chain even
> >    with no store or process configured, the default path was measured
> >    against the pre-series base and runs within noise (a 5000-commit
> >    log --stat and a long-history blame, ratio 1.00 either way).
>
> So we can configure a provider for a particular file type via
> .gitattributes and diff.<driver>.process and then it is used
> automatically, if there is no provider configured we use xdiff?
>

Yes, that was the original intent.

> > - The diff-hunks store shows the non-authoritative side: an in-process
> >    cache at $GIT_DIR/objects/info/diff-hunks that may only reproduce th=
e
> >    builtin diff, so serving from it never changes a command's output.  =
It
> >    is read by default and written only when a repository owner opts in,
> >    warming it as a side effect of diff work the command already does:
> >
> >        GIT_DIFF_HUNKS_WRITE=3D1 git log --all --stat >/dev/null
> >
> >    A warmed store then serves the stat formats and blame from stored
> >    coordinates instead of a fresh diff: on git.git a 5000-commit log
> >    --stat runs about 1.9x faster, and blame reads the same entries
> >    opportunistically (full numbers in [1]).  Its format and keying, wha=
t
> >    it may not serve, and how it handles corruption and staleness are in
> >    git-diff-hunks(1), gitformat-diff-hunks(5), and [2].  The interface
> >    point is small: a cache drops in as the provider that stands aside
> >    wherever an authoritative one answers.
>
> I had a very quick look at the documentation in patch that implements
> this. Am I right in thinking it stores xdl_opts directly so that we
> cannot change the in-memory representation without breaking the cache?
> Are there plans to garbage collect cache entries when the corresponding
> blobs are removed?
>

Yes, you are right regarding the in-memory representation breaking the cach=
e.
On a separate branch where I was working on diff-hunks more, I had a prune
command that removed entries based on time as a maintenance task, but nothi=
ng
more intelligent.

> > - diff.<driver>.process shows the authoritative side: an external
> >    process, configured per driver, whose answers may deliberately diffe=
r
> >    from the builtin diff and outrank the store.  Git asks it for a pair=
 by
> >    object names alone, so it answers before any blob is read, which sui=
ts
> >    a cache or a process that fetches the blobs itself.  Consulting is
> >    opt-in per command, following the allow_textconv precedent, and a pa=
ir
> >    the process cannot answer falls back to the builtin diff.  The
> >    protocol, the per-command gate, how failures are handled, and the
> >    versioning that lets it grow are in gitattributes(5) and footnotes [=
3]
> >    and [4].  The interface point, again, is small: an external,
> >    authoritative provider joins the same chain ahead of the cache, and
> >    neither consumer learns it is there.  A later content-carrying reque=
st
> >    would extend it to the pairs and consumers this identity-only form
> >    leaves on the builtin diff.
> >
> > The series stops at the coordinates.
>
> Does this mean the offsets and lengths in the hunk header? I can't see
> any reference to "coordinates" in the existing code.
>

Right, "coordinates" is a term I invented to refer to offsets and lengths,
but I can see why it is unclear and do not think it needs to be coined. I
will replace the use of that term with more explicit / already established
terminology.

> > A consumer that needs the changed
> > text, such as patch output, would have only its hunk selection replaced=
,
> > with xdiff still emitting content from the blobs; that machinery is the
> > content enrichment sketched in the Roadmap.  Establishing the framework
> > on coordinates first keeps this series one design: the question, the
> > interface, and two providers answering by identity.
>
> This seems like an interesting proposal and the diff headers seem like a
> good place for initial phase to stop. It would be helpful to have a
> clearer explanation of the features this interface would support (i.e.
> what's the motivation for these changes) and a lot less jargon in the
> interface description.
>

I really appreciate your feedback on this. I spent some time thinking about
the most straightforward way to express what I am going for. My goals are t=
o:
  - add a "cousin" interface to xdiff-interface that allows users to
    configure their own alternative to xdiff. Among other things, this woul=
d
    enable users to install their own more intelligent diffing mechanisms
    while composing (to some extent) with surrounding Git diff functionalit=
y
    rather than replacing it wholesale.
  - still use xdiff in the end for its content rendering features so the
    alternative diff hunk provider composes with Git's existing diff
    features. Meaning, this "cousin" would stage hunks and then xdiff
    would render in the end.
  - provide the additional feature of allowing current xdiff-interface
    callers to potentially operate with oid's only and no content loading t=
o
    save time dealing with content when only hunk header info is needed.
  - somehow make a consistent/easy interface for users to plug in their
    own xdiff alternatives, which has been via pkt-line.

I think returning to the v6 line of the topic for future re-rolls and focus=
ing
on the framing of a "cousin" interface to xdiff-interface, makes more sense=
,
rather than the "diff provider" concept introduced in v7. Accordingly, I am
inclined to eject the diff-hunks patches for now and focus on the "pkt-line
xdiff-interface" line. The diff-hunks example was meant to show an
in-process xdiff alternate / complement that cannot occur over pkt-line, bu=
t
I think it makes a lot less sense to include in this RFC now that the "diff
providers" concept would be dropped.

> Thanks
>
> Phillip
>

Thank you!
