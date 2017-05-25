Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5B6920A04
	for <e@80x24.org>; Thu, 25 May 2017 15:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759221AbdEYPhR (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 11:37:17 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:32951 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751871AbdEYPhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 11:37:16 -0400
Received: by mail-io0-f195.google.com with SMTP id m4so21183677ioe.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Yh/KUK4QQIKIp77KpzkzeICga38gkXsdO6YhyXn6aNA=;
        b=e5lgqhbeMkdq9MPnoCnf0uPkwuUJ1V7hnpuMz7OjT8zNv9IEwGngKswIBaQHtYMsuV
         wHFjuzeW8xDnHeobQLr4oLpyEecbiZBGhe97z1zLdi/zH6n1NtnV0MMrShpz8YwfgCQh
         ZCBmlBMxWfxJxUNIhbTPH6lpfo5f+ci3ycpxte1PJ2p/IQse1YHITZb3+q1eUd+sllkn
         /EuAy+rEJky5ECyD+IjsvNdD+esvlYtbtuIYf65P0oRNYANXnH0IWKK86MqkupsOboO4
         IJKwva6ZpcmxHeDL/7vW1khAqx1Yk7if33NJzawJHABamnL38zKSEHzrxb8LJ6fkS5yh
         j3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Yh/KUK4QQIKIp77KpzkzeICga38gkXsdO6YhyXn6aNA=;
        b=X7vFnF7VNQllZa/zGw5Eb5tPuircApSopE+o1OlRAyScoz61frCGcgyrDv8pj5UzCW
         ifnSsGDSrUBJmXNLfBBOGUsAfH2EJk7QaKjMUuvXB1GL+nATgNrG8gyL5w1b/hntZN2E
         mKixr912ID0iI5eI00y4Pm5e28AD7Bf/hDJ4q8fWz6d26cRqjHDVb5Qdj0JSdZswIkk0
         r9bH9qjSBd8jV6UaT9Gj3xngr6/g7+TWwGiFvVbiq/b5WTsUY7es8FXh83yhityUSBba
         0q+rxAmVy2Afg5l6YLwfliZnNq+vsxvNd7jJ2rxCTU19VfGjFG0UedNLB0d+EFZyNZ2Z
         tE/A==
X-Gm-Message-State: AODbwcBY24ZfIjE2RQnHMafWdACklLbBDJbSYMGjNbDJXvZFVXOCyg3o
        +ISMp85+QKZlOTkuvCmGZe/s4hyjARxZ
X-Received: by 10.107.201.206 with SMTP id z197mr43126397iof.85.1495726635746;
 Thu, 25 May 2017 08:37:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Thu, 25 May 2017 08:36:35 -0700 (PDT)
In-Reply-To: <517a9182-0366-d51a-b7e5-f9085df5b4f9@web.de>
References: <20170523100937.8752-1-sxlijin@gmail.com> <20170523100937.8752-7-sxlijin@gmail.com>
 <517a9182-0366-d51a-b7e5-f9085df5b4f9@web.de>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Thu, 25 May 2017 11:36:35 -0400
Message-ID: <CAJZjrdXZkxjHt3XFFhS2BDWwwW8Gmz7frfbUzxgBBwcFYBZe3Q@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] clean: teach clean -d to preserve ignored paths
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2017 at 12:14 AM, Torsten B=C3=B6gershausen <tboegi@web.de>=
 wrote:
>
>> diff --git a/builtin/clean.c b/builtin/clean.c
>> index d861f836a..937eb17b6 100644
>> --- a/builtin/clean.c
>> +++ b/builtin/clean.c
>> @@ -857,6 +857,38 @@ static void interactive_main_loop(void)
>>         }
>>   }
>>   +static void correct_untracked_entries(struct dir_struct *dir)
>
> Looking what the function does, would
> drop_or_keep_untracked_entries()
> make more sense ?

To me, drop_or_keep_ implies that they're either all dropped or all
kept, nothing in between, which is why I went with correct_, to
indicate that the set of untracked entries in the dir_struct prior to
calling the method needs to be corrected.
