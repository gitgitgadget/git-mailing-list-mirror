Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959871;
	b=rFvPiCK0vsdaI+LMXcENVM3liAbXTh9W7DHbJ2Pw/8XgmoW08saFL6nj/Eh26MxLKeyl
	 a87pTmGE2LlGj+RUVwuFdwgWk7msEmYYXSwvwQZQ0wvDHWeyQABEV7nI61Jz3c+vToenS
	 quUUbvwmjxE43VH/O1bBOO3VrsD+w2wem/v8RkSmi+4Y2nVxQEnJ9QebZzir2HmqoIkoI
	 /XM1u3bEc7RS7eKbQiCc6kL360n5oAxj3EXwfD4Q9RaKlyjNRvQO5eBmI30r5lPpQjpDn
	 tZVPSX4L50foiL7GBce36Exedb1+rd3YayB34F6nkIlnPlf+RtQT4eKQ+6SUvnP7tWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=DhoD21Bt8EroOJp9OW1jtND1BLZQr0H3poPqTJtDoNs=;
	b=0W3JGGqefcIVbGNytSGOq/f73s9GbSVEzLGNwgUwElnslKKJWbfBTThcj8dOWQNnnAO1
	 nkQUSFRneif4mCRgKj9VGp7JEjIAS3iOROWyEpdWgKE4xVuewTUziBSlN1XYZzX8ADSqs
	 ecU/UFeGZwiHC/V1VGlctCpNMc3+Wka9I1FLNAWpLdiA4Ysl+vCim1E4+WdlnzCF8x453
	 Ac/BAi4D4y5cLbQdJXsL/94G2W8qnX6YkmrXGkyyAV8Nn+QlU3YuSbxoCl7IP1dlNmznB
	 vkG+OacrWd+R8AXhC62qA3NYVcIMcHKCZeA1Uz4E1iLBaqn6TBSiUNDHOyTxqKYI5Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yM3mZQDm;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A083606A32C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 23:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A083606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yM3mZQDm
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-862a5b64755so219072a34.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 15:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794959869; x=1795564669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DhoD21Bt8EroOJp9OW1jtND1BLZQr0H3poPqTJtDoNs=;
        b=yM3mZQDm2XCLnDy26HZa8cMywdKsDHrO6HX9H8Yjx2YiKBSzVG/OupqTxTqJzIHqRR
         biAqkfizc4AeMkLFgg176H2QrknXztfhzZo0bAo3t2Ly/cjU6SOk7qSPbXsolve8pSEq
         mLzOaFMLWnN+JGlQkvLLAN1ihs190rltVfzEFhxCrv34Xy2giQHEZrRL1StcrBlu4BVt
         4BP9YNTgqUlrPZoaGLTEHn8KN8eueewkdAKkNjq1T7HAwF7h39TYBT+92B7Thk6u42fj
         PGVK449AQ8ljia4fFxyYuG6fgpsVU8wTf3OQ0CIgZH7LYShH0OB2xxFF433eOBYYU3BI
         lqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794959869; x=1795564669;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DhoD21Bt8EroOJp9OW1jtND1BLZQr0H3poPqTJtDoNs=;
        b=E6TgwZlgoriQsYO8l7kLBjRd3p6XnlypE1xAvZ2/MhfM8pD7Wj6xE81/lbB3muboBD
         qZPumw9lQLUlSL2BpFlpWHBn5ZjfVaGkpV39x2GYWSZjAv55aCSaS4L/CSd88DyYCrXc
         WC/n5mZeD1hcp4yWTgBdwdFSSn2JN59UChNVdtmmI1R//UVFQYMW3rovEP07V3DlwX3a
         o86omLxdEKuwze0dmZCR/4lZDACinTTtmRpgtYCD30mQXSALeOpd4xQIFxLk+lXVn8SL
         UVqnVvaadOFViR2I16PiQgFRSoTCYjzLxxxdQwpPPF9OqtnFPLbUQ39KcJucrmzfOKzP
         aBuw==
X-Gm-Message-State: APuU4Z+NX3YtenjG71WFixN6OetktixLXTRXCABrwZs31eBpqfbOy5dv
	lFlsRjPhumPvaoJhcmLFUg5AU1LEoxc7duSTsm+e9RAJ2z9+7JKE/ZqZRmIWVw==
X-Gm-Gg: AYBFou3a2rNrx+M2F4XzhonAgMfIVZ3QS6pqTaXxyYtRAcd2I3xEe6lm03rj0I0BPUa
	exJwpBUakf3cAsW1aUwWKjcOlRO8/W2oqphDnOqkif3zooTlNZMx3IP5DoUqHhwHDHXfltwNVAl
	Bo6+RrMLhHP8kXgHA5LUuyTgU/f64lENq7WmmeOi6OiDisNoNg5gPEyq3piW5inPD9W2NeYFXms
	XPdZAibcLYmqQEGbmlV5cx2ZN/20pgmMNBRcprnGOsvdPr/v9PVxzmS7wDztXRukgt3tfa1OjO1
	DxI1XMHsxwFpQDG3c1Hph732RYf6u79R558/E/776Oh7vBZrNQz9LkigVKglDxXYUBzNERJdur5
	gxcemCs2HEMiDo3Bjzz9WoIZ4PcjLKBRZLYRqTYcUwnJ5o1RLKhbsNCt4+YVOcP+foyQSXlSsDy
	LhG4yGg6DAAcjb/qRqEvtKekzqI0lCN9UW7ZfZ8+hGiBZ95O3p2qf/4/15PNzfKHMEE29mpPNTe
	PmpR6YhJyvb/yLTeWcOCQjlBFRWUefgGRat3pvm6+jJhPCEZ70GL6sN6h9fCeKYCBAGDFB5d2WF
	/4ScXhmiYYaK6jHg3DgoUT6Nby+tOVzmy0FCnHmBvLS6tqdy46ORgQ==
X-Received: by 2002:a05:6830:2549:b0:85d:4ed7:1caa with SMTP id 46e09a7af769-862f08cd866mr1289524a34.29.1794959869465;
        Tue, 17 Nov 2026 15:57:49 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f01381e9sm768415a34.1.2026.11.17.15.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 15:57:49 -0800 (PST)
Date: Tue, 17 Nov 2026 17:57:48 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] object-file: create ODB transaction temporary
 directory eagerly
Message-ID: <avzn-Zz5-h1haIEq@denethor>
References: <20261110002251.2007617-1-jltobler@gmail.com>
 <20261110002251.2007617-5-jltobler@gmail.com>
 <CAOLa=ZShhVC=7uYs4_CP6pUSuiYziQrbN8EbJhpqYToixPV-VA@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZShhVC=7uYs4_CP6pUSuiYziQrbN8EbJhpqYToixPV-VA@mail.gmail.com>

On 26/11/11 08:48AM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > Typically large numbers of loose objects are not expected to be written
> > into an ODB transaction so the overhead here should be marginal.
> 
> Question: why is that?

Loose objects are only written to a transaction if the number of objects
in the incoming packfile are below the unpack limit (default 100
objects) or by objects being added. Of course it is possible that a user
could add a new tree with a large number of objects for the first time
though. There real point here though is that the overhead here is per
object and small in comparison to the cost of writting the object in the
first place. In most cases, I wouldn't expect it to be noticed. I'll try
to update the message here to be a bit more clear.

-Justin
