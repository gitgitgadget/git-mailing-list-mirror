Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A6251FBB0
	for <e@80x24.org>; Wed,  7 Dec 2016 10:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932318AbcLGKpb (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 05:45:31 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:32864 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932248AbcLGKpY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 05:45:24 -0500
Received: by mail-io0-f194.google.com with SMTP id j92so12856796ioi.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 02:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4JryTJ+Lo5Cp3M35bKCXABL/q6aqztz14RDQfJU9QZg=;
        b=GPevyAUe1ALtSZ87tU2Ok33f0Nhke5jcwJlyia12CO1qZBZ+eQM8wO8A8Es3mPdzpM
         TOnAETGHbJD3lOxu6Wz588kRlRieKGH8k9Y0cXeOuXnaWbwduavMdUr8Dtb9z3cMWw5k
         5xqWrDj1cefslkYt7CKCmG96vKZqhATQIDjfmHpOjrn2YktSJ5DpPIBdNsk+pf3Obf5q
         V7j06G93DePmWZgXzlu4Bfe7Bf2e/rooXi1si4i1aAFUIZOdP+0oGI5pRBKKePqrcOI6
         3ijbynpnsQQHThCoKyaCaPQj/sEbMWwlV48A5HTa4yAKqMrPgUdEdFgO60EG8uM+5+gp
         kR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4JryTJ+Lo5Cp3M35bKCXABL/q6aqztz14RDQfJU9QZg=;
        b=IU01yD1SNG5pCkVE7U2Xza49EF9jqON9u5qEI65g1N/d+fYdU9oi2qhHtp/leZHcQt
         mStST+th9mqgF43aFjSMsJ1XKtSswRcUyKV5A2cT+Mqb72jp2bFV3eOxk4ny7Cq0GTIU
         IDnRTkUSB9UyUtmWcVHm6sgs3fCFBXgN0QR6Nn8KeJzTH1907oSURJKgGN1fznrQkb66
         PnAvaiL1C3/Gwt+vIWuXTzVsbtK6AGcK1Cb9KH8M/ut7WH43qtcB75FkVMI3D7t9PKG3
         giqYaAMdptq3ayU7oQM5xlJL7qnqpMaDJC/EtVvgXGFE0c5SCDdGZSk6XEp+dMLK3ca8
         SduQ==
X-Gm-Message-State: AKaTC00plK8UoekVHjyP7Q8+584oJW0lrUCGJWMUsu0gspQmJdp2h+aAOSYQG/pmWMrTSn6qT+izlRzn4/MAeg==
X-Received: by 10.36.34.196 with SMTP id o187mr1540114ito.3.1481107523540;
 Wed, 07 Dec 2016 02:45:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Wed, 7 Dec 2016 02:44:52 -0800 (PST)
In-Reply-To: <1481061106-117775-10-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com> <1481061106-117775-10-git-send-email-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Dec 2016 17:44:52 +0700
Message-ID: <CACsJy8CKY5wb+0KzpincHLiYwC0za9Wexo9QvNedcQTGc+ZRDw@mail.gmail.com>
Subject: Re: [PATCH 09/17] pathspec: always show mnemonic and name in unsupported_magic
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> @@ -413,10 +411,9 @@ void parse_pathspec(struct pathspec *pathspec,
>         prefixlen = prefix ? strlen(prefix) : 0;
>
>         for (i = 0; i < n; i++) {
> -               unsigned short_magic;
>                 entry = argv[i];
>
> -               item[i].magic = prefix_pathspec(item + i, &short_magic,
> +               item[i].magic = prefix_pathspec(item + i,
>                                                 flags,
>                                                 prefix, prefixlen, entry);

The final output looks a bit ...um.. strangely tall, with the first
two lines that have one argument each, then the last line comes with
three arguments. Maybe put 'flags' in the same line as 'item + i'?

>                 if ((flags & PATHSPEC_LITERAL_PATH) &&
>



-- 
Duy
