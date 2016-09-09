Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A46A1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 16:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbcIIQ6G (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 12:58:06 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35657 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbcIIQ6F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 12:58:05 -0400
Received: by mail-yw0-f181.google.com with SMTP id j1so50551968ywb.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 09:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2xyfhr7GQYTl6hjxvNL7c84/AaqFsudtIUtDLDjCq9c=;
        b=cEz9vipd4pPCp0vhAqr1rixG9L7wMa/DVmBlLK/oKP+Awwh/apWdZSrvgHp5X2x9xu
         UElUVhBHWAYUO7XNoCseoK1XBy4w6Gsq+5LRnlHBBYUm87nnVyWaa/v1I323bRDALAHy
         gS5liakWL8RMZKaGEd4XI0FNMCM6mSXbp6Uczpmy7mflpXlIBq9G7JtiUAQUz7tG44EE
         +M5DjUJm18Qm0WrvnekwAQ0W4X/OeO8CMiXKoppvkq5RLxTWn4YbbCSyO4tBUfOLFWHd
         1/dlgkVHvfr6c9oWmB0YGE5Q54OYpWSUYz+3G6tIarXYPy3teYlGMNZp2pwrPvm0Bmjc
         Y2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2xyfhr7GQYTl6hjxvNL7c84/AaqFsudtIUtDLDjCq9c=;
        b=TEkR6o1mLplOug/mHvqSW1uWsL3i1j+gM7fu3YMdlkiY8PbNoRAlADLXovJBo6fsCX
         zd11t8aUTPmy4IKrP259WfCd7LBcu4Ezlz0zRHWay78mFptd9jCp90g4l6lMu3/1S/y3
         t4sB8f0APQc1jkayNqoCNEoMkgb9QlfIsAxytsf7LSUNJlRzrpKgeXsmPTieAav64Yvb
         pp/Zd4vNiqO4o4H/gLTrreNDs6Sd3lFD7yTz3oWhiXE8eVz8xr9d9Hak0hvp1AvIzMuZ
         e5WomyU0u1D2P9Waby9Ja9ttQpykKayZc32cW95/FRh8MZ4vK37bjYjMbdqihnoMBVlO
         gGFg==
X-Gm-Message-State: AE9vXwPZIofvyE58fr111cik3JgN4uX+ITPpCZUDujFS5aYNIzxnSdE0gH+LH3/RCWej++E3N6ZsvGKho4EnRw==
X-Received: by 10.129.125.84 with SMTP id y81mr4407340ywc.234.1473440284499;
 Fri, 09 Sep 2016 09:58:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Fri, 9 Sep 2016 09:57:44 -0700 (PDT)
In-Reply-To: <87zinmhx68.fsf@juno.home.vuxu.org>
References: <87zinmhx68.fsf@juno.home.vuxu.org>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 9 Sep 2016 09:57:44 -0700
Message-ID: <CA+P7+xoN+q_Kst=qXG_HRznxbN7cbyi5uZe15zq1c16EifeK1Q@mail.gmail.com>
Subject: Re: git commit -p with file arguments
To:     Christian Neukirchen <chneukirchen@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 5, 2016 at 2:08 PM, Christian Neukirchen
<chneukirchen@gmail.com> wrote:
> Hi,
>
> I noticed the following suprising behavior:
>
> % git --version
> git version 2.10.0
>
> % git add bar
> % git status -s
> A  bar
>  M foo
>
> % git commit -p foo
> [stage a hunk]
> ...
> # Explicit paths specified without -i or -o; assuming --only paths...
> # On branch master
> # Changes to be committed:
> #       new file:   bar
> #       modified:   foo
> #
>
> So why does it want to commit bar too, when I explicitly wanted to
> commit foo only?

It wants to commit bar too because you already added bar before. It works like:

"git add bar && git add -p foo && git commit" does it not?

I fail to see why "git commit -p <path>" would unstage the bar you
already added? Or am I missing some assumption here?

Thanks,
Jake

>
> This is not how "git commit files..." works, and the man page says
>
>             3.by listing files as arguments to the commit command, in which
>            case the commit will ignore changes staged in the index, and
>            instead record the current content of the listed files (which must
>            already be known to Git);
>
> I'd expect "git commit -p files..." to work like
> "git add -p files... && git commit files...".
>

I guess the part about "git commit files" is different from "git
commit -p files", which is confusing.

> Thanks,
> --
> Christian Neukirchen  <chneukirchen@gmail.com>  http://chneukirchen.org
>
