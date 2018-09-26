Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0241F453
	for <e@80x24.org>; Wed, 26 Sep 2018 13:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbeIZTgj (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 15:36:39 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:34899 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeIZTgi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 15:36:38 -0400
Received: by mail-pf1-f181.google.com with SMTP id p12-v6so13450929pfh.2
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 06:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xspXhU2motLJ1B7IVcgTfyge2zXkCQ2mZEhpri4Q1kU=;
        b=WATKn5vCjvLDY/8Ex42LinRO5PkHLfXdIgx/PiJUSedjMxbFvdeGndjDamHLVJ2iK6
         C0kOtE9gvtUKPg08CMuDa7PQAyKZjzQ/GaYYmCxbTVt8dz4e06dP/C5knABYNQORQja6
         tvvQw20NtlsJwyboLqHwSJfipP3lWayzjco5DcSzp+huA6M0bVFR4uGt6FoKD0vwYmgm
         y5iW3HL/r9GEyzNa9GCIezxinXWuD8D2qnol0cEkTPumJP88lB8a4zMTGUdxmBB+kaD0
         PDu60Uac0w/TMG4+erCiZzXv0I44uDDYlK13T/jaWKpjYFyP0TaEODtO/lrZWpI7p2hu
         UGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xspXhU2motLJ1B7IVcgTfyge2zXkCQ2mZEhpri4Q1kU=;
        b=MzS7cZuBi+yPY3L3Ja+rf+K6GcOezHaTOWHI5YLv0max1x782JGtJDHFY9zjw7tYOQ
         NwNtAsq4bk7n2IJvmcSzHsySmr/gXpfswhbmeXA8hilC2PSulz0okRGYvdV4ZPTamix/
         3IL+uGikEgRXCECqHxdj9rKQHklwiQF86/b8W9gG2AK/dr1GeG95s4weCM9jqwuIeucW
         Zmc9h0CMAuP0RLZT9cvFKTkJaoa33xtzmUA5qoP/cXIbr/UZ8X4NHi27kiI6QusBnTwn
         YfoWChHfl7Q/RbRtUmEq91ZEfGkmX54RXv5CV9wWuDY1nxDaiDN6MCKaBSuA7wSr8oke
         zYXQ==
X-Gm-Message-State: ABuFfoheTnvwr+j51pUXO7j58jnG3mQMZSBoc+2dWw7SfshVIT+jupMA
        x0c31oGY8zvlOhKmuNscDSbJE+wqtHn38cOw6Gw=
X-Google-Smtp-Source: ACcGV60gcAH2nXiHPASiNbP32egnGuDhr6Zor5wSwOTl9+jISSJanh35yVtEvsAS3NLKxsR1HkbahXxZ1mGIBlQx4WY=
X-Received: by 2002:a62:2646:: with SMTP id m67-v6mr6364434pfm.254.1537968221150;
 Wed, 26 Sep 2018 06:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <CALOYryFX4PPR+=1L+sjEqPsdmNh_+vNxGf0wwuAgoYzau=GShw@mail.gmail.com>
 <CAN0heSrhaaP0ds8K92g9w5DAnbwuq8mM6WLKrTQ7e_a8Fku9KA@mail.gmail.com>
 <CALOYryEMB5HoCXbVKnc49KLkk2ySZjn4DG9RbJjQAvPn1H5K6Q@mail.gmail.com>
 <CAN0heSpUhzbTjceVhBxk_jjE=vOAVTzXGFQ=UL9Y+muJHe0S6w@mail.gmail.com> <CAPig+cR8KyeihQbUbSP7Awz+NTbf8c3r-ZE9w2wjnvvEpU0gDg@mail.gmail.com>
In-Reply-To: <CAPig+cR8KyeihQbUbSP7Awz+NTbf8c3r-ZE9w2wjnvvEpU0gDg@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 26 Sep 2018 15:23:26 +0200
Message-ID: <CAN0heSrajoYrkta3+uZJnH32mWsL7vKiYYmEzZ3h+GAeuMQPSA@mail.gmail.com>
Subject: Re: t7005-editor.sh failure
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Alexander Pyhalov <apyhalov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 26 Sep 2018 at 13:59, Eric Sunshine <sunshine@sunshineco.com> wrote:
> This description of the behavior is misleading (actually, actively
> wrong).

Hmm, that's bad, my apologies.

>     echo foo bar >cow
>     echo >cow foo bar
>     echo foo >cow bar
>
> That is, they all create a file named "cow" with content "foo bar".

Somehow I knew that, as in "I've seen that before", but I guess I've
never thought about it long enough to really incorporate it.

> So, in your example:
>
>     echo space >/foo/t/trash directory.t7005-editor/.git/COMMIT_EDITMSG
>
> what is actually happening is that it is creating a file named
> "/foo/t/trash" with content "space
> directory.t7005-editor/.git/COMMIT_EDITMSG".

Thanks for clarifying.

> As for the "ambiguous redirect" diagnostic, that seems to be Bash
> trying to be helpful in reporting what is likely a programming error
> (that is, forgetting to double-quote the expansion).

I see that SZEDER has posted some interesting reading. I'll make sure I
understand this better before coming back to this later today.

Thanks
Martin
