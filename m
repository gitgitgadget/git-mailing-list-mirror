Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3CA71F462
	for <e@80x24.org>; Fri, 14 Jun 2019 07:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFNH0m (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 03:26:42 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33332 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfFNH0m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 03:26:42 -0400
Received: by mail-io1-f66.google.com with SMTP id u13so3748495iop.0
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 00:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoOQmEG0OUVxxu//aCqFfQchhFc/qQYWgVXYI09xFIk=;
        b=cKy5TJrxWQ4ltU2rmWDWG6pPyZC4VHp9A5K4ez+XdCvsflfegpAkXmVoab/qHv25gu
         yilE3L5qIS2qCWXMTlXH7x/jW3ruU2L++D7ThOGVRUvjdnG/JbzD5F5lWWPSJuh/sdhw
         t/eWJMQ/u1Rvcl1q4iCIT8JUEfbATRiBXHKE9iiyyeYxDseZK0P9Xs4HGSROtZxuMgYf
         bv+Y7sDkaEmLt+bBulvmz1b9KzLUITb3OyIoGNSZD4TplB+HWZX/Yv0G34LBt/TRH4NR
         TZgB5uxelZqy6+aw2sO1gXZRDKjD5Szv9SkzXX0cmswu+l14YNBdrE+pH4pgqGwnj6Jv
         rPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoOQmEG0OUVxxu//aCqFfQchhFc/qQYWgVXYI09xFIk=;
        b=Ou4xkUWqQtMJHbHYCB82AIouZSnz29H1sQpS/a1U11MPToTxbv1zdPitfKKzVt+Pbk
         QtZRhORR9sNH6g+tPB5Xr4Wr2E7Arunr2Zc9o6OYUIEVZC7yM8C9ks0lTzxqC732U1sf
         yaChBcOxmP+ZJncrrQBmx9v2hfEsyNjC5AqFrswwq8JHpzXl1B0Ken0AlJLM9bQAT3Ni
         7LwcfRPPq7OK58WJbSj2M7+v+5EF4UPIcuM79zWo9DZBwIIHTXDguofajVenVXQikPg5
         2KfpZlELNQt2DPfwFcvjA876Y4cb7rrzmj9M4EAs5qc+6QlKKvMajzZZvHo45STXr9MX
         IgEQ==
X-Gm-Message-State: APjAAAW2dvySN4i5AVKgMTOkXu3xtTHZ6ya7xlsAd4ab+qy7pKFrJvqB
        oFpz9zkpYV6/OfUnUJHY/CzCcL+65uNPpZGcCeg=
X-Google-Smtp-Source: APXvYqznRkCzghHDBPfUDz1y/p1Gy1f3LnqwvqVqwTTCJXx8sjyGUXmkA9vMqboPtU+UUB36ZSDVUXggz2f+bwz4aAU=
X-Received: by 2002:a6b:7008:: with SMTP id l8mr59285944ioc.292.1560497201833;
 Fri, 14 Jun 2019 00:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAEwRq=ohKw8o0R3mtcr5E0fAeEX_OMo5qCiVx3EWwp5B3BKU9Q@mail.gmail.com>
 <CABPp-BGQ0frtOk7ZF4vnLdfeYCXibUaC4zUV1coTz=AzOvy8Lw@mail.gmail.com>
In-Reply-To: <CABPp-BGQ0frtOk7ZF4vnLdfeYCXibUaC4zUV1coTz=AzOvy8Lw@mail.gmail.com>
From:   Vincent Legoll <vincent.legoll@gmail.com>
Date:   Fri, 14 Jun 2019 09:26:30 +0200
Message-ID: <CAEwRq=qufzNg_fBNPgSkV++VRHE2jE8q_iNBB1Fn=BQjTFRLEw@mail.gmail.com>
Subject: Re: cherry-pick strangeness
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Fri, Jun 14, 2019 at 12:56 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, Jun 13, 2019 at 3:42 PM Vincent Legoll <vincent.legoll@gmail.com> wrote:
> >
> > What am I missing ?
>
> When you cherry-pick a commit, it reapplies its diff on top of a
> (usually different) commit, preserving the author name/email/date, but
> throwing away the committer name/email/date -- instead using your
> name/email and the time of the cherry-pick for the committer.  Since
> you are transplanting on the same commit, and you created both the
> original commit and the cherry-pick, the only thing that can be
> different is the committer timestamp.  Git records timestamps down to
> 1-second resolution.  If you run in a script, odds are that the
> original commit and the cherry-pick both run within the same second
> (though not always), and thus you end up with precisely the same
> commit.  When you run interactively, you take longer than a second
> between commands, and thus have a different committer date which
> naturally will have a different sha1sum.

Thanks for the thorough explanation.

Looks like this has nothing to do with "--[no-]ff" at all.

So if I put a "sleep 2" before each cherry-pick I won't get to see that
behavior, or if I had used something that changes the commit message
("-x", "-s" or maybe even "-S") ?

Shouldn't something about that be added to the man page to avoid
people scratch their heads ? (I can try to cook something if this is
deemed acceptable)

-- 
Vincent Legoll
