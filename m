Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75C1E1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 17:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbeILWvm (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 18:51:42 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:43505 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbeILWvm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 18:51:42 -0400
Received: by mail-ed1-f52.google.com with SMTP id z27-v6so2443805edb.10
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 10:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rDzPNEsv2tqbeyPpKhrKZ6hW10fPCx0jxypcI+6Si60=;
        b=Y1sUjLv42En+A/QGCIzjUU4yBIGd8MElzpwRGrzpn4eHfkKlz4H7hbOzJ9DNXswfZz
         Am6JMxzsvmlHTRIgFSErtT4ZgVqZ9wWxhJUgKl3r1949nCrfnqc0bM5nHMlSaNdKO2YQ
         83ACVsf88zHDj7JnWDX0AZHoe0pppx5Peu/YaepPr7XUxhNphK81rJaNGv+8HYn8Yc8X
         xQQnZAkReC5m2XCOSsqmyc3qUFTKdOP4lB2CjCpN5bPRhgWkoy90BnTXyWK9I/h5/m//
         BRAwnsV56Eyb6mVssRCK1A7Wqfbig5hdMxgZbmNlCgeUi82JbUl+uYMyRM9tw6ZGHJim
         JAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=rDzPNEsv2tqbeyPpKhrKZ6hW10fPCx0jxypcI+6Si60=;
        b=Fs304OZuMg2uWatihY9aFooPmXsh+5OZGKryI7IedY/ey62ch+mjjPUhMDhFany7sH
         tRdNLIzKyvAUWlWO1s1jpIyMZaaOcrmORXSbNS2HAwmfB7gkf97mBpzmRHgUzWy5PqWI
         1P2ve77UdnTGbHVmS53E0TRZDx1FvrJm97YyJu7l3aKUAdZ0zNLj7iB2BwYRdodCprel
         4XYpdv3Bt5R/JIdvSmQCMspoLcNvSj17NVPBzNI5mBsMcfISxvBz4Qjtj8jE6N78Rrd7
         qwTVWUtRobpOliwQhly+8LEBXEZ6+kyYKxakYuOqCPpp3b+YLn04Q/4CGdC/gRJb7TPb
         zwYA==
X-Gm-Message-State: APzg51Bg+ra01lAeD1cEU3esxQxJQoI/CssE6jaMONzMOKpikltw8WUI
        dObde9WIPyGp+E5SKl5e4EI=
X-Google-Smtp-Source: ANB0VdZMX+SB5LjTcNJRUe58QVfUJKZzF3PDoqk3qgt3DTKCPPNKLEbKzoyLIUH9faujFASOI8/Fvw==
X-Received: by 2002:a50:d307:: with SMTP id g7-v6mr4173722edh.221.1536774365191;
        Wed, 12 Sep 2018 10:46:05 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id f26-v6sm811441edb.28.2018.09.12.10.46.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 10:46:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: What's cooking in git.git (Sep 2018, #02; Tue, 11)
References: <xmqqsh2fn0bg.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqsh2fn0bg.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 12 Sep 2018 19:46:03 +0200
Message-ID: <87musmlick.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 11 2018, Junio C Hamano wrote:

> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.

Can you please pick up v5 of the patches René & I had for various fsck
skipList improvements, at:
https://public-inbox.org/git/20180903144928.30691-1-avarab@gmail.com/

Looks like v5 is ready be picked up, and might have fallen through the
cracks during the release period.
