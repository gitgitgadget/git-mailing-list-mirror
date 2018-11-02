Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05AEA1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 18:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeKCDnW (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 23:43:22 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:52807 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeKCDnW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 23:43:22 -0400
Received: by mail-it1-f180.google.com with SMTP id r5-v6so4449543ith.2
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9XVrSK7sQqFeIr6n7+jSQTY7IXYi3VfubS2ZEj1eRRo=;
        b=r8rUxahqerA7BdCRBCcjvwbhI9DdGQP7ZLQkKCFeNLD1RL6vUGDO/nuzqujlgVxKk0
         Nu2ZaBJWMWvthIozY/tKleKHXu3bbvsBnUDWxXj/dFdnLLdj0ELeh1lzHyBFKfKeIS0C
         zECTXCM3xC5aqjpTbJ29DSju2cxrQ54bGPB2KmlGH8ja3+MlEWyKrOQZDXJLU6I0IzIX
         Hs+QxP9puwmgf3ccjTxVZQUHjstGXyDre0hNh5hvjbuUzNW/Q2TwG3KkGkI5K4ZPlmRV
         N8I66rSzt9KcRhLPnGvT+L1QJoeGp/WS3+ul3PGD9ddFujUQIgoYWlAHXMoca0gGksnC
         fl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9XVrSK7sQqFeIr6n7+jSQTY7IXYi3VfubS2ZEj1eRRo=;
        b=SO/hPfO2+eDVOnGCYovY0WqxHcHDtdjMQOaxKcUyJFDU3ntQ18hZZEPSxett6md0M4
         pUWxEcSyACJT8FDZZJfjdF4sR2wIV4utsrODI3POeW4N+nuWgyLprIFR/eVKTSnn1pXT
         pFYf7VSaxeSxKrxQpEPKbkDdp9r05v3NKZlsX0Inj5j36bVzRTJAjd1eGHloeV2hO201
         mE3IGYPWLd/bkaDDARafhwjwftr92pgxDZuvGBwDHtzTfS0UFAOOnClRwbXg39DMtfuW
         RsU8XrPSGWOyqs1s9K7cF6n7D9VS9Gh7ogCknXFmYc0mGoHIMQl2lHgaAvr961FakClf
         XUCw==
X-Gm-Message-State: AGRZ1gJaJJgZterttK2UGFAad++Xwq7+ORoK7SVTlR5Nz7P17X5x21cA
        qeOmJuQuT++6iHSPtf9axbqEsyz7y1uz4pFXGCI=
X-Google-Smtp-Source: AJdET5dXW58YwAo+wtyE4ict+a4H4//I+Gd1kDCiJNMSKr52/so9PqgUc80lMo0tQxRY4z/JGj+YHlRaoGCObpsleEc=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr107441itc.123.1541183711893;
 Fri, 02 Nov 2018 11:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8AVfkWsAP_-CNd5RSbQ=tyCzdw-ix1k5zwmAKaj+z1qXw@mail.gmail.com>
 <CAGZ79kbk0QdxTNWusieU=3DzTvxykmh-yTgNArTcM9USc5WWRw@mail.gmail.com>
In-Reply-To: <CAGZ79kbk0QdxTNWusieU=3DzTvxykmh-yTgNArTcM9USc5WWRw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 2 Nov 2018 19:34:45 +0100
Message-ID: <CACsJy8AZ=re0wAabHbRV0R7s-CUMJR8G6aeMx9cb++RvGY59Vg@mail.gmail.com>
Subject: Re: submodule support in git-bundle
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 2, 2018 at 6:09 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Fri, Nov 2, 2018 at 9:10 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > I use git-bundle today and it occurs to me that if I want to use it to
> > transfer part of a history that involves submodule changes, things
> > aren't pretty. Has anybody given thought on how to do binary history
> > transfer that contains changes from submodules?
> >
> > Since .bundle files are basically .pack files, i'm not sure if it's
> > easy to bundle multiple pack files (one per repo)...
>
> That is a really good discussion starter!
>
> As bundles are modeled after the fetch protocol, I would
> redirect the discussion there.
>
> The new fetch protocol could support sending more than
> one pack, which could be for both the superproject as
> well as the relevant submodule updates (i.e. what is recorded
> in the superproject) based on a new capability.
>
> We at Google have given this idea some thought, but from a
> different angle: As you may know currently Android uses the
> repo tool, which we want to replace with Gits native submodules
> eventually. The repo tool tests for each repository to clone if
> there is a bundle file for that repository, such that instead of
> cloning the repo, the bundle can be downloaded and then
> a catch-up fetch can be performed. (This helps the Git servers
> as well as the client, the bundle can be hosted on a CDN,
> which is faster and cheaper than a git server for us).
>
> So we've given some thought on extending the packfiles in the
> fetch protocol to have some redirection to a CDN possible,
> i.e. instead of sending bytes as is, you get more or less a "todo"
> list, which might be
>     (a) take the following bytes as is (current pack format)
>     (b) download these other bytes from $THERE
>         (possibly with a checksum)
> once the stream of bytes is assembled, it will look like a regular
> packfile with deltas etc.
>
> This offloading-to-CDN (or "mostly resumable clone" in the
> sense that the communication with the server is minimal, and
> you get most of your data via resumable http range-requests)
> sounds like complete offtopic, but is one of the requirements
> for the repo to submodule migration, hence I came to speak of it.

Hm.. so what you're saying is, we could have a pack file that lists
other (real) pack files and for the bundle case they are all in the
same file. And "download from $THERE" in this case is "download at
this file offset"? That might actually work.

> Did you have other things in mind, on a higher level?
> e.g. querying the bundle and creating submodule bundles
> based off the superproject bundle? 'git bundle create' could
> learn the --recurse-submodules option, which then produces
> multiple bundle files without changing the file formats.

This is probably the simplest way to support submodules. I just
haven't really thought much about it (the problem just came up to me
like 2 hours ago). Two problems with this are convenience (I don't
want to handle multiple files) and submodule info (which pack should
be unbundled on which submodule?). But I suppose if "git bundle"
produces a tarball of these bundle files then you solve both.

But of course there may be other and better options like what you
described above. If in long term we have "pack with hyperlinks" anyway
for resumable clone and other fancy stuff then reusing the same
mechanism for bundles makes sense, less maintenance burden.
-- 
Duy
