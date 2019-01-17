Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A4D61F453
	for <e@80x24.org>; Thu, 17 Jan 2019 20:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbfAQU5r (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 15:57:47 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35675 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfAQU5r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 15:57:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so12606523wrb.2
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 12:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nDUxQQlbS3oQFJsgCFyyjDnewnESYlKtK6PnFQGcvic=;
        b=jx/CDzjPnS3kAVP3nnBJJ/cgnEssiXpErU3wjn4+P97r+mPEd7UHSRYJbt33gRtCnT
         ItNy6zcWcTNcAK3wYF+seXjI8nc46VYA1hzAprCHeKgeaADqLxIrN2GlFUechkiR7zgY
         8OQEz65ujcqxXt4UmQhjqTYnPJWBkgW5hMzoIBpGQFdBhhJRAhpsWntTdmU4DkKOSJbJ
         6sFw63StRmIT9fjhbflbPwALKivWsojHPB93jrBBMZ2TYNpDYlpl2GRBo2jUNuwWnFnr
         1DvAOwI2IFRqy79Gi7Pv6Fa6mPioBnPg1PwbQFPsTtFJEJ+1CHje87zvFynGi9EnG9nR
         O9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nDUxQQlbS3oQFJsgCFyyjDnewnESYlKtK6PnFQGcvic=;
        b=JK0yYycEUw9s8BTPz3qHiqrlsCzqsuJ2JyXycyBEIupyShUV3J869jhr9RmFRENsFu
         H1IJfDROtl6vzpvAnQrU+4/kQqFzuYsG9AUkfjq1oDqbTfaHxf2VVSW40KQw8HOWKvJ7
         I1OTQtja6avPiNyzNTQcYUu2HQRxYrhLYqAl/rF80V8Bk4xeEtDoFRrhReUhNhec+bsZ
         VniGNBpGi2wnmM3kuKVsOT15nCom9kkWbNf4zFvFfXEFprfNoXmZiFqKJvQqoCMcSc8f
         l1aS+bRtg4/JNlU1WfAHyKE9bwK7ggf1xizsW3CKlkmxrmjkzo55MGpAJpiSvIFOvEOF
         qavw==
X-Gm-Message-State: AJcUukfOG1VJWSCRAYhaNjSgWCj9UL0RZmMK0hmrkjQ4AUzsb24kirge
        aUe7FZl8y/GSSxwvCXXiQ70=
X-Google-Smtp-Source: ALg8bN4Svqmcp46Ki4xFpa5+4IyCjVetS1cb/h+sz5JONQCaeGMQKOT/9aFAIKJUFpoiGMK1qgdLZw==
X-Received: by 2002:adf:bb8d:: with SMTP id q13mr13379584wrg.183.1547758665482;
        Thu, 17 Jan 2019 12:57:45 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p6sm103413098wrx.50.2019.01.17.12.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 12:57:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] t6042: work around speed optimization on Windows
References: <pull.109.git.gitgitgadget@gmail.com>
        <pull.109.v2.git.gitgitgadget@gmail.com>
        <55b0a641d4cd3af37806300e10be36925716e86b.1547713759.git.gitgitgadget@gmail.com>
Date:   Thu, 17 Jan 2019 12:57:44 -0800
In-Reply-To: <55b0a641d4cd3af37806300e10be36925716e86b.1547713759.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 17 Jan 2019
        00:29:21 -0800 (PST)")
Message-ID: <xmqqo98fm27r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When Git determines whether a file has changed, it looks at the mtime,
> at the file size, ...
> Functionally, we do not change anything because we replace two `git mv
> <old> <new>` calls (where `<new>` is completely overwritten and `git
> add`ed later anyway) by `git rm <old>` calls (removing other files, too,
> that are also completely overwritten and `git add`ed later).

Thanks, both.  Will queue.
