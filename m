Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1CC420437
	for <e@80x24.org>; Tue, 10 Oct 2017 23:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbdJJXlY (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 19:41:24 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:55401 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbdJJXlY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 19:41:24 -0400
Received: by mail-qt0-f169.google.com with SMTP id x54so410515qth.12
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 16:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O/5E9TUh9dhx5jOUMpfUwxMuLkULo5tGE19W82GvGNQ=;
        b=fNgw50ydCSH6RBnQ7LhErlxfOUgOQs8qcCN+rF+odRYLEwP2wrukI7x+uk9Svfy2/m
         sLez6bkp6VRLRQQnTJSgnNiZGtCRgU4imCdpz3K31/cfAZk7g9USxTiGFzGtcbLiElIX
         xXsVfqmLkXujj/8cvsIFI82wzKR44zr/I846uZFhsQriVLADz1vyUE0skarHEBoge6dl
         kLLjZ+uWv8y8qpbS7QQ37bM55ZuwwJ4YHMuAEVL6cHREsmtoiWwMmlr9M3ogZnAS+6x+
         uguE27rzgYSGru7shya6d0TghwNZBvP/W9Xr4NYg2STR2Q+1ehz06+Y4FUkIF66WxUac
         OB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O/5E9TUh9dhx5jOUMpfUwxMuLkULo5tGE19W82GvGNQ=;
        b=XKtPG8v6iPzxu7W8ACsl9qgPW4dH54zjHBzgE+k7rdbcxf7Ds6RkBreeXs9X5Xu/Qe
         YifeqkRDbx9QfS9Bw7/86hBSR5O4XUTBnssWAkh1ZObOMJdsEu7LCFWnfZD9vUXAJe3O
         th2yDQry88J3m7WJyxA5qX4yUh0InghNPqedH67P4yGFqWNxtQaoa4H6xcKVsmPK7ufb
         /yepvGk5jTKWM3Jf4W1uj5v77+DuF2gR0zFljOVk2w5kDw1a7DlM1ZyPOhqPfRiJCI4f
         PD4GHWFxMab3eYHpyckTHtyaYEkGh6vi2ZECdMAbRVHZXqMn5vx+7gLkjxCJJQaCXTWC
         jW4A==
X-Gm-Message-State: AMCzsaXlJr2+TiwlwtBkSsBBMZnd6ZO5nijqyXk/Ii9FA3DxXo4qHn9f
        weL/hSPODwyYNmTEEW8bb1M0NTBqebKr43SKjo8xzQ==
X-Google-Smtp-Source: AOwi7QD3rDWfoJfRGvsYXDCQLEhVvi7TSDntr3gTm6hqrTih2nWPqmQl6i29O2Tdi2sHssmwG6SwQ+tLp3ITeCfjpLs=
X-Received: by 10.233.239.140 with SMTP id d134mr17089546qkg.308.1507678883257;
 Tue, 10 Oct 2017 16:41:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Tue, 10 Oct 2017 16:41:22 -0700 (PDT)
In-Reply-To: <xmqq7ew2pokm.fsf@gitster.mtv.corp.google.com>
References: <20171006222544.GA26642@sandbox> <20171006223234.GC26642@sandbox>
 <CAGZ79kZqaC-hFAa3dc7_j8Ah94Ua0+sAjcDUYBL0N-C_J4Bx4A@mail.gmail.com>
 <20171010130335.GB75189@book.hvoigt.net> <CAGZ79kZFtMxD8wf59SViOOc_mrhwTVr6v0ucAePp+-8hg_im-Q@mail.gmail.com>
 <xmqq7ew2pokm.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Oct 2017 16:41:22 -0700
Message-ID: <CAGZ79kaqAi2-2KfQqqW1TvBvmHb_13gjZSycY2GsVgakLWcxFw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] change submodule push test to use proper
 repository setup
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Josh Triplett <josh@joshtriplett.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2017 at 4:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> So you propose to make git-add behave like "git submodule add"
>> (i.e. also add the .gitmodules entry for name/path/URL), which I
>> like from a submodule perspective.
>>
>> However other users of gitlinks might be confused[1], which is why
>> I refrained from "making every gitlink into a submodule". Specifically
>> the more powerful a submodule operation is (the more fluff adds),
>> the harder it should be for people to mis-use it.
>
> A few questions that come to mind are:
>
>  - Does "git add sub/" have enough information to populate
>    .gitmodules?  If we have reasonable "default" values for
>    .gitmodules entries (e.g. missing URL means we won't fetch when
>    asked to go recursively fetch), perhaps we can leave everything
>    other than "submodule.$name.path" undefined.

I think we would want to populate path and URL only.

>
>  - Can't we help those who have gitlinks without .gitmodules entries
>    exactly the same way as above, i.e. when we see a gitlink and try
>    to treat it as a submodule, we'd first try to look it up from
>    .gitmodules (by going from path to name and then to
>    submodule.$name.$var); the above "'git add sub/' would add an
>    entry for .gitmodules" wish is based on the assumption that there
>    are reasonable "default" values for each of these $var--so by
>    basing on the same assumption, we can "pretend" as if these
>    submodule.$name.$var were in .gitmodules file when we see
>    gitlinks without .gitmodules entries.  IOW, if "git add sub/" can
>    add .gitmodules to help people without having to type "git
>    submodule add sub/", then we can give exactly the same degree of
>    help without even modifying .gitmodules when "git add sub/" is
>    run.

I do not understand the gist of this paragraph, other then:

  "When git-add <repository> encounters a section submodule.<name>.*,
   do not modify it; We can assume it is sane already."

>  - Even if we could solve it with "git add sub/" that adds to
>    .gitmodules, is it a good solution, when we can solve the same
>    thing without having to do so?

I am confused even more.

So you suggest that "git add [--gitlink=submodule]" taking on the
responsibilities of "git submodule add" is a bad idea?

I thought we had the same transition from "git remote update" to
"git fetch", which eventually superseded the former.
