Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429322749DF
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767522147; cv=none; b=iow9gQqjvOaPvb/d6QQl8xZpjbEvu4qWuPwnGuGxFLJuvl2qfLuj+exrCrvrs1n7abUfNvESzIYgIwOpzu4Fr588/X0fRg6O2TADe3inuUm562fiVGhZHr3UX6J4asi7k6DfFcEvnCeN/b2LZop9Pr+Xv8I4DkgsdJY4saBV4AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767522147; c=relaxed/simple;
	bh=UJ8/BdJCDkIiJ9EY4ol+MyuXBjvigUKVcRq/vvLP92E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oh8xQt58hJtdoUT/QIVA9rxrOriRHO9cOk/rOyFnl4lYPO34T/Ra8zyijmxCLRoMGxACS1t0GA0De69FX45AbyrZ7I29kBDHlyYuXfZNCVdCcQ6oaDqOUbn9hVW8i6TKwfbBzR2/F9fapuSEVdb2/qZq1eXaGRKSW/7Zi0NwMJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=hdJB4mn/; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="hdJB4mn/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1767522137; x=1767781337;
	bh=7C9DOHKBf9E+JdphVOi61IbtRI78LQDSTgkqEz0bewM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hdJB4mn/b8hWxCrDdqqUz8GSfR1+q+RD64fj5StedORZF15nqedJRZwBkTYMOiGAw
	 +6RVTC2B2sDlozXBTA483YocX8m1Ue4DXNdNzlJevW5RI2YK8juTBPJhq81Y7pV/20
	 hzWvdtAoGWe1dgiTdraXERHYzKnc5YgWDgDTlxkBM+5jYSNPqk8dyo4GQHILe5KLtM
	 UzUvA9ZpvDfwFZyBtNGe7FJGKBwOXkKhqJ3zAnDf49xhHt9Qgl21gux9RdRIg9R+mz
	 0pat0gKQTf4+xZCabMlzx9TuSzU8/0bWh/+oDZiYmYsF6G5koSJQ2WA5sDf25GvaVd
	 ZiISDZImMv++A==
Date: Sun, 04 Jan 2026 10:22:14 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, "ps@pks.im" <ps@pks.im>
Subject: Re: [PATCH] reftable/iter: fix undefined behavior in indexed_table_ref_iter_next
Message-ID: <W6v12kkhI_qyFV03jZJriHkrs5pYt8tHCD4ve0bWxikUYAGasvwwWDV3Df67dM2ttRh49EECD_Ph84NbtpxE1Opv-Z03UcE7vtbMjsYhfWs=@protonmail.com>
In-Reply-To: <xmqqy0menlc3.fsf@gitster.g>
References: <Q0zfHYp-_TO2h_5PXPG9KjHwpMKIf2o2u2dsaoAjIsScmA3W6t7IvqIEeLfM7auEFIQyazlNnA3MGAuS4AANF0yfEBJAjkU1bWp-NH9m89U=@protonmail.com> <xmqqy0menlc3.fsf@gitster.g>
Feedback-ID: 35521663:user:proton
X-Pm-Message-ID: 47caa95ada0de2bf05ca304fb17bf7d57c6cac06
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

So I did messed up
sorry lesson learned
but still...
wow very exciting=20


Sent from Proton Mail for iOS.

-------- Original Message --------
On Sunday, 01/04/26 at 04:49 Junio C Hamano <gitster@pobox.com> wrote:
Tsahi Elkayam <Tsahi.Elkayam@protonmail.com> writes:

>   The indexed_table_ref_iter_next() function accesses ref->value.val2
>   without first checking the ref's value_type. This is undefined behavior
>   when the ref is not of type REFTABLE_REF_VAL2.
>
>   The correct pattern is already used in filtering_ref_iterator_next()
>   which checks value_type before accessing the appropriate union member.
>   Apply the same pattern here:
>
>    - Check for REFTABLE_REF_VAL2 before accessing val2 members
>    - Add missing check for REFTABLE_REF_VAL1 to handle single-value refs
>
>   This was marked with a "/* BUG */" comment indicating the issue was
>   known but not yet fixed.
>
>   Signed-off-by: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
>   ---
>    reftable/iter.c | 13 ++++++++-----
>    1 file changed, 8 insertions(+), 5 deletions(-)
>
>   diff --git a/reftable/iter.c b/reftable/iter.c
>   index 2ecc52b336..2eee65bb1e 100644
>   --- a/reftable/iter.c
>   +++ b/reftable/iter.c

What are these lines with two-whitespace indent about?  When sending
a patch purely for discussion (because the actual change may be iffy
or dangerous), we sometimes deliberately corrupt the patch not to
apply mechanically, but this patch does not seem to be such a
"request for discussion" patch.


