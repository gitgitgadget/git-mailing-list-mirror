Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC1871F454
	for <e@80x24.org>; Fri,  1 Nov 2019 23:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfKAXjQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 19:39:16 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:41041 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKAXjQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 19:39:16 -0400
Received: by mail-il1-f182.google.com with SMTP id z10so10030954ilo.8
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 16:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=1VN9HgC+7jxbi2igOVZmfWXH4dMjsadvwucWod7D9Qk=;
        b=AO3865y3dDZLygMeqqITeBULMbkGXrXYSQTHHfNsCM6SiTDN5DmLkkiUE2eB4GcBaT
         writFSoSuvmE11cw2eSEcU/VtS3fVrRdzxX3mUgJZtcoCkxZMZBpW17x4+zz9l/X75n3
         2eCwEAmfs1tKbD2tMlLbEpWV10qt+UMRulrTlPirQv1qzf40MSnv3NbE2xjN2mkGyv0c
         HbqyZiicKQ2c1/YbMY8vw29dckiygxBTBjIOVeIM1iiGgI1NTun3xKqyBw1Drt/RbRL0
         cm+kOvGsBIueD0LX8YvenjLMznq219A3ywMhysgs+Cq7Qrjnn79KrUkX46fA1D6vjE5C
         Ev+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=1VN9HgC+7jxbi2igOVZmfWXH4dMjsadvwucWod7D9Qk=;
        b=JkkV7mvHcxf6cDJoFsrQWc3i7qMfUtbHrYvl3pEx8Pmjxibn03NT2Yfg32+QcWNbWf
         gvVJGVkjQRPATKBi9FzK+qMwc9LZBve4xRcC/eq6fHobkRNg/XMyJlVC8AtiHtxokGCt
         kEnH3KMppxAOmlKpxamViaTE4yCq2gelzmI0u7UGosAQao8sr6sevwa2xgg4J79eKIy3
         o0az10DI1KuV6LZq9C8mzSI2k+nw841aBlX2DnErL5Otuq014cOdbSWHNzax7T6iDX1M
         nkXb3t84d0sOOLqnfIblhW3hV1nX5UuvAr/qo/Vayr8iBvrk1k11dNAnflorEZGEpy+z
         lrEg==
X-Gm-Message-State: APjAAAWnyvbl1D0na+5XTyiJpJZUH9k4wMEfhbwOXH92/FPGvKRtL+jg
        W/hU17kXBhOkjEaYbp77EkD6JM+aXQmpI9T1sa0HlZeg
X-Google-Smtp-Source: APXvYqxdYMJSkCuSh7QxgYJ25e/Bwm+a2R5fLkTcQRmZNbcNumXN5kKR/9wC8hLxtoDI3krfG07dU1nUzhbBkQf5Ho8=
X-Received: by 2002:a92:1d51:: with SMTP id d78mr16004280ild.166.1572651555479;
 Fri, 01 Nov 2019 16:39:15 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Fri, 1 Nov 2019 19:38:32 -0400
Message-ID: <CAH8yC8kGLKqKyTsndWCfGm3feT8aROyasqZA6Yj9YySe6HQHzA@mail.gmail.com>
Subject: Unusual output on 'git pull' on Fedora 31 server
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I upgrade a server today from F30 Server to F31 Server. The server
hosts a Git-based project over SSH.

Since the upgrade I've noticed the following on a Windows machine and
Armbian machine. All the extra 'remote:' are actually on one line.
There does not seem to be a eol in the output in the extra 'remote:".

The server provides:

    $ git --version
    git version 2.23.0

Any ideas what might be going on?

Thanks in advance.

$ git checkout master -f && git pull
Already on 'master'
Your branch is up to date with 'origin/master'.
Enter passphrase for key '/home/jwalton/.ssh/id_ecdsa':
remote:
remote: Enumerating objects: 9, done.
remote:
         remote:
                  remote:
                           remote:
                                    remote:
                                             remote:
                                                      remote:
                                                               remote:

 remote:
          remote:
                   remote: Counting objects: 100% (9/9), done.
remote:
         remote:
                  remote:
                           remote:
                                    remote:
                                             remote:
                                                      remote:
Compressing objects: 100% (5/5), done.
remote: Total 5 (delta 4), reused 0 (delta 0)
Unpacking objects: 100% (5/5), done.
From ssh://callmaster:/var/callboot-src
   ee5b8ff..0c05cca  master     -> origin/master
Updating ee5b8ff..0c05cca
Fast-forward
...
