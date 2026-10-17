Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB9433F36D
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792204817; cv=pass; b=ucPFC2kN5/AeTYTPTxM4FlRXceIn3awGYxrLITubAIY+3JBR1x3Q03GPU2yhBVy1MVFo0PdV4Sign1dMcqvt8oKiuCZ7jLznbBGX0mG/CAZVK0y5g9KjEeDmDBhGK/uzwxAyqBvOewuB24QVCiVXA38xKJgS0rLjNvqjr81LEqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792204817; c=relaxed/simple;
	bh=Gh+7GoJAQTui695FyG/RD4USGQS9k42af5/F02oNzbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3z4z9xa7tIqjtNOp67qsEA2dSxKJMUc73ZveFZ4EzcQwXtWsiDAZJiPYpJhjNJfZiyudEj9artnPTF1THNkoZpnqKjLAewdP0W9ccEw+DzS/U0SFN1N74cUt/V+WCh9dZVOkCdsNJ5xASjbbuQOwUzPpgVlh8QoEoO5Dpt6FLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnliDs/w; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnliDs/w"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f2ed2541aso6498785a.0
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 19:40:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792204815; cv=none;
        d=google.com; s=arc-20260327;
        b=UzfaRWarsdVH/GNeQrzgVjtFZTOkA0BEzPbzZXorN1dDAlOJl5wTqdzTHQva+kHEAo
         3eJZIEJyTdYIEdtnGfwybgzGYUSNsKZQiPDiaHDyp7cC7UvW87zduK+4Cw1YEmTVMWwz
         nnc1RtnoM7nUEbuh6C4GqY/KEP+kl7EfUTMolrBcexR08uir5W77bzMNdL+cUhlTvfyb
         6NWwe3k/EjDBFzwJR5LEjdWxSBLuAWG0xnJp+DsWCZYO/0yLV31pEfhzrh+6Wkclgw5+
         ME6DnkXL1pHEz9wYfiBfIKLVM3B+fvH8N7XDpDcuZ97XpwrUx05rV6JpnGwwSYp1sKzx
         Cr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PXiz2+8JyPJjEVRKTQBCZh9O6fJH13cZ7uijstHx6yc=;
        fh=rhEurnMte3dV9eajID4p+GrSHRwwpir9bkV2O3A+wK4=;
        b=C72LXoJUl0AO5CdcM/VSNg39+0Wkwe6qe+GxzMNxmREaYmELACx0hdLLaWyBfOuNEw
         mSufN1vK5SP5XqWSE7fscS6H53fqUK4ylSwmWieQqSiLQrKfWdVbuTwkHKF7onJCj253
         kfCaX8YtsYIy8LDnTa5E6OU0QjbCYpsDGwBPwCokEVfPUx9KSJlcfRdhZRtxq5L6sZn5
         mqLzpCbHQuhfN9fL9zBoALlyiw3B95nYRTkgEzP2BD7SX1bvTjTSyF1R8/r1x+TMt6AY
         v2kdwzD9yCsr8YwB4zVFzXhpWlzrn+OxsFxBV2JRpFWqHOQM54U825lWRjIPk98piICx
         WC8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792204815; x=1792809615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PXiz2+8JyPJjEVRKTQBCZh9O6fJH13cZ7uijstHx6yc=;
        b=VnliDs/wFS2m4GsYO+9rRy1dlhu0WdTAN91xVVWWywY3OXIOReMPMD9RTxGmFhxkmA
         1SGpRDilFdE7QXuyjPyEERqJQsI8At0hHlJCvnU0v4ASD8W1qkQz9UFLI4EPVYAKpmVa
         qKjghklfWIKG+Q7xJvY7iwqcIwKFeJ4KfpTLiWMNtc5ZM1J0XbkxqxyJgalPcuGgLe4W
         Aby2y3+BgzN4WVXJzJezu/72kOO+NMrKaKKriwqtg7On/5iI4AuQ3xPJ/OtK2exU4Qrz
         Wuf4QOfewtpEzON02iA/Q2Nik0ozeXAw8S3qlFTDHIOw2St0zxnK+vPfKRj7LoCqCoo2
         bKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792204815; x=1792809615;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PXiz2+8JyPJjEVRKTQBCZh9O6fJH13cZ7uijstHx6yc=;
        b=X69fF2r6p70rqUOAnIpxxC7iwcLO7PbEAV12jYZuIKHtC8c1Kcs6+Rj3u1di17e3rh
         ATOAk7OmW2tMPkYamuSFHUBk2Okhd24M/IORsE9935vJIa++V5VP8T6zvlUbdblygx+D
         AfwnYgrGrFPMlsTedQJ2Nk+YbHrswVkmper/BqUQEmc1qiZMDmUao+xOFdA/Lofm5sgB
         mNHsjZgjhtzLAEjVU4/82X77gMagQklf7Zow75tPpn0/MprSaclM+An1vGWpDjxnvvOj
         j/eU6XxkClOpmH5AipnX4FEAsAw5MShIeQrw2QGUw5r8FW3MqOm2gYf3gbGj0yDiR/ha
         S+5w==
X-Forwarded-Encrypted: i=1; AKwUvBymOPdVvq7gqPQIaoxfOsvz0qBEjFSml7apBwV24+KEuQ0D7KEwFerCCZIv6eJ7G4btWFY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvyBNXpdbXbN8BUmvG04tmr5OqCtvbeMuBbtetCMB0+t+3DTVQ
	KpbMTrBpxoQH1xpJFkx6qKhtJQ/OWpe36rEH4xGf/nXxWtMuCWBOV8qaE7nbmmeR86LBw9h2TW0
	Cs8Lk1Fe5qSeBfF6DZvU2HEZM1tZpyQCEwwUW
X-Gm-Gg: AYBFou0FpwfY7LPjHMl4vNZzPn8/UxMRG/YUp2I3/biQQESxb/dbOhTkvPy5qJhc+1F
	BiSkQ50/L/x+lAyJfjot2GE7rOIhxtCMJ2OuBvoEntHjUi2cl9o/ABXIYBkjY0mHwGkF5Swcshc
	0Gqg2EYE295UkCHdRHNd6f/9RlyQyrb/qT7ewf79dB9UM3D1CCHHUltwGMzSEgiCXy5N7RCKN4m
	MHxFlGOKGC4sVc2f9uW/roMWDZDEuVze82//JKEal/SJ81gH+kduaSgYGp8XdDEXoDSpiXssEYH
	GZ5Cgyq1PMzHo/3ix92SAPh9Ea0XcvRrBzAvOauAcSLZDLX8lZYwK2ZIHZCio0HH4/8pUay1pKD
	6Pg1giJ7XZeRd3y+zM9QMfi5A2JV0nRpz3LdMIPf97dOx
X-Received: by 2002:a05:620a:6507:b0:93b:d88b:ee01 with SMTP id
 af79cd13be357-93f17f8aabcmr814595185a.34.1792204814974; Fri, 16 Oct 2026
 19:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2225.git.1789269613.gitgitgadget@gmail.com>
 <pull.2225.v2.git.1792012836.gitgitgadget@gmail.com> <015602168c8532c07b94c9f50925bf5d5a2ef7c8.1792012836.git.gitgitgadget@gmail.com>
 <xmqq8q3yon7p.fsf@gitster.g>
In-Reply-To: <xmqq8q3yon7p.fsf@gitster.g>
From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Date: Sat, 17 Oct 2026 11:40:03 +0900
X-Gm-Features: AclHuK-X7Qj-PfTPeTGBG5QCzoxPGWWuQs9K-Ix0WReI8VB4Vfy4D1Skvl56iYg
Message-ID: <CAF5D8-tTmruFLpCY4WpCkMU+3ng9pHp22MrTcUrKbXfWmhzoow@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] worktree repair: avoid breaking unrelated .git
 file and gitdir
To: Junio C Hamano <gitster@pobox.com>
Cc: Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 3:03=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/worktree.c b/worktree.c
> > index 879941a977..86094307b1 100644
> > --- a/worktree.c
> > +++ b/worktree.c
> > @@ -640,7 +640,11 @@ int other_head_refs(struct repository *repo,
> >  static const char *get_worktree_id(const char *dotgit_contents)
> >  {
> >       const char *slash =3D find_last_dir_sep(dotgit_contents);
> > -     if (!slash)
> > +     const char *prefix =3D "/worktrees";
> > +     int prefixlen =3D strlen(prefix);
> > +     if (!slash ||
> > +         slash - dotgit_contents < prefixlen ||
> > +         strncmp(slash - prefixlen, prefix, prefixlen))
> >               return "";
> >       return slash + 1;
>
> Just being curious, but slash is found by scanning dotgit_contents
> for either '/' or '\'.  We make sure what comes before the slash
> is "/worktree".
>
> Could there be situations where this code needs to accept
>
>         "...\worktrees\my-worktree"
>
> where slash points at the backslash before "my-worktree"?  Because
> somebody wrote the pathname with backslash before the worktree name,
> it would be natural to expect another backslash before the "worktrees"
> constant, no?  For that matter, would this code need to also accept
>
>         ".../worktrees//my-worktree"
>
> where three are extra/duplicated slashes (or backslashes)?  The
> normal code paths to create these directories and records the path
> to these directories should hopefully be using the canonical '/'
> without unnecessary duplicate slashes, but (1) existing use of
> find_last_dir_sep() might be a sign that we may have to deal with
> backslashes, and (2) since this is about reparing a broken set-up,
> it does not seem too far-fetched to attempt dealing with the above
> two sample input, hence this question.

While Git doesn't create a .git file with backslash separators,
it can find the repository from such .git file on Windows.
So I think 'worktree repair' should handle it.

I will also add handling for duplicated separators.

Thanks,
--=20
Yoichi NAKAYAMA
