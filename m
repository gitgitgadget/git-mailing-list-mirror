Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA491FC0E8
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741123925; cv=none; b=eQ+65jYqBP72L1FA1ZJ1y+So8mmK0NdQsmiFjNuqUkDgl8KIcR2cwk14uvt4NI4xfayoCtLBKtBGoLsfLALb9BbUJpK+RxjcmskOrNa/IWJNKs6OESgh6yjxEpCbrXExPQ2SRRxgQFcOHUS9uYNn9gR8oPp7j/xULyvmsA0sEGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741123925; c=relaxed/simple;
	bh=oQ2HHvTciYlcpRKZ3aGWSMioxrBaYS8GbnG4ES5xT9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFC8Nh+TBGuDL8lxwTDtAlmeV8kiVOaIN2e3zFpq+mn9AWTJEORAu54E+9811nEIpQ9S4laq8RRVv077Q8yPSj6CPw6ftgDgks/qWpAcciXGtVHzNSsTlUSbpVUqxIhwhtYIM5BLyX01gMIDWklgQuwqMY64lR0cLfBzyl5lc9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=J4qSpeeG; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="J4qSpeeG"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6fb95249855so53305987b3.2
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 13:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741123923; x=1741728723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tkJfIS9w0UlT2ujBFkHPpX3eNH9jWP0caTsheeVvMMA=;
        b=J4qSpeeGnQX2PVkzVToKBgZxROvdRStVgtWm5P5my9AUhEtKYHqssh8pcQYyOeq9s3
         1cXAcd2xWGzUXUzabRbSvdW606+cw22v9eevCAVlGp39Yzk31cjAhZFXba/tv4aZHLBR
         fzCeUDceELA+auMc/XAdDxFSSDWWo1uOxIyMkvqhX8Zkl1wx9KwQSNQteJqbV4rKR+Rj
         JRPIsa1jlvHjwP2vcngvkawvSnGB5XP1/XGVKWdjuL5Rz0MOdt0vUIi1RKLhLUSdAJc6
         veZdUjzC9pZlO9vMtTe+oDponnxdABdYEzSo92MHOUC/r6XNNmeIeDCxUnG3wscIXBej
         kskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741123923; x=1741728723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkJfIS9w0UlT2ujBFkHPpX3eNH9jWP0caTsheeVvMMA=;
        b=b1wJKOnQRsk6zUeLfO3E5MdqN2cz6LiMWbNc1VXLeh4zHVMtWQat7+QBb0Ta2AKU2l
         bbgh6KyaRk4+wX64R1kD+ZnIAbnTxodv39VPtSUl2ynXnoo5IEj4Tqg5fO5NxyTG5Sr1
         llYDhDx/4KKNU5QnX3veeGG6AKITOoQ8ob6v0MSbrIi6oMpZ+hxtrrA9AooNYvyL2wds
         okxt6Ehayu7eGTTIzEO0EQusz9I7LU4DRe+KjvUJYf3bZa1JwoICFbpaKqteLJfenadQ
         o9Vwk+POO9HHXTfuvLYBSjt5aeETVzR3Vm7AcrFpZxbjgHEuyCrm3MgCz1xpxebM4HYs
         daXQ==
X-Gm-Message-State: AOJu0Ywrj63lrAq5G1RsjSEjJv96WmFqRWP8kOktz7Wbe6O/NWkLAVRT
	wXIwN6+M6mm7toitNhz1P8UALlsBWrK6MGdFdOnMaISw3N+m7VaG3P+tYJcc9yFYC8pGEL2cbDf
	1
X-Gm-Gg: ASbGncsixF0j0BKm1tqVHlAgV004Iv7VbI59SWs/7+YZj9jFGC/6D1QG0TBH+xO3R4G
	O0OcB3kXGPTiEsYHwNP87/nSRnhxq5FR8+UbESFsW+voDFiYfLl/eThMB1tNwpdvTw1Wv5qgE7F
	flf4NqF0YWPwUK5O61XGlG9Q2YrS41EaU8tJG0BydJTiSRiuGrcu/V96KokziXJdQgnbJ70y95j
	+B1srO0kFOGL4uY0FD51EZKtIynfHtGmtgAwYc2d8afMfH3/Jkv2fHjk4ipkX30+OTanJWxofpk
	ADJar6EncaM6FpAh+1PeOzXOcpq4/gYmpdjyOpcGOhWMQAJQuHwH7PUQ/qDwPktlne5OWtbCos1
	hW1cOU17XPKT0XsXq
X-Google-Smtp-Source: AGHT+IHOlZsZC52vFlH8q8dYH9QDTKOFPJbX+M5PEwvZ5ZWM2kyF+XczmsnT81+N8gPRPWm5beBM8g==
X-Received: by 2002:a05:690c:708d:b0:6f5:2793:2897 with SMTP id 00721157ae682-6fda3094903mr12137267b3.30.1741123922778;
        Tue, 04 Mar 2025 13:32:02 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3cbc5ac9sm26369057b3.121.2025.03.04.13.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 13:32:02 -0800 (PST)
Date: Tue, 4 Mar 2025 16:32:01 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/10] unpack_loose_rest(): rewrite return handling for
 clarity
Message-ID: <Z8dxUc1rUeOp13Pb@nand.local>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
 <20250225063421.GJ1293961@coredump.intra.peff.net>
 <Z8EFGnUmyAAJ6DUY@nand.local>
 <20250304071011.GB1283943@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304071011.GB1283943@coredump.intra.peff.net>

On Tue, Mar 04, 2025 at 02:10:11AM -0500, Jeff King wrote:
> On Thu, Feb 27, 2025 at 07:36:42PM -0500, Taylor Blau wrote:
>
> > On Tue, Feb 25, 2025 at 01:34:21AM -0500, Jeff King wrote:
> > > This should make the logic a bit easier to follow. It does mean
> > > duplicating the buf cleanup for errors, but it's a single line.
> >
> > At least to my eyes, I actually prefer the state after 9/10 and would
> > probably be OK to see this patch get dropped. I wish I had a compelling
> > reason *why* I felt that way, but I think it may too subjective.
> >
> > I don't feel strongly about it either way, though.
>
> I also don't have a super strong feeling, though I fall on the other
> side of the line (which is why I bothered sending the patch).
>
> If we didn't do that, I think the alternative is probably a comment
> like:
>
>   if (error1)
> 	error(describe error1);
>   else if (error2)
> 	error(describe error2);
>   else
> 	return buf;
>
>   /* if we didn't return above, we saw some error */
>   free(buf);
>   return NULL;
>
> I dunno. I'd probably stick with what I send. ;)

Fair enough ;-).

Thanks,
Taylor
