Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793008839;
	b=FhWGmfI2FrwskgsexfaiqcbxoxUsUMGna1wm1FfwJxe7TC2LWocab0laW1eAxnnao1/I
	 94Vh6UY7HCixVMVsoxg7+WMDPCl1ibdEPh21LHeiTOGxDPEBPiFY8ZbiZs/D7Pde/M2SY
	 XrzZQ11mPye1rLxvn/UHkBatQxh5tSUH2QK2p9CPKp+5jjUHqAjhFqAUkSx/C+mgUUa82
	 NT0JAD0vKIHhx4U+XJUqU2fqapedYDIoEVHbT8gU8JsdmHXUWLxDOJNKt/5zUfJQ7ysQH
	 Tb6yJ2IlCQfzvsjp5mDi1M2y+GretW6nwpNFV/4WTxJBCgcBYfwpocmJWEEFjNhViZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=2aFfKoCwsrg7anYZQpFkEmr6xcfTRwE9ewNBvxXSACE=;
	b=L4ZxJ9AMc7gaWywTRAgmbM1eQLxD60OY9LURExDqYNswi8W+f70T5Z9uNsr4iN1tRmhX
	 ksqL6Ww2OAD+dJKfXjBonJeyPgsHiO/2O0IfGZRRtCU3q4CAT48bq1dA/AqDzg68mfHha
	 qsWh+1oVf4EOmUissV2xccNgJW+UnWPqOMEsAWDJvCLTxFLlkTGLIEWvB5wpBNkJj0zO4
	 RYaHr3rJTY91KyIbKryNoCKTV8avseazLsYMTFEzhAMFQfSOefBiV6WeGUZATV7AfZZlq
	 0z5Yn0UdX6CMiI7A6GJ9zR2kpkOqKAlfVX6jHuy3fkZRLJnrbQgMH+DR7JyI1scUM2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C+XpIzjM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F89606CFB2
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 10:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F89606CFB2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C+XpIzjM
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so4876309a12.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 03:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793008837; cv=none;
        d=google.com; s=arc-20260327;
        b=XGKenu4ajgvdhVG2dwrgPN2lNiLs/Dr76eT1So3kFfozrzaw+9Cv0Gq1sdKPMJQczI
         GkXQ7juoIAZxZ71RTKSfllV1NR2HgOZ5ImJGIzUkSjZMSN+0W16bHcXe7kHkkuiWT+LM
         dg4u/odRkXB53jhgi1/ylnWaNagsxofN40QnrnlwKHdgf9O1JdoxZm1fhILylYgpLenj
         m8jabfao1U5YYb7WIw8oKYWkirbDGU8h3x5TePCOpJDQ4PX+U41Go0NPyxw3wBB52dsJ
         GsQWGD4Qivad680cox9pekLKZcOmqPEOh3U98nyFEBeUtcv8U3YMCrbfW3G3OnQPW/+R
         rLTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2aFfKoCwsrg7anYZQpFkEmr6xcfTRwE9ewNBvxXSACE=;
        fh=R6j8oBDV+wCvxs0Q12TWY7nA2+7Y/5ZK94RKFEZaxRE=;
        b=CemhKBHAwDYtLjzzrw7DZFHQKqd8pQUT1d1mkzvhdUYMTin7Anhogj0aPhiSveLy3I
         obro+b7j5H8MBTlR37WPkGC7eo7z7YAZXy/cGXkKGteE8wlITeZJIApVMuUnlcOB01Mr
         5DCUB6Rl7I2tbvdcfjSTtebBNxlSyiWuITbLWem3uOVgnG43niwmEDp0SXsYGGkJQhec
         2DqefvdCtWVFV/+mt0/OI755tzcRe6SGQylgXmqyoEhhAlEpw47/jGEQ+Yb8y/ie7cDD
         sFWjnahTCR5KwnrJ8w6UNVfG4IbynZ+G8v3lMnK/fmAf9UHANcBQ4Ge3B2jxgpceTvd4
         +j9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793008837; x=1793613637; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2aFfKoCwsrg7anYZQpFkEmr6xcfTRwE9ewNBvxXSACE=;
        b=C+XpIzjMu5UQdsCNKTJRpADP13o9mDWFvgAv4cArtPg+3OAvmOJVOWQqKIiMzkHwxW
         98NngjY0Nhi0k10XWZZK+lMg7cHxsCrSM/Qb+iRg737adptZeCwG3sA4uhAJ7V/OkBcb
         KG31kEq8dE9iL9CN4rYSrDNKa7Ehwl+lI4zgQeT2JxylKb7R+hFZ9NOSA+Zflx6fbXN2
         evbp9ZApRd+KTTbmcQCOE9JdfcOMk+HB2alztgidGv4Znru2XlEN6/g9Q2OEhrrCC6kQ
         lhYXo2KB4alLlaWondCzSSNDnj0uFQ5vSnFH8UEtddDadQrJ+t5619hYa8SoW4jbHBWT
         OqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008837; x=1793613637;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2aFfKoCwsrg7anYZQpFkEmr6xcfTRwE9ewNBvxXSACE=;
        b=ezDW7ejiZgtw4ZZ6lgQBo3S1H5xqqnrk+gditVvUNeuYhCbyPjLBDzZlf43EUTMhfA
         rzLIgZo1I8ygAbj16oeIgfgCpvNbbNdGuGxHbUCQlVUrOWlrjIpK6Djzg6611BcR4j5k
         /9bUB2K8jfOZFHUsV7AitCdLJXaSxUioP9T02fEtObyk5c5WncoGwWvtJM9AARgfTaXu
         i6m9AtXBBiNsQWEVfuHeapwjmDhbSHznq46+I5rzIQJFkmImwwH5cD/ziDyOvBSVug0p
         MgwLVIhbfesS5bcNzMScvbzD4pBurpWqBSzpefDcp0LsAdF6E31AXZ5lkXAU6S1YyMjg
         vorg==
X-Forwarded-Encrypted: i=1; AKwUvBxsnBCqwCR1YZsjlAzhUb3LCSFMpviRGvtErnRnw6JOWJTJbhYyLVJ3FzR/5CHYOGOYPCs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWbBx8y1NEoPyLO0PwMdabDLEkUujRUcoWtZiTTIhxOLR4WCJY
	zKEelCpGk5S8dAhkPi23tKgWOXoH77F+E2oiOXXhCZeDJnL9MXKZkWVIuCFoSfPZmRKhmU0MDng
	154SLTtQy8lR+hdY2VYPcbdR5zbwMhF+6173u
X-Gm-Gg: AYBFou1iq4MXrQw2LBvCCjGGfIPQASpVrdTszojkJL0f1aJShUkh4PeL/PZD57Z8NXX
	0islGAAyzz87Lxf1RcMtUQnkQe1FZOAVUwYYjqVCpZgPGNVaIJx9fpOjn26Eh4/l2htf4TUe9om
	vxZbEDzL43QmWJ8lGb67jzsf57hJqHigPnE0NEaSzle0w+xo2JXiF0w9Yvbp14xERbAauUWT8Rq
	s4c8hV7uIuExbo9pZjH9iAnFF0xJb2lKlePgpXdmsANRBcm2KNgk/6NqZHm+1jp8dLKqeTGNDzC
	O2fo5RUPJjRrOT1MKmyib91zb3yydjL5KtK5iYn21lW3Jnb7UGu8JLC7w+o7k9q6dC1hfQO3/ef
	KoninZXDJZ6AUTfdfIaal61f9O+shyNa9/ynKrBJsG7+f+ub4a6ai81BZ6DG5JCvaX31kjw==
X-Received: by 2002:a05:6402:2142:b0:6b3:b10c:40f9 with SMTP id
 4fb4d7f45d1cf-6b442ff1deamr5421607a12.31.1793008836668; Mon, 26 Oct 2026
 03:00:36 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
 <pull.2456.v3.git.git.1792652185.gitgitgadget@gmail.com> <0f446c3c12aa5963259fed2617da51c31b992321.1792652185.git.gitgitgadget@gmail.com>
 <at8gbEmbW8b5cDjo@pks.im>
In-Reply-To: <at8gbEmbW8b5cDjo@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 26 Oct 2026 11:59:58 +0200
X-Gm-Features: AclHuK94nK9gEVKKFpxCFtVWVAvvlXbcBFf9gxQ2ZKm6p87ZdnXt-lgppC7Oci0
Message-ID: <CAHwyqnXAncLAM1q8m_OZmv=c_gajrgR4mK4gCWJ_zEGHcj+N3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] imap-send: wait for the tunnel command to finish
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +     if (ictx->cfg->tunnel)
> > +             finish_command(&imap->tunnel);
>
> Hmm, okay. Do we _know_ that `ictx->cfg->tunnel` is always properly
> initialized in case we call `imap_close_server()`? Or are there error
> paths where it might not be initialized yet? If the latter I think we
> might see weird behaviour here as the function does not seem to be safe
> when called on an uninitialized command.
>
> Maybe we should make `imap->tunnel` an allocated pointer instead so that
> we know to only finish it when allocated and initialized?

Good idea.

> > @@ -1163,19 +1166,20 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
> >       /* open connection to IMAP server */
> >
> >       if (srvc->tunnel) {
> > -             struct child_process tunnel = CHILD_PROCESS_INIT;
> > +             struct child_process *tunnel = &imap->tunnel;
>
> Nit: I would have avoided this local variable, it doesn't help us anyway
> to shrink the diff.

Ok.


Harald
