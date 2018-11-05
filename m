Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 071881F453
	for <e@80x24.org>; Mon,  5 Nov 2018 16:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbeKFBiZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 20:38:25 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:53848 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387420AbeKFBiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 20:38:25 -0500
Received: by mail-it1-f176.google.com with SMTP id r12-v6so10669493ita.3
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 08:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sAUY2batoNQB2s2PG6ZP6fkZ6whXV46WPWTb7Ihohis=;
        b=hsSKtIcMYjUjnhMmv8pCxzyQh7b7w5Rqj0K/ELB+3VFj3omu+BeypknTS8T++xfZ4X
         MnRz+uKsk9lha5H+iXLRmQFGoZVbKTs1vEBeeFBxkKGEeKPtUHEhetZIDLGkfdR89hSM
         oJsO6zg2hRTSHy+PipCyCPJ11U0/jmVTSuGL1dL9yonFNYv7isaNZS8IuQoZ5O8siM4o
         psav/8/+H2HHi28q5jioq3iV/6/YApKzTPROTCxrekAu+ZI6HC6S61HrEHhTS7zoNLHw
         RAWd1EaxII7LuPLQkxAqT7CbIIkIg6I9TFgUU534rn0hfc7Peka/3Mr8dCL9f8LRg1FC
         rauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sAUY2batoNQB2s2PG6ZP6fkZ6whXV46WPWTb7Ihohis=;
        b=dlrBBuZBawsU4/Fi4bjP8hVR5UNFnk6OUwUSl+FpXbEbdh1tXE0VIAsW0gxpzNuFas
         iSnsHFKnMQjzJHX4uJ5LCjNnObFwgUe+6ccunG9oowtaQhJEK+y8YqxYhCdUdg0+W4/q
         tYorUerjI3YFLhhCaGppEz8V4OUsS+1np2tTBZMpGPkn8zxkq1IqJuxLoqynBATbek6s
         wMc3g5tkVRbeYKk7sohgmxLbEgeDwp1KMDYqmouV0z+yUp956fsgTUYHsresRDv2KwQY
         BmbKoYAzqQxajWmn9bJkmuUPxFiFxw2F8wjCpFy0BuT/bDhL9MFwwDmtyqf3rl61PEeg
         yIZw==
X-Gm-Message-State: AGRZ1gKytfIj4Jnh/e7X6fUSORF7CrJhJDV7GXQ3+JknnGlh9Wb1bgw7
        lJfbYTBy4tEewdJLg1O3ZOOxxOq2PsVfX8K4j9A8qw==
X-Google-Smtp-Source: AJdET5fXy4X/VSoXS5/tAsZBjzOWfUPVnOyTdoGpl250ZbEQ6NB2YF83Q8yh1YL2Sm4v6+sacUrKk8zl1gcMuFUFyDc=
X-Received: by 2002:a02:8449:: with SMTP id l9-v6mr8258446jah.130.1541434679149;
 Mon, 05 Nov 2018 08:17:59 -0800 (PST)
MIME-Version: 1.0
References: <20181104072253.12357-1-pclouds@gmail.com> <xmqqtvkwl4u8.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvkwl4u8.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Nov 2018 17:17:32 +0100
Message-ID: <CACsJy8AzriX4YYSSZN-U06HHKgL9XmkJ1WhWbLo4LwZvECa8hw@mail.gmail.com>
Subject: Re: [PATCH/RFC] sequencer.c: record revert/cherry-pick commit with
 trailer lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 5, 2018 at 1:56 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > A reverted commit will have a new trailer
> >
> >     Revert: <commit-id>
>
> Please don't, unless you are keeping the current "the effect of
> commit X relative to its parent Y was reverted" writtein in prose,
> which is meant to be followed up with a manually written "because
> ..." and adding this as an extra footer that is meant solely for
> machine consumption.  Of course reversion of a merge needs to say
> relative to which parent of the merge it is undoing.

I think the intent of writing "This reverts .... " to encourage
writing "because ..." is good, but in practice many people just simply
not do it. And by not describing anything at all (footers don't count)
some commit hook can force people to actually write something.

But for the transition period I think we need to keep both anyway,
whether this "This reverts ..." should stay could be revisited another
day (or not, even).

> > Similarly a cherry-picked commit with -x will have
> >
> >     Cherry-Pick: <commit-id>
>
> Unlike the "revert" change above, this probably is a good change, as
> a"(cherry-pickt-from: X)" does not try to convey anything more or
> anything less than such a standard looking trailer and it is in
> different shape only by historical accident.  But people's scripts
> may need to have a long transition period for this change to happen.

Yep. I'll code something up to print both by default with config knobs
to disable either. Unless you have some better plan of course.
--=20
Duy
