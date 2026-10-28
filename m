Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793147882;
	b=Y+FthboRzC2/1yVZRyTzSeu+WAQ/1T3YfoEorU0EruFnOfThQ+2sO6nbAG8foqtF3l1G
	 HScuLqMjERI1icy5cJr2I9d/auQCUCRwIRo3Ophg/dYAjv74V8M7nadcu9b2wwr7ZJ84K
	 ZY7QJgi1lzl2HHpfNRE8VDaS5TYl2PVLUziEC6OU+f0o5pLkPTeO7OmcUtl+FlDxfuj10
	 1hg3k8oZZ/nMCxz4gnd5Sl6OfSHQs1iJOwZdiYMtHNsM5JEOogYLHcHSfLDKfUPMiRLEE
	 BkHkHa8iMOJevHJ4tegtKqpjC1zI5SGLNrHPRQkIpTVoZ+TbhW7MS2WRyC9+fYYQqoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793147882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=4DBpqXoNMO/kp7WpSol1oVqnwTk8ZJ/rI8n8Evdoxx8=;
	b=p5jPO4K/osh7QgDdFOGid8fNmkuK050CdObl2viAj+aFqI9WPzA3Bk1owms6y0KuZH8N
	 BugHLAYJ5D0Zz6EHnsfteECZ6wM9FjEQoPjOElPziujYrAuOQg8TKWUHEWX1gjN2TrwXo
	 Jaws52PcARQa/fkikkUbnV2xnb0g9fZDN1mT1kucOLyk/X2YWQ/URuqnr9EsXLMbplo96
	 J/e9aWZ9rMpxegCxQF8z6xgSXbn7ZSkQCRS/naM1rR0t/9ZEt3bryq025hZk7LwwVVt3K
	 Nf2ggjGfzRI8Ig7G+jn2sSa2r0LBq1clGV3Xomd/rUsVYupib0kaePLhUqiqZyaYg4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=VRiOLLbP;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDFC606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 00:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFDFC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=VRiOLLbP
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8479f46ecd8so226044a34.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 17:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793147881; x=1793752681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4DBpqXoNMO/kp7WpSol1oVqnwTk8ZJ/rI8n8Evdoxx8=;
        b=VRiOLLbPiQIoL7ohdLiP/Heh1LLfACRVhYofohFPlQ3Bw2Z0M2Vr8uxEbm/r10twhy
         LCW9qQxmdCnAqC931wnOmfmS3rsACsWFOpedHwCpnMu9Xlo2sWfg5PbtXuMfS4K0TcFJ
         hzYQJUJDQUb4AnVmyK7KXTG/AHbDxEYtTeLPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793147881; x=1793752681;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4DBpqXoNMO/kp7WpSol1oVqnwTk8ZJ/rI8n8Evdoxx8=;
        b=WoZszrWXTF4dD4aRkedDxP8Gh2JJD9Yfx2LPxT+GDoaLkhwQzeH9+xwa1KFDt/0DU8
         FYcnbsTzS9AqxMWq5MDw0Pek/MkR4dBg6T2zV5enpwMXB72GWOCN53rCNE2ge1dfwnaB
         MobUNH05mvKqxzlOcgjT37ri7XGyQcAfgP9bz8R0FvztETqjklCiinSFMtXn1FsNlF68
         H+ZANS961dUk9RjGTns81RQzhNEAVd3LNpgVvZGs/hqbk6OtFc6Y7s+gVZa9DfkAWBp4
         T+J5wuau3oCCKrVWvFbLEP4GLdgizfDkeyv9Ml/vwujcxcq+hY/23/n63gyLZgwZzDNB
         XbyQ==
X-Gm-Message-State: AFq9FYIwVDisrulj5WXWDVaalQbsdsBZ7t+XtzZ2p9v2BQynAaWcx5oN
	kUypj8ndMJaFd41w045m0KBJ9N70iS4x6UFZ91sPlWqX6kKFi0jKrSYEf2GCroeRBb0=
X-Gm-Gg: AYBFou27miwo4ojeXkUr6pEpPy2ULaTbr8SNV2JaXU64vGOO1wG2guzoWyeoyJfUEwi
	WvAJ+LFp1/v0u5sXhDMEKDMyMuuQSLpMbyMSdg0dWq5Ug7e4vLyyOaJ/Zar8uq/r1cmN84Etovx
	ItWsCdihmoAkEXMN3bfzGE2zOon9RZ0WJ6x0fHlkM9EKwGENd3MSk8V044YXkNazdhbzMOUuYFQ
	eaRfLL2CXu0EcvMUxkpWl2UoUR9GPLZBW/XGaEPeCdoLtI57t7BqckLKXLAzOAhObnnWaZRTmAn
	SZAfcvZG27+Jf6kSSQUVKdq625sDVbLOKJ9YjsaP1jOoPKRmaDy3RDG+M06xGBmOULux9VLu6wi
	AoX/5b+0StVGVKblg/QeuaOxdW37Lba2uV+vom6AkzY9hK2u2+wnDKb5KtjiV5GG8Ta8KBrxnCl
	gbORd5zt8nuxC9SXapdORpuo5H0M3YyeFehgXWuuCTG3DZwuMp/wxhdUfAbnOwlxmTNDN/uJ3kA
	i5tL3iERhZAi+gqXMR+nfJvngJLpx/KEyfaRZce2AGkXNqwB8PACBDUN+HhmYZNmSrHfEzIPH8c
	C+xsfcYuajLXoqFSinSBHN+mbUHHfSbpK5qINORXHmFbYMZTvlT2NQD6aoJishtVJouOsAYjOrj
	+xhg6uhyri5XMo94QvoCaqJrldxyQjgWUM2e/FwUkIOrP
X-Received: by 2002:a05:6808:17a3:b0:4e7:c6f2:75a6 with SMTP id 5614622812f47-5638526c065mr459772b6e.68.1793147880830;
        Tue, 27 Oct 2026 17:38:00 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-563c5437b81sm142465b6e.3.2026.10.27.17.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:38:00 -0700 (PDT)
Date: Tue, 27 Oct 2026 19:37:57 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH v2 0/8] repack: various corner cases for cruft-less MIDXs
Message-ID: <auFD5f8IWEHwaFLD@com-79390>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
 <xmqqcxsufz55.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcxsufz55.fsf@gitster.g>

On Tue, Oct 27, 2026 at 05:27:02PM -0700, Junio C Hamano wrote:
> Taylor Blau <ttaylorr@openai.com> writes:
>
> > This is a reroll of [1]. Thanks to Stolee, Junio, and Peff for
> > reviewing.
> > ...
> > Thanks in advance for your review!
>
> I am trying to eject stale topics out of my tree, and the discussion
> on this topic is about to pass the 1-month mark.  It seems that
> comments on half of them are "looks good" and the rest are "just as
> confusing as the original without improvement".  How viable is this
> topic?  Are we still improving on it, or has it long passed the
> point of diminishing returns that nobody is interested in polishing
> it any longer?

This one should be ready to go as-is!

Thanks,
Taylor
