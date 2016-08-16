Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F0311F859
	for <e@80x24.org>; Tue, 16 Aug 2016 17:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbcHPR2X (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 13:28:23 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:34955 "EHLO
	mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbcHPR2W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 13:28:22 -0400
Received: by mail-it0-f53.google.com with SMTP id x131so21494902ite.0
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 10:28:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JyPbrDC8i3GARvhFta4eW0oOz1oh4oUg3cjYY+rvWCA=;
        b=fUt1MbMIRH/UqZYEYPcmqoweYnf5/BNSjvoFNSRXbodHzm5SpeAgpRbGqSAtOLO5d+
         wWKaYrosMoB7tgSpTgxlHcn1QR9QASALdDdo1+c2Ptuu+L8euRZKJ1u2uK6YLm8mWQ9p
         hepSwsmqKj6rlzFwQktW1v8oGj7yK+NsNcDcA1PmjIJj6GDe8atIuZjoYsEI6E/MrHGT
         dWPatz8Im3ioInMb4wgdLsXIKfq9uhD4NyGAY2gX7/dJGlQqp7BRJVxzapCY4JXPIxaF
         yO9GCcfg6kNYp0a+RqTR875M8Yn6Q/mznpWdgjwDESHD8LuB1V0AIExzK1fdL27Jhc7y
         EvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JyPbrDC8i3GARvhFta4eW0oOz1oh4oUg3cjYY+rvWCA=;
        b=lcJrbTs4wG1zEKqEKraL+PQygid3raY0khdrg9mb6B9LuGx2N3MoPd/mxuRuqEiK+j
         MdeH/s1mfvDCzmOQgEPPrT07t+RcAzJFOGCXL5rLr1JaC/iyfF1bPtmLohNantNAfRsJ
         aE11q7b1iD6Vd1ThW+uQb30stK1j0nvYBrHVQM5smag/Ijn3y64fPY5wWUXTPC8pVz/t
         2jK96SFFUKpjGURpRl7coERGiKw6mhLBvplOaJ4aNi/svSq67YOuIvCt/W0VRMxuJHaN
         hH2idDnv20ygTtIUVe3/kjJeJmlE75e8/oDiaavuQSpZFWM0ee7fco+NuFTD0Nur4CJc
         w3Tw==
X-Gm-Message-State: AEkoousqBwPixy5c3Ts6hJ3DqctTO4WfdjntbVBxc+Jx2opFguaMUUSri5aTVjDZESCfOwrNGWc9bCVDv5Tg9Kcz
X-Received: by 10.36.92.206 with SMTP id q197mr23504732itb.46.1471368178264;
 Tue, 16 Aug 2016 10:22:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 16 Aug 2016 10:22:57 -0700 (PDT)
In-Reply-To: <xmqqa8gcej1p.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <xmqqa8gcej1p.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 16 Aug 2016 10:22:57 -0700
Message-ID: <CAGZ79kby02NuRvQkcuTNjxxc4oDvjAH4wE=3dCXmqyRRrCU0tQ@mail.gmail.com>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
To:	Junio C Hamano <gitster@pobox.com>
Cc:	meta@public-inbox.org, "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <e@80x24.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 10:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> So as a discussion starter:
>> * Should git am skip a patch 00/XX automatically ?
>
> No.  My preference is to add "--initial-skip=<N>", though.
>
> When I receive a patch series to reroll another series, I somehow
> know and verify that earlier N patches have not changed, I detach
> the HEAD at the last unchanged commit from the previous round and
> apply the remainder of the new series, so that I can preserve the
> author timestamps of earlier steps from the previous series.  By
> the time I "know and verify" where the first step that was updated,
> I have a full series in a single mbox; having "--initial-skip=<N>"
> would help with that use case, too, and "skipping the first" is a
> narrow special case of giving N=1.

In your work flow, how do you respect the cover letter?
e.g. in 3787e3c16ced:

    Merge branch 'ew/http-backend-batch-headers'

    The http-backend (the server-side component of smart-http
    transport) used to trickle the HTTP header one at a time.  Now
    these write(2)s are batched.

    * ew/http-backend-batch-headers:
      http-backend: buffer headers before sending

Is the text from the original author (and if so from which version
of the cover letter) or is it your work?

>
>> * Should the public-inbox offer another link to patches 1-n, without
>>   the cover letter? Or should it add instructions:
>>
>>         If this is a patch series you can apply it locally as:
>>         curl <link> >tmpXXX
>>         git am tmpXXX && git am --skip && git am --continue
>
> I do not think it is sensible for "cover-letter" specific
> instructions.  However, I do not think it is unreasonable to either
> add another mbox.gz link or replace the behaviour of mbox.gz link so
> that you can grab a mbox that contains "this message and everything
> after it in the thread".  That way, I could open the first message,
> see something like this I found in your message:
>
>>> Thread overview: 4+ messages in thread (expand / mbox.gz / Atom feed / [top])
>>> 2016-08-15 23:06 Jacob Keller [this message]
>>> 2016-08-15 23:07 ` [PATCH v6 1/3] diff.c: remove output_prefix_length field Jacob Keller
>>> 2016-08-15 23:07 ` [PATCH v6 2/3] graph: add support for --line-prefix on all graph-aware output Jacob Keller
>>> 2016-08-15 23:07 ` [PATCH v6 3/3] diff: add SUBMODULE_DIFF format to display submodule diff Jacob Keller
>
> and then go to 1/3 and click that "this and everything that
> follows".

Both thoughts are sensible; However the --initial-skip=<n>
doesn't address the special case of storing the cover letter
(which we eventually want to do?)

I thought of it as the following with room for improvement:

diff --git a/builtin/am.c b/builtin/am.c (shite space broken):
index 739b34d..5f08b61 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1246,6 +1246,7 @@ static int parse_mail(struct am_state *state,
const char *mail)
        FILE *fp;
        struct strbuf sb = STRBUF_INIT;
        struct strbuf msg = STRBUF_INIT;
+       struct strbuf subject = STRBUF_INIT;
        struct strbuf author_name = STRBUF_INIT;
        struct strbuf author_date = STRBUF_INIT;
        struct strbuf author_email = STRBUF_INIT;
@@ -1309,6 +1310,7 @@ static int parse_mail(struct am_state *state,
const char *mail)
                        if (msg.len)
                                strbuf_addch(&msg, '\n');
                        strbuf_addstr(&msg, x);
+                       strbuf_addstr(&subject, x);
                } else if (skip_prefix(sb.buf, "Author: ", &x))
                        strbuf_addstr(&author_name, x);
                else if (skip_prefix(sb.buf, "Email: ", &x))
@@ -1325,8 +1327,17 @@ static int parse_mail(struct am_state *state,
const char *mail)
        }

        if (is_empty_file(am_path(state, "patch"))) {
-               printf_ln(_("Patch is empty. Was it split wrong?"));
-               die_user_resolve(state);
+               if (indicates_coverletter(&subject))
+                       /*
+                        * TODO: store the cover letter as the first or last
+                        * commit or as branch.<name>.description
+                        */
+                       ret = 1;
+                       goto finish;
+               else {
+                       printf_ln(_("Patch is empty. Was it split wrong?"));
+                       die_user_resolve(state);
+               }
        }

        strbuf_addstr(&msg, "\n\n");
