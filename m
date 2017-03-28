Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17D791FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 23:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753523AbdC1XRT (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 19:17:19 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:35971 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753119AbdC1XRS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 19:17:18 -0400
Received: by mail-ot0-f176.google.com with SMTP id t8so58019578otf.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 16:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=oJCA5vJoZgEfCOaN913C1zooZ0zB5xm4w2xN67gr4fM=;
        b=cp6IkkzvF54awKfwE5oAGyGq33v9A/XrXFczHBvppH6IYwJarjDb1VDEk+GOTa8WnZ
         RbnNvyTYpCyg3HDm6myPVERWBqgiiGgXUH6I0dUuL1Ce7vnvwCCyq3EqMk6RY6P2nE5T
         skMXnf2Kx3i/Dg1THHXwEVWlOAn4LLZhQhXkLcKgoa/cmdE0dtYUccuWpMJiPdIJI82R
         x24jaMduI/ztvpw07PdPLObNh9jA0r/Ri+p6yY9F4ZQPNGsw/urk+6/rIE43aeMm7elC
         f56R4uXWu3l3CzeS4bLb8r1f6uECG2A37ReNkreJytZt001c2P5/fnkjxp9CCNlal2/d
         jAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=oJCA5vJoZgEfCOaN913C1zooZ0zB5xm4w2xN67gr4fM=;
        b=aElECKFi79CllWJtbGLc7XP/irR/Hd9e6dottJ3ojNEH0Yw+WgbhLj/QDIOyCnncJe
         yd6J5aUhEw9NnoMA0EwPn2vrQVTLD0XQFbDH8xBEexsuLUSgldwC7zChI3BuA1TYeqJI
         BIxJQ0XPhnJ6rmWU/MCO0b4CQBIBznFcPi86e1RDJYjy58CMsPiEWt9PkPDyvBOO61az
         q6GFXQpCuKeOlEosEH5gxry8NOTBV2FzEzpgpbul7HAsEeXMqdM30lKD7ccOTlXMBZNP
         IlzX4hyU2XZl0E/9P1hWquNCNt6a3Lxo7sdAhrqlVxD8yqnWjwfF7yutBdeJxj9xjhoC
         M+0g==
X-Gm-Message-State: AFeK/H2QIIX1UPjsBO1QrsGS6xkph2nC3z/TTWFEFVv8WNLmIJbJAU6lC5/UueVavgZQZ0hW7R9jsZ+zl0alGg==
X-Received: by 10.157.0.8 with SMTP id 8mr3149798ota.234.1490743037034; Tue,
 28 Mar 2017 16:17:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.31.131 with HTTP; Tue, 28 Mar 2017 16:17:16 -0700 (PDT)
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Tue, 28 Mar 2017 19:17:16 -0400
Message-ID: <CAH8yC8kexrV8d7Tg_vCCM+GWsNH82386HEyN=XSguqZjcOuPzQ@mail.gmail.com>
Subject: Git fails to build on Ubuntu Server 16.04
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I configured with --enable-pthreads, and LIBS included -lpthread.

$ make V=1
gcc -I/usr/local/include -g -O2 -I. -DHAVE_ALLOCA_H
-I/usr/local/include -DUSE_CURL_FOR_IMAP_SEND -I/usr/local/include
-I/usr/local/include  -DHAVE_PATHS_H -DHAVE_STRINGS_H -DHAVE_DEV_TTY
-DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM
-DSHA1_HEADER='<openssl/sha.h>'  -DNO_STRLCPY -DSHELL_PATH='"/bin/sh"'
-DPAGER_ENV='"LESS=FRX LV=-c"' -o git-credential-store
-Wl,-rpath,/usr/local/lib -L/usr/local/lib  credential-store.o
common-main.o libgit.a xdiff/lib.a  -L/usr/local/lib
-Wl,-rpath,/usr/local/lib -lz -L/usr/local/lib
-Wl,-rpath,/usr/local/lib -lcrypto  -lrt
/usr/bin/ld: libgit.a(run-command.o): undefined reference to symbol
'pthread_sigmask@@GLIBC_2.2.5'
//lib/x86_64-linux-gnu/libpthread.so.0: error adding symbols: DSO
missing from command line
collect2: error: ld returned 1 exit status
Makefile:2053: recipe for target 'git-credential-store' failed
make: *** [git-credential-store] Error 1


If the makefile is modified after 'make configure':

    find `pwd` -name Makefile -exec sed -i 's|-lrt|-lrt -lpthread|g' {} \;

Then Git builds successfully.

It appears the request to use pthreads is not being honored.

Thanks.
