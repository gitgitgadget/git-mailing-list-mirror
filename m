Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC003DC4C8
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041831; cv=pass; b=lTxvLEQX5jLkr9+UHYNj1ywvy2lbUp4Mp9N7Qr51EmrnX5Bcctiw1OFmXbeJ1XNs5c1RQ+TE3OtcivYphErnd7dcDNrP+6xRyvP+MU54b9AcvfbFIR/Ms9oiuFAo7KP6K/myJkkK9/wYqdWTKE1EPdtE0gs5mYlLszZUt1ESNgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041831; c=relaxed/simple;
	bh=TfohyiCwNhzzFCeIlXWMYcDIg9RTR+w1jRsQDsOITw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLSZQP/M1czQpXzYnnIBjY7GzICSKbMm+Ul2UQz8t7mxD4JyKx90b+UoZeuCcWyo4vAAb0uLslwEBpy4BK+hcEicZebYpJehK7r119hK7xZQNOnWp5pd66o2rijoDMK1X9kH4wNmU5IIv+5imeSCyNSaqNWPI1KLEAGBcDAtaAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFwCHk+X; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFwCHk+X"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c7971d0d97dso4679609a12.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 07:43:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777041827; cv=none;
        d=google.com; s=arc-20240605;
        b=dcQLbxrdsDvqx86O7gaXR0BABw7JI6tmOAje1eB74Q/yqBnX1wzsWmLat291GK/J0z
         efmDpSWEPHjo/ZDCZ0LSRzCljOPnaxqNeZbftz0MCnHp1tHvM3DYkymPyOIgLsWOh1fg
         kacbF6gd3/gV4Q0c+GL5HWpO1lf0Z1pfWuu3byb0m7QtDFNXvvj1WvsSZzZdReUC5OqI
         gNk7MDFeJmbcq+m5K+pgDJQi2y0oEP0VD07ZSWkA+MvQmwiSM0rZTQaKXhHDCRAgrjAn
         PL5lyrUDlA4TfeQuTVB+M4DYvhCbtfY8KUCgqqBfEObYD1+7GrUynCN1cimbqAwLX+a0
         M3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NrqkaTu6F3hgC5gxjg5Kkdc4d7wd3jdN1618WDXm8wU=;
        fh=7C13Yara6diLW3o1hgquesR7ciM/ftgxAeePVQ59NFA=;
        b=IoN+R/gqRp1FRu6+JA6wIJjFR21SSl1yXOnYNVDC4TMBIFTzIwt6Hdr5okYvllWp04
         k2gYUVSQouVszkGsmz9fSCzPRcpPgloAr5OBFmpHSXrWpBK8kOQAn2qilVbrgS+fA3iO
         9uUzhOBghlw41XxTBpG2g14RORQfYU5PC5ziHsddQyzglGhYLrnsKN3OH98WxrNP1FKy
         BEE87FkFkjTQCbmVCqrOOZh7Bt/5Kd99w4dEAqXPZc9cvO0tyQUT/BALlbtVKdNgX48N
         j64NOCSz+P5j+gu5mysEfzB/ywK/sl3o+xXIJ0iUGNvPY82jgbUOxI8fiL6vN2x8MZYm
         lqJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777041827; x=1777646627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrqkaTu6F3hgC5gxjg5Kkdc4d7wd3jdN1618WDXm8wU=;
        b=mFwCHk+XZpWoSEMwf94dcvnf6iZUSW9IhWznIpqxNX0EdVQ8uxeE8YWgMA2vUZO3Cq
         5BYvT2uzXLJM7SwI3Z01h3GQfQkyuxMxRFzDxgDVRJbCQUoIIk+vJ7J7wCruqhBIRJKq
         ap+JMXbC41ATeaIxJVqDFltntPNqayAXr2Qq4EIfpyPcq4fGDjp5KpKbph2gqHpYv1oQ
         XkJvAlbFaq4Lsf/d6K7oxXs8NmSig1SyorzlFt8PPvFUppXae2erpSPFvvrXImMY3KWD
         KuF01b74g5iBq4Dch00kA8sO1h6PPh7gHrGwfw7ftGoKYJypgfAcsMrTiFbytfEIFUOe
         GIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777041827; x=1777646627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NrqkaTu6F3hgC5gxjg5Kkdc4d7wd3jdN1618WDXm8wU=;
        b=pzRLDgcCtG/fyqkFxN2ZkJkvn7O6wzK7bvMkEQTVN4QNely8GvOvBgDV0yBJRjVt2z
         5q4PZrf3QCDunwi0V9mahPammaaO385jHJmn8rI9X2VO9YdUVmFjeVmRcrHIsR287+dS
         nOYiX0gyMuCB3udPfkYYgXS12PxgYzv7yRymHR38Ry5k2Qkk+gwhozfMzTX9P8XtyyOd
         0FJu3I+zI5J8efHivsTXMySi125BcV+FJydB/3hDtbKBImBnRidfBVuGt1EmQbvSAR6O
         As/GB172597O0bYs6i8p+NQuFmKqmxTdiTA6dnSnbH/VOgEm7M3gqUmWrNZCdOsd5jF7
         bzcA==
X-Gm-Message-State: AOJu0Yzue6WS1yeO7qJYSgX4jroXWYMicXsJy5Ri0E+H0dipjV25Vtfv
	6OT3AwVb/pzxJuWW1icdMuq8gFBHk0QX52rL8i+XwyLQ95bAOURJunDXz8FaYloVw9EDZh31g/g
	4j6oZBbcI8vuqujprpXFq6sFDhh5WU38ryw==
X-Gm-Gg: AeBDiesKZUlWGjTUsvdtl0HFtWUVcWFBf8BGTNO2zKU3jdRtI4BwbZ5Y0CZNm89tQ6b
	uMC6qM8cr+ubgNr6NaPYtLcTRVXFzrXSt5av93exFqow1q3jzgOiBwrSCqgSVlHpcTP6pPraOxJ
	5YQ700Tbrav4PxD/jkUgg55Zfp8pqI3SLnvM8FfVGBM8Z9Epfd2r89exaSr0LxraUHh3ghPBhPk
	0CF5mLRIFCCmDynoeFnAqDIVtDG9+AouA23d2lWa8RxE2x7BvJu6HczGLhMKGu98m5PqiQbDrHW
	xiWI7sMDPNzIzYUiHVQq70RpnuC5CNkKTiNA6mYM9gPq4kD1UraclizhCxJWGDVLxIOADLisQOB
	i9qkNRfbkNaku17iWEm+WCMAu9w==
X-Received: by 2002:a05:6a00:4fcc:b0:82f:5034:77a4 with SMTP id
 d2e1a72fcca58-82f8c8409b4mr34512292b3a.21.1777041827112; Fri, 24 Apr 2026
 07:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422-b4-pks-history-fixup-v1-0-48d4484243de@pks.im>
 <20260422-b4-pks-history-fixup-v1-2-48d4484243de@pks.im> <CALnO6CCBA=OSvKT8D6-YR1S=x3VOa_MpzWfK6FJWPSXq0ysMPg@mail.gmail.com>
 <aenCRKxak1l6GE3H@pks.im> <CALnO6CAZQxvqEqDhahFs7NcjENrU=Dg=cbFDkEeAE3+h_3R+8g@mail.gmail.com>
 <aesTeWQqMTFd4gy8@pks.im>
In-Reply-To: <aesTeWQqMTFd4gy8@pks.im>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 24 Apr 2026 10:43:35 -0400
X-Gm-Features: AQROBzDyGBUVSNx3aBT2cmWLHU-2I6X5hvVLpLp2u7c3shupffJF_w6tcwIlPTQ
Message-ID: <CALnO6CCkdoCFfyq97hUNzx2DaBNSHBpCUWfuq2LW1Jfzt2jfEw@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/history: introduce "fixup" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 2:53=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Thu, Apr 23, 2026 at 05:18:50PM -0400, D. Ben Knoble wrote:
> > On Thu, Apr 23, 2026 at 2:55=E2=80=AFAM Patrick Steinhardt <ps@pks.im> =
wrote:
> > > On Wed, Apr 22, 2026 at 03:06:12PM -0400, D. Ben Knoble wrote:
> > > > On Wed, Apr 22, 2026 at 6:30=E2=80=AFAM Patrick Steinhardt <ps@pks.=
im> wrote:
> > > > > diff --git a/Documentation/git-history.adoc b/Documentation/git-h=
istory.adoc
> > > > > index 24dc907033..3cdfc8ba02 100644
> > > > > --- a/Documentation/git-history.adoc
> > > > > +++ b/Documentation/git-history.adoc
> > > > > @@ -53,6 +55,19 @@ COMMANDS
> > > > >
> > > > >  The following commands are available to rewrite history in diffe=
rent ways:
> > > > >
> > > > > +`fixup <commit>`::
> > > > > +       Apply the currently staged changes to the specified commi=
t. The staged
> > > > > +       changes are incorporated into the target commit's tree vi=
a a three-way
> > > > > +       merge, using HEAD's tree as the merge base, which is equi=
valent to
> > > > > +       linkgit:git-cherry-pick[1].
> > > >
> > > > I'm not quite sure what, as a user of "git history fixup," I'm
> > > > supposed to take from this. Does it make conflicts less likely when
> > > > creating the new fixup? I imagine it doesn't help with conflicts
> > > > between <commit> and HEAD that newly arise.
> > > >
> > > > Anyway, I'd think the mechanics are less relevant than the end-user
> > > > behavior at this point in the doc, unless the equivalence with
> > > > cherry-pick is supposed to tell me something about that behavior.
> > >
> > > There's at least two more or less obvious variants to do this:
> > >
> > >   - You generate the diff between HEAD and index and then try to reap=
ply
> > >     the patch on top of the target commit.
> > >
> > >   - You perform the three-way merge.
> > >
> > > The second item is definitely more robust compared to generating the
> > > diff and reapplying it, and we use the exact same strategy to perform
> > > cherry-picks nowadays.
> > >
> > > > > diff --git a/builtin/history.c b/builtin/history.c
> > > > > index 549e352c74..6299f0dfa9 100644
> > > > > --- a/builtin/history.c
> > > > > +++ b/builtin/history.c
> > > [snip]
> > > > > +       /*
> > > > > +        * Perform the three-way merge to reapply changes in the =
index onto the
> > > > > +        * target commit. This is using basically the same logic =
as a
> > > > > +        * cherry-pick, where the base commit is our HEAD, ours i=
s the original
> > > > > +        * tree and theirs is the index tree.
> > > > > +        */
> > > >
> > > > OTOH, this explanation helps quite a bit here :)
> > >
> > > Hm, okay. I felt that this explanation here is even more technical. H=
ow
> > > about:
> > >
> > >     `fixup <commit>`::
> > >         Apply the currently staged changes to the specified commit. T=
his
> > >         is done by performing a three-way merge between the HEAD comm=
it,
> > >         the target commit and the tree generated from staged changes.
> > >         This is using the same logic as linkgit:git-cherry-pick[1].
> > >
> > > Not sure that this is an improvement? Happy to hear other suggestions=
.
> > >
> > > Thanks!
> > >
> > > Patrick
> >
> > Hm. I think what I meant is that the in-code comment makes sense to
> > describe internals; for users, I'm not sure what I should get out of
> > that description of fixup.
> >
> > What I (think I) really care about is that it behaves a bit like `git
> > rebase -i` with a "fixup" command (modulo conflicts). Especially since
> > this is quite a bit more porcelain than plumbing, no?
> >
> > Idk. If the 3-way merge is valuable to keep, maybe it belongs in a
> > second paragraph just to push it out of the way of the primary
> > description ("Apply the currently staged changes to the specified
> > commit")?
>
> Ah, that's what you're getting at! I totally misunderstood what you
> wanted to say, this makes a lot more sense. How about this:

Yep, sorry!

>     `fixup <commit>`::
>         Apply the currently staged changes to the specified commit. This
>         is similar in nature to `git commit --fixup=3D<commit>` followed
>         by `git rebase --autosquash <commit>~`. Changes are applied to
>         the target commit by performing a three-way merge between the
>         HEAD commit, the target commit and the tree generated from
>         staged changes.

I think that's much better.

> Maybe there should be a new paragraph before we start talking about the
> technical details?

With this version I could go either way :)

> Thanks!
>
> Patrick

Thank you!

--=20
D. Ben Knoble
