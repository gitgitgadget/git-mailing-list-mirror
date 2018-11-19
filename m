Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A7221F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 13:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbeKSXbl (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 18:31:41 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36898 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbeKSXbl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 18:31:41 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so20522032edb.4
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 05:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+9w/eoyYmNnO+mqxqswkxbhLikHDvz7jvAy46Wg+m9k=;
        b=XEFla6PtRbrr1jQDxQAVfrcwrOef1TrTd/3vsWxTRD3RGfSKpAlql8CJnFxZgXlTig
         TAJY1R++vUCw1Dh6RYiB6TBANfRgmyTEPZuGc0shI04083QfpmU7WvOyxc8kQW1CemSB
         cEVrXPK0Fu5QZ+YBOSuBM/G/i4MJV5XDewYX5K30jhXA3Qy/ek6Y//deU6sCZvdBzpgf
         Akg0PjiWuWRjzRZvjQhvar02K/o0dnFjEZ160ACS4VTQ7G7tufFIFUE5n1i9CVVHd5YS
         GjMo+t6KfAC0VekpazRzCu872wYgHZyoNfIPWRjiLUbuDlCO0RRiI06VvIu7Y7nn7ba8
         /BkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+9w/eoyYmNnO+mqxqswkxbhLikHDvz7jvAy46Wg+m9k=;
        b=XnwBg/M1FMpmLZxD3xcrMJnSocrPQBGki8P5WB3o85PRW53AqOCJNL6GbHpVEFvGIu
         VMivwSPlGQ4VGfVvL5JFG3TP+36vQN+bpsCXo/xXSycZS9kYfjCR9GF0/scV93Tlm5mZ
         2ykRJBvLUuu3WNs2L6ygv1vJA3SN5NxwS53YtGFRi6hSUu5/nBY5sPY49W1QAFcci8/2
         tPfBJiw7yYAKpNLs+GKWUCL1Ca8JrdM10/f4rg2Bf/NqcVCGL3p2qjXcWxhU0vkb7RwC
         9xfSwynEFQ/mtcscgVBle0cJRjwwrFZ4Eg0brTDYH+Pfj/V+stetkcbF6ZBvsmYBDaZ/
         4tBg==
X-Gm-Message-State: AGRZ1gIjtmHo0rh4ur/frcHGLagox7CEXo5sQC5FIpa/1hQhonaECcbo
        SxRmA/0D9m+mbuX4rZnvq1o=
X-Google-Smtp-Source: AJdET5cIb3/dEvWdvO6d/5gqx6LS5I/iHnuMyyVp6G31R0DaKTVdyjH39+whJ6kGi8ZDsvI1bFfHnw==
X-Received: by 2002:a17:906:7c52:: with SMTP id g18-v6mr11904290ejp.77.1542632885115;
        Mon, 19 Nov 2018 05:08:05 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id f6-v6sm11422844edr.18.2018.11.19.05.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 05:08:03 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] checkout: print something when checking out paths
References: <20181110133525.17538-1-pclouds@gmail.com> <xmqq8t1y3jex.fsf@gitster-ct.c.googlers.com> <CACsJy8BGgf0J=iKNc3qmz_rTMNdaPmR_1v+9i3nhGKcuOH4AFA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8BGgf0J=iKNc3qmz_rTMNdaPmR_1v+9i3nhGKcuOH4AFA@mail.gmail.com>
Date:   Mon, 19 Nov 2018 14:08:02 +0100
Message-ID: <8736rx1ah9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 12 2018, Duy Nguyen wrote:

> On Mon, Nov 12, 2018 at 7:21 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>>
>> > Since the purpose of printing this is to help disambiguate. Only do it
>> > when "--" is missing (the actual reason though is many tests check
>> > empty stderr to see that no error is raised and I'm too lazy to fix
>> > all the test cases).
>>
>> Heh, honesty is good but in this particular case the official reason
>> alone would make perfect sense, too ;-)
>>
>> As with progress output, shouldn't this automatically be turned off
>> when the standard error stream goes to non tty, as the real purpose
>> of printing is to help the user sitting in front of the terminal and
>> interacting with the command?
>
> I see this at the same level as "Switched to branch 'foo'" which is
> also protected by opts->quiet. If we start hiding messages based on
> tty it should be done for other messages in update_refs_for_switch()
> too, I guess?

I have no real opinion either way, but whatever we can do about
"checkout" being so confusing since it does so many things is most
welcome.

Just an alternative: Maybe we can start this out as advice() output
that's either opt-in via config (not on by default) to start with, or
have some advice_tty() that only emits it in the same circumstances we
emit the progress output?
