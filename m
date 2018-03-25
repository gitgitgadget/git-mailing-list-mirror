Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C1BF1F42D
	for <e@80x24.org>; Sun, 25 Mar 2018 09:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeCYJ1o (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 05:27:44 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52934 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeCYJ1n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 05:27:43 -0400
Received: by mail-it0-f68.google.com with SMTP id k135-v6so7266014ite.2
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 02:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ABKW2wjcvGk8fOxIw/qyKsNZ5VegWd5uFZK3ts3AiyI=;
        b=nJcFqM/Ua48oQdKjjUBciwjukUvZh8T7QKeT5ULoTyBLOgT1PhPlXHxAYur1kz2eGE
         AnaqpNxdlD3R7yqQ9DkKetLNpSji6ym9zOeXKzoURSNcecV0CX6eapocrzLghaQqEWga
         M/r9Pvq1zrqEosLx0zpImCmSz5yTmmNhR5W6S6d1V0OVT5ooqWzPqOy0I3PS6mMqB5Xg
         Pk4yjSbNkV9lOt/6xO6ygRrXm/SeOuFVn3WRpuhNc+XR+0qA9iBg2unYojcdUQ862os0
         vdSIglyWgQRBwGw64q+2SdRUg7oXZJ+xUQmogo6QyKpoyoqFYsNb6o5IcbQyD00Vhxv2
         f5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ABKW2wjcvGk8fOxIw/qyKsNZ5VegWd5uFZK3ts3AiyI=;
        b=glMoTqA0XwRYydOYQMMCQ5kR+jmRmlY2vGRbjferwoEYHQh+UDkyqniKnmaFtVP8al
         DAT/07lVcLDnb61tHlP/GsvZpecu2g5tM6F3bUiDoQrj4r8RaUJ3XTIeLfur5POT8p6U
         Aq0RtH0uX/AiAjlJWaUeBomQJGav9OwJQgKfRJID+yTXgzZhzrbm3CoZGV/8tsWtIBkR
         fU8ALBruMfeE2t5dRPi8NyA0XBRspiQQ0z16XvKyW1ax7uwxBBdYW/RQgBMR02+9h1/i
         irvZIIgoUQGE8i3Yv0aOvG8z2y13+0rVeAsoC0/1zoqAQdeUO3sXFMm0NQZxVJgaIJ/m
         8lbA==
X-Gm-Message-State: AElRT7GQFJLLehGfHHEhR6iT1pQwAxPGetXrQ4uXGfz4ZDcGD4Icxtqg
        hdEIErn5y1gFSNNp67iF7btNIy/PMT6lvc0RKMk=
X-Google-Smtp-Source: AG47ELsTXRyZSNtZd4jEM5nmf2y11K9XqnSyZ0D5rDDDDXgqluxQ3CKIW8ExSXPc3Up+emtgRJqeYGQnUcRvhIWy9NU=
X-Received: by 2002:a24:80c7:: with SMTP id g190-v6mr15480586itd.129.1521970062662;
 Sun, 25 Mar 2018 02:27:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Sun, 25 Mar 2018 02:27:41 -0700 (PDT)
In-Reply-To: <CAPig+cSkQLSvOroB0bLLLBAXy9UBDN+s=i97COtNDpO0FbLJkg@mail.gmail.com>
References: <20180324173707.17699-1-joel@teichroeb.net> <20180324173707.17699-2-joel@teichroeb.net>
 <CAPig+cSkQLSvOroB0bLLLBAXy9UBDN+s=i97COtNDpO0FbLJkg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 25 Mar 2018 11:27:41 +0200
Message-ID: <CAP8UFD1f=VM7VLWGPOzn5PSwHr_m2PohP0gOCM6wk7FdoZ3-Yg@mail.gmail.com>
Subject: Re: [PATCH 1/4] stash: convert apply to builtin
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Joel Teichroeb <joel@teichroeb.net>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 8:40 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Mar 24, 2018 at 1:37 PM, Joel Teichroeb <joel@teichroeb.net> wrote:

>> +static int do_apply_stash(const char *prefix, struct stash_info *info, int index)
>> +{
>> +       if (index) {
>> +               if (!oidcmp(&info->b_tree, &info->i_tree) || !oidcmp(&c_tree, &info->i_tree)) {
>> +                       has_index = 0;
>> +               } else {
>> +                       struct child_process cp = CHILD_PROCESS_INIT;
>> +                       struct strbuf out = STRBUF_INIT;
>> +                       struct argv_array args = ARGV_ARRAY_INIT;
>> +                       cp.git_cmd = 1;
>> +                       argv_array_pushl(&cp.args, "diff-tree", "--binary", NULL);
>> +                       argv_array_pushf(&cp.args, "%s^2^..%s^2", sha1_to_hex(info->w_commit.hash), sha1_to_hex(info->w_commit.hash));
>> +                       if (pipe_command(&cp, NULL, 0, &out, 0, NULL, 0))
>> +                               return -1;
>
> Leaking 'out'?
>
>> +
>> +                       child_process_init(&cp);
>> +                       cp.git_cmd = 1;
>> +                       argv_array_pushl(&cp.args, "apply", "--cached", NULL);
>> +                       if (pipe_command(&cp, out.buf, out.len, NULL, 0, NULL, 0))
>> +                               return -1;
>
> Leaking 'out'.

It might be a good idea to have small functions encapsulating the
forks of git commands. For example:

static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
{
    struct child_process cp = CHILD_PROCESS_INIT;
    const char *w_commit_hex = oid_to_hex(w_commit);

    cp.git_cmd = 1;
    argv_array_pushl(&cp.args, "diff-tree", "--binary", NULL);
    argv_array_pushf(&cp.args, "%s^2^..%s^2", w_commit_hex, w_commit_hex);

    return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
}

static int apply_cached(struct strbuf *out)
{
    struct child_process cp = CHILD_PROCESS_INIT;

    cp.git_cmd = 1;
    argv_array_pushl(&cp.args, "apply", "--cached", NULL);
    return pipe_command(&cp, out->buf, out->len, NULL, 0, NULL, 0);
}

This could help find leaks and maybe later make it easier to call
libified code instead of forking a git command.
