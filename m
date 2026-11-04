Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811495;
	b=BefGluJeGXVeif4jOewWZFgFttLZTWcR42QvzgFQk+iF70Dom2OoFyAtKbPpDRG+vU7V
	 Hmy+cbBkTt7SSXng3ejSLZW6Moxy+y844MZJTtDV6svuMJFAgABOEKy3nzGxPGX75m4J3
	 dxRKsHxgnGnoLmu8yDLyrMgmrdV9PgPtp1rVxkUJ0VzaQVBKv69a25WFsYJtNZdRsbY8h
	 OmWVxWBop5xT1IPX3A4tF7ZKe2a1K9rHylNw9PuYaNLEg4OsQRjFP7clKBRZYWBfKRcDn
	 2WnQbKsLyco0GOOWco/NZwzclxB3i+RRixP+8LBuN6dwuKjlTm+J509JJjhRQA276yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Q/vumjcKm51Kb9fat97KJmMi5KScFNVPCPrEO5fnbn0=;
	b=BP3DBf36FPFMaUBNnr5UgL+wYiVL4iO/LE6Y4jQ0MFWeHQV2zr8H1LgXVUQtdqiv7DmT
	 zhmOXDZR2yRtBWCbF3vWMFozTDEMuGOOi+RGYSrShhUFAMjf9Q0hJx2iBuKwn4ee/EfK2
	 a5YoOJ6vFQQtlC7R/rNbfoI8gB7qOr0broTLk5xz2hRDz9nudUfnnuwnpgyVigdchpDsF
	 yZsv9ciA9W2GwdgvOFijWHB7xqNO00w/7OqxAPfIR0nUJUk/NlS8Q7ubtsUvKXTF3dhn/
	 NNqmXjblwSvOPWVxvzA/bCCVLi4UXUoEPvR+odZta3K6TEe4SZfbhO/ApsNkBUeDLZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N8b91Gdy;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88688606A32D
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 16:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88688606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N8b91Gdy
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8439fe796ebso512659a34.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 08:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811494; x=1794416294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q/vumjcKm51Kb9fat97KJmMi5KScFNVPCPrEO5fnbn0=;
        b=N8b91GdyxZ8zwuALZJZ4GZabpfiFkQb3VUkmECtk7jVslmIgNOGfxxnGlF3jc2JteH
         NOKRMvzgwTzkCoOXSKlFJx7xnVP0dYxi7YyAqacefkFQ3oeqdaWs7jEOF6eJFy/fmTph
         Q2Oq/Ea6Vp+IIiwMcth4jM3hQEdWTKWuypFennPb56WezRv0q7jLYD111snwiHb+tKxY
         IaiqIxhrg7IUzuYn6btpcXPxNMKEED86rQA0T8pb/b5pmCQPFXBw2SnvKE9SCPRHeDQL
         EvCQaFjoHORBE/gqk28ctoze6/YOk9dklk/y7R6CKE+ii6ykkhNhBOyKcxPNUz6xa0sJ
         Fk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811494; x=1794416294;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q/vumjcKm51Kb9fat97KJmMi5KScFNVPCPrEO5fnbn0=;
        b=EnuGr4De3oSeHGSYOqDhO8Y7gCH6hN/4NbPSqPbYmlwP2Zd4Gyz65lm7CXso6DXSwr
         q3n6r2uzhIx9SLbDwdw/9xu1ozEktO+529leQ/iN+w3gL1ztmOuqCb4Rh2Vys6oWfCzF
         0EaoaYKCMqU6IwQENAeW45bToOe+V8gBD2JRm7FNWDNPViIbAUp+8D7VJzpihrlFJEsi
         wmyewaNpm8O77sMkBaNox6OqPtZyBupFLgw1zSaEKmx9rGrl0m/YxFyET2h3B+m8+eox
         aWV5aQInLK8qyxnjd1q8ilApg1/H8NjMeotuLEFOAiIsuETLxg08Q0Bngkb30MhxjyKe
         rtIg==
X-Forwarded-Encrypted: i=1; AKwUvBwismODbv78LbW0IQSTbet7rQ6TltVXyoLnbAuiq4en58JPJwEnPhcYeTB04LXZHevxpnk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9VcdCvuBfUZ1fbDUhMEM73t2Vqa1tqcKFrPomta99VWbuyBIGj
	gjCat3X8ONaIObPHBiDVMDJlzH7VhdXZMZSn5Iz4CTTNXpZAPj9+BNNRFO+ATA==
X-Gm-Gg: AYBFou1Ftif0G+9BDuUmp1WX3bPXzpq+fUkA1Gppr8cihyf1UJiVZlTQo9/L8d/xPwH
	d+GqZ3O3RkqYZ0zmSQ+IsBhWsCmcsIlIEcPOH7BVyUlribR6qGk/tGQTywyxVDs443T+Hr3LjEY
	C23Q1C9yi2nnVTSeW4uc/L4fNNvklMrJA78T2lqNIPtIXvuLqL3y5rGYPWdDwd5tDVx1rQq6nD3
	PwTcwkxav5ZC0dXbWEN4kBewDdOCXrv0zHW3IsRMbhcTFOpa4M1r3iLgnCXEHtyuoS26zGFVFtR
	2Na8o+NDnv/18WZ68qTaM4vJRsdY5H2wppoxYZHcxijIItDDsMixDY57JLUnNoU2Mbi2/RCTc5K
	Nr/JOTv9W5KtoA+F68aJkrSTHCOPx4R+g4zEALsK4ZKqhN0xuCLT80Ni/o740TyuGE6V5OaTKc7
	nl/olURj7GnR9JNWp5Vmobdc3zv81c0BiknXby+cWl+tMgICgSBudS1JEFSWu0iarhnXqfH/JP1
	IcX45SWZOoOqn30uBAKYvhHGwXv1soTB+Vwfe0PWoXMjSqA1sDi+nLz4TTsvVED9NsfNmaH2nOm
	3juWK3MU8wlrq5INMMGgUpa8hDsFKxzvsiVilxeKtj1N0lu9BUjS
X-Received: by 2002:a05:6808:1996:b0:4f5:c4b9:dc14 with SMTP id 5614622812f47-5640dcb744cmr12613945b6e.13.1793811494334;
        Wed, 04 Nov 2026 08:58:14 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9c79f00sm2135072b6e.2.2026.11.04.08.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:58:13 -0800 (PST)
Date: Wed, 4 Nov 2026 10:58:12 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Patrick Steinhardt <ps@pks.im>, 
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] odb: do not list our own refs as alternate refs in
 the quarantine
Message-ID: <autiszIPCf4Aes9T@denethor>
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
 <pull.2285.v2.git.1793619933300.gitgitgadget@gmail.com>
 <aum-34I8KZvTfDRT@pks.im>
 <CAL71e4McZzVJqFHnmpoQkC6+hUkhz9_HtEy7dqC5rDyXdV6oaQ@mail.gmail.com>
 <aunS6dE0B-JAJnBk@pks.im>
 <aupPATAGBWH1RIe6@denethor>
 <CAL71e4M0t2ZgbqOd4MXeX3vH2W7pPRSMg+8i8epXYbh5-5t8Hw@mail.gmail.com>
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
In-Reply-To: <CAL71e4M0t2ZgbqOd4MXeX3vH2W7pPRSMg+8i8epXYbh5-5t8Hw@mail.gmail.com>

On 26/11/04 11:32AM, Kristofer Karlsson wrote:
> I agree with that long-term direction.  What do you think we should
> do for the short term?  I see a few options:
>  1. A smaller, more focused patch in the alternate refs code, as Peff
>    suggested in the other message.
>  2. Your read-only transaction environment for the connectivity check,
>    (if you want to take that on, I would probably mess it up :-) ).
>  3. Only a regression test for now, with the hidden refs case marked as
>    test_expect_failure, so that we do not lose track of it.
>  4. Or nothing, and wait for the long-term fix, as nobody seems to be
>    hit hard by this at the moment.

IMO, I think the patch suggested by Peff is a reasonably fix for this
problem. Later down the line I will probably also revisit how "files"
ODB transactions manage the object directory, but there are some other
transaction related topics I'm hoping to land first.

Thanks,
-Justin
