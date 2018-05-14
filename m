Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C0F21F42D
	for <e@80x24.org>; Mon, 14 May 2018 07:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752343AbeENHwf (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 03:52:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54316 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751855AbeENHwd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 03:52:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id f6-v6so11694890wmc.4
        for <git@vger.kernel.org>; Mon, 14 May 2018 00:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Hz656L8ca3z2h8Oipk+BTlFFHOrUPnYapfrA5PMVglw=;
        b=mJRzTl39SqKdaxmrDH7CzkqcH4Z82PldDHbSKK7G3mWR8YHe79XMmSWo3jpMcNDlk3
         5JIBNappE30GqBGeWbOhSlhuU4HIXd+IIoNHrk/Kkc6oA0O6lrjDpqjn3OxQD9O9cQ2P
         NbRDIOBn+5184JFIOVtc533cxVQV+au9PVpya+dXj0+5GlOBhH8IeN52IcInTgBH56gj
         SyCyKS+vy8a7QoipYf+ZghMsa/LhnyXN18Pyec0kg1c9N1M1rjmkKtJq7enQF8X1UHmY
         qE2XO6xU03o/hWzakyZsSYtyoClFp9/NgAN1rdQkliI49UfMhFRUPWLkX5a21nsrkhhD
         kGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Hz656L8ca3z2h8Oipk+BTlFFHOrUPnYapfrA5PMVglw=;
        b=c8kK45J/zGPe46d8/L2wyYEZW9Dz18zcfHHR2g87crV4HQAeV/8IwdbqnPdjYu3lun
         +jgFay6wkTBPXabLWX6S0soKd9WIOXb0LOt9H4DeMWhrpOBQGRF7/b4fiG9cDFeG/dOK
         hkrNs8gTs96NTtZ8zP1aOm9kgDtNDSYTAleZOVt0bM1rF/3J8ACIlyrqNiC/mWY4rPmT
         kWbSE0urc34GWZmgH/3GMlhUuYKtaS1/MdWim8k6StJjMEc7kXc5/loJm6jN+zIzWzKA
         FNiHYpMENr6Vm50lYVrYQOgjWAsCyxBG0yG/9QfeqiE1HtCQmXgRyiQtoLsP3rF7iK3Q
         ZZ2Q==
X-Gm-Message-State: ALKqPwel1kXsELrHS7tcg9SKZ7lYmAoKDuO9pexdaBVPkDs/xH9PVecH
        2OgIYli+wxKblcsLNQGt3QY=
X-Google-Smtp-Source: AB8JxZrrF1KVNOIyVBCklpfBcoRf11RMs6qdCN+8eT6SYBnPu1jZ20CPilr6JjE3PFAYLWVDmAVoDg==
X-Received: by 2002:a1c:374f:: with SMTP id e76-v6mr4116232wma.141.1526284351944;
        Mon, 14 May 2018 00:52:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c27-v6sm11500313wrg.75.2018.05.14.00.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 May 2018 00:52:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 14/14] commit.h: delete 'util' field in struct commit
References: <20180512080028.29611-1-pclouds@gmail.com>
        <20180513055208.17952-1-pclouds@gmail.com>
        <20180513055208.17952-15-pclouds@gmail.com>
Date:   Mon, 14 May 2018 16:52:29 +0900
In-Reply-To: <20180513055208.17952-15-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 13 May 2018 07:52:08 +0200")
Message-ID: <xmqqy3gmbrnm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> diff --git a/commit.h b/commit.h
> index 838f6a6b26..70371e111e 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -18,12 +18,16 @@ struct commit_list {
>  
>  struct commit {
>  	struct object object;
> -	void *util;
>  	unsigned int index;
>  	timestamp_t date;
>  	struct commit_list *parents;
>  	struct tree *tree;
>  	uint32_t graph_pos;
> +	/*
> +	 * Do not add more fields here unless it's _very_ often
> +	 * used. Use commit-slab to associate more data with a commit
> +	 * instead.
> +	 */
>  };

That's a logical consequence and a natural endgame of this
pleasent-to-read series.  THanks.

Unfortunately we are gaining more and more stuff in "struct commit"
with recent topics, and we may want to see if we can evict some of
them out to shrink it again.

To make it clear that everything that is less often used is keyed
off of the "index" field, I think it makes sense to move that field
to either end of the struct (I think in today's integration I
resolved a few merges to leave the "index" field at the end).
