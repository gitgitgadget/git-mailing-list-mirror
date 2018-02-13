Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0AA41F404
	for <e@80x24.org>; Tue, 13 Feb 2018 04:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933405AbeBMEjX (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 23:39:23 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:32866 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933378AbeBMEjW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 23:39:22 -0500
Received: by mail-wm0-f53.google.com with SMTP id x4so11529252wmc.0
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 20:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CTXMf4MO+cOe2MU/o11CCGePk4Q8DB9iuif9szhzClQ=;
        b=SCUksRsPNym7Ia1UqEG8IAcc/8Qk/4jFc7nVwPcVD+SkqodJnjZsXcx+Ge+xeLvZGB
         2EyopP4oR8iplW8cgIGG/bxCRThdH7raL6H857E+fcigcktyvopw+AKgc9HdsjJcGyH7
         GPc/P/g4oLDV33ZVkuI3vHZMCTvA3tu7/EYdfYaBL3mQ4Zb4v2ajT9L05BWKUF191iUk
         Rb4PQRFpIZhLQjRA1UiyHS9FYhHz035kTyx4FWOMosMm+CqQ2V5yMqkZdUqBxl1pYyTp
         hOJHA7RgpAKsw18oY+302mp3ku8J90NG014+nBMnIx31yrRAqo4zpx2Ec/9RG8Cj7dYh
         gVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CTXMf4MO+cOe2MU/o11CCGePk4Q8DB9iuif9szhzClQ=;
        b=ugFsg9niv0Qk8NCC4UfzKhz5iIbpvWKLLnWYmYUUosGKpXV85dH0zBRJuOp5bpwevs
         etFZo7x4MVRV9kZ0iUpcwZ2g+syU6Fw9DL3c74TkBlXwJurA2BOf6egG+d0QOl18gFHi
         WxR0P4EKdGhrGfiDJRlzoS4T4AGfr9Q8H+rCYVzhRlHXQ6vAfFJYerO35uE51/c24pWp
         X7NGhZNQtiWZ9yuwKfZsCsT8Ps+DWPZIt/8V7ceE8o3WZ3g8Ommfezuuu1gqYWU2CCWQ
         RHwVtqdnb9kLuFtt7BcC8ujYs7YcbtcvuCn1tK2roDyC+hsXpXWkTnhNzOQ7fk/uaxfN
         LgAw==
X-Gm-Message-State: APf1xPBy+P+0PCZ9fjpd6fqjQFuCobFQc4r7lYWeqzufqlKrVsAHXW/+
        9hUxyRZLOjFob4QC5ATplOMOVYNJYJQVB3uZy/A=
X-Google-Smtp-Source: AH8x226DujhQQTWZoZtswV9z4VLPNrG0jAPmCkdYvf+KdB7MlRvAs/Yv9qLE/yXFG01arL6WAM6y1U0aeKqmnsAHfSo=
X-Received: by 10.80.211.7 with SMTP id g7mr393445edh.76.1518496761191; Mon,
 12 Feb 2018 20:39:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.149.220 with HTTP; Mon, 12 Feb 2018 20:39:00 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1802122121230.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
 <874lmqirma.fsf@javad.com> <nycvar.QRO.7.76.6.1802102357510.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87zi4edbp3.fsf@javad.com> <nycvar.QRO.7.76.6.1802122121230.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 12 Feb 2018 20:39:00 -0800
Message-ID: <CA+P7+xqKPbwt-KeYTKadM3bHDkU3m0WiezKeVu75TyftBSEYDA@mail.gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 12:39 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Sergey,
>
> On Mon, 12 Feb 2018, Sergey Organov wrote:
>> > Have a look at https://github.com/git/git/pull/447, especially the
>> > latest commit in there which is an early version of the deprecation I
>> > intend to bring about.
>>
>> You shouldn't want a deprecation at all should you have re-used
>> --preserve-merges in the first place, and I still don't see why you
>> haven't.
>
> Keep repeating it, and it won't become truer.
>
> If you break formats, you break scripts. Git has *so* many users, there
> are very likely some who script *every* part of it.
>
> We simply cannot do that.
>
> What we can is deprecate designs which we learned on the way were not only
> incomplete from the get-go, but bad overall and hard (or impossible) to
> fix. Like --preserve-merges.
>
> Or for that matter like the design you proposed, to use --first-parent for
> --recreate-merges. Or to use --first-parent for some --recreate-merges,
> surprising users in very bad ways when it is not used (or when it is
> used). I get the impression that you still think it would be a good idea,
> even if it should be obvious that it is not.

If we consider the addition of new todo list elements as "user
breaking", then yes this change would be user-script breaking.

Since we did not originally spell out that todo-list items are subject
to enhancement by addition of operations in the future, scripts are
likely not designed to allow addition of new elements.

Thus, adding recreate-merges, and deprecating preserve-merges, seems
to me to be the correct action to take here.

One could argue that users should have expected new todo list elements
to be added in the future and thus design their scripts to cope with
such a thing. If you can convincingly argue this, then I don't
necessarily see it as a complete user breaking change to fix
preserve-merges in order to allow it to handle re-ordering properly..

I think I lean towards agreeing with Johannes, and that adding
recreate-merges and removing preserve-merges is the better solution.

Thanks,
Jake
