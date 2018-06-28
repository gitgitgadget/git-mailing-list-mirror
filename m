Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F3351F516
	for <e@80x24.org>; Thu, 28 Jun 2018 19:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbeF1TJ5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 15:09:57 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:42573 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbeF1TJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 15:09:56 -0400
Received: by mail-wr0-f182.google.com with SMTP id p1-v6so6560817wrs.9
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 12:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Qc25R8ZoFgo99xdm/dEKWDO0CQKgranMLvsYDKmZGNU=;
        b=RQVAiOl6S/3UBq5teCqsZreDHMh3HSBxAHKe+xt1sNGg4aAxdcye9LD/nq7mlU3gx6
         QL6N394m1vLhFsklOi4H7pO3/qBwCDpLlDZo1dJM68zxFlK4U+nzzZDApsozIb0zDl/4
         eNhDS5vbVh+aTHVLEFtpKrtBbVZxu0rI9PfyAWFqQh/d2bBXhytgyI1epSKb6vZddSe5
         NIjdPBusPqt4cYZVSA/LogBmQIGxRzNldXAP2lEEUqIdG7oJ2nxpMvZ+3lj1J/exvm2T
         3rdPv+U5oQGCt41OTiVFTb1ec7g1vcUievV04t5hq2uQ89wcsf59yLbMXGn/qQLgPKoD
         5SbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Qc25R8ZoFgo99xdm/dEKWDO0CQKgranMLvsYDKmZGNU=;
        b=YofEmW0hx3HJqq3oDevRsdEU3MODVud2TozHfc/HYDYT7qMrkgfvDtQ3LxYo1RWIKU
         jYJC35+md1oiGYqW5arGh6akc0KFMoCgHhttB/z0bxGl1pS4ZKk9NzHmB/0kL6eaQ9E7
         V56S67AVAUj61LwqEsQgw3D4esFvE3AVlOwRZSXdN4LjlPxow1judBn1BTWtoXg2CwaW
         caku61nF2aqNL1+ap4bIV7Nsj3wzIuOev8Q3j7mHEDmVujqBxPpOZWbttV2iFGh6CC5h
         fqAWw/uudrC1T26u0TOCPtVMNtXzhX3stpBcxEmAEWTkHj7YV0LeSMAyurxllUy8ubqG
         UIUQ==
X-Gm-Message-State: APt69E2x2ymhyduce2f1UtYZfkEz5gOYjfPqeTAJyqaJoiKeK5eEU5Mc
        6g6lhuD9aZmHLPtzcMLUs58=
X-Google-Smtp-Source: AAOMgpd+cpUUVrMNZa0CjDgBZSNxtZZ5UYhojLCFbq6xYmUjvYIC/U1+1Uzszdfn9zdkrUmoWE5H9w==
X-Received: by 2002:adf:dec8:: with SMTP id i8-v6mr3036155wrn.72.1530212994833;
        Thu, 28 Jun 2018 12:09:54 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v10-v6sm869701wrm.80.2018.06.28.12.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 12:09:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jamill@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "jonathantanmy\@google.com" <jonathantanmy@google.com>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "peartben\@gmail.com" <peartben@gmail.com>,
        "peff\@peff.net" <peff@peff.net>,
        "sbeller\@google.com" <sbeller@google.com>
Subject: Re: [PATCH v5 6/8] mem-pool: fill out functionality
References: <20180620201557.77155-1-jamill@microsoft.com>
        <20180628135932.225288-1-jamill@microsoft.com>
        <20180628135932.225288-7-jamill@microsoft.com>
Date:   Thu, 28 Jun 2018 12:09:53 -0700
In-Reply-To: <20180628135932.225288-7-jamill@microsoft.com> (Jameson Miller's
        message of "Thu, 28 Jun 2018 14:00:13 +0000")
Message-ID: <xmqqo9fuwwvy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jamill@microsoft.com> writes:

> +void mem_pool_combine(struct mem_pool *dst, struct mem_pool *src)
> +{
> +	struct mp_block *p;
> +
> +	/* Append the blocks from src to dst */
> +	if (dst->mp_block && src->mp_block) {
> +		/*
> +		 * src and dst have blocks, append
> +		 * blocks from src to dst.
> +		 */
> +		p = dst->mp_block;
> +		while (p->next_block)
> +			p = p->next_block;
> +
> +		p->next_block = src->mp_block;

Just being curious, but does this interact with the "we carve out
only from the first block" done in step 4/8?  The remaining unused
space in the first block in the src pool would be wasted, which may
not be such a big deal and may not even be worth comparing the
available space in two blocks and picking a larger one.  But we do
want to decide _after_ thinking things through nevertheless.
