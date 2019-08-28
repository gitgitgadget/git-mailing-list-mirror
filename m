Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C2A91F461
	for <e@80x24.org>; Wed, 28 Aug 2019 08:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfH1ItN (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 04:49:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33748 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfH1ItM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 04:49:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id u16so1635750wrr.0
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 01:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=++JggFXvKnlwEwWkZ9GsXasXOVg0EYBPThQl4ZNK6BQ=;
        b=ILQ3//70lXT2PPsYuN11n0fXtDAQJOHVZzXISr1427x4EB52ETN3iAUGoWfWrrCvyi
         Vk+7Bk16Un4Cbx/bQidnfzsduZBFBU6x73939YvoWcH7mlRhVrQJJvQVAEABU3/Y92r6
         sEVzEDNfsHcMC7fIjGYa05CyxU0BXTcQ/zwcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=++JggFXvKnlwEwWkZ9GsXasXOVg0EYBPThQl4ZNK6BQ=;
        b=UsTLSHail3wN0IGyqR+eMKlX/+AqLo0jyAOl/4kyrs7YuAR5yOsKYCx2m/OF7w/lt3
         Uo23CAqCVJvpjwI4ppC7I8ZT8y/SX/IGARrC6uPMv7guFUElwjVhwWgEtveNyjQZyddD
         naQySaXOntxxP4UV8fCWhc+fCa1XgQznlEGok5GTV5oF6hx5xRklwDF1HV91PLkO1Ljs
         Og3hH0gAZTYBBSOyhRMolTTVhwK5+xe2ury4FA1NoIk0vhFCxcyIYrdXj+AhWvi5aRbr
         ogd1cwZ7IytbSoi6Snkdd+IZ4vEuD8UNjyOBeMGWBbkwAG9r4qAqKWw2vPnE2YMtHnb7
         Fs9g==
X-Gm-Message-State: APjAAAVy8G4SKqclrsySonZf63vQG8JuEAb0+qugpc8w2/6S4KMOEtFR
        hfAlGf8zha3rB2RKaCDIJVcC43gJkqkZr0hlgWyeOmRVESShaw==
X-Google-Smtp-Source: APXvYqw03weVmhIX/LD07f+n/C9p8t11fFuKsQ5SzhC3+km8UGG/xabqhdv19u9JV80AU+ct9dX+c7voiUWvUj7WVNY=
X-Received: by 2002:adf:fc03:: with SMTP id i3mr3010841wrr.48.1566982150982;
 Wed, 28 Aug 2019 01:49:10 -0700 (PDT)
MIME-Version: 1.0
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 28 Aug 2019 09:49:00 +0100
Message-ID: <CAE5ih79dF7LJSp=hUgj_r2XUmWKYnU3XgSReSjOetG8Sek599A@mail.gmail.com>
Subject: git-p4, and python2 EOL
To:     Git Users <git@vger.kernel.org>
Cc:     Andrey Mazo <amazo@checkvideo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Peter Osterlund <peterosterlund2@gmail.com>,
        Andrey <ahippo@yandex.ru>, cclauss@me.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We're coming up on when Python2 is end-of-lifed - we have until
January 1st 2020.

git-p4 uses python2, and doesn't work under python3 at all.

The problem is the conversions between Python3 unicode strings and git
(utf-8) and p4 (utf-8, except when it isn't).

I had a go at fixing this here:

https://github.com/luked99/git/commits/git-p4-python3-final-showdown

You can see from the comments that I wasn't really finding it straightforward.

I think I know a bit more about the problem now, but before I start
having another go at fixing this, I wondered if anyone else had any
thoughts on this, or even better, some time to spend on this.

Thanks
Luke
