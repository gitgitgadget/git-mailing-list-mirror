Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EC00202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 16:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbdJCQxO (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 12:53:14 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:54973 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbdJCQxN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 12:53:13 -0400
Received: by mail-qt0-f173.google.com with SMTP id i13so14106022qtc.11
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 09:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rvRI2pqsd0Dn/yfPE2Kry0abU7HEw4wdUFZGUMQgEOc=;
        b=lRdUp7PxmrrhM54w8qmV/OZjg2ACG8/NLH47e/VQ486e8o8sEfOxlDXsH9SnKD0kb2
         TSCgrQml3Gi+cO1YNx0iDq6+iekhD1aAkIvZGqk1RQPChB0ePhdLUSBoSg2mY2OLy9Gv
         3Pt299TkpnoYAn2VAkhb3J6U9IOLLbq6Ceu0O6o++AJDiPKQz5cK7kzSiRpFwP0sGMXT
         qAc4ZjXLNq+JL7h0crp7QhcoubFOz164K5XACc3OwYhEddL5l10le6QkxVhhFx43foz+
         6iWUesyeIZtRTM/P4frHzg9ByrXsOsSY1ZScsxCH02deHR6XwiOrnBBqdddeFkDgHJG8
         7eDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rvRI2pqsd0Dn/yfPE2Kry0abU7HEw4wdUFZGUMQgEOc=;
        b=NzMhnH+yKTouRCl3ZIYFOsVMUzJ83D1x64FgC52cs9zOlBVXA4f8ToaU7uQbHHtuW4
         L8iZUTnTIaZ5FIYgzJAj0eRHdOBmM1MqIYbVOrgWVjoqu4U+2/Y5ULsYX1FtjzmQzuoU
         4pX6/gRG0gOIv7xwAeuB+PRcbAXCwUjh6SHuylti07diyxRsF5lWZ2a89V6Yx0dfrieG
         6cRn+u0nWnoRJ4TgxucrBJ8+fWBN1/VuGRtwgonDS8nNC/rovRuARyoGQh+XCbnbiSbw
         m5OkmWFcyW1+OeqYbWTkuHwrOgfcTCWsWGjXio2m+MdX7LQbSWZ6P1sPrfiur+bpCBRQ
         66wg==
X-Gm-Message-State: AMCzsaUc7yjNhFVcrlMwzLemhS0mrGL882LinMIJEP60XPxxyGgEx0hr
        DcLyy06JXbnO7kbiqZRqhJcttag1zf4TnKgVA7HXqw==
X-Google-Smtp-Source: AOwi7QD+xUcnkJ7tSoC9OFve4OB9lNvRN/mlp/T88x/j5R4zndECDW4L5tO0Jz2yJSCotNk6VmM9DLxheY7F3zCB4pg=
X-Received: by 10.200.8.53 with SMTP id u50mr8447325qth.260.1507049592408;
 Tue, 03 Oct 2017 09:53:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Tue, 3 Oct 2017 09:53:11 -0700 (PDT)
In-Reply-To: <CAK7vU=0ztEwMPsGO4Cd1A5JEnxmwkF57QPKjjvjD8rBUB79dRA@mail.gmail.com>
References: <CAK7vU=0ztEwMPsGO4Cd1A5JEnxmwkF57QPKjjvjD8rBUB79dRA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Oct 2017 09:53:11 -0700
Message-ID: <CAGZ79kaBJnXW=rSiKuHpds79mXVL0Aoo+PBa0a5V-C_bop=Kbg@mail.gmail.com>
Subject: Re: Enhancement request: git-push: Allow (configurable) default push-option
To:     Marius Paliga <marius.paliga@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 3, 2017 at 3:15 AM, Marius Paliga <marius.paliga@gmail.com> wrote:
> There is a need to pass predefined push-option during "git push"
> without need to specify it explicitly.
>
> In another words we need to have a new "git config" variable to
> specify string that will be automatically passed as "--push-option"
> when pushing to remote.
>
> Something like the following:
>
> git config push.optionDefault AllowMultipleCommits
>
> and then command
>   git push
> would silently run
>   git push --push-option "AllowMultipleCommits"

We would need to
* design this feature (seems like you already have a good idea what you need)
* implement it (see builtin/push.c):
 - move "struct string_list push_options = STRING_LIST_INIT_DUP;"
  to be a file-static variable, such that we have access to it outside
of cmd_push.
 - In git_push_config in builtin/push.c that parses the config, we'd
need to check
  for "push.optionDefault" and add these to the push_options (I assume multiple
  are allowed)
* document it (Documentation/git-push.txt)
* add a test for it ? (t/t5545-push-options.sh)

Care to write a patch? Otherwise I'd mark it up as part of
#leftoverbits for now,
as it seems like a good starter project.

Thanks,
Stefan
