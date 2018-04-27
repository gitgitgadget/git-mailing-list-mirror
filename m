Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 112A51F424
	for <e@80x24.org>; Fri, 27 Apr 2018 19:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759149AbeD0Txn (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 15:53:43 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:42714 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759022AbeD0Txl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 15:53:41 -0400
Received: by mail-io0-f180.google.com with SMTP id a10-v6so3770316ioc.9
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 12:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UjdfRdmzBiIUD+uqZpi/pbAGH5V7VqywGTHIWW2JkdI=;
        b=bnbGJI9k863JjLZaYZ2Btcjn0Tr0qQMdZrd+//cnXWazsDz5IOFq8weF5gJ5qil+Us
         19YYaGcfhApfPCGlSSRhx1q77er9q9MMZNAah1oYMg3XZ8tm2dz2bHqaVtRmgFcqPmqz
         2CZIkIitSJqR2kg55PvClNohLhqt7CvE4rwjINuWh5h3Pe6ocOXsWVzEXdk7sFf+RiIA
         tDe4tbmFkFN4bpNaaQI0Cb68AlosxI66WBu6Y20TFfiSdwkiBXZUZWYY/IyrrNnZL4bu
         c8nCiuz52bDzqz3BzHIL6xP8KUeUda6G619M8FOVlabaoXXkRU6faG+yedNPWIivX54r
         h7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UjdfRdmzBiIUD+uqZpi/pbAGH5V7VqywGTHIWW2JkdI=;
        b=C7YZ6TFWdClUz5/At9amQ+LoO5wgyYciikRywRNNohHldhSxtPMxDaoJrM6xRY2hMd
         ZFCw9cHOK71gj0mxEdrrVpuU2rV2NpioOfb+c0VOzn1gL3CcoQd7UhoHD/ivQZqUjrYi
         GPUwTtNJh/HIos9mJfOjK/M3fOkG8WDbhgFQyJ1J6vG/e8LeCn+9Jao7xxte97H5FVGI
         wsP+4/tz+zlPisQupPkz53ZomnMSfjgMbRJ9M7q02AuaOLlT1R/LstyPO23wyflE7VKG
         hYHbV/g7nRRCtbkvP7soZCjqpbf9ea8/4E7nq7E4QVMaT3igJd16iZg7amA4fF1Kr5eH
         uf9A==
X-Gm-Message-State: ALQs6tDJ6iWK9Xy/GSJifmW/i21g4y+XCuYP7wmrBNqCCbro+25FgzFL
        J7l4D2BBRP48Aozo1apPXNan1PTwd5KYZzZTAqA=
X-Google-Smtp-Source: AB8JxZqooUaUMEgkNeVeaL5tfAjD0av8zazi7xo+weHppKVWrwbwoCfctP4F8E6KkcpTjdNim77KGZgqxAAOHtK87WQ=
X-Received: by 2002:a6b:8aca:: with SMTP id c71-v6mr3669963ioj.255.1524858821193;
 Fri, 27 Apr 2018 12:53:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.149.81 with HTTP; Fri, 27 Apr 2018 12:53:20 -0700 (PDT)
In-Reply-To: <1524849496.1125.30.camel@gentoo.org>
References: <20180413170129.15310-1-mgorny@gentoo.org> <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
 <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com> <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
 <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com> <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
 <1524849496.1125.30.camel@gentoo.org>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 27 Apr 2018 21:53:20 +0200
Message-ID: <CACBZZX5AG62uV9O9C69AzgzP5=x1J7r0x3B0BRXS0uMJ9qLn2w@mail.gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
To:     =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Cc:     Marc Branchaud <marcnarc@xiplink.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 27, 2018 at 7:18 PM, Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>=
 wrote:
> W dniu =C5=9Bro, 25.04.2018 o godzinie 11=E2=88=B618=E2=80=89-0400, u=C5=
=BCytkownik Marc Branchaud
> napisa=C5=82:
>> On 2018-04-25 04:48 AM, Junio C Hamano wrote:
>> > "Robin H. Johnson" <robbat2@gentoo.org> writes:
>> >
>> > > In the thread from 6 years ago, you asked about tar's behavior for
>> > > mtimes. 'tar xf' restores mtimes from the tar archive, so relative
>> > > ordering after restore would be the same, and would only rebuild if =
the
>> > > original source happened to be dirty.
>> > >
>> > > This behavior is already non-deterministic in Git, and would be impr=
oved
>> > > by the patch.
>> >
>> > But Git is not an archiver (tar), but is a source code control
>> > system, so I do not think we should spend any extra cycles to
>> > "improve" its behaviour wrt the relative ordering, at least for the
>> > default case.  Only those who rely on having build artifact *and*
>> > source should pay the runtime (and preferrably also the
>> > maintainance) cost.
>>
>> Anyone who uses "make" or some other mtime-based tool is affected by
>> this.  I agree that it's not "Everyone" but it sure is a lot of people.
>>
>> Are we all that sure that the performance hit is that drastic?  After
>> all, we've just done write_entry().  Calling utime() at that point
>> should just hit the filesystem cache.
>>
>> > The best approach to do so is to have those people do the "touch"
>> > thing in their own post-checkout hook.  People who use Git as the
>> > source control system won't have to pay runtime cost of doing the
>> > touch thing, and we do not have to maintain such a hook script.
>> > Only those who use the "feature" would.
>>
>> The post-checkout hook approach is not exactly straightforward.
>>
>> Naively, it's simply
>>
>>       for F in `git diff --name-only $1 $2`; do touch "$F"; done
>>
>> But consider:
>>
>> * Symlinks can cause the wrong file to be touched.  (Granted, Micha=C5=
=82's
>> proposed patch also doesn't deal with symlinks.)  Let's assume that a
>> hook can be crafted will all possible sophistication.  There are still
>> some fundamental problems:
>>
>> * In a "file checkout" ("git checkout -- path/to/file"), $1 and $2 are
>> identical so the above loop does nothing.  Offhand I'm not even sure how
>> a hook might get the right files in this case.
>>
>> * The hook has to be set up in every repo and submodule (at least until
>> something like =C3=86var's experiments come to fruition).
>>
>> * A fresh clone can't run the hook.  This is especially important when
>> dealing with submodules.  (In one case where we were bit by this, make
>> though that half of a fresh submodule clone's files were stale, and
>> decided to re-autoconf the entire thing.)
>>
>>
>> I just don't think the hook approach can completely solve the problem.
>>
>
> There's also the performance aspect.  If we deal with checkouts that
> include 1000+ files on a busy system (i.e. when mtimes really become
> relevant), calling utime() instantly has a good chance of hitting warm
> cache.  On the other hand, post-checkout hook has a greater risk of
> running cold cache, i.e. writing to all inodes twice.

The FS cache is evicted on a LRU basis. What you're saying is true,
but in the two different implementations there's maybe a 2-3 second
gap between what git is doing and the post-checkout hook is doing. If
the system is under such memory pressure that you've evicted the pages
you just touched you're probably screwed anyway. Maybe I've missed
something here, but this point seems moot.

There's certainly other good arguments against using the current hook
implementation for this, e.g. not being able to do this on clone as
noted upthread.

I think patches that made this configurable in some way in git would
be worth looking at, and due to the subject matter it might make sense
to have it in the core distribution as a non-hook, but I think the
default behavior should always be what it is now, since almost nobody
cares about these edge case,s and users should have to opt-in to use
behavior to work around them.
