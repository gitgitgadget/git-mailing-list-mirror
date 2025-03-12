Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B170810
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741815489; cv=none; b=qBtBx2ooEUt2PspOR+wHFTqY1+kwEMb6m0mHas8AyHLnBl7QYAJIpyIrqi+j25XtEbNhkMinDo7m9JVGEXRe4LJZNj2N+5a3Vrhw7gkAneaxf4Q22tlG3OOM5O0XbDQHJvwpX8ibVuQg2X2ToO++GjNSGF+PmO67gM6Y06lsRV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741815489; c=relaxed/simple;
	bh=7zsKhNps1FMmUeR/PcGdJTFil0oJQ/mjkXwbAVpfXlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljFobAkpSnqKyG5fmUHWYtda12EKUpMoNc3BnISKC5WesFxVPJh+hMIlSacHXh1MPFZyJXOwSvor6DQ2xFTZ2JMT4HfHTnK4TWtsQBQgUYUfdYK+jGtFrXwLEbNpQfvERbvWplDBEZ8k5c37zW/Y1wFn07DNWm33at1A/zRscZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=toTP02jT; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="toTP02jT"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso270095276.3
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741815487; x=1742420287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ruDACtn+200w8Pl6lj/7nRC37498S3Aq+NdSquipztA=;
        b=toTP02jT0OOh1csX8oiJiV7DlUARMnO2VjxwbGMppWZ5ghxxs9sJxCQ/qQYku3xOnC
         uKn1X/pij1eO5Y+U38bD0HFQPYH3Ege9c/Rc4tVyMeuwVWCohGJT65v3Lf/v+4/85KAL
         1sqEKc/UErqHbDTdxaD80yF47y2FPV8JYm4YKaI0g7CrSPKlebJS4Ub/rd3s5KNT+MDZ
         n3kaV4pdcqHVkWttTlr44ZfOHLtU+33QexxZcNU5vW6J6Pt/1cu5q+yRZXzEtEDFyIjU
         WtQT83oO8+L6WNWcoVwrrYZ1AhkOEZ2dia57+/H1jx6v1ChThhOo1eRcQEF/2jkX4yIf
         W02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741815487; x=1742420287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruDACtn+200w8Pl6lj/7nRC37498S3Aq+NdSquipztA=;
        b=N+wa5pqi2RdKjm6TnTuKiySODiuVCW0g9v8zCkW6GT7SH7sxSBZ+KHrqyFvV/XqZ8M
         MwJm2cs00hWZodXZDMbMCoJ7QkxS3HaXk3Cwckzz5QObgcvCgd1i/S2kL9WXUyFp378H
         PXTxHf4XBvWvfJWgTngTxqWSsIjbiMmfcNHMLGAjR5IDA8ew6hnemNjeR/QC3483VC9O
         XZJxPfSIvpFwDpXvZNdjS3/aGCttEkpzv0NlMosb4/+V7bcf9MheZEniFMCXmAvxLbgp
         CHLgQ30SvJLm4yOClX7NPp0sFkmtZC6D0cZVaA6lY2mvENgufeOSncj0efgT5wvsuzlP
         /NHg==
X-Gm-Message-State: AOJu0Yx8eFFbCtwUMoNw2y4eCrKjO3xmtB4PMBgRR1/XnTg7uc/w7elF
	UVQMymJP8i2+fjbhbj+RjxUInYeuwfgPyYJ4s2zjCtFkPkWmtsaruOr1GlRlBFY=
X-Gm-Gg: ASbGncvxkZIDJsSt0AnocT2u/9+ArMDXJN/+0Qdkvt63lcByxOTCAFLgPMi83yu7U0I
	je3Biq6rU1Tz6WGKUVMnNWa0drf4h9oC3oHolxDJRLLw12Adeki8GEvCkAiirUdNqIHn3+EdOQR
	KoE7BpU35Qy/VurCMBfHe6BpeuKJZ+Hq3xDsMLtrNeWQCkX8uN06mhSqZz78PO+uC98sZvgizji
	mE620JC7DxETQGz8Wb7CQb8JZ35+6PbPW2AAgpuv34/iOMALzq6LJxqQavb9Xe9R5yWDeqTZ3i3
	5Id/KD97hRHn2DMf72jQ6s71omvqRQlhiKSqh1c8g7UnP8CPujys04oTLq32fnrN1g3jl3lzkBD
	9+Ic5kikCdZKAWcKb
X-Google-Smtp-Source: AGHT+IF7uVAhedFtDgA23QmAQAqKr5TdZ5k95PNe+JscOK8P/uUcpnWj6Yd8UilrWC+iruWh0LAVKQ==
X-Received: by 2002:a05:6902:2702:b0:e5d:b671:8fce with SMTP id 3f1490d57ef6-e635c144d83mr32460335276.12.1741815486879;
        Wed, 12 Mar 2025 14:38:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e634b8e8ff1sm3537438276.40.2025.03.12.14.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:38:06 -0700 (PDT)
Date: Wed, 12 Mar 2025 17:38:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 5/9] refspec_ref_prefixes(): clean up refspec_item logic
Message-ID: <Z9H+vWHFkATWNLxt@nand.local>
References: <20250309030101.GA2334064@coredump.intra.peff.net>
 <20250309030706.GE2334191@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309030706.GE2334191@coredump.intra.peff.net>

On Sat, Mar 08, 2025 at 10:07:06PM -0500, Jeff King wrote:
> The point of refspec_ref_prefixes() is to look over the set of refspecs
> and set up an appropriate list of "ref-prefix" strings to send to the
> server.

While we're cleaning things up, I wonder if it is worth (slightly)
renaming this function to something more descriptive, like:

    refspecs_to_ref_prefixes()

, where we pluralize "refspec" and add "to" to make it clear that we're
converting from one to the other.

> Of course this is all completely academic. We have still not implemented
> a v2 push protocol, so even though we do call this function for pushes,
> we'd never actually send these ref-prefix lines.
>
> However, given the effort I spent to figure out what was going on here,
> and the overlapping exact_sha1 checks, I'd like to rewrite this to
> preemptively fix the bug, and hopefully make it less confusing.

All makes sense.

> This splits the "if" at the top-level into fetch vs push, and then each
> handles exact_sha1 appropriately itself. The check for negative refspecs
> remains outside of either (there is no protocol support for them, so we
> never send them to the server, but rather use them only to reduce the
> advertisement we receive).
>
> The resulting behavior should be identical for fetches, but hopefully
> sets us up better for a potential future v2 push.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This could be dropped without affecting the rest of the series if it's
> too churn-y.
>
>  refspec.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/refspec.c b/refspec.c
> index 4cb80b5208..c6ad515f04 100644
> --- a/refspec.c
> +++ b/refspec.c
> @@ -246,14 +246,24 @@ void refspec_ref_prefixes(const struct refspec *rs,
>  		const struct refspec_item *item = &rs->items[i];
>  		const char *prefix = NULL;
>
> -		if (item->exact_sha1 || item->negative)
> +		if (item->negative)
>  			continue;
> -		if (rs->fetch == REFSPEC_FETCH)
> -			prefix = item->src;
> -		else if (item->dst)
> -			prefix = item->dst;
> -		else if (item->src && !item->exact_sha1)
> +
> +		if (rs->fetch == REFSPEC_FETCH) {

Do you think it'd be worth handling rs->fetch in a switch/case block? At
least that would allow us to catch unknown values more easily, though it
seems unlikely we'd ever add any :-).

> +			if (item->exact_sha1)
> +				continue;
>  			prefix = item->src;
> +		} else {
> +			/*
> +			 * Pushes can have an explicit destination like
> +			 * "foo:bar", or can implicitly use the src for both
> +			 * ("foo" is the same as "foo:foo").
> +			 */
> +			if (item->dst)
> +				prefix = item->dst;
> +			else if (item->src && !item->exact_sha1)
> +				prefix = item->src;
> +		}

All makes sense.

Thanks,
Taylor
