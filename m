Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DC117997
	for <git@vger.kernel.org>; Fri,  3 May 2024 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750838; cv=none; b=HiESdgJvh9HgN3Y+ZkXiX+cpsODGgpROPFPVlbBMetp/3FaWmmu5tHaSzx8Q5W8F6O/MdPVaa1kcZWuYRc3NIzc11dNF19H66GyC+16NF+b9s2JZDKvfXOXMRVX5ODrpE6dJu4HR7Ov2OkFBNaKQLedcrH+NVLpa0gQbTiqE1/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750838; c=relaxed/simple;
	bh=JsF9ZmnWA0A+d+NuvaFEAFvGSZQYMciirfTi7Nub3HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVVi5AmgUu/jKKqdUS0kbdP0jEAxj6T7LLft9Nj6Dwki3MmlYcliQZpRByYuwEytTJqKCd7c5c7N/r8h1Dh50Ikf1Kyc8PzTYxkr82hdFJwWSF70I5hvd6rHnGJNz5ShUwq5x2WZW7xGO7mSqGpyYwQ8k4XRaWVkDUuf40lKnzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODPOvN2u; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODPOvN2u"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-22f746c56a2so3869341fac.0
        for <git@vger.kernel.org>; Fri, 03 May 2024 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714750836; x=1715355636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNcb2zSaF59WGKWbqiAza5+oQrmCDfRcuq7e4p+3hJ8=;
        b=ODPOvN2uyTfZjMj3lsUpX0rkj2J+p0GFvF1TC/U+EBlPVGaQ4c+UK/oZppY7sB0G3G
         MGo5tDmiQ9uoISeHlzEvRjIKoddCn7eeeB/8n2zh+FQQ775pvaAWSDZg/mYLEKVe6DVa
         7x9EHZn93O6PErZWu6e4hblWl41G1DPmFqv957Mf+I8UxglFL8zmYDOPF2z9d8Rscmq/
         uE3mKCTEghFGhY6npTBWHRYRzVimM64ZeP+NtpNdarVixm69CcsVHkWBNkTLloS3GXR2
         TbUh8ryeYcNvFFgHFQaJEMZe/p++lE0gGpNDLpP0a1fpDwZhd1HIeg2UsEr3bbgv1ZO8
         jXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714750836; x=1715355636;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNcb2zSaF59WGKWbqiAza5+oQrmCDfRcuq7e4p+3hJ8=;
        b=ZZrpH28kQCfWEdz2jcgw1n3aaoCS/fwF3qxM17NxLvayAxun53YgBEJ0gSroGrdK9Q
         d5Yoj4cocmJSnirO4U9GsHK7adbblsh5UTXi5oCfE10cV2AgVbh+ZOK1Mp41Tvm2Rk+E
         PU5e0xGLirp+E96rN+mOhUcDGCEEoX1e5K/wb4OvMSgUikWEpo4SZHDHyYc2GuAKbqHQ
         BiSuAArAPA/TQyd6RAH84AZuoo8yVB9OF50zzLaigvkKcp1lUdErmSPiWLAiKjI0Pp7B
         3y+YB5D8QigjPubKMumEfEMRri661DCCcH+Qt+3LpKYdDR9xOctli8mMdpU6RI94eRFM
         pWwQ==
X-Gm-Message-State: AOJu0Yz20GshJoK7TdydYr9Yy4xnIGtBcAxGcbhyr1lQu0juaZH1S0+C
	rrleRCK7WMtSjiMCfIyEI6zK4GX5tE0Kp4GgJDdiZX/mkzM/jTcnyj6Hgban
X-Google-Smtp-Source: AGHT+IGFi9zW7rwuaNJn9m8LldQbpYrkcHrG2zLe3LYrymdoCmFIqeWzO/xDYr8MD5PWUNdqv+915g==
X-Received: by 2002:a05:6870:cd81:b0:23d:3097:a5b1 with SMTP id xb1-20020a056870cd8100b0023d3097a5b1mr3569292oab.16.1714750836708;
        Fri, 03 May 2024 08:40:36 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id wn16-20020a056871a91000b0023b82735487sm654845oab.52.2024.05.03.08.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:40:35 -0700 (PDT)
Date: Fri, 3 May 2024 10:39:19 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v2 0/5] Add GitLab CI to check for whitespace errors
Message-ID: <otau2qghdji5cdzon57devetu4doqtzxsqhnttpdzde2lg2l5s@bfvjgeipdbhu>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	ps@pks.im
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240502193840.105355-1-jltobler@gmail.com>
 <xmqqzft7c2gb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzft7c2gb.fsf@gitster.g>

On 24/05/02 02:45PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > This is the second version of my patch series to add a GitLab CI job to
> > check for whitespace errors. The main differnece with this version is
> > that it first generalizes the existing GitHub whitespace check CI job
> > allowing the GitLab one to reuse it.
> 
> Will queue.  Thanks.  The extraction and reuse of a common script is
> excellent.

Thanks! I will send a V3 here shortly which makes some small suggested
edits.

-Justin
