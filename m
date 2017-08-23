Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AD3520899
	for <e@80x24.org>; Wed, 23 Aug 2017 21:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932668AbdHWVU0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 17:20:26 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:32783 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932671AbdHWVUY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 17:20:24 -0400
Received: by mail-yw0-f180.google.com with SMTP id h127so8253838ywf.0
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 14:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q5a8VhAzMTL4Orp6LrtNMGKG/eCk2kqMgO7KMuHr+5w=;
        b=uNrjwSMUpK4LshqeHzHYh5+ISJoLenbA84a7AdCT9yYV4QEzZaNr0aYA9X18uFZuYu
         0hTpC82mirXYbD89H/AdrQUD/zSFxcUvdvwLuB7VWmV5pnWOg2+OucIt3WwmiI1JGjDt
         0/DnLG3ZjwpE8TIAB1bpyFJ2MYk2zczlehSh9fBxFEpLFdROudEIg9hehzQQWqbIXDZ3
         4AMpr61bJh/V70txsOLt/GMZbKOH3BJC+Eu0mJn7fe3zby2W6NNOUP29p8UbV4WQZ9Nv
         u2i4Aa8tA+uJ1lshY+nsfPoDam4ortpBIZOSJkAkuFIeXQxRRsYkuiFyNifzq1SmQnNS
         Nqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q5a8VhAzMTL4Orp6LrtNMGKG/eCk2kqMgO7KMuHr+5w=;
        b=tNOtt7MNKTVPvNQZHdYFbEUueGCBy9cicqpatwegkPhasska3qNDlMoEH1j421dwUd
         L2mHd1xoffFD64hP/Wm1j/0t1FX5kHMIj3Kc0NWvF2DCLK5JxgWmQvlHULaYIEmvTlYU
         7CaIkrQDf9VWsDhqFf1ac9RCn0OP6GGnBzXQetVZ7RjmfgRpOWUJ5e00uWGHFZggkscn
         2vJBzfCsLOHauLI/pmLLXAxxGQf0tv0t5kkbz+Wcid+8ieIYTLj9ZEE9w2UaKhw99izk
         /3/pQT1pXMy0MRcvTfFZUmoSzOB6jpCdMGK2URaL2JLl+7xSbHsAI8pePU2YT5LeimAe
         AMbQ==
X-Gm-Message-State: AHYfb5iWNJhzcFqSsAYGXqAto8DmsouUETsL0352kiL2XGjIMD3wrWj5
        sJVJHNHAIimYFnKPg5cxkVQbYg+eVk63u0M=
X-Received: by 10.129.42.84 with SMTP id q81mr3254395ywq.370.1503523223701;
 Wed, 23 Aug 2017 14:20:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.153.133 with HTTP; Wed, 23 Aug 2017 14:20:23 -0700 (PDT)
In-Reply-To: <xmqqh8wyxag1.fsf@gitster.mtv.corp.google.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <cover.1503323390.git.martin.agren@gmail.com>
 <dccd3e75fcd1b2de93263e8373a3b4cd5da0dd32.1503323391.git.martin.agren@gmail.com>
 <CA+sFfMdXv+nqpXmwfLTHtkRLuGkAEAwWXZCvOryVZ=aLb_UmbA@mail.gmail.com> <xmqqh8wyxag1.fsf@gitster.mtv.corp.google.com>
From:   Brandon Casey <drafnel@gmail.com>
Date:   Wed, 23 Aug 2017 14:20:23 -0700
Message-ID: <CA+sFfMe56itAMDXOJybf0yHj+BqU1Ai1aU7inoTG3FJtdtZxyw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] strbuf_setlen: don't write to strbuf_slopbuf
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 2:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> So is there any reason why didn't do something like the following in
>> the first place?
>
> My guess is that we didn't bother; if we cared, we would have used a
> single instance of const char in a read-only segment, instead of
> such a macro.

I think you mean something like this:

   const char * const strbuf_slopbuf = "";

..with or without "const" at the beginning.  We can't use an actual
variable like that since we also want to be able to do initialization
like:

   struct strbuf b = STRBUF_INIT;

i.e.

   struct strbuf b = { 0, 0, strbuf_slopbuf };

So the compiler needs to be able to determine that everything within
the curly braces is constant and apparently gcc cannot.


On a related note... I was just looking at object.c which also uses a
slopbuf.  We could similarly protect it from inadvertent modification
by doing something like this:

diff --git a/object.c b/object.c
index 321d7e9..4c7a041 100644
--- a/object.c
+++ b/object.c
@@ -303,7 +303,7 @@ int object_list_contains(struct object_list *list, struct ob
ject *obj)
  * A zero-length string to which object_array_entry::name can be
  * initialized without requiring a malloc/free.
  */
-static char object_array_slopbuf[1];
+static const char * const object_array_slopbuf = "";

 void add_object_array_with_path(struct object *obj, const char *name,
                                struct object_array *array,
@@ -326,7 +326,7 @@ void add_object_array_with_path(struct object
*obj, const char *name,
                entry->name = NULL;
        else if (!*name)
                /* Use our own empty string instead of allocating one: */
-               entry->name = object_array_slopbuf;
+               entry->name = (char*) object_array_slopbuf;
        else
                entry->name = xstrdup(name);
        entry->mode = mode;
