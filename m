Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78AB81F424
	for <e@80x24.org>; Wed,  9 May 2018 18:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964899AbeEISwd (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 14:52:33 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:42078 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935531AbeEISwc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 14:52:32 -0400
Received: by mail-yb0-f196.google.com with SMTP id 140-v6so12697547ybc.9
        for <git@vger.kernel.org>; Wed, 09 May 2018 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F0wJlYfYMrPtLqFq5IzKJmIB1L/ORDBtkUKRHkBCESw=;
        b=BnxmLytEvNCXQ7VFrnHWw60CET4swTg/OYyjLwOmwpizzFB5rZkSu9KCh0AjW4RQBu
         hrdBHnXrUvx85RNzemoFgYAexA8O6geR35sO4u6zfiKsG6ngEBZmI3h4ITawG1mRgd8+
         3Of/IMeoZUNAcsCgvBOa3c4sakRZAJjDGq7z3MXESF67nStzdLsRTvdXWxJ4jJGNrrJD
         +8rSo1hWjWJzRm7k0at88DZtfCxuMG36gf+RLaYiu0sQHXgTy8AqJPEtS38D65tXLyrS
         r46BsWA0fy3bqpC7Webh9TSWP7g96Fpp+xZPw5bFzxSgu2WAptTbp1Oyy/NIQQez1WH5
         Ep7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F0wJlYfYMrPtLqFq5IzKJmIB1L/ORDBtkUKRHkBCESw=;
        b=X0WTE5aSCpPCa9fLfZIuPLRhqoxBvWQSh2888AjBA0RYP/qvTwzXr0Urqwc894Uujg
         g1pEPphpyHMXk+ihbzG/5WyW50jwezUoj7zytn2snvv/AEzg2dl2OgaFqFyE6yXkA2bp
         t3u2CRgcqYpXz6iwbwj3pIHKDCOT4e9yuuUIQizlA+P5RazjFe3mQl3eNTH7y5xicsxK
         xLLJrbirSWm3Uc9A7v2pyai9NPizCWohsXec3hOSEJ/V+Hjt5igQzQg2xyq6RtMCJCKg
         GAlxd4HI8PnJBpphNwhbFG76nLYfAv8CNkvkjUwy7GUunhg2NAyI4MSOYb2xU3WpMyYI
         KQSQ==
X-Gm-Message-State: ALQs6tA3SWIazhkq4/Dmr8DMs/6Ghco7PbnSbrMhCx6QRlyTqJ/WXbXW
        aDioXlkssA1H0YUlDC8jFz1yIung30+MbgSS1pOSaMuG
X-Google-Smtp-Source: AB8JxZpmrapcsNsV57C4YiFgHCWRnX4PBZz+G8FHcRajK0cw2FXORXy7d+8UnSzH+LNICC8US1vZ2xIRLXo3e76dHDE=
X-Received: by 2002:a25:6cc2:: with SMTP id h185-v6mr28929030ybc.307.1525891951199;
 Wed, 09 May 2018 11:52:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Wed, 9 May 2018 11:52:30 -0700 (PDT)
In-Reply-To: <cover.1525868167.git.raa.lkml@gmail.com>
References: <20180508121104.rtsrektxiihvpqtx@pflmari> <cover.1525868167.git.raa.lkml@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 May 2018 11:52:30 -0700
Message-ID: <CAGZ79kaqp2sOU76+uQOvzvh_ojJf1O2YqmnmAU2UM-Jm+ZFQ8Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gitk: improve handling of submodules in the file
 list panel
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Alex Riesen <raa.lkml@gmail.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 9, 2018 at 5:35 AM, Alex Riesen
<alexander.riesen@cetitec.com> wrote:
> From: Alex Riesen <raa.lkml@gmail.com>
>
> Currently, the submodule entries in the file list panel are mostly ignored.
> This series attempts to improve the situation by showing part of submodule
> history when focusing it in the file list panel and by adding a menu element
> to start gitk in the submodule (similar to git gui).
>
> This iteration does not address the behaviour of file list panel in tree mode
> when gitk is started from a subdirectory (gitk strictly limits the file
> listing to the files in that repository, without a way out).
> I would like to hear some more opinions regarding changing its behaviour to
> always list the full tree.
>
> Alex Riesen (2):
>   gitk: show part of submodule log instead of empty pane when listing
>     trees
>   gitk: add an option to run gitk on an item in the file list

both patches look ok, to my untrained eye.
