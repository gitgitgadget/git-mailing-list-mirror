Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902172;
	b=eKz3bU28CFGVlY+6W2rGFh7utgnWArpxFRCTaMrMIK60n6gxqv7Fn3DldXqK5xQjc0Vj
	 JyeRwxtn5XRn85yN+sfsl5lWd1BHMsUgFQgabfQxhOXumUpb2wXPhYg2SEjm/B2IUe6LQ
	 OzdllezeeFeb27t0p+SABsYAhCkt9A2vtOHQyhnw2COKSGmHuCDkugY8bS9jAZ6OHlpiC
	 naUowAizk+0rrdEilea4W21RXTpEttK3WupmhphkIyZ57fvdSSn1Wt+Nu/9HEkgWEktat
	 0XiXCOrMVWZc/lzhV1Ar86rlO1RR3Ye6p9s8VBeUuv7IxvS0tTiz+CqPR+mseDNAorw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Tm5VVqaRW+jmLKOHYWeKyi3/Or1w46oB/61PV4G65Cg=;
	b=Z6TMP1R+cfonDNSXkLsM4fjIalwSugA/e1zX30nGs/ntI6kU7D4xq/52Ng22gUsBKCpx
	 /xp7Nmk9vmXlintekzmt2YLvdkFaUKYZWAjvkvIFLex9qthb9a9R0QAjDc7RzyPePQwUZ
	 23pRuRl8SQDT65sPiI9+q1Vg8E6sxdKSlhNlj3kPad4vzzucyyBWrYxrdZLvojtK88SNH
	 8k2vOn+juQ/0gki+Osdo/kQIqot5psTTss65SZWqZ+qJZhQYhoWySMa9ZCJMsDiTESFKg
	 o10WKYaz+JWnfkMWknVM+LPP6Aw5Lu/0QdRnciE+Yc+kgVuXniTtjGoEKcXspX/uU1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yRSEXdbx;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA92606A32C
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 18:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EA92606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yRSEXdbx
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-8446af403b5so1308172a34.2
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 10:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793902171; x=1794506971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tm5VVqaRW+jmLKOHYWeKyi3/Or1w46oB/61PV4G65Cg=;
        b=yRSEXdbxhAxNZjaoeGSqUwi2VjZRfk5cbMpDaOeGV9LDX+8TaUHzy/L0eytNMVpcr5
         UiBObkGRIoOSFOX6npDwvXg2jSTkethpkA+G7PbxAItsgg2V62IVxoPO6tsENvldoW7A
         MgDiSiI93PgiaMNyrt5y2bMfTa2T06B6MnmvGx+mPa1ZV5SKeiUFkSiwsY/URobMplBz
         5vJsFeqoq4/fNv+khSzBtBdlnxGnBUGI/zOaIJlLSWIRfYlin5YV1/Wk/eBwCq9AypML
         1UUqwSX/rN5MewxRzY6+rR6FYw1YH3temuSaS9HzwIXqYfZz0xHTLADBPcZyj4OXmdZM
         uwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793902171; x=1794506971;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tm5VVqaRW+jmLKOHYWeKyi3/Or1w46oB/61PV4G65Cg=;
        b=bKLdiZTwqMK1FAEQzoJTSgbbtDvlL+dN32XR3nNe0rhx9N8rFDxSHBBz4YukxOAum9
         sdN1rb0V5kfn5clINvlvqvH1/bsBlu2zi0+SQbxHTXdSjqDF4KUWpDPjabWTrUj0vQ8i
         OexnXcPill9vlUdbxrEPJRfm3IY56/UXaDa8pwQo7JU1k0/Zi7AJr9K6Zh+GEn+X6fLq
         fPBS/43iIjfutQdPfd1ECLlgnyERDam2RqBhlJjjhzSa/XYkks5cxvj5BBoLpqXVYwsf
         nOrQHNJCd/MLCJq8hceC9t70ekZ6+tDsUbsG7XNK8kJ1OXXopfYDTDdsZ1ImJRIq0EfB
         +61w==
X-Gm-Message-State: APuU4Z+DN5xrMRalBqw9S2Cw7Hg6kf9U6gEg3z1XHqBG7CHtygjaDJJq
	xVk42hJUuFxdQFQ4bsz98t/0wlMrxvug5zfFgAAPDa/VgvOgy2I9/WrI9le/CQ==
X-Gm-Gg: AYBFou0GNDYxG34sbOmfhl3eeuBoU2siqYuqytV/x7p2wfNSgCgefGARiZu28ASDD/j
	ogpAbsAyxIV8qEKkGfCv2ZVWbbV5+aKu25g+/i7g2YQgTSkYXobfu8rQSWyfFZ1u8tVusD4plFF
	Ysp8rsUxH7JVMWKOu+3jp2CRXmB2LxvkvIk9ammyZOMO6zL6rdLgdeEmt07NP0UQcpsCZeZ8i1F
	zK1Ix2aiKz3lTFYjSgJLxKo+AAgMGzrgEnsapjbaw+2gl3Iftql91AQxrXi8XG+D5COvB6AXeQr
	jj18DFn82EQ1S8QAQWQwyWGOdDAG1JabCD7BvlRZqwth3z78KkoYBI+2YnVmVZdnGW/xxBZK5wD
	aEHjDnE7EfnllgMNkyH9778qgfZIwh8cUF9jhuJ71X9h2b55GlCvBEBWL1D23Y62XEPE98meLHo
	mwlHaJHiWYpquXbH9JC0day5LRY/BTwzYSi911tCIttCrUX8TdG1fxL/zw7hASV5qZoE4J3RiR1
	bnNJe6SMPJI56assZFgQ7WG/hL+vKyFBtHLXazVO7/+vcQLcCnOhxi6XLCXColMTPjU3QA1N2OJ
	xzdYvV654hZb/F1yz8P0pb7avDWe57zcVuYFAUhuU7vrlFW7rq+H7g==
X-Received: by 2002:a05:6830:7182:b0:85e:f82d:4389 with SMTP id 46e09a7af769-85f1d001fdemr136705a34.14.1793902171070;
        Thu, 05 Nov 2026 10:09:31 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e1f2f0sm5121575a34.17.2026.11.05.10.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:09:29 -0800 (PST)
Date: Thu, 5 Nov 2026 12:09:29 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] object-file: return error on index-pack abnormal exit
Message-ID: <auzFvIgWuUzFgvvh@denethor>
References: <20261103212410.1389988-1-jltobler@gmail.com>
 <20261103212410.1389988-3-jltobler@gmail.com>
 <xmqq8q38yz5i.fsf@gitster.g>
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
In-Reply-To: <xmqq8q38yz5i.fsf@gitster.g>

On 26/11/04 03:06PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> > -		if (ret) {
> > +		if (report_err) {
> >  			strbuf_addstr(err_msg, "index-pack failed to report pack name");
> > +			ret = -1;
> >  			goto out;
> >  		}
> 
> I guess this also does not change a behaviour?  We used to relay the
> error status returned by read_index_pack_report(), but now we force
> the error code to an explicit -1.

That is correct, there is no behavior change here. The main change is
that `finish_command()` properly reports its error and is not
overwritten by `read_index_pack_report()`.

[snip]
> 
> Will queue.  Thanks.

Thanks for the review,
-Justin
