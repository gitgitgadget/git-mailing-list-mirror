Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208F1281525
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774169967; cv=pass; b=Kmc3mgXeCI+O1Z09LEchq83qhHpp9pONIEFrqMPdhw/ln5+E4NDd6oxDT6PEwCIuuestxE4xTaDLoy7HWiZwNMmVTFJ5WBrMHfZas/D4nPKuIqZ5N0L4xSpUS3REEc2Ife+3Orbd83uNzH3XTS4bHWLs5mAEZ8CeavJRL8UX1oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774169967; c=relaxed/simple;
	bh=I7o93k9VYHZGExjo98x8vo9U730AwwQxJwQPrcy3w64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYMo14ifc+Q29HxhgACNULIoXZKmcImGAAThw45zX1VIdSmYZnS5r7z+OVa75tZRKFJJPLucOT0QrIlEYujP08+FiksFlLnDJRuZ23Pr9/zRBYzul85fgswpO16joO7WU5IabbeDzFe3ACjjBeJ2kQfj+E87Gc/xCxN9cLP/XpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bda3b4318dso148881eec.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 01:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774169965; cv=none;
        d=google.com; s=arc-20240605;
        b=f0XTReNWY+tdnJRnxSQDS5XPCE4IFXZT5jllWTcOy0e316LOiEbJsp9iJEHwJU048Q
         jBf4qAt3/id/5UU68JHTUtcGYeGY9leSq3rI9H1I5oFlL4RoZHc+GGvYaEPQDep5NnKm
         338sp75N0X3KYReSz3N+/Zz0lKDt45KHIXJqZjvgS9ZcuQxyk/CMhHyGBetI73lINqgK
         MOv9jxMeLZ9EHNQNh/nSPNL3iZDqPzpAET0eo38C/LCIgHE4a0qxM/yLyUt3VpBnNcWI
         BHcG3l8hI1K3io6xMlBmJYO4VhYX9jPQtGFT/0gbzXGJe36ITPyuaBjh7vgBNXKP50bu
         xj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=I7o93k9VYHZGExjo98x8vo9U730AwwQxJwQPrcy3w64=;
        fh=t8YpH709c3wSibd8BcbrKw+BLNNwQB+E/lqdyjFu22U=;
        b=Hf3RAAEhTNSofMiB3k4c84xMHGpVma5TQMlkoMKd91dJxXcKpCJBcVgxMis7LyV0mI
         pxdyWOb1ZlLfAlDNdI1SoWrjpg/9ysXwlVh6F/MVDoJQd8Hij9czT82JrUskJJTt5LAk
         Y+JBOF6vawsAEZTwhEXQxOke1PMWYL4YCUPYvWsla3a/EU6vg+SrfyRRVF1GWfl+FJnY
         jMPqK5aaKlKZ4yENyle73Ec+EQzEsBSxFaHFGRB45cFPxnmnpoAksN4vDJnybw5mRMmr
         K9UJcanVPtIeIP14njycN1gE9TsC6WrTlkn8XVLuzaDqvxVvr72ClMOzFJTzVsnId/OJ
         k5zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774169965; x=1774774765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I7o93k9VYHZGExjo98x8vo9U730AwwQxJwQPrcy3w64=;
        b=FhDhN89+1vOXumRBKUs+If3T78e+P5h/5fbJLGXSl/jGhgMpDxsRXdD0DDuSMpBOza
         LAmvXP5iQACbOtKacoHpq/aHueeFR5Ert37F4Y5x1eZTOnrCd9XUaSEvvv6hwZA7a1jG
         xuz3b00GvU6Mg2BjHQLIBAC/BLQlnSZEpcyEvxCsLa9q/UzpOuh12ohiGSJcaw570jHd
         4nRUtonTI92bjTSAiFOL9XRB2QlH89HJNLFp/RiMv8YxVhIafm3p6F6EdAuxaumQ2/+6
         pjAWzG0Sloma3arbovoMQgzduAYL/0RUrHZQEBQ57m1989nqQQdhzVWIvLACfbScuV6H
         nw8g==
X-Gm-Message-State: AOJu0YyXM9ZrA2iZOzqftIGy0wYTvDp4fGsvF4DcUTXTGpL46OFK0s1e
	Q0mPJR8lO78/b2oOUFdDa5HBu8NEYVA7AMRMtEq4RSCsg8B7QINx8dDfTGlpmAP7d2bkXeeXF9/
	jXztdmRj0UB6sJLoOoRCUobVlxjUt6k0=
X-Gm-Gg: ATEYQzwcrOyIzXAx9MOV7PJ69Hevq42fMVRYVdneDhoGqAfCyfSYKznvS/L6dQucWuZ
	sneP6stRZ17rnXjdYUJPZwQU17qBudZn/bIZO1cMSvqLNtLHfIMrGaEQt/hGbvzBxy/Bre4vRl2
	y/vBva9wN34M1G7b+ovUxKT5o6fRx0Bw7V35GdFcLKU9A8rDkaVx08MJ6Pcw8Lx20kQ4oRBOmtc
	wtxJ9ro04MmXzvLOhvxpIeAEEX8BdGEhD/vM1VxJ9uKwDQS7xSJR/mxRa2zCw6oFANS8peIDfJ2
	6iBwU5dFarUDn/iLK/1kAk40D9JF88l4lq+Ey1kYamtBo3DpR3qU
X-Received: by 2002:a05:7300:d704:b0:2be:140c:bc2b with SMTP id
 5a478bee46e88-2c1096bc4c8mr1776613eec.2.1774169965006; Sun, 22 Mar 2026
 01:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322065509.5384-1-mateopatinodev@gmail.com>
In-Reply-To: <20260322065509.5384-1-mateopatinodev@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 22 Mar 2026 04:59:09 -0400
X-Gm-Features: AQROBzBH_2qWj0UpR92fE-_fFYCVIGiSOeAbvqT2OHlqIq4fuS_ziXoUErcOCmI
Message-ID: <CAPig+cRAsEgeT+OgCSpTuY_Q6dMpXrfadrB=ujkAUyF-ocu2-g@mail.gmail.com>
Subject: Re: [RFC] [GSoC]: STRBUF_INIT_CONST: initialize `strbuf` to constant string
To: Mateo Patino <mateopatinodev@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, ps@pks.im, 
	gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 2:55=E2=80=AFAM Mateo Patino <mateopatinodev@gmail.=
com> wrote:
> My name is Mateo, and I'm a new contributor to Git. I'm a 1st year
> undergrad at Columbia University studying CS and applied math.
>
> I wanted to ask the community for feedback on a project proposal
> regarding the `strbuf` API. Seven years ago, a macro to initialize a
> `strbuf` to a constant string literal was proposed in GitGitGadget [1]
> called `STRBUF_INIT_CONST`. This macro would work just like `STRBUF_INIT`
> but it would set `alloc` to 0 (i.e. the buffer would not be
> heap-allocated).
>
> Someone made a pull request to implement this feature [2], but their
> changes were not merged. Later, Robear Selwans made a patch series [3]
> attempting to implement this same feature. Robear got extensive
> feedback, but his patches were not accepted. The same GitHub user from
> [2] sent a patch here [4], but his changes were not accepted.

You probably didn't intend for it to sound this way, but this summary
makes it seem as if the Git project rejected these patch submissions
without proper justification. However, having studied the threads
which you referenced, it becomes clear that the reason these patches
were never accepted is because the submitters never followed through
by addressing reviewer comments. For instance, in my review[*1*] of
the patch [4] which you referenced, I pointed out several significant
problems with the patch, but the patch author never responded, so it
makes sense that the submission was never accepted into the project.

> More recently, the potential need for `STRBUF_INIT_CONST` was mentioned
> in this patch series [5] by Patrick Steinhardt, though it was marked
> as a #leftoverbit and not directly addressed.
>
> `STRBUF_INIT_CONST` has been mentioned for a long time in this list,
> but it has not been implemented yet. My Request For Comment is the
> following: is `STRBUF_INIT_CONST` a feature that is still of interest
> to the community? If so, I would like to make a GSoC proposal around it.
> The past email threads have already laid out the considerations of
> implementing `STRBUF_INIT_CONST` or something equivalent, so I would
> like to propose this as GSoC idea if the community would find it
> worthwhile.
>
> I would love to hear any thoughts about this.

Although feedback to Robear Selwans's submission from some reviewers
was subjective, Peff's review[*2*] pointed at a major roadblock;
specifically, that strbuf has always promoted strbuf.buf is a
writeable C-style string, so it is not safe simply to assign a pointer
to a literal string to the "buf" member, and it's not practical to
expect that all consumers of strbufs can be audited and modified to
work correctly with the "new world order" that STRBUF_INIT_CONST would
introduce.

Thus, the issue is deeper than it may seem at first glance, and unless
you have some fundamentally new ideas to address the sort of critical
issues identified by such feedback, it is likely that a patch which
takes an approach similar to what has previously been submitted will
likewise fail.

[*1*]: https://lore.kernel.org/git/CAPig+cQL=3Db-nF6nADaWueJaDmxCgmZbUwWj6=
=3DdAwYQ=3DvVrkifg@mail.gmail.com/
[*2*]: https://lore.kernel.org/git/20200218062124.GF1641086@coredump.intra.=
peff.net/

> [1] https://github.com/gitgitgadget/git/issues/398
> [2] https://github.com/gitgitgadget/git/pull/824
> [3] https://lore.kernel.org/git/20200218041805.10939-1-robear.selwans@out=
look.com/
> [4] https://lore.kernel.org/git/20210105064502.725307-1-adlternative@gmai=
l.com/
> [5] https://lore.kernel.org/git/Zrm9ix5aN_g76Qxq@tanuki/
