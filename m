Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 856D52095B
	for <e@80x24.org>; Sat, 18 Mar 2017 20:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbdCRUCj (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 16:02:39 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:37259 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbdCRUCi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 16:02:38 -0400
Received: by mail-it0-f45.google.com with SMTP id g138so60171396itb.0
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 13:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VJJB80TFF71Md7zE36GoDByGNq2OT3WeQ7cg4SoSdPk=;
        b=GbjDwAOND7PGfw6wcKGBxGQat2h6FzTbKbQlicT4v3pHykW15jhl48AoNJPVGha4hB
         d5OL6ouxd3UxXCS8xvUjKesV2leMyKPhvXPq5hNtpOoAqeeDJbo4H028ZKyAWGBuibnx
         TiVXj0/ls/zKVy/eDhvE++f1WKsPEAsKFc6uTS9dFtrZCq8ZWd1s5kPzEm++68dC4c0B
         BrqfGMEn3RKdEhgWA0+8Di5PdNpDaMJEMupBe1pOn21sT7Cb/z/GyYcZ1rfgcbcjm0+D
         /p1AZUEn2opvVQetVjy64L6hMamn89hESR2oqCUuha4Nx/AxVnj/C7pevcatg9DLLwY+
         klQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VJJB80TFF71Md7zE36GoDByGNq2OT3WeQ7cg4SoSdPk=;
        b=KydtmqCw+Jm6jcEIGAokkVx0b55DbITZg9TIVW1DfM3ahT5CdK43JNpgzJwl333lNU
         KY+0mlf5/TAVojnV/kSw5N+aSTpJRJWmzRm7kAxUBwz2z4PWlwrwM5fWnrvHtvoZqQuI
         jCa5TBv9UcyK/gbBaajeVRjKxrHLibu9irwW24ZJwTNzh9QShC3yvhMeh+kUj6jtRu2T
         TqDM/9uxLjQEwXYDjEN9phnJdhwp/7tDNV5G9cBwoUel76ZPkzfp3XpPXOVbBYMv4mTc
         UyQNyqPosABLIz4/599qSFLXiU2TfmLRTRlujcafak+hRQUUtO2DBKccaXEh0IR0JfNC
         RXFA==
X-Gm-Message-State: AFeK/H1ltRLQ/ZHsDA3yvZYN5YKqBk8HvaKIrB/iAFKydIk3mDJwxVntR/v1Yp0Q0ISSTT8oafXfttO6CjG/vQ==
X-Received: by 10.36.224.195 with SMTP id c186mr4188456ith.24.1489867270948;
 Sat, 18 Mar 2017 13:01:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 18 Mar 2017 13:00:50 -0700 (PDT)
In-Reply-To: <xmqqo9wy1j3s.fsf@gitster.mtv.corp.google.com>
References: <20170318103256.27141-1-avarab@gmail.com> <20170318103256.27141-3-avarab@gmail.com>
 <xmqqr31u301u.fsf@gitster.mtv.corp.google.com> <CACBZZX4Zs=00QXv5eaafQd8-n7OakcL3WeQh8XxiMo-9a+kAzQ@mail.gmail.com>
 <xmqqo9wy1j3s.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 18 Mar 2017 21:00:50 +0100
Message-ID: <CACBZZX7G+fj+Fr1ex-vAD47yzvpJXma5YDMBrMoffr_KWFFx7w@mail.gmail.com>
Subject: Re: [PATCH 2/8] tag: Refactor the options handling code to be less bizarro
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 8:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> But I thought it was very a very bizarre pattern to set us to cmdmode
>> =3D 'l' when we're not in that mode at all just to, as can be seen in
>> the diff, get around a slightly more verbose one-time if-check.
>
> When I wrote my response, I viewed that setting as committing to be
> in the "list" mode, not as a workaround.  So checking with !cmdmode
> to make sure that the command line is not asking to create a tag
> makes tons of sense; the new test makes it unreadable from that
> point of view.

Makes sense. Looking at this more carefully there's never any cases
where `create_tag_object && cmdmode =3D=3D 'l'` is true once we make it
past `usage_with_options`, which was the bug I introduced locally
which made this whole thing a bit confusing for me.

I'll drop this patch from v2.
