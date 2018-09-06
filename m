Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB1921F404
	for <e@80x24.org>; Thu,  6 Sep 2018 21:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeIGBuM (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 21:50:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41464 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeIGBuM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 21:50:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id z96-v6so12826139wrb.8
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 14:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OjlAMgbbEsFvnkCYfxvgtWcBYSTzzJ3Hv1YhjMqLokA=;
        b=KE+N+4WZvO5/Oev/QxVsT9k83QvItTu57aB4Avu5Rw0g5GXm5dPZWZWc+r0HNPBZwX
         D9P0PnMCLM7ZV6tNAsvEXWMbeJQ3PUhsv4EJFaOtO6L97dgbpzPKp2KbKt8nBHcTWG3t
         K6ni6UuD9II2bW7Aqr0eeBT1V4E4Ic5VJLod/WD895zPKT6hhNI+1nYMhEKF4B0q1ADd
         P5q4PLEkFYHLqW+9kzIkUHnd2GXjSy9evMT9iqbw/t0I+0Ynd7f4Zh0T2jPwIkwmgvhY
         wp+JVOFVIu9B9C9juuofY9vNP6X5DNq3C1+Hp361nr3vgu8lpUJZIpXoXjDezd8x8dcF
         ASqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OjlAMgbbEsFvnkCYfxvgtWcBYSTzzJ3Hv1YhjMqLokA=;
        b=gFYVFtpSEM92DzX9Mu2izU80AYThN/4gUyKVF8cY+Ov1sbzX9MvYkSbvR8rURkEuMD
         X4kkEPU3Yq3ggsf/thI6O1eh/9KN9yv8k03obnhWj42do4R815xdNQcfFjzl5H7doqHC
         wv4SlHWjXBKa2jxhstCv6uYpDApa9/l23/s/jeOmnXu9PIRwwMU3ue6f/85mHbTygTJF
         djUAI6Qw9z9/NmxlRJkqh7gPfuQGJiOwcyqMnhoq5uRKBC9GKUay5qrwPedjWvqlpKiA
         RM5Lst1+ghmzk95r66E6dJ64ealk9btw1l5uuzcXE2j6F93qN+vFvWxDVAkO6fLQ+Sac
         Z0Eg==
X-Gm-Message-State: APzg51A23jKjktEz9QT1eS3SFEZDBb339/yUZ4zOZOlyMhtO3TrETXMt
        0/mv6Wjy1dy+deu2Wk0M4ns=
X-Google-Smtp-Source: ANB0VdYQCuPsBvDnL3eURDW8Kd+ONTUzHImf5K1PqlEPjyDx8441pTWsHdP+iryOwlV2av7Q7Su+Tg==
X-Received: by 2002:adf:9d1c:: with SMTP id k28-v6mr4063825wre.104.1536268372842;
        Thu, 06 Sep 2018 14:12:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f17-v6sm8480129wrs.1.2018.09.06.14.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 14:12:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] diff: allow --recurse-submodules as an synonym for --submodule
References: <20180905225828.17782-1-sbeller@google.com>
        <20180905231258.GD120842@aiede.svl.corp.google.com>
Date:   Thu, 06 Sep 2018 14:12:51 -0700
In-Reply-To: <20180905231258.GD120842@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Wed, 5 Sep 2018 16:12:58 -0700")
Message-ID: <xmqqefe6z5ws.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> It seems like various commands are gaining --recurse-submodules options
> taking different kinds of arguments:
>
> - clone takes --recurse-submodules=<pathspec>
> - fetch takes --recurse-submodules=<mode>
> - after this patch, diff takes --recurse-submodules=<mode>
>
> Is there a unifying principle?  Can Documentation/gitsubmodules.txt
> say a word or two about what kind of argument values the user should
> expect to be accepted by these options?

I am not sure if the above is rhetorical.  The only thing such a
document can say about status-quo is that the user cannot make an
educated guess, as there is no consistency.  Some take an option to
clarify which subset of submodules to act on, others take an option
to specify what variant of operation to be made on the submodules.

In the ideal world, the users ought to be able to give these two
independently, i.e. "fetch" should be able to say "only fetch these
submodules" with pathspec while "run the fetch in all of these
submodules specified (with the pathspec) as necessary" with
"on-demand" mode, for example.

It may mean that it is too early to add "diff --recurse-submodules"
as a synonym for "diff --submodule", before what we can do to
improve the situation for commands that already take that
"--recurse-submodules" option.  A solution for _that_ problem might
result in splitting it into two options (an option to select which
submodule to recurse into, and another to specify the action that
happens in these submodules)---we'd regret if we realize that the
existing "diff --submodule" that specifies the action (i.e. how the
changes in submodules are presented, not which submodules' changes
are shown) does not match the one we choose for --recurse-submodules
option (e.g. we may say --recurse-submodules is for selection, and a
new --action-in-submodules is for action, in which case "diff"'s
"--submodule" option is closer to the latter).
