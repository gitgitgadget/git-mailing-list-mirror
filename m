Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AEAD1F859
	for <e@80x24.org>; Fri,  9 Sep 2016 10:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754023AbcIIKzD (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 06:55:03 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36455 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753820AbcIIKzC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 06:55:02 -0400
Received: by mail-oi0-f42.google.com with SMTP id q188so18364592oia.3
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 03:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ru3jvSRoIbIFffcr/Q6Fqa6AEptoKJhiLhwCv9cLpww=;
        b=A9KuDoN+OTGMdnaaAjKIvhRpXO+UTijE0M23c5X13Jm+A5c0YR/pEGyMA09CD6WVIm
         PusL34+Nj/dtObr9aqbAFAQqIXPkixvoHvWsFqZ6xLyG6TJbplIhda1nXcCDs8ajAHb8
         A5fMD+qHEq5qls/qQ4FVo1VC3cfpyQHTg/LaXAv4xlI29YlZZR3KIvwxxGsqJHVNa7wa
         Lmjr5+dEAnY3KLsSXyAe/VpGpFghwUAdG8k0Gizzdoa2xXNZNEc+VToDISdkX/7eJ3FM
         FlvAnQItDKPmcoUfslTXEMwQt+yngPCWIA+gyk2WLkCblN9KvMj2T/a8F/Vl8AdB+diD
         X+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ru3jvSRoIbIFffcr/Q6Fqa6AEptoKJhiLhwCv9cLpww=;
        b=fiir+WPnHN9qJ9fGd9TGYWCp951A63/YyHyLjMv01sBsLU0eJhjDk+E7Ob6DB8lNGQ
         I8iYSXBLANOiLNbvN1AWJpmipdD30Hus0EY6BUAEJ5rl7UUzBqG6Q5PzN/9bdPCsvrKs
         54v+hkkbCanf09QMlNPfZ3TzJOefHUoKjjvsCLMNNyHD/4elMHqFNxAQnigVzw/mPI1M
         QgLf8x4RGilaHOjJy8VNZNTPM4EBAdgtMhbRvXSPKrq19QeJ07w4QjVjqJ4ywTxG8bwZ
         LGE1GVPgxfCdAwNiy0mwFmRAz4EKqlTUjJsuoDJN4J9L7tsm6Qb4sf+pmE+KTlUViASs
         RFig==
X-Gm-Message-State: AE9vXwOI9rZ3HbkXvSuhzkWtIAhrBGNOg+eiN15MNYfS417qd18oUcK5hBSdFeTAzsPNKmGraQzsNvMaof4bjg==
X-Received: by 10.202.235.9 with SMTP id j9mr4780308oih.103.1473418501395;
 Fri, 09 Sep 2016 03:55:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.54.40 with HTTP; Fri, 9 Sep 2016 03:54:30 -0700 (PDT)
In-Reply-To: <87zinmhx68.fsf@juno.home.vuxu.org>
References: <87zinmhx68.fsf@juno.home.vuxu.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 9 Sep 2016 17:54:30 +0700
Message-ID: <CACsJy8DOqoW8quz-6qSVR2+3aJau2V=qXCx_SoZvBpmU+9+Oxw@mail.gmail.com>
Subject: Re: git commit -p with file arguments
To:     Christian Neukirchen <chneukirchen@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 6, 2016 at 4:08 AM, Christian Neukirchen
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

The paths after '-p' could mean two things, either as a filter (e.g.
like in "git add -p") to help save your time going through all changed
files, or as "git commit files...". I think the paths were meant to be
filter when '-p' was added. There's a separate bullet point git-commit
man page, number 5, in about --patch, so that paragraph you quoted is
probably _not_ about --patch. Either way changing its behavior now
might surprise users used to it.

At the least I think we should clarify this in the document. Maybe we
could add --patch-only as well, which commits just what you select in
--patch mode, ignoring anything in existing index.
-- 
Duy
