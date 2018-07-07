Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA1F41F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 15:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754109AbeGGPeJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 11:34:09 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:38263 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753567AbeGGPeI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 11:34:08 -0400
Received: by mail-vk0-f45.google.com with SMTP id b77-v6so8378990vkb.5
        for <git@vger.kernel.org>; Sat, 07 Jul 2018 08:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WSOJvyH7T0xMLuooo44t/PHEa4uGk+5zBzfJTaXpweM=;
        b=MCJC4cRDou0p5hxcaRUIbuGzZ4zr4yGe+3Mik2tgDKqmnxkxqZ3/ogNKLMArfsN8q0
         ydf9dNwAysgxIC89W3s2QYOn56cCEMbHRRtsXns+ZbybDWjBRDt6F00+5ln3y/wgkalI
         q8SSMr8fk1oRyU7Efh9b+qFcISso2mgmQp51xuScg0yJOJ+sABRDikREBYGbPJTiJYRQ
         EadaEOJhxY7F9boWmSMIo5r+fhDVYOLZiOUxglaObaslS72XEeKG9sCmyefSFg+Y7hYf
         5QI0dHcSKGWkXBT8iWAGX0x/Vc2QNXdrm/fZS8lGczspiFqgoZUmbnOQnU0YVUONq59A
         NWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WSOJvyH7T0xMLuooo44t/PHEa4uGk+5zBzfJTaXpweM=;
        b=LRE4zamjKWWmnGanMVeNskNnWxdsHYF5gqL0Ei+G77HvNVMDB9whOHXgSVjTa3cgMn
         /mQswysDiAq/bzcNUFCyQLKdIsZ6Zkv7abnN7CJSDWbZz5vhRE0HBDhtn9Qs3XBrHRvM
         LOIisRmqYBT0G7RWpYXP5ykUoaTbc5bd+rsYW/uQ0q1vXl5zBmaY8t/MNkov0aZqCrAa
         tKKYpfpczTgnSlgkV1Tpt1Hb5vshjHlFxA/v86xdzEEGIANnJ4CslLCESuueJnLOoLZy
         LGdAfs/re4QZmretgDdUdgeG8PrlN3Bn6ZVa0nGBq2S+6GliQxPyfLhEj1UFHQgWtV26
         uO2g==
X-Gm-Message-State: APt69E332bLhGqIBA4+f5lvh6mOVETfUaG/NLKl6fjOkNXveRaAz79+w
        pJJBTthgkmcEu9IO3A28s6hCOE4Mg6XHyaf+7Yg=
X-Google-Smtp-Source: AAOMgpcmUowbJhoMcPyy/xjB9KvYaKevDnHr8LQIZqkPigvqsQo5LLwiAgjpMHlKrjIGq/PwcHv9FhPRH+K5AMOqTTI=
X-Received: by 2002:a1f:190d:: with SMTP id 13-v6mr2939032vkz.76.1530977647307;
 Sat, 07 Jul 2018 08:34:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Sat, 7 Jul 2018 08:34:06 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1807071411090.75@tvgsbejvaqbjf.bet>
References: <xmqqlgaogeff.fsf@gitster-ct.c.googlers.com> <CABPp-BFs1gYzBY5+QrrLEB5kJTaierSGDnYWs=5HKRcPksx9cw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1807071411090.75@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 7 Jul 2018 08:34:06 -0700
Message-ID: <CABPp-BHRE5ygBaXEkrmB_2-YKhq2Mr_Hr9Mg4PbUK_8-EmYU+Q@mail.gmail.com>
Subject: Re: What's (not) cooking
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        kgybels@infogroep.be
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Sat, Jul 7, 2018 at 5:11 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Elijah,
>
> On Fri, 6 Jul 2018, Elijah Newren wrote:
>
>> On Fri, Jul 6, 2018 at 3:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > I'll be pushing out the integration branches with some updates, but
>> > there is no change in 'next' and below.  The following topics I gave
>> > a quick look and gave them topic branches, but I had trouble merging
>> > them in 'pu' and making them work correctly or pass the tests, so
>> > they are not part of 'pu' in today's pushout.
>> >
>> >     pk/rebase-in-c
>> >     en/dirty-merge-fixes
>> >     en/t6036-merge-recursive-tests
>> >     en/t6042-insane-merge-rename-testcases
>> >     ds/multi-pack-index
>>
>> It looks to me like the main problem is that pu itself has lots of
>> test failures.  It seems to bisect down to
>> kg/gc-auto-windows-workaround.  If I revert commit ac9d3fdbebbd ("gc
>> --auto: clear repository before auto packing", 2018-07-04), then pu
>> passes tests again for me.
>
> Is this the segmentation fault about which I just sent a mail?

Yes, this is is a gc segfault issue.  It looks like every test calling
git gc will fail because of it, I even saw a "nothing to pack" message
or something like that followed by a segfault.
