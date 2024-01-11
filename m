Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE0A46AB
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 05:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="KYm/0I6F"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1704951553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=23h59niHzI1uAaVYoIyhLFhRGv/nrKbiXWUdstr81O0=;
	b=KYm/0I6FPnwdGuNj4PURd0Jq2xQp/PYwA7u5YB0oruJ3VSilc7lm6RzmDwuOJonC2AyzIU
	ntLeUf3hn1alMwI6Z6OKqT3BF2Vj6iuxShNW28fk6cDgvI+u3PA0X7MB/jH4+qQAyiWtsr
	werktY+4ZsYzy5dHb6R7iT482zj2lPmYG2yKGGl3f9al7tzN23lCLeuwEWS5rqpC6K437H
	F2qDN4c2d8xWr5dfzpeYANch2dy3Gohssj+9xpEu/IO++vDl2ULS5XX29GPHs3Kn23hNMx
	mIgnDaUnBy/84hxK18ORaoCbeH1lVQiIKkEsepU2uebXmWBKXjGQsTPPm84qYw==
Date: Thu, 11 Jan 2024 06:39:13 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Elijah Newren <newren@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [DISCUSS] Introducing Rust into the Git project
In-Reply-To: <CABPp-BH3sva=CNtx8YFGP4Egyau-hR+7njZPFEd-DRTw91BK2w@mail.gmail.com>
References: <ZZ77NQkSuiRxRDwt@nand.local>
 <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
 <CABPp-BH3sva=CNtx8YFGP4Egyau-hR+7njZPFEd-DRTw91BK2w@mail.gmail.com>
Message-ID: <f5b9a57b6e2b513f1d79a93c6f0ccf45@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-11 01:33, Elijah Newren wrote:
> On Wed, Jan 10, 2024 at 1:57 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> 
>> Thus, Git should probably follow the same approach of not converting 
>> the
>> already existing code
> 
> I disagree with this.  I saw significant performance improvements
> through converting some existing Git code to Rust.  Granted, it was
> only a small amount of code, but the performance benefits I saw
> suggested we'd see more by also doing similar conversions elsewhere.
> (Note that I kept the old C code and then conditionally compiled
> either Rust or C versions of what I was converting.)

Well, it's also possible that improving the old C code could also result 
in some performance improvements.  Thus, quite frankly, I don't see that 
as a valid argument to rewrite some existing C code in Rust.

> Further, I found a really old bug from this effort as well[1], and I
> find it extremely unlikely that I would have found that bug otherwise.
> So, converting to Rust can even improve our existing C code.
> 
>> , but frankly, I don't see what would actually be
>> the "new leafs" written in Rust.
> 
> In addition to some of the examples Junio mentioned elsewhere, I think
> new toplevel commands, like git-replay, would qualify.
> 
> 
> [1] Yeah, I really need to dig the patch out and send it in.  I'll do
> so shortly.
