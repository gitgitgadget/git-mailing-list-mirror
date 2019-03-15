Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B5F120248
	for <e@80x24.org>; Fri, 15 Mar 2019 13:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfCONmX (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 09:42:23 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54816 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbfCONmW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 09:42:22 -0400
Received: by mail-it1-f193.google.com with SMTP id w18so10168556itj.4
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 06:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lNFEIWBvmTWNyIvSP6w6hUDs7Rsw7FJ/TNkb5/SAzQk=;
        b=j43VYbZf+r99kXrYvj//SMWFYls4pp6hMKcKV4+rfcTVM7JHwvpSJF/OdzKZ703Uto
         O6MuoFOUDC+tmsSfh0sCtRnSfo/cgP+ycOu2zD2jnh4EqU0x58dUVii4/b8mEzIT8kyB
         9PPvVDwoA9q4gYmOOiTDqNricsCVXuC/XK402Wt3XV9vvNzCSFTtHnFQYlFe/n1mPsx2
         wKvX6+uR4CAl/7ACtD/TAwr5W4dwNgSMT0R2/JKLtfh22IozQObqTy4LYWJ6IqnzgCbu
         2cGJ31yqywSSpo9tWOiUD9XKIBGXli5N8/jDuhM7h0aiGrjjUgro4yQ7+JNJxG7/F4S+
         5kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNFEIWBvmTWNyIvSP6w6hUDs7Rsw7FJ/TNkb5/SAzQk=;
        b=FPXn9pkvMtR9UHjuAtq9mChchLW+mFH3OiWbOIGESEkvZ7M6d10+Wp1/qMQqnbN5cy
         5xBdbGihKmEhBblJq9oqHdpgRoaeUHAPH8wPxLOzlsZRA8Xqcz/qg8vm/5AdXVwZMx1k
         HJ4EmggLmZmTncXwl+C0sfN0SnVpJYlDEmIaoTiIf0KgWmwgUzYVfxrbmoQKthHx6Kfx
         c92VegV0aDLFQm54cg3iTQcUSKwYcbebJJ/1eNxE2rP0eSVeUzBCIFzsST0xyCqOzvs7
         3yU5z8rex2eJZGzlKQH++/G8lB0DF9+ntEE1vADIZeVvgdi4UVaTi676/B5FicIFmBQZ
         hH4Q==
X-Gm-Message-State: APjAAAWxnV+6sjdd5n9H9gvvelVzdoa7fTpjR+X1DZ+wByTPtwjwvNro
        n17t3NZgb5C1OnDK0nGSQhuMhWLVw9g93Wtf1Cs=
X-Google-Smtp-Source: APXvYqzOOBIE9LlEWa1rA/ql3mYrZRe5HbYU/HLl2H3BmggH8rty3Y4LEfItm4IXeI8a7/hXryqeqHsyBLGx6AlTDBw=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr2036342itf.123.1552657341830;
 Fri, 15 Mar 2019 06:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1903150809070.26709@localhost.localdomain>
 <CACsJy8DVRJ4DG6PEkFuzytOQJ7RX6GMaHd4BRQTR9N7Y9V6fqQ@mail.gmail.com> <alpine.LFD.2.21.1903150917360.27423@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1903150917360.27423@localhost.localdomain>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 15 Mar 2019 20:41:55 +0700
Message-ID: <CACsJy8CspqxDhOZFF7ac_63TQXvsHjTBicEPtZaUSOmaQnzs4A@mail.gmail.com>
Subject: Re: "git clone --shallow-exclude ...", fatal: the remote end hung up unexpectedly
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 15, 2019 at 8:19 PM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>   this is the first time i've played with this feature, so i'm still
> working my way through the man page, trying to figure out the various
> valid combinations for shallow cloning.
>
>   i notice that the SYNOPSIS for "man git-clone" does not contain all
> of the supported options (eg., --shallow-exclude is missing, among
> others). is that deliberate?

No. It's either laziness or giving up on adding every option in the
SYNOPSIS. Improvements are welcome. I can see now that --single-branch
is mentioned in --depth (the original option to make a shallow clone)
but not on the newer ones. My bad.
-- 
Duy
