Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 728281F424
	for <e@80x24.org>; Mon, 23 Apr 2018 13:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755219AbeDWNiF (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 09:38:05 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:32905 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755016AbeDWNiE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 09:38:04 -0400
Received: by mail-wr0-f176.google.com with SMTP id z73-v6so41405432wrb.0
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 06:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CuiKZQ3JOSS3N1jzlC7IEAUGayLl6bROIYt+7vHnLgE=;
        b=HDhpDY4osKb+xjOA8e0S/0X03YWxB+/b77aKC5S9DRJTG+h3ZRJJdgpYJzSPwxzsv7
         IVkJ19TAxLTr53gu0pduYgRuURJPuepzjqm5AhuL21VI6I1rQcxKTInZE2HjKrY+NqiC
         VDM6sLodO+/BhpU+Wg8bPreZ0GQAlpz9e+DqnFVprCFCeEvG5UBl5C3UhTgcpKeYSgYg
         XOsb6NA0hvrQBUtKJa/BY38nSXY6le3vH5olkC1k2a3+8Dd8shTT5shnHSc5nEb3rgfa
         u4QSzSvDpzZCHRG7MLTWF/bOqxnrH7sm10gy8iTQ/dhNwx1WkTwLBB7dUNWjBnROvakT
         DWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CuiKZQ3JOSS3N1jzlC7IEAUGayLl6bROIYt+7vHnLgE=;
        b=F8+Pn99wHb6lF5TH36XWZisPart7IG9ajDx6KQmrZfc4iRBWJbttdgFObZ9A4Nv9rD
         84sWmMrGQwcB7mtvQOkLz2M+kMRScyIWMXpOXXluWwVA8Dc8nEvWDTDy2M04eExloyUS
         2ABEEcGOZdq4TeXXkJLifJpJEcc+DBeDKs4NlUpjjgciSScis87yaPbHU6hUE1xV4LaA
         EAImxoMzlRd1qb96C3yEwr5SDBWAP3i767F7R2iGyToz04u6DxqKyT7n/kUoAPdN23GL
         uokNUG3GXZP/Gk1Jl9qZVCwc+YGvWfNXCwc+LFnAuHxKzl1KhE8XpYs9By4RWKDj2g29
         /Cug==
X-Gm-Message-State: ALQs6tB3qNq+8UVOvJxnrcsxumqdS/5l9aMQAtRYoYPS6OQdhftmHao2
        xQFcdoFDOpZgezaG7v+wvEs=
X-Google-Smtp-Source: AIpwx48VhEkwGhIO0u4+P3aISwz1g1CSJI9IxHqKsCdYDeW7HD9cGsHgmvbgN9a/QscnFc2b6CjS9Q==
X-Received: by 2002:adf:afe4:: with SMTP id y36-v6mr17779678wrd.107.1524490682665;
        Mon, 23 Apr 2018 06:38:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l53-v6sm28771919wrc.80.2018.04.23.06.38.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 06:38:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Simon Ruderich <simon@ruderich.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: Silly "git gc" UI issue.
References: <CA+55aFxSZLuk++Dz6SonD+JhbbSDt9G9VcBx5f1CV=6nJC9hvg@mail.gmail.com>
        <xmqqr2ncezdc.fsf@gitster-ct.c.googlers.com>
        <xmqqmuy0ez8b.fsf@gitster-ct.c.googlers.com>
        <xmqqfu3seyad.fsf@gitster-ct.c.googlers.com>
        <CA+55aFztDdB9tVHREhQ7T0COs7p9ng81XfAHZCL3rx9WT2ecEQ@mail.gmail.com>
        <xmqqh8o7eq7j.fsf@gitster-ct.c.googlers.com>
        <20180420072701.GB13462@ruderich.org>
        <xmqqlgdhb6ba.fsf@gitster-ct.c.googlers.com>
        <CAP8UFD0_LvWkKSYd1MWrdoK-tqBcQqm32CUNrBqEfmjWdHkJgg@mail.gmail.com>
Date:   Mon, 23 Apr 2018 22:38:01 +0900
In-Reply-To: <CAP8UFD0_LvWkKSYd1MWrdoK-tqBcQqm32CUNrBqEfmjWdHkJgg@mail.gmail.com>
        (Christian Couder's message of "Sat, 21 Apr 2018 08:07:01 +0200")
Message-ID: <xmqqbmea9h6u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Apr 21, 2018 at 5:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> @@ -388,6 +389,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>>         if (argc > 0)
>>                 usage_with_options(builtin_gc_usage, builtin_gc_options);
>>
>> +       if (prune_expire && parse_expiry_date(prune_expire, &dummy))
>> +               die(_("Failed to parse prune expiry value %s"), prune_expire);
>
> Micronit: I thought we prefer error messages to start with a lower
> case letter, like:
>
>                die(_("failed to parse prune expiry value %s"), prune_expire);

Thanks.

There is an existing "Failed..." already before the pre-context of
this hunk, which I'll fix with a preliminary clean-up patch.




