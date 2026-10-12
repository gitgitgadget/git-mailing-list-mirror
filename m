Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629D549B5DF
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820448; cv=pass; b=P2A4t13KGCJHjw7sST6M05fZulmyZQi8O/Xu8/2pKPVQLhuHOOn2dqPi3fPxD/aJqL8wOthSw9LkEmSI3gsoCsWu0RLL+BkWf/9fRhVqlGrCWebfjmzuDYx++C9Ic0R7kh0EvKbYymOWLiybtWJokCoi7W7SiRUsvlIOhJq7SgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820448; c=relaxed/simple;
	bh=u8cChkcnP5a/wff0J6vbeGC65Ie7S93DWS7aiHJXmKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWrV6Ivsb6cmemdTWTzVPyk/rhqQFOjyNhY7TV7lr3AN6WNlzamxzcVWg1J01ayjLgXVjqSCRz+nRpuqd9kSTNP1zb8SZAbRyqLkxhqTDkY1L556MM8cg5dd6O1hKS0LmcHeL/ptOdRUeEmAppQy9Nipnh8GDHX+KOIqNrV5IXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=peFCNHNg; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peFCNHNg"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-890d52c7c7bso1661747b3a.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 08:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791820447; cv=none;
        d=google.com; s=arc-20260327;
        b=UgnUmV9gH5/9NM57c0dFnh26FuZnPpnDEJMaKq2AXeQKLq1Z1mSOtH/JbqvBDUSEf4
         uxm3r8GEWqZLC/HtskBzcafCSBJqEYAzYoK2TNDUDOWReSZE37aOzKX+B02oklqjMDec
         j7XS4GFb3GnE8DXe+CQSr9Y1SgejWTlj3g0ztmCGbRPXoLysjvGLc1bTrjXCBULspQKK
         V38B9a2qi8IVrltXqH/YuypSWzGVCZDBlTTuGLg3eoWV93rVmNnlkWKB9nj15MfsKxhk
         6TowmE1CeR9mHxhOq8W2qQHkntb9C6uDDCdLNEdPln7yqlei8nRyAnXSm7pzto6S7wX7
         u8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zyxswZUh0LSWsVcRJWVSNH+qIINEztQLLtuh2ufKBZU=;
        fh=4pUjRJWuyybHg4wtqim92t2E/Qs5IS6GIPgaGbU3LpI=;
        b=O50lEIwiu62Px7CyMoUWSSAW29f/91cLyJvz/TAis836x5Hf8eGKtmMYhbhS0sIPC8
         b7BdAFpVQTIy1zuaBt0N1n5/vWEPs/SpXC4fOJ8yZ4abvktVTbbBfJbEcc4RI1+fWK3g
         wXvCQC6FAqXgob84lo96hDwlrzc0vMnFFaiXClgj7bRdmynCDFJb8ztgFSTPv6cEuSdd
         +5r7k/nrf3AeWwg/ixIHQ6S+IP87jeIXqV9qQt6eBKnTtfT5m5mwzdAGfqGVlHmLbNPB
         N13pkuamQb5kXqOYsWM5KD5nDV6h1aSdZ3q7xb08bTu/Q+D8B7LUbEIPKgLKt0BRmrDP
         aQvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791820447; x=1792425247; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zyxswZUh0LSWsVcRJWVSNH+qIINEztQLLtuh2ufKBZU=;
        b=peFCNHNgDghYrloVclzwePWUSb9jVvwen6g7+CapQzw9RZjYZYgwmh6IoNuxqT0X26
         qCC4wilXZ6KlvQtX+qUlIfV3xtwQzDRa6otKgt8XcpB+kUapbXZX00icNvRoWqVpcL08
         ZyqT6+yEZRbOuTjw73cy8FS2/e3F8EjGekj5kGguvSmWWLPpinnGdQmxPuJniA9F+NJ9
         +/7AtCC5874S9PbewEmstRUX8qnWOv5uyzm/LApkwrFnnboBQvzKivnWbTncd6fdQCs3
         6em2+8Bpm67XwW0DP9HJAljhbI33N4VZxgKz/hyt+WMxfbdlGjIlnlYcoIenF5qm8iyH
         wKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791820447; x=1792425247;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zyxswZUh0LSWsVcRJWVSNH+qIINEztQLLtuh2ufKBZU=;
        b=i50H6yo0UtlRUxqsACPjzEO3498s13GQCtN5gVVd6z5+w1GvTrQdKd+rIStIonVDwx
         COU0J88lURvdV3HazWPINxMcwRIhSjYAkj21wW+dcwwUvfMsfe5d9OVSAh3fUbthTwkD
         zbzy3pFOyrRj9PfU1iCzJE5CQ/DhO+bNZXHl4Ieo4UPX2xuXw6maxr43dvpFKS6vWfzF
         07xSyDn52s5zpUY3rKpasLQuehafIXI1LVwKEAuwa7Z2s4xBr4o5Np8eIA4ftjTenK7e
         IPbZkKH7MPwJDC/GUtOXAqnI/rJZtDpTrTDZfMKyK5K/n3Eub6C5lGUn+1ngjDHCPmoy
         guDA==
X-Gm-Message-State: AFq9FYJXaAxzLOMNUGitGu02VHgrWUGPL3ekWiEzQJf7gHOedygDyzNR
	CDpiuFKH5vNGxibURHbmM0NZgee/ORyUjikdqjok3R8aomeCZqmlPA4zAvqL5yiKJWNN+gCSfLR
	gBuNG4rwiVeEO3Beux9uqhmUc1OBH+Vo=
X-Gm-Gg: AYBFou2ge1K9xkVDri+Jztr7oh4yy/lwAPkDy1ZYz4sJOF77TI41OcHqegIrfL9bodL
	LPecL9gjRWjfR8Mwls0v/GtBUTlbrm3sewlik9zdQFhT7+Ejn1plsJvuIUN+Q5Axzr3TA5iT3bz
	lW93P/UKPI0Knm9B+WLhLjQaFxas9YHV4gYmPAD5qnPkyQh+7lFP4PxhUWrXZhr8hVW7K5DbZeT
	jVL7V9HIOhhEzklyJ5pFbrvNbPY+BCg++nhtc8TPN665Klk8ZJ5vmydC3au9LYMVhaBLocYMx1h
	feEmkXyUbZKOgVxaHwmjFy94jKG93uc4ODnfxIMonud5a4sdKhR7ILRXEAhdk5CHNI4Q+bu/BWv
	dH6S9SXx+niCB1yBJUW5GbeLDruni+va9PmVExZ6Tle7NY7VEvcTBEHFTEUDwPmdXd4pLvLtKje
	mjjEazmy0=
X-Received: by 2002:a05:6a00:3692:b0:889:c4e5:687e with SMTP id
 d2e1a72fcca58-897c49b2afemr8241404b3a.8.1791820446699; Mon, 12 Oct 2026
 08:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com> <pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 12 Oct 2026 11:53:55 -0400
X-Gm-Features: AclHuK88SVtMmRc27AK2XZQW36DCZcSkOkkq-m3pp08VxI172YdfwUR-4TU9lMA
Message-ID: <CALnO6CAL7ogi5MDRJmzTqNjjG-S39rDn=GTx3nwM5ASz_kRZOg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] [doc] Add new page on merge conflicts
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, Jeff King <peff@peff.net>, 
	Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 10:53=E2=80=AFAM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Range-diff vs v2:
>
>  1:  ab0344f947 ! 1:  7aa0ae7ec3 doc: add new gitmergeconflicts man page
>      @@ Commit message
>           place, since it's a really nice example of a place Git has a co=
nsistent
>           interface between similar commands.
>
>      +    Only discuss merge, rebase, cherry-pick, and revert for now eve=
n though
>      +    there are other ways that merge conflicts can happen because it=
's
>      +    awkward to talk about `am`, `apply`, and `checkout -m`.
>      +
>           Co-Authored-By: Marie Claire LeBlanc Flanagan <hello@marieflana=
gan.com>
>      -    Reviewed-by: D. Ben Knoble <ben.knoble+github@gmail.com>
>      -    Reviewed-by: Patrick Steinhardt <ps@pks.im>
>      +    Helped-by: D. Ben Knoble <ben.knoble+github@gmail.com>

Maybe this got lost in the shuffle, but I do prefer to use
<ben.knoble@gmail.com> for Git these days, thanks!

>      +    Helped-by: Patrick Steinhardt <ps@pks.im>
>      +    Signed-off-by: Julia Evans <julia@jvns.ca>
>      +    Signed-off-by: Marie Claire LeBlanc Flanagan <hello@marieflanag=
an.com>
>           Signed-off-by: Julia Evans <julia@jvns.ca>

I don't *think* we need your sign-off twice here, but maybe you
intended to communicate something by this ordering? I confess I'm not
sure what it would be ':D

--=20
D. Ben Knoble
