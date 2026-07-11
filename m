Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B9C25B0A4
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 04:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783745467; cv=none; b=qwuknqbMFaND/eTacT1eXRdoeTy8EjKxXuKJmkXMAL5Na1UnVm/Jxb2sPvvZfDGP81Sm0meJ+zic2IxEIg39eV9dPoYR9EdNuZrpAfu/cD0HYTIzK0MEhrOPnhFvd3ZzhvWMBzI4Gw7nSuzNnuM5lWNMwZPErIqN5WfYDSxjJco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783745467; c=relaxed/simple;
	bh=6WcvuGo+1QOdDiBocyxjXrDb2zoJ3E2ZOEhb1gb6f2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kRUjymd7uFh+ImOOfPbhrZNcvnzlXCNZV8rOK1wlliN8GmgbXk9Ej+5TCkuXwTR5ZMVjDU/yqBD2Oo+VKc1DFaoDJwH1D3OH7IvdkeA62MH9HRFORKx9DvLoRFC5oZRJLYcMznrBSN8wS0kghUNkfumY4COnUCjAL8cbsrBvhG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KU5tPHBf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bIM8YwHz; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KU5tPHBf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bIM8YwHz"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id EB6951D0008A;
	Sat, 11 Jul 2026 00:51:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 11 Jul 2026 00:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783745464; x=1783831864; bh=aS83mUiyg2
	/TPdvcZUsVeVhBcBtdNwyXuXSCYJDTo/I=; b=KU5tPHBfdxYANdZuStQLb3z/tr
	sVHp5L0xVjKVaOxz4QaDPqUqFu5jDdQgeYSUyeyptBAzs7U5rSxbv6QxmtlsNN8I
	QLb3oCfX7M7MHa0X3fVcuvMRuFzpx1yxLvzmuB9P6CIZDBezb8HLm7+7BHGNcDRt
	qv542O/3HqzhVEfasfQFbaeOg8WIkzUV+4YDZiD6fyBYNyJpx+nv+6hfLy8/gcJj
	HTkt7KTNYcrO0cwcVGc2fXL7T1o9bRiNF3dQ7uOpO6oiofRb7eOGBPuPHw5LEK93
	bZZvbvQGB3xGZO02cONaxR/wG5T8PUxmNdd5q5beGR8e9iz6VcfN48ohr1HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783745464; x=1783831864; bh=aS83mUiyg2/TPdvcZUsVeVhBcBtdNwyXuXS
	CYJDTo/I=; b=bIM8YwHzi4SneQ+ggm2akKCA5/BJEable2aFO1lBwlro6cLoXtp
	P8PF7iiIQFY12cLugD26ibGT/7H06v5lvgZk9QhKa97wZG+hoRTFf/KouKvmJVGk
	VSCX2+6oZUjGhJ3wU0wikEapIUWCNME0orEV7Del470ycBuoQMTLHS1txZF3/2HH
	+38dZvk9wb9cNjxF29uvymZuEj5LDBMq3reSvqtvnQ4u4C5vIUClllbk5zIYmTkH
	WWqL6Bb1WQ+qo2f+eNSsPO39oKHTqj05yCgFpl/GROoFsz8ALbjwixspeUxh6uJm
	dwC7cyhpv66xmHHGQTWNv+xOzlPZjMnFPyw==
X-ME-Sender: <xms:uMtRakReFey13yLtsuyFDn8OsbzxN7-A9E-hKX07x9aWNWUrzI_AZQ>
    <xme:uMtRapMyTEhlTkCmIXUf65oRMFiMyHXTEnj93x-2Ha6FeZvb1Upd3hO9tAuM6-dzO
    nM4ofNVFOnWsiNtu2X4dK7SBJkdqWjPpy6i3AVBw76wPK3x9d-BHg>
X-ME-Received: <xmr:uMtRavOi44vqNaD7pFPgemmAez0PuiVASZwMbDtZtZUtgS_CoJvv91KJXjTaRsKHjCqBFRLdh869SG4LvBTAMTN-Fej9BOR52UfVxjY>
X-ME-Proxy-Cause: dmFkZTFcPIX1NUFl8bQ/CvPueQEyC2z1o9T054rQWiIrAtUa8PV0e99Vg5jNqJ/AkjCGIA
    ofYZCOSLlmr57dEPCTpGGiMddPGxSm87Vxnbxs+6no49TPL9JmDCtO3YYmoUzDDvc4+/wk
    /+nvBCUqfaYSUrJqAH65Mc/MCgtIbAZ7wWu6kMlYC9AYKp6QljB075SUPBiXB3D0hhrnLN
    Ffdq9IPJ2EWtRGv9HFO00knqSTBShg/DoxJKZF7TGjczMJHhvlZ/LXS5u/Npu/YBhIK4Qt
    PV6zqmrVycbg+uS4F3rWY6kAz5IU4r0JTs2FHiLPsa/Wltnsvq/bj1eYae+g3Zdw+1+HKy
    TOqJruknjpRybHBCG5Lh2noFribiObE/JRiAsWeOrv5tQVf3Wg41JcsLgON9//vuNKTz1e
    ZAEv22r8eMQ1WcOXTKuwtdAcUxVFwD2lykVWFeON8/VBLt4eaI8NatIkrxwbZSOke1Or8A
    ntqJ+O71ufQAIgfWmb8F3eih1Z0XEHRhnqigcIkzrkMuVk+so1fhkRVdptSwGUQ+U0OaYU
    xaumjD97AKEfFa3dQPQ+cgZ+2Hbg/xy/kN8GNvpnhaAgHovMGa2qb4dh9X138brBcf6ivi
    a0zdMR+Tl4Q1ayfgLjuxihdcaRWIuxLVXupEpANCZQTuOolJyvpYrqWnFfKg
X-ME-Proxy: <xmx:uMtRahs3Ie_BGElfO9B1e7IVarIPUiqxwwDwWh7tu7djK8QKPrRS9Q>
    <xmx:uMtRahU07En44QU_vu6-aGka3itAKn6tKJYYDXIJruJ6Pa8Di4PBAw>
    <xmx:uMtRahuMSvRKVrAkaeJ3FoXm0osqR1MFtKQjm13ErvNk6_hLt_RZbA>
    <xmx:uMtRalXzVP7jhJXL1DRZq3Gk-BCBcBBWRsStqJzAiKLNRsniJrWk4A>
    <xmx:uMtRapOySMwTM3olXaq1_DNra3YXdZHfjwEjYJmcxSjah4-7qgNThzEZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Jul 2026 00:51:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] builtin/add.c: replace run_command() with direct
 apply_all_patches() call
In-Reply-To: <20260710195949.54928-1-gatlavishweshwarreddy26@gmail.com> (Gatla
	Vishweshwar Reddy's message of "Sat, 11 Jul 2026 01:28:20 +0530")
References: <xmqqechad6g9.fsf@gitster.g>
	<20260710195949.54928-1-gatlavishweshwarreddy26@gmail.com>
Date: Fri, 10 Jul 2026 21:51:02 -0700
Message-ID: <xmqqechab03t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com> writes:

> In response to review:
> - repo_git_path() returns an absolute path built from gitdir.
>   prefix_filename() in apply_all_patches() explicitly skips absolute
>   paths (see abspath.c lines 271-272 where is_absolute_path(arg)
>   causes the prefix to be skipped). Running "git add -e" from a
>   subdirectory is therefore safe.

I agree that we are safe when it is absolute (no room for prefix to
take part); my question was more about repo_git_path() that derives
its value from repo->gitdir which may or may not be absolute.

Does it always give you absolute, or sometimes it is relative and
sometimes it is absolute?

> - A dedicated test for "git add -e" from a subdirectory would be
>   valuable. I looked but found no existing "add -e" tests in the test
>   suite to use as a reference.

"git grep -e 'add -e' t/" finds t3702.

