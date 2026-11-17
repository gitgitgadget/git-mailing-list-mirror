Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958552;
	b=iHM8xh35MChZKQj3YU//VSeWmXFtlJAdh7SPI/ikNBgFfUFnmVudkrPC+0It6wySlbHw
	 tmxrARKcmsPs2tr77dgiuStxDURA2rsQXLi3/rteaw5iCl0lta6rjNEHsGZZwcsE17QGa
	 Idu8SkELt3SZW7QPmg2TIS0IjNIgyCCrMl2XyefMsh4R7ckcZf6PyIoMDEQMES0MJjnbz
	 aDT4bzhipZtnQ23bDKxEAHlNARWcRBaVnnkHNpCTD4BH8OOH6tA87B2qX1Ypxg85kb9rA
	 Is/2m4CPEkeNaDAdA1c8z9vNNFGd492c51aHAlng2Xn/BmVYfUa/8TZBKOdcBH6EScA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=vFl3Q70JhHcM1/aGNfrbND06YU9lBkpog/uYBPi/bsE=;
	b=Vhjq/BatO/HKQufrJBvu5NBXoUayzo32G7Ae69jaIXY4jXygB+HVfbZ4QHHXbcgXgeJL
	 F5RmBrAZ4qyDCjwj0mXuyvDKN+Ql6f4u9njOcEXcU8EzgVHQYoDo78tpES9R8s6tPEaXT
	 YKy0o9LyHzge15Cwkm76dSEr+RjK6Vb33ue3KQmtq0FpEhgkdp7EL1QRVLOkKRR/Q+csd
	 oQg3onMfKCklWhpPQF1VcIwhRWe9PlaG0Jc6nSWrRT64rMib1t1fVeERcIpPmKHWkivme
	 Zs5d7IF8jePithxyjqiiyoLCkO9t/keIGT6mz2H8j4NiID4/WkENhq0eX8u/LNqYOhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MdRnaepa;
	arc=none smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC58606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 23:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCC58606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MdRnaepa
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4a77761ff8aso247788fac.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 15:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794958551; x=1795563351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vFl3Q70JhHcM1/aGNfrbND06YU9lBkpog/uYBPi/bsE=;
        b=MdRnaepao5m1R1a2vNHfZMHMU8tlPRdQqOyTi7xJ2itC73WUwm7KLJD1MITFycwRjS
         mi46DbPs6w2aynQblndluLsupgqqugU+fJ9dPZoFpMnqkxZFIukEO/AU9/Oppw0ryC21
         CaQR3QIg30TQQIYIhXYrG6TP8dgN2L2IQ7QfUhqn6MLxZzCAkcRxsrrZoEAC7ZFXgTqe
         KA+4Nroxl5CbJwFrFoe8msv6bmSjSkr7FilQCaXwGy2gvs9OBtEaIIlfcDvBZ+47XUKt
         EHhH7ltGzSye/+i5qRvmwcgLuxnZOxO2Km7Uh4Qo8gJmSwDFoOOaz/E9PoAdVR4Xazdd
         O/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794958551; x=1795563351;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vFl3Q70JhHcM1/aGNfrbND06YU9lBkpog/uYBPi/bsE=;
        b=v+AcF4YG7S2cti9NOkMAqJIHDf0BSandW0xxwS+VXh14fwCmgTlBw+5zJFaUHZexsL
         ytszpinx51r8gSKGGVA6txp6XHxjr6InBWCcz5GUpD9rYlvrvQ0pqogVAUbolWt981Kb
         pXQdXKwnc8y7AS8BOuSMwSKtBxDXn9Ewwt8Q3f+7d9nXfMcGiFvRCMch3SgBjkgk69iN
         MLlnFFLxuyQaGNpIKAipxXPllDvQ6bko7VJjmtpN5Ogo5Az7mP0eJkSAdgeHB72btBCE
         Byd3K8u4My4f329qS6lBpSMSCyMiG1liRng7rCWEw6EWExTVJdRfoAPKzCktFcdkYWw8
         E6vQ==
X-Gm-Message-State: APuU4Z/OLLyF6wUJt6KxrMXy8fb+oDLtqGuhHs0a6sWX14JomoFxdBTy
	P5Rv453GTGGFg9DS27dXcfA3YjnIgUF4NoLNI/I5RQlJ2qgyO/NecAIqNcjuGw==
X-Gm-Gg: AYBFou0Ssz/eKxYT3Us2iLe5+QKnvnsTcbjvJ/MJYO8GFItNTrlJ62cULE22aoJY6ZQ
	HtzLO7XImaH0IJ1X3HBTaMIu+Hwua7eIMRMCZpRA48loQi2j1uCA0odJ/aokegN1mvq22nbQxNh
	9AGKIUBnFGvJtAVtZoQP5CFXLU1gfAqpdyTQfh7s+Ccc5zCOfX5954dgEkX8OylIwmbodfMnLEb
	vILxz6CGJDkHsRQ4EAMmOdCBkyAnu969Vgf3aNpT/NGRsb77qcjYFa4XjxoZ2xcFdadLV26HeaZ
	NXBn/Zhi6YXZs+uqUdrEBApMBgycdR28ze+S2GpTTXmG2ub9RDLKbqmLIqsycqhir4OTd7pGiWL
	AB9fS7i5TBRX3mhGn5dZRocDRkxUQ7JuPMI5Yx0gKbEOMK8alB1TJyZ9lEsHYhGiyJm+m2dQAg7
	2+xp7/ZIwnaId/FTZAVzqEgurmxsk9jkPIZW5ozKqQosjWuZxp4XXpBYLwMS/svzfg49gQ3p8o4
	UIO5Bpj+L29LB4xj+FZze1Wf9qOk/NFZ+/b1Z4jfGVhjusvvZo6prFE3TAlZLQ3KBZOEIKY76Kw
	5JLW8Ji/3ZZxEzXG9Yk//m9R04o4ZGBnkp6Iz91aSUYvJhSrqyEYn/o9P1RCfc6gIFp7uhE5908
	=
X-Received: by 2002:a05:6808:198d:b0:53a:ff9f:4d84 with SMTP id 5614622812f47-5773c52fcb4mr1936272b6e.2.1794958550701;
        Tue, 17 Nov 2026 15:35:50 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5777a2bbc1bsm395900b6e.5.2026.11.17.15.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 15:35:50 -0800 (PST)
Date: Tue, 17 Nov 2026 17:35:44 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] object-file: only flush batched fsync writes when
 enabled
Message-ID: <avzghl3FBW3TTWhV@denethor>
References: <20261110002251.2007617-1-jltobler@gmail.com>
 <20261110002251.2007617-3-jltobler@gmail.com>
 <avRqlHdN83O67HB1@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avRqlHdN83O67HB1@pks.im>

On 26/11/11 02:16PM, Patrick Steinhardt wrote:
> On Mon, Nov 09, 2026 at 06:22:49PM -0600, Justin Tobler wrote:
> > When committing an ODB transaction for the "files" backend, a full
> > hardware flush is issued against a temporary file before the staged
> > objects are migrated into the main object database. This flush acts as a
> > barrier for objects that have been written with batched fsync, where
> > `odb_transaction_files_fsync()` only issues a writeout request for each
> > object instead of fully syncing it.
> 
> Hmm, okay. The difference here is bascially that we don't issue a
> hardware flush. So we know that the data is not in the page cache
> anymore, but it may still only be cached by the disk.

Performing the hardware sync here is really only intended for batch fsync 

Right, that's what writeout-only gives us for each object with batched
fsync, and why the single hardware flush at commit time is needed as a
barrier.

That state only arises with batched fsync though. Otherwise, objects are
either fully synced individually, in which case they are already durable
and the extra flush is redundant, or not synced at all, in which case
there is nothing to make durable. So the flush is only useful if there
were writeout-only syncs.

> > The flush is issued whenever the transaction has a temporary object
> > directory though, regardless of whether batched fsync is actually
> > enabled. For transactions configured for git-receive-pack(1), the
> > temporary object directory is always created, so the flush is also
> > performed when objects are synced individually or not synced at all. In
> > those cases there are no pending writeout requests and the flush is
> > unnecessary. Only issue the flush when batched fsync is enabled
> > accordingly.
> 
> So this is essentially a performance optimization?

Yes and I also think its not really the correct behavior. Even is fsync
is disabled, the fsync here happens. It doesn't really harm anything,
but I think it makes sense to address as we begin to roll out
transactions more widely.

[snip]
> I assume that we only support batched fsyncs for loose objects in the
> first place? In other words, if a transaction were to write a bunch of
> packfiles, it would not be possible to batch-fsync those right now?

Correct, this mechanism was intended to batch fsync loose objects.

> If so this new condition correct to me. But I think this should be
> documented as part of the commit message, because it's an implicit
> assumption.

Makes sense. I'll update the commit message in the next version.

Thanks,
-Justin
