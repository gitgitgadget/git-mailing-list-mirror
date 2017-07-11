Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C0942035A
	for <e@80x24.org>; Tue, 11 Jul 2017 15:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933496AbdGKPui (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 11:50:38 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34220 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933465AbdGKPug (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 11:50:36 -0400
Received: by mail-pg0-f67.google.com with SMTP id j186so386096pge.1
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 08:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GHJ/HR+82Tklb6oozLtld2a+FO0mVaZUkastYFYoPd8=;
        b=P8FmwEBuCd9uy7upfvjYkf5b8Cr8+1f7hUEdopYlyD19MkiMRBjyM9SJuaKq+Nz2GW
         uMrkn3jYgz8lsUmgjGfU3Zk1W3FoBm/6EuxCnGB706psk97Cux94whZa5G9WRGg2eEYr
         rEX7N5lRlz15B7IzO6fJYJGu9Fneu6gLRr7g0Odp0tT7r+n0yRxbykyR+u2EKUl2kQl3
         3kT1mZqGNN/k0wkng7T0Tf7Cpo0zS+JmN8XVsUTbYfXSB7qbAqPfAgF4oUVOoEy+Y6jl
         JblbS4UvirzKNSlRAi0TXkPRq4JkxAjomq5TLbZHZ+IkBXKIDqIUy5myJ3dHkq/e4BJx
         Hd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GHJ/HR+82Tklb6oozLtld2a+FO0mVaZUkastYFYoPd8=;
        b=ZHy30CoMS5dw0DhwNwab55ZmOr3IScLNTfsyKAxKTaniWtFEE0cW1XwiIlDK29p2a8
         nytHwltllc0PC53qFmxGjlnZfpb5bejvcF56ski6Xz7kkxueih2ruEc3qqsUCscbnD5Q
         u9fk/zkV8gzu1jc94u77oe9nKJ+Tbc3y6apqHs/WHpxECEFiSSIM+bd6pygj1CPeoY7B
         /MTbNR4dzwFK80ErtaiE+zxMaiMCzTMYXc9kptKsmxCY9AWnulnGBonFNd97PXtayMgi
         1nOnGRAbWasPUj1pCex9mDi7V5hlLSdeTEndKOj0/IzO9ZR7stYbIxIRqRzBqdHiVXRV
         gc+w==
X-Gm-Message-State: AIVw110ALH56NpUaBnuLNEX1Mgf4m9qF8v2HKVCnq7oJIJB0+WWiyYSc
        WSZsNnV/TboNig==
X-Received: by 10.84.231.143 with SMTP id g15mr592802plk.157.1499788235789;
        Tue, 11 Jul 2017 08:50:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fdda:b931:7ea7:8e3c])
        by smtp.gmail.com with ESMTPSA id d18sm763006pgn.27.2017.07.11.08.50.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 08:50:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #03; Mon, 10)
References: <xmqqlgnv52oq.fsf@gitster.mtv.corp.google.com>
        <99EB15B6-CAA1-4C78-88B6-C934C8FBD8F8@gmail.com>
        <20170711091108.3qj35d4yk5el5xxa@sigill.intra.peff.net>
Date:   Tue, 11 Jul 2017 08:50:33 -0700
In-Reply-To: <20170711091108.3qj35d4yk5el5xxa@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 11 Jul 2017 05:11:08 -0400")
Message-ID: <xmqq7ezf3rcm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jul 11, 2017 at 10:28:08AM +0200, Lars Schneider wrote:
>
>> > On 11 Jul 2017, at 00:48, Junio C Hamano <gitster@pobox.com> wrote:
>> > 
>> > * ls/filter-process-delayed (2017-06-30) 7 commits
>> >  (merged to 'next' on 2017-07-05 at a35e644082)
>> > + convert: add "status=delayed" to filter process protocol
>> > + convert: refactor capabilities negotiation
>> > + convert: move multiple file filter error handling to separate function
>> > + convert: put the flags field before the flag itself for consistent style
>> > + t0021: write "OUT <size>" only on success
>> > + t0021: make debug log file name configurable
>> > + t0021: keep filter log files on comparison
>> > 
>> > The filter-process interface learned to allow a process with long
>> > latency give a "delayed" response.
>> > 
>> > Will merge to 'master'.
>> 
>> Hi Junio,
>> 
>> can you already tell if this topic has still a chance to be part of 2.14?
>
> I'm not Junio, but we should be able to reason it out. :)

I am ;-).

> It's marked as "will merge to master", which typically means it will
> happen during the next integration cycle (i.e., within a few days when
> the next "What's cooking" is written).

Just like being in 'next' is not a promise for a topic to be in the
upcoming release (or any future one for that matter), "Will merge to
X" merely means "With the current shape of the series and with the
best of our current knowledge, this is thought to be mergeable to X
at some point in the future".  When a more urgent topic that
conflicts heavily with it appears, when a serious bug is found in
the topic, etc., "our current best knowledge" may be invalidated.

Anticipating such an event that changes our assumption happening, I
try to keep a topic in 'next' for at least a week, if it is a
non-trivial topic that changes more than a few dozen lines (not
counting tests and docs).  For things that touch deeper guts of the
system, I'd prefer to cook it longer.  For more trivial things, it
may only be a day or two.  So "at some point in the future" varies
depending on the weight of a topic.

> Since 2.14 will be cut from the tip of master in a few weeks, once
> it's merged it will definitely be in 2.14 (barring a revert, of
> course).  This holds true during release freeze, too. Anything
> that makes it to master is part of the release.

This is correct.

> The stopping point there is that things stop getting marked as
> "will merge to master".

This is correct, if you allow the possibility that a thing that used
to be marked as "Will merge to 'master'" gets demoted to "Will cook
in 'next'" (and you need to anticipate that possibility---I try to
demote topics that got in to 'next' just before -rc0 to to "Will
cook" when tagging -rc0, unless they are fixes that are not too
involved).

I probably should have marked this as "Will cook in 'next'" in the
first place.  The practice has been to blindly promote "Will merge
to 'next'" to "Will merge to 'master'" by default when a topic gets
merged to 'next', and then inside of the first week try to find a
chance to re-read the topic to decide to demote it to "Will cook".
