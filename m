Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E96A53
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605302; cv=none; b=seqquK44xy2UGb49q03CXWioAWJteo0JMMxh0smlyiqtXbRNNpSZsE2Wy8xC0t8myuaITckfKNGOqAqd6v26jClz/Z+AgjMpj3/eKVW+lOpf+t8I2xvQdbrx9ncRJ/MEjqNGm4My7qM3PXuZPqRfupdYRZmpPumgZAXX6D7Syu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605302; c=relaxed/simple;
	bh=GSYAflL56vic4lSetyFggRmIPTyDMUdGrTbHKkntb0g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HOimE6mndGibn1bu+N7eJa4OZtWV1+L9YPFKx+b92ItMp10EvDQcFH0fdvvoxRrX3DvtYTgJECwUlbBkRZko4isljJsxdfAckUH60a2ph4V15nWoTiA0P5k0iYGeZKfMMauW40ert66kQyN2vuPAoMrYqMXVx1CslAnve8tqrZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=x9/NF+9E; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="x9/NF+9E"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5340B1CBF57;
	Thu, 18 Jan 2024 14:14:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GSYAflL56vic4lSetyFggRmIPTyDMUdGrTbHKk
	ntb0g=; b=x9/NF+9ErpU6nJpm393xt+OZ+vBcnu8jmR6sLU9ZBVt17ud7NQA1Ol
	O4CgnYn1sOhlL/0L2yKnge1ElMXCQ/jqNPpjIUbClB7t5Gdl8s4Fo/EloTRniyZh
	Ckou+UUscrSH0w9zeFTs9cXNe2jsOvES0eth9Lki4c+ENVQsLhvMU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4AF2F1CBF56;
	Thu, 18 Jan 2024 14:14:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AA3EF1CBF55;
	Thu, 18 Jan 2024 14:14:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sebastian Thiel <sebastian.thiel@icloud.com>
Cc: Elijah Newren <newren@gmail.com>,  Elijah Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Josh Triplett
 <josh@joshtriplett.org>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] precious-files.txt: new document proposing new precious
 file type
In-Reply-To: <298F7067-D572-433F-A7DD-5256B43B97D7@icloud.com> (Sebastian
	Thiel's message of "Thu, 18 Jan 2024 08:51:16 +0100")
References: <pull.1627.git.1703643931314.gitgitgadget@gmail.com>
	<xmqq8r5gfc3j.fsf@gitster.g>
	<CABPp-BGSTYDUR1oYYXkCSh-1i2zwxBM=-gnoe-ezNbtPi5CV2A@mail.gmail.com>
	<xmqqsf3nl2b3.fsf@gitster.g>
	<298F7067-D572-433F-A7DD-5256B43B97D7@icloud.com>
Date: Thu, 18 Jan 2024 11:14:56 -0800
Message-ID: <xmqqwms6qwr3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DE7A3054-B635-11EE-9C62-25B3960A682E-77302942!pb-smtp2.pobox.com

Sebastian Thiel <sebastian.thiel@icloud.com> writes:

> #(keep)
> .config
>
> As a side-effect of the syntax, it's obvious this is an 'upgrade', with
> perfect backwards compatibility as old git does the same as always.

Yes but ...

The point Elijah makes is worth considering.  To existing versions
of git, having this entry for ".config" means that it is ignored
(i.e. "git add ." will not include it), but expendable (i.e. "git
clean" considers ".config" as a candidate for removal; "git checkout
other", if the "other" branch has it as a tracked path, will clobber
it).  Compared to the case where ".config" is not mentioned in
".gitignore", where it may be added by use of "git add .", it won't
be clobbered by "git clean".

So this syntax having "perfect backward compatibility" is not quite
true.  It does have downsides when used by existing versions of Git.

If we use Elijah's syntax to say

	$.config

then the entry to existing versions of git is a no-op wrt a file
named ".config".  It simply does not match the pattern, so an
accidental "git add ." *will* add ".config" to the index, while "git
clean" may not touch it, simply because it is treated as "untracked
and precious".  In other words, its downside is the same as not
marking the path ".config" in any way in ".gitignore", as far as
existing versions of Git are concerned.

We of course discount the possibility that people keep a file whose
name literally is dollar-dot followed by "config" and older versions
of Git would start treating them as ignored-and-expendable.  While
it *is* an additional downside compared to Phillip's "#(keep)"
approach, I do not think that particular downside is worth worrying
about.  Yet another downside compared to Phillip's is that it is
less extensible.  Over the years, however, the ignored-but-precious
is the only one we heard from users that lack of which is hurting
them, so lack of extensibility may not be too huge a deal.

For projects that are currently listing these files in ".gitignore"
as "ignored-and-expendable" already and want to categorize them as
"ignored-and-precious" by changing ".config" to "$.config" (or
adding "#(keep)" comment before the existing entry), the
pros-and-cons equation may differ.  Their current participants are
protected from accidentally adding them with "git add ." but risking
to lose them with "git clean -f".  They may even be trained to be
careful to see "git clean -n" output before actually running the
command with "-f".  Now, if their project ships a new version of
".gitignore" that marks these paths as "ignored-and-precious", both
approaches will have intended effect to participants who upgraded to
the version of Git.

To participants using the current version of Git:

 * Phillip's approach to add "#(keep)" will not change anything.
   They will be protected from accidental "git add ." as before, and
   they will still have to be careful about "git clean -f".

 * Elijah's approach to rewrite existing'.config' to '$.config',
   however, will stop protecting them from "git add .", even though
   it will start protecting them from "git clean -f".

The devil you already know may be the lessor of two evils in such a
situation.

So, all it boils down to is these two questions.

 * Which one between "'git add .' adds '.config' that users did not
   want to add" and "'git clean -f' removes '.config' together with
   other files" a larger problem to the users, who participate in a
   project that already decided to use the new .gitignore feature to
   mark ".config" as "precious", of older versions of Git that
   predate "precious"?

 * What are projects doing to paths that they want to make
   "precious" with the current system?  Do they leave them out of
   ".gitignore" and have them subject to accidental "git add ." to
   protect them from "git clean -f"?  Or do they list them in
   ".gitignore" to prevent "git add ." from touching, but leave them
   susceptible to accidental removal by "git clean -f"?

Thanks.
