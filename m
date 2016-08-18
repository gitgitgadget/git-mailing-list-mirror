Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 528D6203EA
	for <e@80x24.org>; Fri, 19 Aug 2016 00:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbcHSAvF (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 20:51:05 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35029 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754176AbcHSAu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 20:50:59 -0400
Received: by mail-io0-f175.google.com with SMTP id m101so34944454ioi.2
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 17:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vBlFaR3ZOWCYXFb7eVYgrGhSxPxmLmY0Fpkp/hS9AjU=;
        b=gGb9gvkUNVgXsLw9u3bCknhFozW6nhIHluCjcNVGtOyrnRr4BMr7y8izZF3uWobqVG
         Srq1amrEm/AYCAX6TNdwL0Au8A0qxgL6aF7mWwhzCz/XElb/7GFVLszNvcE/79ipZvac
         KztyZDpWuxr+lK/jphDdwWwN9nL4Iz9EBHy/4eNbwktwKaJbCeCrwj8mN17VwJoldNd7
         NgQcnVOuNQpZmG60pFevPX/u/5O51arG2F8KlRotqr4bgxqIcpibCF6sHga7cCuodxG2
         1Qd8NwNmKUeybG/IOufuehk4FxAueuQ4aE3tEXsL9a89Fn6Qgkxm0Qbfzr9eFAtLaqcg
         kGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vBlFaR3ZOWCYXFb7eVYgrGhSxPxmLmY0Fpkp/hS9AjU=;
        b=M6sGKZ64dMokdXBuOKAYuRWmyaTk0s0FJZKJBRXWRBY/4Qh69wBXwqt0P9n7fhzVOj
         MkiwKEqkn0ZkxpuSLQZOF1/bhiTkTgDzmc6fCGD+jOi3GP3rwyL2ZOoFEw+3qIt7uttf
         Oo4aPB1Zg1NCzj8AwG3jOFMm9uFh58djaAuwxoJC0T96StwXxVqwEjFWyBnrEZrGCjGw
         xOEU0N9nBaxBtZojm41ibVsKj15SfThYqH6ET+qaOcGigPR9dgAzPsbiOGPCbK13JWhn
         0L2b6Jt3K3UUv+9l28nJ8BsA6iyo2VXYhdPCnCYO2e7tTah3rPiZGtR3fkr5JybMlDPc
         TfNQ==
X-Gm-Message-State: AEkoousIPkBohLC7LtEdGrp0lChzpaXGZOFgoAf2a2rV9o68i2iUy+fLRoENXNXZp32tdjt5aWHFNJmQCjLBfuYj
X-Received: by 10.107.178.129 with SMTP id b123mr4838944iof.83.1471543583779;
 Thu, 18 Aug 2016 11:06:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 18 Aug 2016 11:06:23 -0700 (PDT)
In-Reply-To: <20160818005131.31600-5-jacob.e.keller@intel.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com> <20160818005131.31600-5-jacob.e.keller@intel.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 Aug 2016 11:06:23 -0700
Message-ID: <CAGZ79kYK0_TC0AS_6Wqh4LA6xnj9xeZu7O1Gj5A+Y1h1ikKjHQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] submodule: allow do_submodule_path to work if
 given gitdir directly
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2016 at 5:51 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Currently, do_submodule_path relies on read_gitfile, which will die() if
> it can't read from the specified gitfile. Unfortunately, this means that
> do_submodule_path will not work when given the path to a submodule which
> is checked out directly, such as a newly added submodule which you
> cloned and then "git submodule add". Instead, replace the call with
> resolve_gitdir. This first checks to see if we've been given a gitdir
> already.
>
> Because resolve_gitdir may return the same buffer it was passed, we have
> to check for this case as well, since strbuf_reset() will not work as
> expected here, and indeed is not necessary.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  path.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks good,
Thanks,
Stefan
