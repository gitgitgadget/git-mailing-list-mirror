Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AACC77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 20:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDJUwU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 16:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJUwT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 16:52:19 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6592D19AF
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1681159922; i=l.s.r@web.de;
        bh=gMkm3mAr9gN4fBf0W+QNVTE2aZO5PKY3k0SqZkjTig8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Mwj8S1Zg7Jn5Rh1F7eMNa/YjsVIzMHmzPyIh52oRvBjKyaCvV+9k1B3v9YCwCaYLF
         Y8wBM3LXCAWCCyuPJZ8XAogP3mfqxXH8X9FcmCGj4T/uzohYgYA1m7dYbNVmIJc0/a
         eWVIncdRButm7nFOHJ8H/0gk5fEhTNhm//9x4NY3PobxSa1At6KyKr0xNEWnxT1y4B
         PaMW2Z6+8+DDzBDBZJ7AINgAe6Yp+dH+nXz/askh5h9HvVPl8m68L1a5m2zpwK86s/
         EaXTqf8utwL1Cijs5lfTXLbFxKHRYCqN1ASt7h/Fe8tKDgDm3HG03g+7F9/1vfmATT
         hkmjj9cJoYAfw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.158.21]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mfc8y-1qJ6Jl4B2G-00g4eL; Mon, 10
 Apr 2023 22:52:02 +0200
Message-ID: <b17e05d5-deda-527f-1587-9f1cd7046a0b@web.de>
Date:   Mon, 10 Apr 2023 22:52:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] date: remove approxidate_relative()
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <f5b9a290-7cec-7a83-660b-e15494d2cdc8@web.de>
 <xmqqjzyjemji.fsf@gitster.g>
 <20230410202536.GE104097@coredump.intra.peff.net>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20230410202536.GE104097@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KrlN+ApJpwetPhbM3fIAf2ilfgAOSNUfytD2LRnQ9Fb6Fze8Aff
 sU/8zFgn1GBwE1ppV5khIUzkekzmLXrnhPve20HjRmeASrm/dR0RsGC68Wj+ZNt68QkNktp
 Qw5Xuf8zWgZSeNFy1ftZjhOtZuKQX4Xned0n/djXkmEChXFwzQlgimRghbOE4JQwrAbKHwg
 /I0rKLCVYtlAo8Ai3xcsQ==
UI-OutboundReport: notjunk:1;M01:P0:x85o12vktHc=;+qFKAAdLtUk8pnWrLZZ7lhQcGt7
 E5BQ+3coLbdEMNnen97Bb8OvIpGSenEZH3R1HUVMqzY55E7fKXoyncS9rPFz395nDjssmQoDM
 O1J4plifkXx4qSAAW0STlIQbNKvI7chE2ynFaQ8l8ZvJiPkStpIv/X+/xQs48Bt8cQ8IaYw4t
 i+CA4OEDoNYKHWXXk/k1vvFKSluyI3WwcLB5WnxM/fpyvhS85uwI+wDHpFmpSzlfoMUkEmYTx
 FaVFmN4L/832tFAoTZrAcUlAZmuYvNlZZpUFgqkkkZZ55nmGyo6XDh/3+Mdk8eaKa5VWJus6j
 rxbHJxaB6W9x1/v88Cibr+GRVKTXK+DxOlBA+Ha6VjUHWOXMd56uXlzeANZLiglyMl5po2nM2
 O/5Dk8T6SQgli293K4//Mt0+47Gn4+wU53pV2CYhlEsTnjNl0BfBbFoSnnP62cKHstZU88q3R
 CqcjpHaHH5+qsz1HmpIqj87jwZVQNJhdq9D3sP7AZ/IoixX1/ew18uWOadrYIU7BJY3EWmvCq
 whUib09Fl9fePPZxIJwzvtETmLQpTjvAfVKHuc9HADgr9g8aGB2gfOGA7oHjYgkEX13/zRRiI
 IqcNWqEYBbA2tuHpwDNxtimKlxqRgG5MWk9OjOKX8ua4zElNNUaFMGYaH7jde/v6lY/kto2dq
 INgbq1EKcUGOwuXTZjPL0PW99BAGt4ri2+yOH+65GkXgG49AZNNar4ODpbu4Vev4Ozs9o3ayU
 aMkk3WxGABG8Fg05VTtVpwtvrwVvxqk7rHA/XJgxX1XebjF+cq5ADPAKrAZW1pun5h1QsKI5H
 OoCESfJXu7zA+6TkLOuIjq1x+TQaAoqgt2lROok8+KqY/4ZTvJxT7votH6lEOlgt/4EY8jO+N
 l90IPow8BecAvFms0DjJM3EDMMa0Is8eWqCcYPJEfgicUgKZreu6wU0b406MZssQENckO0a+s
 aWEBjegLgFx9kO8k2yDl5NeIHE4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.04.23 um 22:25 schrieb Jeff King:
>
> I'm not sure of the least-confusing way to address a single hunk, though
> (by line number is one option, by hunk-number within the patch is
> another). I suspect the best workflow for a user would be to
> interactively say "show me more context for this hunk". Some viewers
> have support for that (e.g., GitHub's web view of a diff). But handling
> that for a one-shot CLI program is tricky, not to mention then feeding
> it back to format-patch to generate the output you want to send. :)

So basically you propose a format-patch --interactive mode that shows
each hunk and allows extending its context.  This could work.  For hunks
that span multiple screens it might be a bit iffy -- or perhaps not, if
the scrollback buffer of the terminal or console is big enough.

Ren=C3=A9
