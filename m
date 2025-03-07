Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4EB2135AC
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 23:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390352; cv=none; b=GZgo1OuHhhE91KUrf0Cu6mGvhlabDU16JU6Om9ZiQfCMKnPxzMTr4NuG6HNx5ICLlrekU0YFI2dQV60ZLtvp1wqr6e85ahaN6rCv6jfci9caVN8TcPgKyANbaa5ijynycenOyOh5RaZNxjXKjHlIKCvdSw0cpjI8srgfu3v3Nls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390352; c=relaxed/simple;
	bh=n4PEB9d7BQyYgeRCymB7nBCXoL919q0t0RnSe7l2TNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stj8bnqktdgR2uDZHRcaN+edEBLfMaAk80WJv402YqK9OcYz4tmwZB9TrlUJbxjQwDs2IOz3dmRbCaqnt5DpHDZXdSz1OdrKY1zCAN+Ns8I6OVq4mbZmaT0y0YMw34lH3dZ3yzkxXyoO3+CsE5uXf86igh7bEQ/RWxbAOTxgwDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fqwaXHuo; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fqwaXHuo"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e60b75f8723so1703701276.0
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 15:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741390350; x=1741995150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovvbsNtSV0y+XHQNJQhjUgJhbM7oWJE76UPHADAC3Eo=;
        b=fqwaXHuoDdWu15z3Uw2s4+NtYU9fBOVqEap9o+hZ5sBnrrbOjqixt+mKu99Q8nxSFy
         JrQPbeqnoiXtVrzvH54JmqniPBernJhNPotLXenwd+e70Tq4r5OANh/I3aIGDB+2PIiK
         vx6E/D6h9nCRWuQALSgIVOLE7saHOisqXODnsRvkm+4Vd8b/a9YScr21/FDgpaUwFJgU
         WeV88P5XzFH26AQ+3VUE74XBB+uI+601MoFlPVPIvVMZClLEoy+Sh58JNn5cRGK/JY0V
         oV1/uAQB10UCkRloovuw29I2X3UtqgQSVHnsj4MshRlDG7Vy2PSkWye+GS+4Oa9fQmJ8
         Uffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390350; x=1741995150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovvbsNtSV0y+XHQNJQhjUgJhbM7oWJE76UPHADAC3Eo=;
        b=kNaV8Ra6QLJjvjy3mXnxd01bLAXqmzd+StDkwWT8bgDm8oDWhazKd2kV3y3HerU0O9
         2brhx12EkAu9bFTkTfMmqPqliLSVso3K8Cm6UuwyJIQ58QU+nRAsdKPZn+SL9I1rarFy
         DLU9QeTZapU4JgobSIOMiQYbLkkCKr6E5fhww8VW6aMoTIadh07Npnes6vGKqkO5byYP
         jiXkT60NhNt2uYZGvS34G9DEff45AWoA+RpGtwiZh56F7uaBoE4IbLinaII3t/Ne6mZf
         Si7Nd2Y+LxQq2MQJhxrjPFH8wVUC0X09baVeLzKYxrIKekGUY+yA4Ua1IVEEZx7Hb8eS
         se1g==
X-Gm-Message-State: AOJu0YyYn1wfoaWgyK0sS7DMzPsfD2vrjgnrtIPAYOYAvDqwOdKBDT7G
	uHoavIpOg3DplHNkqw6ovEJXT2AApsDgXNCzs11P/a/auuTXsi+2y2h4dhaQ3sqH5Ie5BJajtmP
	z
X-Gm-Gg: ASbGncsLRTublZZ55QrkNHGqweMEcxNbklvVn0g0mtwX0XJNufjCO0ZzpLS88SaE///
	xLZ6GsxbA5LS1nGi9fCzBQhPiGispw53QHuYf4Ke75n+L/A1Bh3lgWfQVSlJ24Qdxagr172oz48
	C/p0tBnoeHoEJmITGQJcJdCk9Pul3doDrki3O0q7PEYLTGVds2fj9dwk3sW6QIyg/sF8Np5eIE5
	sE+lhFtCPobIFzqe2ehQByDXzgX3VnGTYa19guKhZ1H81iMkeBkvFVwXbvukNMpXQBxVbrYA98d
	7LFDLsstI48BkzOtMpwdmT8KX/eO9+yWyhgC6zHXzvC9/dDrMkYq+vODJ9JG7FZtvKeFdxHS9LL
	Qh0+kkeTkhceRtLyt
X-Google-Smtp-Source: AGHT+IEm8kcZnGnmCtWYwCU0o7zl7hS7OmbG3lrQLWwBack327KQems1/4sxS2rEYCFczQhgGfFMwQ==
X-Received: by 2002:a05:6902:dc9:b0:e60:a3f1:b13b with SMTP id 3f1490d57ef6-e635c144c97mr6539373276.18.1741390349805;
        Fri, 07 Mar 2025 15:32:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e634b8fe22asm1002642276.51.2025.03.07.15.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:32:29 -0800 (PST)
Date: Fri, 7 Mar 2025 18:32:28 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH] fetch: fix following tags when fetching specific OID
Message-ID: <Z8uCDAaVX80d/Z1H@nand.local>
References: <71075837-D0AA-4F01-9F5D-CA10BFE93B63@ca.ibm.com>
 <61147be4b9a0ee76f1fe0f3376d7316205da350c.1741389941.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61147be4b9a0ee76f1fe0f3376d7316205da350c.1741389941.git.me@ttaylorr.com>

On Fri, Mar 07, 2025 at 06:27:03PM -0500, Taylor Blau wrote:
> diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
> index 195fc64dd44..8495730e264 100755
> --- a/t/t5503-tagfollow.sh
> +++ b/t/t5503-tagfollow.sh
> @@ -160,4 +160,19 @@ test_expect_success 'new clone fetch main and tags' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'fetch specific OID with tag following' '
> +	rm -f $U &&

Oops. This line is stray from when I wrote the test with a more
conservative approach that matches the above. It's harmless, but could
equally be removed while queueing.

Sorry for not catching earlier.

Thanks,
Taylor
