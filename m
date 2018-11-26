Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 703621F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 22:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeK0I6h (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 03:58:37 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37763 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeK0I6h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 03:58:37 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so17261689edb.4
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 14:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=20Mf8a+pkCBcFOmQaCOYSqi9Go4HZ2jppnKIkyQNFBU=;
        b=eFKWcEDoWA3LV17MqrGLFBm8s08NDFkUYLovMx+B2VVQ7VpMzCglFYX2i9vAn8/CvY
         xUkHr14DsVVnQ7juHJPcVglwtFrUDcLAvSbpoUqF42rnkyHox7QWLjCN6LGD4KSn7tQq
         QjX3zb4nmibCNv5gw/fNnn4gcL7I+8UWg3y2E2K1Uq4j6zmKal+suQxQmk3pF3xz+6qQ
         d1vXiNynKz8HKtHsERDYJO03e/HwbER+s7C6DmER5VNrbPWyUmJT/qjH+HkCP4Ddbyc3
         RpnKtEgH/rljzlofDkmTInlW/1fDZ9LQzhdWQEGvmdWdekN0qtTRIMOiR7Gs9Vyi1mh+
         THlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=20Mf8a+pkCBcFOmQaCOYSqi9Go4HZ2jppnKIkyQNFBU=;
        b=e2+hjliD3hX5iL//9CwYbONhgxKzN7aZR3xpqxDsOERbl96QamRV9toXTaL/JCyTKZ
         fdT5RxrIxYH5UdD7ovOjnh6HqQ55dsJria30tDNUoHQoIUD647ynLNb4KzMFpPPOmVGv
         rNEdaEsW6XDvbCaFtUGLPDjllWdn0NjQzXpoCKjm91gS9GedP1aQsEz+kR2OeEEi6bYU
         ekSr/TOcaD0byudS+GXgx0UoPxnc2jkQTtuEG6ChUmxjjtXftykzI3oOMxhnYYIXL20q
         n2/MBrBLnYcwbdzHVMC5BHMIMaGN60EM3pwfEbUBeS4UQnZdsQllaPkfx7YkOt3+CSFP
         gjHw==
X-Gm-Message-State: AGRZ1gK7w3C4TBB2HdRMXFEGzENwjsR1Oa0fcM/FdbqwFHJUg/FpSQdE
        HtDQYEj5BIW17raTf0BmTPoqyl4E40ReOMUUAa0Wyg==
X-Google-Smtp-Source: AJdET5c7kYD2GEGhfL/VHW/+hSNjxUZ1BQs2Mrff5q96m9nJVSOUquNAnD3Qb9rETejQVluilCJmkdSLir2yaqd8dn8=
X-Received: by 2002:a17:906:b7d1:: with SMTP id fy17-v6mr21466468ejb.70.1543269782171;
 Mon, 26 Nov 2018 14:03:02 -0800 (PST)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com> <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com> <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com> <20181120060920.GA144753@google.com>
 <20181120061221.GC144753@google.com> <05e7df80-0dfc-c1ec-df14-c196357524f4@gmail.com>
 <CAGZ79kbaPKaCFGGXnbNchvk=1Q4Q5Hgt2hXOhcGo6pVwquhaEg@mail.gmail.com> <7e06ec44-a3a0-fa38-75a7-7b875ae0679e@gmail.com>
In-Reply-To: <7e06ec44-a3a0-fa38-75a7-7b875ae0679e@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Nov 2018 14:02:51 -0800
Message-ID: <CAGZ79kZLFGtKzQLAXcrXRy8D9NhMwG=7iTCMzYu_h3Ba4G8cYQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] ieot: default to not writing IEOT section
To:     Ben Peart <peartben@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 26, 2018 at 1:48 PM Ben Peart <peartben@gmail.com> wrote:
>
>
>
> On 11/26/2018 2:59 PM, Stefan Beller wrote:
> >>> +static int record_ieot(void)
> >>> +{
> >>> +     int val;
> >>> +
> >>
> >> Initialize stack val to zero to ensure proper default.
> >
> > I don't think that is needed here, as we only use `val` when
> > we first write to it via git_config_get_bool.
> >
> > Did you spot this via code review and thought of
> > defensive programming or is there a tool that
> > has a false positive here?
> >
>
> Code review and defensive programming.  I had to review the code in
> git_config_get_bool() to see if it always initialized the val even if it
> didn't find the requested config variable (esp since we don't pass in a
> default value for this function like we do others).
>

Ah, sorry to have sent out this email, which I found as one of the
earliest discussions in my mailbox. The later patches/discussions
became a lot more heated from my cursory skimming and sorted
out this as well.

It is interesting to notice that, as I also had to lookup how the config
machinery works (once? a couple times?) but now it is so hardcoded
in my brain to assume that if functions like git_config_* take the
branch, we can access the value that the config function was supposed
to read into.

Sorry for the noise,
Stefan
