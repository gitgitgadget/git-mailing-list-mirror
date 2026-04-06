Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3962338F922
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775500855; cv=none; b=Cxfz9Z2SJwJOrMurBxaje6oCQ7b8ki1wcpE93YBXx3z6fuwCIrpGSdvd9N08U/RoMnEhQZfwmEpJW9aTLZ7JYtoEzIwnIqSdvcr2fq/2yQpzVGUIbzmw9NBnGNrn7p5ObSTj2W1rlxvKV/s9RdKyoFM4lypdHkwIuySnsOjkDpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775500855; c=relaxed/simple;
	bh=V0GeOPAx+2RV8y9QmrPVvYWqtxLGZfov+NbiFrC/nw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3Jh/2A2dwxG8lZCIyjeYRGsEVcTsRrS2jpzCaqoJzL8E8xP0RJSALR6RH+bQvRHqNck3ef74yV7MkJoqIESrewclmJrhhkZb2p00L8WW4lalD8hx1ZnzN+NFC6pzmm48fkl1lbZy7UAv2wztlb9Ejy7Tt50IgHxEVb3f4eONw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0n+lsH6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0n+lsH6"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso28239915e9.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2026 11:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775500853; x=1776105653; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LMOd6xUZdZ29TgPMelZcwSAbhKQsTn0MyYwEPDBgp6A=;
        b=p0n+lsH6lIM0oKa2z0uYnhxea2Ca9zHa4pFIU7KCD9uT5GLxrx6zE7OuqUFvmI68Iu
         IYGLS1GCs3KX8dyFq9ieOV3ed4qtRzxtkVmDiE9eLI90b1ELslzkmc+t94AW5P6EXUnZ
         4CLhe2Sxe0oAQu1j5x2mhHeKSnT/sk/jNlA3zwrrGRypHV2K9OArCpo14oMzHDNT7LCx
         fIC0AqL2t91YWdjBHjyBMQInEwFEkkxgkzQHR4AtqkmGxsqumAKVVuxJc1deDsKNYKem
         ZQPv8UbsViC3D96YtsYqUGd073LEIwhkqrztnJ/MXDgRR/PcHpCgJG5KZCtKYEJc3FdT
         67XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775500853; x=1776105653;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMOd6xUZdZ29TgPMelZcwSAbhKQsTn0MyYwEPDBgp6A=;
        b=JADSsb5D/38vf0mmDZzZwokFrSiDMKHTePu+GK0GBO1+r6UZLKefcbxp+lftjkMdFa
         mWE9H/FuMXKZeZ44kZiqBgH4BLH+hzMFeYyFVb/qd1o2K79EuzGJgaIL+qXJ9gbQE8++
         k6WJtEuGeH+JIVgZzjIryYtxyanR5/oAK3MowalAO1/V/9KZQ0CGjw2PLtSKJrbBdyB8
         R3OQv8mD2wCqbjs3AI4gV80k9e6/iuhEfCXEJ8T8Uhjlo8TbJl3kbE81LaYS0mz9grce
         vCBtW/4tKt1bawa4vR/pJsv0TXM6+/Sy9tvmrza6YaZtBwH1FTz6dVCve5vVJPB97p7/
         cvuA==
X-Gm-Message-State: AOJu0Yw/iel3++dEv0/rG0jA+PlhrHWPhVGIQ5fxZkUmsnU1esFgU7mz
	zEB9NUmP6RiaNwceZwsFYgk3rY5iWuLuxA2zEhDBPWJXNbircTWTaHq6
X-Gm-Gg: AeBDiev7i4j1YEALlRN7eAbzLIF4bEdz1GWvsD4lwDJQVzwThHtxWLUfAyrvS/gxfCA
	VQk9evLkjEg3Vur/HQZ/zMFZQtShCrHDSbwPoPaTS6FTPrgR8hiCTbdepoERm3Af84iEPMfQIVo
	mZOmvKlI6TWd/ttLaFOlBaXRo08UuNG0HQR/+oOTWmPtdgUsV4I4x4nt6DYqAjwlFq0/pHhRZF3
	p7uolMxeFj4PDrUhjvoM06ISOLvZ9uI5kMsx28kKoVEf4u+S7I1qJGM4z2ZOVLDw69uinObAS9X
	41epwtI71fVkcW01oHkCccXpSEgr+6rShhK6aXq/IXKclu6zPLZ0ARWbtmMmNNARz2fGTmTO+Nv
	KfJiyeGGECHKeQ1i0NA4JffkJR2+i0F54u/azn0MCQ4cz1iANVFbz4WQ1gG/WKOdersNHDllPDL
	OCJF5zBkd2dpu4RDEr1zjv1VEmuSIDyeop
X-Received: by 2002:a05:600c:638e:b0:483:6d4a:7e6d with SMTP id 5b1f17b1804b1-488997d4dbdmr197202135e9.30.1775500852362;
        Mon, 06 Apr 2026 11:40:52 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897fd5594sm97582795e9.3.2026.04.06.11.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:40:51 -0700 (PDT)
Date: Mon, 6 Apr 2026 20:40:49 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC PATCH v3 2/5] pack-write: add helper to fill promisor file
 after repack
Message-ID: <adP-MYYSmElK9wL3@lorenzo-VM>
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <3cd15429194c763727fbfd5981ba38c1dc2cc907.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <f2540dc1-fe76-48ec-91a7-82e32ced75fc@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2540dc1-fe76-48ec-91a7-82e32ced75fc@malon.dev>

On Tue, Apr 07, 2026 at 01:22:16AM +0800, Tian Yuchen wrote:
> Hi,
> 
> On 4/6/26 08:24, LorenzoPegorari wrote:
> 
> > +		while (strbuf_getline(&line, source) != EOF) {
> > +			struct strbuf **parts;
> > +			struct object_id oid;
> > +
> > +			/* Split line into <oid>, <ref> and <time> (if <time> exists) */
> > +			parts = strbuf_split_max(&line, ' ', 3);
> > +
> > +			/* Ignore the lines where <oid> doesn't appear in the dest_pack */
> > +			strbuf_rtrim(parts[0]);
> > +			get_oid_hex_algop(parts[0]->buf, &oid, repo->hash_algo);
> > +			if (!find_pack_entry_one(&oid, dest_pack))
> > +				continue;
> 
> Memory leak here;

Yep, `strbuf_list_free(parts)` is missing here. Ack.

> > +
> > +			/* If <time> doesn't exist, retrieve it and add it to line */
> > +			if (!parts[2]) {
> > +				struct tm tm;
> > +				localtime_r(&source_stat.st_mtim.tv_sec, &tm),
> 
> Typo.

Ack.

> 
> > +				strbuf_addch(&line, ' ');
> > +				strbuf_addftime(&line, "%Y/%m/%d-%H:%M:%S", &tm, 0, 0);
> > +			}
> > +
> > +			/*
> > +			 * Add the finalized line to dest_to_write and dest_content if it
> > +			 * wasn't already present inside dest_content
> > +			 */
> > +			if (strset_add(&dest_content, line.buf)) {
> > +				strbuf_addbuf(&dest_to_write, &line);
> > +				strbuf_addch(&dest_to_write, '\n');
> > +			}
> 
> It looks good elsewhere, at least in this patch 2/5. (ゝ∀･)
> 
> Regards, Yuchen

Thank you Yuchen!

Lorenzo
