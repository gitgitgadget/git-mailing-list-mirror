Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1D681F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 14:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdAYOfv (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 09:35:51 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35164 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbdAYOfu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 09:35:50 -0500
Received: by mail-lf0-f68.google.com with SMTP id v186so21395785lfa.2
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 06:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zW2SeLj50LukFXWHmspe7bT9C3KAGASZ32aNl88Qj5A=;
        b=OQD8HUVDISaZdpswPbqjvzSUgkUGULHAD6t9hO7RpxpjrSnC45+s+ZY/Cf8nJLcdmz
         j9AcvDqpcCXkYE0fnCH5VF7JwVxc3WZBkrJ7AmBMhyIMcOwqttR5kT+XccIGbx650ZNd
         AkeFearhBmMZ75Eif/B1BYwgWk40jrWzPE5tyJ9l90/l9m3Y1pknx6E2F3LTesMHn4+i
         Llq9kQ/CQfglHQWA8ftwJeJoLk3f9SL/X8oMJsFSewW6xKLEN5Pjgn5cRqC8lKrwwAaL
         7Mh7fSsNw909Y8nWreC/r605iwOkDalRXwBM22BKx1Fj0j48NERwyLYbyhTiArcPMoQb
         rzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zW2SeLj50LukFXWHmspe7bT9C3KAGASZ32aNl88Qj5A=;
        b=tHvJKy+hYGMXJHJt348wp48gYbWzNZK5b/tc0PAJ/ULetl1r1g7jF5r9DeZNDDz3yM
         g+ggl9HXFkwblQnFl/afpLgUUJnMpwhMM4/0sWT+oHhQWqxus9ugEpKwPA5Xcgzxrbpm
         nX68eLn6PWUJT0szVDoTGBLLMZk2JyfCvNSenBX6hArmft8rhorbPgXh2plTMe/zjvUh
         nWHORAKI1jyPdyfEGThNrx74RzGvNQvfvjpkmXp8oyQJC5hMWLrJM6lX8C42e6gCQWJf
         JDJe2kw6SgUmqeM9LaHQEWj/S+WA/W2+VeaF1EzjT/WQ9ujckF6SNHvDKhfnCKwSgZYw
         X4lQ==
X-Gm-Message-State: AIkVDXIntNfYKg3I5yMSuCpWa+b4lyaRxiGp1C8zLP1SyHqj2fW56scpmEQaPKgOfyTtp9wl9Yvp+YaOP8r51A==
X-Received: by 10.25.67.83 with SMTP id m19mr11316890lfj.24.1485354948747;
 Wed, 25 Jan 2017 06:35:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Wed, 25 Jan 2017 06:35:47 -0800 (PST)
In-Reply-To: <xmqqefztsj4c.fsf@gitster.mtv.corp.google.com>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
 <20161226102222.17150-15-chriscool@tuxfamily.org> <xmqqa8bhb32x.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD1EgOxcPi=tpiosKkYMcCZe+b6gwW0CKt2sE1NZ7gQv=A@mail.gmail.com>
 <xmqqo9zi35n6.fsf@gitster.mtv.corp.google.com> <CACsJy8AR6yNr0y+_JZDkW-HO_yHPkUx_6zbLGoviKQBOVcSg5A@mail.gmail.com>
 <xmqqvatouwsh.fsf@gitster.mtv.corp.google.com> <CACsJy8B_xe6RtszPrncvDdSYosNUQxvhcEQ3DO_WO0sepXqvvQ@mail.gmail.com>
 <xmqqlgu627uj.fsf@gitster.mtv.corp.google.com> <CAP8UFD2LWGtNtdhtQTZXqsACBvK=jD25vt8M4HzBRBVS1sJ+=Q@mail.gmail.com>
 <xmqqefztsj4c.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 25 Jan 2017 15:35:47 +0100
Message-ID: <CAP8UFD3KXOgVOhuMtws36XPiek56U4mQKdUs07hzKc-dC=ppmA@mail.gmail.com>
Subject: Re: [PATCH v3 14/21] read-cache: touch shared index files when used
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 23, 2017 at 7:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Also in general the split-index mode is useful when you often write
>> new indexes, and in this case shared index files that are used will
>> often be freshened, so the risk of deleting interesting shared index
>> files should be low.
>> ...
>>> Not that I think freshening would actually fail in a repository
>>> where you can actually write into to update the index or its refs to
>>> make a difference (iow, even if we make it die() loudly when shared
>>> index cannot be "touched" because we are paranoid, no real life
>>> usage will trigger that die(), and if a repository does trigger the
>>> die(), I think you would really want to know about it).
>>
>> As I wrote above, I think if we can actually write the shared index
>> file but its freshening fails, it probably means that the shared index
>> file has been removed behind us, and this case is equivalent as when
>> loose files have been removed behind us.
>
> OK, so it is unlikely to happen, and when it happens it leads to a
> catastrophic failure---do we just ignore or do we report an error?

Well, when we cannot freshen a loose file (with
freshen_loose_object()), we don't warn or die, we just write the loose
file. But here we cannot write the shared index file.

And this doesn't lead to a catastrophic failure right away. There
could be a catastrophic failure if the shared index file is needed
again later, but we are not sure that it's going to be needed later.
In fact it may have just been removed because it won't be needed
later.

So I am not sure it's a good idea to anticipate a catastrophic failure
that may not happen. Perhaps we could just warn, but I am not sure it
will help the user. If the catastrophic failure doesn't happen because
the shared index file is not needed, I can't see how the warning could
help. And if there is a catastrophic failure, the following will be
displayed:

fatal: .git/sharedindex.cbfe41352a4623d4d3e9757861fed53f3094e0ac:
index file open failed: No such file or directory

and I don't see how the warning could help on top of that. It could at
most repeat the same thing.
