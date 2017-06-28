Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF5B22023D
	for <e@80x24.org>; Wed, 28 Jun 2017 22:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbdF1Wfj (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 18:35:39 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:33993 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751614AbdF1Wfh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 18:35:37 -0400
Received: by mail-io0-f179.google.com with SMTP id r36so44142293ioi.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 15:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AKSJbtHaFUJE/KWu4Szkon3qD6nDpTJ5Tl02MeKkbo4=;
        b=rq1sQz8vDq45wvb4LQsKKg9mHvwrJikUqtjMO1RxVu7gHPLKY/bmriyguRkE82VUJu
         L6YtHWZ/O5YL34kpz6wM82rwdJIpsPxqdVGYFeWTpXbVD6+gT6NDs+x3cu0s78gfVCzA
         vQ5VzwcNzGFQZeNExTPH4L45CXNLjQI5ys9YNXg+q3QdkCZpVWkDgnxw35VHUmZ+BW2i
         ABb5aJaD1krC1dULpy1+ldhJ/gT/FGqbpmV9K8OolC9sChLdDl4777qHXEVPyoOY/eCA
         ZtDjBuC03w16w4+KdsqZcmjvuQX192fPNJXIR6v13lRyUJSPKAJmwURwh8s7zk2wv6nZ
         Q+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AKSJbtHaFUJE/KWu4Szkon3qD6nDpTJ5Tl02MeKkbo4=;
        b=rh+aeg6bdfCDKX+cQ+ExNbYEdGTHNRcNiFef8QGeAAL1AHD2BqYnfnTUJIsWxWgySp
         zz4YIkW57NRuHZfZsyAJy7rMepoOHk3GSxjY7g4X0lSBiMcDsl8r1La75XQSUv39Gk/k
         e0eAnw9lX1WCk8HyISkuty7OhzSWTi1s4mj3R8bQZf9WxGYQjWbhELmNRme/Enf+4bJk
         1RBCN0xvnPHiAqjpXxA8TpaBuDFgoBlf9sFTAn0qgRiX6cOZ1wJLMx7XfEhBmmzAt4n3
         QgB+FHVBRuyqeDwdnQlCJYBK+bV45qAut+siM3kKpf8sAY9R+fQYX4VQpvckca/dIQ4j
         GDyA==
X-Gm-Message-State: AKS2vOwnAQPr/ujNzWgK0/pRi3JiTOTQ9ZmIoi22SiLVQwCLM2yqHsg0
        zuJjYi/rjJXSqq//v8wgk78P/LLcFg==
X-Received: by 10.107.10.205 with SMTP id 74mr13822982iok.80.1498689336923;
 Wed, 28 Jun 2017 15:35:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.31.10 with HTTP; Wed, 28 Jun 2017 15:35:16 -0700 (PDT)
In-Reply-To: <b1b97b26-f715-1d0f-410e-51356b05b890@web.de>
References: <20170615231549.20085-1-avarab@gmail.com> <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
 <20170615231549.20085-5-avarab@gmail.com> <xmqq7f0byayu.fsf@gitster.mtv.corp.google.com>
 <2122b01f-7627-cd1b-c7df-751c076f90ff@web.de> <87injfkd0j.fsf@gmail.com>
 <433f9fb7-a202-1091-46de-04535b2a49e1@web.de> <b1b97b26-f715-1d0f-410e-51356b05b890@web.de>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 29 Jun 2017 00:35:16 +0200
Message-ID: <CACBZZX6XoAKEbxgStcZCo30ahZ5NiG4oKp7TJUYJFYTXb=EXGw@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] coccinelle: add a rule to make "expression" code
 use FREE_AND_NULL()
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 29, 2017 at 12:30 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 29.06.2017 um 00:21 schrieb Ren=C3=A9 Scharfe:
>>
>> Am 28.06.2017 um 23:39 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>
>>>
>>> On Sun, Jun 25 2017, Ren=C3=A9 Scharfe jotted:
>>>
>>>> Am 16.06.2017 um 21:43 schrieb Junio C Hamano:
>>>>>
>>>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>>>>
>>>>>> A follow-up to the existing "type" rule added in an earlier
>>>>>> change. This catches some occurrences that are missed by the previou=
s
>>>>>> rule.
>>>>>>
>>>>>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.=
com>
>>>>>> ---
>>>>>
>>>>>
>>>>> Hmph, I wonder if the "type" thing is really needed.  Over there,
>>>>> "ptr" is an expression and we can find "free(ptr); ptr =3D NULL" with
>>>>> the rule in this patch already, no?
>>>>
>>>>
>>>> Indeed.  How about this on top of master?
>>>>
>>>> -- >8 --
>>>> Subject: [PATCH] coccinelle: polish FREE_AND_NULL rules
>>>>
>>>> There are two rules for using FREE_AND_NULL in free.cocci, one for
>>>> pointer types and one for expressions.  Both cause coccinelle to remov=
e
>>>> empty lines and even newline characters between replacements for some
>>>> reason; consecutive "free(x);/x=3DNULL;" sequences end up as multiple
>>>> FREE_AND_NULL calls on the same time.
>>>>
>>>> Remove the type rule, as the expression rule already covers it, and
>>>> rearrange the lines of the latter to place the addition of FREE_AND_NU=
LL
>>>> between the removals, which causes coccinelle to leave surrounding
>>>> whitespace untouched.
>>>>
>>>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>>>> ---
>>>>    contrib/coccinelle/free.cocci | 10 +---------
>>>>    1 file changed, 1 insertion(+), 9 deletions(-)
>>>>
>>>> diff --git a/contrib/coccinelle/free.cocci
>>>> b/contrib/coccinelle/free.cocci
>>>> index f2d97e755b..4490069df9 100644
>>>> --- a/contrib/coccinelle/free.cocci
>>>> +++ b/contrib/coccinelle/free.cocci
>>>> @@ -11,16 +11,8 @@ expression E;
>>>>      free(E);
>>>>
>>>>    @@
>>>> -type T;
>>>> -T *ptr;
>>>> -@@
>>>> -- free(ptr);
>>>> -- ptr =3D NULL;
>>>> -+ FREE_AND_NULL(ptr);
>>>> -
>>>> -@@
>>>>    expression E;
>>>>    @@
>>>>    - free(E);
>>>> -- E =3D NULL;
>>>>    + FREE_AND_NULL(E);
>>>> +- E =3D NULL;
>>>
>>>
>>> Late reply, sorry. What version of coccinelle are you running? I have
>>> 1.0.4 (from Debian) and can't get this to produce the same results as
>>> what I have.
>>>
>>> On top of next, I did:
>>>
>>>           Revert "*.[ch] refactoring: make use of the FREE_AND_NULL()
>>> macro"
>>>           Revert "coccinelle: make use of the "expression"
>>> FREE_AND_NULL() rule"
>>>           Revert "coccinelle: make use of the "type" FREE_AND_NULL()
>>> rule"
>>>
>>> And then generated the patch as usual with `make coccicheck`, and
>>> applied it. This has your change.
>>>
>>> I then re-applied the manual "*.[ch] refactoring" changes
>>>
>>> This results in this diff with next:
>>>
>>>       $ git diff --stat origin/next.. -- '*.[ch]'
>>>        builtin/am.c             |  3 ++-
>>>        builtin/clean.c          |  6 ++++--
>>>        builtin/config.c         |  6 ++++--
>>>        builtin/index-pack.c     |  6 ++++--
>>>        builtin/pack-objects.c   | 12 ++++++++----
>>>        builtin/unpack-objects.c |  3 ++-
>>>        fast-import.c            |  6 ++++--
>>>        http-push.c              | 24 ++++++++++++++++--------
>>>        http.c                   | 15 ++++++++++-----
>>>        imap-send.c              |  3 ++-
>>>        ref-filter.c             |  3 ++-
>>>        refs/files-backend.c     |  3 ++-
>>>        remote-testsvn.c         |  3 ++-
>>>        sequencer.c              |  3 ++-
>>>        sha1-array.c             |  3 ++-
>>>        sha1_file.c              |  3 ++-
>>>        transport-helper.c       | 27 ++++++++++++++++++---------
>>>        transport.c              |  3 ++-
>>>        tree-diff.c              |  6 ++++--
>>>        tree.c                   |  3 ++-
>>>        20 files changed, 94 insertions(+), 47 deletions(-)
>>>
>>> These are all cases where we now miss things that should use
>>> FREE_AND_NULL(), e.g.:
>>>
>>>       diff --git a/builtin/am.c b/builtin/am.c
>>>       index c973bd96dc..2f89338ed7 100644
>>>       --- a/builtin/am.c
>>>       +++ b/builtin/am.c
>>>       @@ -484,7 +484,8 @@ static int run_applypatch_msg_hook(struct
>>> am_state *state)
>>>               ret =3D run_hook_le(NULL, "applypatch-msg", am_path(state=
,
>>> "final-commit"), NULL);
>>>
>>>               if (!ret) {
>>>       -               FREE_AND_NULL(state->msg);
>>>       +               free(state->msg);
>>>       +               state->msg =3D NULL;
>>>                       if (read_commit_msg(state) < 0)
>>>                               die(_("'%s' was deleted by the
>>> applypatch-msg hook"),
>>>                                       am_path(state, "final-commit"));
>>>
>>> So it looks to me like removing the "type T" rule breaks a lot of
>>> things, but that the change you made to the expression rule is good, an=
d
>>> we should do that for the "type" rule as well. Your commit says the
>>> "expression rule already covers it", but this doesn't seem to be the
>>> case at all.
>>>
>>> As an aside: Junio, did you mean to apply f8bb4631fb to next this way?
>>> Looks like a mis-applied scissor commit.
>>
>>
>> I can't reproduce that strange result with master, but get a scissors
>> line into the commit message as well.  The diff at the end looks
>> reasonable (contains just the manual stuff).  Here's what I did:
>
>
> On top of next it looks basically the same for me, only difference
> being several new converted cases in repository.c.
>
> Did you commit before diff?

At this point I have no idea what I did wrong, and no time/want to
really find out. But whatever it was was the wrong thing, obviously :)
