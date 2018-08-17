Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B3B81F97E
	for <e@80x24.org>; Fri, 17 Aug 2018 15:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeHQSfX (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 14:35:23 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:53055 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbeHQSfX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 14:35:23 -0400
Received: by mail-wm0-f45.google.com with SMTP id o11-v6so7910203wmh.2
        for <git@vger.kernel.org>; Fri, 17 Aug 2018 08:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JOhHyMBtYS7O8WR5hZVPATNKWWMxzKd3tzJBA6+iHGc=;
        b=LfPO+BX8inuJxN4D5cW4knC/VeLYvfxrDr02K50ykqzdAjxI9zcN+Jba/+IjPvopB8
         rZoQeXBr0XatVORlgcMKNQCt+vbGeIF3l8HNvP8SahciGGhH/nWsj7CFUTnAWbNmuWaR
         rLeY0uVOBI6rrKMG1xrKh8XoVTJid3P/KfACvhfah9tJNQzdH8mNawneh43vbz3Io9+b
         ns5KNwICqR2NCbYmiGM1FQ7+HD1IQkxJAb2GihAnyyEcV/bhZ9pxFi1XYkXvl7CPCrJt
         B6D4LQDI99/lsLKWfz1FmqUfpu1UkkPIIdxVBEy4/sS+ou8wRCc0h55qumxMVmVP9tB9
         eomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JOhHyMBtYS7O8WR5hZVPATNKWWMxzKd3tzJBA6+iHGc=;
        b=sb2f0VyPU47ETWjVO8828E/0i2iIkPb88xj3jsreMO5Ao+tUJ4ygjvoBK02/5VczAQ
         UJXfn1ZoyOjQlaJ7yltbWiRViwfdnoTaaYgvIgal5oTovR8X3xoZKBdVNufKyNJ+wFsK
         AtZOwF0z19gOlnOrhmCE/sqZYhJ5pFTN7/emeY/r2Pd6ZW9M4rKpHXtH8A3RdyWnZdZ0
         pAVBHsDvDVROAIb6JJrZOOWwWR1kUbP/Z8yM6TWxPALEcKav+1e1ijM6xjFkc2dm0lrS
         ANDOvLsxFw1O2oDhymybgiVP/Zoxei8M/7C2EGz4lrcoJqlcaK1bpKJEUT019QKJSadQ
         oF+Q==
X-Gm-Message-State: AOUpUlE5rSpX2qTtwjcJPzOSiGp6jNdFHTBpariGv90paoNurqrmMe0o
        ET84qFrhCB21G3SvuemrJk8=
X-Google-Smtp-Source: AA+uWPw0HLB4Eq5vTZhhG5ZY5b+RjS4wuEJSVKAscEoj0SyMVH5OG4FQ8helLa6Mi/6WLEvuB8NDsQ==
X-Received: by 2002:a1c:8010:: with SMTP id b16-v6mr20195860wmd.9.1534519893404;
        Fri, 17 Aug 2018 08:31:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r13-v6sm2626050wmf.34.2018.08.17.08.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 08:31:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] commit: add short option for --amend
References: <20180816183117.13716-1-pclouds@gmail.com>
        <20180817064734.GB131749@aiede.svl.corp.google.com>
        <CACsJy8Di4GQLqkBmcnrfmU9aS=wizxU36Ly0BRgDEDmFG=+2Fg@mail.gmail.com>
Date:   Fri, 17 Aug 2018 08:31:32 -0700
In-Reply-To: <CACsJy8Di4GQLqkBmcnrfmU9aS=wizxU36Ly0BRgDEDmFG=+2Fg@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 17 Aug 2018 16:33:30 +0200")
Message-ID: <xmqqa7plc8mj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> The alternative is -A or -M which may be easier associated with
> --amend.

I would be confused to mistake that "git commit -A $args" would do
something similar to "git add -A && git commit $args".

I do my fair share of amends during the day, and I've never felt the
need for a short-hand, but perhaps that is just me.  I am wondering
if "-E" (stands for 'edit', not 'A or M are out, and the next letter
in amend is E') is understandable and memorable enough---after all,
it is "editing" an existing commit, and the edit is done in a big
and different way than the existing "commit --edit".

But perhaps that reasoning is a bit too cute.  I dunno.

