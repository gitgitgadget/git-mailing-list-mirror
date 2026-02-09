Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D5812B94
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770674611; cv=pass; b=W96Fi7MgvYNcVtKQTh+/Payn2NfoE9IaZxSHv7GjPhf6b+YiCnNLhwWDPD0QRFUJy6m22qlP1beauvQ8epjlj+hGzlnjE6p4QDzkgxKa97D6NUNM/JVrIVcXEkycxu8+aHncjv3Y+XWG4idaBrocYyoMkpMpklt56PEWDKFwzOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770674611; c=relaxed/simple;
	bh=V4x4urWd9owbe6b8HwLMpM3SDIf1SlRwgvchoZaulkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MM2Mr07jCznTK2MsDqBeMdhnQurSej/yplR49ZbbrFUnB8x2hNLd16xiQORFG18CWh8iVhlUAfS1BpeHxnrVS0BI15RIsJHgl7qxB3wlKgkPSKFWDK2oSvmby92hqHIQE+bceMEbhr0FK6UUgnt7M7QAJKf8gZ9xrraTdLCatjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbL2USDJ; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbL2USDJ"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-66314fa03c9so3078941eaf.2
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 14:03:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770674609; cv=none;
        d=google.com; s=arc-20240605;
        b=lkdp3iR38xTFwcblslFRloaMlqGes6wR9LPpNUpyyfrV9ChiB32akDTsQ8N03T1Mky
         XuzPkYoQ5QFdZ0vWnpDgIbNrvCudjP51L0ihH40WaMrK7tAoAygxxIgfyetFPghWlPvT
         QlI9uF4pOACkKlKn/ZLgNEvtdeGvQcH2qcMy6ITtwxH0ytO4n3bk5yYjFnPcK7+G0rAU
         8uTGgHmYTTP4J01KwPdg/N+sOnmkYRlYt+rpAVqm4V02l6m8KvWDzZze/e1rnDwTE941
         V1LpVbDmfZo7QeK2pg89dI6NB0SCOt2EpdfnpF9xPeHR7C2zZLU+VzGE8xztAeehlSXB
         2Scg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V4x4urWd9owbe6b8HwLMpM3SDIf1SlRwgvchoZaulkI=;
        fh=1UVtMVfN4NkFYvZWBqNAxKjSOTNJXlJ6OKe1tQ4K4n4=;
        b=X8R/8i72FJH2jvUu2hVIpG80AaodHNbdq3/vBoNpEjdhSzL8X6F3z0woDYYlirPN9B
         Yy1crBafQGaed7f8m2qcj4pqOBr2nO1w8RTrVz2kDuGdn7Js5mEyNr4hS1gyJEjbACtw
         715edpp/1GbQWuAetBWJ04osGvU02XOWUc+xSscvmeQbp71mGoUyRWRy/K7XWYUjMZ6D
         JKd65OauEFAYI8c34jgqORNKtYtGujtPWZYmMlN7X7NmlKDSBboD1pmBtokvWOAmDtGp
         v6GxdnS22DJ3f1d2cvOuQvmZOrVQNd9bSxTO2W4/8YYfB/bbLkbS8k63p4pP7wT1MiSV
         gqrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770674609; x=1771279409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4x4urWd9owbe6b8HwLMpM3SDIf1SlRwgvchoZaulkI=;
        b=mbL2USDJjK4laLHnWQXAzkq3T5cCQtoAVcIxqGGXN2O4iDhwWpYZX6MYTnkk+Hs+eJ
         DiCjv6xrJ06/xehSuzbujWY7FFNiLj/XFTsD2j/HUgmcpss443RAPb4qJhjnNjOoDg5k
         +RfRDRUbuGxmi/cFPqG5o0RnaZhsDNtwtdhZ7kceGF7nIzi5rSYCGM4du8xJeG9/nUI4
         eJo+qkfjFZ9jA9OxopfK7dL1IpfEtO3V1LUCUBVrdV8gUSjj3JQJR6gVjuGy6N6PoQUS
         C6Fg5XAJpszo+KZH9zrAqXasMJKt2eZrZ3YkPriWp0k0TIv5kwqzpANRMPSZOfDS0xw5
         6qdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770674609; x=1771279409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V4x4urWd9owbe6b8HwLMpM3SDIf1SlRwgvchoZaulkI=;
        b=s7xeYdWbg/U+JYxIdUs6XKpkZQa0b7no11Gw8uvGDt0EHqpQicCI9swCvTYFinW+9q
         rGIrOB9lmi7CLSGnkEwKlw5Bz3pM2NLMIqeD3CCPtDoAvgPWBBfBktB6qbdhx2k4tPZJ
         mLHLYrZg6n0pDIbh/tRmPfUeoYLtcPy5XsPbiqOwc9THVFpnlAA98uYmsNVzk4nYcRGx
         H3D1eCDY+a1VwN3asSI8KK3u5LkUOnU+TXHRA+KEvx5JCP0y8Lh3ZgFazBwYtxKMPhXO
         YW6FU/k628hby8f1nAYOMiaBeaNMV0G3lmlnXS6FJrS1ga1o++TXgnA27MBdaIpZRCcR
         8FhQ==
X-Gm-Message-State: AOJu0Yywccyjbrr/XNyrfsBondJmtjY+cgOoEw6vXpAPxHxKTfwzzS9d
	G2ZlT95DArZje2MmCPe3Hw2v9cHQ1j6RWxaLoKJ3JTwJH2nMdds8o8NSohGWsz9FEq+Rrza7/XH
	1sNqPE9VHkBrpwMrndRbn/EMMWL7uj0nLfO3c
X-Gm-Gg: AZuq6aLnclB0UQzr9ssTfInHtLM42qvzI1o44WSlLcWSTRO5g/uSrWiWrq3mUz68500
	I2SikGnVFn028l7CWIwWXhV+PTmz6BpyqWzO4RpDIy8HXX+wj3LD7yLSUCC5ikwjWdHPUiix1Ou
	BKXmzs7O0NIm6Uzceyi6aEn7k8iAqVV2j0TjBHdpA/yQXAWUTUM1aG/q5lyv9S8b1czhNZ4F4he
	O8s81sW1vHlpfsq36nChizW7h7KCQ11cGGiHe2T0BIJGwNj8e1yUiWCeMM4bbiEE9/6W1gW8qPj
	bdMwNB8ew9WiuK6SKauAyx+1aWdsp617ezn5mZ9NlXOPiutQBoncAxFbaEyyeX4F13ftKCONOse
	8F6SH
X-Received: by 2002:a17:90b:224e:b0:353:883:affc with SMTP id
 98e67ed59e1d1-354b3c8a795mr10903447a91.18.1770674598071; Mon, 09 Feb 2026
 14:03:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ae4cb197-1edc-44c4-afbb-bbb24df509e8@web.de>
In-Reply-To: <ae4cb197-1edc-44c4-afbb-bbb24df509e8@web.de>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 9 Feb 2026 17:03:06 -0500
X-Gm-Features: AZwV_QiNOJ_wVn5waQSVqIVJi8p5Diu2lmwpoCluIXqO_T15c2T1GmVvsNPQAec
Message-ID: <CALnO6CCMPCMdhMoei=bPSWC47n=+Uw_qP3joX8DPitUTcwNyaA@mail.gmail.com>
Subject: Re: missing git documentation for "git clone --recursive"
To: markusd112@web.de
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 3:35=E2=80=AFPM <markusd112@web.de> wrote:
>
> Hi,
>
> I am missing the argument "--recursive" for the git clone command in the
> git-clone documentation
>
> https://git-scm.com/docs/git-clone
>
> Is this --recursive argument outdated? In some projects there is the
> following command in the documentation that clones the repository
> including init and update submodules:
>
> git clone --recursive (url)
>
> In the git documentation only "--recurse-submodules" is mentioned as
> allowed argument, but not "--recursive".
>
> Thanks
>
> Markus

The latter is a (now-undocumented) alias for the former. See
5c387428f1 (parse-options: don't emit "ambiguous option" for aliases,
2019-04-29) and referenced commits (like ccdd3da652 (clone: Add the
--recurse-submodules option as alias for --recursive, 2010-11-04)) for
some details.

--=20
D. Ben Knoble
