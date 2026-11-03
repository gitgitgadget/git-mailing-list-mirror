Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744050;
	b=nuqRz0Ss0umhjRue3/hHJxlPLOQ1X2GSZeZgosvTSR2NRiVoEmQtQalTSJaxsFweBiqN
	 ewU3qnvIkveh3VdvANuscE4XLD2P5bgJsSoSZjcvde/qam5MTiaHrIg8PzpnmpKIFGA59
	 69mcsJldvZ6RD4MuN/SYdDntd1UfmhxlvF7q/8L8X1JqNUj70ECc745Qa7ATs6OkyA5nC
	 +UIsJxXDzgGzWtEgPWdRpXqpYIoni8uQbFNdCnKw8Rrg/H7dqEDYOT4gLNJMyleY0nLfD
	 Srlbz4HCz0RqfAfIMek2NkSwtfv3n3r7FyVF39ExmzJjPCkYWQuV/vQY4wHi/pXJVLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744050;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=0D1Z3d2MCQIiltY0q59cCrKmzb2vT87F07aVmLoILlg=;
	b=00Hd3RQIEXybrndDT44p40HN9h7dsYv6Khvf2Gh2faL9EIg+vuRYCxbP4CiZiyOpckGR
	 6VH1loIpgDnKa5b7R7V3I4EbdeDU+YCCXlPm3SAvMyivGm9LFMcLn8Wv+e2vYwvsbr7va
	 xpNALVFSP5W5J+i3KfsxvyzNWxwfrq7LOLHHNzTq8CR12yc4PoSSdEfrE27F1HSgJTZcl
	 bZbTj/UtSb5EfxpiqC1rVMZaXDX/M3L98IlKpZNsp8ANioBR8wrGzSkin71KagmExTlWz
	 PO0XlcNRqYftFlw6VkqKF3KKuKuphjaVmGbykpWOv+qCBQlrpsYedzexX7aNBF1RJWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=IcSU5c8y;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gm74Bpsp;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97518606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 22:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97518606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=IcSU5c8y;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gm74Bpsp
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C8C9614000B1
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 17:14:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 03 Nov 2026 17:14:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793744048; x=1793830448; bh=0D1Z3d2MCQ
	IiltY0q59cCrKmzb2vT87F07aVmLoILlg=; b=IcSU5c8y6Zm9nLPKn5U3Xxp8ak
	iq79D7FSQgEFck6m45Hl5GyOToiweZXono9izULObdFNVQENg4972UPmO3E1SK1b
	FTAN4lA61p5TyfcqfkcLq/nOKnOY8SHzu8o6bKHzgPwYIJX3nW7MiZVlQCiBw/g+
	FE1HKxEsKjkH2Wp6EXABOngQi1Q+opHTAC7iL5WdpdbnhrjjWUYZk1jEFDBMyLnD
	ZvcSTIfJ6Ga1L1GlW2yFHupIF7Uhk2Fmlt2/eAGXI3Y9x4mXgFgnnUZWeTigPS1g
	NC7vZTSLZw32ujowZqXc2MfKioyLNABPoNQmkK6ASOeG7FPbx9J3tZ1RdGgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793744048; x=1793830448; bh=0D1Z3d2MCQIiltY0q59cCrKmzb2vT87F07a
	VmLoILlg=; b=gm74BpspBO04554/vGyqp7C4MJGay0B/NQPJGlh/FuwZK8YUGXM
	lgHt0YTqDSLGkdVgb1Hcku8vHWl0Fv+M9CyZC/deiXL9fDniRSvBnueq7VspVE/8
	lm5njyzlKcoXQr/SpjlvkCP+o5buxO9KjJWUrGSCnAhiPwIZShwrAKkFYk+82s4q
	qDK6e/kHq1YMY80TMtohinwXzFZ/VgwfcaDdLecq7xlIXZ+xIqHF+D35Wd/7+39u
	0QksdBItE4OLi06N1iHgzr5q3/hhdAAWvmga8K4k7yGeB75XZvlji2kBtpHzjGLD
	HfXOFPLyy2sLTD6lSEsq89Zvyw5EFQY0BmQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793744048; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:h3thimQzkuP43Ln2bUPXhtvJCaNGO40TWxmzgIjWDzmRLGz
	b3rQxib+Akl61S0aZAeCWbyxshr6wq8PrhAiiDpIxGvgcN4lqS2jSRAgBME/0CVl
	m67yc1crowniKmQsL9/SlrBGwSmev9m8etsJInJohs7i8qLcNqmJa/8qNEjlEq3q
	XtMEa5RYwb55KV1HL464P51Se8p4UQUfr4mcSEIytKk63OoJG1RIrJ0EyztXI8Qk
	bXUPTtFf7dDA5nA0PmSWlGQPZTLh1YV2od9PwJrmjxqVavo8cQG9h4jCwf19JV92
	KeL8YNnefKoWng7RdE7BgX1TTCds4enJxbdNSXg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:YFHdEtkrO/IvUhTkSl6/xSiymdpIRaMy1NusXsm7V6Y=:23nkFrt4gY4CuowCMzv/5sYgKT6dKl8Q6ZCZBEpMp1E=;
X-ME-Sender: <xms:sFzqam2a54cJ-t_Ek-IP6nDKMYzwOFka9TdmUQdImc24Ttnfhyucjg>
    <xme:sFzqaoKpP2O8HFR26GIzsyEC2l8IRl9eqg-6w5DUH2YNpW-DuaJu9xqWyWMendFIK
    snuOHQOZBmlS-nBZhI8ZtBprodITxfTTOpLpkSlFnj8ztbKeF1EpPE>
X-ME-Received: <xmr:sFzqalG2ygegYNIPaeGEZ9I6bE435NhHujgjWj0lm4nA-hUNYvXLEhRnb_Dd3cW_84OLwXGovbJW4GF3s7MZz91jsv_V5QZHToAQ>
X-ME-Proxy-Cause: dmFkZTGQH6TcpZJSgTKg/vn2q71KJY0wqKPUSH/NBX29wRqu9JMdZjGwKBUq11hKrS4Loz
    QFEb69pei5OcKs0UmzBIS0XUHsnJ/ygJpqgiTziW2CXI9EX4caWrsmJS0TtwYoSixzHYId
    AnnGrEbCjP2ckG1lzGsl6k2AawVSQbuXnSXKpD2pIsQUJZ/fpwMDJ3+/K0tud2GGe8wNi3
    tXFEL9Y9kkUtVSswZhQrTWHi+rYl+y7R0e/PgacWk8ut8j54x6uw6VI/yiUqDCcS5wTPGy
    QeSbZ2nDQfpkCAqibXmzhr/LVzUHUYDF0eTC9mJ7bPNfqqBwL08sxz/c5MpHwVt2hRmnNt
    vLq25RHXij7EdCTaP4xQXDaIdVGOaaml0EkgOwyPGQyTYhXPMNRFx8swhH4nA8RGE0IQUJ
    RqOx7K0lTW/4sGctcMx0aNJhyINauOopX8FPdBbYtvv1xyM93cP/BxlM0OZiUDs2H4u89k
    NgGmc2T2kh6gtLmk4ZSIGEKgBiqEBt901AbgVBnnBnaCiePAHpNM8QPQE9O6SJnhVVv/4G
    eJ1BkUoHZCPAWEL8MX2pVcEKXWif/JYPnHhwL73otSv8ZYrURuXwsccf3dRu69Vlk7WIO5
    YZwM5XBHAIyTWU7p3hv2LVDYN7YiCLqsqapFcCBUOs/eyaUMiZC5UHM6tnCA
X-ME-Proxy: <xmx:sFzqakWEsTavisc3sWpVPhMWrs1ohJk_FXRdMCTD9z8E1-vOK2vxZw>
    <xmx:sFzqatzdRbQLvwL9kE7FAfo8B3yRtrjTR7CTZBvQoI5DZ8YV5ehFCQ>
    <xmx:sFzqapQcm7aE2BW16H9sxEI-S6Cx6Jp19hujAuakXYEif_lf5eJcsw>
    <xmx:sFzqaphz604mw_-6u_wM-Q2_GxlBYBJUL8eGTZSyoHhLRjOEnwwMTQ>
    <xmx:sFzqarVwPKYKl11qN7OTTmrVugVmymAzaTA28x3Ggaq5Euiu_YkPDHFr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 17:14:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Simon Richter <Simon.Richter@hogyros.de>,  Taylor Blau <me@ttaylorr.com>,
  Olamide Caleb Bello <belkid98@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3] pack-objects: use size_t for streamed large blobs
In-Reply-To: <20261101072904.274912-1-gitter.spiros@gmail.com> (Elia Pinto's
	message of "Sun, 1 Nov 2026 08:29:03 +0100")
References: <20261031183748.273957-1-gitter.spiros@gmail.com>
	<20261101072904.274912-1-gitter.spiros@gmail.com>
Date: Tue, 03 Nov 2026 14:14:06 -0800
Message-ID: <xmqqo6c54l75.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Elia Pinto <gitter.spiros@gmail.com> writes:

> On platforms where "long" is 32 bits but size_t is 64 bits, like 64-bit
> Windows, handling a blob of 4GiB or more truncates the size in the pack
> header while the data decompresses to the full size, corrupting the
> object. If the compressed data also exceeds 4GiB, the length
> accumulation overflows "unsigned long", misaligning the offsets of all
> subsequent objects in the index.

Makes sense.

Will queue.  Thanks.

> -static unsigned long write_large_blob_data(struct odb_stream *st, struct hashfile *f,
> -					   const struct object_id *oid)
> +static off_t write_large_blob_data(struct odb_stream *st, struct hashfile *f,
> +				   const struct object_id *oid)
>  {
>  	git_zstream stream;
>  	unsigned char ibuf[1024 * 16];
>  	unsigned char obuf[1024 * 16];
> -	unsigned long olen = 0;
> +	off_t olen = 0;
>  	struct repo_config_values *cfg = repo_config_values(the_repository);
>  
>  	git_deflate_init(&stream, cfg->pack_compression_level);
> @@ -513,10 +513,11 @@ static inline int oe_size_greater_than(struct packing_data *pack,
>  }
>  
>  /* Return 0 if we will bust the pack-size limit */
> -static unsigned long write_no_reuse_object(struct hashfile *f, struct object_entry *entry,
> -					   unsigned long limit, int usable_delta)
> +static off_t write_no_reuse_object(struct hashfile *f, struct object_entry *entry,
> +				   unsigned long limit, int usable_delta)
>  {
> -	unsigned long size, datalen;
> +	size_t size;
> +	off_t datalen;
>  	unsigned char header[MAX_PACK_OBJECT_HEADER],
>  		      dheader[MAX_PACK_OBJECT_HEADER];
>  	unsigned hdrlen;
>
> Range-diff against v2:
> 1:  185b9da891 ! 1:  02e682725b pack-objects: use size_t for streamed large blobs
>     @@ Commit message
>          write_large_blob_data() adds up the compressed length in an "unsigned
>          long" as well.
>      
>     -    On platforms where "long" is 32 bits, handling a blob of 4GiB or more
>     -    truncates the size in the pack header while the data decompresses to the
>     -    full size, corrupting the object. If the compressed data also exceeds
>     -    4GiB, the length accumulation overflows "unsigned long", misaligning the
>     -    offsets of all subsequent objects in the index.
>     +    On platforms where "long" is 32 bits but size_t is 64 bits, like 64-bit
>     +    Windows, handling a blob of 4GiB or more truncates the size in the pack
>     +    header while the data decompresses to the full size, corrupting the
>     +    object. If the compressed data also exceeds 4GiB, the length
>     +    accumulation overflows "unsigned long", misaligning the offsets of all
>     +    subsequent objects in the index.
>      
>          When running repack or gc on a loose large blob, the original loose copy
>          is pruned, leaving only the corrupted packed copy and resulting in data
>     @@ Commit message
>          because core.bigFileThreshold is itself an "unsigned long".
>      
>          Triggering this requires processing an object of 4GiB or more on a
>     -    platform where "long" is 32 bits, so no test is added.
>     +    platform where "long" is 32 bits but size_t is 64 bits, so no test is
>     +    added.
>      
>          Helped-by: Simon Richter <Simon.Richter@hogyros.de>
>          Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>
> base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
