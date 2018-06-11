Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 841841F403
	for <e@80x24.org>; Mon, 11 Jun 2018 21:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933622AbeFKVCW (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 17:02:22 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33692 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933394AbeFKVCV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 17:02:21 -0400
Received: by mail-yb0-f196.google.com with SMTP id x36-v6so7196066ybi.0
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 14:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9b7XEjaRxYIHO9n/JZ3F/uPfS9/Pwu3FAi8T+cgAdJk=;
        b=X5KyNsNe235gZ0UIql+wkYI/janZFeJzCoGwgf1TTn+ZHiGe+bdOtgZ2ik2lfa/7yt
         v5Psa5FNOvN77kzqcsqB34yVHORSO0qgGi1yK8h4Ej0ZR98A3gDW5EmmqeqYKhSVfg44
         1Z2G1WaDFoM+9AWg2XoKoD595od4e1ljF1LSpuJof2wYBSYpNvJ3FYfvDM1dK7Rb51yc
         M/2DkSE7qljG3Rq7yaS5d34IhYeJFyGjt2F55ocdG4T9HVGvAvLU7C+u6NoZZoDO9lfj
         bouDuJYaulQ1AHll9UIArf1/WrSDvlT9BGuTb9Cgk+eGj2WrlF3Wbywgy1Kwl71EwbZU
         o4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9b7XEjaRxYIHO9n/JZ3F/uPfS9/Pwu3FAi8T+cgAdJk=;
        b=UHPKjYOU/VGfkrZGFKmtQ4QVJ1ecsa9AizXeMoH0IS4+b257vvMENqfrcJ37oildmr
         0n6JjxcSsuzc+EpI0JfZJbLXoGMSh71ZlxhCia0ZJmta9jx1MLt46yI9NuEuFFuBirzg
         39C5XFCDvA/tfkegWR0OEhoWnJ1qLMKtPwbLXVi0AUXZniqDnFfKSao3nE0Axalac9Gg
         Bm03sUsMECiIQYeAggqtuhF89FrEF1PkuK3oOPw94c/Ban7St/5XcXqq5BcufUMtmsQd
         K0ahbb5Bck7n+aFkXEdeh5tNR5Or6Z5mVuzbUVDuyi9KyZ5DPOKD1fJK8wFC0AeddZad
         Jtdw==
X-Gm-Message-State: APt69E3toXFFRSepQQbZjAGKsSQgZjup642C240krcRcxTwpzzQW3Mp7
        qF1jgKSRdymSKJJ7ohxpZcg0P3mzf5hu8p//bZRnhb5jyYI=
X-Google-Smtp-Source: ADUXVKLRc4qJYsjO1hIfSR9rlSw+2SG1gc2OeO8IZjYNPAa7vyb0C5wAmpRbEIgQVSrJxqV0WJ2wF7Kz6mKc5xxuveQ=
X-Received: by 2002:a25:cc54:: with SMTP id l81-v6mr392296ybf.334.1528750940250;
 Mon, 11 Jun 2018 14:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-4-dstolee@microsoft.com>
In-Reply-To: <20180607140338.32440-4-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 11 Jun 2018 14:02:08 -0700
Message-ID: <CAGZ79kaH7XzbtPZqVwGgP774GJNxF7ZsHqLzWEmb2NLSxG3Njg@mail.gmail.com>
Subject: Re: [PATCH 03/23] midx: add midx builtin
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,
On Thu, Jun 7, 2018 at 7:03 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> This new 'git midx' builtin will be the plumbing access for writing,
> reading, and checking multi-pack-index (MIDX) files. The initial
> implementation is a no-op.

Let's talk about the name for a second:

.idx files are written by git-index-pack or as part of
git-pack-objects (which just calls write_idx_file as part
of finish_tmp_packfile), and the name actually suggests
it writes the index files. I have a hard time understanding
what the git-midx command does[1].

With both commit graph as well as multi index we introduce
a command that is centered around that concept (similar to
git-remote or git-config that are centered around a concept,
that is closely resembled by a file), but for indexes for packs
it was integrated differently into Git. So I am not sure if I want
to suggest to integrate it into the packfile commands as that
doesn't really fit. But maybe we can have a name that is human
readable instead of the file suffix? Maybe

  git multi-pack-index ?

I suppose that eventually this command is not really used by
users as it will be used by other porcelain commands in the
background or even as part of repack/gc so I am not worried
about a long name, but I'd be more worried about understandability.

[1] While these names are not perfect for the layman, it is okay?
  I am sure you are aware of https://git-man-page-generator.lokaltog.net/


> new file mode 100644
> index 0000000000..2bd886f1a2
> --- /dev/null
> +++ b/Documentation/git-midx.txt
> @@ -0,0 +1,29 @@
> +git-midx(1)
> +============
> +
> +NAME
> +----
> +git-midx - Write and verify multi-pack-indexes (MIDX files).

The reading is done as part of all other commands.

> +
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git midx' [--object-dir <dir>]
> +
> +DESCRIPTION
> +-----------
> +Write or verify a MIDX file.
> +
> +OPTIONS
> +-------
> +
> +--object-dir <dir>::
> +       Use given directory for the location of Git objects. We check
> +       <dir>/packs/multi-pack-index for the current MIDX file, and
> +       <dir>/packs for the pack-files to index.
> +
> +

Maybe we could have a SEE ALSO section that points at
the explanation of multi index files?
(c.f. man git-submodule that has a  SEE ALSO
gitsubmodules(7), gitmodules(5) explaining concepts(7)
and the file(5))

But as this is plumbing and users should not need to worry about it
this is optional, I would think.
