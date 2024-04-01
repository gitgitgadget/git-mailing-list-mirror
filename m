Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CD44683
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 21:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006277; cv=none; b=JRO0J5EfJLNAry2lZ9QpZBSiXcJ1dVXWSIj9vjxckhymc4qI79cN5QnxlkTtpc0fzrAru/JZafjLkFcGhHyjcGF9NIpR5gAGi0+5F8aSUXvZW/209v84YVEeKIzvx9EUO7NDtU7shXtBH3dflXy2RQGKae4G1OoOObfoGG6UOmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006277; c=relaxed/simple;
	bh=xRuanbi5573dBe5CjI+xECVou77zCwRQdUKLrmSMH7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgXyg5BFX1oUKTzwlRb8zDk7gIqR3ZvqxEBjbSm0oWscPhIy+OyzIqOF14cldLHHxUDKiruVKq4YhMlA4cdpntCEl3VE3+bok+4mWmp5hsqKba6sRTp0Lun8q6fhgLhMuTOT5wVT0c8LC85uwrht3dsARUptzP9Bs5hm3Sri/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=atQQAF8W; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="atQQAF8W"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78be360863dso113793785a.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 14:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1712006274; x=1712611074; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4Nh4lDZmecvezO9nTLPQQ9ie+rY0shVDxL4VAYeVwNY=;
        b=atQQAF8Wr5eOorhby1259OsX3OrRFZEwY5WiZjadjQjH72biQ43fiwE36qxlyEbTYt
         fJ59kfavUHD2KzTdTmHelbHnB+2JBhzK5k2Qy5GtYErCHrYIs+zmZZrwfJJSVjrHNYeE
         vTwpZzvpBemlFlcEY/FTzZyiwwMHTaYL9p47EJtoSjgngMqg7PSHi7CTVCIHXQvziupg
         jSiwnVw/6jqQEyzFIr5fr+wt0GrZgGN7PNESNefFWu4QU4+QJ2rjPOk3zadJX66C72VW
         4GW/wsn7+LE5e5yxMoyd/8dFNZvoMZXzItfhCvFoCP5vxNRgEgxX5OW8Oe97PbTSPgrr
         o4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712006274; x=1712611074;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Nh4lDZmecvezO9nTLPQQ9ie+rY0shVDxL4VAYeVwNY=;
        b=DU7GYBNvwWCd9j4fORpw6jfxt1anpbyWGI3Zq0hPYNGaoH98MMioWX16PHnSQAeMCo
         NyB5GSK+JfIRsqtCB804C5WesxavW3PzwpKHcPOjQu+rftxVUCc3nRIgwD799v68eeIz
         B+xvmMzKAcWnM306m8twTg++vghEgTUZC9kk3MNfIbpn3RcdZxPeAmWlVgmQmNaXrn70
         Rtin22TnlXDOyiivNRBzSAptCzy5ENcBL3BUsvAyyQtaQgNuezKu5Rfiwsyw/H0V0Yi3
         2Y+r5b9DaZqcwfXB9+87IPtgPfGfG4Qfl7Gz3Mn5vwSKYLQOU7895JFL2tAFKy7zAaeL
         YLZg==
X-Gm-Message-State: AOJu0YxnweOG8lhCgxDc+2jOmHGRncG0tI0ln3LgZwQDEE+x2Y8VoBqu
	ZwvZefKCwo9CG9PM2jYHrJnWSd1/MxDe281v52xBMMooYgV1GZOeJJ8BAmumC5ptbFQTuWCREBK
	JD6Q=
X-Google-Smtp-Source: AGHT+IFDTHN9M4qCtGdr86bIGHZmr9YhVvqX/sV51lZhoOJhEvjeyNkvWv6i08kG29ACVOTiZ7hQLw==
X-Received: by 2002:ac8:7dcf:0:b0:431:4406:6f5f with SMTP id c15-20020ac87dcf000000b0043144066f5fmr21950806qte.1.1712006274635;
        Mon, 01 Apr 2024 14:17:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id hd17-20020a05622a299100b0042f04e421d2sm4908484qtb.24.2024.04.01.14.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 14:17:54 -0700 (PDT)
Date: Mon, 1 Apr 2024 17:17:53 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <junio@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2024, #01; Mon, 1)
Message-ID: <Zgskgeg6kXJsb3/c@nand.local>
References: <xmqq4jckaoid.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4jckaoid.fsf@gitster.g>

Hi Junio,

Thanks as always for preparing these. I have comments on the two topics
with my name on them below, but I wanted to make sure that the series at
<cover.1711387439.git.me@ttaylorr.com> is on your radar.

This is the one to move writing-related functions from 'midx.c' into a
new 'midx-write.c'.

I just sent a reroll here <cover.1712006190.git.me@ttaylorr.com>, which
is based on René's patch as well as incorporates feedback from your and
Peff's review of the first round.

On Mon, Apr 01, 2024 at 12:09:30PM -0700, Junio C Hamano wrote:
> * tb/pseudo-merge-reachability-bitmap (2024-03-20) 24 commits
>
>  The pack-bitmap machinery learned to write pseudo-merge bitmaps,
>  which act as imaginary octopus merges covering un-bitmapped
>  reference tips. This enhances bitmap coverage, and thus,
>  performance, for repositories with many references using bitmaps.
>
>  Expecting a reroll.
>  cf. <ZfyxCLpjbaScIdWA@nand.local>
>  source: <cover.1710972293.git.me@ttaylorr.com>

Thanks updating the description. I am waiting to reroll until after it
has received a little bit of review on the technical front.

> * tb/path-filter-fix (2024-01-31) 16 commits
>
>  The Bloom filter used for path limited history traversal was broken
>  on systems whose "char" is unsigned; update the implementation and
>  bump the format version to 2.
>
>  Waiting for a final ack?
>  cf. <ZcFjkfbsBfk7JQIH@nand.local>
>  source: <cover.1706741516.git.me@ttaylorr.com>

I am not sure what to do with this topic... I haven't heard from
Jonathan Tan in a while, and the same from SZEDER Gábor, who was also
reviewing it.

I personally think that the topic is in good shape and ready to go, but
I would rather get a concurring opinion from some other reviewers before
suggesting that it be merged.

Thanks,
Taylor
