Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 309141F803
	for <e@80x24.org>; Mon,  7 Jan 2019 10:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfAGKKY (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 05:10:24 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:53431 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfAGKKT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 05:10:19 -0500
Received: by mail-wm1-f46.google.com with SMTP id d15so314994wmb.3
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 02:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2IpcDOeIYxypIJ1fhMd9WIFi4lfW1q7TXXG/EXiUhGQ=;
        b=DY1deiQiHKZmDs4HiJ9hVZm371PWyIyk8A1cmdZ88Z+DBv5RtyDi8WoKEIhMuUCbW6
         vtdy5EfqdXHWCkViJ9DzzB7mLtUMJtUI5UmQyW/xPsQNSsRpMOInYAELjXXuCPockT3P
         vXP+jkFa7Byp1+3UCThOUqULteB/9xfUZLAns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IpcDOeIYxypIJ1fhMd9WIFi4lfW1q7TXXG/EXiUhGQ=;
        b=TZWcR8PBvwTkMF3gRAqUdTvLBzYAv1RuuFdv1EhAdefYVaSoUPlaOUzrv1MafOzPjB
         Q9rXEqOb5vyvXsBS8Yq8EMEp3XZDiE8CCzJro5XkYmaglicZgvt2g5bm3pbojxXDazdb
         XbsfEZDRYqMGip4F2Nis6QqIKR32A1jDDjruz1MskkACCMQd0052/JXia6f3Hegl+zOO
         0SzpAtNgLDxee1ikajnNhsqlF4YoXCXDwi9l5pwFr+5YcgfPvPjHXtvfIiFfJAtjViP/
         hL7jtR2imjSkpWhrslRkXcIsqyUFw2J4BZlz9fBGYfyZUG1KU6QeDz0SpJUxh3YDQFvM
         933g==
X-Gm-Message-State: AJcUukf4oHw3yn9nBlzYzWNNS535YsUWlmWX3/CeexCfywbi4HLpukhT
        S0mWcBresBPKMFXFLQIXzNXYrBlxjTl/5HP2W8e1oA==
X-Google-Smtp-Source: ALg8bN7BhCuDqp3RExfaAj8S+/Q2F35Uea2E6BKeVpOc1uDGiHIxFmUZcfxkBODrx16IVh6Kz7SRW2e2gwBgqN3otT4=
X-Received: by 2002:a1c:8484:: with SMTP id g126mr8739886wmd.117.1546855817024;
 Mon, 07 Jan 2019 02:10:17 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1901062337420.5908@fractal.localdomain>
In-Reply-To: <alpine.LFD.2.21.1901062337420.5908@fractal.localdomain>
From:   Luke Diamand <luke@diamand.org>
Date:   Mon, 7 Jan 2019 10:10:05 +0000
Message-ID: <CAE5ih78_w0kt0g73tAn1gH=zcGJAdmFWWhWn29cmT6gS_tdKug@mail.gmail.com>
Subject: Re: "git p4" fails when perforce login not needed
To:     Peter Osterlund <peterosterlund2@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 6 Jan 2019 at 22:48, Peter Osterlund <peterosterlund2@gmail.com> wrote:
>
> Hi,
>
> When I use "git p4 sync" to update a git repository from a perforce depot,
> the operation fails with error message:
>
>      failure accessing depot: unknown error code info
>
> When I run "p4 login -s" from a shell it reports:
>
>      'login' not necessary, no password set for this user.
>
> The following patch fixes the problem for me:

That's my fault!

Your fix looks good, thanks!

Luke


>
> --- /usr/libexec/git-core/git-p4~        2018-12-15 14:51:07.000000000 +0100
> +++ /usr/libexec/git-core/git-p4      2019-01-06 23:23:06.934176387 +0100
> @@ -332,6 +332,8 @@
>               die_bad_access("p4 error: {0}".format(data))
>           else:
>               die_bad_access("unknown error")
> +    elif code == "info":
> +        return
>       else:
>           die_bad_access("unknown error code {0}".format(code))
>
>
> Not sure if this helps, but running "p4 -G login -s | hexdump" gives:
>
> 00000000  7b 73 04 00 00 00 63 6f  64 65 73 04 00 00 00 69  |{s....codes....i|
> 00000010  6e 66 6f 73 05 00 00 00  6c 65 76 65 6c 69 00 00  |nfos....leveli..|
> 00000020  00 00 73 04 00 00 00 64  61 74 61 73 35 00 00 00  |..s....datas5...|
> 00000030  27 6c 6f 67 69 6e 27 20  6e 6f 74 20 6e 65 63 65  |'login' not nece|
> 00000040  73 73 61 72 79 2c 20 6e  6f 20 70 61 73 73 77 6f  |ssary, no passwo|
> 00000050  72 64 20 73 65 74 20 66  6f 72 20 74 68 69 73 20  |rd set for this |
> 00000060  75 73 65 72 2e 30                                 |user.0|
> 00000066
>
> Best regards,
>
> --
> Peter Osterlund - peterosterlund2@gmail.com
> http://hem.bredband.net/petero2b
