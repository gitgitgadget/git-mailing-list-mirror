Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03F811F406
	for <e@80x24.org>; Tue, 12 Dec 2017 20:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbdLLURj (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 15:17:39 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43918 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbdLLURi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 15:17:38 -0500
Received: by mail-qt0-f195.google.com with SMTP id w10so248104qtb.10
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 12:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=mWhEOGlpV5d/x923w7MC5KxrbmDngCYq6ZcpXhwzVNw=;
        b=CQZceina3h2T8R74WMl6uvecNP78qobH9eV91M6o9wGMtFjckZALWtE4XTlh6V6Oma
         SDPopW7rhjxZX3D71q3K494jYzP112XNUh+SAGZe6K3c7YqHtZXX50QKdWUI2nrGrelW
         i1EAwj8oNVAXxmum7x4gd0e4w9oE+bNv2PefBfOa5a3TCWd4f9SA6/rTXw1qicFAKXS5
         yCxiMO7DOp9yknFFXZ6/8p5u0++SNlJSasHU0A/ElAah4iNzaDUdzLXtb7DTr4VBrEgu
         hBbSPM41hZZfteqV+86ifW+bz1E4Q4nGNUXeDSH9eWlfYpPRcaQieFjkLRpHnJAgM0BO
         Gbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=mWhEOGlpV5d/x923w7MC5KxrbmDngCYq6ZcpXhwzVNw=;
        b=sPcVHg9Rwpk4JQGAooCXWtBC+0vGmZ0LKxdsr03ajB5riEBZk2iYQGOAuB4i46e17E
         pn6uwYGNg/flR9zJIn+2tUy576v1ktcMlGhJWHEQUnJqRczHyyXjXjgoeZuzAofjziF+
         XxAIKC8wD2GMFVo4UGwm4A4sc1lmw7O1iX3J590Q3fUZCmJOkHfA2w+BIB37UuQVVbPr
         5ZdagAoc6zrmiClPpQnN5Ef9dTVWPLmnTgyBM2ydGaZp3mCRvj9Uk8CMw7fmm1iw4gnY
         rjGdxdjeaABIjv10FzI7Xicwc5t8DFWiB9T62T70VKKSBfXADUPQeXLo3cnCQT14d4On
         2jFQ==
X-Gm-Message-State: AKGB3mIQqhA7XChU8gb8TTYJCBHW9MjNAcIrVIUgOE/V21uJ0TCohoDK
        S+xApxF0mW2/y8K8mj3BtSie2hawMlrgHDFn4K9DRw==
X-Google-Smtp-Source: ACJfBova4PVcrs/bXI4LR24ABgxmUYqAuFJuHyA2E1eSTkjwbJTd4dqO8NTUVHGXWWz1yHrVd2kXY+84+oHPI2/pBQk=
X-Received: by 10.200.6.76 with SMTP id e12mr7143385qth.217.1513109858164;
 Tue, 12 Dec 2017 12:17:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Tue, 12 Dec 2017 12:17:37 -0800 (PST)
In-Reply-To: <20171212195352.146675-3-bmwill@google.com>
References: <20171212195352.146675-1-bmwill@google.com> <20171212195352.146675-3-bmwill@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 12 Dec 2017 15:17:37 -0500
X-Google-Sender-Auth: vK5bmMzabrbiwqa2YHDAnuRGAf0
Message-ID: <CAPig+cTtFB8ZyqF994TLbEj0Km930W3C758niCXNH5v3=hW5Cw@mail.gmail.com>
Subject: Re: [PATCH 2/3] submodule: used correct index in is_staging_gitmodules_ok
To:     Brandon Williams <bmwill@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 12, 2017 at 2:53 PM, Brandon Williams <bmwill@google.com> wrote:
> Commit 883e248b8 (fsmonitor: teach git to optionally utilize a file
> system monitor to speed up detecting new or changed files., 2017-09-22)
> introduced a call to 'ce_match_stat()' in 'is_staging_gitmodules_ok()'
> which implicitly relys on the the global 'the_index' instead of the

s/relys/relies/

> passed in 'struct index_state'.  Fix this by changing the call to
> 'ie_match_stat()' and using the passed in index_state struct.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
