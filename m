Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA21B20193
	for <e@80x24.org>; Wed, 26 Oct 2016 09:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757876AbcJZJ0R (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 05:26:17 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:37105 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757850AbcJZJ0P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 05:26:15 -0400
Received: by mail-it0-f68.google.com with SMTP id q124so556240itd.4
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 02:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C+fbUd5IOPx/NM4+IVj1diV/rjXzlNZJhee/1KEzrlI=;
        b=XfXfmVMAbPdp0OyWWXUPn61Zz3Pr05stuH5WYUMFhPHonNbqdvT2y1k4q9fzNNXzlX
         3XdZ8chFwARWUO1wQN0jQhHwEY9JHXZNCVQH0+4et8RX14gqJbKfwClOZR7nEIw9LlHK
         r59n/sGJ3rjP/AZKQMKb1pGYsU4ZzSpXU3rwwfs46oYsm6eYXC3/y/Pg7YBES4yKRQsT
         59+xJ3GQ9rJ0f+q7s8zaNsBqNcTg3sxxJjiO4orWhDDNZHzh6gPDhbNWQnGTigT2iElx
         MiSnq0YglYBW/SImnPhmrN23oaTwYdfp+gIyvx0Z8Gls4naryQtLKsSVt5NeIS/1JUwS
         CN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C+fbUd5IOPx/NM4+IVj1diV/rjXzlNZJhee/1KEzrlI=;
        b=WFRTHGAgWbCwh02xg0ucmXvyZFH92A3Qf/nTGg6N/9XNpENpNx+gTzSlxlgmp/p006
         IHrfvX/wDdp+fjuUNw3sdr81CXyFeqrAO+ptUV/MJoo0XowZoKo+f3gr2CDo33qeMyqC
         SDhk1TwDK8nrGSVhvlQHY2QPictseFE73FsqyeSrKNfxdPYc6/bc/Vtc7KTM1983EYcY
         r4LFb9Ti/ULZ2Ek421G5UVkyDD6vcsOq7prZrkvTPY6naj3TfmSxGUxok4Y+anwl609U
         mxt18P0i8752fMif35ZLbOdAO8k1RbA9i7+kq3KeLGLPdLiN8MUNzSgBGthtL58dTHp6
         fdpA==
X-Gm-Message-State: ABUngvfXhZN1Fgl0ChgZUOjSyWhEts4y76c63SaJx+5RXiJxob9DkQRD7KYyNcXZFCtcapyqG8mFTGdpy7Kp8w==
X-Received: by 10.36.206.71 with SMTP id v68mr1375589itg.50.1477473974748;
 Wed, 26 Oct 2016 02:26:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Wed, 26 Oct 2016 02:25:44 -0700 (PDT)
In-Reply-To: <xmqqk2cws5t6.fsf@gitster.mtv.corp.google.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <xmqq8ttd7h8g.fsf@gitster.mtv.corp.google.com> <CACsJy8BBwWRGSyJDYQ7THj7quu4=T1xT_-KojQd45Vye4Kgcng@mail.gmail.com>
 <xmqqk2cws5t6.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 26 Oct 2016 16:25:44 +0700
Message-ID: <CACsJy8Ba0BY=pZwrKf5rcD5AaZ3YyKh9=ENKkj7hHpTqh00OnA@mail.gmail.com>
Subject: Re: [PATCH v1 00/19] Add configuration options for split-index
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 12:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Timestamps allow us to say, ok this base index file has not been read
>> by anybody for N+ hours (or better, days), it's most likely not
>> referenced by any temporary index files (including
>> $GIT_DIR/index.lock) anymore because those files, by the definition of
>> "temporary", must be gone by now....
>
> and if we guessed wrong, users will have a "temporary index" that
> they meant to keep for longer term that is now broken here.  I am
> not sure if that risk is worth taking.

Even if we ignore user index files (by forcing them all to be stored
in one piece), there is a problem with the special temporary file
index.lock, which must use split-index because it will become the new
index. Handling race conditions could be tricky with ref counting.
Timestamps help in this regard.
-- 
Duy
