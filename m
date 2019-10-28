Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A274A1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 21:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfJ1VoB (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 17:44:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42032 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730592AbfJ1VoB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 17:44:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id c16so6354801plz.9
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 14:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HjbXpPEpnWCZi8fTDCVSZivh6ojHOjERuUo7Qn+cJNY=;
        b=eQtqA0p1J6rwF2L2+r2F27hOK5vy9Vsjjq9eVIqFs5sESxx6RC4L9n9DeWJ3wM6yMs
         2hceUlaO+3uLgtZ8RBvaIoK5HH6G141T200hbSUkv/q9gcz023vUdtK+mhfHRg1Qo2tN
         YA+ie6132MP6xJyKetNKzaQAQSk4LDn9tWp5EvEBHDMdFR8XS4FzWaWcUzeHSFjcOEgc
         jG308bUq1ZFZSQbtUAYprPy3Upy20fFi+D6/SiYMeKPvaT6mSyouOUVakcrXm8jsVHnq
         C7Ez5bN1MKy7bBBTruDE9JExmXkJ1+Tojacz+qGkeewe3qHenLnxV1r97sk2HSsc1BmC
         XE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HjbXpPEpnWCZi8fTDCVSZivh6ojHOjERuUo7Qn+cJNY=;
        b=BtgYbI7xYbquBh1fx7LN/9apnBGtkxVI2qcURCVcMWydRQSK0DLAg424rF0aQuwuW2
         A3V3JLnCHkMF9DX2vosT/6JoXd9a6Xo/TkHu8lkNgAR6fR0z800veGZK74+cjWgwV68V
         Z+yVTKxt+KTOICIiBTe38wIeT9xqFK1sJg4TcKsFk8wBvz49P93OuC7YQ96hk6XJ0SCp
         dzJ/naGwSoFzQT6BU0yhuoZ/oAMJEqpbLK41Nq3Ii642GXcL0yHnNJlzQcEvSPpiDERG
         8dk5UC8+mqF0CzBBb4rmOq8XUTYeO1AQIye/u4If748iwdMPLydbTsg+F17xODEs5eqg
         s9Dg==
X-Gm-Message-State: APjAAAUsWUhxVfuaL8PG2jhOxJtIdskLH5xyvUxEhxvvAfZ+8H344aio
        vc+9rJ8MpBMSWmRgd56Sat/YBTSL
X-Google-Smtp-Source: APXvYqydLSg1h7H0iAP7XWKWX178v7AqWJG/kdzBPPn3vvvbWnXZgpRwyyV/8sapxWgcYtZSeUVUaw==
X-Received: by 2002:a17:902:b205:: with SMTP id t5mr254936plr.126.1572299040160;
        Mon, 28 Oct 2019 14:44:00 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id r81sm13331892pgr.17.2019.10.28.14.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 14:43:59 -0700 (PDT)
Date:   Mon, 28 Oct 2019 14:43:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Michael Felt <aixtools@felt.demon.nl>
Cc:     git@vger.kernel.org
Subject: Re: COMMENTS: building git on AIX
Message-ID: <20191028214357.GB12487@google.com>
References: <1200106e-b75d-5b15-0608-427cd923578a@felt.demon.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1200106e-b75d-5b15-0608-427cd923578a@felt.demon.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Michael Felt wrote:

> I have, a couple of time, successfully built git for AIX. However, my
> prior attempt (version 2.18) - I never got around to finishing and today
> with version 2.23.0 - I am unsure how to proceed without a lot of hacking.
>
> Just some comments - long long way from calling anything a bug - just
> not as portable as I would have hoped.
>
> The simple issues:
>
> 1. The "Makefile" is surprising. I expect to run ./configure (or better,
> out-of tree, e.g., ../src/git-2.23.0/configure). Just running OOT
> configure does not result in a "Makefile". So, copy source tree to dest
> and try again.

See INSTALL:

 [...]
 Alternatively you can use autoconf generated ./configure script to
 set up install paths (via config.mak.autogen), so you can write instead

so the output of the configure script is a config.mak.autogen file.
Keep in mind that most of Git's developers don't use the configure
script, mostly because it's slow.

I like the idea of teaching the configure script to set up a VPATH
build.  Would you be interested in working on that?

> 2. Makefile assumes gmake. Standard make does not support :: syntax
> (fix: install cmake)

I assume that by cmake you mean gmake here.

> 3. The default CFLAGS contains -Wall. Not all compilers support -Wall.
> "Fixed" by adding CFLAGS="-g -O2". I am also undecided on having -g as a
> default flag.

Interesting!  That doesn't feel like a recent change:

 $ git log -GWall -- Makefile
[...]
 commit b05701c5b4c7983ef04d8c286c65089596553bd6
 Author: Pavel Roskin <proski@gnu.org>
 Date:   Sat Aug 6 01:36:15 2005 -0400

     Make CFLAGS overridable from make command line.
[...]
 commit 19b2860cba5742ab31fd682b80fefefac19be141
 Author: Linus Torvalds <torvalds@linux-foundation.org>
 Date:   Fri Apr 8 09:59:28 2005 -0700

     Use "-Wall -O2" for the compiler to get more warnings.

It seems worth calling out in the INSTALL file (and autodetecting in
the configure script).

> 4. Must have gettext installed, which needs GNU libiconv - sad to have
> these libraries as additional dependencies. e.g., bash 4.4 finally
> removed the gettext and iconv gnu dependencies. -- FYI!

See INSTALL:

 Set NO_GETTEXT to disable localization support and make Git only
 use English. Under autoconf the configure script will do this
 automatically if it can't find libintl on the system.

Did the part of the configure script that does this break?

> 5. Another "gcc"? dependency: "git-compat-util.h", line 361.1: 1506-277
> (S) Syntax error: possible missing ';'
> FIX: add 'CC=xlc_r' to get language extensions

That's

 static inline int noop_core_config(const char *var, const char *value, void *cb)

Does AIX cc have trouble with "static inline"?

> 6. Needs curl (libcurl and curl.h), but does not check until much later:
> FIX install curl; FIX2 add -I flag to find $prefix/include to CFLAGS
> (.e.g., CFLAGS="-g -O2 -I/opt/include") - FYI GNU autotools also fail to
> include $prefix/include

From INSTALL:

  "libcurl" library is used by git-http-fetch, git-fetch, and, if
  the curl version >= 7.34.0, for git-imap-send.  You might also
  want the "curl" executable for debugging purposes. If you do not
  use http:// or https:// repositories, and do not want to put
  patches into an IMAP mailbox, you do not have to have them
  (use NO_CURL).

Would you be interested in improving the configure script's detection
of this?

> 7. More stuck here. libssh2 is built by curl, but as a static library. I
> could "hack" the libssh2.o file into the linkage, but unclear how well
> that will work. Also wonder if libssh2 is "required" or optional. For
> curl it has been optional (and I think it still is).
[...]
> git-imap-send   imap-send.o http.o common-main.o \
>           -L/opt/lib -lcurl -lssh2 -lssh2 -lssl -lcrypto -lldap -llber
> -lssl -lcrypto -lz  -lssl  -lcrypto libgit.a xdiff/lib.a  -lz  -liconv
> -lintl -lpthread
> ld: 0706-006 Cannot find or open library file: -l ssh2

The "-lssh2" comes from "curl-config --libs" output.  It sounds like
your copy of $(which curl-config) should have CURLLIBDIR set but
doesn't.  Should we use "curl-config --static-libs" on AIX instead?

If you know what flags to use to link to curl, you can use
CURL_LDFLAGS to set that instead.

> Not sure - if I can help - but do hope this already helps in a (small) way.

Thanks for working to keep Git portable.

Hope that helps,
Jonathan
