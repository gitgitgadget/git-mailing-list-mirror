Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA19D34CFC6
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896699; cv=pass; b=p3bhQK1ypp9fnWDkOno3bRozOrdTeD3tPYWt4NoxjFWJ9akwDfo3fM3LxvHfWxl6l9vBZPneYJFoAG7kVhF87pgsiaunDILiT4PRXtdSTzHlbRaTm0+cs2chHW0vGcLljHa/9TGx+eGT9ZEHqE612R/5uYp7tZmnypQIu3qLteI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896699; c=relaxed/simple;
	bh=hF2VAzhluawLoWTCnQbRSKJUP3MEenW2LfVtSz3b2o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bysoJG4cHtju0DpYeofw3dmZ4uBRIYQtUmpYWKlnR/GaxP/Em+fEhevgGnDIM+Td6SW1C2jBoiYcFS6SsFuiZlsHhNSp8+HQ+ZoFIgwkQ6xdB/8Ybh+axrFa24F1U2HBv/yWku1i10F5jCG7IMwWWLFYbRKIepd/5Mla9Nv8Ge4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=BhrZx2zX; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="BhrZx2zX"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66493875766so484012d50.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 02:04:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782896697; cv=none;
        d=google.com; s=arc-20260327;
        b=DkXPKfkoaiDpKnWeV30j8RzJIkbzKaTho5h7gFo/6Qqku9buqsMAGUYDinCM/EFRKH
         b4JpZpq96O3HInxrW2KO3ciOVQu/mptHQFflIGyY8GeRnIfrnCtvO+8krs4sWQ097xdj
         Ea6gxFAoPiC4BYi2v65y7hzlvvt/QTAjWU+ZT67A/k0jGJ7ZQRbhQf0+TcUFm8LSeaUj
         Zaex0E56v24XimkO1TC8l0/xLJwGoEdgUK4bC4hjMJ7/xbuNu/1OjR1gyTDjg2HXQeDc
         kmATvZ1rptXjpCt/2ohvqRzE5ciH9xGA/ZhRAqktRaLGBnDsHcsxsDbONNXBF8E19L//
         LX3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pthR7B4UaRZeAZUAeuFZeSqPRnBqYECH7I7kteBK5So=;
        fh=r8BF32fe1NfFHoO5uoBIqu2GR2AW4xj0EvvFLLquQ70=;
        b=Pejy0PSN9do84PPm/eh6NRRCJlDeKxNKiSOuxYawcVTiP22ArHNdwHABBLB0ehVuOY
         KLgd/S9qsl7rDMgVw/B7UUBgXoHp4wTzkX9DvifgZYOXWDQoWz9PY9S0L5ZJ6icqjxAx
         JQwWBor2zWws4ATJWWKYD5Sxs0k7DRjaLBj8SofORoWKVR21TT5LRKYNNG3mHkFM6NC/
         d4rTemZyYyQ8bVfn9DTsEAQ6xczmzTIFLX7/C89EYTNZIgTeT8MfzK42PeepJ67jzzsx
         sN/K19ahvCc579vY+e6SucSCqWXNJtubsnDCybUTsLPVKLl7VCc7iBtmA5GeRe/dsOLX
         P2FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782896697; x=1783501497; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pthR7B4UaRZeAZUAeuFZeSqPRnBqYECH7I7kteBK5So=;
        b=BhrZx2zXVzq4/EybYR+ltK66TjqyP+TgTCof5FsKHtOxoUXFkYdNLKmSFclb/Qb91B
         JJy29mYGDR7uWcn1CrOJsOCCLohYZTKb0pPHts9mdn7EogcAXootnkYxY6bJVepQrZ0L
         9ot6bbudvz+h517IeB5cvPzQLNzZBqyAYeXvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782896697; x=1783501497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pthR7B4UaRZeAZUAeuFZeSqPRnBqYECH7I7kteBK5So=;
        b=lRpl4gV8atcEErXE56Dct8TbJ7WUvNwFTsK2TPU6+f2vqFLFK0KeNbM2YHcwEpjkiZ
         f0dsahiEqg7ZeJ/k8EQu7apI3oAJ4YH2DqkDItNA+yxTGZ+d8qCpv5wwdsf2EBVEAV9k
         Jrm5aiYqB+uvAS38BlwCZ9UvGsiWpD+1tlPZFK7I24GGfZG674WCiyOQSWnguT1LXCgz
         3em/Hy6JI0IV3VuiB8pElqivrQ8tcvW9OFFYZIfHsvpQ30Q+ofPmqCCNyIITqOxKVsD6
         e4XpWtvEq1MtdPTZHJMtv2mQ5xkFnY8Kau2VaWNk3w5loVJm9nb2HFGN2b8LtinpfENi
         MkdQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr0XBq4TVvcUgWggj414rjmLHz7lsivN6pFCVtSUonBp6Ew9dF8nWVqrHynThPx3QdMUSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT4dVA2EhW4+c4HISxLNoWZ7UvNt9esJ19/Hz8T616fDXn+hdh
	yZRZinxyPDn3u6TJoTPfmEFR5fQiZHv2jFRY+KD9epL125RbK8UmQ+ROAFIwTyZkcAHaq45gC5c
	rRaOrt5FZqx5l5gfdcqAbXBorfyDgkCRqKiViBubfOw==
X-Gm-Gg: AfdE7ckvKuzAVWzfqvZxH7NIfd09ixbD0EVdKSq2sh/EiS10ksgEs796x6EGpr8oULv
	eTndt+QmEraKAJaDq4XScpXw4e3y4DlaYSUGqJ8E1f+/JaOLcY6kokBDFc624Qq7vNI7KaNW32/
	wViyYGBSJRZwM58yvuHsRB/s26srEsqoes5k+JSr6CZi2b0+hYv5ElHpeZ13BL8+Xu0fndtCL1U
	r9oqXjX5YoCYF4K7xVG2sl8PNF1IHr5tr89v7d2SS6BHWaeCTQHDVETJjD69o4roG8vDIPGMw==
X-Received: by 2002:a05:690e:4503:10b0:664:988a:89ab with SMTP id
 956f58d0204a3-665219659e0mr562219d50.5.1782896696773; Wed, 01 Jul 2026
 02:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628075716.GA3525066@coredump.intra.peff.net>
 <20260628080710.GC107826@coredump.intra.peff.net> <akIJQbOUbdBbkTef@pks.im>
 <20260629203527.GA1895313@coredump.intra.peff.net> <akOG0oMu2KTqqyW7@pks.im>
 <20260630234702.GA3759976@coredump.intra.peff.net> <20260630235850.GB3759976@coredump.intra.peff.net>
 <akSxCUfm2P7ocLJX@pks.im> <20260701080014.GA3748390@coredump.intra.peff.net>
In-Reply-To: <20260701080014.GA3748390@coredump.intra.peff.net>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 1 Jul 2026 11:04:45 +0200
X-Gm-Features: AVVi8CfEcRMPxdPvem37qc_QXXNxnWxokRWA3NZwX_jgq2Am03QMWcdtd7KfSuI
Message-ID: <CAL71e4PfXA-ixKR6r7fu_7_QmdzK+rTRs29mOsUYKaq+_a5q5w@mail.gmail.com>
Subject: Re: weird quadratic reftable behavior, was: Re: [PATCH 3/3] t5551:
 pack refs after creating many tags
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, Michael Montalbo <mmontalbo@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Jul 2026 at 10:00, Jeff King <peff@peff.net> wrote:

> Yeah, it is (mostly) the same problem. About half the time is spent in
> refs_verify_refnames_available().
>
> The other half is in reftable_be_transaction_prepare(). Looks like it
> makes individual calls to prepare_single_update(), which reads each ref.
> And those reads are expensive because of all of the tombstones. It might
> be possible to do an iterator merge or similar between the sorted list
> of transaction refs and the reftable contents.

Hi, sorry for jumping in -- I found this interesting and started
poking at the code. I think both halves may share the same root
cause.

The merged iterator's suppress_deletions flag filters out tombstones
internally, which means higher-level code with prefix or refname
bounds never gets a chance to stop iteration early. By letting
tombstones pass through and filtering them one layer up in the
reftable backend, the existing bounds checks can kick in before
we scan through all the tombstones.

So instead of doing full scans inside merged_iter_next_void()
we can just delegate to merged_iter_next_entry() and instead
add a loop to reftable_be_reflog_exists() that skips
tombstones (but is amortized O(1)).

Now multiple call sites would need to add something like this
to compensate for returning tombstones:

    if (reftable_log_record_is_deletion(&iter->log))
        continue;

but it may be worth it if it reduces cost when there are many refs.

The key spot is reftable_ref_iterator_advance(), where the deletion
skip goes right after the existing prefix check -- so a tombstone
past the prefix stops iteration immediately instead of being
silently consumed. The same idea applies to reftable_backend_read_ref()
and the log iteration paths.

I have a local branch with this attempted fix. Rerunning the
benchmark:

  Before:
    nr=1000  0.306s
    nr=2000  0.945s
    nr=4000  3.816s
    nr=8000  14.93s

  After:
    nr=1000   0.020s
    nr=2000   0.044s
    nr=4000   0.071s
    nr=8000   0.145s
    nr=16000  0.258s
    nr=32000  0.591s

I can send a proper patch if needed/wanted, but I might have missed
something silly here.

Thanks,
Kristofer
