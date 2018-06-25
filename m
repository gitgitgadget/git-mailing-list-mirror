Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 357BC1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 16:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752207AbeFYQRF (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 12:17:05 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38170 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751641AbeFYQRE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 12:17:04 -0400
Received: by mail-ua0-f193.google.com with SMTP id 59-v6so8996070uas.5
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 09:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bp/YFUf1a/TJyO1jCkz7kzb7bRT3GIRBHBXlZNPpcm8=;
        b=H5TVBrYnm0xj/hHJkYCjJeS+XuO7appaXRzu3Uj7pNCwpClKms0Tcy3YyZRM06RDqV
         9kWYt2SPXlS3xufi7NX4hEtC3K0tAHJ7odr8xQ9hPBbPE/Fclq2mJrvfBna4zNtvOqRW
         pv+Fv+R8felWjUW5TNhKaGSfSR1HOL1ExXK6qafS/SGIzXqZDmdU1+SiigF18cpa9Yxy
         foSzdrBWei9yBFXmDgKLrWgmHE06uZbR7XcG4kQnEv2BAFtR+cUzluv2fQzFruazdrn1
         Rk9t6B6b0WxRDyocXWN3b+Hi3gfMvImQq+il5jUJOWJGFjbt82i1asLv1uynjt+U8Hlt
         zSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bp/YFUf1a/TJyO1jCkz7kzb7bRT3GIRBHBXlZNPpcm8=;
        b=kamrvfocXJNmwQZeg0C/uZ03n3tMg1AfgtCJGFdumy9cvkkYuD+xTd8X5khgp/ZFWz
         pi1ai1VqyGJxXfgleJikVpkLnGk3y/dIAvqS9l6/kKgc0qC/GsfKWnlOTcVZM7t4vmrM
         QNUblZHttF7fi+Oau8Lk9UMLlRxHw+iSQ/KSLjlOvuMATKcsv2hxMmk+n9uv/PBtk9de
         hWpOvCI29PrpTLCQ5WeXUx+yi+7Z89w8ab7ZpXr46plhtuygVJlfQgipqaTQyv71Glto
         g87GFw0FsbxLKYlToDA9CZ1iy+wjeYZx+t8LYwgsPLS/WLZX18zC4F96rYRVZp4nIuYK
         ECzg==
X-Gm-Message-State: APt69E3LuUIkXiM9rFgUhp9/XgScAXWS6SqJlRe2fH6L7CNwG8IaUspt
        QrSXjya8SqA6OibqK+Wm++dUHLA8VrZFqyWNRFKSrg==
X-Google-Smtp-Source: ADUXVKLzjaU6dlH22BkEK6Ho3MZ0mNwSMceuAEi6vvEr4XVsX7j80KXjMLM9B2fhI90ZAO1X7DliMVGF9V8tN/5xBoE=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr8191348uae.199.1529943423294;
 Mon, 25 Jun 2018 09:17:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 09:17:02
 -0700 (PDT)
In-Reply-To: <20180607050454.19438-1-newren@gmail.com>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607050454.19438-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 25 Jun 2018 09:17:02 -0700
Message-ID: <CABPp-BGwBcj4pA5tOhBqJiVZanoZeBdmRa7v7C74=nctrNoZ8g@mail.gmail.com>
Subject: Re: [PATCH] t3401: add directory rename testcases for rebase and am
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 6, 2018 at 10:04 PM, Elijah Newren <newren@gmail.com> wrote:
> Add a simple directory rename testcase, in conjunction with each of the
> types of rebases:
>   git-rebase--interactive
>   git-rebase--am
>   git-rebase--merge
> and also use the same testcase for
>   git am --3way
>
> This demonstrates an inconsistency between the different rebase backends
> and which can detect the directory rename.

Due to changes in the en/rebase-consistency series, I'm no longer
keeping this patch as a separate submission but have pulled it into v4
of that series[1].


[1] https://public-inbox.org/git/20180625161300.26060-9-newren@gmail.com/
