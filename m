Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D830A439356
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526897; cv=none; b=bhTZ2rhjcsEpnlyMA9ZSKhDycpa2PuD81hSvekiSfsLKlAf1h1LPDWSkAiKz0PW84ORuFRoivxPRnk+3xa2Wg8B7HjMt+D8MvG5amAYmDUXTf0Sk1G/4UWdJ6v13mgsgyVgnaqlRksoCz2q+lHfbKHNzaa8o6urDsTRi5iBHmgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526897; c=relaxed/simple;
	bh=VPEeFN/6I7M1Z7t2CFuRRCRSIHKscdN7Ev8w04LRIPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEfxnL9hKmtOw4bbOt15dQNEBr+ur9U20QfSq+9w4gujEit4UIyul9scZueoD3cmn02PMLQLHnfIwl8ZVY42ba4tpKrskl/fJ4Ul8HMsgrwYNKNi2a70V5ExSqnkJpUJm3drml4WX2048vLDKOR0xTGCmHWFnltDMPEBw/ZT9lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qNsuJbGm; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNsuJbGm"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7ebd88be784so274180a34.2
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 09:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783526895; x=1784131695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M/TnbP6OBTCx4Xms5jMeHr1yd9VBRxZdo8X0lk2FeKA=;
        b=qNsuJbGmpcR+QVE5SgOQjcyuOrdSkyseLEGKm/CS1+UZB2QWij15Ro5G1h47fdt4/m
         7k38ZalNxf9fWM+S7kZXjcVNUvBFSTtXRCw0KzDZdP86OhzDcpR/1x99Ep3UUFAgebyz
         uIyWibVLYPCDoXazTfav2pi6sXsp7nW1zDIuMKJnuXvGu1VJ+4DGBdgy33MrpdQm2SoX
         VlSrctYG0uC8aonVHcoMyxVXNjHjXicLQrd/MmcJZE8pWEr+CBxRIEDNKqdKaTUvoFxX
         FDlTzniq8VJugHLtbc3TftLR7RrC3/X4eiPfbtZfaTbQc57LowUjOy+h52XYPqWWpkgd
         U4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783526895; x=1784131695;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/TnbP6OBTCx4Xms5jMeHr1yd9VBRxZdo8X0lk2FeKA=;
        b=mbJZhlWW3Yw9iPe1i9+2D2SyZKARa69MptYmFD5fAtAeJPCi3yLVrLaGAJFJPBgt7g
         93WpR5/5zxu6xDShG+5OyhwIexjKYX4S5pkC/p5DpTdh4YBaD9kc6sIiK2SqjXop6L4x
         qkan9yNlHeJDvQNuxxgU2dBa2pIYwLmE5ctsPRe3AT/PR7tFVsSlt1NKni+cbKs/i0Bd
         BmXH8deMimSQoC486oxEQDIO04NQZESLdSzTSAml0rzIFPbPfl1XAyhG1pupFW+PnXeR
         qu56YUIzyB1kslERse/RxPrsTGyKrh64DkiRVA43TlyYvd28lCO0aj6JJVqbENCvhhHU
         IrWw==
X-Gm-Message-State: AOJu0Yz5k11UHo1zSJ5YA0n2E0CESs5HWtWQpHHfZg0CS6Dsk+Tkak3m
	VkvIUPrbturuGYkw3sChrS/SXLk5/P1ggBMM7zwdPPzmpTmEU7YdSkJK
X-Gm-Gg: AfdE7clkvaVaDJH7eBl1tsNDc0pnsJVGNCF1aPH7eR9KYtqb9D3XLOtD9x2+0DLomDA
	5I0zteUdlDTUCiMnnyx9YcUoD5Q6XZHzAi4wsPJrG994aHdQf1e3f5rGhS0XGMdrwV3YnfNvfHQ
	pH1J0AUAAAdYuRIdXRqTHQrB2r4JxFYfvNwgva+5KK4Xz27SoSoiGNja3Qx5ZKa97tNnfaQsOjC
	aqi+yW3l3SIY1G2YK2Q9Y+dWLL+daeWmlKdxwnZrPjLDA+2ou8uqgviJ7xslAqbtELZhh5/QgGP
	+TVHL3EyK1GGTXfsR9TnE3iFmB4L+EMIRr5EIQxGjIhsCBOdeqnqc1v/vnzDY08KUU84Li/tdCs
	UJba9VakrLRjSimI1nRKOAAmU4Ic5QSX9QvfwVHM21deTBjVso/G+YZN4hnMp+97blTCBvQMZ73
	YzSYDDpg==
X-Received: by 2002:a05:6830:660a:b0:7e9:bd00:c6ad with SMTP id 46e09a7af769-7ebcff7ed1emr2065759a34.16.1783526894673;
        Wed, 08 Jul 2026 09:08:14 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae177c5sm2167356a34.5.2026.07.08.09.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 09:08:13 -0700 (PDT)
Date: Wed, 8 Jul 2026 11:08:10 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 03/11] object-file: embed transaction flush logic in
 commit function
Message-ID: <ak5rFZOYdEQ3zRni@denethor>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708041412.1157499-4-jltobler@gmail.com>
 <ak3xFCzvgj1-Ev_3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak3xFCzvgj1-Ev_3@pks.im>

On 26/07/08 08:41AM, Patrick Steinhardt wrote:
> On Tue, Jul 07, 2026 at 11:14:04PM -0500, Justin Tobler wrote:
> > When a "files" transaction is committed,
> > `flush_loose_object_transaction()` is invoked to handle performing a
> > hardware flush along with migrating the temporary object directory into
> > the primary. In a subsequent commit, the temporary directory is also
> > used to write packfiles.
> > 
> > Instead of maintaining a separate helper function, embed the logic to
> > flush and migrate the temporary directory directly into
> > `odb_transaction_files_commit()`.
> 
> The change itself looks simple enough, but this makes me wonder why we
> want to change this. Like, what subsequent step does this enable that
> would otherwise be harder to do?

Originally, I was planning to rename both
`{fsync,flush}_loose_object_transaction()` to
`odb_transaction_files_{fsync,flush}()` respectively. For the flush
helper though, it's doing more than just "flushing" the temporary
directory files; it's also migrating the objects to the primary ODB and
reconfiguring the repository ODB sources accordingly.

This is really what you think of happening during the commit phase.
Consequently, it made more sense to me organizationally to just embed
the logic `odb_transaction_files_commit()`.

> Maybe this will be answered by a subsequent commit.

Will update the commit message to properly explain this.

-Justin
