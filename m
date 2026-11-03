Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738607;
	b=co1oOeCOYFBywypyND5POCg8Nm/ogNc2es9RyULJPqmcG03au4hmSETCTxsEkK3X7U+U
	 qmSEBVCMyBmcaNTbUHsSXEEAUJkn/+85LfgvPAZ0eDuHdUSWWKdmWbuppPg6uK7QWrEUY
	 4BCeaEc+eOgx3hQ6XrttqM/MUok55B9Al1C4EPtAUKJZdD+UAO+1jqllCw9hY6mVNZWVX
	 5w1w1NwxXqL3v6KVqwrL8AJy0Z4D6kdXISgZ/krnm69LSUaDdl68YGxKeYb48ceZjmfK3
	 y7jwNRYGGDV/+HKGwMHVGgY1obRlALjQvfsobM8/n0sgFODhNzm8J6xTUM1scSjENwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738607;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=gYwZCtBSuZpbDzY34pRtunDq1xn0PXw18jALH6cL6Zc=;
	b=Clu5K2lzuT7AmVMPpdwhpE7BBF1eNG6tiWyxhGETWPXkeqU3zQfdFD+WyUlSDeO2jjgd
	 oTry7IrFcWPKKzHjvquyamMVeVzwo2j9jsuzGYnfFBfQEY1kAxoo2PrMpsD/JobwT6DcF
	 sFgCAClCo3x3Mf4o1PfGzx0udEgpo+s5LvnS37XdCllTAeEDlmY2BSlufl7VrItaOA3uO
	 gV9fRjwKMgP52/VCcYLadyZQttpbIYDtedGEX+P0a40i3P+BWY6Ji6v52gYaJFm8sSb3v
	 UvbppuI99PtwX68GAGuu+Bk8gnhhUMXfULgfE8wCIEQLP6NA/4+iHwR0AsCS8MC0/Ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EkG9hCH6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E0606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 20:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C4E0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EkG9hCH6
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ab27e45e7cso331111fa.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 12:43:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793738606; cv=none;
        d=google.com; s=arc-20260327;
        b=VHrvKyc6Kvxa1cnqrjJEnmUI9z9KxCr/fu3hTFbxX9q1YYesbEheOgpsPB/c3e6SLH
         0munCx5I97rijYdE2DgfQv72a1xQzJjMjn71wYP5ezuOeMbChU93cZcrQkfBcbg6KXVy
         zBQIKGniy6eanDNA1onQtbT5prXRjfQKoIxV//zHUXyzGFNGL9Ga2JJh9KqP8uwTySWp
         TKWtAvAlYIffoUaaUmJIHz3y4L5PS7vL6P3iNCeHqmoveuh5gDfIbTqW1lCEugBJSDY9
         bNjcG88p3oxetfau3QGSoEn8fs36Dw4mFIrdjvxDLKfYYul/9v7//8HaEVNPO/ni0Sch
         XrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gYwZCtBSuZpbDzY34pRtunDq1xn0PXw18jALH6cL6Zc=;
        fh=tHh6quu8HNzKaDn2OQxcxXJCS98jQRtIMGB2GGmyP1E=;
        b=rg4oCwLYmlex7y239FKV55nQl9y6m4/puvS0qz/IaV6rXmoA74ZjvhSwLtpezKwPJw
         +8O/dRxbm2RKfq774j4EG+P3yXYbWT1d4JyXtIaVv4Pc/m9drBBdfkzuHcANeZruwLZb
         bau/8IMtCcWIWKNniAwDfL4UN810SCl8aCd38ulgVAnDkAIH5okMQzmAoXuUN3WPaG51
         emNJS2/WD5e4xQx+bkiFoXb/WpHqV3WIwF+te7vIO8pAQIYoURiJW5USrLBMX7g/wUfU
         MIoWuXDAJpLcvSSOBANinG5s3NdfgFT75fbaTII69CmQLevb8SyAgIlovY3/Ypij14xI
         HTpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793738606; x=1794343406; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gYwZCtBSuZpbDzY34pRtunDq1xn0PXw18jALH6cL6Zc=;
        b=EkG9hCH6nSdhq9kf0CiWLE+0F3G/rrbArRC76Q/0m87GzCAGAWmgT2GOPrS/YhYFaC
         eavUejSKMdcCw4+7GL8VegLpBiELO0DWvkFxyDtkq0XtIWbtHqhTAjiDD1wanGtxV1H0
         RwMtbe+yDSPSLrio+EM11/w2pN2cI9nAB3aM7UdUGnj3w0Qn7l72GU0VxJ+A6eYuQt85
         aD+EA2qUlA+BjjcZ1CbJRjvQ1/R00RtFuUGzXyEnyZN0BdTTD7Hp4hONo5+5Rn7pDVgn
         eMqHOjOgSlQshqrSo0LcjIk9w0g1Tk8Mib0S/0N372ZrRCJug2bY0bB1r1OKu3IbQmb5
         axZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793738606; x=1794343406;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gYwZCtBSuZpbDzY34pRtunDq1xn0PXw18jALH6cL6Zc=;
        b=LmffjLww+c3FcjLMqnLt8LR1EmpYb6DYrbMD9knM26+j7Z3/WtPaaDKSh9wgMQzQYg
         hIT9t/ocWHcLh5g0Kcygi+e2XCgbHIEuVvaF3koK3hh1vNAHLGGWdvzO4Dlt28Zazt5i
         K0PQoLjrwqyotGPHDRsdIqbCL2K9/CFGYkYl4x1SFqoC2vXTk3hyagXJNT1k0RUOYot2
         AhfB32HGd3Rk25msBFgsnKea4DIvEZmS4XbB68CaMZqnBhcGKf1qM1cd7eVfAukuB18J
         4v4fmte5QwRTAKImZQsHEmXGPszxsgJWYYgrNYGesw000uCGU68Mrn/TpPTU/OOD6fgX
         hWKQ==
X-Gm-Message-State: APuU4Z/XpZ8w6WXzD6K19tnd1WBz7jDzKiMMhj0pkT4kd4SHYJ+qAc3q
	RKvPGYV1OoKlz/U4AppMdJb8f+dfy4d92f2co3OsjGMLHLDv6rnBMn/hT/16/NPKzysdg5AeMbc
	cT7iUSMwZP4PPrAYSaN8pDF+ivDkADt4lIg==
X-Gm-Gg: AYBFou03x5hFHe9h8ZRi9id66lupcsBVWxfpcbMsF61V252/dV99z8cuDZLcESkoCxR
	+XZgl6qVFXN2SAIoYGFWgk+V68uJu1KJr7jP+r8sPS+5surqjPHuAzZY3PbZbEB+EnZV95dSCwq
	jVhf6zHEUohgBXe54+21WB4qK8An+sWoTSYuiJMKhgFe9EKQCH08WL0RlP3KndUzh52n8FWDUKo
	w1g9zEmhp0L5HPmVDOc8CKe3C4ifQvy74T4IiYQhIMUQeHHEUDTDSliNAK6q9KdcvZf37D70LBR
	ejp3wAsb/aULtDc+hAZGNk+uO/en4O8vmg5G7bzgJTPM7MUVfU971ZSmgCOjX3bFBiZB0FiakjU
	uPx/UhvXJuXWFu+KpWk0zP0VVtKc5wv0J3XuVsXo=
X-Received: by 2002:a05:651c:41c7:b0:3a9:d756:bfdd with SMTP id
 38308e7fff4ca-3acb7a9ea86mr33325051fa.7.1793738605383; Tue, 03 Nov 2026
 12:43:25 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CY8PR17MB6236D16AD8CD80720FF1342DAE692@CY8PR17MB6236.namprd17.prod.outlook.com>
In-Reply-To: <CY8PR17MB6236D16AD8CD80720FF1342DAE692@CY8PR17MB6236.namprd17.prod.outlook.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Tue, 3 Nov 2026 12:43:13 -0800
X-Gm-Features: AclHuK-wJfRCsofssIColAsvk4blajDLakTdXjdWu4zyQSKU8SyR2hgDAQVVIcA
Message-ID: <CAPx1Gvd3H2-e5RBoH9e1r0cWqe2uo1tm-eUSop0ffNBc2Pj6tg@mail.gmail.com>
Subject: Re: Interaction between pre-commit hook and git commit <pathspec>
To: Kevin Lyles <klyles@epic.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 12:00=E2=80=AFPM Kevin Lyles <klyles@epic.com> wrote=
:
> The documentation for the pathspec option of the commit command claims:
> "The contents of these files are also staged for the next commit on top
> of what have been staged before."
> However, that appears to only be true if the pre-commit hook doesn't
> modify the index contents.

There's an implementation detail here that makes this tricky.

Git documentation talks about "the" index / staging-area.  Or, more
precisely, there is one such entity per work-tree: the work-tree's index.

But when you use "git commit --only" or "git commit --include", well,
now there is a big problem to deal with. If the commit is accepted,
the ("the") index / staging-area should be updated accordingly. But
if it's aborted, the index should roll back to how it was before you
ran "git commit [--only | --include] <pathspecs>".

In order to make this work internally, Git actually needs two or
even three index-es (indices?) / staging-areas for the work-tree
in question: the one for "before the commit", possibly a separate
one for "making the commit" (when using --only), and one for
"after the commit succeeds, assuming it does succeed".

To get a little bit more concrete (which makes describing the
underlying process a lot easier), let's note now that "the index"
is really a simple file.  The main one is ".git/index".  (I'm ignoring
extra complications like a split index here as they don't affect the
result, so this is purely an internal implementation detail, but if
you ever dive into the Git code, it's something else to trip over....)

Git handles the "old version, temporary intermediate version
if needed, new version" problem by creating two or three files
total. One of these is named ".git/index.lock", which serves as
both a locking file to prevent two "git commit" operations from
running at the same time and stepping on each other, and
also "the future version of .git/index, should the commit succeed".

(The third file, which doesn't apply to your specific case,
has a funky temporary name with a unique set of characters
sprinkled in.)

If your pre-commit hook attempts modification(s) of the proposed
snapshot for the new commit, it may need to update more than
one of these files to make all three conditions hold, and in general
it just can't. (It's too hard to know what the correct names are,
since they're different in a work-tree and the "--only" name is
randomized.)  So pre-commit hooks are restricted to "ok" or
"not ok" actions.

> It's possible that there is a better way to achieve my goal than a
> pre-commit hook.

Instead of running "git commit" directly, why not run a script
that does the appropriate "git add"s, then runs "git commit"
for you?  The pre-commit hook can then inspect to be sure
that this has occurred, and if not, remind users to run the
script instead.

Chris
