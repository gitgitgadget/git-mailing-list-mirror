Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010EB44062B
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788602489; cv=pass; b=AbzSKHAObppk6XOtjQH5CDMfOXKq1D9Yhv4nbfAowDfXcE9QTt/p6DtC34NzJUFcYWXD/T36nsGnz8nrjl55pehkw6ml4MDCkzEGhdgsJwTIu1awB1ljqaSWUSbTqRL2Hby4R4SlGBoCaKLeKjvSyBZOb2DpJNa/4fvCZen788Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788602489; c=relaxed/simple;
	bh=f598xynJCs9MwksuZreuXYxFwyHfHBpA3PYtnCajpEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSWVB0zlowzy/riZ+DmvGZHt0B6Zxi3kAAnRpUwKxI98wlrm+7gjlWsLGNR/pYovxR4pNHo6ZJg2CkgpjxMowqDhYPMP/TXngTZPkr4A2+PoEXIlDLeNg/wGJ/b2pz9uaGynORqZ1eS5fIB0Y9EEk0VXR5GAwsLqhnGhOqqC4CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5JCeBmX; arc=pass smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5JCeBmX"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4a46a53abc9so1952505b6e.3
        for <git@vger.kernel.org>; Sat, 05 Sep 2026 03:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788602486; cv=none;
        d=google.com; s=arc-20260327;
        b=OoVw7uLqN6Q9zFqTBlpqaIe3a10IDrF3wgQAMLHOvJDsBB9plTjFyvXec+IkoltcdK
         77t2tMnUSMB8/+1Z7Som5vC2ueF212iLfrE+0oYWjWct8+EbkYOEq1MUn6p5UZkz8U8x
         UzAb+g6l/epdF4Qf0MMHvR8dob4v0bYBcK3dyfuBwK4JX4LxxYTDv7mOKKv1gg1/wjQZ
         b/CmMXGPMfHJBd34aKMteHUw0xcBjd9luz8yn0C6erhNoceChypyjA6X8Tt7OXYYMLC5
         039kc+nCA6+l9TGGwUrNx5HBFQxuxLtiwEqeQQX1/y7qeh8pEWERq7HaU5lpqa6Sksvk
         wqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NMsRlPIy5X/EMi4KsOVYOKv9YFbKBmzgt1iq2AY0htc=;
        fh=rfLjIwn2a57wX7vvUPf5sv7xoXYLkb1by0ZOpcDOxJM=;
        b=ZTqj4qpWcHWzwxC3kQtPlbLVGTIUrU57zKG4+8VGPxzRUnwOEN98WR7e73iGil6Byc
         sIrmcXQVag7m6wh5OuWASPhIAMRxfcP/eNob5BEuwQJBDVsdm/EWg8wLPJbbmiQuf3su
         LHyBZDhi3YJrPl2UR8tGWDlsS47xb3KNNutsIRIpq6z+H3R5xiwEQFAm/ZqdbDIA9tZ1
         pDbmokkQbkC/KKuHZ+tOovwqPPi+hPPUa1Sg7jqb+2rDxev0LX1pGQX8TV9bAOSqjyyo
         /xfr0ZnPKU3md9Ti4L7EA75E/uI2MxpyKId5AcJCuPcS+x2F3o/QCQsEjptENJnQsY1z
         /pKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788602486; x=1789207286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NMsRlPIy5X/EMi4KsOVYOKv9YFbKBmzgt1iq2AY0htc=;
        b=T5JCeBmXuTyRrkcFxXpetIB6LG7qmZABpuUchWnfOtwCv1Yx6RN3wvBQ5bb+Mb/120
         ebLC13bfVqMWAkMstAWKmjUI0yaoZeoe5BbYouJCU0GyxeifSXm0Iz4bUNT8wfQ08jvo
         AfHsQoyXY/BUaz2w/FBA6AzcQRGEeqxeG99fyVUiqppOUru9GG/qF9pHSNt9fEhX9OPw
         rw1yWrTsGQXb25yMrqCPBtKHkdsHhPvBXpE5DB8G6DpNCcDQatxgrR2H5sFXBxVwy7Gk
         MUq8qA8WXf7Ig/yZoFvYyMACq09+GdZx/ewHFSbDHEbf5PlDzJ+wEagHkaF1dawpWab3
         h9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788602486; x=1789207286;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NMsRlPIy5X/EMi4KsOVYOKv9YFbKBmzgt1iq2AY0htc=;
        b=A0wgMuDfiku0CeDaG9hGWGrNCvt9ZMmzUzqpLXUep/Ja0tglXOLBc+MzA/AplZeihp
         jEsU4pIIuqpRDofAV3VVbYXkzsL/zOE/lfVK07BaCl1qTvf7GQvRziQUL9MUCejGjtuy
         RooeKotKTfYnk6Of7Ph514p91Qc2c+sAMGN/bVSNAjvSj0unJnQe8eJb7M+fuKkAgTCB
         tyDFIQ2Wtsxmsw0bq7E9m5CyMmSTsVT0600tz8rN8OgBdq+ZamWlHVdUUbxdQ0sTvWWm
         RVnwwwbWqLSbMgLKN6JtkDxrmNvD+c2ScXu6H1vN4VHCP81AV5P7h3dWTmqABrNCS9UA
         jasA==
X-Gm-Message-State: AFuF++m9GH8+ZcuYtlMiHd5EP0EgzKBuprp8DRmBTCZbToE4GwMHhURc
	OS7AIM65tXWYg75P2WmCz21bgPRVgM2s/lQdcZ6AyJEklEgNcefdxYlOsm4lU2FFaBZjka/V6pi
	evUH+a+bCyPvs9mirMVYKwbo3PN/KmgI=
X-Gm-Gg: AYBFou3ZLQFiBkzWw3GQMmzJ72AvPlIiGt4iQBDnT84lFhgBz3cwz6l4zCypKS75Bvk
	AYuWnW0s0tNoSUJWAyF7/k/i1cRCHCGP+c/W1/bYR0mQcKHQO9whEi13KbJugPMkW3qkTsSTyvD
	9us7kAs5Dv29QpEap1nSFA5mmCeLxK2NlVwc08MocAYS90QTzU4gDtf9hM+JrdHSg77iKF986tY
	JfDz/TUjmUZ8sJbv4uZ4fyKPYvSRIccH0l5pCTyC854LhsCAm7yE+dxrLRFfYsMz74qZGD8dyC7
	stVVQ9pD3suoeZ29YAQBto3g0YFuhB4LZYEYgTkPcjw5FGYtsOf83YwPmCfFjw2cdQYpyAuRpBg
	rzm7oR3UglHK8NWZ4QhN1etwlB0i3ir2Xw3ozKSkSR8+ImILvB4yYRjr+CovKORzG+8kwWCaihA
	==
X-Received: by 2002:a05:6808:3a0e:b0:4b9:e5fa:8910 with SMTP id
 5614622812f47-4b9e5fa8f4fmr5436966b6e.35.1788602485709; Sat, 05 Sep 2026
 03:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260825175818.645579-1-jayatheerthkulkarni2005@gmail.com>
 <20260825175818.645579-3-jayatheerthkulkarni2005@gmail.com> <xmqqh5k43bzo.fsf@gitster.g>
In-Reply-To: <xmqqh5k43bzo.fsf@gitster.g>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Sat, 5 Sep 2026 15:31:14 +0530
X-Gm-Features: AcwNN1VaMlWdxeEc8Zg8IqSXSS-yBGwx025ctESU-lxpS2l3hAf68y4er7caSfQ
Message-ID: <CA+rGoLf-BMh_BNUwi4k7NCLakbxP8vTuLbQKctX2K6MTK5b1yA@mail.gmail.com>
Subject: Re: [GSoC Patch v5 2/7] repo: add path.superproject-root with
 absolute and relative suffixes
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 3:39=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:
>
> > +static int get_path_superproject_absolute(struct repository *repo UNUS=
ED, struct strbuf *buf)
> > +{
> > +     struct strbuf superproject =3D STRBUF_INIT;
> > +
> > +     if (!get_superproject_working_tree(&superproject)) {
> > +             strbuf_release(&superproject);
> > +             return 0;
> > +     }
> > +
> > +     format_path(buf, superproject.buf, "", PATH_FORMAT_CANONICAL);
> > +     strbuf_release(&superproject);
> > +     return 0;
> > +}
> > +
> > +static int get_path_superproject_relative(struct repository *repo, str=
uct strbuf *buf)
> > +{
> > +     struct strbuf superproject =3D STRBUF_INIT;
> > +
> > +     if (!get_superproject_working_tree(&superproject)) {
> > +             strbuf_release(&superproject);
> > +             return 0;
> > +     }
>
> Here get_superproject_working_tree() does not care what repository
> we are working on.  Shouldn't it be updated to take "repo" as a
> parameter?
>
> Since it begins like this:
>
>     int get_superproject_working_tree(struct strbuf *buf)
>     {
>             struct child_process cp =3D CHILD_PROCESS_INIT;
>             struct strbuf sb =3D STRBUF_INIT;
>             struct strbuf one_up =3D STRBUF_INIT;
>             char *cwd =3D xgetcwd();
>             int ret =3D 0;
>
> I suspect that it based its decision on where you happen to be.
>
> It means that when I have a checkout of "git", with a submodule
> "sha1collisiondetection" at its top level already populated, in,
> say, /var/tmp/x/ directory, the following happens.
>
>     $ cd /var/tmp/x/git
>     $ git repo info path.gitdir.absolute
>     path.gitdir.absolute=3D/var/tmp/x/git/.git
>     $ git -C sha1collisiondetection repo info path.gitdir.absolute
>     path.gitdir.absolute=3D/var/tmp/x/git/.git/modules/sha1collisiondetec=
tion
>
>     $ D=3D/var/tmp/x/git/.git/modules/sha1collisiondetection
>     $ git --git-dir=3D"$D" repo info path.superproject-root.absolute
>     path.superproject-root.absolute=3D
>     $ git -C sha1collisiondetection repo info path.superproject-root.abso=
lute
>     path.superproject-root.absolute=3D/var/tmp/x/git
>
> The last two ought to match, but only the latter works correctly.
>
> Before this series starts reporting path.superproject-root,
> get_superproject_working_tree() needs to be corrected to work on the
> repository in question (instead of relying on where the process
> happens to be), no?

Yes, precisely.
I didn't think of it that way.

`get_superproject_working_tree()` currently relies on xgetcwd() rather
than inspecting the target repository, which causes explicit repository
contexts like --git-dir to break.

I will update `get_superproject_working_tree()` to take repo
and update its callers accordingly, along with adding test coverage for
--git-dir in v6.

Regards,
- K Jayatheerth
