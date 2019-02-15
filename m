Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CE1A1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 13:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394839AbfBONCS (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 08:02:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33602 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfBONCS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 08:02:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so10302957wrw.0
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 05:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ek5JG+VkYDSxQL/pbIY6T1gjw67iznOrCqV2OTZVJII=;
        b=NWB3Hyib8r2e/ctnOkveoe414I28TidQwMB/1nH7EF3EzJnaHp+w9vZ10jZCGZ7iJa
         5gt59Z449BnSsh072mtMRGVEwrMyx9+Wd/kNHFhJOMQ9C3KAw8eXFyRGmG1sa8LfEKVh
         9Gz0zgnF5aoyii/T8fFJ7VAcKE2ezHhBvSyYmZhZvoho97/GH779m1Wjdzc6mjLUB6uh
         Zi5FyjtBzUCM743XgkGLSV8dwswQb2ZM5QY8Os2DLchnFKbHNRWxpNQ5JQkNwfrNeKv4
         GFri6ucGos51zup5hsygt6yRxqiI1rdOAJF/AOVJwgyz/RA5ICxM7eP498uYuFx8KSUI
         E3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ek5JG+VkYDSxQL/pbIY6T1gjw67iznOrCqV2OTZVJII=;
        b=TW+Ymvs+9XeE6Os3dffVxKQfQD2bEIW7H/J565vop8JTyZ51Wjf1Z8MSxsqEyZbyW8
         3T9Vl2f/0QQasSZgL4t5MXHUHkU+e1dnYvqRZV3asChfib2z59HrWjxEAPP3ynQ+o03t
         HJJf54hPgtefuKPWHtbGv8LyX0JfVj23R6i9RMFAUhZRfnmSQcnloDjJNCDcyX3SIBAP
         3zAe7uj4f4sPByJLIlwvtMzjI7KByaZmiF9gP3ozzjr7oIxjRBT6yldtfFP/bHz8MaNF
         3tfG4le3nvolY4IgMYzLPXFocMQ3zZ6/WN8JmcQ/RjO+/gNAUlMufqzQp/0HlJfG3Nze
         i6zg==
X-Gm-Message-State: AHQUAubUlzMwjDRk7TQYuNlDFU8aDjBSr5+I+o117/gw6c/d1+T5W+NL
        A+KONmdfgeHC9AJKb190q75PJDKs
X-Google-Smtp-Source: AHgI3IYZj9xFncLgRikcCNyzksG2uuo2CPIQAxoR2rrRucJkYJp2vzz0zFE1bMTyEpNwUQhcmcXhow==
X-Received: by 2002:adf:fd46:: with SMTP id h6mr6697302wrs.170.1550235736680;
        Fri, 15 Feb 2019 05:02:16 -0800 (PST)
Received: from szeder.dev (x4db90347.dyn.telefonica.de. [77.185.3.71])
        by smtp.gmail.com with ESMTPSA id v19sm8502054wmj.36.2019.02.15.05.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 05:02:15 -0800 (PST)
Date:   Fri, 15 Feb 2019 14:02:13 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Max Kirillov' <max@max630.net>
Subject: Re: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results)
Message-ID: <20190215130213.GK1622@szeder.dev>
References: <001501d4c476$a94651d0$fbd2f570$@nexbridge.com>
 <nycvar.QRO.7.76.6.1902142234070.45@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1902142234070.45@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 14, 2019 at 10:36:42PM +0100, Johannes Schindelin wrote:
> On Thu, 14 Feb 2019, Randall S. Becker wrote:
> 
> > t5562 still hangs (blocking) - this breaks our CI pipeline since the
> > test hangs and we have no explanation of whether the hang is in git or
> > the tests.
> 
> I have "good" news: it now also hangs on Ubuntu 16.04 in Azure Pipelines'
> Linux agents.

I haven't yet seen that hang in the wild and couldn't reproduce it on
purpose, but there is definitely something fishy with t5562 even on
Linux and even without that perl generate_zero_bytes helper.

  $ git checkout cc95bc2025^
  Previous HEAD position was cc95bc2025 t5562: replace /dev/zero with a pipe from generate_zero_bytes
  HEAD is now at 24b451e77c t5318: replace use of /dev/zero with generate_zero_bytes
  $ make
  <snip>
  $ cd t
  # take note of the shell's PID
  $ echo $$
  15522
  $ ./t5562-http-backend-content-length.sh --stress |tee LOG
  OK    3.0
  OK    1.0
  OK    6.0
  OK    0.0
  <snap>

And then in another terminal run this:

  $ pstree -a -p 15522

or, to make it easier noticable what changed and what stayed the same:

  $ watch -d pstree -a -p 15522

The output will sooner or later will look like this:

  bash,15522
    └─t5562-http-back,21082 ./t5562-http-backend-content-length.sh --stress
        ├─t5562-http-back,21089 ./t5562-http-backend-content-length.sh --stress
        │   └─sh,24906 ./t5562-http-backend-content-length.sh --stress
        ├─t5562-http-back,21090 ./t5562-http-backend-content-length.sh --stress
        │   └─sh,26660 ./t5562-http-backend-content-length.sh --stress
        ├─t5562-http-back,21092 ./t5562-http-backend-content-length.sh --stress
        │   └─sh,4202 ./t5562-http-backend-content-length.sh --stress
        │       └─sh,5696 ./t5562-http-backend-content-length.sh --stress
        │           └─perl,5697 /home/szeder/src/git/t/t5562/invoke-with-content-length.pl push_body.gz.trunc git http-backend
        │               └─(git,5722)
        ├─t5562-http-back,21093 ./t5562-http-backend-content-length.sh --stress
        │   └─sh,25572 ./t5562-http-backend-content-length.sh --stress
  <snip>

It won't show most of the processes run in the tests, because they are
just too fast and short-lived.  However, occasionally it does show a
stuck git process, which is shown as <defunct> in regular 'ps aux'
output:

  szeder   5722  0.0  0.0      0     0 pts/16   Z+   13:36   0:00 [git] <defunct>

Note that this is not a "proper" hang, in the sense that this process
is not stuck forever, but only for about 1 minute, after which it
disappears, and the test continues and eventually finishes with
success.  I've looked into the logs of a couple of such stuck jobs,
and it seems that it varies in which test that git process happened to
get stuck.


 
