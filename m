Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CF8A1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 03:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeIKIF5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 04:05:57 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35949 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeIKIF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 04:05:57 -0400
Received: by mail-yb1-f193.google.com with SMTP id d34-v6so8803677yba.3
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 20:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kcyhPbjjfSiuwmaaBtxGUkPG9gxpNnhhQNyB9zCebMk=;
        b=DFvd7GNCiJzPPRpFlgfHnGcE6gg9EuPJuiQZmff2kVZGjHa6zW2Bd85ZANi748Uboo
         xC+1feuicCXQsW7qE3SGFxeCqCVoc9Bzm1XMFlzD5tGWNk+/5xY2mWCcwn0jGwXPUvSB
         TRoaXYaDR6N0D4tc5HawMt3N/oh2ZK19WpUfAHmXCECre9cnEZHdZIuoEkqOV6wxqQkr
         Km/k5M7QARzROJRmZPMZ5qNiZ97J2T75TpXA9RAtvIoPorhEzPz4sZhb7+JaYSeMpoIW
         uHLIlBRLuDSaVr0AszXMeiCdk7ONX/Hg+nGECuofovL8VcMiwLS9BDHFnXw7KGLwKTKZ
         5b3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcyhPbjjfSiuwmaaBtxGUkPG9gxpNnhhQNyB9zCebMk=;
        b=W79gFUe3ysFBKb0MOab3NpTBgBwI1MnciLTp9J7aFnim8R04bUYrdE9Bl/cr4RycxM
         j+BZ7SCvnnddqv9qh0RSmUiuqG/ABX6eUwhM+iEIE045AQA9grvyryGCjcu7pdpSVRoG
         egRUFp1c/p1JPuY6g6f85WTIgIlKlXKfNwXkfTDiY904Qi2qSWNt8/Mk1XjX3Zf0c1rW
         doCaWfkA0hgiovVsGFYbpHxQmSyiv6mObaiCESD88ZAWYex4yy47qTbRy7Vpl9Eonqx1
         s9L045xOnjgs9EuwpkrA8/hjlFYhdny5QsGmTIlXxfs7Z3iq9Hc4UfrZPP/O6ohz7pgr
         2SmA==
X-Gm-Message-State: APzg51By5s9QJqEsiKv+o3iRuEB7677zvdBQftdwKSRi1qdlF8ZObYPK
        kwhjZmjEDWniQ/XidwLpXVcmsqPm1CKWiTEIEPuE/A==
X-Google-Smtp-Source: ANB0VdazOVx4rj1NLlDokDq5yiyfwZ8dOoDTErJZrN/AYmMyHYRNxU11g5LqfvZ4p7zBqxgJbZBEFOU97w60laAl+JA=
X-Received: by 2002:a25:41c3:: with SMTP id o186-v6mr11173559yba.493.1536635331062;
 Mon, 10 Sep 2018 20:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAGZ79kbObDXyaRLADQpvMMSitOLCDwb030Q6UBiX-7Y-XWnqog@mail.gmail.com>
 <20180910215831.17608-1-sbeller@google.com> <xmqq36uhrnjk.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kY2XpB4nJOJc0LLueqsutpncgwdN8uC=Wj0Uxu9Yjgd8A@mail.gmail.com> <xmqqy3c8rh3d.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy3c8rh3d.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Sep 2018 20:08:35 -0700
Message-ID: <CAGZ79kbRrPnQnPs0FX7_TeiekpmmLzDoSsQpi2fDjc-WkqBf_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] trace: add trace_print_string_list_key
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 10, 2018 at 5:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> >> Of course, even though these are 1/2 and 2/2, only one of them and
> >> not both would apply.
> >
> > Or you could squash them once we reach consensus that both are good.
>
> Ah, sorry, I completely misread the first one.  I thought that it
> was extending the implementation of existing unused function by
> using trace API, which explains why I mistook them as an either-or
> choice.  I did not realize 1/2 was adding yet another unused one
> without doing anything to the existing unused one.
>
> So the choice being offered are:
>
>  (0) take 2/2 only, keeping zero unused helper.
>  (1) take 1/2 only, keeping two unused helpers.
>  (2) do nothing, keeping the simple unused helper we had from the
>      beginning of time.
>  (3) take 1/2 and 2/2, replacing one simple unused helper with
>      another unused helper that is more complex and capable.
>
> Are you planning to, or do you know somebody who plans to, use one
> or the other if available in a near future?  If so, it would be OK
> to take choice (2) or (3), and it probably is preferrable to take
> (3) between them.  A more complex and capable one would require
> maintenance over time (trace API is being updated with the trace2 in
> another topic that will start flying soon, so it would be expected a
> user of trace API may need update), but as long as that is actually
> used and help developers, that maintenance cost is worth paying.
>
> If not, I would say that the option (1) or (3) are worse choices
> than either (0) or (2).  It would be better to minimize maintenance
> cost for unused helper(s), and the simpler one is likely to stay
> maintenance free for longer than the more complex and capable one,
> so (1) and (3) do not make much sense unless we plan to start using
> these real soon.

Yes, I think (0) is the way to go, actually.

I wrote patch 1/2 to show Peff and you to prove otherwise that I am
not contributing "only grudgingly".

If the current unused function would be actually helpful in debugging
I would not remove it, but actually use it.

>
> >> It is not costing us much to leave it in the code.  It's not like
> >> the function costed a lot of maintenance burden since it was added
> >> in 8fd2cb40 ("Extract helper bits from c-merge-recursive work",
> >> 2006-07-25), so the alternative #3 might be to do nothing.
> >
> > True, but ...
> >
> >> somebody else in the future to propose removing
> >
> > is what is actually happening here already, see
> >
> > https://public-inbox.org/git/1421343725-3973-1-git-send-email-kuleshovmail@gmail.com/
> >
> >> I am inclined to say we'd take
> >> 2/2 ;-)
> >>
> >> Thanks.
> >
> > Feel free to take Alexanders patch from 2015 instead.
>
> I prefer to take 2/2 over the one from 2015, especially if we can
> explain the removal better.  We had three extra years that the
> helper stayed unused and unchanged, which gives us a better
> indication that it won't be missed.

Will send a patch with better reasons tomorrow,

Thanks,
Stefan
