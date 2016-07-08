Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF4872070D
	for <e@80x24.org>; Fri,  8 Jul 2016 16:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948AbcGHQkR (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 12:40:17 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35193 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163AbcGHQkO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 12:40:14 -0400
Received: by mail-io0-f175.google.com with SMTP id f30so48084206ioj.2
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 09:40:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IqqmBKRitSZZxXYaQOsohTez2eaWtOyDNfWoLXSDXGw=;
        b=OsaSA+W02dTPuXm9rXjWjHVQ6QU9TFrQFKABJw3uFQv7iw6bg8jKgMiq32Acvv7MSz
         gVf0xpkiUmhyPRHbY5yqDT8LFubk/xyI4Z6qq+vbEg9TULQng9f+AdfiAXVqEpTvnF/p
         y3sdTE/4Vyh2yXgx6IH5lADWYPdGYmL/pEz+HjwGaHzOYLLz8OmglwAA6CjwcjMKCDXH
         xP/zpONc3qQRUFAI/h+ouOWU68pQPtJjw+mk72OxJzjgPthbtIlehYs8JNdMKVUPnXmy
         yYHqc7VnWs+eLZDRbHpDNyfcDtdXLizDrczMR/RGYFXo4BIE4Pq3TOdeAP5WYEQBEBQ8
         DjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IqqmBKRitSZZxXYaQOsohTez2eaWtOyDNfWoLXSDXGw=;
        b=k9xGSMm1a7EOXCOKeT9F69dVN04n7rjT1pt5RPX1N+kdTMYA1+wgbKxSmEPX9Zt/9Z
         on6EpJe6mg0JFadHpLi18Puyt0zi+Y7KTF6S94fJgOVu5dUfHtTM2XoATR3yk1cCAju4
         s5j67LcvJBgsoPStMQZms3aVIgV1zpIuReVOTn8CUO1mJJAbdsMwhNH69gxRDjdR63Uo
         Kkr1McDlqUryWTW3jISQwBIB7oNez59+XBAHYSpiH4OhAzw8XX5iQV9wdSkJ1a5+CUeC
         9iSOmgAQiKrv5Al98afM71Od1X/ZLmgBX8z7rKrtdsCL3WAD8+GODXAXxX7Nxm6AYmKx
         mZEg==
X-Gm-Message-State: ALyK8tIXTG2PTzI4360MRu+5Ua2xDGaQ9DQt3N7tmkTESyba99heSn68JbZMwp0J2oEuA/4MaZi0QR56qxuVUQ==
X-Received: by 10.107.22.6 with SMTP id 6mr9212298iow.128.1467996014107; Fri,
 08 Jul 2016 09:40:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Fri, 8 Jul 2016 09:39:44 -0700 (PDT)
In-Reply-To: <loom.20160706T170547-355@post.gmane.org>
References: <1466914464-10358-1-git-send-email-novalis@novalis.org>
 <1466914464-10358-11-git-send-email-novalis@novalis.org> <loom.20160630T192750-125@post.gmane.org>
 <CACsJy8DjYLQCBRc9CzFSWNqkVnhbAfnxd1mnQh4oEfJwKjPd1A@mail.gmail.com>
 <loom.20160701T013515-311@post.gmane.org> <CACsJy8DvZgj0w8z8LdeuY8HdTTcEu7ABPyFi_wnmEZOGsoMkDQ@mail.gmail.com>
 <loom.20160706T170547-355@post.gmane.org>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Fri, 8 Jul 2016 18:39:44 +0200
Message-ID: <CACsJy8Dz7LHPQp2drE9EeqFzvjm1RHo_mA0ytfhXMgrcZBMgPw@mail.gmail.com>
Subject: Re: [PATCH v13 11/20] index-helper: use watchman to avoid refreshing
 index with lstat()
To:	Ben Peart <peartben@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

BTW just for me to have some perspective, roughly how many directories
and files are there in the worktree of this repo?
-- 
Duy
