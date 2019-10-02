Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 163C01F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 18:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfJBSeo convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 2 Oct 2019 14:34:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55009 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJBSeo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 14:34:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so8260998wmp.4
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 11:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4K1bLhH7O79LD5Jj282mhoYxegx6hGkLh4aOcAvrTXI=;
        b=JmTc+WwzgrZFe9E62BLiC1OSU3lZwYcCswHeVIfiM/rDf3in70opuXA3GIteioRdBr
         KIeu05f4ODz9P/8ljKzsgeAx/FElVhSV5/5QzxgWqtcs0jZLU55lRZ+KrxUba/vLQSHr
         4lm9o0T64qOmGb5S650+Q0dgT6zP24q9jm6oCsTea32SM2FlLyPXaYtAoFmvscXr5Qbg
         w3WPPGIirNeRD41MyDOAb7btiQue0ZRaxU0f+xDtM1YkKXVvrX5WyvBCtGGgs9xNTKm2
         cDD5PmE32egZLiY6p8qlRGUrqHUBdaSCAqxWoSBjUSnvqsJfFrw7WeEhA3aoadw/MlMs
         GcQQ==
X-Gm-Message-State: APjAAAVlqU1tl96mQrC7+hFBZWKYB0wwjRn/NH+aJMziFsnVPb1eN84+
        C+5coacaUbfqBggmG7sR5PDz6Bw9jeJpE6gBa4w=
X-Google-Smtp-Source: APXvYqwLkJQuUwlhwzHiubBYRQyy/MZtlFnUKtYZj9xXvYh9pQTPSp0lYaSnyO/briVRjvE+zJbAPEwQsmtJAqE+tmA=
X-Received: by 2002:a7b:cb55:: with SMTP id v21mr4013736wmj.53.1570041281867;
 Wed, 02 Oct 2019 11:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.373.git.gitgitgadget@gmail.com> <1f84f92846bc14d21aa7339c8baa0f9bb710b17d.1570039511.git.gitgitgadget@gmail.com>
In-Reply-To: <1f84f92846bc14d21aa7339c8baa0f9bb710b17d.1570039511.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 2 Oct 2019 14:34:29 -0400
Message-ID: <CAPig+cS1XHLC3Q_Ntq=-Ck8WzRR7FL1qwQuCfUPVFSTkEKK+LQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] range-diff: internally force `diff.noprefix=false`
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 2, 2019 at 2:05 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When parsing the diffs, `range-diff` expects to see the prefixes `a/`
> and `b/` in the diff headers.
>
> These prefixes can be forced off via the config setting
> `diff.noprefix=true`. As `range-diff` is not prepared for that
> situation, this will cause a segmentation fault.
>
> Let's avoid that by forcing `diff.noprefix=false` just for that all to

s/all/call/

> `git log` that generates the diffs that `range-diff` wants to parse.
>
> Noticed-by: Michal Suchánek <msuchanek@suse.de>

s/Noticed/Reported/ perhaps?

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
