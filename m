Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8993200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 09:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755493AbcLZJyc (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 04:54:32 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35664 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754829AbcLZJyb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 04:54:31 -0500
Received: by mail-lf0-f68.google.com with SMTP id x140so10684067lfa.2
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 01:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9bQ0GA2P1dHrG5coc80mJeHi7SYG4YcuHiandP7eEYI=;
        b=hlqviAAlz7LJ2DTmszhoDCEFELpqQnUZS/piDszXMMDEAelBHH9Q1kKP1sTepZv1aB
         bOr6Xb8GIkQYZDDiqcbueEviq3ravRR8nEQoKQLHjSgx7PW1p+xuBzkZSTSsGfzUdSrN
         TyqT+VpouloHh6qlIQ/Z65sWRiKu8qBf0IU5AQ/o+Tc+Auc0t40umpXMgG+liHrSY8XC
         XkbBtOIY5nUnCNeMF+UQGoylyjdzLZMFwZvt0ifk9ouBQ/rxsQ5bs4sXALFAVZtXcbe1
         m7rIAsNxOqEF2p0BsN2GeTP3sg66EDc9xmk4O6ZR/IvcNfg4z2yLcC2o9s2w0yCDqw0u
         Fytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9bQ0GA2P1dHrG5coc80mJeHi7SYG4YcuHiandP7eEYI=;
        b=QWmbHJ4BxE5nlZD3TATBqmeRLmbtOo9HC6PKMeML60K/6D/fxJOgAiW8fUwXScoFaY
         XZWEjJaU1zvIveFqUYcg6enTz7+VHHeEpC9cCuUYtwlmPvCUl/ysEQteEZ8DQ4Mml7N8
         J9MEyW+uVKRnNr6IMDCeLAvi2zAiITWAyLi3+pE9D4/3YTJDKlt0IC/GTUMVs7elS++3
         zk4nSVLrTL/FT0CUqV/ODxIKVHE8t8KxN5s8GSBW0GY5jrzWbE09l8yGBlFAq8h76Q+j
         POe73D6YL0m9jcww8RmkLsBYj+NlC9fJsRpAGImGNu/ijrJi22h3xL8GCzi+kbjrfCHL
         mBIg==
X-Gm-Message-State: AIkVDXLAzxU5VdV+W8wxEB8EBAHM+Tm8MUbOiVl7Z9NFTNiC5edKbXk3Cr0k3zpOGgqLnqGq8bBL2awftkjeUA==
X-Received: by 10.25.170.198 with SMTP id t189mr7552245lfe.129.1482746069838;
 Mon, 26 Dec 2016 01:54:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.152.13 with HTTP; Mon, 26 Dec 2016 01:54:29 -0800 (PST)
In-Reply-To: <20161219115812.GD24125@ash>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
 <20161217145547.11748-17-chriscool@tuxfamily.org> <20161219115812.GD24125@ash>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Dec 2016 10:54:29 +0100
Message-ID: <CAP8UFD2hE5nLXKpSEPaS_1XYqQw+Wn=nMT4paV+FtGFrHzHsFw@mail.gmail.com>
Subject: Re: [PATCH v2 16/21] read-cache: unlink old sharedindex files
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 12:58 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Dec 17, 2016 at 03:55:42PM +0100, Christian Couder wrote:
>> +static int clean_shared_index_files(const char *current_hex)
>> +{
>> +     struct dirent *de;
>> +     DIR *dir = opendir(get_git_dir());
>> +
>> +     if (!dir)
>> +             return error_errno(_("unable to open git dir: %s"), get_git_dir());
>> +
>> +     while ((de = readdir(dir)) != NULL) {
>> +             const char *sha1_hex;
>> +             if (!skip_prefix(de->d_name, "sharedindex.", &sha1_hex))
>> +                     continue;
>> +             if (!strcmp(sha1_hex, current_hex))
>
> fspathcmp since we're dealing fs paths?
>
> In theory we should be ok using strcmp, even on Windows because case
> is preserved, I think. It's only a problem when we write path 'abc'
> down and read 'ABC' back.
>
> Oh well.. your call because if you go with fspathcmp, skip_prefix can't
> be used either. A lot more changes for a very rare case.

I'd rather keep using skip_prefix() and strcmp().

I could find no place in the code where fspathcmp() is used to compare
dir entries, but a few where other *cmp() functions are used:

$ git grep '>d_name' | grep cmp
builtin/repack.c:               if (strncmp(e->d_name, buf.buf +
dirlen, prefixlen))
dir.c:  if (is_dot_or_dotdot(de->d_name) || !strcmp(de->d_name, ".git"))
sha1_name.c:                    if (memcmp(de->d_name, ds->hex_pfx +
2, ds->len - 2))

and also a few where skip_prefix() is used:

$ git grep -n '>d_name' | grep prefix
builtin/repack.c:60:            if (strncmp(e->d_name, buf.buf +
dirlen, prefixlen))
help.c:147:             if (!skip_prefix(de->d_name, prefix, &ent))

so I think it is ok to use skip_prefix() and strcmp().

>> +                     continue;
>> +             if (can_delete_shared_index(sha1_hex) > 0 &&
>
> Probably shorter to pass full d->name here so you don't have to do
> another git_path() in can_delete_

Yeah, you are right, I will do that.
