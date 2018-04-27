Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 319921F404
	for <e@80x24.org>; Fri, 27 Apr 2018 07:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757471AbeD0HgT (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 03:36:19 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:41512 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757153AbeD0HgS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 03:36:18 -0400
Received: by mail-qt0-f182.google.com with SMTP id g13-v6so1110350qth.8
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 00:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=oSXfpkg/pgRauEAmYtcHiJc0c0xyLstSxnFFm35HX3A=;
        b=Nvp2O/IB935sTYkbFkNZCBhRonCcoZTo28ETSfkG0fb3+w0R/oq+jGkoHDcpU0YVim
         w1nBNQGLSKeXX+KJ2efH7zfvyLMA7YLQbS4lk7iqOqNI65WTMZrq5oo0Qi5m3bbb048R
         j+XckSqUVcjSHyfBYhKybUTSlI2NdxiOrx+QwTdsSMShVzSU+tTHC9dkoZqzlJcWcxpW
         Z0rNPm0GdKLXFvfyIciNN4DynV9+nYSaACn2N7/gLIwyHGOfOp84LEvopVvnExuQWj24
         SrJxzaTFQilEboT2Tcb9HApRA3+V9oY2kqEsDQygEmMjTjQ0y0rZefmwAA8t+AKxOkaL
         KRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=oSXfpkg/pgRauEAmYtcHiJc0c0xyLstSxnFFm35HX3A=;
        b=c/NIbHfcKAKQdzdOuXXrus5omHThHgCCNtdtxVZ35Nbx3zPUX8YEZtOIiCBLxqg2wT
         dESQXxm+i+eWiX4Kp3RnU9+gSOtgomNtl3YVeYysmOkfKz8jnDy/+M5FZ2YL7YCH88yI
         gYxUMERhOKAxtj8DBSkqpVSX494U49D8gSoaDLY0ynBhyQp4u8KSPo2F/is5b7u9JQ6X
         sba529bkDjx4dQhOiUwPnWqvC4MOEXab6aeqZxRpA4wNGv8Kau7OVkRizaUFZz99B+SG
         L4NIWr7C4tRfbuDCbj/YW5H3nBdt0yD95YVeXFUbnGMxZxQyW3ZZ1Vt24Dbi/mGVCV6Z
         2Tew==
X-Gm-Message-State: ALQs6tBkUvPA01b8R3/0NcD+4qsFSS7yknmaX4bVlFETWQNTRX6VmTha
        ZhL5aaV4h1xx97gWA/Ul7BR/kfGZeIh9TD0px+I=
X-Google-Smtp-Source: AB8JxZqxFuDbJ4vpbMlou+qNVHo/l9hmhId9BguXFMqGdPvG/VV7RZdwfXCWpIoSVctAQmWL2DXhB3BvcNvPuigmbI8=
X-Received: by 2002:ac8:3267:: with SMTP id y36-v6mr1022824qta.25.1524814577407;
 Fri, 27 Apr 2018 00:36:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Fri, 27 Apr 2018 00:36:16 -0700 (PDT)
In-Reply-To: <20180424215635.9183-1-t.gummerer@gmail.com>
References: <20180423193848.5159-1-t.gummerer@gmail.com> <20180424215635.9183-1-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 27 Apr 2018 03:36:16 -0400
X-Google-Sender-Auth: 7cTc9ZbyjBOiDhN83jj-4Z48CMY
Message-ID: <CAPig+cRor4UXXZhoAkhOQfe6W+oC84YFmA-KwpLspuEh_A4Zng@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] worktree: teach "add" to check out existing branches
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 24, 2018 at 5:56 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Thanks Eric for the review and the suggestions on the previous round.
>
> Changes since the previous round:
>
> - UNLEAK new_branch after it was xstrndup'd
> - update the commit message of 2/4 according to Eric's suggestions
> - make force_new_branch a boolean flag in
>   print_preparing_worktree_line, instead of using it as the branch
>   name.  Instead use new_branch as the new branch name everywhere in
>   that function.
> - get rid of the ckeckout_existing_branch flag

Thanks. I did another full review of all the patches and played around
with the new functionality again for good measure. Everything looked
good, and I think the patches are now ready to graduate.

For what it's worth, the entire series is:

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
