Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210591BDF4
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 13:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wNLnPBHE"
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DD530D4
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 05:20:28 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7ba170ac211so324633241.2
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 05:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699536028; x=1700140828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8qtID1nt+dGFaXhS+7WO96T9XoSGVNF3HiD5uIzzMJs=;
        b=wNLnPBHEz/OghvMH1zbtq/D1F3hH6fDp7QSNByqYzFftGh64tzmsZLemtBIH1wKtA4
         IW3tf9EUJfViDi9APVGy/UYIdAmBvBxipAU9dVs0ZTGuHFGF0iRdg7yeyJuonDZagzXO
         D51HKnpfofaKcQtJr1vucI4CsUIaXW/sbJop4OkFW6tdHGbdk9sRtEyQtOqG24gMGy7Y
         O13rztBst/T/L+6ZobY5+rf6g3QaIDkJMPYJ2UECKj2GT0YDQuBflcXpHdm6svPys7+e
         S5rjsTKCAERBnIrQ4Qd8gdmULy8IErFe2R2JCgWMkN9ufmPfwKpnvx9HA2XpY/kIz8cP
         I3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699536028; x=1700140828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qtID1nt+dGFaXhS+7WO96T9XoSGVNF3HiD5uIzzMJs=;
        b=a+cqI2rniTpm/R4YTmGO+d9KFixx3XK/Xm02rl1dOmQ8jrBSWJbSyvjOkJg6Tr7Zi6
         ue5BsbXSj37k0U4GaVzjwzrr7in4tIx+EAlJZ9tgrepz8jX409fBCnCPrIdeF27HtGab
         4D6kRSEF2iOCET+QcUfhVNontN5QbhWjunPUdzcebfrfQHsKA8Ps3hCmKY42Z9VtO0OO
         1Q/WM5QHeYJjr6uA2tyUL/q6x44TRTxmDwr6btAdqgG8wreXt8n7YzkDSf/aIfy1CYr4
         TdIvnKsYITVu71Ek9FXLBxwTT8e5bwTfpSRJ2940xL82GangRMP8Ez7XdbD+IVbmoI0k
         RXzg==
X-Gm-Message-State: AOJu0Yw60jmDTciDDOTR1Om5IaRPmcTVRQ5W3iGR3sCpetnVtNw+ESRk
	S79JeUZH8eY0vcN5g0vGH/qzMHblsuAdz+GQGKGztA==
X-Google-Smtp-Source: AGHT+IEizUcLV0YabEmqyP7kixaiIwxNgQncX3BglYQraROq5XSaCwey8CEMcBqZyN/GuWW8I/aLXQ==
X-Received: by 2002:a67:ac49:0:b0:45f:1a97:e971 with SMTP id n9-20020a67ac49000000b0045f1a97e971mr4870247vsh.20.1699536027745;
        Thu, 09 Nov 2023 05:20:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id pl11-20020ad4468b000000b006710660a548sm2048285qvb.27.2023.11.09.05.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 05:20:27 -0800 (PST)
Date: Thu, 9 Nov 2023 08:20:26 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2023, #04; Thu, 9)
Message-ID: <ZUzcmsfJe6jk4fTk@nand.local>
References: <xmqq34xg5ek3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34xg5ek3.fsf@gitster.g>

On Thu, Nov 09, 2023 at 02:40:28AM +0900, Junio C Hamano wrote:
> * tb/merge-tree-write-pack (2023-10-23) 5 commits
>  - builtin/merge-tree.c: implement support for `--write-pack`
>  - bulk-checkin: introduce `index_tree_bulk_checkin_incore()`
>  - bulk-checkin: introduce `index_blob_bulk_checkin_incore()`
>  - bulk-checkin: generify `stream_blob_to_pack()` for arbitrary types
>  - bulk-checkin: extract abstract `bulk_checkin_source`
>
>  "git merge-tree" learned "--write-pack" to record its result
>  without creating loose objects.
>
>  Comments?
>  source: <cover.1698101088.git.me@ttaylorr.com>

This series received a couple of LGTMs from you and Patrick:

  - https://lore.kernel.org/git/xmqqo7go7w63.fsf@gitster.g/#t
  - https://lore.kernel.org/git/ZTjKmcV5c_EFuoGo@tanuki/

Johannes had posted some comments[1] about instead using a temporary
object store where objects are written as loose that would extend to git
replay. Like Peff mentions[2] below in that thread, that approach would
still involve writing loose objects, and it is the goal of my series to
avoid doing so.

I demonstrated in a follow-up thread[3] that my approach of using the
bulk-checkin and tmp-objdir APIs does extend straightforwardly to 'git
replay'. This works by writing out one pack per replay step in a
temporary object directory, and then running 'git repack -adf' on that
temporary object directory before migrating a single pack containing all
new objects back into the main object store.

I am fairly confident that tb/merge-tree-write-pack is ready to go. I'll
spin off a separate thread based on that branch and cc/git-replay as a
non-RFC series that extends this approach to 'git replay', so we'll be
ready to go there once Christian's series progresses.

[1]: https://lore.kernel.org/git/0ac32374-7d52-8f0c-8583-110de678291e@gmx.de/
[2]: https://lore.kernel.org/git/20231107034224.GA874199@coredump.intra.peff.net/
[3]: https://lore.kernel.org/git/cover.1699381371.git.me@ttaylorr.com/

Thanks,
Taylor
