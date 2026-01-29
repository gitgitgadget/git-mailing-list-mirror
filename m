Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FF4345750
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705624; cv=pass; b=lHc6B/VWBo/S+xEoIfqJqGGgqCOanTE7cyWqAuXdiO4TACgD0ppdcvFklJjkumsMovFjZp67K9I3B7wAegERrxri6JfDdQ4v+W4jfky+po/J1Cdhtpw+r0Q8fgI2F3b2+CuPlcptOI6dWgnG27P6/Sqt9ITTa4jwzqBrbeaUPBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705624; c=relaxed/simple;
	bh=p7DMZwaZws70tHd01qo4NzWvN17kEiAFXC5z+AEZvSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sloxqXsYi+3FAACkWeNjTryYriIRx+Ha4l1peTm+y8OTRE7spVIUQ6sovOpysB/7JIZpEssPZQmGi1fhxA6b7mSP19/PaSFXy1Sfu1wbehdJebhZiTF2E8/RnITaE+8NT00REQgYbwP8oi6sXaYKDdOFMa77jRkrzS+A4jfQomk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jd6PSdEn; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jd6PSdEn"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432d2c96215so1066580f8f.3
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 08:53:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769705621; cv=none;
        d=google.com; s=arc-20240605;
        b=JlTX1lhpThQW30QaHpoBBSK2A+vgF7glrFagGS2DzUtJ9ADC/BO1Wd6YmW0U4X+QsD
         LHaW1RajGPT5LyJcvWcLDy+iXCPXUkU02JORmLkd8vEdR60ZqyJQFKtdwMX9uZ2oUbG4
         SH3NRL7mVyo+RfgTnSEnod4mIAP0AiYT8+91bpSOqfNnWR5a1v2phJmqnkprgxhT/Vyc
         LT+MktxR2/uxcKOyYf/dulNsXWTgeTIozVlvlJxbf77xm12dDxOHTkyedgLYEPOwEmSt
         ee2VYMNWoin31fHv1Yn4SDAYO+w37ucafYUFfOh0OSM28j1D9GPQteUDaW23LBzbzzHP
         wLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rMojeZ+MT9IDMbhrg2bDU1juKMXTquLfNeETBN/OHKo=;
        fh=Z23r5Gqkv0hfb7+AE+6cZSh8FYyyMto21+RV+PYI3xc=;
        b=FjueGVowhDcQDmDsItqGolfIpoLhFxseR6yyEpejosP2yU2kWMrxn4zecBiu8qL4CK
         0Kg1IdP0Y+Pvz4zHkD09PfbbYm03WyMeQRtt6Mgb33BaHqft7etz9LW89X0ltfWDc1d6
         4j24k1xSjoxDDQupwGz8SQxwE7CoZJ89eiA8KZHmjGIVA7f1BrzRfrlN8S2mRbhN5cQD
         Gm/SMaX/sfV7LnFSnw3R0nnU3kr6zySqu51wh5Ix3KMmbRlZqhLnBcM8m4cZSHKR9HZF
         pRotCwO6U5N4qkZOz2yy4wF8DTIJgiEkMISJ3RQmKq3Fbu++6EY5gFFsAthbDBn2CMpk
         fy4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769705621; x=1770310421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMojeZ+MT9IDMbhrg2bDU1juKMXTquLfNeETBN/OHKo=;
        b=jd6PSdEnmASLUPS83+6cvk+XfnKNgwv0W8wXSNzMwPBhe5DhBQyMt1IIa4KOkZSfcH
         0sy4b428hOsob8oaP6ei5b0dRWAzrB416enp3K19d/VoaEDjq+bCnA6Dd9D1OYOQNR3d
         Z2czUugOLs/+qGd42ZkMikiDsbHJB3JcYSGhAKtun0OYK6lHHujjszHLlugeMknO6cGX
         JqgMPWy1by8Fb3HmJTHK7M5mLtUMJQZPydob0lpVM9+BVk01ex1olssUhtq2c4QbTOSu
         GkhI1FQ0clfxMzdVhHH+RnlqEIQXYnGw7jXnekq7B2wJx5ZIzciJ0nJLRqBh11LS2FGK
         X3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769705621; x=1770310421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rMojeZ+MT9IDMbhrg2bDU1juKMXTquLfNeETBN/OHKo=;
        b=cZzC2573doP/JPdEo3wlFoddZ9lEkFDM5tO9Bs3B52V30CUvL1Lb7fKcSCVJlM9A/D
         mOTKHBnPiJbmBfuUMaH1BQOzxp6+xqK5CQLvOtxtjrSqsyFA3fYshxkdkhZSnAQFolyh
         XRFzElrsg5czD/8E8AppvOHyAexxCSAcNaDnnf9jKUTZ+QtSf5VtyCoggdrW0Wniyn3b
         QwJnZx5Swa74HcqO+4YO0PT91M44EzvPWMux7jdcHUOTbviK95ZRhvn5uf0uMZMqiAPw
         +0W6b+nHeNT2YSkvupk11cyJ4nsxmSz4xKpknKJW96cRoaLcvXrTzJ15Qd7yCdI1r+Ao
         93fA==
X-Forwarded-Encrypted: i=1; AJvYcCUJNh7RpVBz0opsg17dBsZNUS3fWwSu1SUf08OyWomA9EmFE1ML16Pbl9huACS/G65ToXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOzM2wR7ef0mMEsGdt8McpjzhqSRbdnnmQjMVG4kzWn774CsvG
	MCsdBLCGsL7ix7OtojxqqyX2QJZcP7rpL/IyCFxn5TKSxBw4tkLA1dAz/zqJkDlb9oJlZ4ZN91C
	fcPlu0G1JnSkgkmsqjTxhNC5La/1bvHFEx4ap
X-Gm-Gg: AZuq6aI1Vz18uSOW8vZQFPB2lxwC8T4i/NvrOWyShxkb1B0nDk0V2VuYrrxvnWl+TEF
	zeteY+ZcoepM3O+wmyozgiFhmJ+gzWTGE+6qxeX5WukYtuPFkJokAOF14ZH86M32uxpzRWz3Jnh
	m2Cdz3vOxelwU2CRS+3Iohjhq234j8mOcncGnAfrj211OjTkxAb7j8uAnFofoc8ewv8zFG+BjrN
	63vZjfg8o7OtjnO0d6cDzoJM3Jci8WYEKA50Hm5dki/ocbkUX4yUqCqfNUY6ar6Uh19H1g=
X-Received: by 2002:a05:6000:1446:b0:430:fbe1:382a with SMTP id
 ffacd0b85a97d-435f3ab8953mr399034f8f.54.1769705620567; Thu, 29 Jan 2026
 08:53:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
 <xmqqikcusn8p.fsf@gitster.g> <4fa413ae-f2a4-4de2-a2fb-0b1db379750b@gmail.com>
 <xmqqy0llk33y.fsf@gitster.g> <3aeb49dd-8618-42e0-b9f9-6a4fb8065793@gmail.com> <xmqq343sjn4x.fsf@gitster.g>
In-Reply-To: <xmqq343sjn4x.fsf@gitster.g>
From: Yee Cheng Chin <ychin.git@gmail.com>
Date: Thu, 29 Jan 2026 08:53:04 -0800
X-Gm-Features: AZwV_QjkN6og4EYqzaZhB3O6VN_fKCT4Z8cnmRvq9LmFeCCn0JJfwaGVWMWLn8A
Message-ID: <CAHTeOx8SOZmqvi0pkcheSjFpbEALmOwaUiX0tKLmNP7fqvjMXA@mail.gmail.com>
Subject: Re: [PATCH] xdiff: re-diff shifted change groups when using histogram algorithm
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Yee Cheng Chin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review and sorry for being a little late in replying.
Aggregating all my inline replies in one email if that's ok.

On Wed, Jan 21, 2026 at 12:51=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> So the idea is to remember the original values in g and go (the
> location of the group in the file and the other file) and if
> shifting up and down changed any one of the four ends from the
> original locations, we always take the fall-back route (if we are
> doing histogram)?
>
> By the way, this appears after the if/else if/ cascade that has:
>
>         if (g.end =3D=3D earliest_end) {
>                 ... do nothing case (case #1)
>         } else if (end_matching_other !=3D -1) {
>                 ... do the slide-up thing (case #2)
>         } else if (flags & XDF_INDENT_HEIRISTIC) {
>                 ... do the indent heuristic thing (case #3)
>         }
>
> Am I reading the code correctly that, even though this new block
> appears as if it is a post-clean-up phase that is independent from
> which one of the three choices are taken in the previous if/elseif
> cascade, it only is relevant to the second case?  I am wondering if
> it would make it easier to follow if the new code were made into a
> small helper function that is called from the (case #2) arm of the
> existing if/else if cascade.

That's correct. This condition happens only in the 2nd case. The
problematic scenario here only happens when the opposite side is
non-empty. If the opposite is empty (case #3, where we run the indent
heuristic algorithm), there's simply no need to re-diff anything
because diff'ing against an empty hunk is pointless.

You made a good point about placing it in the if block itself. The
existing code was a little confusing and took me re-reading the code
before I remember the condition. I'll fix it in v2.

On Sat, Jan 24, 2026 at 2:54=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> I'm a bit confused why we need to check both groups. I think they're
> supposed to move together (if we move "g" by n context lines we also
> move "go" by n context lines) so I can't see how we can have
>
>         g.start =3D=3D g_orig.start && g.end =3D=3D g_orig.end
>
> when
>
>         go.start !=3D go.orig.start || go.end !=3D go_orig.end
>

You are right. It was an over-specification. Looking through the code
we should be able to just use "g" and there is no need to test for
"g_orig". Will fix in v2.

> >> +                    xpparam_t xpp;
> >> +                    xdfenv_t xe;
> >> +
> >> +                    memset(&xpp, 0, sizeof(xpp));
> >> +                    xpp.flags =3D flags & ~XDF_DIFF_ALGORITHM_MASK;
> >> +
> >> +                    memcpy(&xe.xdf1, xdf, sizeof(xdfile_t));
> >> +                    memcpy(&xe.xdf2, xdfo, sizeof(xdfile_t));
>
> These would be safer as "xe.xdf1 =3D *xdf" so we don't have to worry abou=
t
> getting the size correct (sizeof(*xdf) would also be safer but there is
> no need for memcpy() here).

Will fix in v2.

> I also wondered if we need to do a diff or if we can just mark the
> common prefix and suffix as unchanged but I suspect that wont will work
> for more complicated examples.

Common prefix/suffix would not work for more complicated examples.
Here's an example (imagine each character to be its own line):

File 1:
A AAyz AAA
File 2:
A xAA AAA

The current Git histogram diff generates the following:
A [-AAyz -]{+xAA +}AAA

After the fix, we have:
A {+x+}AA[-yz-] AA

Note that there is no common prefix here, and we need a real diff
algorithm if we want to solve this issue in a generic fashion. As I
mentioned in the cover letter, I thought about implementing a "bespoke
linear-time algorithm" but decided against it. What I meant was we
could implement a simple diff algorithm that finds the common lines in
both hunks that would run faster than Myer's, but isn't guaranteed to
be a optimal minimal diff. I decided that it is unnecessary to
overcomplicate things given that we can just call the fallback diff.

On Mon, Jan 26, 2026 at 1:37=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 25/01/2026 17:34, Junio C Hamano wrote:
> > Also, after reading the first paragraph of the big comment again, it
> > makes me wonder if it is saying the same thing as "When histogram is
> > being used, we shouldn't bother shifting up and down to join groups,
> > as the result will always worse than the fallback", but is it that
> > bad?
>
> Looking at the example in the commit message the result of shifting up
> and down and then calling the fallback is better than either the
> unshifted diff or shifting without the fallback, so I don't think just
> disabling shifting improves things. It would also stop us coalescing
> changed lines, for example
>
> -A             A
>   A     ->     -A
> -B            -B
>

I agree with you, but I think it is actually a nuanced decision. The
histogram diff algorithm explicitly chose the specific
alignment/anchor points to align both files due to the frequency of
the lines. When we do the sliding / compaction step, we are
essentially ignoring and overriding the algorithmic decision made by
histogram, for the sake of other metrics that we value (compaction
values fewer diff hunks, and indent heuristics values aligning by
semantics approximated by indentation). I think those metrics do help
which is why we added them, but there's a bit of design tension
between the underlying algorithm and the cleanup step.

> To me the problem is that the histogram diff does not always generate
> particularly good diffs (maybe I'm biased - whenever I've tried
> switching the default to "histogram" I've always switched back
> "patience" fairly quickly after being presented with a diff that I found
> hard to comprehend)

FWIW I personally feel that way as well. I think the documentation and
narrative that histogram diff is a "more advanced/extended version" of
patience diff is sometimes problematic, as both algorithms are fairly
different and have their own weaknesses. The Longest Common
Subsequence (LCS) used for alignment in patience diff is global for
the file and allows gaps, whereas the LCS in histogram diff requires
consecutive lines. This means even if the diff has unique lines across
both files the diff results could be quite different between histogram
and patience. This consecutive requirement for a subsequence is why
histogram diff runs faster than patience diff most of the time, but it
does mean the patience algorithm is better at discovering a global
"spine" across a file.
