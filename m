Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 700911FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 23:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754471AbcHZXG2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 19:06:28 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:36416 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754337AbcHZXG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 19:06:26 -0400
Received: by mail-yw0-f174.google.com with SMTP id u134so57244874ywg.3
        for <git@vger.kernel.org>; Fri, 26 Aug 2016 16:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JkysE0IWotxH/9US5HYQZM5UDmW4+ATuYWlSmn8HTPY=;
        b=NSPg/BBnKxJCY+7skQx+n2sOOGiTsj0B8JVRbpJYTPnip1zMTDCmXfiq6YjSruPTv0
         ZSPK7y4D3ON2qbLM8hAPahsdBYcEHCId5xn0r3z86Zc50nJLk8tB8C0Ode+euocgzoVi
         ucn7k3hsBqgvmQvjoKStRQ88tAeU07MovBf7GFjvArtQn32A8C97ZGYzNGRpHr1QovsJ
         D2uzTSnfMckomqOGoKiUHW3/cwhfbEWJoFwV829/5aKEV9cNq7uZGWYzdNCxofj/Wf7/
         1nRVTv/3ymYHTo81Yx5xzLmYBW/eas7iPnullSET/hbzkMRBviuUnIVqxGdAV1FsW7u2
         EWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JkysE0IWotxH/9US5HYQZM5UDmW4+ATuYWlSmn8HTPY=;
        b=Fwfkwlkb3lYzSQZX90NQ9Z9Cn45depTqIlNDmOwyDVfNQYIu+qef2GczkIHyG16vOy
         z0QG+uTYN/B6O7oeAdbrUPbk//m+BX4ZbhUbtqx3qRP7/+89k5oLADaCQVPr0wKFCNqI
         15L+9l+4WHw7wdEFpVfTrIrJ8aZvF9CtN7/WEp+LmUQsL8hqZMuGsBCMnN+XMme8jiJ8
         bPwChuvBE34L7NGm7mhgbfjdK5QprgAjcNwduWazqYgPVqn+GhPZqIvD2xG4Wd5DPGky
         zFa9yY46hXE8KPuWMPUg8KtTMmufr5dOtRURmiruprvSZdXnep4qBlazsiNbDV6uxT6E
         fGMA==
X-Gm-Message-State: AE9vXwOG8ODRKdIFmqQdzW9cym26jL+KFP88yKrcs4kdhBnMWfVt5SNHOxV6qYIN+OZT0NkcEYiP/w19u2qL9Q==
X-Received: by 10.129.168.9 with SMTP id f9mr5315767ywh.258.1472252749770;
 Fri, 26 Aug 2016 16:05:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Fri, 26 Aug 2016 16:05:29 -0700 (PDT)
In-Reply-To: <20160826200426.l3eu2mojgmjdz2ec@sigill.intra.peff.net>
References: <20160825233243.30700-1-jacob.e.keller@intel.com>
 <CAGZ79kao12f8VTT3uxRvAUBhvbfSLjsYRjidTau3M-Kf81uXDQ@mail.gmail.com>
 <1472241486.28343.10.camel@intel.com> <20160826200426.l3eu2mojgmjdz2ec@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 26 Aug 2016 16:05:29 -0700
Message-ID: <CA+P7+xpvtdoeK3uiSGAeNzQaYQhS7p0WT+nCcfKAS7FauFNftQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] submodule inline diff format
To:     Jeff King <peff@peff.net>
Cc:     "Keller, Jacob E" <jacob.e.keller@intel.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "j6t@kdbg.org" <j6t@kdbg.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "stefanbeller@gmail.com" <stefanbeller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 26, 2016 at 1:04 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 26, 2016 at 07:58:07PM +0000, Keller, Jacob E wrote:
>
>> > >  char *git_pathdup_submodule(const char *path, const char *fmt,
>> > > ...)
>> > >  {
>> > > +       int err;
>> > >         va_list args;
>> > >         struct strbuf buf = STRBUF_INIT;
>> > >         va_start(args, fmt);
>> > > -       do_submodule_path(&buf, path, fmt, args);
>> > > +       err = do_submodule_path(&buf, path, fmt, args);
>> > >         va_end(args);
>> > > +       if (err)
>> >
>> > Here we need a strbuf_release(&buf) to avoid a memory leak?
>>
>> No, cause we "strbuf_detach" after this to return the buffer? Or is
>> that not safe?
>
> That code path is OK. I think the question is whether you need to
> release the buffer in the "err" case where you return NULL and don't hit
> the strbuf_detach.
>
> IOW, does do_submodule_path() promise that when it returns an error,
> "buf" has been left uninitialized? Some of our strbuf functions do, but
> I do not know offhand about do_submodule_path().
>
> -Peff

We probably should release for the error case. I'll do that. I don't
believe do_submodule_path ensures that the passed in argument is
guaranteed to not be initialized or used.

Thanks,
Jake
