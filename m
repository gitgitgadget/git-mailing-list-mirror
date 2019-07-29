Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 402611F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391131AbfG2UAw (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:00:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36639 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390945AbfG2UAp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:00:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so27930604plt.3
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kug54h3Rl3weT/vDIIyYWRRi4Dd6iJHwJ9YPDt5/Elo=;
        b=CgEu9rxT4UGZRaGilPEiOYTGaM9nok/h71GIvFaTgeqJzpOHM5WDYG03n01ke0TaUI
         0mHmbSf0/asZzHoB9kAP8tiBHIOvfsOqkxiB5q09nYxmVntWE5c0tnSSqXQJRAAT9r/V
         WGvuTttlkrIgGKPHVUbbJd0K4WNMgMEhNnLIAR6+jnpJp2z7yKB6r3lxDEAGgGiSrbXp
         kLYPvte1AWSuuzI4Slz1sYUJkabtefnCv8d4G1woFwn9BN48Svknyd0DW2c1u2jGg78L
         rOLFUJUIBkFrU6p0/8Tv8bUO67cUNyk1dpvdzTlJLZrB48qd+CSakDj5oqtw1ipHcdch
         Cz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kug54h3Rl3weT/vDIIyYWRRi4Dd6iJHwJ9YPDt5/Elo=;
        b=j0OXrfqCRtdzTOmTEJpN8qGG73Sht7lHjHAWUcB2pengBugzEDhdDc8+HI2fKXu7Vk
         2niRT6uEBDvvrL08HiF7ASWxXLPOsotxxVji3RODchceGotdz2R+4DYLgobvFFWI2+YO
         EuOpPCT0x8N/lyXTVgM0FVneEAwPH1NPyPCHnQAVvrtpoDUhtgfj8FEsvrbyzwaxI0px
         flT+0SF0RFgcCcD6GrMevo3TArnCH/Bfr5eL2tnK6RWi4aK3kYNrh6Q0otojPRiHqqUo
         B/DgqGZQLRULJODoKI6QnNyNg1ydgNdzciaUffCpOZVrpLIE5N0ZG454doGspRmqtENU
         FhbA==
X-Gm-Message-State: APjAAAW0CtG0OEmFHV14z4oUdGtyFAUE84Rluu00cc+Fkpbn+xe9m14l
        OOhQl+bkl5YBAM9pQ5f5SoaKm4ArAxBiZjHXWOk=
X-Google-Smtp-Source: APXvYqwnC/C6sRaAI8Nsn74f5fCH8qaMWIS+y5SiSzv7/yCj+NXm2zS6EdqTEFdOWFgREhz2eKyFKrXpugd+VRBpvJQ=
X-Received: by 2002:a17:902:758d:: with SMTP id j13mr109906184pll.197.1564430444899;
 Mon, 29 Jul 2019 13:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com> <cover.1563490164.git.steadmon@google.com>
 <e8b3fd8a5bf8f77795454a901fecaa585701eeb2.1563490164.git.steadmon@google.com>
In-Reply-To: <e8b3fd8a5bf8f77795454a901fecaa585701eeb2.1563490164.git.steadmon@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 29 Jul 2019 22:00:32 +0200
Message-ID: <CAN0heSpi3rYAR5XmT4FM_YB746JjYHxmQHwASk4778saBKoUUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] git-merge: Honor pre-merge hook
To:     Josh Steadmon <steadmon@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>, stefanbeller@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 19 Jul 2019 at 00:57, Josh Steadmon <steadmon@google.com> wrote:
> --- /dev/null
> +++ b/templates/hooks--pre-merge.sample
> @@ -0,0 +1,13 @@
> +#!/bin/sh
> +#
> +# An example hook script to verify what is about to be committed.
> +# Called by "git merge" with no arguments.  The hook should
> +# exit with non-zero status after issuing an appropriate message to
> +# stderr if it wants to stop the merge commit.
> +#
> +# To enable this hook, rename this file to "pre-merge".
> +
> +. git-sh-setup
> +test -x "$GIT_DIR/hooks/pre-commit" &&
> +        exec "$GIT_DIR/hooks/pre-commit"
> +:

I'm pretty certain that my comment here was with respect to the ":",
which made me think "hmmm, won't : always exit successfully?". My
slightly less ignorant self of today answers "sure, but we won't always
get that far" -- the "exec" is pretty important, and it will cause the
current shell to be replaced with the hook invocation. So however the
pre-commit hook decides to exit, that'll be our exit status.

I retract my comment from back then.


Martin
