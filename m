Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DDB920966
	for <e@80x24.org>; Wed, 29 Mar 2017 09:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754569AbdC2JTV (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 05:19:21 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34479 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753226AbdC2JTU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 05:19:20 -0400
Received: by mail-oi0-f49.google.com with SMTP id o67so4755168oib.1
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 02:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=tMT/JeRup6u0AO0eM5leNCDnQ+gqp3OFibBvIAutvAw=;
        b=Wn0J1/shGUnd06LuwBTuOkl+evgnFpEn4nCvuwgW50gHSRPVikkeiyrPBMUQH7xrRj
         isR4qa3y0LpUl2a/XPoWZU7NCglFETdrDsHIwNq61IPeJT7YakZD19IDBtwPkIyoXJMC
         H+zWg2fHXflDyMC5Q3eQtn6b2OsymkPsuxAbiXZvLEAlU5eNt9z6NNh3juMgMzKtsaiB
         pikYYPGHozuwZeNfj0yDNx7KG/UmRX1SYT1aatARqhwycIUjb0vtA+hB1NpQnRSwX1wU
         YAcVdtoNFiKny5mZClI2FMtmtxaIVV0O/5iT+AeFSKJWmhis5AXGUiAYRVaw9d5o5QEW
         +EUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=tMT/JeRup6u0AO0eM5leNCDnQ+gqp3OFibBvIAutvAw=;
        b=J8xsz96ELEo2/M8U0qDEryogjMmaPTf/QVee4ZwJHaZJvGOxeALoAKVuDFGBNDJqT0
         Uog7zxCPAymY0NC+vB96G8dDFdbw8ipw70BKf4Z9d0dDHHuZL+piHt4N3duJt38VSWL2
         2gWVgQDH7ySFslk2YOVuGaR0as7cZQcS+CMUlrxT63MpvIn2d8cKUAxtMFgOdNqNxd0F
         jolDwNwqkJNcyjEWnOQMIaQfNjZ4dLishTQ/wXWmBuLVpGbL0j7O6GsT6926t906YVO+
         btLt2NrbqfLpDhfghnwxP2c4H/uOvFKiohA4SmMOEXVM7QDrJwkMj4K5FvROW/bP/Hy/
         1HDQ==
X-Gm-Message-State: AFeK/H1Ww9erIXfMezTnYfQnb6PNPRO5/h/qAQ98XgkSX5HFIC6Dwh1dIiVTKfoi1xPQ5nIW8OZ8Avz9ZDaZxg==
X-Received: by 10.202.206.149 with SMTP id e143mr9285223oig.158.1490779158188;
 Wed, 29 Mar 2017 02:19:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.31.131 with HTTP; Wed, 29 Mar 2017 02:19:17 -0700 (PDT)
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 29 Mar 2017 05:19:17 -0400
Message-ID: <CAH8yC8kOj5a5PN4V7mj7xZPoNDr-MH-CkirxRKyfx1-qAvfpqQ@mail.gmail.com>
Subject: git-compat-util.h:735:13: error: conflicting types for 'inet_ntop'
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some more 2.12.2 testing on Solaris 11.3 x86_64:

$ make V=1
gcc -o credential-store.o -c -MF ./.depend/credential-store.o.d -MQ
credential-store.o -MMD -MP -I/usr/local/include -m64 -m64 -I.
-D__EXTENSIONS__ -D__sun__ -DUSE_LIBPCRE -I/usr/local/include
-DHAVE_ALLOCA_H -I/usr/local/include -DUSE_CURL_FOR_IMAP_SEND
-I/usr/local/include -I/usr/local/include -DNO_D_TYPE_IN_DIRENT
-DNO_INET_NTOP -DNO_INET_PTON  -DHAVE_PATHS_H -DHAVE_LIBCHARSET_H
-DHAVE_STRINGS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME
-DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM -DSHA1_HEADER='<openssl/sha.h>'
 -Icompat/regex -DSHELL_PATH='"/bin/bash"' -DPAGER_ENV='"LESS=FRX
LV=-c"'  credential-store.c
In file included from cache.h:4:0,
                 from credential-store.c:1:
git-compat-util.h:735:13: error: conflicting types for 'inet_ntop'
 const char *inet_ntop(int af, const void *src, char *dst, size_t size);
             ^
In file included from git-compat-util.h:209:0,
                 from cache.h:4,
                 from credential-store.c:1:
/usr/include/arpa/inet.h:43:20: note: previous declaration of
'inet_ntop' was here
 extern const char *inet_ntop(int, const void *_RESTRICT_KYWD,
                    ^
make: *** [credential-store.o] Error 1



Looking at git-compat-util.h around line 730:

#ifdef NO_INET_PTON
int inet_pton(int af, const char *src, void *dst);
#endif

#ifdef NO_INET_NTOP
const char *inet_ntop(int af, const void *src, char *dst, size_t size);
#endif



When I grep config.log, I don't see a test that results in NO_INET_*:

    $ grep NO_INET config.log
    $



According to Solaris' man page for inet_ntop:

inet(3SOCKET)              Sockets Library Functions             inet(3SOCKET)

NAME
       inet,  inet6, inet_ntop, inet_pton, inet_aton, inet_addr, inet_network,
       inet_makeaddr, inet_lnaof, inet_netof,  inet_ntoa  -  Internet  address
       manipulation

SYNOPSIS
       cc [ flag... ] file... -lsocket  -lnsl  [ library... ]
       #include <sys/socket.h>
       #include <netinet/in.h>
       #include <arpa/inet.h>

       const char *inet_ntop(int af, const void *addr, char *cp,
            socklen_t size);

       int inet_pton(int af, const char *cp, void *addr);

       int inet_aton(const char *cp, struct in_addr *addr);

       in_addr_t inet_addr(const char *cp);

       in_addr_t inet_network(const char *cp);
       ...

Jeff
