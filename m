Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 124811F453
	for <e@80x24.org>; Fri, 25 Jan 2019 09:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfAYJZY (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 04:25:24 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38401 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfAYJZY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 04:25:24 -0500
Received: by mail-it1-f195.google.com with SMTP id z20so8768130itc.3
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 01:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OD6uObuaaDUkSihoXIxk84NiqSzX4h+WAY2Qv8t3LOU=;
        b=aklTUWnr8ajlHDz2qY44sk9MCYNnRbk9GFvYlcssTwr8FMJQfZUpxHnjxZVJ0R63E1
         ClS43/ej00GUzmio4XEZEgKAcIMrBlTq9OBuW/TffZXXlErVEwc6Uv3I2C0c/UavbHnb
         7PgoO3bB4IcqxzhJ1h+NBAncnUWoXWKDoGIGsVPCXXWlPcD9Yk1qxz0G+yfcPB2k0aB2
         XfOxU0CWU6DQB6LEj6dMeY9qx0xQLWro9TC7T0Rh+snee7hcPFiwgZvDIJLgADubIz79
         6DjkXP1Fhv1t3VQVNcpTozShrrykxwVEHThg2v0pCXxx6a4tsGxBAYRL0l7rDBwGafnb
         Fb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OD6uObuaaDUkSihoXIxk84NiqSzX4h+WAY2Qv8t3LOU=;
        b=gW+kgha49mHuXGBYntQZedvMbmsxFRgp4qdulL7rz4ZINhl0lgwmdCbHqbG7g5vpkG
         JJu2/7A+rQQS+zghGo1xSt2x3W/cxjmkvKCz9Ot2bgrwSL86L+UnjIyJ29FufYOxDRrA
         xMWi7qe55wN9xKLuzuJe6KQbisgZFL+3Rbl8CHHbNVhcCapTjkyJiDlG+Yy3WoGKjEVF
         WD4E/YbmNNNwOoEuon4KD4hnE4arCnbNxn8pVcKba6OlufVS0/pJUjOM2yU7pCIamcPX
         Vf2iPo94hM6heQW4Wy1bGpD+KD9WZZi7t7vxDVftPDoTEhccegr7Tcc3JOyHWvxsKiSp
         nqGA==
X-Gm-Message-State: AJcUukcb0yFUDXUjSI7lmQeTY3+kKagvL6AVKtLP0QAY+GlejRr1pZ49
        WUrbylbNJQrh4FE7eMi8Q21ieOb4zarIg2kMNrtb1g==
X-Google-Smtp-Source: ALg8bN5B0kePtZNr/RxoJzzJS5uvJXoY0sjenzH2YA7orcSZDlW7TQoyorNArsofzFbu0w5tEGIEjslvQPywJ24wPvs=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr3677938itk.70.1548408323353;
 Fri, 25 Jan 2019 01:25:23 -0800 (PST)
MIME-Version: 1.0
References: <20181220134820.21810-1-t.gummerer@gmail.com> <20190108215225.3077-1-t.gummerer@gmail.com>
 <20190108215225.3077-8-t.gummerer@gmail.com> <20190122235313.GA199923@google.com>
 <20190123202156.GA11293@hank.intra.tgummerer.com> <xmqqzhrr9j52.fsf@gitster-ct.c.googlers.com>
 <20190124011244.GE34357@google.com> <xmqq8sz9hd6e.fsf@gitster-ct.c.googlers.com>
 <20190125022649.GA540@google.com>
In-Reply-To: <20190125022649.GA540@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 25 Jan 2019 16:24:56 +0700
Message-ID: <CACsJy8Cn-kb6793TLHwszh5E79JeCLhUPjJsfKv0Yfujd_-_0A@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] checkout: introduce --{,no-}overlay option
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 25, 2019 at 9:26 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Junio C Hamano wrote:
> > Jonathan Nieder <jrnieder@gmail.com> writes:
>
> >> I find --ignore-removal fairly easy to understand, and I had no idea
> >> what --overlay would mean.
> >>
> >> I realize this is just one user's experience.
> >
> > Exactly.  My impression was the exact opposite from yours.
> >
> > The phrase "removal" in the context of checkout does not click for
> > me at all, and neither it does in the context of add, especially
> > given that Git tracks states (i.e. snapshots), not changes.
>
> Thanks.  What do you think of --skip-removals (or --skip-deletions)?
> The idea is "among the changes that you would be making to the
> worktree, skip any unlink() steps".

Another option from rsync: --delete (and --no-delete of course)
-- 
Duy
