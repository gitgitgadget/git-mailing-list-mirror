Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92733201B0
	for <e@80x24.org>; Fri, 24 Feb 2017 09:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbdBXJq6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 04:46:58 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:35370 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbdBXJqy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 04:46:54 -0500
Received: by mail-ot0-f196.google.com with SMTP id y13so1632316oty.2
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 01:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lSo+/tyojJlp08kvTzosgi2lddPOmN6A703IQPZCPAc=;
        b=r+qKnjKQCK3YADPGLIIVezm9OOWXRU3wUDRxMvRcaGLSpe1C40S+YP2X7oHdckCZ1T
         sS+bt1UsAEinSFKekzOgyvJ27sLgf5+mJUCE9A5SwsLWJGd+Xn7mRNfNYOBY9uxobEhG
         3BLmXAl154zCxqJhYnVP5ltxos6NUL9Oj+sovraCg356VHoUAWhib7aJXrk5xVilOeHn
         YJWIG+8gDkKt8L3sQEwfN6HHze47KWWhoSqiy4Lpaq2t4cborUg+esULapHzXzjxkAci
         gztF9Mg+10vaPhpKUbWEVumgjSCmgxtxoMy/ktKQH1DaGTisWAGi62o0iJqfiP7xhQgN
         W03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lSo+/tyojJlp08kvTzosgi2lddPOmN6A703IQPZCPAc=;
        b=WpClIfubjxECTXOdkztaloZtrZAMbIpGaiwQvFLPqvPWPC10yF8WTrZPxWVjVRdu2c
         Fz1kXEAJhk0OiSIg252Qhp8sXpdsRnkeG8/veddhpMbm1Zw3XJXaRY/4jX5GvgQ/CV31
         umONd8q5/PFi2Dad29/pm5GcGzxLH0YmAjaUwssMsQxshSRzxO8kJq2ArUA2faVC0GT/
         wbpca/A6xEiV5EspC9OAlZ/+U+wurHd8MUjjKQlAM33OBDc9pRU06gPHXM+T4EFtqau5
         P8Yi+Xd/v2huIXfQHkq3nCEJNpxx/zaT/C5/U/RjY0EXmGvnz48UwHSy4QFwV9zoNDU5
         6kYA==
X-Gm-Message-State: AMke39m59HbAgxg9JiBsq6L3MIebzjraPhzzJZlpVr3duTiR4iiV+X7WRUaV2HfjY1DJbrSW/seH1ZGN8XFnAQ==
X-Received: by 10.157.9.242 with SMTP id 47mr968842otz.128.1487929098871; Fri,
 24 Feb 2017 01:38:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Fri, 24 Feb 2017 01:37:48 -0800 (PST)
In-Reply-To: <xmqqwpcg7k6r.fsf@gitster.mtv.corp.google.com>
References: <20170223122346.12222-1-pclouds@gmail.com> <20170223122346.12222-2-pclouds@gmail.com>
 <xmqqwpcg7k6r.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 24 Feb 2017 16:37:48 +0700
Message-ID: <CACsJy8CerU-=PF6wqzUAM02jkrVVGJ5MA0NgL6z9bHn5KM6jiw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] config: add conditional include
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 2:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The variable is obviously not treated the same way as include.path ;-)
>
>     When includeIf.<condition>.path variable is set in a
>     configuration file, the configuration file named by that
>     variable is included (in a way similar to how include.path
>     works) only if the <condition> holds true.

Yeah. I was thinking "value" and writing "variable" instead (or
perhaps I meant to write "variable value" and accidentally'd the last
word again).

>> +     /* TODO: maybe support ~user/ too */
>> +     if (pat->buf[0] == '~' && is_dir_sep(pat->buf[1])) {
>> +             const char *home = getenv("HOME");
>> +
>> +             if (!home)
>> +                     return error(_("$HOME is not defined"));
>
> Instead of half-duplicating it here yourself, can't we let
> expand_user_path() do its thing?

This comment came up in previous iterations. I perform explicit
expansion to make sure we don't apply wildcards on the expanded "~".
But I guess going with expand_user_path() is better (less confusion
for future readers). We can come back to it when that "don't apply
wildcards" concern becomes real.

>> +static int include_condition_is_true(const char *cond, size_t cond_len)
>> +{
>> +     /* no condition (i.e., "include.path") is always true */
>> +     if (!cond)
>> +             return 1;
>> +
>> +     if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
>> +             return include_by_gitdir(cond, cond_len, 0);
>> +     else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
>> +             return include_by_gitdir(cond, cond_len, 1);
>
> This may be OK for now, but it should be trivial to start from a
> table with two entries, i.e.
>
>         struct include_cond {
>                 const char *keyword;
>                 int (*fn)(const char *, size_t);
>         };
>
> and will show a better way to do things to those who follow your
> footsteps.

Yeah I don't see a third include coming soon and did not go with that.
Let's way for it and refactor then.
-- 
Duy
