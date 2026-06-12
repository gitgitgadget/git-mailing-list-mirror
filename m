Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABA4390228
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 02:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781232063; cv=pass; b=gy6bwzUs9ZlP43MIHYTVOD+Chpywhbq3aRrWTuoV+8/7VM5/f9fZS8o+EMAT9/ai3k39px7Tsotn4qnVhhQcXR1pVs0f1h8Uv5dZ6ZhrrB8bXh4niemd7yfoeOzTFWXZJqotX4XQ91hyF9optqNNtzpWxUM6xcw8V/eZ39tl9vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781232063; c=relaxed/simple;
	bh=mYpno5FzSNszTslLOWNN1kBB8Q0yBe1qFudCzSyrZ6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jg66detyXFmbZGcvwh7RJ2An6O6DxQCdZJzoJdnNW+Irvw6k7Qs1uGkU46oMDPr6YWgQEBb6JL6+foxLHS9TTRAGy0dP2TK5HoUkc2uU38hNGz+6cN1D2bA7zZFdBk8A9eypCKy2Y3f9UtmdmAgkq8TEd0wvs+w7Jjbby8vcz9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tkzfn3ss; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tkzfn3ss"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39664fe2dd8so3655861fa.3
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 19:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781232060; cv=none;
        d=google.com; s=arc-20240605;
        b=LLkNkv8pW1J4MTlvyRQrGo11jY1HZHJ6PDz7pcsCkLOO9FeDjgn7YPJE7BebT5vdgo
         S6rhGuoh09pBJefrIJh1+VJ7zbnM2ANHsmChxEp+r7hCeLEW703ZBeXc2BFNe4g57Zd/
         BrWN/x+QUd173+e3AIx/y9Z+rUg9KMi/7Jesim5TkIlVaStwaP1eZu3RA2KTDMj5FmUp
         nsOm9bNIfoDN2kzZpyGG06X8zUVZXl9gNBQXKF+fs3zw1b5lXXgHvSDn03MuOpp1vq0l
         jQk3cjhUooEWJwXKD9i70oZCwr4qVVjNGY1FnO0aUwzV4scmWeWMQQQB0kcxFe//940X
         GxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M3NOd0lhy/6RN3a5U6TGiOgc0nbZHIaC2FehAuERbbM=;
        fh=QuqSm4z1e6fTDPgzqH4R1/5/6gjLnj6641dss+Mhz8s=;
        b=Oer+Qexef8+cXM+swPNvk5xbDLt9nHyR0PqbmDXFJYAF3vUsxh9DCkg+CBKm0Cv5P+
         uncedxtZRL5ythVIzSTBglNn49P1GHGEGhgiHu+bN7YjrizgA73zBEpEtcR1n5axG0ck
         2hu+uhMlGlH+ZTY6pdPduISfpZ1ne5xFFSvdP924zj39PdfytL+kp22V/IZThywMaLp9
         BDx/WO+iS90PWgNNCVSXDOTK68NYWwsRI0oKYMelJAkWCn+9sUR67nQ1R6xjqfUpmxyc
         twcROm22YlXx4QY6p/ZWvEtUd3KHA+o+tAN8LuKhq4Th2wlNNG8UGjlHdPUQnqkEdr6r
         qFTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781232060; x=1781836860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3NOd0lhy/6RN3a5U6TGiOgc0nbZHIaC2FehAuERbbM=;
        b=Tkzfn3ssSIHCZbb/165LVQ8pxYZVEb4JTuEZqszy5FpsOpms1LXN0gBSQxUiInTnES
         WXjinHEHHx4b0bmSeZzR8y8B/7TLrkLTI7cuNiur7bOH0MUrmVck7/tbOjT+rSXS/vnt
         xC1n2K0/QUqyRKGQNuaMt0eYlHts3ME/vkUV6vwSZs+iaghHIT0o+GW7JWFj2MpqUEVy
         tAhChJBmq4YdEkdidrMEDjmbn2OvCjX68gSb8FWP6erKTyY1cPm7Wn+5/6NSPBDMIpb/
         H3m8vpmn14JVl4jyS2x8xos3DROQ/Uqop01lvs1KYXHldQQyQgcoFM7HG0N8CaoNC1t7
         LCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781232060; x=1781836860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M3NOd0lhy/6RN3a5U6TGiOgc0nbZHIaC2FehAuERbbM=;
        b=eVtjzqLCiNdGBSOixD71APP0rcjKoElUrNHuqgy2AsxE8/yU1LXMEkNCgzUHKyYp4p
         VRm+kQTzfmvU/S/mvJIjU2KKItYJpXC8sYfOeMH+o8RRC00I2qNkzJ9uSzUFBWAkjFXl
         PmwNkatIlmxRsj3ELdDmvOwg+AMRwHyMpJGCTT0R/p/Yf+8TS57/OEoqivP1NjcRtDo2
         GlrBOJ93m83hVIMe/jiLSHYq1O8BTXNxvuX9hYM2rXax1/XDkMFyC1PSb3nXA7ezqhIK
         ktSTuYVo6TC6IXmpHaXA+MBbwNEo7kzSga9AAEpla3QutZGW8ojkBsCRNUnbjqcndh6i
         GTSg==
X-Gm-Message-State: AOJu0YzABkT4g0z6Y9GoYsX7XagIqFH1qNPhdAE3j3ctFs1OiiMrQ8X4
	Wr4SL/NAMNEU+O1i5X30l/0u1fEs7f3269XpRvgvaQNUKF7B/t3OE0bJ7M1Pi+wgpSEBz3eH4PN
	zvwvmTD0XXYxZJMvKAgc5vH9E4iQABiY=
X-Gm-Gg: Acq92OHJocjg52Ocb9l34gN1ZYcStT5UXfUsgIdkCkbAMu0/MZ8IZgBUkYxiOFg1wys
	2ATQmCcYgP4kYGWZsxMRe9/dVfZSl4wTNnbYcJosZf/ubcOIIAwNgIBqasv1Ra5BwsdUTMz5mU6
	VD4ryfEeKy4CvGYmPBNsqA44u5AZxCG9St0ZM+vXdEDHePrOd1DHKnZtN2f121EPV+RS+WR4mzk
	KBzAmebSnkGfbimmdb2IW8iOSrAYMxKvsb+aMCqkK2eRfF7iFDW5MVKYfWmetll/gw4A6IVvIWM
	RmYQYWZWQR1VchYvQKPHMlIfGMWbvcVfqAkj2Mpi+c7R01AOxwsqRSsZ8morYAXMH32d6VlCflB
	ifF58D54y3FHseLFep6LB5Zoh9QDt
X-Received: by 2002:a05:651c:210d:b0:396:6a01:a781 with SMTP id
 38308e7fff4ca-3992b2cafa6mr2336341fa.26.1781232059613; Thu, 11 Jun 2026
 19:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ref-filter-memoized-contains-v2-0-e72720344a7c@gmail.com>
 <20260608-ref-filter-memoized-contains-v2-2-e72720344a7c@gmail.com> <20260611082244.GH2191159@coredump.intra.peff.net>
In-Reply-To: <20260611082244.GH2191159@coredump.intra.peff.net>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 11 Jun 2026 19:40:23 -0700
X-Gm-Features: AVVi8CfYOzRYXy_TZu6chRUvhl6kLVIQHpDaU6o7QTXCP4dnrUlxRWiM5MngRnw
Message-ID: <CAJ-ks9=hiEaHyXP-sxYyeLc0Ky5Tw7dfOWiFAqb+A2274ECyZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ref-filter: memoize --contains with generations
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 1:22=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jun 08, 2026 at 07:36:35PM -0700, Tamir Duberstein wrote:
>
> > The wall-time standard deviations were 11.356 seconds and 133.8
> > milliseconds, respectively. Separate runs without redirection produced
> > the same output with SHA-256
> > 2466f6e2b72aa16b1a2126eddb81c8a1b2764ee251204ac034c191a925aa896f.
>
> Heh. Without the original repo, this sha256 hash is meaningless to us,
> isn't it? Ditto for the sha1 the earlier command.

Yeah, AI slop. Removed.

>
> >  int commit_contains(struct ref_filter *filter, struct commit *commit,
> >                   struct commit_list *list, struct contains_cache *cach=
e)
> >  {
> > -     if (filter->with_commit_tag_algo)
> > +     int result;
> > +
> > +     if (!list)
> > +             return 1;
> > +     if (filter->with_commit_tag_algo ||
> > +         generation_numbers_enabled(the_repository))
> >               return contains_tag_algo(commit, list, cache) =3D=3D CONT=
AINS_YES;
> > -     return repo_is_descendant_of(the_repository, commit, list);
> > +
> > +     result =3D repo_is_descendant_of(the_repository, commit, list);
> > +     if (result < 0)
> > +             exit(128);
> > +     return result;
>
> There's a little more going on here than I expected from the commit
> message. Is it important for us to short-circuit the empty list and just
> return 1? Or did the existing helper functions already handle that?
>
> Looking at contains_tag_algo(), I think it would actually return
> CONTAINS_NO here (though I didn't test it). So this is actually a change
> in behavior for "git tag" if that's correct. I doubt it is triggerable
> in practice, though, as we would simply never call commit_contains() in
> the first place with an empty list. But if we are going to add in this
> logic, I think it makes sense to do so as a separate commit (describing
> what it is doing and why it's not (yet) a triggerable bug).
>
> Checking the result of repo_is_descendant_of() makes sense, as discussed
> earlier. But probably that should come as its own patch, since it's an
> independent bug-fix. I'm also tempted to say it should call die()
> instead of a direct exit, though it does look like the error exit paths
> from repo_is_descendant_of() would all have produced their own messages.

I dropped the empty-list change. The error check is now a separate
patch and uses die().

>
>
> And one side note. While looking at the implementation of
> repo_is_descendant_of(), I did notice something curious: it also
> switches algorithms based on the presence of generation numbers! So it
> should also be cutting off the traversal early when possible. But I
> guess its main problem is that we call it independently for each
> candidate, so it may traverse the same (useful) stretch of history
> multiple times.
>
> So probably an alternative approach to this patch would be feeding all
> of the candidates at once, the way we do with reach_filter() via
> filter_refs(). I'm not sure if we have the right functions available for
> that (naively, --contains and --merged are inversions of each other, so
> swapping the arguments to tips_reachable_from_bases() might work, but I
> didn't think very hard on it).

I tried the suggested argument swap, but tips_reachable_from_bases()
only reports whether a tip is reachable from any base. It cannot report
which candidate refs contain a target, which is what --contains needs.
I did not find an existing batched reachability helper that returns
those per-candidate answers.

>
> I wonder if that might perform better or worse. I'm content to leave it
> for another day, though, as switching to the memoizing depth-first algo
> here is a pretty easy change.
>
> > -     commit=3D$(git commit-tree $(git rev-parse HEAD^{tree})) &&
> > +     git rev-list --first-parent --max-count=3D8192 HEAD >contains-com=
mits &&
> > +     test_file_not_empty contains-commits &&
> > +     git update-ref refs/contains-perf-base "$(tail -n 1 contains-comm=
its)" &&
> > +     awk "{
> > +             printf \"update refs/contains-perf/%04d %s\\n\", NR, \$1
> > +     }" contains-commits |
> > +             git update-ref --stdin &&
> > +     git pack-refs --include "refs/contains-perf/*" &&
>
> My head almost exploded reading the embedded quoting in that awk
> invocation. But I can't think offhand of a better way to do it. You
> can't use test_seq because it needs both the number and the original
> string. You can do it with sed, but it probably ends up even more
> unreadable.
>
> But OK, we are making a bunch of refs based on first-parent history.
>
> > +     tree=3D$(git rev-parse HEAD^{tree}) &&
> > +     base=3D$(git rev-parse HEAD) &&
> > +     target=3D$(echo target | git commit-tree "$tree" -p "$base") &&
> > +     git update-ref refs/contains-diverged/target "$target" &&
> > +     for i in $(test_seq 1 4)
> > +     do
> > +             commit=3D$(echo candidate-$i |
> > +                     git commit-tree "$tree" -p "$base") &&
> > +             git update-ref refs/contains-diverged/candidate-$i "$comm=
it" ||
> > +             return 1
> > +     done &&
>
> And then a few candidate refs that are not reachable from other refs, or
> from each other. OK.
>
> I think you could just write:
>
>   git commit-tree HEAD^{tree} -p HEAD
>
> instead of doing separate rev-parses, but it's probably not a big deal
> either way.
>
> > +test_expect_success 'verify contains results' '
> > +     git for-each-ref --contains=3Drefs/contains-perf-base \
> > +             refs/contains-perf/ >actual &&
> > +     test_line_count =3D $(wc -l <contains-commits) actual &&
> > +
> > +     echo refs/contains-diverged/target >expect &&
> > +     GIT_TEST_COMMIT_GRAPH=3D0 \
> > +             git -c core.commitGraph=3Dfalse for-each-ref \
> > +                     --format=3D"%(refname)" \
> > +                     --contains=3Drefs/contains-diverged/target \
> > +                     refs/contains-diverged/ >actual &&
> > +     test_cmp expect actual
> > +'
>
> This is a funny test to have in the middle of a perf script (which
> hardly anybody ever runs). If we are concerned about the correctness,
> should this be in a non-perf test script? Though I'd imagine something
> like it is already covered there.

I deleted that block rather than moving it. It only rechecked ordinary
--contains semantics already covered by t3201, t6302, and t7004; with
GIT_TEST_COMMIT_GRAPH=3D1, those tests exercise the newly selected
memoized path for branch and for-each-ref.

The series adds functional tests for the behavior that is actually new:
t7004 covers cyclic replacement histories, and t6301 covers unreadable
ancestry. The p1500 additions now measure performance only.

>
> There's a lot of subtlety in what we're verifying, too. In the first
> half, we are checking that all of the commits in contains-perf contain
> the base.  And that base is the final element of the contains-commits
> list. Which made me wonder what happens in a branch history, since that
> list is linearized. But because we used --first-parent to generate it,
> it _is_ linear, and the results work out. So OK, I don't think it's
> wrong, but I am struggling to understand the meaning of the test.
>
> The second half is just checking that...the other refs which are not
> contained in "target" are not mentioned? OK, but why do it only with
> commit graphs off. Why not both off and on? Again, I'm not sure I
> understand what we're trying to focus on here.
>
> > +test_perf 'contains: git for-each-ref --contains' '
> > +     git for-each-ref --contains=3Drefs/contains-perf-base \
> > +             refs/contains-perf/ >/dev/null
> > +'
>
> Yay, actual perf tests. Here we have a ton of matches, and they all walk
> over the same chunk of history. Should get much faster, though it's
> mostly a synthetic test.
>
> For --merged, we already have separate tests with each of for-each-ref,
> branch, and tag. Should we have the same here for --contains? And should
> we be using the input repo data, rather than our synthetic test? It is
> nice to show off the performance with the synthetic test, but ultimately
> the point of the perf suite is feeding it real workloads and looking for
> regressions.

I added p1500 cases for all three frontends using refs from the input
repository, while retaining the synthetic shared-history case.

>
> > +test_perf 'contains without generations: divergent refs' '
> > +     GIT_TEST_COMMIT_GRAPH=3D0 \
> > +             git -c core.commitGraph=3Dfalse for-each-ref \
> > +                     --contains=3Drefs/contains-diverged/target \
> > +                     refs/contains-diverged/ >/dev/null
> > +'
>
> OK, and this one should find that most of them are not contained, but
> the depth-first algorithm could walk all the way down to the roots. But
> we don't run it at all, since we disable commit graphs!
>
> So what are we trying to measure here? If it left commit graphs enabled,
> I think we could demonstrate that using the depth-first algorithm with
> generation numbers does not make anything _worse_. I.e., that
> for-each-ref and branch did not regress from the change.

The divergent-ref test did not exercise the changed path, so I removed
it.

>
> > +test_expect_success 'missing ancestors are reported by contains filter=
s' '
> > +     test_when_finished "git update-ref -d refs/heads/missing-parent" =
&&
> > +     {
> > +             echo "tree $(git rev-parse HEAD^{tree})" &&
> > +             echo "parent $MISSING" &&
> > +             git cat-file commit HEAD |
> > +                     sed -n -e "/^author /p" -e "/^committer /p" &&
> > +             echo &&
> > +             echo "missing parent"
> > +     } >commit &&
> > +     broken=3D$(git hash-object -t commit -w commit) &&
> > +     git update-ref refs/heads/missing-parent "$broken" &&
> > +     for option in --contains --no-contains
> > +     do
> > +             test_must_fail git for-each-ref "$option=3DHEAD" \
> > +                     refs/heads/missing-parent >out 2>err &&
> > +             test_must_be_empty out &&
> > +             test_grep "parse commit $MISSING" err ||
> > +             return 1
> > +     done
> > +'
>
> This is a great thing to test, but probably should be pulled out into
> a separate patch along with the fix to check the return code.

Done in v3.




>
> The commit construction looks OK, and is nicer than corrupting the
> repository by deleting a real object. Given that we are pulling the
> idents from an existing commit, it might be simpler to just use the
> whole commit as a template, like:
>
>   git cat-file commit HEAD |
>   sed "s/^parent /parent $MISSING/"
>
> but it may be a matter of taste.
>
> -Peff
