Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2754120229
	for <e@80x24.org>; Tue,  1 Nov 2016 21:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754505AbcKAVlh (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 17:41:37 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36334 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754479AbcKAVlg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 17:41:36 -0400
Received: by mail-qk0-f172.google.com with SMTP id o68so216751111qkf.3
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 14:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2qRBhxyb9ogs5HXXcdZ7keNFsimajDXMIjNWvM7cB98=;
        b=TaKMVF4n7sYMMC5n1+3HoKZ025EFZj9qxYax+CqbpsqzFw6UBcmvxJeXSNioA9bRet
         oD9c1qq37ePxB1NEtHmiFzhaaqzXsZFy+P8aG64138nidGTt9C87/IahSe80gkTHppAF
         ajY0kY1Zs62lg6ZHMs0U9qQ9mv6OlGa4E4dpI6QgIasH5cybfA+aKPKZBEL8C/cgEAqC
         +JtoLRLCsJ5A+UuRc7cS7ySmpYeNED6yvAXeFsPPQEkT7oDbTWuKCo8tOpx0K6cVgkSU
         Qy+ZQCtHhaZuQFcAi0UHlr5n/1wK279C6xvYYuLf7Ghg9Vnf54UricRk0vuskXfxVWiz
         jJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2qRBhxyb9ogs5HXXcdZ7keNFsimajDXMIjNWvM7cB98=;
        b=WClq9yp7SXncEw7a9db2iG7muqONh5oVaYdeIdU+iiUorr1C+IsrEmrkD+qwETSvVQ
         0cap0Z2gCpetMU5mxDBgnGhPV8Px4JIUd5C366Xw4jhAGNIaxDR1P9j+vrSdpvw/x88q
         NxL1SHkYSQ+obeVKDdKtcThKsMmPU9d1qSsJssLYHvk/nbYVGJPO4kCqPZkOyZ3s/7gJ
         Hsa5yJYMd/ExDn4khE3B3dAwAje09ZNtjYybKHzAUXjs5Iyx1GFcFXUT26Hf4y2umzrr
         5ShCixSExzQuA1zxG/FI224uZbbXNAuAJH8WGp2hUDUjwJ3VgPQBACh7S0/pVRqnzWMn
         68Bw==
X-Gm-Message-State: ABUngveWz15UrGTzxkZeDbznuzVCignAB5rz8YAnsE+gQbnL8bvFyAcgTqq7JCMCeKDZImxkSzrhdSpmQyewM4ZN
X-Received: by 10.55.45.193 with SMTP id t184mr199676qkh.58.1478036495727;
 Tue, 01 Nov 2016 14:41:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 1 Nov 2016 14:41:35 -0700 (PDT)
In-Reply-To: <xmqqzilinanp.fsf@gitster.mtv.corp.google.com>
References: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com> <20161101203637.3jr73wwpfal4brho@sigill.intra.peff.net>
 <xmqqlgx2or5p.fsf@gitster.mtv.corp.google.com> <20161101205916.d74n6lhgp2hexpzr@sigill.intra.peff.net>
 <xmqqh97qoqq2.fsf@gitster.mtv.corp.google.com> <xmqqzilinanp.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 1 Nov 2016 14:41:35 -0700
Message-ID: <CAGZ79kZHajTxFRbOftH==UAXhbH7RSA_jYWO-aQXhW2aSRdUFA@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.11.0-rc0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 1, 2016 at 2:38 PM, Junio C Hamano <gitster@pobox.com> wrote:


>
> -diff.indentHeuristic::
>  diff.compactionHeuristic::
>         Set one of these options to `true` to enable one of two
>         experimental heuristics that shift diff hunk boundaries to

We would need to reword this as well, as there will be only one heuristic left?


> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -906,22 +906,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>                                 if (group_previous(xdfo, &go))
>                                         xdl_bug("group sync broken sliding to match");
>                         }
> -               } else if ((flags & XDF_COMPACTION_HEURISTIC) && blank_lines) {
> -                       /*
> -                        * Compaction heuristic: if it is possible to shift the
> -                        * group to make its bottom line a blank line, do so.
> -                        *
> -                        * As we already shifted the group forward as far as
> -                        * possible in the earlier loop, we only need to handle
> -                        * backward shifts, not forward ones.
> -                        */
> -                       while (!is_blank_line(xdf->recs[g.end - 1], flags)) {
> -                               if (group_slide_up(xdf, &g, flags))
> -                                       xdl_bug("blank line disappeared");
> -                               if (group_previous(xdfo, &go))
> -                                       xdl_bug("group sync broken sliding to blank line");
> -                       }
> -               } else if (flags & XDF_INDENT_HEURISTIC) {
> +               } else if (flags & XDF_COMPACTION_HEURISTIC) {
>                         /*
>                          * Indent heuristic: a group of pure add/delete lines

This comment may need adjustment as well (though we could go without)

>                          * implies two splits, one between the end of the "before"
