Received: from st43p00im-ztbu10073601.me.com (st43p00im-ztbu10073601.me.com [17.58.63.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D692E652
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705613607; cv=none; b=PVf+KuC/H+nzkJHNuWWNvpxLU+GnUiX1mVpCmlmB2glBtxsFNkmNyLYMotgl53Rf1gsyp1b/yvSCwJTCk1JoBoDnoCx0G1cAjKtneoq6mrhEPuY/nNlmI39cmZbP+D+lSw64h5am30GYwjCORLCTTBeF2FEo8hvaS6dNPiszLPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705613607; c=relaxed/simple;
	bh=x5Ky+YoBYGK4tdKr31BWrMYbcj3RjTp2f3dSPbj1A0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxcEizIh4gC8ZXNUdtEY3h1IcrXKWrKkycsaXryxYLiuLSThZLUMUrAyw80EIfaIFfAEpwKCM6ehQCboJk2+X2IHngJzbj7uWUcwPWSsHIu2yua7jHZ+vCpeqI+oIx9WI3846qfM3WtlFSkIBTusXF6ZAOkbrNUrdt2DzAyY8gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=yvtDtKzf; arc=none smtp.client-ip=17.58.63.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="yvtDtKzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1705613605;
	bh=D7zI20ivqRHBqICNqQx41lV9FQb2fJuD5HtLiK+hmLY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=yvtDtKzf1BDqjyAYT5XAsnwhvV7j46E3+Ylvzl+L68c7SHZmAEqxA5MFXk4kcCOZA
	 8kSQOASXVNAYsoWbbTs71ADVeIjZiIEznX9p9k8vc1a/3rDgGHryRG9pIv1khoJEcx
	 h0hzCMK8aVobkAIwkpABdwTv4ebximAniMF/yQLhAfA3oDv0lq3qqvnCH6fIIE2Clj
	 W700qcN/XwGYRpfmsO6/OOfSHObIrl8P9qFzBRDEAfABSPmSR0HnvWz4JRlvKQeR6D
	 MfqC0DPqpe6nIuVGBTmuD/ebT19zSczIAHdiKv2E0I6cJdU5T7y+EN9rkt90aNwxCS
	 Rh+R+wUgfrA9g==
Received: from [169.254.237.242] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztbu10073601.me.com (Postfix) with ESMTPSA id 299C5180224;
	Thu, 18 Jan 2024 21:33:24 +0000 (UTC)
From: Sebastian Thiel <sebastian.thiel@icloud.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>,
 Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Josh Triplett <josh@joshtriplett.org>,
 Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] precious-files.txt: new document proposing new precious
 file type
Date: Thu, 18 Jan 2024 22:33:21 +0100
X-Mailer: MailMate (1.14r5937)
Message-ID: <F214D88E-6837-4EAB-896E-DF8CFC315EE7@icloud.com>
In-Reply-To: <xmqqwms6qwr3.fsf@gitster.g>
References: <pull.1627.git.1703643931314.gitgitgadget@gmail.com>
 <xmqq8r5gfc3j.fsf@gitster.g>
 <CABPp-BGSTYDUR1oYYXkCSh-1i2zwxBM=-gnoe-ezNbtPi5CV2A@mail.gmail.com>
 <xmqqsf3nl2b3.fsf@gitster.g>
 <298F7067-D572-433F-A7DD-5256B43B97D7@icloud.com>
 <xmqqwms6qwr3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: Y8eVoNrPC-hi1k4EDYHZvPWcuR1yN15t
X-Proofpoint-ORIG-GUID: Y8eVoNrPC-hi1k4EDYHZvPWcuR1yN15t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_10,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2401180150

Thanks so much for the analysis, as seeing the problem of choosing
a syntax from the perspective of its effects when using common commands
like "git add" and "git clean -f" seems very promising!

When thinking about "git add ." vs "git clean -f" one difference comes to
mind: "git clean -f" is much less desirable it's fatal. "git add ." on the
other hand leaves room for correction, even when used with `git commit -a"
(and with the exception of "git commit -am 'too late'").

From that point of view I'd naturally prefer the "$.config" syntax as it
will turn precious files into untracked ones for current Git.

>  * Which one between "'git add .' adds '.config' that users did not
>    want to add" and "'git clean -f' removes '.config' together with
>    other files" a larger problem to the users, who participate in a
>    project that already decided to use the new .gitignore feature to
>    mark ".config" as "precious", of older versions of Git that
>    predate "precious"?
>

If the user should have a choice, than both syntaxes could also be allowed
to let them choose what to optimise for.

Doing so might be less relevant in the `.config` case, but most relevant
for ignored files like ".env" or ".env.secret" which under no circumstances
must be tracked.

>  * What are projects doing to paths that they want to make
>    "precious" with the current system?  Do they leave them out of
>    ".gitignore" and have them subject to accidental "git add ." to
>    protect them from "git clean -f"?  Or do they list them in
>    ".gitignore" to prevent "git add ." from touching, but leave them
>    susceptible to accidental removal by "git clean -f"?

I did hear that some projects use make files with specifically configured
"git clean" invocations to specifically "--exclude" precious files.
Thus far I didn't encounter one that use such a technique to prevent
"git add" from tracking too much though.

To my mind, in order to support projects with both ".config" and
".env.secret" they would have to be given a choice of which syntax
to use, e.g.

    # This file shouldn't accidentally be deleted by `git clean`
    $.config

    # These files should never be accidentally tracked
    #(keep)
    .env*


On 18 Jan 2024, at 20:14, Junio C Hamano wrote:

> Sebastian Thiel <sebastian.thiel@icloud.com> writes:
>
>> #(keep)
>> .config
>>
>> As a side-effect of the syntax, it's obvious this is an 'upgrade', with
>> perfect backwards compatibility as old git does the same as always.
>
> Yes but ...
>
> The point Elijah makes is worth considering.  To existing versions
> of git, having this entry for ".config" means that it is ignored
> (i.e. "git add ." will not include it), but expendable (i.e. "git
> clean" considers ".config" as a candidate for removal; "git checkout
> other", if the "other" branch has it as a tracked path, will clobber
> it).  Compared to the case where ".config" is not mentioned in
> ".gitignore", where it may be added by use of "git add .", it won't
> be clobbered by "git clean".
>
> So this syntax having "perfect backward compatibility" is not quite
> true.  It does have downsides when used by existing versions of Git.
>
> If we use Elijah's syntax to say
>
>     $.config
>
> then the entry to existing versions of git is a no-op wrt a file
> named ".config".  It simply does not match the pattern, so an
> accidental "git add ." *will* add ".config" to the index, while "git
> clean" may not touch it, simply because it is treated as "untracked
> and precious".  In other words, its downside is the same as not
> marking the path ".config" in any way in ".gitignore", as far as
> existing versions of Git are concerned.
>
> We of course discount the possibility that people keep a file whose
> name literally is dollar-dot followed by "config" and older versions
> of Git would start treating them as ignored-and-expendable.  While
> it *is* an additional downside compared to Phillip's "#(keep)"
> approach, I do not think that particular downside is worth worrying
> about.  Yet another downside compared to Phillip's is that it is
> less extensible.  Over the years, however, the ignored-but-precious
> is the only one we heard from users that lack of which is hurting
> them, so lack of extensibility may not be too huge a deal.
>
> For projects that are currently listing these files in ".gitignore"
> as "ignored-and-expendable" already and want to categorize them as
> "ignored-and-precious" by changing ".config" to "$.config" (or
> adding "#(keep)" comment before the existing entry), the
> pros-and-cons equation may differ.  Their current participants are
> protected from accidentally adding them with "git add ." but risking
> to lose them with "git clean -f".  They may even be trained to be
> careful to see "git clean -n" output before actually running the
> command with "-f".  Now, if their project ships a new version of
> ".gitignore" that marks these paths as "ignored-and-precious", both
> approaches will have intended effect to participants who upgraded to
> the version of Git.
>
> To participants using the current version of Git:
>
>  * Phillip's approach to add "#(keep)" will not change anything.
>    They will be protected from accidental "git add ." as before, and
>    they will still have to be careful about "git clean -f".
>
>  * Elijah's approach to rewrite existing'.config' to '$.config',
>    however, will stop protecting them from "git add .", even though
>    it will start protecting them from "git clean -f".
>
> The devil you already know may be the lessor of two evils in such a
> situation.
>
> So, all it boils down to is these two questions.
>
>  * Which one between "'git add .' adds '.config' that users did not
>    want to add" and "'git clean -f' removes '.config' together with
>    other files" a larger problem to the users, who participate in a
>    project that already decided to use the new .gitignore feature to
>    mark ".config" as "precious", of older versions of Git that
>    predate "precious"?
>
>  * What are projects doing to paths that they want to make
>    "precious" with the current system?  Do they leave them out of
>    ".gitignore" and have them subject to accidental "git add ." to
>    protect them from "git clean -f"?  Or do they list them in
>    ".gitignore" to prevent "git add ." from touching, but leave them
>    susceptible to accidental removal by "git clean -f"?
>
> Thanks.
