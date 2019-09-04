Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A84CB1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 19:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbfIDTUv (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 15:20:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44589 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730436AbfIDTUv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 15:20:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id y4so9950338lfe.11
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 12:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Y7aggwkL+Ki4jHy1ac1Z0AbPX2JpSAQqIXeQHhceoo=;
        b=t0f8uj117gXjtTBLxLGApaUCro2SlUhnYaTyWEbXoImdDWHa/d64gQkloycZEWNlpb
         7Y3e8FnTxQaoH+clfDJPya1+3m68CwJPpal3Ap3JL/Ee9iCC6KIYFz8FU0Z0rSLolOzt
         ANgK5lr8D1QCu1N3FVj/0YoD+4/3J1J9oGv8SAZzIkh81v+rdTfF5GGg/G68FugZiJgi
         fet5p8mo6hOxjQpTDoktqsUK7uE4k+e6cxDa5XQXQXGP5pHMmljik95ExFgFEKsBj3Mn
         +sk47FFr+DW9LXhU+MTm5vJGco5WdiErNJ3lrWSI1+nO1qkzHXY2a59q7bSrqle87c/S
         7Arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Y7aggwkL+Ki4jHy1ac1Z0AbPX2JpSAQqIXeQHhceoo=;
        b=ojo3EhsmoS3wxjMKm8OWQn6/Wap9PaoUQ9UnoWCWVe7DVei8OV9j090NJV99Q471dW
         dRqSA+FuofV/S3kO6LHt+1FqgK6idMLeleFFSLVEXVE4GoYLTUXWw4NU24PJgUwEWCzv
         y+Cek8UyvHE/IE+FsJO5iBexMpPhZsrMtZgLp0KEJ8jiU9RptNgtMVoC1R4u6sTmuCY6
         BKzGx532r2ovzkpyXQUu7idysHVtR2Mr0hVrIhaowGCOrNgFVLG2Z9g0Sy2NFBUgKrbX
         kKhpN197iOKw/BNM8DSvZ/NOHh+wVE7YeUcF5VFPFB4xPUMCnxH0hQaexEmiKi4I5wtq
         CQUQ==
X-Gm-Message-State: APjAAAXM9k6cpPemcGb0KZDhCvjHDdScus6A38VgBscoV1OtBAn0J4Ef
        lXqcB/gT3UCYDhY80LNM88AeJwnQTZUQo3KShS9SBTY1y7u/5Q==
X-Google-Smtp-Source: APXvYqwEZL+GVkN0oTGKSVuC1ahxl7paDpcknNjjTpQ57VE9BEZxw/03jilGD2K4jwyIopzZBM4e/McUvoGbcyW1x8E=
X-Received: by 2002:ac2:5445:: with SMTP id d5mr7728564lfn.43.1567624849249;
 Wed, 04 Sep 2019 12:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190903214942.ubcbdgtphpwnaxs6@yadavpratyush.com>
 <20190904143055.11400-1-birger.sp@gmail.com> <510e80f4-a8e1-329d-2395-b1268bf7c1f8@kdbg.org>
In-Reply-To: <510e80f4-a8e1-329d-2395-b1268bf7c1f8@kdbg.org>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Wed, 4 Sep 2019 21:20:38 +0200
Message-ID: <CAGr--=LY4JWdms3GtnKAtN6z-2c-jpXE2HJ5_dMM5gEFayrj_g@mail.gmail.com>
Subject: Re: [PATCH v5] git-gui: Add hotkeys to set widget focus
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git List <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Wed, Sep 4, 2019 at 8:59 PM Johannes Sixt <j6t@kdbg.org> wrote:
> Many keyboards do not have a right Alt-key. That means that Alt+1 to
> Alt+4 combinations must be typed single-handed with the left hand. This
> is mildly awkward for Alt+4. Can we please have the very important
> commit widget *not* at Alt+4? I could live with Alt+3.

(RightAlt wouldn't be used by Europeans, anyways)
Are you suggesting to keep Alt+1/2/3 for the files/staged/diff
widgets, but use something other than Alt+4 for the commit dialog? If
so, which one would you prefer?
The initial propsal from me was to use CTRL/CMD+1/2/3/4. What do you
think of using the CTRL/CMD key instead of ALT?

Birger
