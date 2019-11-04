Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 457501F454
	for <e@80x24.org>; Mon,  4 Nov 2019 17:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfKDRgW (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 12:36:22 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38545 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfKDRgV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 12:36:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id v8so2940025ljh.5
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 09:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deltaq.org; s=deltaq;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5nZRIJtXKv9d/CTm4haGCyv4qAMDOLbIeF1k/OrKH/I=;
        b=IcC5zepKtIeoncmVkNDKNpBqN+q7hiVraF0OlCYYCWzMWRvD1qioE06WcwsqCNkPNT
         g7ZU5TlKGRedzHCf6T7UWjHwM2E/WTaIYZZyUG0+Mt9Q8J+dCbQaUZCe+Vdc1KAI8HkH
         t8HcIPVneQL4RA/mPKG1ftUTl9nM7igs5Zwg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5nZRIJtXKv9d/CTm4haGCyv4qAMDOLbIeF1k/OrKH/I=;
        b=l0bgXy+rVG1NKGGnCbapnYzJb3ROHSZifXQFvuPmVRUP26E5zidtHCb0LArXuiBDIw
         cf4Q4PCHUXi3kktwvZVUYbniqL5xc4RmIvAWTcQsJzgpekBxwplBtmm+zz6fM/txZoAs
         t8Z6JOu9AYGyhASPLHaTHdooODz3i2QoAA+BQvUp7LNE0Zne3LYLET68nvH45d5QRfV0
         q/IZWiMgngBOFGJcOhOgBaZSnCTREdITYVSpsxYsmE5h6Zb3T9Y1B+kdTs0JTZIlHNbc
         6Z3rGUisy1X+bc4p4XfnbiCUH4OV919cmRDK8L1F5KtvMh+19QX/JZfBgsFTUddPfRwe
         DP7A==
X-Gm-Message-State: APjAAAXi6/d82gjARUPJyHX4cP3GVTtWXrlEyt61so6bYq9SWWq3Smij
        IioHkQeeg/YgNY2p0ciDMPSoFRPcrU38wHOfyp4LqQ==
X-Google-Smtp-Source: APXvYqxnyjqAC5vfp2cykFb7lgO6fyJWRnpBSDZ7jyeHEjfW2EXhEXvzwKN124Tdr3TJQE50EEsi5f/Q+Jim+33hAuw=
X-Received: by 2002:a2e:9610:: with SMTP id v16mr211572ljh.219.1572888979183;
 Mon, 04 Nov 2019 09:36:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.436.git.1572418123.gitgitgadget@gmail.com>
 <0190f6f2f978a674a29a1e2013d00bc289851c76.1572418123.git.gitgitgadget@gmail.com>
 <20191103074453.56ubga6eitjhp6rf@yadavpratyush.com>
In-Reply-To: <20191103074453.56ubga6eitjhp6rf@yadavpratyush.com>
From:   Jonathan Gilbert <logic@deltaq.org>
Date:   Mon, 4 Nov 2019 11:36:07 -0600
Message-ID: <CAPSOpYtBRvDX4by_k_ViuFN66vKx=WM7zcQ_JXivxApDBOGJ1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-gui: revert untracked files by deleting them
To:     "Pratyush Yadav me-at-yadavpratyush.com |GitHub Public/Example Allow|" 
        <172q77k4bxwj0zt@sneakemail.com>
Cc:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 3, 2019 at 1:48 AM Pratyush Yadav me-at-yadavpratyush.com
|GitHub Public/Example Allow| <172q77k4bxwj0zt@sneakemail.com> wrote:
> > +             after idle [list after 0 [list \
> > +                     delete_helper \
> >                       $path_list \
> > -                     [concat $after [list ui_ready]]
> > +                     $path_index \
> > +                     $deletion_errors \
> > +                     $deletion_error_path \
> > +                     $batch_size \
> > +                     ]]
>
> Using `after idle` means in theory we put an undefined maximum time
> limit on the deletion process. Though I suspect in real life it would be
> a pretty short time.
>
> Nonetheless, should you instead do this asynchronously, instead of
> waiting for the event loop to enter an idle state? This means using
> `after 0` directly, instead of doing `after idle [list after 0...`. I
> haven't tested it, but AFAIK this should also keep the UI active while
> not depending on the state of the event loop.
>
> What benefits does your way have over just passing the entire list
> (without batching) to an async script to do processing in the
> background?

I forgot to include this in my point-form list at the end of the
preceding e-mail. What should I be looking into to achieve the same
sort of behaviour, where the UI isn't frozen and the user is getting
period updates about the progress of a large deletion, without using
batches on the UI thread? Is that a thing, or am I misunderstanding
you w.r.t. to doing this asynchronously?

For what it's worth, I used `after idle {after 0 ..}` based on the
recommendation of the Tcler's Wiki [0]:

> An after idle that reschedules itself causes trouble, as the manual warns (PYK 2012-09: the docs no-longer contain this warning, but it still applies):
>
>      At present it is not safe for an idle callback to reschedule itself
>      continuously.  This will interact badly with certain features of
>      Tk that attempt to wait for all idle callbacks to complete.
>      If you would like for an idle callback to reschedule itself
>      continuously, it is better to use a timer handler with a zero
>      timeout period.
>
> Even this warning is oversimplified. Simply scheduling a timer handler with a zero timeout period can mean that the event loop will never be idle, keeping other idle callbacks from firing. The truly safe approach combines both:
>
>     proc doOneStep {} {
>      if { [::sim::one_step] } {
>          after idle [list after 0 doOneStep]
>          #this would work just as well:
>          #after 0 [list after idle doOneStep]
>      }
>      return
>     }
>     sim::init .c 640 480
>     doOneStep
>
> This skeleton should be considered the basic framework for performing long running calculations within a single Tcl interpreter.

Thanks,

Jonathan Gilbert

[0] https://wiki.tcl-lang.org/page/Keep+a+GUI+alive+during+a+long+calculation
