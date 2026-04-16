Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91FD372EE0
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 21:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776374262; cv=none; b=t0f449Rmj3iTaOGsJY0kAGIHzxeWXfpYV+j2rDrt+g52+BDFFnfyLfbMY1aU0SIFnElHhKJ/eBE1HF6wyLHwVjX76PtF0T61C0caWZr4GUAg8DfNDePi1NG+fUPg9h1bJMKpmJDK1+VmQj55u1LvO59BGqE58h7goWxWNH+4584=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776374262; c=relaxed/simple;
	bh=PsnmfRC5Kq4+4S2LXTKrOSp69Qry92nnU3hXzDK6UYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ezg5Vv5eL8Kywot/IxHz/b/+QWE7VLiI2qLrEtWZiUHusqvOScBSnEg2SWYQNZWMgC6UiuqpOjzxTTHxPuujb6e7SFx8oYHHAS0qvWgXLMUCtIINQ4JHx2Q3jx2lV2t0vRMbArc6feoQKF1Rrr8+0iQwTbcZW5o7TX+8xkMshE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=kdnRN8Q/; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="kdnRN8Q/"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-652fcd5a6d7so49927d50.2
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 14:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776374260; x=1776979060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r9p+uJFp/pZAJ2lt3XHNRkDlhESsy1C1D20YGQN7pkQ=;
        b=kdnRN8Q/QbB7hHh4Ixa7bOxXS9WtgiLFZ547FdU3jYWkbbgpStVJ74UC4hZ84a3FSa
         awoE+nC+NmtoHC9Jka80zIjelN34MHvKUMDtiJJv3nkafmfoDgE0ohGweWgvDR2blBsl
         4E10MIygGW1HN2L9+Laek6UdTEODowHt5yhHwvPxuzIwmld953zNsNllPEnPwB/nXebF
         F3KCV73vGjJMSua8ELWdQqwGNzMlbau3Ap65UpGIq/ekQAMdledD/HR4OfDL1aCbpEw5
         0qyK/2lDr+WXPt5Ohd126/c267s5k9ICcKUvfbl1Ij1jC/imvaaK8Hlq+EFiPugomcIJ
         op8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776374260; x=1776979060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9p+uJFp/pZAJ2lt3XHNRkDlhESsy1C1D20YGQN7pkQ=;
        b=Nkwk4gGGYanD5SU90BGWaC9Li/PN8uPx0QFVRKjxmghxzTlTvSU3jWJsgA+ycrWXfK
         PoGY7D1ncFVZUN8E7wU9zdCbMsjwQqlEQqWE8Ris3/T2/f25k4nYtYcgGcGyHLFBsSVz
         2k3lyPrvdskBsun8AFRDse3oZ6gfOCH77ab7YKq+iOOeZmxquNxSu59qYfQ/BQH4/1Is
         990anKhZtsw55VKcJ7L4coMykzUbV2wCCBeHS5f2B+IGAFCHYE9xgAcXv69ViS4n1XeF
         3Xs5VOxtAfCvetUwvXOdpeYXXKIxZWPFiiNDZcIMiMAOSyoOw9hdBQF0SS8CLewixN22
         dFuQ==
X-Gm-Message-State: AOJu0Yxa8j+iFDDAIcGX4clc+W0/CvgBwFDpKWFoSB+JyqhkhZapmIje
	eV4sm99uuENMbUGUyUVWGatNezh05QiCoGAOgXVMZq3W0/dytpNN8R1wFG/A3myg4Lw=
X-Gm-Gg: AeBDieuXEQwnQbKw1PerGUPf1bcMMBoBPDzZa7BOQsK3M/1bkvj6V91xZ7N+El9ffiz
	QrFxLkhusQyKRgfPjIw3d43omXMJTAM9VjDWE28/Zrxp8mD0EcneDjV8icBc2JiMRLTsbMdAkmy
	1CTtv8xa+ex/7m5Qdl7jNtoUXoZDojljDWQRB8fDrXVZNOQt7xWWw6Ag4rnLEynizdxhhWtC/A/
	wGXNo3RRJjjF+xFILOT7oH6qQ26DpoMS31+l+/MbHUbKPlyZfVM8QDGcoTD8Pf+ZjAqZ+QWuWl5
	u2+PmmW6KEbJFRm+sdPHUx1G5+jKX0gtv6PUid/74zpqdi8g4kXka64KcBRRSbL0kzG/MUXC8YI
	EXM4VhTo11/RMsvRv+8sZd7ilyrmhL6K5/acuIxpYSFAhx/rH+szCKaip666FUmCjVqAtlKb0Kn
	Vcj2ilzh73sAEce6k6Az8G7WhwFJhNyEcAtOjCCmgQiGgjvuWsjgIoOqGHwQkzjaNW5zEr8E9ks
	sJkG/VNEY2jybUy1CkvLliNppqu4IW6CQx9rWXDeMZZMa9pYCpL66nmiKMpcrQc40RHAXxPVE57
	/fSPxq1G0nZZ9iGop0WyMSh5X0g=
X-Received: by 2002:a53:bb8e:0:b0:649:ef87:5bc8 with SMTP id 956f58d0204a3-653107f6513mr221027d50.7.1776374259949;
        Thu, 16 Apr 2026 14:17:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-652e4775a27sm2728623d50.14.2026.04.16.14.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 14:17:39 -0700 (PDT)
Date: Thu, 16 Apr 2026 17:17:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] midx: state what failed correctly
Message-ID: <aeFR8qOTBGA922eY@nand.local>
References: <xmqqik9qzlv0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqik9qzlv0.fsf@gitster.g>

On Thu, Apr 16, 2026 at 01:33:23PM -0700, Junio C Hamano wrote:
> ---
>  midx.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)

The approach here seems very reasonable to me, and the implementation
matches it faithfully. I think that this makes sense to pick up, though
I suspect that there are other quality-of-life fixes that we could write
on top, e.g., to suppress duplicate "failed to load"-like messages,
which I recall having to deal with in the past.

The patch looks good to me, with one small nitpick:

> @@ -339,7 +347,7 @@ static struct multi_pack_index *load_midx_chain_fd_st(struct odb_source *source,
>  		strbuf_reset(&buf);
>  		get_split_midx_filename_ext(source, &buf,
>  					    layer.hash, MIDX_EXT_MIDX);
> -		m = load_multi_pack_index_one(source, buf.buf);
> +		m = load_multi_pack_index_one(source, buf.buf, 0);

Here you specify "missing_ok" as "0", but...

> @@ -387,7 +395,7 @@ struct multi_pack_index *load_multi_pack_index(struct odb_source *source)
>
>  	get_midx_filename(source, &midx_name);
>
> -	m = load_multi_pack_index_one(source, midx_name.buf);
> +	m = load_multi_pack_index_one(source, midx_name.buf, true);

Here you specify it as "true". Given the above I would have expected "1"
here, but I think that this hunk is preferable, and the earlier one
should use "false" instead.

Thanks,
Taylor
