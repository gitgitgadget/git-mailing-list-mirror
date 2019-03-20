Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DBA320248
	for <e@80x24.org>; Wed, 20 Mar 2019 09:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfCTJob (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 05:44:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46754 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfCTJob (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 05:44:31 -0400
Received: by mail-io1-f65.google.com with SMTP id b9so1319733iot.13
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 02:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8dmUM/felQQohDarMYqqlhrYHKeO18ZEBUWlDL19tNQ=;
        b=qIQrnf9erqH1s+Y3sDlnwaugIZ4hlRUhmanJzEOhqVEoUrW1x+orxOD8fFLU9WgVNb
         Na3ErlSMFW50ggXs9F+WmcbJNzOog+95O4oLysqPIrQaW1Mi/3RLfkQEYa/ofjDoRzZf
         3/QmfrFoE8GDkSCjS9YJ+aSGXAzjBjXhd8DMKBlfHD65bN7obC0DOFLjFshIh580lyd5
         GgvyPk+G1coOAKUrRrWnlb0w0OnQh5whqmZ8PlsolWu4s79QycILI0BFqBs+5eKK8pJl
         lt59QqER86DdBrNepp7IYUoc5RHc1/pn9zZWMTBGndUW4NyELbXEyM2gWwa8r7SCwA/K
         gzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8dmUM/felQQohDarMYqqlhrYHKeO18ZEBUWlDL19tNQ=;
        b=IQGkrcF8a3zCuHAEd/VkBGU7XGbfgOcw/EVkIhJjXMxg7Yw7FQRpX5hWg1srk3cb7x
         F5mdoGbwt/tYAzCNcUwR7rWGdD0Vew7EcXapOOYog2W1jK3GssRw2xKp+3axzvxu+KKf
         pu1D9KntHn5rvaTyGiLHtzhpXQ3dUignBqScMNuMnAdpXO2IzuJhRVIziaBNOP3vfHOf
         QvVXywQgBjkGewisBF0CDkcrx7f0kJED7rUryKBtBAFOyK+IFhYLBJpOrdfP2vcrj7Fx
         uIBT2bQ25MdFW3fKsc3r6bgg8c5lGWSAKKQOW28pdxAak4k2/rHEex+ZDCVsOXPl3u+s
         BQsg==
X-Gm-Message-State: APjAAAVm99sN7uXFkiX8q2BTFOTz/5gaj4OCdpweLPLjaOCZPGhgSldr
        lPJGaGo2ICpAYmaJX8wG/nMaapAVVvoK48EvFe4=
X-Google-Smtp-Source: APXvYqyBho8WzdmFf6naQ8r677to2LT43HtkQKmWM/edZjOGAS77fq91EwjvLVgFnMx7E7p8SC2Ec1k5tNYUHbhgwg4=
X-Received: by 2002:a6b:3709:: with SMTP id e9mr3870127ioa.282.1553075071106;
 Wed, 20 Mar 2019 02:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
In-Reply-To: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Mar 2019 16:44:05 +0700
Message-ID: <CACsJy8Av87XHBX0EKS3W-yZ0yKxfa47d9NaAeUGmh5icGiTGYw@mail.gmail.com>
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
To:     "C.J. Jameson" <cjcjameson@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 20, 2019 at 10:57 AM C.J. Jameson <cjcjameson@gmail.com> wrote:
> --m parent-number::
> ---mainline parent-number::
> +-m [parent-number]::

Careful with this. Optional argument with a short option means the
"stuck" form which is known to cause confusion [1].

Try "git revert -mX HEAD" and "git revert -m X HEAD". The first one
reports invalid number (good). The second assumes "X" not to be an
argument of "-m" and leave it for the caller (revert in this case) to
handle, which could do unexpected things.

Personally I'm not excited to have more stuck forms like this.

[1] https://public-inbox.org/git/20190208024800.GA11392@sigill.intra.peff.net/


> +--mainline [parent-number]::
>   Usually you cannot cherry-pick a merge because you do not know which
>   side of the merge should be considered the mainline.  This
>   option specifies the parent number (starting from 1) of
>   the mainline and allows cherry-pick to replay the change
> - relative to the specified parent.
> + relative to the specified parent. The default parent-number is 1.
--
Duy
