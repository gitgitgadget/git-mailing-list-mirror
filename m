Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E3431F453
	for <e@80x24.org>; Wed, 13 Feb 2019 21:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbfBMVgN (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 16:36:13 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45851 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbfBMVgN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 16:36:13 -0500
Received: by mail-ed1-f66.google.com with SMTP id d9so3235084edh.12
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 13:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7jA9/FYghpbkIjJGpgtOpxp1rJdjwYY7QfnIoHAhKf4=;
        b=hN4hgR2/7sp+rSZz0MQeJp9dfbCI3CEJK2LPe3s5T3KUjvArVXHT4tAMVx8T1zQOB9
         pH9tLhnsMTCUULgRLojZW/TnXSB1OXIr8KIT4/vJeyNN9rRNttxqP8nGlwcfsdfixmqx
         HZCamn+ikucdBUFLFwXL6MITD6+MGrBZUPR3itDfcWnSfqp9Yf+4OrpPinKDwzIojB1g
         VNpKR2+g29dUYugnaa+HmO5DXxhyiyXPhvvj4G7jm7r5XVvdIAyKlSgILD5Ejyhk0uCV
         wFWQn30wwTDCdEWgwNxmq1KT6o3lRyaWn0t5BV+qhR79gBz0vgMyTjsvYdbOv/g6vhzV
         kWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=7jA9/FYghpbkIjJGpgtOpxp1rJdjwYY7QfnIoHAhKf4=;
        b=ZDBoxtwLQ7LvqN9cIbW5Tzvenx7PR6xEMQfPd3NkvzCMZSB9suHZM55Jj+Rw2i39ld
         H6os6ek66Cf4TL5WW1xZrepZ2p0ubvXL2SapE7oQ5paSrMjbWYa0AbbgT+ahYBdDKEVt
         sZn5z7apfNSFbgDGU3NStLSwSavJF2t4RrI7m5ajY/IzH8qsxbNL0+8HkxCfJe27TrU5
         zEyXZISvjKPlIyY6kqLbQT1tyr4Vgj5LeEQ6GGNPiTakpfWWDdP18jqJyDNjOReKzgsa
         WqhumWbAaaA8BHuVmcGBIrsNdnbWUhuaC45XyO7K4G0f66uJd0ytNTYQUPDJ5oecf7nj
         XGgw==
X-Gm-Message-State: AHQUAuYG12edVpDgwfbMs7Wq1vI8dQ9WWIoAFLRaovQqVQxmq0zmvsYN
        rwsbwKZSBi6t8MnDkPPAunY=
X-Google-Smtp-Source: AHgI3IbGgTyMQphQ6HIu8aWb8mtkTzTw1JMP/kqiHWsIQbwpPFqfjAyGroKzpuNo6DWW384mLiHqRA==
X-Received: by 2002:a50:86cf:: with SMTP id 15mr128398edu.239.1550093771128;
        Wed, 13 Feb 2019 13:36:11 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id i33sm120756edc.8.2019.02.13.13.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:36:09 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: How to get next commit that just after a specified commit
References: <87mun0j9vv.fsf@evledraar.gmail.com> <xmqqimxnbdfq.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqimxnbdfq.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 13 Feb 2019 22:36:08 +0100
Message-ID: <87ef8bjrqv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 13 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> (Replying to
>> https://public-inbox.org/git/383c14cc.9289.168e61d39e8.Coremail.wuzhouhu=
i14@mails.ucas.ac.cn/
>> which curiously I can see there, but not in my inbox (or spam))
>>
>> Git's data format doesn't make it easy to find "C" given "B" in a commit
>> chain like A->B->C (also there could be any number of "C"
>> successors). We need to walk the graph. This shows how to do it:
>>
>> https://sqlite.org/whynotgit.html#git_makes_it_difficult_to_find_success=
ors_descendents_of_a_check_in

I didn't mean to link to that fossil page to start some fossil v.s. git
argument. I just remembered having seen the one-liner there.

> Of course, the history is not necessarily linear.  Even though you
> *MUST* know all your parents before having a commit (which means
> that when you ask "what came before this commit", there is a
> definitive answer that everybody in the world would agree on), you
> by definition cannot know all the commits that are children of a
> commit (simply because somebody else may be creating a new one), so
> the question "what's the next commit" does not make any sense from
> that point of view ;-)

This is the case with fossil as well. You could create a new descendant
commit at any moment.

Their point in comparing it to git is that there's nothing intuitive in
the UI that exposes this information for the *current* graph, whereas in
fossil this is a built-in command:
https://fossil-scm.org/xfer/help/descendants

Perhaps this information is cheaper to extract these days with the
commit graph and we could expose it somehow?
