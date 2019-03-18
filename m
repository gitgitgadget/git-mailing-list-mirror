Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA1DE20248
	for <e@80x24.org>; Mon, 18 Mar 2019 06:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfCRGrp (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 02:47:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37991 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfCRGrp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 02:47:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so15668265wrm.5
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 23:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=LI7S9WDQjyL9ff6hGfOzCNnTTYOa6HwZm+vFu7epO6E=;
        b=deQLASHrnJJPRCM0KjUF8vxiuwRGrCUy/JFSOYXtM7sW/kwJUNC/dRW33eVPkKcqjs
         Xce4CqsGZiFUEpR0eKOKeS0ihwrxrBsL6rh/7LFL+dAeYzJy5HvWY8osVVwLY2FhpYNo
         aRfpAz/BlqAriq/sb/9wM9r7BG9vnoRCZ1TFgIVnZuY8ItcYWgk9ZFWM9/lqHZLggKAB
         NF+desvWYA/KkMXtQShXoYZPlQT62ObzfsYtsnxIhYdC2wGZVHdAn0vRcglZP+NE2J9d
         jNK1X7nqyile9Fk6OUDpErdVlWORCn4La6BoOQKFlhCK0kr/LUAVFmaC7+bBaD+vuKIr
         PVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=LI7S9WDQjyL9ff6hGfOzCNnTTYOa6HwZm+vFu7epO6E=;
        b=kk8BKqb8YrAQcvLrE7fzrmH60nKhl8Xim6d/1yQSUFzvPa/DW/8rDENENMsYy48Un2
         8TBmK8kQG1VTe+qE3Z39+/ZcepYa3IwrB4v+wXU6lunLxiXuq251PBb0KXPC4lbkVA8m
         WLPQVUD3Mnv6YrUtwY2/0mR4kh/rfnif9XUpARNgNUYQ+zfl+6Gf2NulKDAV4NFgJtjW
         eIDJHfQAVKrV7wxNDHv6cNack+72m0MuPQDQ/SovYicSLZC9l4W2F8GEMO4+Aq/Loc4w
         rWvvecA0ETARAiy1wbrEOanPDONgrYc7eyDUITSUhVBAtpktbAVSXYf97U3QykO4f9zW
         vFeA==
X-Gm-Message-State: APjAAAWImr5Rynwf7mq7wVoKhyjapB5obZHQt3GkURc8ba8xU5Aim1Rm
        piwgMQOXvWh7eW4OFN0EiLI=
X-Google-Smtp-Source: APXvYqxfcfptz/q+u3FfxPshwc1yi2pB1u59gpqRZNlRB5sq3VflYvbATJzQo6OYZBBCCGY632IgAw==
X-Received: by 2002:a5d:558c:: with SMTP id i12mr10616988wrv.19.1552891663639;
        Sun, 17 Mar 2019 23:47:43 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id g81sm9186767wmf.7.2019.03.17.23.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 23:47:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] git-diff.txt: prefer not using <commit>..<commit>
References: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com>
        <87multaaac.fsf@evledraar.gmail.com>
        <CACsJy8C3P93896fP8BStmYd1WMNukYV6u8gB0zgC3rKLqxgzyQ@mail.gmail.com>
        <87lg1da8uj.fsf@evledraar.gmail.com>
Date:   Mon, 18 Mar 2019 15:47:42 +0900
In-Reply-To: <87lg1da8uj.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sun, 17 Mar 2019 15:12:04 +0100")
Message-ID: <xmqq1s343chd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Sure, and if we're going to change our docs to consistently use @ at
> either side of such ranges instead of the empty string for "HEAD" I
> think that's worth discussing if the goal is to get rid of ".." for
> "diff".
>
> I'm commenting on the in-between state being more confusing to users,
> which is as far as this patch gets us.

Yuck.  Let's not spread the @ disease.  We are not Perl where being
closer to line noise is somehow considered cool.  Spell it out as
HEAD, please.
