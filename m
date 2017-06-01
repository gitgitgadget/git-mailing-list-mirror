Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3808720D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 20:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbdFAUDz (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 16:03:55 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:32866 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbdFAUDy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 16:03:54 -0400
Received: by mail-lf0-f46.google.com with SMTP id a136so18653827lfa.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 13:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8QsjssKLaNsKg5eYV7nf97SvW08mRqFhj8Zy2/zHt+Q=;
        b=bRtQKZYKBwnJMKjCHQopH1Xfb5fATNaKBSlXAgWTf3zoKL8XV1y8Pp5Tt5jkOZCTKw
         ecAMZn9C+lbggwk/pfbzsV91xsgVhCWwE+Li2FtNMcLVQ9k2eSkPO9DhLVScj8+uTqC1
         5/KD60sA7iwZ7lEyDP0ffmM89HH6nr3sXaEFpZRYQ3dZTs1QfEJVJR0NI/bGKxgrIJAB
         tQgHtv4Z2hcLU9epEjcX3c+3MzMrXOrBbnN72Y+I5CK6iUPfiyf/46yJWB7V8IgP39HS
         Kzpnkj3BAlu5F4ap/EmPTtHCGicGIzhf6+n2oiJgoc6Winm9MUUkSW9T8et7eO1bXZmf
         X/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8QsjssKLaNsKg5eYV7nf97SvW08mRqFhj8Zy2/zHt+Q=;
        b=bQAp6PPE4QdxFLEyTePbesas84MiflInYXcAofJ+un4MBn4dyydoxA5JiKTf3RbyUP
         UdYszdP7jOIQ0GhM1naX30CmsGVl03QgPvNSM0IAG7FZuCqITwE3mteaKPEH6SROJrQs
         F1PsRKgdx9zH6aXMbkcIDxsR5dY3x9cEIsg0RDIx7fED2e8KFyuQsVF07eTREr09Uvmh
         O5bDhgznpgo3rSIIreJL2IBpU05QuY5vgUnZfB43Gtwagqhrn5irJNoBWjz6lK7gGoNl
         0bjUScw8eQnf/nLjWxx5vGztDEExJ3lbDk5hfJayGNAwVwY22lZU58jDq9eWP0MucnQv
         j2VQ==
X-Gm-Message-State: AODbwcD1E5ju5GSvDLgbOTkaGq2AJQsyBuGlJ/Me5LO+hQ9YDNbEABCv
        4kBTJr6t8vMSYjxa6mEN3so/avbmUA==
X-Received: by 10.25.44.69 with SMTP id s66mr1153826lfs.58.1496347432332; Thu,
 01 Jun 2017 13:03:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.32.133 with HTTP; Thu, 1 Jun 2017 13:03:31 -0700 (PDT)
In-Reply-To: <CAGZ79kZJF9iDsVgyi-hSKb6N8w0uhVCU4W-r89F0eRJPXe_4Og@mail.gmail.com>
References: <20170531214417.38857-1-bmwill@google.com> <20170601181059.GB127481@google.com>
 <CAGZ79kZJF9iDsVgyi-hSKb6N8w0uhVCU4W-r89F0eRJPXe_4Og@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 1 Jun 2017 13:03:31 -0700
Message-ID: <CA+P7+xpK8qmdBgvPd4f995=WG1p3Oa8YEXfwvGsNqtZZyFZ8Mw@mail.gmail.com>
Subject: Re: [PATCH 00/31] repository object
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 11:28 AM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Jun 1, 2017 at 11:10 AM, Brandon Williams <bmwill@google.com> wrote:
>>
>> For those who don't like reviewing patches in email form, you can find
>> this series at:
>> https://github.com/bmwill/git/tree/repository-object
>
> I was just asking Brandon for a remote to pull these patches from.
>
> As I was looking at the very first patch, I'd like to lobby for trying out
> origin/sb/diff-color-moved, as it will tell you about code movements. :)
>
> Thanks,
> Stefan

Yep, I'll be doing so.

Thanks,
Jake
