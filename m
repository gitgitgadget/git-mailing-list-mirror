Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB5B202DA
	for <e@80x24.org>; Mon,  6 Mar 2017 12:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbdCFMct (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 07:32:49 -0500
Received: from mail-ot0-f180.google.com ([74.125.82.180]:35359 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752590AbdCFMcs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 07:32:48 -0500
Received: by mail-ot0-f180.google.com with SMTP id x37so66770841ota.2
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 04:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=whDaRsZsKilQqUPb8qHIizRKZ/+dT16rnrAxadnkdN4=;
        b=hM9wqeKwU03ZcfjeqXMS0U2HGlLtrTh0gQ5HMMzwO9h6x33KxJHapapekiuvMlODnc
         ULCzUAD79Gu2qxqpd5gMmgVhHZhPoRid3OvzO7vhHGXtRkBhUjMPAnCeXOR5dFbpJ34n
         4EJFwqyzJa36V0+O8xn6/M52ngCOV3uKQI5pbOO0mh4J5RQsqRlSprCGOXexkc5IlWgM
         4N9ub6migaFjuMg+8a9iZRrY22ilCJQVw5sQd5XdV3H7b6n7+BYLYGsYbPZIzqMJ374L
         e2N3EXT98zVSHkuXV8KWJorUVKm/7WK5GVsCa5vDAZc81jzH2fv817rXkILaktfqjvK4
         jJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=whDaRsZsKilQqUPb8qHIizRKZ/+dT16rnrAxadnkdN4=;
        b=lvbSzSBd9cD0rjBiBT5xe0pLylcBlreAo1SiKzg/b7Vg25fzZgyKEsQVSE3Y7Co7rb
         AF4sMnXnS7cxepJKS6Jz8uZ5okiKzDyWhrF62pAWq0RGu6xZ4fL34JUi3mgE/yPHB1gS
         y86HSFuX1/Au7sZEAF4wPD4f8xpxmH3+zO/rocrNhAIlOn27I1m8D4QL5VKD2RwKo2Vv
         7DQamuIrcoQ/+jv86HBh0yXT+yH2nMVjxz1s5lepxFduBAmzNHKw1l5tfsp4OQNDrRhn
         8z5IwRuyycI8Pd+wGFLWj3HKBrGcGWrD1+hv+MT1754PFo9DzPAeG55hRY+FWw6nshKr
         CEgg==
X-Gm-Message-State: AMke39nKEgwFkaHZpLEPBOYkF3gpjZ7C78yQKHmk5rz6XCE5dpgGmA4yvJX0LIdfYBL63Oyj14Qth/eSEX3iOQ==
X-Received: by 10.157.25.18 with SMTP id j18mr7618502ota.128.1488803474164;
 Mon, 06 Mar 2017 04:31:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Mon, 6 Mar 2017 04:30:43 -0800 (PST)
In-Reply-To: <7769af97-3dc7-f23b-c7c1-1d6b227a2f83@alum.mit.edu>
References: <20170218133303.3682-1-pclouds@gmail.com> <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-24-pclouds@gmail.com> <7769af97-3dc7-f23b-c7c1-1d6b227a2f83@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 6 Mar 2017 19:30:43 +0700
Message-ID: <CACsJy8CfB=ZwVuYJd8QfFM5PqFHKfHLZ8RqDmZ7=R-=PdOJbjw@mail.gmail.com>
Subject: Re: [PATCH v5 23/24] t1405: some basic tests on main ref store
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 3, 2017 at 11:43 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> It's notable that these tests grep around the filesystem, so they won't
> be applicable to future refs backends. Of course, "pack-refs" is
> intrinsically only applicable to the files backend, so for this test
> it's not surprising. But some tests could conceivably be written in a
> generic way, so that they should pass for any refs backend.
>
> Just food for thought; no need to change anything now.

I'm a bit on the fence about this. On one hand I think there is room
to backend-specific tests (and this one is more about files backend,
we just don't have any direct way of getting the backend except
through get_main_ref_store()).

On the other hand, I can see a need for verifying refs behavior across
backends. Submodule backend is unfortunately a bad fit (and probably
worktree backend too in early phase) because it cannot fully replace
files backend. lmdb does. I guess these tests will have some more
restructuring when lmdb joins the party.

I imagine we could have something like "ref_expect_success
[backend,[backend..]] <title> <body>", which makes it easier to
exercise a new backend with the same test, or we could add
backend-specific tests as well. Not sure how to do it yet (the devil
will be in the body, I think, like dealing with "git -C sub" for
submodules). Probably won't do in this series anyway.

>> +test_expect_success 'rename_refs(master, new-master)' '
>> +     git rev-parse master >expected &&
>> +     $RUN rename-ref refs/heads/master refs/heads/new-master &&
>> +     git rev-parse new-master >actual &&
>> +     test_cmp expected actual &&
>> +     test_commit recreate-master
>> +'
>
> Isn't HEAD set to `refs/heads/master` prior to this test? If so, then I
> think it should become detached when you rename `refs/heads/master`. Or
> maybe it should be changed to point at `refs/heads/new-master`, I can't
> remember. In either case, it might be useful for the test to check that
> the behavior matches the status quo, so we notice if the behavior ever
> changes inadvertently.

You had me worried a bit there, that I broke something. Yes we rename
HEAD too. No it's not the backend's job. It's done separately by
builtin/branch.c. Probably a good thing because I don't the backend
should know about HEAD's special semantics. Front-end might though.

>> +test_expect_success 'delete_ref(refs/heads/foo)' '
>> +     SHA1=`git rev-parse foo` &&
>> +     git checkout --detach &&
>> +     $RUN delete-ref refs/heads/foo $SHA1 0 &&
>> +     test_must_fail git rev-parse refs/heads/foo --
>> +'
>
> The last two tests have the same name.
>
> You might also want to test these functions when the old oid is
> incorrect or when the reference is missing.

I will. But you probably noticed that I didn't cover refs behavior
extensively. I don't know this area well enough to write a conformant
test suite. But I think that's ok. We have something to start
improving now.
-- 
Duy
