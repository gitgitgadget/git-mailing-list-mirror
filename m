Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC072F39BE
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 20:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771534423; cv=pass; b=XQ6P6R4RbhlNx/j5KUEuQrHEfGRSyMorhae2sT20nxEDGXxyy7YyF/VgP4lHdKPCssu+ACzM2SOC0O8NqpYWIAlZz/DhvvVSGD2HXAfKtWxP0+8CGcUQGUSP0g0d7aBU2IL5cwIULbsbZG8lGTq4vEJSkxRT0K4AHtlZaFSUeB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771534423; c=relaxed/simple;
	bh=nx+ZN9sXnh8hGxvx0UUGs4C8qYQYbiqwelDRcLh2MY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mHz1dA+kuVY+Dj1v7Fq4Al/unRK5JbwurQ5LwSi4hM3R/vZr7AFCWg6hLrmr1ImZcHudszznGBgyhQgHdBohYFc+K09tDvLPRZrC9STeTF+GHMEhKzx7Zh3ucU+pzN1kysBE9a4V9mT/B1I7MgVgOCzIwzoqR0FT145dIlZV2Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5BnHVTa; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5BnHVTa"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d4c65d744cso812973a34.3
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 12:53:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771534421; cv=none;
        d=google.com; s=arc-20240605;
        b=krLQX9MgPUNmO8OTcNi1B9ZgQ9UBbr1Jd7VyVrvmhMJTcCAkF+WI2qOGwmlxAnkNtS
         ZkAf2iTRWos23ZH2/LE2tZphbElfd+eTRArbwbH13ccjB9zhMFwYZsDipCE1fd9P0pVB
         N4fBNPKVslnLUePlM0wtpDyFHWt+kU4M53Mg35p1kCEsAzIPL2IK1HfsRJnBmmg3c/Jn
         8RRfo/FCFplnRHF5Tr01mIy/RMjsRldQtTdRmGSBiqHEX+Ofu1MG0OFb1GBHDVujCBOK
         cYs5HKUU4fAQs0MVTkCUiet9OkmDdFYIVoyhGunSziW0wCBkjTJMCtbkq0PHygyKo4WE
         rZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BQNy7+WWfKPorPxZ5puKMOaTqQjaVM9RjoBVJnw/eqw=;
        fh=ck1Uqu8rBAurbFi1qdQmTI8y8SCiafV/bwVULDcJXnk=;
        b=DVFo0QkLYJMIFWBDHIHeNXEmVwH23M1cZp1VR7NtTPIWO9Q34BeYtHLid0SmtjW46s
         p+3qgBuWOyN/q9GNk49KOk9xbswlrsbSYdvsp8sV0bw72tnUXC9VocYAnkU3xqRfKCY2
         ZhfraufFREZFxgnjx1hYXlBBxnHCEYUSEyGb2Xp3f/F8TSCaVKFpp4I+eFOZGl7ok581
         AekgUhlI9iMRCTIlrAdNkLPZAbl8orZPpg7x+soOzsjgxOpRr4GnMgmC8jes0d0FVlu7
         jvkj6s8V5AvDYk6+7+M2iNSVfUkV+3ppPEst+8fAxfX2qeAuTdWU3BrPZuyvrz/CokDV
         cUaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771534421; x=1772139221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQNy7+WWfKPorPxZ5puKMOaTqQjaVM9RjoBVJnw/eqw=;
        b=S5BnHVTaoRXWlhwQxC6wyVqlzu5EAeFVkO3tj7xZJkLWlVBebYIB2RRz9X3i1+b7sA
         xtt/qcGBxSVu37p2Aux7n2p1s4lg9QzNNgKaGN4AsoOMZJ8z295FhCXF1n1YOIutD26r
         pyLplX1jSKI9rSPAFitPEcpOdgHlIQ9aZzuABRYjmMjUGG6MQvTXcyEzclXV6BzfBzHr
         96PbnhbXNR0KBHXEnIXPr8NF0s9ledCPmEtPy10J0TOGzCB6TqhhSJRoZF07Pwv6c+My
         7dAz3513IAgPQObMnNTVIFzua2ztgsWZPs+JaNt1hMB4J807lRXhIxS8+M4lBbSAcKhP
         0PQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771534421; x=1772139221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BQNy7+WWfKPorPxZ5puKMOaTqQjaVM9RjoBVJnw/eqw=;
        b=eHn+/sM79aZ28KvbHlV3MTFDSK6X71fBpdiHw3q1LtB7HjXgl5P5l/XGiWFGLWEVRm
         csXSQUQmkc9Hyeez/Xwl4Kmx4+M60wOxpwJ2afzHNarlq6z9md/cjeNZUlEIYa2Nfuc+
         wNgOtQ1XfQViwek/OR85f5oU3/ESK7eLsfVRzhU5qWdqHLpIDVG4wCF4c1JEiY68veIl
         4IItDlSZSECPMt3+h5Epqg6ep27WksXQZdnpSpJymzJmbJv5E9raOq0W8hSrBU3Kg+yi
         /Bkb1hyUugiLrwc6G0Wz+PhDysHuHUOG8miLoU5ekQGrH/VO9XVYeZMtKSvLpyqplV5z
         sxWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2kk+HBW/qZu163FnY74D9EGzhNDGr5sCovIGuo1YLzeORVJ2prVpJKuy3CdZcvU2ZF5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp5+2KMLRcvYKfLdl1qmxReDT/6jVhYa/O+KLRGznW2N7KZSHD
	noXsV/4dph3HPQ1ufOaEiK9Wmlbk9TlcNS80sNed798rCS7n8rsJ6+r0fMqB4fmRrfBFlVbKuLA
	r5fbgrUlXYpbLiBzpSRezGfOURucMGhuWeT60
X-Gm-Gg: AZuq6aL5tMFBg9PAOws3glZCkyhgtZgnMeyLy1rNVQXlQtecCsXUQhsGMo1cQNOn1SZ
	W1Eso9QdWgr1y2z5WSU5rGk/VJzY3sg63SFPcAutdnRVLD4zrgK4lmE4O2q99+UvEXB4TBe3qjC
	2MR8b63+b+5nB+35wd6ocbBUC19knmZu2O6mMhCD+VL5ZyEyGc7mla7zEdjWvUFgJe28amq8f6L
	e1SI0gTwjIzc0MtqD2qSdjXUJcv2liIfH9nOUrrckoFPp+Gr1Pn4WxtqlqRIyxCERA/zVm91RjK
	tKwGo30UPGbxR7UF9xgu8Mk8HGI6voO2bF7oXgQC
X-Received: by 2002:a05:6820:4df0:b0:676:c2a1:ef12 with SMTP id
 006d021491bc7-679a742e84cmr3756012eaf.42.1771534421167; Thu, 19 Feb 2026
 12:53:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
 <46c24e0d05a91f830e400914a7e446afab320859.1771406115.git.gitgitgadget@gmail.com>
 <aZcr7DiIteTS9udR@pks.im> <CABPp-BF5jLfsndbinaPO_18fxvdUuVOYC8j31==jMXwK6iP0QA@mail.gmail.com>
 <xmqq8qco4gsv.fsf@gitster.g>
In-Reply-To: <xmqq8qco4gsv.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 19 Feb 2026 12:53:29 -0800
X-Gm-Features: AaiRm50YxAKYnWwye5yqXc5Q3hAiYQtIlVpBmOlRRF5nxqpwa2pthkA10Tz-TX0
Message-ID: <CABPp-BG94fTEhQbUy==OYiGrbQH+Tqt+GPiP6TynUCNPMP2y6g@mail.gmail.com>
Subject: Re: [PATCH 4/5] merge-ort: prevent the_repository from coming back
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 12:30=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Yeah, also full disclosure: I do not know why
> > prefetch_for_content_merges() needs to use the_repository.  When I
> > introduced it back in 2bff554b23e8 (merge-ort: add prefetching for
> > content merges, 2021-06-22), I was just looking at diffcore_std() and
> > trying to mimic how it did the prefetch.  I don't actually understand
> > why the comparison against the_repository is there for either of these
> > functions.  Maybe someone else knows and could shed some light?  (cc:
> > Jonathan Tan for the diffcore_std() case I was copying from...)
>
> I did a bit of digging for you ;-)

Thanks!

> The comparison with the_repository is from 7fbbcb21 (diff: batch
> fetching of missing blobs, 2019-04-05), whose original version did
> not have it, but was later amended with
>
>   https://lore.kernel.org/git/20190405170934.20441-1-jonathantanmy@google=
.com/

Ah, the explanation in that email doesn't exist inside the commit
history, since the diff was squashed in and the relevant part of the
explanation wasn't added to the commit message.  I should have thought
to check the mail archives too.  Anyway, the important bit is:

> Also, prefetch only if the repository being diffed
> is the_repository (because we do not support lazy fetching for any other
> repository anyway).

This comment came from mid-2019.  I then copied the logic from
diffcore_std() in 2020 (though didn't get the relevant patch upstream
until 2021), and as of 2021 we have ef830cc43412 (promisor-remote:
teach lazy-fetch in any repo, 2021-06-17), which means that this check
has been obsoleted by events.  And it looks like the check in
diffcore_std() was left in place as an oversight as well.

So, we don't need that check anymore.  I'll add a commit that simply
removes these checks from both merge-ort.c and diff.c and reduces two
more uses of the_repository.
