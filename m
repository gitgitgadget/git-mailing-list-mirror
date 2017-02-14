Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 531AC2013A
	for <e@80x24.org>; Tue, 14 Feb 2017 09:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752959AbdBNJij (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 04:38:39 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34904 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752864AbdBNJih (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 04:38:37 -0500
Received: by mail-ot0-f196.google.com with SMTP id 65so15944980otq.2
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 01:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tHWR5dOcEkk7R6DWoimiFvbvlPtuqbKm0BXD1r7ip0g=;
        b=jXdI5w0p2Aqau1q/mmwTMcRrw+SlZpfLKY52T8hlGsXWvk+tgpvGsGvY7wcVCdR3QI
         FcAL3swcRqdkI4g7z9env1p3diw0/4vT6T6s4Joutq/3RCMUgyXPVhQdnLaGprxP+hMd
         KcB6bd3wbKK+gEgPppKBu/p9e1sj1wD3iZq5vKETA40fuU6xPyQR6VORtfBF9WVnF839
         lR+mm/Wps9P1OzpykN+uOgjQuocA7cR5sBFDBvZ4M9kQuKD0oif8zKMVoN6n6CzIxHLk
         MyLzqYXo/FdSVT46q8jl2Qqgblf85ro4nyje4bON8t2qCYiIYZyN6+grfpASLEmO+hsE
         oINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tHWR5dOcEkk7R6DWoimiFvbvlPtuqbKm0BXD1r7ip0g=;
        b=dg8Ra2dwcQMxxgu0bqUnDzMAcMaaO5QZBl0be+zutY8S3SBI+rquqXennoYYMXD0Bk
         NY3RnJmrSdZlTAA1tlcgwjAhuEMUgCoQgucG44Rr143frvnkTGANN6UVGgENt4WUlFVE
         5dEs8Nl/s3FRck7blhMNRu97cn79d1t1NKRDKBW9LIBsiFcXTYnjOVR7S2JiCfEX/5IN
         1JLIvs6QsSqefe/OPYh9EQfdb7kk/OTfVODQicVc1NIThzgs2qF8eRgbKZTa2P9MiNxz
         opOJ+nbUxlWFQ7EIC7SUBB6JR0x0mZcCFTgnJldEHUwxH3w5gyAF077zI+OgI51xT3ZI
         uL6w==
X-Gm-Message-State: AMke39ml1F5M3WricHMxzytFv6CvXR1FCf7W/StuwoRBvo/cG7RIlb5Ye2VtgD4Ghs/inIexOxMWj++FCZieYA==
X-Received: by 10.157.9.214 with SMTP id 22mr14878021otz.128.1487065116117;
 Tue, 14 Feb 2017 01:38:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Tue, 14 Feb 2017 01:38:05 -0800 (PST)
In-Reply-To: <CAGZ79kbJXUY=UGvHtkeLLj-qMaoOyTwa2dr3-FqEdYi8eFs4LA@mail.gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com> <20170213152011.12050-8-pclouds@gmail.com>
 <CAGZ79kbJXUY=UGvHtkeLLj-qMaoOyTwa2dr3-FqEdYi8eFs4LA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 Feb 2017 16:38:05 +0700
Message-ID: <CACsJy8DorHk9Xc9iPhw4DYAUeufVhd8229-GXzC_SaTEUb89RA@mail.gmail.com>
Subject: Re: [PATCH 07/11] files-backend: remove the use of git_path()
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 6:09 AM, Stefan Beller <sbeller@google.com> wrote:
>> +
>> +       if (submodule) {
>> +               refs->submodule = xstrdup_or_null(submodule);
>
> drop the _or_null here?
>
> So in this patch we have either
> * submodule set
> * or gitdir/gitcommondir set
>
> which means that we exercise the commondir for regular repos.
> In the future when we want to be able to have a combination of worktrees
> and submodules this ought to be possible by setting submodule != NULL
> and still populating the gitdir/commondir buffers.

You probably have seen it by now. In the near future, submodule is
completely gone from here. We convert to a .git dir before we pass in
here. In a farther future, gitcommondir will be gone too with all the
per-worktree logic in this file. A linked worktree consists of two
backends actually, one per-worktree (which remains files-based), the
other for shared refs, which could be files, lmdb or whatever.
Stacking up submodule on top of a linked worktree should not be a
problem.
-- 
Duy
