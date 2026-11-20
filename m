Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197537;
	b=q8u4LFZkMaOO+FBW+OaOZlLMM+0ZhCObpn6iBuNcPIWVApecqAt8Sogig1927KwydmP4
	 vumlv+3L0Rs2Y4A3Fwrj6RkdDljEBHBEJ08fgmmErhfzAlaqzidYYz0aiyGpsMF7nvpmW
	 Im8mW8rvTGnag495gDnoH/3j/bzguKlIYaH1ITDnueHl7eIgTfnQPKbN9r9xWN5eL5DHQ
	 aBHCNuJyf01AzhTxAN9HiaZCIAZsccud/twpkqr71W/dHTFfZcUgA+NMCKus9Y14HWeek
	 7/R5dTa51mLf6goxlg318HERPN9I62WIISDUMsijHzikMRZb65RPF8yPSYZ8jKk4ZQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197537;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=w6fE/pceAsFaHmAklHfmlz8R9rI/ZjMsT2JPSCNoe7k=;
	b=kqY5nUDoM9IjfqGgEUblhMRABd6azsRYwCBd9L84r0eZHJBbkPGn69uFPM3XiCM2kikN
	 /BbMPWOcM+CIk4Uy4TZXZNQQ1NJvoRzgOb+CcGcy+LCE3RInd/OZJPumLMrAV3L0tASwj
	 uS6A4QdpFAkvynLeEL4CIS1/d3/3gX41y180h+Aoi+jNg5nKeVJS977d3JW7ZGS06NiEQ
	 LKniw3hVewYXkV78aH8EVx4oOLdF9v6u9wxKy/5TLWu/PGNAWUO9mGLM43NBltudM0XUi
	 1i/qoG18zEItXQYFievJnk1p8OPIbgDCHR/NPXb8I2X90fKucsz8z43zxgsMt0o9atQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=gxxC2zXz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Kw6hpL5X;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A08560A2608
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 17:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A08560A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=gxxC2zXz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Kw6hpL5X
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 35861EC09D4
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 12:58:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 20 Nov 2026 12:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795197536; x=1795283936; bh=w6fE/pceAs
	FaHmAklHfmlz8R9rI/ZjMsT2JPSCNoe7k=; b=gxxC2zXzAnUw83mXouDlarl9fG
	Xy8lGvDBKryMr2YBYMqbZsbmixW2cul2GFRnOOo7+EgZcF1iWJt87Ijfn124t8aK
	obOJhBa2HDiBqMXdkoejjNbei2Dz0TMwpSGDxvBh+A8dad/glL72BHdqFDbn8dN5
	TUfeWa8BiCUFLOr7w/vJ97OANo28iJ9WCcQDiS+LnUJx62q/ohv5R6oleNbhacW3
	JDTmk+wA13hapEwAMNEb0XxBtw9jdB6kOq8fvSjd5c24BiZO4UzH2zF7kSp2pI7z
	WtCRknXk+xv+dCOlS4Q6FFDijC2mWie1lXP3UVRnxMFN8mBLysnbaEUQpYhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795197536; x=1795283936; bh=w6fE/pceAsFaHmAklHfmlz8R9rI/ZjMsT2J
	PSCNoe7k=; b=Kw6hpL5XQ3xy4ErW2qg23L0ph7WsfOmROEFYR54w6biWh9icpd7
	Gx8X2wAfd7c6m8JdPYMdVyBa6aRtjyZ6Ntc3uJ9P0ogllhexLeb2cKNrlQOSSseJ
	BZbLL0cIhJO/jw/7JFvbnuiv8DHshKxKx9hAn8kU73BLYwfYNHN9sBnJBbnHmT6L
	UhB++FDAUzrac18kbFH7nW66pPQFh5SLDZbc3TeriHjyD0dIhJrhR2ckKHguW/Z0
	HXSXPkbLrbJJ08b8ukkiyAVnI4LvpigCcR3u75a+9ks4ba3oC8QLq66ONSXpiaMc
	G4sCV6O2PPYyLzM5fgrYfttgoqbc0GmE/RA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795197536; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IZHMKw1sHiRXjQj20wpsTDFV2MHZJU/aUl1MA0mif6UbikC
	9vMt+jOs1FpC02eR4YVLs5PlG9NrJl2ultNYTT/0QHiemGO8pRFp2DVfNpOGdhZB
	Bf188FfNPBQPGj3GQtpSap8BQ7ynlyXW12MSA1q6mO3z8cWNVmI3MA43GcupkTx6
	hOWAYToX3qvWfpXug2XshJ8yJsJBV8zlkkCmD+Y2t/B3yWpTAO7IUtSc36kuRcDv
	Z7/9N+1MxU0G6Znyb4dEFlUNNwVFw13WqLz8pmxRRH7IWuKGhlg1qCP4S93Zv/Bg
	oE2Kt4IxucG1fRGdWBirpU20zvzSCILfndcNwzA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:y5OFnD/ZH1TC8tveEnrovqpi1HsBwomW1CJe6InyHeE=:zzzjlnCdYV8adbfViDJPhT9O6HALSokmvSAxJPa8gW8=;
X-ME-Sender: <xms:YIoAa6mScv_IjKifseFD16EUtMaQqYaitx3eCC1p96P5e4pOVs3qQw>
    <xme:YIoAa5Q_KieJrz8VbmOfz9RenpcFweY6c57Sa74bZvBOhCOHj4Y1HBGfueMXWB4hC
    cbOOyf_REQHBF8PLBk7JRX_QjCBqY4JtYyAqC6UTgKexT1f5EP2p1I>
X-ME-Received: <xmr:YIoAa2ASCsuJfOWP3wXaKNjrQ1YvCP30mbiRzfQe4wV1Ky7Cvq6pSu_Obukb5ezKSNgdvslfTog20vzhH7rFh4JHjILwkrj-7pOc>
X-ME-Proxy-Cause: dmFkZTE0RcdBK+JRBkB82PxsrNJpFDepxuDl1Vf1cVKq0HynOlqSKm9PsEqONfktcClvbF
    XE5pcFSrYp8RkZbN/IwACW+CJnqbdUVaTB4RammtjCEatTZLa+MTP53eP2YQF95DmW2ZEn
    XOYy1mc1qhHDvrA0JCc868o/QPnmRWTRvsocuA8EHuRPNlGGpD99ZVDq8UWAP3wkmhc3hx
    7H5xVuGIp1UTeq1guD/kLXyCgv2UaX939uU3ca6wJuiyALbtaoc3BxP3RIK82kayCEUl/C
    YCSgItTXanzbfBmtcnB4YGAID1kcnXwtM1f/0E5mGaMCXd/IR7G4xYAfOR+6ujl3aVx+Ms
    Hbk/sZbNHZO1Z3iTQz/YtWMCsAqwHi8+EwpTR3bJUKB/U7+KloN+XgvnR6MbPYFYJEM7Zk
    wz+UjqAE4ImEObGqAGo4dVxuFMbRiH2ITNjcj22GeLE3jVX54Zff4XM0HR5eSt9ezZ6kov
    1BBspphyYWLNOUZbupyvIysYwzs/P98t7Gwtgn81g5ckeNfRkUGPbFbvLnRH1UB91wifRv
    XWBXPEC4g21dJafj6m09OxfPJxX6T70V8RLI+Ti/Kg/Q9i74oxB/sfWYyGxKvfLz3Zyp8j
    v4o4hVnKi5JlBSNQGX4+Kf3AD+m2uSTnFH8ErzeRGxAxxwwzRw40aiBC3qCQ
X-ME-Proxy: <xmx:YIoAa4SWFplguNK22j6Ofcm_jpGAOCMrvEQNc_qy1dJheUFICfFr9g>
    <xmx:YIoAa8op6h0dMzozkFqI2YR1cW6-DHxK18FH2_FKMQCyNiPl1RRp1g>
    <xmx:YIoAayzICNusUzMwjXKLMBcJq-Z6COczbhPV3OxFG5qiHP6bWg9qoA>
    <xmx:YIoAa5LM90QZ_BPLNs4049sySf-0iAqQ2FoXcYxHgWtEQRcOt-Q7TQ>
    <xmx:YIoAa9Sqtxj7z1IsGe_d5F-Oun4xZGqW9iojfSjeHenkJ3ACILkZrI61>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 12:58:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] doc: wrap emailed text to a maximum of 72 columns
In-Reply-To: <20261120110215.42209-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Fri, 20 Nov 2026 12:02:15 +0100")
References: <20261120055908.83043-1-okhuomonajayi54@gmail.com>
	<20261120110215.42209-1-okhuomonajayi54@gmail.com>
Date: Fri, 20 Nov 2026 09:58:54 -0800
Message-ID: <xmqqmrr3qt9d.fsf@gitster.g>
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

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> CodingGuidelines, SubmittingPatches, and ReviewingGuidelines do
> not say how long an emailed line should be.

This initial observation of the status quo is given clearly, which
makes an easy introduction for readers to the issue you are
addressing.

> State the limit in
> each: wrap the text to a maximum of 72 columns, matching the
> commit message convention, so it still fits on an 80-column
> terminal after a few levels of quoting.

The above says what we do and why we do so.  In a proposed log
message, the latter is more important.

> Leave a blank line
> between paragraphs. A block of quoted text counts as a paragraph.

Contrasted with the above, this lacks the "why", and is written with
a funny verb.  "State the limit..." was an instruction to the
imaginary person who is making the change to our sources, which is
the "imperative mood" convention our SubmittingPatches specifies.
But "Leave a blank line" is an instruction that the imaginary person
is adding.  You need to tell that person to tell our readers to do
so.  Something like

    Tell readers to leave a blank line between paragraphs.

In order to properly give the "why", we'd need to go back to the
initial observation and say that these three documents do not say
that there should be paragraph breaks for readability.

    Side note: if your convention is "each single long line is a
    paragraph", then there is no need for a paragraph break.  That
    seems to be the common format LLMs produce.

    But our convention is "lines in a paragraph are limited to a
    comfortable length of 72 columns, and the beginning of a new
    paragraph is signaled by a blank line".  In other words, line
    length limits and paragraph breaks go hand in hand.

> + - E-mailed text, including a patch message and a review reply, is
> +   wrapped to a maximum of 72 columns, matching the commit message

The phrase "patch message" is not used elsewhere in Documentation/.
We use phrases like "log message", "commit message", and "cover
letter".  We do not want to use the word "patch" here to avoid
giving a misleading hint to line-wrap diff lines in a patch ;-)

    - E-mailed text intended for human-to-human communication, like
      log messages, explanations in cover letters, review comments
      and their responses, is wrapped to ...

> diff --git a/Documentation/ReviewingGuidelines.adoc b/Documentation/ReviewingGuidelines.adoc
>  
> +- Wrap a review reply to a maximum of 72 columns, matching the commit
> +  message convention, so it still fits on an 80-column terminal after
> +  being quoted a few times. Leave a blank line between paragraphs. A
> +  block of quoted text counts as a paragraph, so leave a blank line
> +  before and after it.

"before and after it, too."?  I personally do not see a need to
specifically say ">" quoted text and what you write in response
to that quoted part are different paragraph, but some people may
need to be told, I guess.

Thanks.
