Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6818C20286
	for <e@80x24.org>; Thu,  7 Sep 2017 19:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755882AbdIGTYF (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 15:24:05 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34003 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755770AbdIGTYD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 15:24:03 -0400
Received: by mail-yw0-f171.google.com with SMTP id r85so1971158ywg.1
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 12:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6tWNYiAFye9hNUJczDNaaFeLtx/gpZz6c/QLEVr9znA=;
        b=iZU9rzJUYYfHbOBtkRsgtkq3DhvgEpnXJxk/fzseRU7bfVjkFfMLQ1nYbIfNNbHuBN
         sHCSX+dVmWsQbWEYUE2WouhF/QVkqEIt65bTcr+8/yia9AT1xJwWfSMYYqZkqo6qH2dg
         4jUUSnyRvdOq2ebF5UcpVn6inc9bY+QSRrI/mQ7dS0pVV4S/JgYKs200D9lA5hsGDPgx
         X2xra17yFeIxNZ3ccvfFa4bs+fA4ImJnZP0L8ouIKZJ1yH08qa3VFO2cLmh3RK/TMjHp
         ZHRwY39gOu0jmKb3MruThr26mvi2APbzPVUclW2ZRBe9YtnFvfjugbZCv57jXL3IgI6c
         JboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6tWNYiAFye9hNUJczDNaaFeLtx/gpZz6c/QLEVr9znA=;
        b=N+ud8X1JU9P14hYc+BrB9FEtsz8QR+V7KlMRs+eM8/thDz7UVcpr8nWzWWj9PxjIlu
         GOEEhHVpviX+sVQA47ayeP+o0oiPPqMH34MImw6MYt7kt+LlMkwvlurhyiNSAQym7LR3
         Wmgncc3bkLxXQ/HsNnz1EMoOS6o3eYq89HnwSL2rFAFv9RV18Qz/BPJ/LeL+H1WC8+CI
         +HQ9XhULGldSqrundllPeuzy3uPgsZnEhj2e+f+ejER/grNvCEhi6TaYZCvYVWODmprw
         8yGx+yoqP/fHd6rDiVoCmjv12/PF86sv8PnbJx8hvxb36mDq8859PG8Ftlptu0/EHsJz
         NH/A==
X-Gm-Message-State: AHPjjUi1SII1fngjs1usvq+xTu0OJEwyI3eY95RLJ+0Pxw4iQRCzzU6y
        DNSrg8IqPQJlpBM2E8ntPqTF2egDKilL
X-Google-Smtp-Source: ADKCNb63N0NtLMS9PNHxf8R3/zcBKcqdmjOzV3TAzTw9Bw7mecUEIXlQ7FAO8oMWTZ02amTnv712cR7JN7nF9Pj+VyM=
X-Received: by 10.129.69.34 with SMTP id s34mr360833ywa.29.1504812243045; Thu,
 07 Sep 2017 12:24:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.116.7 with HTTP; Thu, 7 Sep 2017 12:24:02 -0700 (PDT)
In-Reply-To: <20170907101126.u574pr7l5odff6zo@sigill.intra.peff.net>
References: <CACNsYJ-UeEONZ+mDgg6x5Bi+D3VmS=5eGCYq1gEPHVsMEJGojA@mail.gmail.com>
 <20170907094718.b6kuzp2uhvkmwcso@sigill.intra.peff.net> <CACNsYJ8rRSf5gNtnPS05CnYCYGmoBymbgH7UumuOuBz1jp6RBA@mail.gmail.com>
 <20170907101126.u574pr7l5odff6zo@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 7 Sep 2017 12:24:02 -0700
Message-ID: <CAGZ79kaubRDXnetj+EXawnr50LMo4tGObz+-Bd-=KerndLfSaA@mail.gmail.com>
Subject: Re: Strange behavior of git rev-list
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Pawe=C5=82_Marczewski?= <pwmarcz@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 7, 2017 at 3:11 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 07, 2017 at 11:50:25AM +0200, Pawe=C5=82 Marczewski wrote:
>
>> Thanks. Any plans to fix that? Or is there a way to turn off this heuris=
tic?
>
> I don't think there's a way to turn it off for `rev-list`. Merge-base
> computations are more careful, so you could determine the correct
> endpoints that way. But when you fed them to `rev-list`, it would hit
> the same run of skewed commits.
>
> We've discussed storing true generation numbers in the past, which would
> make this optimization more robust, as well as allow us to speed up many
> other traversals (e.g., the "tag --contains"). It's something I'd like
> to revisit, but it's not at the top of the pile.

(We just had an office discussion if this is part of the hash transition pl=
an,
i.e. have a field in the commit object to contain its generation number.
and as I think the generation numbers would lead to fast and correct
behavior unlike the current heuristic which is only fast, I would try
to make a strong point actual generation numbers inside commit objects)

>
> In the meantime, it would probably be possible to write a patch that
> conditionally disables the optimization. But it would mean all of your
> rev-lists run a _lot_ slower.
>
> -Peff
