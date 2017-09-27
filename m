Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2B592047F
	for <e@80x24.org>; Wed, 27 Sep 2017 23:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752473AbdI0XPV (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 19:15:21 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:53275 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752455AbdI0XPU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 19:15:20 -0400
Received: by mail-pf0-f170.google.com with SMTP id x78so7997896pff.10
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 16:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=flByv13JZC5wL3MQZltKr/XHsigj8KwMv2GJOTrc5Rs=;
        b=gapgwNGtMFseeVdLIRO1ArRaZr4c9DiKgvf3P2rg3DlS9IHsoCWYFd4hakvVgCUrKa
         8wDE8RUTmpcQbR7VWjiPrVhxQkz3F4UB70vi0haUjLFhJOkrWP0bnomztK1TmfjMhhha
         797c6FkG3+pHcxL/t512bMoGRBiIQBqsKBgZkLbRGaTeNqfuoT7x3/Q+gO9XyBWqRLv7
         x2GQhBKBZ8/koB6Nmx21CujQV8/egamjrwR4hxl9PH4cIv9dh/vk2sdRIv3fR5XdQyU1
         VRdCkaauw3mMSQNU3O5g5gbeKTJmRDrkrdHo3FvJvoXOiDrGbkYSjeS7CfgKcpjJAhz2
         AEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=flByv13JZC5wL3MQZltKr/XHsigj8KwMv2GJOTrc5Rs=;
        b=dOPJXxipopS8O2MI8/JdleRcLtEmtRBhK5ntCERnQQgzJ+AYEC8B5iAiZn4tbZVETb
         NWRrvCU6P88DsPdCXU5hkypqzG2uPagfu1qqZI6ugD1FTO6TSuv2Pd8V1pS8k9aV/qBy
         1jsYnGWqhVPvHH6W0I9jD5MXm7Mk9OQ7OCf80bHdeqIUpFxdZNAI1cPMpUd9iyjrhdQE
         jTWzva2I596NefwR686VG9uIXkTu2zhAnr4WXx5cgTL1yESrBim6a8nKrdcfu+oIiEya
         c6xlUxGA0y/lgLdZ5EYMpjoeAFfpwxFa2IOY4uMjcGPzgcqUGGt+E6tBvVEbcV2iGBx7
         Y+fA==
X-Gm-Message-State: AHPjjUgI1zwidob7Ek4inr3Mi3DyDcwrzF9XGn85X0so5HEaMcNV3obq
        gvxtVEzN2ucJugrkXPpM3xPugRZ8
X-Google-Smtp-Source: AOwi7QBa/aQezrGQiYWPTD7pnSn1v5+4KXiOklY4kMLpWSz6yzdgRxPZwB2cI/eHsr7As1lhYtFK9A==
X-Received: by 10.84.238.135 with SMTP id v7mr2458664plk.276.1506554119769;
        Wed, 27 Sep 2017 16:15:19 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:1558:8bd:d6aa:64f8])
        by smtp.gmail.com with ESMTPSA id p127sm84525pfp.168.2017.09.27.16.15.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 16:15:19 -0700 (PDT)
Date:   Wed, 27 Sep 2017 16:15:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     peff@peff.net, git@vger.kernel.org, gitster@pobox.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] diff: correct newline in summary for renamed files
Message-ID: <20170927231516.GG19555@aiede.mtv.corp.google.com>
References: <20170927224909.25dfojhx6wzaqwt7@sigill.intra.peff.net>
 <20170927225126.4836-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170927225126.4836-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> In 146fdb0dfe (diff.c: emit_diff_symbol learns about DIFF_SYMBOL_SUMMARY,
> 2017-06-29), the conversion from direct printing to the symbol emission
> dropped the new line character for renamed, copied and rewritten files.
>
> Add the emission of a newline, add a test for this case.
>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c                                        |  1 +
>  t/t4013-diff-various.sh                       | 12 ++++++++++++
>  t/t4013/diff.diff-tree_--stat_initial_mode    |  4 ++++
>  t/t4013/diff.diff-tree_--summary_initial_mode |  3 +++
>  t/t4013/diff.diff-tree_initial_mode           |  3 +++
>  t/t4013/diff.log_--decorate=full_--all        |  6 ++++++
>  t/t4013/diff.log_--decorate_--all             |  6 ++++++
>  7 files changed, 35 insertions(+)
>  create mode 100644 t/t4013/diff.diff-tree_--stat_initial_mode
>  create mode 100644 t/t4013/diff.diff-tree_--summary_initial_mode
>  create mode 100644 t/t4013/diff.diff-tree_initial_mode

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
