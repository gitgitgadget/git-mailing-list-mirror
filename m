Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 104BC1F576
	for <e@80x24.org>; Sat, 10 Feb 2018 11:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751009AbeBJLV1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 06:21:27 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44957 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeBJLV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 06:21:27 -0500
Received: by mail-ot0-f194.google.com with SMTP id l5so10111130otj.11
        for <git@vger.kernel.org>; Sat, 10 Feb 2018 03:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5fUo7UIiGvQFgykhwxQjUV+Mk2j4DUYQe5RqSZ4A/wI=;
        b=ubocu+0aWGNfhuzzy4H2FWYzeg0IPoRrB8uCJcot3EGA7MAXApLOSAjWY1V+FSCKdY
         nGXd1N03nRn56OBX4Xf9muxoz+kRAOAkcpO5sHNfx9D40epolRPnotb75Fdjjm5jvzaL
         PYZ5f7agByojoCgyzHkVsApZYYbMc2BZNNJ0ZRg9QYRrE++JFH7c5R+6UBYY2HALAFSW
         7HwRXeqgCzesC538FYUrI6ezTDChK2U+44PvV6AH5bz9r0+wfR6zT2QbNb96g4E7R9iV
         iLk/9JUoCqM6npXRnAvwxC7PF0GUuvlnv+b3ITRHMNR9auYXMmzTNIjmueZMh1ZMAX5f
         cnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5fUo7UIiGvQFgykhwxQjUV+Mk2j4DUYQe5RqSZ4A/wI=;
        b=gh7aIWTAQuUamfmMz+5RcvAzY2OwPiyDGy7LNYkuwH6IeV0qsiuMWzUGP7iK+QDpQz
         CvxshmMmlZtMqP86vVfHKdG8ehvVzg6gNcWpHziup5acLLKdEGxJW4j1GmTGRmlfjb+0
         +Kz0MoFE2n6MzKbFmuWQCGgGYFUvpNfQC9sBQ2MZRObwff9ZA5of2IfYh53WRDbRticr
         Ho3NFBPsikJ+eyh9nqH0g3wBhlQ1IVOK5i8ikBHTlPN2mJzf+65pZvWa/NB30If7ffgy
         tXo9UqqwokCcy3LMwDMWNXyIRzumOEWnZcE7r3HKAxS0X3tQh6txrYIp/jNdB0W6vltn
         j1+Q==
X-Gm-Message-State: APf1xPBWjLgcMSWFbLyvnrWLV8tcFe7DTNYHvTqK8wxGtQ5s70RDHB8O
        OemVhpBaQJUPEZwfsnMhMJeR11iQPQqXeGu7nE/vww==
X-Google-Smtp-Source: AH8x226PKf3EKhZ1B6xkRQKAMOKLtcql7VQPY9rLPy6obXcC2KZj+V/zkypvmiGULbmWd5fFjCYzd2cVekLTcwxt4QY=
X-Received: by 10.157.31.47 with SMTP id x44mr4709984otd.165.1518261686505;
 Sat, 10 Feb 2018 03:21:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Sat, 10 Feb 2018 03:20:56 -0800 (PST)
In-Reply-To: <CACsJy8Dp1j5GJtHGowK+Vk4KBBUtqOkTfx3U0PNN9DmKO1e-mA@mail.gmail.com>
References: <20180121120208.12760-1-t.gummerer@gmail.com> <20180204221305.28300-1-t.gummerer@gmail.com>
 <20180204221305.28300-2-t.gummerer@gmail.com> <20180205021202.GA17847@duynguyen.dek-tpc.internal>
 <CAPig+cRLohiqR_Drh7P0q3XbvC22WLjNwH0YLZo3dqFzZZuAPw@mail.gmail.com>
 <20180209112727.GG2130@hank> <CACsJy8Dp1j5GJtHGowK+Vk4KBBUtqOkTfx3U0PNN9DmKO1e-mA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 10 Feb 2018 18:20:56 +0700
Message-ID: <CACsJy8BOvU_z-uLrFmzFyryMXHNDfc_FUN_4i4NnVXWoShaBLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] worktree: improve message when creating a new worktree
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 9, 2018 at 7:08 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Feb 9, 2018 at 6:27 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> This would loose the information about the identifier of the worktree,
>> but from a coarse look at the man page it doesn't seem like we
>> advertise that widely
>>
>> ...
>>
>> So given that maybe it would even be better to hide the part about the
>> identifier, as it seems more like an implementation detail than
>> relevant to the end user?
>
> Exactly. I'd rather hide it. I haven't found any good reason that a
> user needs to know these IDs unless they poke into $GIT_DIR/worktrees,
> but they should not need to.

Just FYI. I mentioned elsewhere [1] the possibility of a new extended
ref syntax to refer to e.g. HEAD from a different worktree. Such
syntax may make use of this id (which also means we might need to give
the user control over these ids and not just always auto generate
them).

But that's for the future. If/When that thing comes, we can worry
about displaying id here then. For now I still think it's ok to hide
it.

[1] https://public-inbox.org/git/20180210095952.GA9035@ash/T/#u
-- 
Duy
