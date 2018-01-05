Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DEAC1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeAEU0a (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:26:30 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:40856 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbeAEU03 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:26:29 -0500
Received: by mail-ot0-f179.google.com with SMTP id d10so4861983oti.7
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NMwcl1TzrSV36rbrf4YjF0IEojXJr4FNjkgkHrvAKio=;
        b=PrTBOIXu2GeaVHmz0yfp5rev+E/9A1Igs8PJ81LlTCQ8bv7D9gcRGKrRFvNF3JcE7N
         mnLpHsME5OJfF/sbUBupgGTMIljTnoML/iHxaxi7uPc3iCuGu+b7zJ3HclRpqVsrr8XZ
         smegcJTK7B6JeEzhstMkXM0y8RxOBxZF2KEwEKbYLlrX9f6pbX5XSwz3/bYl+PqF8WhL
         wYXR8BuDzSNi7XbVbzarO4UhF7vbwEidYealj99xh64gOOimoXIswJupTLjB7KP0YkY7
         yHjuJV6fBrzRjrH2YlIykpR9LjrzitRNmwV/+QQPTl30gHnDrWCb0YxCQ7ZMYrm9DMhu
         XJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NMwcl1TzrSV36rbrf4YjF0IEojXJr4FNjkgkHrvAKio=;
        b=sMOXJ1QbKL49L1i7i36OWM6FjefFKAME/WqdfoVJv1KP8GKsBhTIcjRNndXARLWbJ4
         /KQG0Ev4hQ8CUP9F6rIW6Dsf9MOYfOwKm/2Ea9NSJlAu0lFY0bKY4gWC/rhClCqMpVEv
         VJvH5rKbE/hzgcpEC3MtRUDgjlLwcNRQzQrai/dLGsNlV8vkJSROgdyT4eiUqhXHZl7D
         SFpQ7bkyt35W+Y57qnLIowlcPwitHU6WrXyKUrB76Os/T7gbfvXNnFpS6fF0GFukDG5K
         N2Uroe3+WWalqx5P0M1URgrqfEa1PHvKOYpCDgwdzl2JP/djK9XaZ5MN6SvcY1qo/f19
         lTcQ==
X-Gm-Message-State: AKwxytd51N4Awmy1Zbay+NzkizfbKN6xPp5zuU32JclVlv8klTtEMKs0
        L06J7AVDWnt/cFgCOsL3bVinJryXeSO1m/I1RaKATA==
X-Google-Smtp-Source: ACJfBosZW+xGj+CDS5GdG3FuuS1jq/IEuj6d/AQ/bxmgg7RdWupdyRZR/Q5nfLfhG/JdoMHzoX3HAx7tSRiQHYg4/5E=
X-Received: by 10.157.17.51 with SMTP id g48mr2928931ote.186.1515183988318;
 Fri, 05 Jan 2018 12:26:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.32.133 with HTTP; Fri, 5 Jan 2018 12:26:27 -0800 (PST)
In-Reply-To: <alpine.DEB.2.21.1.1711012254380.6482@virtualbox>
References: <CAKbB5OwxQ4XtLXuu2w3QmuKryA=3iHupz=y0m2E1NH+Dwzd8Xw@mail.gmail.com>
 <alpine.DEB.2.21.1.1711012254380.6482@virtualbox>
From:   Matthew Orres <matthew.orres@gmail.com>
Date:   Fri, 5 Jan 2018 15:26:27 -0500
Message-ID: <CAKbB5OxZ1Mua0zNMpe8nt8cQbasUyfz0uNzOXL9FJXWrsqPN-g@mail.gmail.com>
Subject: Re: Git 2.15.0 on OSX 10.12.6: gui multi-select stage
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'd be glad to give it a try - but am unfamiliar with how portable a
manual build of Git can be used along side the version I have
installed via Homebrew - do I just use full paths to reference the
compiled executable from within my repository folder?

Thanks!

On Wed, Nov 1, 2017 at 5:58 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Matthew,
>
> On Wed, 1 Nov 2017, Matthew Orres wrote:
>
>> Using 2.15.0 on OSX 10.12.6, when I open git gui, and then attempt to
>> stage multiple files as such:
>>
>> * Left click first file
>> * CMD+Shift+Click last file to multi-select all files
>> * CMT+T (shortcut for Stage to Commit)
>>
>> Only the file I selected with the first Left Click is staged and my
>> selection disappears.
>>
>> I'd be happy to provide more system-level info if there's issues with
>> reproducing this on other machines.
>
> Maybe you'll be also happy to test things?
>
> I believe that we carry a fix for this in Git for Windows:
> https://github.com/git-for-windows/git/commit/3a5640fd3f0aa57edecc8dab455a97c5a15e6626
>
> The easiest way to test this would be to simply build Git from the
> `master` branch of https://github.com/git-for-windows/git (I try to keep
> it building and passing the test suite at all times not only on Windows,
> but also on Linux, it should also work on macOS).
>
> Ciao,
> Johannes
>
> P.S.: If you test this, and can confirm that it fixes your issue, I'll get
> this patch submitted properly to the Git mailing list (sadly, it seems
> that the https://github.com/patthoyts/git-gui project is sleeping beauty
> mode for a while now, otherwise I would add PRs there).
