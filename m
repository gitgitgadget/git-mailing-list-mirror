Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 254DF1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 13:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbeDYNGy (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 09:06:54 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:42898 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752722AbeDYNGx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 09:06:53 -0400
Received: by mail-ua0-f196.google.com with SMTP id f3so9277075uan.9
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 06:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6V9sAEiLR4fSzvqtnaMC4YtLmgQpkXcfq6II/S/4Yho=;
        b=fXLtSRQ+WcAs1QvW8UeyzfUcI5Xx+bme2XPEmiYwhhXsQhop68S7Zfdn4F8pocun/x
         /UPIShpHOh1nwLYBNL894E7FfkqxCVTaSWIX5Vlr9G9TTyb5WZp30QAiz6gFxDSDEOYv
         5PtQgA4ptsMgfVlJqraoSU2opTXRgmPTE3jqSGLGvi3qbDkUZmKR0KmYCRIgnfp7rJ9L
         Ej+GU61gJjUYNYqp9owSSzV0uFn6DL0sY4TLkBmJ8THgz4QYBZg/fvYZjsMdICIyrCmX
         OTvojLnpxgeyXU8d3EP0VEqdcptBJEqaZ/gcGlSXXJqPtLzOKxC7fusd4uewYKEX8bPK
         +KBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6V9sAEiLR4fSzvqtnaMC4YtLmgQpkXcfq6II/S/4Yho=;
        b=I3O3X0c2fzmCWPdu8ok0CqmnZdngnCVz5Ytf5mUaqT35d7MK/G8I79hd1jGwupXLz5
         wUY57R5Hv/5xXcSSPS6qFOvqJxDCWDBSiRWUY66O6KOGCC52XlZoFiRDP8zVoDTaiL5+
         tyR51TdWPsVKPZ5UZrseqmIyrJ3olvhVfw8xlKh+r+0O3QUcGbXuIKL0OIPbXtceE5hq
         Ff5KBeQ8zUSyjfCeACU67AxLyIrHgsXjwkfOsd25cn/LVaf8d51ytvs00/q411C4qLMX
         zouZlzeiP12RYX/srQZ150r1j9CQbtoqZjliCdxsRMSOay8/dAW2Fdff4W3IIgFtGo0C
         LMkg==
X-Gm-Message-State: ALQs6tC04hsOR94mlA5POnOxTzdcNpP9VDLpp1CvypvqsDAHpCNT5WVr
        63R7ipW0hm+MtBEdo6f1GV3Syx/5i6w8ztmdWaM=
X-Google-Smtp-Source: AIpwx49P7vcft2qDzq8EqSA0x0xGYOES6P2M36Zpuz+WigGHY/JMC9UyOjfo6+Yg0UKVIyb3ZXb8WrLoxmP5FTsA/dY=
X-Received: by 10.176.91.86 with SMTP id v22mr14917425uae.31.1524661613075;
 Wed, 25 Apr 2018 06:06:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Wed, 25 Apr 2018 06:06:52 -0700 (PDT)
In-Reply-To: <20180421165414.30051-5-pclouds@gmail.com>
References: <20180415164238.9107-1-pclouds@gmail.com> <20180421165414.30051-1-pclouds@gmail.com>
 <20180421165414.30051-5-pclouds@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 25 Apr 2018 15:06:52 +0200
Message-ID: <CAM0VKjmZeVF6GV9ZRXLdwZJJyFi8oLnGvKe7tQYi_QRLoAk4Og@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] git.c: implement --list-cmds=porcelain
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 21, 2018 at 6:54 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/=
git-completion.bash
> index a5f13ade20..7d17ca23f6 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -835,18 +835,23 @@ __git_complete_strategy ()

> +__git_list_commands ()

Please add a comment before this function to mention its mandatory
argument and that is should correspond to a category in
'command-list.txt'


> -__git_list_all_commands ()

> -__git_list_porcelain_commands ()

Users can have their own completion scriptlets for their own git
commands, and these should be able to rely on helper functions in
git-completion.bash to do things like refs completion and what not.
Therefore, we tend not to remove or alter those helper functions in a
backwards incompatible way, because we don't want to break those
completion scriptlets.

Your patch removes these two functions.  At first I let it slide,
because first I thought that anyone who needs the list of all git
commands is better off calling __git_compute_all_commands() and then
using $__git_all_commands (same goes for porcelains), because it
involves less fork()ed subshells and external processes.  Then I
thought why would anyone possibly need the list of git commands in a
custom completion scriptlet in the first place...  what for?!

Well, it turns out that there is at least one completion script out
there that does rely on __git_list_all_commands() [1].

Please keep these two functions as a thin wrapper around
__git_list_commands().

[1] And in a rather curious way at that:

    https://github.com/github/hub/blob/master/etc/hub.bash_completion.sh#L1=
2
