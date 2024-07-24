Received: from sonic322-27.consmr.mail.bf2.yahoo.com (sonic322-27.consmr.mail.bf2.yahoo.com [74.6.132.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051F44C84
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 01:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.132.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721783294; cv=none; b=dhlMAHrAHps5/FPZAvaTx8F7Mq+Ar/2hEjvQzbE8MTOV3HUpR1nsJUJX4uZsZa95l+xh+/SNj7EjBk1UyXzS8mfdnQxnt1XDnAniOXZKeiJCGoSwFUapxxknHOUswbIb1m0enWq+Un+CZyuBDDxKxoRro9cRCB92PSXrnYxpVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721783294; c=relaxed/simple;
	bh=MAoDJ2B3WJ08WBOtE6S1NjdOuuA7RjvWcHYpWzzymK8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=YSOfMCpsUDPuNeWWvXRTEfLm5X/WpIwjXfpoD+s/e797brVyd11M/l8UtScYQD9J5PkRxfSmKGM4HdHSMQlRBQ6oP09FkjbOMZG0WwTtmY7dvSamdXzk0qf1We7tswUSet+ZMskWii9aBrLtDJNgzuJ7yWJCwsserSPNeIJ/ito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=CLJePnFA; arc=none smtp.client-ip=74.6.132.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CLJePnFA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721783291; bh=MAoDJ2B3WJ08WBOtE6S1NjdOuuA7RjvWcHYpWzzymK8=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=CLJePnFA+h5acdCrRcGEp7e8r6DH6hz1iQ7sFKKOQOX+mb/udy5V4nZTbSf18ZKcSpmVOn96P7B+8OUI1sar3nLoJsCeGCrhcVyX4i+Wt66VDAps5bUnHmgm6V18qHBvnuAIJrKNEP24hazN5MNtcJAf7RDGT/79tn7V78g3Q2m4pJ9niUBIpvr9jIMfp9D47+jqXmDKCmuPhU3JXQhpWr5C4ymuVTnQ20sFtVMYsOklZMsJmY1kXIxjL+VFCFCdmdsDiZPO+tSDfk8t917h10RHGpWQ1DejZzADKrsOEalDimlpdsxqqNNXd4UTJ3Zr2LKxn4mq9KF38HbBq3J8Ag==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721783291; bh=zlsPKDyas3As4PjRc4e6TvqeT60oCZ7H/OaJTGumfc8=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=F/AxZWbDMq9iDuSoeShLFxjVAW0DH7KQyrJcBKNEs7KcHj3a6l9YRZ2cB0KoCRlQX/JIjsAZtExaUhFQ7ZjfMwWZOwC6rcoGYE+vMgKUFSKAMvgLJnLCc+KbGuUVhvMtJnSp9vWuyo5o6dryLo+W8OpQV/Y+b/xjxwxIx58rVeEqDIJnunHJsKsQSpitU0gea6OMqGqbeAcAkPtZwzyar3VHFsKrH344OeMW4IAw9IwIFLTkYDHJKh54bGw0IHbeCe/8MnNRJYiqjVDSl/M4NR7cEBP/R+ReZlRljRvJMZmz1hiFV8IwIKp/pAfaD4K1RpuTTteuhOIApw9WMj5l5w==
X-YMail-OSG: bNGkr5sVM1n7iUlO.ZkPacEusJRCiSm1QPZ5HyY4tkeYRN60DKlH68KUOTD48DW
 uchZFsLOOSnATJWRY5NDG9_s6YkR7uYK2.P9ehnSpv7nQrK4FYDVvM60wlgKwOMZBJQbfVzZk5IE
 vLONMbXqsqrPnPRK.O5.fz58jJ7znbb3MRN7DpvQoUdnxcwDCxYxkSpyZThh3TpYALTp22CbaGcQ
 Zffa6dUSb3sPR6nwCEtv0LjV5wB3erYjgg0fl1KegW2wsHq.Oneyx80w5zlAPm55WzxL20r2ydie
 0Zd1Cxqijo89LIZ5Z4modsY_959gGdFECF1gj.bAUlXaIzulfTDxskch6zELkwXYx8FFw0UxTYH7
 ftzPrzweYKMHZKkuy5JLd4O2GmE_RQSuDF8fLmFIgCSIe.IUrchBBIQR8aw35SYW0wIB7lvegOKh
 RLlXspXEssM6lwOeUmE1Lr5zRrebdisbRajlD9nlhWKIG.ZL2tiKUH9Xh7N_AzP9CHtDnCZ7iPow
 JNFjgfFxPYbXqOQWcDV4EsIeuxjIBOyQsEW5KdcXLEGR_AdZliT.vigjv38z_16hryVIz2Vtzt0q
 JWwt.5tNAfcMh27WhoPLf7mHuZczRitCAJfg.4ivLGIrpVcbSatln2zPcNwsZ3zucwG4VnATQJxe
 ct9m8pHVnonzRUCJhRWphuQO3BqnvYSRb38IGeIved9U52W74xTk7UvWFifCLL4kkMQH60QTJ._M
 Fox0sSmZouxgCnIOLVurd2z1g9XzPpqnnenvJLn0ZpXKAkWsQXE8KXGJVm0TayX9nB6PWgdaocHA
 Va2HhcvRSmuXnovQESKPY1OILG0BLGiLtIgnCzKAobhWgO7DWvRnjo980.6LO6qXrx5Bf.l5G6_C
 Shk3hvJZsMO8E3d5SwRTysSlkjTvcS50anZFzegxM_8lk6TvS.M5YRHf8I5n94uHO556vEcyuxlz
 jp0brtkfDarACb0KbAj.MWqeO.6dsctOpEaLPgwms1cMBYdtVr2VYg_s9hyr6phMfWcB6g7Tdbl9
 B1DFSr_rPcgigvI8SYhiryJad9.yXGFzTyrz602eFX0OAvzbIrjk9UH1soD0Nx3Z8XC89fqy30XS
 uBOUSinlivHjQ5Ozu.f9gf32az.c_WGK_lqlLP0zJmhOVGMSlzPEURmDnDQai3ymjOallMP_omqt
 U4OOBrFlOxT.Cw5owI9X5aM0RUa0GbZ4KMkq9RKYFJN0ojXxEIL6od50ofDI3B2DkVvmc0NbGOuG
 7cv3GzPusgRgY6YgcGWof8Ot7QbFYXhEQe5_cPftRkN6_nos0yT4D_HVM7q2mlZ4Vsvolco6LSog
 9veFn7xSnBuPDLGtGmqrboV4.cFH3prgdaHdXmMk9RRis5e_M62j7lz0blm1_SiHg3Z7u6XcgPdQ
 2t_JdIJ_qhlwytZ1Z9XEzA4NE2FshQ9qaTDb4XIkF6MD97BgHeZSkl6o5WUZq8Kiress0J37uBDu
 MP.GqZCZCbC3EibE6q5nYWt_hW74UkvCpNSjP5zvpgyGJmyCg3uV.5r6F5BAWBnOlvlUZBchMRLH
 WdDp2usLJ7l1q74P372MPJSHYg5irI2l3nT8pBAz6mYm_g.VBGLuLuLF2ZVbaI_IcJCqtytJDE0U
 CgHE77zkq1z1c2635WzpNlsEx0SEUlPoFUNBl1QcyACO_xpXRke4jvKfGgTI9lhfumLxlwrNE_d7
 YktUY08nY1Bba7QoRYnPhBfOy7WRD8Y5Wo8oPomMyKQZB4ZlX9xBFsAWp1Msc8_8R8dVApAd4w.5
 FGrFfD22l25gb7HIVJH2nMKLQZJKd5UUnCcM1fCuAuXMXg3AVocv6jHGtY3L6MBcU2y_Aad1ZIIo
 gftOkJ9JGRETzOzL_rtfSbeiX.LybZVIBW_V6iwWS_o2MPNCMdWcTL0n1YI7gKAltnuA.BMwWMaS
 Eduw91GTprRy3P0fO5VFbzbJCeC.SMf5Q4BhF.GMjxlws.radL9FrXzq7hMJKzl3SBCNONuzc4zD
 p.lkLM1iCS9EV6gjxWBgfpbEve7lRguYBRNmEZf8FkPMwwN06kyGjuTm4mguXTAZVfs.oq8.RZzC
 p4SVxFjKEhSDunqZYzfd60YPrwWHiQwbHmBibtmZe9fXvPpTEsULkR5kxATou1SUmEJVAJGvB_Yb
 Zhw_7ac5xbwHH11D1SJFj8pDPFeSeM1Au.sUz8CXm43NPvJ1TFTgTVYk.de.qW5Bw6zKUNrHxioT
 laz17ve0x4ui0kd.s
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: 53ae365e-5d87-4b52-9640-fe2e9941a1c5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic322.consmr.mail.bf2.yahoo.com with HTTP; Wed, 24 Jul 2024 01:08:11 +0000
Date: Wed, 24 Jul 2024 00:47:54 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <332605494.478904.1721782074981@mail.yahoo.com>
In-Reply-To: <xmqqjzhb28yc.fsf@gitster.g>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com> <4f77b7eb7f1110e47201b8c97c34a0cbcd14e24f.1721762306.git.gitgitgadget@gmail.com> <xmqqjzhb28yc.fsf@gitster.g>
Subject: Re: [PATCH 5/8] git-prompt: add some missing quotes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22501 YMailNorrin

 On Tuesday, July 23, 2024 at 10:40:30 PM GMT+3, Junio C Hamano <gitster@po=
box.com> wrote:

Thanks for the quick reply, and aplogies for my delayed reply.

I replied at the github PR https://github.com/git/git/pull/1750
and didn't realize GitGitGadget doesn't forward it to the list.
Then I accidentally sent email with HTML. 3rd time the charm...

>> Listing some portability guideline here for future reference.
>>
>> I'm leaving it to someone else to decide whether to include
>> it in the file itself, place is as a new file, or not.

> Check Documentation/CodingGuidelines; I think we have something to
> say about local var=3D"val" construct to help dash.

I wasn't aware of this file, but I should have searched for it before
posting. Thanks for the pointer.

As far as I can tell CodingGuidelines and my guideline align perfectly
on every subject which both mention, down to nuances like that quoted
initial value in "local", though each also has few subjects which the
other doesn't.

> ... If we were rewriting the prompt
> scripts to be usable by other shells, great.=C2=A0 But then we'd want to
> make sure it adheres to existing coding guidelines we have.

Not sure how many prompt scripts there are, but if you're referring
to the scripts at contrib/completion then only git-prompt.sh is
applicable in many shells and would gain by being portable. The
others are shell-specific, so I wouldn't think they need be portable.

As for git-prompt.sh, as far as I can tell, after this patchset, this
file adheres to CodingGuidelines completely as far as correctness and
compatibility go.

However, regardless of not being aware of CodingGuidelines, the goal
of this patchset was to improve compatibility and correctness, and I
wouldn't have chosen or felt comfortable to included style changes
("'then' in new line" can have also portability implications, though
not in the many shells which I tested).

So no change in terms of style, it still diverges from the guidelines.

Shall I add a commit which fixes style issues?
