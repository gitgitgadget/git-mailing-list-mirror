Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3F681F453
	for <e@80x24.org>; Wed, 23 Jan 2019 22:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfAWWiu (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 17:38:50 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:36422 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfAWWiu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 17:38:50 -0500
Received: by mail-pf1-f202.google.com with SMTP id p9so2886792pfj.3
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 14:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+PTz5ieJYcrqFUIALXV0mOfKq1dkSQ4dmqabcr2OW74=;
        b=QGlqEt15ZyKCW4aJr/oLdDhYi7hQ+n6JSHZiBepDLNpnlqNM5RmbFdT2FDwaHJ46z8
         LXtxknmViHbn2kcyTsSUdMpkijZa/YWnFaBBO3H6OEgeXwWeKWHFG2A3/p0iaFJRS/PU
         CRPNPFk2Wmt0sGH3gSO0yLieVLE7+p9jcE14KBxnK6rgxn4QD3Us7o96E4xASFOg/Wtw
         JwlgzmRdTHwRk0HKN4O074D2rl52rPKc+OtMC26mBKMg3SCcDra0ek9/ji2GSm9Z6xIR
         f6nG5ZzDUfKKNnBDtsraZjgUYf2FGDadiDtMj00jPp6pRqjSIem9WNvZS+6h4rma21a1
         u8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+PTz5ieJYcrqFUIALXV0mOfKq1dkSQ4dmqabcr2OW74=;
        b=sVKfY91aTMJnGniL2PTIoee4JLAhGd5UYfTmNgRzOr4d5K6TP3uUQryjImTVJmXzoK
         D8mT7doYOKpuD1yYjryQcjyaHmoNRj0qMR8Qllnc7y8qfSXmmEYEiF+qifw1txilx79U
         QUiRVyt2J8kM4qiDUSN5lYdjwADHTLrXJWjERvBmYdPYfDnt43RyLTbyPimarC9WTJh5
         oHQGvb4Bi8a2swtqNhX11OlHHijPQVIsnzt6MOjkIW4PPvbO9Rm0UjCwGowZ6pgzlsPG
         4GgR+GjvmdRFdd8yVhBqwLXU3dsMHOVjggQinivUZ3X0d9O1TTADvsMcYW4dJ8vubHEF
         L9dA==
X-Gm-Message-State: AJcUukfkGvdwUOaPNGFH1H20UPj3J3VK1S91bJzp9JFUV7u6siQ3Lr1q
        z2Iv8r24zfI3bJMoXZmT2Zy/Z8b2fkgicJGVvjmU
X-Google-Smtp-Source: ALg8bN4nW+5Svd3qDXNdOjsOuG1+Th+C6T49i2C+Ddrn/PrN8FTjAgn31p34Khw7ir/vrgiWk4aA/sgngIY8MOUAYTKm
X-Received: by 2002:a63:a05a:: with SMTP id u26mr1819899pgn.25.1548283129202;
 Wed, 23 Jan 2019 14:38:49 -0800 (PST)
Date:   Wed, 23 Jan 2019 14:38:45 -0800
In-Reply-To: <b39f90ad09265614efd466fee5089354a193ae8c.1547047269.git.gitgitgadget@gmail.com>
Message-Id: <20190123223845.147378-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <b39f90ad09265614efd466fee5089354a193ae8c.1547047269.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v3 7/9] multi-pack-index: prepare 'repack' subcommand
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        dstolee@microsoft.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
> index 6186c4c936..cc63531cc0 100644
> --- a/Documentation/git-multi-pack-index.txt
> +++ b/Documentation/git-multi-pack-index.txt
> @@ -36,6 +36,17 @@ expire::
>  	have no objects referenced by the MIDX. Rewrite the MIDX file
>  	afterward to remove all references to these pack-files.
>  
> +repack::
> +	Collect a batch of pack-files whose size are all at most the
> +	size given by --batch-size, but whose sizes sum to larger
> +	than --batch-size. The batch is selected by greedily adding
> +	small pack-files starting with the oldest pack-files that fit
> +	the size. Create a new pack-file containing the objects the
> +	multi-pack-index indexes into those pack-files, and rewrite
> +	the multi-pack-index to contain that pack-file. A later run
> +	of 'git multi-pack-index expire' will delete the pack-files
> +	that were part of this batch.

I see in the subsequent patch that you stop once the batch size is
matched or exceeded - I see that you mention "whose sizes sum to larger
than --batch-size", but this leads me to think that if the total so
happens to not exceed the batch size, don't do anything, but otherwise
repack *all* the small packs together.

I would write this as:

  Create a new packfile containing the objects in the N least-sized
  packfiles referenced by the multi-pack-index, where N is the smallest
  number such that the total size of the packfiles equals or exceeds the
  given batch size. Rewrite the multi-pack-index to reference the new
  packfile instead of the N packfiles. A later run of ...
