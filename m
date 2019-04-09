Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B08C20248
	for <e@80x24.org>; Tue,  9 Apr 2019 15:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfDIPIu (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 11:08:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51004 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIPIt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 11:08:49 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so4046454wmi.0
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aB9kCLw3zmoWEv56WXNuDOhazDIG+C5/uBDGCq67P/M=;
        b=qa7AZu/oGywAt611lLIQFmCgcGqIaZ/MmWEUNbfKVCtJhWqshlIlIitfYH67YBJ0lZ
         FSTEiBfOx3y/eJ0T1cjcW4KZqxmyZUFNb03RnAy1kFo4f0pJo/IYvLpvp3+yH0tsYvtW
         NvyEkxfTALzoUgJY5v9EBIxKO/QHlBpFY6m4xmSuqU2w/XoxJx3qgUj+xsP9nSwI+2B0
         PDbwxEopmJXtr/Zp/3L2CQeI5vP2MC9R5fJY//Az2IlGaldaRlz+rvrk2F+cFAdAbV5n
         jueyTT5QryRPK3g8LS011RhqXjRkqvLAq045DTtTtLrR8M15mcNDVc5sv2jHmL6pKBDl
         +g4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aB9kCLw3zmoWEv56WXNuDOhazDIG+C5/uBDGCq67P/M=;
        b=Ov6sJYcFlb+GSnbcmsy6hVWdoxY6oz0B5ma/K3/zF4dfV1OGwXC2f2iBBueiGe788p
         sLy9cBrBLxLjTuGVlseK94caUSrWKc292evkUzadUA8GQ2xyrQZ2+HEK2qyxyzSZsXlt
         +TGlMsU+IyQ85+WsV8nCtfiwgrIqeAqdQItqG2h0vuL0px2sVH8qk4kYGe6Xxt499Nzx
         dMKHVpCZ6/lcjJLFV2r2iWcy1XSONBjPNxMYwd3YbFC8KajnwcnbSHrcmqQitqzUmlNH
         2zbsApRAAD/Z3S19sJQycGCRAuXsDBtw9NZ9TCB3ktv1QD34myu5x74AJ2Rw7K411jkC
         7lrQ==
X-Gm-Message-State: APjAAAXl2kYE9nFFAoZ0QIE+o1SzFMdkIzZAfUHyeqsJPtn82slnurhZ
        pQXeSh4RSoZg9MV7QB6MC/U=
X-Google-Smtp-Source: APXvYqwTAFTv1cb+DTf9UKXO8ulhUu/dd8O09Dlzbwodn+uNxnNWKrzrD/2crKh75RtUaSc2FsK1VA==
X-Received: by 2002:a05:600c:2294:: with SMTP id 20mr1461365wmf.56.1554822527897;
        Tue, 09 Apr 2019 08:08:47 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w18sm49706677wru.24.2019.04.09.08.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 08:08:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?Q?G=C3=A1b?= =?utf-8?Q?or?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 01/13] packfile.h: drop extern from function declarations
References: <20190405180306.GA21113@sigill.intra.peff.net>
        <20190405180340.GA32243@sigill.intra.peff.net>
        <c21b923f-54aa-defa-ecfd-11ecd6f8a664@ramsayjones.plus.com>
        <20190405192534.GA4496@sigill.intra.peff.net>
Date:   Wed, 10 Apr 2019 00:08:45 +0900
In-Reply-To: <20190405192534.GA4496@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 5 Apr 2019 15:25:35 -0400")
Message-ID: <xmqqsgur43nm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Apr 05, 2019 at 08:19:30PM +0100, Ramsay Jones wrote:
>
>> >  /* global flag to enable extra checks when accessing packed objects */
>> > -extern int do_check_packed_object_crc;
>> > +int do_check_packed_object_crc;
>> 
>> ... removing this 'extern' on an int variable sends 'sparse'
>> into a frenzy of warnings! :-D
>> 
>> [You didn't use a global s/extern// by any chance?]
>
> Oh my. I did look at each one, but probably via replace-and-confirm in
> vim. I don't know how I managed to botch that one so badly.

In any case, I think I have a correct SQUASH??? immediately on top
of this step queued.  If there is nothing else needed, I think we
are ready to squash that in and merge the whole thing to 'next'.

