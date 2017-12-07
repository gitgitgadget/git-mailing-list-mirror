Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D84520C33
	for <e@80x24.org>; Thu,  7 Dec 2017 00:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbdLGAiv (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 19:38:51 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:43114 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbdLGAiv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 19:38:51 -0500
Received: by mail-wm0-f50.google.com with SMTP id n138so10227541wmg.2
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 16:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cujmhyhIhcnioBTVpez3X89/gxSDXWc2GAbFd671fMM=;
        b=DeHirb5l6rG50kPWH8fi1DWRqQBwtwcTTjJi0iHwLmaxfdOKtWHrWmM7RWzS6bkPYn
         LnnLIGFH8N+K6lKcocJM0+1kLTl2rc9z1VPMEDtM9voktL5uKpnFbhBxRb5bSEM1mFDz
         okJVoMOuira17vRuhiKXRE4u1NyX224TLkgEfH0+XYNSTrY5aw52jmbU+MgjAAgJXM4a
         Z0//WIzOvZ/WfO0gY7Z6hDcrwwXIiy6Sh6XwTzXogdvRA8AJ55Yhjrmey+UIJXyyEwVH
         YCAvU0Pxm4lOnNV5eh+ORQY4mPlLu9Ay0o5ifJwue5AAe5zGbqzTZofOnMO9MRUvg69r
         4d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cujmhyhIhcnioBTVpez3X89/gxSDXWc2GAbFd671fMM=;
        b=ZL88iNDm4euX0YiWVIOXNW/UNg/hwpR7PFmap/aSRgJvjnwshUYHSikggZhlAx7Xuy
         vS1VoME7+TaiNzpRnZxm5FlpMSkW/xyDvZ8jRNWODeEzUjuSYugYznczOgL0Ov4HXyOD
         skLvhRVCn7b1ctK7FUU/GMxVHDrGV+wzZlnNEdHpH28I3KKq4TvHFhzlsNe78qd3zq5e
         tcNaNxIoWnNYHsC8Ii5L9wmVz5dgwwJkrYbiqeLIB5UG9l3b2xwvk1M6U6JKVPeALg7u
         A/veHF2gUOIe0L8lxLrsjOagBtvm/Y8rxY0QreMIhtntwhTsC9Wdl+aNz1pRyBP+27Tl
         1Qcg==
X-Gm-Message-State: AJaThX4DLgn1HuknBFPXhN8HiRuIUyKOviwY4CEiCDeTbAngUrigrvdi
        K7WUV/semfJiim/K2xYedpZ8z44LZFvcgJfG85A=
X-Google-Smtp-Source: AGs4zMZO5ncplQuPZw0zFPgjtIXpk9JxxU44lZvouN7EKMwB842zH/oVy/34kLmvUw9Ufs6nO9xqdC2jds2jMz5nVB0=
X-Received: by 10.80.137.147 with SMTP id g19mr42576451edg.293.1512607129824;
 Wed, 06 Dec 2017 16:38:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Wed, 6 Dec 2017 16:38:29 -0800 (PST)
In-Reply-To: <20171207002439.GB21003@sigill.intra.peff.net>
References: <CA+P7+xotDPa+=G5ypfyD7gySp6r2SKRAjMSw_0BmvuyyfcjxBw@mail.gmail.com>
 <CA+P7+xouqMi4xo7psM-PmpqcpKre2X1YyYZBLfMDYSSZ8tD_VQ@mail.gmail.com>
 <20171207002234.GA21003@sigill.intra.peff.net> <20171207002439.GB21003@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 6 Dec 2017 16:38:29 -0800
Message-ID: <CA+P7+xpoaa5zaF13ageKKjpPKTECU6XjaRdSZy6WOP7Q0TX+yA@mail.gmail.com>
Subject: Re: git commit file completion recently broke
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 6, 2017 at 4:24 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Dec 06, 2017 at 07:22:35PM -0500, Jeff King wrote:
>
>> On Wed, Dec 06, 2017 at 04:01:51PM -0800, Jacob Keller wrote:
>>
>> > I think I narrowed this down to "git diff-index --name-only --relative
>> > HEAD" producing a list of files *not* relative to the current
>> > directory.
>>
>> Hmm, my guess would have been something funny in the setup code
>> forgetting our original prefix.
>>
>> But nope, it looks like the culprit is f7923a5ece (diff: use
>> skip_to_optional_val(), 2017-12-04), which switched over parsing of
>> "--relative".
>
> Oh, actually, I guess I was half-right. It feeds &options->prefix as the
> "default", meaning that we overwrite it with the empty string. I don't
> think "--relative" works for the semantics of skip_to_optional_value,
> since it needs:
>
>   --relative=foo: set prefix to "foo"
>
>   --relative: leave prefix untouched
>
> -Peff

Yep, and apparently our test suite completely lacked any tests of
--relative on its own.

I've sent a patch to add some tests.

I don't know the exact best way to fix this, I guess we could just
revert it the changes to relative... but maybe we could add or modify
the semantics of skip_to_optional_val()?? What if it was changed so
that it left the value alone if no value was provided? This would
require callers to pre-set the value they want as default, but that
would solve relative's problem.

I'll look into that.

Thanks,
Jake
