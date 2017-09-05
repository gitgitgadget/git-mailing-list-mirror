Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9262208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 16:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbdIEQ6D (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 12:58:03 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:34594 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbdIEQ6D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 12:58:03 -0400
Received: by mail-qt0-f170.google.com with SMTP id m35so13599427qte.1
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerotech.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8wDe0daL2+gc1oXnfQXtrgn5/ipr3UPRg0/9luwt6Ic=;
        b=MYWsHeWcRV+QpX/+L7AFq1GDT16TFcMXehAXUJEKlNAt0XdabsnyEdDLLEXCz3yOi6
         4kgSLAoinLDEAmbLG79Jj7Xp5VC8880crquNyDYi+N78xCuEFoXkgyr3a7HPWICn6nDg
         7oxAgH5/ElnhzFHKTc3jtLnthHSBqTwy+6TFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8wDe0daL2+gc1oXnfQXtrgn5/ipr3UPRg0/9luwt6Ic=;
        b=NyEt3qKNOpI9d1/L8ZQVshUbmwoiiUPGxn07IRnAkUy+AkuOm/kPkskdz3TDyqy2UH
         EI1X9aNrtoaA3pxC5oEdKVn2B50Wf12QQSZQ8P1YsmcwQD5EEau+oxv2x+jY7N2qko4I
         zN2Lh5eZ5X3dKsJ2I5Olhc2vVqkn7ztUhaYmxNkkBZNJaQCMDqM4rnZUKqg1esuDT1dI
         W4n5eeYC2SoE+D9CBwwUDfYBCgI0wOJtGry7e29vq8MhsXlHElC2FxvTAfDs3GP9H38T
         pOVXz67TRDFYsiHwUf2qSv0JGPD2UWoZRnl/68KHMsTlRLboQWzPRUmLM6wwLrEAk42t
         UaTw==
X-Gm-Message-State: AHPjjUievjclChuaEcn1jynwqABLLFThYSBr+gA37CIlH/Rxz2ZxGURW
        e2tFECTZim4jZJW3lKDCRbI2UHrMRvrH
X-Google-Smtp-Source: ADKCNb5j5VmBiboqIcDJG9oXz3yH26Qjbw73FzpwxyzqNoOqUTQAUmus8AnjyrRL+d7NWx8DfKlTc3AzvgUMg2h/A7c=
X-Received: by 10.237.36.225 with SMTP id u30mr6772225qtc.11.1504630682189;
 Tue, 05 Sep 2017 09:58:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.130.35 with HTTP; Tue, 5 Sep 2017 09:57:21 -0700 (PDT)
In-Reply-To: <20170905153636.tsmlq3wv7ztpc67z@sigill.intra.peff.net>
References: <CAEVs+za9do_wXC12SSRznF9v9oGw3_Grq2EFDVf8nH1CRgM-Qw@mail.gmail.com>
 <20170902083319.lcugfpkkk5lahieb@sigill.intra.peff.net> <CAEVs+zbbWQuM-=5d04bkpTu38Mr4PyczskNhni5K1u_nzh-2Qw@mail.gmail.com>
 <20170905153636.tsmlq3wv7ztpc67z@sigill.intra.peff.net>
From:   Ross Kabus <rkabus@aerotech.com>
Date:   Tue, 5 Sep 2017 12:57:21 -0400
Message-ID: <CAEVs+zbCj0Zv0t4_WG6y2jcLoXwHy-Mu-LH31c_QgFaE9i3HtQ@mail.gmail.com>
Subject: Re: [Bug] commit-tree shouldn't append an extra newline to commit messages
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 5, 2017 at 11:36 AM, Jeff King <peff@peff.net> wrote:

> So I'd argue that "git commit -F" is doing a reasonable
> thing, and "commit-tree -F" should probably change to match it (because
> it's inconsistent, and because if anything the plumbing commit-tree
> should err more on the side of not touching its input than the porcelain
> commit command).

I would agree that "commit-tree -F" should change to match the behavior of
"git commit -F --cleanup=verbatim". I feel pretty strongly that this type of
cleanup logic shouldn't be done in a plumbing command, though I'm not sure
it is a big enough deal to change behavior/compatibility for everyone.

>   $ tree=$(git write-tree)
>   $ commit=$(printf end | git commit-tree $tree)
>   $ git cat-file commit $commit | xxd
>   ...
>   00000090: 3034 3030 0a0a 656e 64                   0400..end

Yup, confusion #2. I was using "-F -" which I see now is a different code
path. Reading via stdin without "-F -" _is_ the verbatim option. This
difference burned someone else on the mailing list as well. See:

https://public-inbox.org/git/CACAUoX6zT0wXxCLXK+sk0e4hgfD_A_EWWKvWnTOXK0-hzw7BUg@mail.gmail.com/

Probably more reason that "-F" should be 'verbatim' by default.

~Ross
