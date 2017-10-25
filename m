Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E61B203F2
	for <e@80x24.org>; Wed, 25 Oct 2017 18:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932284AbdJYSre (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 14:47:34 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:49546 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932275AbdJYSre (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 14:47:34 -0400
Received: by mail-qt0-f174.google.com with SMTP id k31so1314264qta.6
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 11:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5I5YTumClQlEgA4ulHJC+JwzlbbUlSRRkhU8B9/RYZw=;
        b=Vvc/tby8gk9bJI0jyXLa28bP86rxdEaJiOSQHFXJypuu9ipiuYUKFtigZUjJLPfrQ7
         dZSHc3Vpp/4cbbSmrkm2PwM9UWns+zHMKglthVLtq4USetV9jcEmatmaoakHAd+aryQg
         b/BfyhCC+w3lEmWkUv0CoE+4bI3j77STupdFJVNe7v4dIbNkfhLRS2890bVrDpx8Vq5o
         wACRRaX2UK/55WNnIzM85sCZWH47HUEX9lwfORl/PCy2KXY+i/FpiR5HimOh5uOWYvBJ
         Dj4zeqeYHaIdPbc88UYQVNn9WdstcvQhpTpihcXiFLRmoKjBXAJSabPlYkOS8eIvMnBk
         OxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5I5YTumClQlEgA4ulHJC+JwzlbbUlSRRkhU8B9/RYZw=;
        b=NeAf/HCFZdHPw3bHkM5JER/w4T5fAOs3gK0GYiAcNGDkyxdbET6qLdVBsP/hii2Jmq
         iWT5nQJ9pnnvsCshTTUUYSF2X/37Ex1XR5tNJZdVlXrC747N674A4wzyxd/OHN+w2QHl
         v3woEg2aC1lP2c13UPUaIszYLRMjWE0OtCTTAqM7W9wxvtn5TCZQvx+m+lIz2IiEnGMf
         bsIvGkmJptotRu7RH+G5znt2Si0NKfjyCSKF6llQIn7Do8yJ8xZ1mGKDX8Qx9+j2WGGV
         nKO8/qBIHzIgDlSxESmhfyYEDiFNj4vyObiCe5rC/nRF34Grz9swAq95ZYgSYvZcwhZX
         Gndw==
X-Gm-Message-State: AMCzsaV5EQBnyflLC8LS48mhcG6iBa+7mwGjDzAp6SVZXSob67U+oOOb
        j+zRHYOX4rQyuqGeh+5ZHcPA/d+60zX0j/KgqcViqw==
X-Google-Smtp-Source: ABhQp+QiBmEqlCKIaCqEDYm3Bvs9vr2qS168sJFu2jVjGFAGO4AZu6JY3TRCOx4br/y2lSBMQ0aQ1IZXSTU1aN5CVL0=
X-Received: by 10.200.40.146 with SMTP id i18mr31822993qti.79.1508957253105;
 Wed, 25 Oct 2017 11:47:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 25 Oct 2017 11:47:32 -0700 (PDT)
In-Reply-To: <xmqqinf3izgm.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kZftQoP-Ht+VRakCZsQxh1tjfu=4DFJn_R6fiKD2MmzMA@mail.gmail.com>
 <20171024234234.10944-1-sbeller@google.com> <xmqqinf3izgm.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 25 Oct 2017 11:47:32 -0700
Message-ID: <CAGZ79kYUMv2GhSqhsUxgagoYFObwt+3wiD0oN-uEf-HpnPV7OA@mail.gmail.com>
Subject: Re: [PATCHv2 0/2] (x)diff cleanup: remove duplicate code
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 10:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> v2:
>> * I realized that we don't have to change the hashing function of xdiff;
>>   we can rather change the hashing function for the move detection,
>>   which is less fundamental.
>>   (That way I can shrink the series down to 2 patches)
>> * commented and renamed function parameters in the exposed xdiff functions.
>> * applies on top of jk/diff-color-moved-fix.
>
> Yes, by reusing the line hashing and comparison from xdiff/ we can
> ensure that we will use consistent comparison function, and the
> thing we need to focus on will become how correctly the caller uses
> the xdiff interface.  This looks much better than the previous one.
>
> Eric's comment on the function parameters is right.  We keep them in
> sync with the naming convention of xdiff/ as long as they are still
> part of xdiff layer, and the convention there is that the lines
> being compared are l1[] and l2[] whose lengths are s1 and s2, if I
> am not mistaken (well, I am not, as I just touched the function
> there during my lunch break ;-).
>

Yes, I am torn on the naming as Rene commented on it and did not like
the (l1, s1) and rather would see a (a, alen) / (b, blen) approach.
And I thought that was a good idea initially as that patch is explicitly about
exposing the internals of xdiff to the world. So when the world copes better
with (a, alen), then the function added in xdiff-interface.c should take that
parameter as to not confuse the outside world. And one could argue
that xdiff-interface is not part of the xdiff layer any more as that is the
glue-gap to the rest of Git.

However I agree that we may want to keep l1[], s1 at that place, as the
rest of the xdiff interface looks like it is kept in line with xdiff.

Thanks,
Stefan
