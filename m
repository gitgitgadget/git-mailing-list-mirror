Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C20C1F424
	for <e@80x24.org>; Sun, 22 Apr 2018 16:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753807AbeDVQMw (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 12:12:52 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35884 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753759AbeDVQMq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 12:12:46 -0400
Received: by mail-oi0-f49.google.com with SMTP id h11-v6so12127430oic.3
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=igQoPXgkAtIJmC6eR2E4GGUNLdBHPhAKkEQro/VeDbE=;
        b=pwytKdKmXrk1WCjMIIox6rjR1F2ccNn0WS0rGkaJfze/DpuzgW2bFSKz1X/Dfk83n8
         19vy7jrLEK/5qaqVpGtOBOXsATmu5x1VUZELifCWBZYjF4pkuICvGFuyMHaQtW182EOf
         duVFTgkS0xzaH8TDjJRRnjodtI3cfBdr8yiZNIh5N9FJi7O+VrhoBQbDgVyrPztC8gVP
         f5BTEBct/4vwLfrOjRn42zrnN+xOgNtLXGcs6JQfVV8b5bL9sWqoUP/ohitw4inaKt7m
         2f9l/QbZ2LWbnbbaNqb10hlyZnYmN7376BS5Vn5UpHA58+agdTYTNR0rizO69KgGOxYN
         M2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=igQoPXgkAtIJmC6eR2E4GGUNLdBHPhAKkEQro/VeDbE=;
        b=VT9OOHNDXQoc/92OB3m3abLjdB5d1+lx990r9GwzuVOy5rgsK6KHgsMZo/blf89o7q
         9qDeiItFhGQetB6MFOpjPDKpQs1A+J9i2rUN1yW4j43SHsxrdXvOXG3xJaiBfTilwWTF
         EylICx8CLx6Z0Dhyik78HO3li+3J19mOjE49VTWRW2e9ksiOADgvfhtF81hiZqkaSw4x
         OwcJabmBBhknYiGdtxFj3r7qJzwEy5caX3oEUT+vhAWk948JyCRIPS8I8Ze+oyhQPsFw
         MH+udTKLBE3C7TXivaXCV4xNQbHwtK9MGtWbsYXzjz4y5QG2ZoyituPbA3Oh0avkNWyu
         cO3w==
X-Gm-Message-State: ALQs6tAN+HhNmktIj6p5RFWTofVUlVMq0TKOrSolR5kza/jRSCxmJc+O
        Uf9o4jGI7qerPyvbbdOpb5ZEp6PqDFu3KHlQcJ0=
X-Google-Smtp-Source: AIpwx4+hyTMUZZc8VV9NusyzCgi6IGsVpe0wOL7/zs2q0cEkZdep/LFhSMf0Z0s2O0+mxFpqNzUh+NHeTWsTVZ6zdEg=
X-Received: by 2002:aca:5b06:: with SMTP id p6-v6mr11529140oib.216.1524413565374;
 Sun, 22 Apr 2018 09:12:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Sun, 22 Apr 2018 09:12:14 -0700 (PDT)
In-Reply-To: <9303a7ef-5895-a974-84dc-98521be14793@ramsayjones.plus.com>
References: <20180415164238.9107-1-pclouds@gmail.com> <20180421165414.30051-1-pclouds@gmail.com>
 <20180421165618.GA30287@duynguyen.home> <a5dc36f7-fc79-46ba-7e73-e9473cf1aec9@ramsayjones.plus.com>
 <CACsJy8Cj57=p5nKH1T2UZmFbDv2d_JRO+GcAo29SAZcSxgKCkw@mail.gmail.com> <9303a7ef-5895-a974-84dc-98521be14793@ramsayjones.plus.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 22 Apr 2018 18:12:14 +0200
Message-ID: <CACsJy8AcTkPgVavDo_nUZkwPAFy335j94BY=BwATHbv5sdvu=w@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Keep all info in command-list.txt in git binary
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 5:58 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>>> I think you need to try a little harder than this! ;-)
>>
>> Yeah. I did think about grepping the output but decided not to because
>> of gettext poison stuff and column output in "git help". If we do want
>> to test this, how about I extend --list-cmds= option to take a few
>> more parameters? --list-cmds=common would output all common commands,
>> --list-cmds=<category> does the same for other command category. This
>> way we can verify without worrying about text formatting, paging or
>> translation.
>
> Hmm, my immediate reaction would be to prefer my simple tests.
> Yes, they are not exactly rigorous and they would be affected
> by changing the help formatting, but they are effective. ;-)
>
> [I don't think the formatting would change that often, or at
> all - whoever submits that patch would get to update the tests!]

Hmm.. for non-column output that's true. "git help" with column output
should probably fine as well because even though we add more and more
commands every month, these are not marked common (and unlikely so).
So yeah I agree.

> What did you think about adding the BUG() checks?

I was thinking if there was a way to fail the build after running
./generate-cmds.sh and generating empty output but it does not sound
easy to do. So yeah, BUG() checks sound good.

-- 
Duy
