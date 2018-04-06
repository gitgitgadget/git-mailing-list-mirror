Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C48341F424
	for <e@80x24.org>; Fri,  6 Apr 2018 07:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbeDFHk6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 03:40:58 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:36668 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeDFHk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 03:40:57 -0400
Received: by mail-qt0-f194.google.com with SMTP id w23so241771qtn.3
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 00:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9DuV6BW2qwyG3GxtkPtj0MVe/VjC6cGKt4jwZ6/bmRs=;
        b=tErfzrQ/NcDBJmdFEest3Ul4MufCJIPfkbyvRd3/3ANE0cB+Y1ZiNnfXQw5Av7avlf
         PIbl6Prdj+Xymrlk16DbJKSlYbS9JvUyc2LoDs/PN4orutdRaP34LYVFk5iZ0r3YAb7t
         8gmiwV05Axv0jeddB1GaRxxOxEZlOWG9l3Y9rcj8XpocES+uJ/isVyya1LEk73iKMqOz
         i+fMdrFwKs3Ay0BeFlO4xIN+pz5LWTQATFCNFgTkM6S+uaWQIXDKIvy+h55YjNtjgnxG
         RNQolkFR/cMWNpJY2WPrpZUCagZRfLT+gIYVSTUtQlvdbggYfJ3l/AHRGdfnv30656rr
         RNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9DuV6BW2qwyG3GxtkPtj0MVe/VjC6cGKt4jwZ6/bmRs=;
        b=JEjaFA5BuM4TPnV8vOiyCzJY5Ifc3L3eNbtB+wTVomrleHmUemQtSihvnj9m2432wR
         VJnVy4wQSX/2pI2Q9+OOl418KRKL/HyH4u7PxhNMdVM8glbRwJ6uQraB/k4P77JRCFRg
         6Ibp9xYtDFsnBoAmS+Ph36MHBCCqeId+cRxan7VpF8pXKknDuMnGG0nZAaFHMvqgY+C4
         jftnndwiBrMotxWyVqwyEypBk0NVL90RqvZMABvVK6Z7YS+TrwFNMQM7D/Npry6FKGpX
         KRxhHMg1dFIs3dpkghZeKIkCeW3eOz8VN7wxGinTtPZRk5wSxWPdU7x20BsqRKtR1hXc
         pICg==
X-Gm-Message-State: ALQs6tAQQSfC9xhrC3CNtnBz4Niu7wprZCAIG2GxWhcXeJfWP8yA3pEY
        qeG3pEDTgPeCeNkXh5yDZhmsY7zems9BPSMpNwg=
X-Google-Smtp-Source: AIpwx4/VxIAwecSk5AJghI5Vh8VhkMIsVb/K+Gi7WFJIAGw/IkpT1CzlADWwXqHozJLxWTfvP1Dd5dz+wNTs8E9VcbA=
X-Received: by 10.200.50.174 with SMTP id z43mr35211785qta.250.1523000457015;
 Fri, 06 Apr 2018 00:40:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 6 Apr 2018 00:40:56 -0700 (PDT)
In-Reply-To: <CAPig+cRKaxECLHb1id6Mcd0O3uOiDzdGB4ZxPt1UpwUDi9Xb+g@mail.gmail.com>
References: <20180306021729.45813-1-me@ttaylorr.com> <cover.1522996150.git.me@ttaylorr.com>
 <20180406063013.GB662@syl.local> <CAPig+cRKaxECLHb1id6Mcd0O3uOiDzdGB4ZxPt1UpwUDi9Xb+g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Apr 2018 03:40:56 -0400
X-Google-Sender-Auth: h9OL_G8sMCGuO21t047pJp_tQ08
Message-ID: <CAPig+cRrz_Reb1CJN0u1LSQ38LjED+tuBAT=RT5rESfJ05absg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] builtin/config: introduce `--default`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 6, 2018 at 2:53 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Apr 6, 2018 at 2:30 AM, Taylor Blau <me@ttaylorr.com> wrote:
>> +test_expect_success 'uses entry when available' '
>> +       echo bar >expect &&
>> +       git config --add core.foo bar &&
>> +       git config --default baz core.foo >actual &&
>> +       git config --unset core.foo &&
>> +       test_cmp expect actual
>> +'
>
> If you happen to re-roll, can we move this test so it immediately
> follows the "uses --default when missing entry" test?

One other issue. If "git config --default ..." fails, the --unset line
will never be invoked, thus cleanup won't happen.

To ensure cleanup, either use:

    test_when_finished "git config --unset core.foo" &&

earlier in the test (just after the --add line) or use the
test_config() function to both set the value and ensure its cleanup.
