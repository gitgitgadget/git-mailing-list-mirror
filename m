Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAFFA1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 23:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbeHOCHl (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 22:07:41 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41115 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732316AbeHOCHk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 22:07:40 -0400
Received: by mail-yw1-f67.google.com with SMTP id q129-v6so17541977ywg.8
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 16:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rvneEdtJBY4B525wbKKaTYAcIISuP+sml5YQrSVg0YI=;
        b=KaBVeGv24YPNyEgeQBafoiVzEi5X2UoYvdNxfGLjSobgZ7JV130s+IinQv/40mztPb
         VtyAhCir/kGPrZSkafTYN1nZ/nRUIORhmjWfMnWBW0tZZbDfT1nFcwngXirzWFdRGr0d
         wgj+CCU/+kzVlhQ9Vr9x/tDNhbMSFsr4KKNM1r1K81h4qJtsS2qTAoHbJizPpQb0rKte
         XmPYOeXklhSN6/NIHrKrz8OKGetaXEQ8RPajSp/QvfglIdub3i5CdvXhwFbvdtkv2OSG
         9CSSJAToC+M5JcWa4t0ZRMGFPUYe/nyBNazUidVHiFjeRv8shf5JcfqYHHZ9Z+H/N1T+
         J8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rvneEdtJBY4B525wbKKaTYAcIISuP+sml5YQrSVg0YI=;
        b=BJdmZFK7ubzK2n8pkcBIzgTSTDmuRnk0di2UqnsVuPWjGmI4jdHAV+6LjgyxMOMsim
         52DnS5obfH07fj+8RSbw+OI0qwTyHl0FuERMb3mozC/AcXe3P6g1mrqq1zIMwfSB5r70
         EokozwCqYBho90mnSucvk0YSlsoSxhcxspZxs0RNJKs52jj33kZzUJlLZa7OSXvTKa7M
         91+DtI4TRdxxk/WBXz6AcYQyBKPPmg0MIgxTu7RjTDprjs5w78mAnZtTluKR2XVMP0l7
         rZ6aWIH360es6bzxF2QE++/xBBP3Qq8WX2g00sCizdgXNE7juzyTVPwo7sr/cpuJtp1x
         7DoA==
X-Gm-Message-State: AOUpUlGQkW+AX/kG1PvAIL1sHzL+zgsVKIeK6HKF6iJj978zj1OiqHey
        egY43zlUZGfmVdywVkd5kTeeEPz657tozQePQ3qqpA==
X-Google-Smtp-Source: AA+uWPyr0p6m6Jw/0ZKj3MzfKbq0gmH977vRPKjfzZiKtqcZRwwP3I8zkoKaYfFa+B0KO191QUyXHurPqAPNtX6JmgM=
X-Received: by 2002:a81:af67:: with SMTP id x39-v6mr12533339ywj.33.1534288693275;
 Tue, 14 Aug 2018 16:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180814222846.GG142615@aiede.svl.corp.google.com>
 <CAGZ79kYbmTXXwWO6Sy5ytOLS6=p=9gMzgbjdrSbJPkkQqsyJTA@mail.gmail.com> <20180814231232.GI142615@aiede.svl.corp.google.com>
In-Reply-To: <20180814231232.GI142615@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Aug 2018 16:18:02 -0700
Message-ID: <CAGZ79kb+f8-z+iVNFurSt1ezGNTonJa0ZZbFNhtbfKvCSaDBxA@mail.gmail.com>
Subject: Re: [PATCH] partial-clone: render design doc using asciidoc
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 4:12 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Stefan Beller wrote:
> > On Tue, Aug 14, 2018 at 3:28 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> >> repack in GC has been updated to not touch promisor
> >> packfiles at all, and to only repack other objects.
> >
> > We'd need to adapt this documentation in Jonathans series?
>
> Yes, or in a separate patch.
>
> >> -[0] https://bugs.chromium.org/p/git/issues/detail?id=2
> >> -    Chromium work item for: Partial Clone
> >> +[0] https://crbug.com/git/2
> >> +    Bug#2: Partial Clone
> >
> > This is more than a formatting fix (I did not quite check the rest,
> > but this stood out), but some change to the actual content?
>
> "git show --word-diff" tells me it's the only place that touched
> wording.  If you'd like, I can send it as a separate, preparatory
> patch.

--word-diff is even nicer than -w which is fine for all except the links.

If you are inclined to resend, please do separate, but I do not
insist on it.

Thanks,
Stefan
