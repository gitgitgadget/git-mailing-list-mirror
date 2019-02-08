Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 619EF211B5
	for <e@80x24.org>; Fri,  8 Feb 2019 18:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfBHSxf (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 13:53:35 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33732 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfBHSxf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 13:53:35 -0500
Received: by mail-ed1-f65.google.com with SMTP id a2so3700782edi.0
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 10:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=fSKtbhd7xSysYTg2FSQuDdh3Y3l2gqpqsiSBK61vd0Q=;
        b=rcaJ96XwPwAuKBcWbqgMuZJx7ZHJ73Vj11K1gCasmFgv3YpONgEamuziMqfl5+RJjS
         BSEllvp1S+Vfb9tdzU7lmAz/xCn1GKLk0WQzwPxKYMfDqaJIy1JzHA5bSKkWI8o+K1QP
         DzzqLi6MThy00I+PEf1kTW8X/Lw+66Iyanir+6OA/GKJTeF7CFucr3AVU/WisY5EmDUX
         16wmIHExcJXzhkJ2ki/uGnYiCFVv5n9c4/DJK0O5BR2MibAcjANXJLAzieqp92wICzBt
         Q3e7OZnCovYKKW0Ltm/PaCXSa67iWscgIhamMK2kUUhmXbm7AaChMPfsI5UL1mpCV+gj
         7vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=fSKtbhd7xSysYTg2FSQuDdh3Y3l2gqpqsiSBK61vd0Q=;
        b=WY0KQmPcEkU9yBEcspb/Ox1T2fAGhS3eBgqbvRs70MM/hYSdGtmOBSh13nLq5kCKDK
         I8M7k9pRw2L4aAys37veRFq2L4A6iNiGvcLbXxM2wqs+FLk6SLUbef92EcBh5mRJzYyc
         VvRgIc4Pm3t9gtmL3X6DUWh37Yy9IykcYoucNVYlaQAjxXa5v7tuv5TEl2CTwMraUOO7
         9SNtH6FZGPUVkVoJMhQRQms63UVkCeBs7Q3nTty+nmhxinOFPIGyfvZlSiYIlTJ7lzEj
         YrPPJIosPFiqWjloqirCVI0+PaW26MVj79j0ahTKdDfIuq+ltvUvbNehLlRIEizS4qNK
         ZF4g==
X-Gm-Message-State: AHQUAub1z+Sys8ECr/uF/i2FT9KUjTTDLQ6byPkrmSaftFF9fC1Auuxg
        Y8q6teFSAx+x6xQB+C63n4A=
X-Google-Smtp-Source: AHgI3IZz4JrO05JvBu+ZeI0/7TQkUxYEnTkRCFRryx+MTvG6SUPoCnDbRqXwLs1n+xA8KiwgKP8ygA==
X-Received: by 2002:a17:906:b886:: with SMTP id hb6mr16746917ejb.71.1549652013739;
        Fri, 08 Feb 2019 10:53:33 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id f34sm817813eda.22.2019.02.08.10.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 10:53:33 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: New command/tool: git filter-repo
References: <CABPp-BFC--s+D0ijRkFCRxP5Lxfi+__YF4EdxkpO5z+GoNW7Gg@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <CABPp-BFC--s+D0ijRkFCRxP5Lxfi+__YF4EdxkpO5z+GoNW7Gg@mail.gmail.com>
Date:   Fri, 08 Feb 2019 19:53:32 +0100
Message-ID: <875ztukt77.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 31 2019, Elijah Newren wrote:

> What's the future?  (Core command of git.git?  place it in contrib?  keep it
> in a separate repo?)  I'm hoping to discuss that at the contributor summit
> today, but feedback on the list is also welcome.

Some of this I may have mentioned at the summit, but here for the list:

* I think it should be a candidate for a core (not "just contrib")
  git.git command, given that we have someone willing to maintain it &
  deal with bugs etc. I'm not worried about that given the author.

* It's unfortunate in terms of API we need to support going forward that
  this obligates us to support a fairly intricate python API going
  forward, so it's similar (but more detailed) to Git.pm (which I also
  tried to get rid of as an external API a while ago).

  However, as you correctly note that's the only way a command like this
  can be really fast, we already have the "no special API" command with
  git-filter-branch, and that's horribly slow.

  But perhaps there's ways we can in advance deal with a potential
  future breaking API change. E.g. some Pythonic way of versioning the
  API, or just prominently documenting whatever (low?) stability
  guarantees we're making.

  I imagine if we need to make breaking changes in the future that'll
  less big of a deal than in other cases, since we'd expect the API use
  to be one-off migration scripts, although maybe it'll get used for
  all-the-time exports (e.g. mirroring internal->external repos with
  filtering).

* The rest of our commands are hooked up to the i18n framework. I don't
  think this should be a blocker, but it's worth thinking about what the
  plan for this is.

  Are we going to need the equivalent of Git::I18N for Python (which
  presumably will be a run-time dependency on something needing the
  Python API that links to gettext).

  Or perhaps we could do the translated strings in C, by making the
  program you're invoking be a C command, invoking the Python part as a
  helper (which would need to re-invoke a helper if it prints its own
  messages).

Thanks for working on this!
