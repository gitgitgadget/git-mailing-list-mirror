Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2D21F94C
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 19:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745586; cv=none; b=lF7jpzqKm/fv2VA7ZZQKDVFK7Li9UJng/Ybs5wtass2C3H2RW1UClKZ0KEJJjL2O2NKMwrIoHkGsGR/JgLc/lfjaaz7lypS0ElOeV2JxPSizYTRjY/2dNEq2EJidct0AGNVgzryladIdKMNAmikkPOMETlMWsDJMHnbukBgiOow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745586; c=relaxed/simple;
	bh=15QXnQmEAz9FZ4X/7ZbfhPXhExeBngMjltDLpSTzT1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzTfC0IrWhd4u6G3QsxoNYeogCw5SkSMoKaFJY3VDj/oIehVhlbxt/XgkgrfdAfz3DrY0gtHS2Aqz8udtnPhSMes2FGe7rPue8WL+ULb73R4wdh2+Huz9Z9CtF7w6torz4s7UVGMNmlhZ7hcCXaYvKeOAoBXsgfwLChbbbgc3fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=GRzxejTV; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="GRzxejTV"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ecfc7fb2aaso52371986d6.0
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 12:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1744745583; x=1745350383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=czMI7bKkByd2jDwLPhoXXPg0ZHSJ8iyg3oaXrENDDX0=;
        b=GRzxejTVJYzqWk5nWs9JgFqzkhHENfU8CpSQh82SyFhLCjzaJHD1NzI+I/hSRiwq2c
         Wt46PduSmMLpJGIObUvrBq5g8+7pbJpx8KoWd82Vez0LGzByuxMisGZ6o9TIf4Gxuejd
         c/E+Zil35bGHkjxPWVZm9PVAE5R295uvjnlz3Hgull3PXcubBHmoT8MXIGuvZkP/X+xS
         hhGfTZUFWG+Kk322tizci2rrRPXfyShKaaEyRVFg+tl8Q6AM8zTZfUzs3oDoEQTPkzXo
         KFF9YagXLBviBIkaLOQ2M8SmrRJWrWoeep0XJHyySZGyq/yCVyoxaYcxxeRCF0n/jJA5
         9jKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744745583; x=1745350383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czMI7bKkByd2jDwLPhoXXPg0ZHSJ8iyg3oaXrENDDX0=;
        b=CyfU7gG6noJ3DI1kW2suwvKs1euyIzQHHw14EeOgjtP9ZHbf/Eb5QDHQCms5lo3Mq3
         ebn1oziiV/nKRBCPiMJNHyiPajV8Iz6OrIr800ACWw2KXw6skfQeXKYYb1XEoI7/KsoM
         c7WNcqJka8rO6zG4pbZvEaAqpQz8BuHB+lf8ShMo31yrbddAOmLWct7QSVr/U2j3akTq
         CpvlEFcFG9EylgsDSf6evVUdfKifYUdlgWLm9A65N7w78ldbwWlWZ8O7iQoiBXeTXW0h
         H9TmLUovwl5Zaev0u92RXl4Sjj3DoJbRZfiBNMhE2m//3Yql3jH/F0fO02q4HWt3NMw8
         qqdg==
X-Gm-Message-State: AOJu0YwhoeqqQ/zO5mawgUUKM1tdQocCHWfF8F0VMfvkf/29ygW6YsjM
	8wWdZKDVE46o8nJ+Q/pB8YDtSox0HJPkGtJyUSLz9kcubypLX55DKOpx7HmtWm0=
X-Gm-Gg: ASbGnctMbl8IqMMtR8ETo3evjaazcolmOOdUQGrUuwOkL4tQbHbZGUZkFOHts5PGcv4
	quTZgSgoz7JfTtA9G1rXdrGNOsdXzRIR72FzVJ9QbjfgIclBIf2e/ZgSoOA0EeLX0HMQBfFm1Ij
	7H63oVciyBXw/oxTqhZmzfXMccpO+k+GvuCJnIIahskGf1WBgOhuR5MAQs3RZOdrchZv3k03EHp
	UQdw9X4Qw190vh4LTLIulS7ZdxvV0SDrzuiLuVqN4vbbE9etM5c8HJeWxHK4kdCb+QdwNO8ZXL3
	XsUmlBrBSN0lkNPT8LMill2mvQUSuzfhU6pRmT25ACKylkhgsOIx5Dzl1CQ3Xq4XNoCPDJ08Iep
	oC2rQm5eekiPF
X-Google-Smtp-Source: AGHT+IGPCVu/zt+ILUQgA96L6zJIluKLKdeImFcFPNimN5V1fw2q0pHVTOSyUFjPtNPHJltMNASmmw==
X-Received: by 2002:ad4:5d6e:0:b0:6e6:9ce0:da9d with SMTP id 6a1803df08f44-6f2ad8f9c92mr14759826d6.27.1744745583050;
        Tue, 15 Apr 2025 12:33:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de9731bcsm105375236d6.43.2025.04.15.12.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:33:02 -0700 (PDT)
Date: Tue, 15 Apr 2025 15:32:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/8] pack-objects: use standard option incompatibility
 functions
Message-ID: <Z/60anmKVxke0AVX@nand.local>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1744661167.git.me@ttaylorr.com>
 <65bc7e46309712e06a2d743172ea4ec518ee928f.1744661167.git.me@ttaylorr.com>
 <xmqqwmbmpjbc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmbmpjbc.fsf@gitster.g>

On Mon, Apr 14, 2025 at 01:41:27PM -0700, Junio C Hamano wrote:
> > -	if (stdin_packs && filter_options.choice)
> > -		die(_("cannot use --filter with --stdin-packs"));
> > +	die_for_incompatible_opt2(filter_options.choice, "--filter",
> > +				  stdin_packs, "--stdin-packs");
>
> The order of check is now reversed (which does not make any
> difference to correctness or performance), but this way, we list the
> options in the same order in the message as before, which is nice.

Now I can't un-see it ;-). Even though it's not a correctness issue as
you note, the whole thing leaves a bad taste in my mouth. I'll swap the
ordering to match the original in the next round.

Thanks,
Taylor
