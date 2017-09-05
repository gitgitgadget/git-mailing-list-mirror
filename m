Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B330208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 21:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbdIEVAE (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 17:00:04 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35173 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbdIEVAD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 17:00:03 -0400
Received: by mail-qk0-f182.google.com with SMTP id r141so15011256qke.2
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 14:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerotech.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sKOXqe3AwkIso6fkhukRALkMe0UaggY6dDMG/J/N1SE=;
        b=PVqxVGDw4Pa3hlmpt7Cjp6a9l69vfjtxq4FzlNvBdbfu1CzqFgjU10k5sL3rbxzt2y
         L5ciDAAxI0kkjsEhOg7bZgOTbHivqoD/TqxlVB7qr6eDFgdwyGtRLFHrCXvyfjL77rkY
         mXKy9KDvj5tqqaf0L71K0DBKtlihT69kOFahI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sKOXqe3AwkIso6fkhukRALkMe0UaggY6dDMG/J/N1SE=;
        b=MOJAIFwvuspfwzn/Jyb/RjhMMEMwUesBjxClMNa0RPhPlhGDsV9Du5ql7nR2XauBOZ
         s968HCOS8mKA5BNKiEXqb09ha/hzqxicC/lAauYQSJmQWKiPo6uSunG0FynCzZcvek+7
         kmfhDkQD8tEGpEe+pkVMTZlWppYEj8sioP2xlT/+QLJXSgWc/gTFigq+qpICKSLPwt0X
         SQ8+I/uYP2rKXdfthNz2/bpnx6eNcuPZ/nArDoLasFErB/9w60fw2eSnCEHYB1IHLD86
         tzkVnsmZXkA1jP/VFOSRl+75wDiM3kYVuNImuWo4WwFx5fNsj47PWl8m8Q/ALXu1j6tZ
         eYbA==
X-Gm-Message-State: AHPjjUijaIWDVE53VZYlUdxRIC6PPPhxTPQ4x3MZ+spTloxF9ZXEHYS4
        k4xZ+59JG4yCraoNNXFRXduLsyfb+Uf3
X-Google-Smtp-Source: ADKCNb6wpNOInZ6CiyGw6MlgzXrtQGJCsGy8ol4LGq2ce/x9b4vAMBhi2oMp/hA0FzWNF3WdxmqJ8tE/6MmaJPz8Qnc=
X-Received: by 10.55.22.218 with SMTP id 87mr547763qkw.248.1504645202981; Tue,
 05 Sep 2017 14:00:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.130.35 with HTTP; Tue, 5 Sep 2017 13:59:22 -0700 (PDT)
In-Reply-To: <CAEVs+zZRw3kW0C56NcJNXieCSTOa=uMxg6tDPjU2u+WDzhTLfw@mail.gmail.com>
References: <CAEVs+za9do_wXC12SSRznF9v9oGw3_Grq2EFDVf8nH1CRgM-Qw@mail.gmail.com>
 <20170902083319.lcugfpkkk5lahieb@sigill.intra.peff.net> <CAEVs+zbbWQuM-=5d04bkpTu38Mr4PyczskNhni5K1u_nzh-2Qw@mail.gmail.com>
 <20170905153636.tsmlq3wv7ztpc67z@sigill.intra.peff.net> <CAEVs+zbCj0Zv0t4_WG6y2jcLoXwHy-Mu-LH31c_QgFaE9i3HtQ@mail.gmail.com>
 <20170905170311.yhcksrw2bxevd3hk@sigill.intra.peff.net> <CAEVs+zZRw3kW0C56NcJNXieCSTOa=uMxg6tDPjU2u+WDzhTLfw@mail.gmail.com>
From:   Ross Kabus <rkabus@aerotech.com>
Date:   Tue, 5 Sep 2017 16:59:22 -0400
Message-ID: <CAEVs+zafc_=_xV3pAmFq+wCCc_Ex4HhTOLJBqyDnodVQ+pczBQ@mail.gmail.com>
Subject: Re: [Bug] commit-tree shouldn't append an extra newline to commit messages
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gmail mangled that patch of course...
Ross Kabus
Software Engineer
www.aerotech.com | 412-968-2833


On Tue, Sep 5, 2017 at 4:57 PM, Ross Kabus <rkabus@aerotech.com> wrote:
> From: Ross Kabus <rkabus@aerotech.com>
> Date: Tue, 5 Sep 2017 13:54:52 -0400
> Subject: [PATCH] commit-tree: don't append a newline with -F
>
> This change makes it such that commit-tree -F never appends a newline
> character to the supplied commit message (either from file or stdin).
>
> Previously, commit-tree -F would always append a newline character to
> the text brought in from file or stdin. This has caused confusion in a
> number of ways:
>   - This is a plumbing command and it is generally expected not to do
>     text cleanup or other niceties.
>   - stdin piping with "-F -" appends a newline but stdin piping without
>     -F does not append a newline (inconsistent).
>   - git-commit has the --cleanup=verbatim option that prevents appending
>     a newline with its -F argument. There is no verbatim counterpart to
>     commit-tree -F (inconsistent).
> ---
>  builtin/commit-tree.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
> index 19e898fa4..2177251e2 100644
> --- a/builtin/commit-tree.c
> +++ b/builtin/commit-tree.c
> @@ -102,7 +102,6 @@ int cmd_commit_tree(int argc, const char **argv,
> const char *prefix)
>   if (fd && close(fd))
>   die_errno("git commit-tree: failed to close '%s'",
>    argv[i]);
> - strbuf_complete_line(&buffer);
>   continue;
>   }
>
> --
> 2.13.1.windows.2
