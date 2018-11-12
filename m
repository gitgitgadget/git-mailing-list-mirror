Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1322A1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 09:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeKLTmP (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 14:42:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53136 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeKLTmP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 14:42:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id r11-v6so7764186wmb.2
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 01:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HNDRrvpc65yLo/25bi/d/VIznzozZpDATBMzqabzBDA=;
        b=WmHBH4wDE5SnUVt5/EjnGCdqJ5oSdHdqBR1bQcX/e1m5ZX6kEWZK6p5wPutim1cZsj
         5lvrfnKb5y3qdbIC1kwQhb0XCs4J/JpPph8o/3gOdieLMmMWdRKbpzXTuHc478slMO4d
         Vxd+A1EtQt0864wcOTr1q1srXI9yBYfqbeAZ/Zm9x0z5tmxdbjnHmsld7DuDXMU12FmT
         DrFiZoqd6J77N6HjBoZm4If0nfNjGV0JSilaOKSTvTHMX+UNrgJAeuwD9Y7OdH41VY9r
         kCFnHZ7Qk8Xqeto3qqADTM6of2gB4+ri0rwyBINceOoQPOQVUldVpmQq8IC3s5w8NsnB
         SgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=HNDRrvpc65yLo/25bi/d/VIznzozZpDATBMzqabzBDA=;
        b=eoytDwWuQ0qf0rLMCCBm4Gn6aLfp+YETnstsIBrfMDlj73gW7HoqEdus5WSSkWjuY5
         jR6hVqpI1zmYB/qTbSkDsBa8qYu+V3gnTxWzDTsA/KUKFTj/aULpzBaHyK3xmaxXasgu
         tkw1r5TlAns/uiQGBXadOvsLYbk0BfQVwPQJ2Hkdqb0UvQDjw21vnK9MoFdhy7zT5NX6
         IAVcitH/Pg2frtnrQGW54cNoH0KgieE6/E7dLyx8u8dFs7Ri4C9SoXojKXRyZtLuaJmS
         o99DRm6AmjfV022s0K709BEw1M0LurJvJ/JIK3UNKuuIXluyy8llHfU2jg7pmlEqBobz
         oSWw==
X-Gm-Message-State: AGRZ1gL1O8dY+eK/1RoakXRnV+jxQq6Z1spswX/fuY4LwGSVc87l+nZx
        6bctJ69Jip9fTUnqCRooa1c=
X-Google-Smtp-Source: AJdET5dfTTSRiWPK5X6d54fgB7ybb6UF8kzzt8k1NfAmQduqoSZ73M2jC982Icwee2hjtv6d9DEipg==
X-Received: by 2002:a7b:c38f:: with SMTP id s15-v6mr7270300wmj.145.1542016187046;
        Mon, 12 Nov 2018 01:49:47 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id r1-v6sm14914174wrt.59.2018.11.12.01.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 01:49:46 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Matthieu Moy <git@matthieu-moy.fr>
Cc:     Per Lundberg <per.lundberg@hibox.tv>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, jost@tcs.ifi.lmu.de,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Junio C Hamano <gitster@pobox.com>,
        Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth \(IKS\)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
References: <875zxa6xzp.fsf@evledraar.gmail.com>
        <20181111095254.30473-1-pclouds@gmail.com>
        <871s7r4wuv.fsf@evledraar.gmail.com>
        <CACsJy8CYpuc7-CZhk7kQQVQFxOfLFZu4TVpG=b0a7j8P1J394Q@mail.gmail.com>
        <591ab1f7-ef39-13e5-83b8-76fe372ecc2c@hibox.tv>
        <1205132135.1189562.1542013731020.JavaMail.zimbra@matthieu-moy.fr>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <1205132135.1189562.1542013731020.JavaMail.zimbra@matthieu-moy.fr>
Date:   Mon, 12 Nov 2018 10:49:44 +0100
Message-ID: <87o9au39s7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 12 2018, Matthieu Moy wrote:

> "Per Lundberg" <per.lundberg@hibox.tv> wrote:
>
>> On 11/11/18 5:41 PM, Duy Nguyen wrote:
>> > On Sun, Nov 11, 2018 at 1:33 PM Ævar Arnfjörð Bjarmason
>> > <avarab@gmail.com> wrote:
>>
>> >> That will lose no data, and in the very rare cases where a checkout of
>> >> tracked files would overwrite an ignored pattern, we can just error out
>> >> (as we do with the "Ok to overwrite" branch removed) and tell the user
>> >> to delete the files to proceed.
>> > There's also the other side of the coin. If this refuse to overwrite
>> > triggers too often, it can become an annoyance.
>
> I may have missed some cases, but to me the cases when checkout may try
> to overwrite an ignored file are essentially:
>
> * Someone "git add"ed a file meant to be ignored by mistake (e.g.
>   "git add -f *.o").
>
> * A file that was meant to be kept private (e.g. config.mak.dev) ends
>   up being tracked. This may happen when we find a way to make per-developer
>   settings the same for everyone.

Yes, the cases under discussion here are all cases where a tracked file
clobbers a file matching a pattern in in .gitignore.

What I'd add to your list is:

* Some projects (I've seen this in the wild) add e.g. *.mp3 or whatever
  else usually doesn't belong in the repo as a "soft ignore". This is
  something we've never recommended, but have implicitly supported since
  the only caveats are a) you need a one-off "git add -f" and then
  they're tracked b) them being missing from "status" before being
  tracked c) the issue under discussion here.

* Cases where e.g. filename changes to a directory or globs because of
  that make this more complex.

> I both cases I'd want at least to be notified that something is going on,
> and in the second I'd probably want to keep my local file around.
>> If we feel thrashable is stretching it too far (which I don't think it
>> is), we could add a "core.ignore_files_are_trashable" setting that
>> brings back the old semantics, for those who have a strong feeling about it.
>
> May I remind an idea I sugested in an old thread: add an intermediate level
> where ignored files to be overwritten are renamed (eg. foo -> foo~ like Emacs'
> backup files):
>
> https://public-inbox.org/git/vpqd3t9656k.fsf@bauges.imag.fr/
>
> One advantage of the "rename" behavior is that it's safer that the current,
> but still not very disturbing for people who like the current behavior. This
> makes it a good candidate for a default behavior.
>
> This could come in complement with this thread's "precious" concept:
>
> * If you know what you're doing and know that such or such file is precious,
>   mark it as such and Git will never overwrite it.
>
> * If you don't know about precious files, just keep the default setting and
>   the worse that can happen is to get your file overwritten with a bakup
>   of the old version kept around.
>
> This would probably play better with a notion of "precious" files than with
> a notion of "trashable" files.

I used to think this foo -> foo~ approach made the most sense (and said
as much in
https://public-inbox.org/git/871s8qdzph.fsf@evledraar.gmail.com/) but I
think it's probably best not to do it and just error out, because:

 * We'd still need to handle the cases where "tests" the file collides
   with "tests" the directory. Then where do we move the colliding file?
   ~/.git/lost+found/* ? We could handle the subdir case with another
   special-case though...

 * I think such silent action will just leave users more confused, and
   in many cases (e.g. a merge) whatever message we print out will be
   missed in a deluge of other messaging, and they'll probably miss it.

   I'd like to avoid a case where a bunch of *~ files get committed
   because the user's workflow is (and some beginner git users do this):

       git pull && git add . && git commit && git push

   As the "pull" would now invoke a merge that would do this rename.

 * If I have the "foo" file open in my editor (a plausible way to run
   into this) I switch to another terminal, do the merge, miss the
   message, then re-save "foo". Now I have both "foo" and "foo~"
   on-disk. Another case where we should just refuse until the user
   resolves the situation to avoid the confusion.
