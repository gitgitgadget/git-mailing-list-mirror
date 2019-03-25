Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BA7720248
	for <e@80x24.org>; Mon, 25 Mar 2019 06:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbfCYGku (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 02:40:50 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54529 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbfCYGku (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 02:40:50 -0400
Received: by mail-it1-f195.google.com with SMTP id w18so12297353itj.4
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 23:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=V9kZeYspdkS31n728MXPdl0ZZi5cm48mND38/KQZsTU=;
        b=X52hLCqCHmQECFUBhfMjbllHyj+8doM8/QwNZALCUtHpEA6Gh1H7xvxqYfuRnAPJdn
         yIXKi0ozYES6uZW/Gtx8GaoElJDuk/9ItywX7mSJ4MLfYrkqXPZFOkkUa8Pf3Q4JEt5V
         kCrat8V26WKx37X79cacoNkIR3wx7qSY177ajvGXrfZe+IobMXxLtV+B0+P8L4GX2iQl
         Suj6DDsbcuTqvKEfdWQ0SGpFOS1UvZ1qCZU9Xls7JerDUxXHOekqZwvsFr9gm/xGhfrN
         GlYZvDiUm+p/PBjzjiIN/WoFJL9VjCmbzWNiVyOCkP2qzoFJ1mc6yXD+EzboGN5pUfdf
         ZYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=V9kZeYspdkS31n728MXPdl0ZZi5cm48mND38/KQZsTU=;
        b=DMkb4aJURaoT6sQj7rS+LlwDIxiJ3ruPmQoYPsf3xVKkBJ8zKW1oSrFbKKIZw+zEoF
         l0/5oF9aSkAF1xaN9lPSbz7kwqWVei2gSEaO+taZfSl7q1iF6e5sItAFIrc8zjcWebKj
         eOKBF7VZeQKlpbgkuj41oEXAjz7mz7hN6ZsX88uoebCtzi5OvOq2coMmCZCHkbL6vBZy
         etxGQph40KXYkVlCNsM7H3BpTXtAnSJpyZBHRNS+LdcjDg5GIFc+KY5QszU6JIIPQJue
         w/8VM4qmt2xGpBJBXWIudCvUgCRYOWzpVIzasy5tnYN2jSg6MBM33XxIS1j5CBRna5Ik
         whSg==
X-Gm-Message-State: APjAAAUJ6zwrT9d3xLkij+h8FJ3yqCk0w3RdsVARVuBQlD5ZDM3xRmyf
        ow0YMIh2raJtRgvluUxoonexc0jY04KI6x9IG+z8Ab+h
X-Google-Smtp-Source: APXvYqwf3bEvIRVd+IcXGDA52amWWGn7Bj8+Mew89/loZSc2xnuIZmP5BDQIHSnqWqdmXSaIrKkIP2ayhwzou113n/k=
X-Received: by 2002:a02:6d12:: with SMTP id m18mr17076815jac.54.1553496049899;
 Sun, 24 Mar 2019 23:40:49 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 25 Mar 2019 02:40:24 -0400
Message-ID: <CAH8yC8mDWpf0b3zykyvHRLLbYdmLB7hAk9LcsciB=dYhs4C=VA@mail.gmail.com>
Subject: How to disable docs when building Git from sources
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I'm working on a low-resource dev-board. It is missing a lot of
utilities to save space. I'm building Git 2.20 from sources. Make is
failing due to '/bin/sh: 1: msgfmt: not found'. I don't cross-compile
because that's a bigger pain in the ass than waiting for the native
build to finish.

I ran './configure --help' but I don't see a way to disable the docs.
In the past I tired --disable-docs but it had no effect.

How do I disable the docs?

=========================

gcc -o builtin/write-tree.o -c -MF builtin/.depend/write-tree.o.d -MQ builtin/wr
ite-tree.o -MMD -MP -I/usr/local/include -DNDEBUG -g2 -O2 -march=native -fPIC -I
. -DHAVE_SYSINFO -DGIT_HOST_CPU="\"armv7l\"" -DUSE_LIBPCRE2 -I/usr/local/include
 -DHAVE_ALLOCA_H -I/usr/local/include -DUSE_CURL_FOR_IMAP_SEND -I/usr/local/incl
ude -I/usr/local/include -I/usr/local/include -DSHA1_DC -DSHA1DC_NO_STANDARD_INC
LUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.
h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\"" -DSHA256_BLK  -
DHAVE_PATHS_H -DHAVE_LIBCHARSET_H -DHAVE_STRINGS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_G
ETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM '-DPROCFS_EXECUTABLE_PATH="/proc/s
elf/exe"'  -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -DSHELL_PATH='"/bin/sh"' -DPAG
ER_ENV='"LESS=FRX LV=-c"'  builtin/write-tree.c
mkdir -p po/build/locale/pt_PT/LC_MESSAGES/ && msgfmt --check --statistics -o po
/build/locale/pt_PT/LC_MESSAGES/git.mo po/pt_PT.po
/bin/sh: 1: msgfmt: not found
Makefile:2533: recipe for target 'po/build/locale/pt_PT/LC_MESSAGES/git.mo' fail
ed
make: *** [po/build/locale/pt_PT/LC_MESSAGES/git.mo] Error 127
