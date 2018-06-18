Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D63A91F403
	for <e@80x24.org>; Mon, 18 Jun 2018 15:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935451AbeFRPGh (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 11:06:37 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36749 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935425AbeFRPGf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 11:06:35 -0400
Received: by mail-oi0-f54.google.com with SMTP id 14-v6so15121178oie.3
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 08:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hsaMEFcgsHxC7UpgwHkEnvM/E4k+qTFTJmE4mJuBewE=;
        b=fcnnzBA4942OdWdQrZxBaGEzXSj1DRioeuRYEoENn+X8vxqSKNWhlnC1SSVnSGVLUj
         E6Zg3x2l9k9pKCFKcnME4XrEyc+NhBI9NbbVvdkMV2bDapaQfDG7jpHiKUzPdzT8XWbA
         +VVgIfYsQ5O9QSYQoG+jOZyRvCHJAogHzLGM30o70Jkw5OC7l/eMqU2HM9Zye/t1dCGD
         YD4t58quFzmZQNlbGj6Tl7TuuOMJmnyAUyVgei4l426EEexEk0/gCr9+DYGJAFJDOdOC
         4cIYlmD3RXdtfkai2VDtBeg99PJmRg6+dsWbCQNN7Ooz+L1HGAeVZgMiget/QBFmWQq0
         p12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hsaMEFcgsHxC7UpgwHkEnvM/E4k+qTFTJmE4mJuBewE=;
        b=mraGLPcwMUjHAv/z+LdDB0nb9vd2vwElgL2I7vkVhfJLsgXwoj7psru8+VWH1PcKno
         I34goP8MpfhuCDSdhOrceNdHPgmu3uule0LxFzJbCg7ZcYlT3FZPIiX/MmPp0iwRXeXj
         tEfFnjYP4cTXPzTcf+NOCe2w/zoHw4+ntnIgJwDSczSuZPUy4YD3zG2EcazV83TptX+6
         WxoaiezLBN4TegoVUyWlZozBEsWOZ5FpOi+VhvSvqZszj82VmrJEWZ7s4LN5VwIr1PQ8
         XHLzcUdDS3G8B9sZpDp6y+QAhJpRooMq5xlbBBLUOXKCkR07vnWh/k2LC6uLeOLZth9K
         UwDw==
X-Gm-Message-State: APt69E2ZbrxtwINFUA05Le6dhla/h9LYK239MngqQZfr7147BGr8IAfG
        FJ3l4faMtAWPKks2n91bQjoqHMT5N9HmqGn5TzI=
X-Google-Smtp-Source: ADUXVKJBmLy0ShrSRKcPIRETFpqKFxQkFJ+4a3eUp52eWeV02wZgFLT+/Ks8K16icD7H4PBUgX8o/H9Yiieg0rkkJ68=
X-Received: by 2002:aca:fcc8:: with SMTP id a191-v6mr7636923oii.34.1529334394851;
 Mon, 18 Jun 2018 08:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180618111919.GA10085@book.hvoigt.net>
In-Reply-To: <20180618111919.GA10085@book.hvoigt.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 18 Jun 2018 17:06:07 +0200
Message-ID: <CACsJy8CJGditaq4CZfJctVAe9QCdapWQW=W--AumH-4RWWd=vA@mail.gmail.com>
Subject: Re: Adding nested repository with slash adds files instead of gitlink
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 18, 2018 at 1:23 PM Heiko Voigt <hvoigt@hvoigt.net> wrote:
>
> Hi,
>
> I just discovered that when you have a slash at the end of a nested
> repository, the files contained in the repository get added instead of
> the gitlink.
>
> I found this when I was adding a submodule and wanted to commit a small
> change before that. You get the slash by using tab autocompletion.
>
> Here is a recipe to reproduce:
>
> mkdir test
> cd test; git init
> touch a; git add a; git commit -m a
> mkdir ../test.git; (cd ../test.git; git init --bare)
> git remote add origin ../test.git
> git push origin master
> git submodule add ../test.git submodule
> git reset
> git add submodule/
>
> Now instead of just submodule gitlink there is an entry for submodule/a
> in the index.
>
> I just thought I put this out there. Will have a look if I find the time
> to cook up a proper testcase and investigate.

This sounds like the submodule specific code in pathspec.c, which has
been replaced with something else in bw/pathspec-sans-the-index. If
you have time, try a version without those changes (e.g. v2.13 or
before) to see if it's a possible culprit.

> Cheers Heiko



-- 
Duy
