Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2FD72013A
	for <e@80x24.org>; Fri, 14 Apr 2017 22:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbdDNWeJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 18:34:09 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:34121 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbdDNWeH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 18:34:07 -0400
Received: by mail-io0-f170.google.com with SMTP id a103so120902765ioj.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 15:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eeVQnaRBUpToK00wFdQ3cnS2kdO9p3otxyaJdYHONjA=;
        b=RpyH3xOREC4rHxSswU/qaoqiXW1jT2erEQCDCAsAaQg236BiLJqKQFbJ1sZHURXbXR
         UhNps+My0Kq3LL4718xnuzP5he0BWl7KndBJBQz/b38DJMZB/lUngw2InOz7JFn+HdNd
         7mXlcxl3Xg967m9cLhBqC0EPIhzbs/ctUtJF6PvOvehCZ3nOUPX/Fu8pJQXF3tL0i7z3
         Ikx4tOqzPQkfKGOiw3q8t6Wx4TAdat6sBof7YcjDg4WvvBUusSTgr9mPtKITEyjKrCRf
         6idMdxCA+0wgclTENFJi//treSOETFyl3ucsFmGOWOgF43AVGtX5MacQDcF3YL/ZAgQE
         qSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eeVQnaRBUpToK00wFdQ3cnS2kdO9p3otxyaJdYHONjA=;
        b=m5L/8h+4qx67VMdnNA0Z9ho8ExoDnc8HOFH69iTJ+h5tbnO4uMEOjFtrEsoIhvCXsH
         wXaxkyYgyws1BGxA1bMPlnm3TH6/Yfg3hb/cZgvy+VB4HwhEmBVDqP3BLgizWpMZ2hgx
         9pbWIaGK7P2PpV+AkdayI/MaOFmr9mQ67DaBnX93LZmx29dP4kJwhdRptd9cRMOHbWxB
         CDJqH9WVo+TT1q4BzRgYmVIZLLObsadekG0d5A+OM+K+YcIR/9QUfrBiilPF3HcFXa1f
         odnQ1TzwsBiGUjSNefGFu59GGwVmuOrgZKGbsv4jSQehjlHFnkIikGhEZ3vMLsHvzLMd
         nPNw==
X-Gm-Message-State: AN3rC/4YSlDsTcD8Tat8eSg1bledj2xDEjkfU+WeFK2vnViM1t/Rf43m
        7IZqziZBFnAwjx1fhucDky+OFw65gfiI
X-Received: by 10.107.46.229 with SMTP id u98mr13218809iou.147.1492209245587;
 Fri, 14 Apr 2017 15:34:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Fri, 14 Apr 2017 15:33:44 -0700 (PDT)
In-Reply-To: <CAELgYhfwwLZXGN9yHZ04koDwGn3=KbuJOxhLM-+PCbumTmMunw@mail.gmail.com>
References: <CAELgYhf1s43p62t6W14S=nDt-O247cPqsPMUDfye1OTnDND3Gg@mail.gmail.com>
 <CAELgYhfwwLZXGN9yHZ04koDwGn3=KbuJOxhLM-+PCbumTmMunw@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 15 Apr 2017 00:33:44 +0200
Message-ID: <CACBZZX7Ajf1c9YKP=MO0T9SV7d0-XZsT=RthJocqZw4_TcCcQw@mail.gmail.com>
Subject: Re: Index files autocompletion too slow in big repositories (w /
 suggestion for improvement)
To:     Carlos Pita <carlosjosepita@gmail.com>
Cc:     =?UTF-8?B?4oCcZ2l0QHZnZXIua2VybmVsLm9yZ+KAnQ==?= 
        <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2017 at 12:08 AM, Carlos Pita <carlosjosepita@gmail.com> wrote:
> This is much faster (below 0.1s):
>
> __git_index_files ()
> {
>     local dir="$(__gitdir)" root="${2-.}" file;
>     if [ -d "$dir" ]; then
>         __git_ls_files_helper "$root" "$1" | \
>             sed -r 's@/.*@@' | uniq | sort | uniq
>     fi
> }
>
> time __git_index_files
>
> real    0m0.075s
> user    0m0.083s
> sys    0m0.010s
>
> Most of the improvement is due to the simpler, non-grouping, regex.
> Since I expect most of the common prefixes to arrive consecutively,
> running uniq before sort also improves things a bit. I'm not removing
> leading double quotes anymore (this isn't being done by the current
> version, anyway) but this doesn't seem to hurt.
>
> Despite the dependence on sed this is ten times faster than the
> original, maybe an option to enable fast index completion or something
> like that might be desirable.
>
> Best regards

It's fine to depend on sed, these shell-scripts are POSIX compatible,
and so is sed, we use sed in a lot of the built-in shellscripts.

I think you should submit this as a patch, see Documentation/SubmittingPatches.
