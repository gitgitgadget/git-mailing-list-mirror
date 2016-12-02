Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A8011FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 18:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753657AbcLBSob (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 13:44:31 -0500
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33643 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753548AbcLBSoa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 13:44:30 -0500
Received: by mail-yb0-f194.google.com with SMTP id v78so5386215ybe.0
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 10:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=flwc8wQ1f8Fk9c1Uf15mjtFU7EFEEbx8eJDsEsy4a00=;
        b=BdutaclWd0MTLgeCIO/KI10JCJHo67Eo6wMYVbyUKorLuKSxEURIa1yzsTdF44X+Zg
         MuLY7tcXgY5CxlkGxMBMuBrtif7vp1HCr3Qe7WW28M0KQpxihoOfs2kI4gjCnHT6KaRQ
         tQLWXIjznvR74yTLMTiu+LnLtsCRIzRJtYrDj/jt0V/jfux3g5UdiHDfIUUUoxr7k90P
         CN2wE+76S11hh0oPAw+vwj5sVrzIdS6rZ4hiw96vTHJW6OmNqtb8CMT79Xv0ojK+SyVn
         WA5D11jHWO8okYHjy1RCgK7LS6OnR1np0OFxqyMogV2E6K5rxLrV9DNIDv+dCYMqE69f
         G8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=flwc8wQ1f8Fk9c1Uf15mjtFU7EFEEbx8eJDsEsy4a00=;
        b=c1myxBcd7A5zwbdn19as1n6E9e0pdWxYoHzSnIUZvyvJtTvT/tZImzLv9aBSyZOsMe
         hKYNVl10hHgxftJ9y8NaC5VhpjjcrK4KPcqfjMESJJsMIRNSyf6kItShdHfVs+Bn/Ipy
         z2wjTgDiVki+UJNucCG83pyuHYyb4s2yYpqCFhI4si6rvHydPjJcZCVrXq0antYeaFnm
         Xih4CiAe5/6tmSbRXM+uR2q/q6wZn7KAPH1gP658+7BsUpqA0WfcG9i+f5nHLCAeOsuk
         QsSh1NHr0b5esftQ4dCOv/8BrnXmaTkUvkTCdUziPGj5cdoKbNxseXMIxIU9hBCsiqI3
         X7bw==
X-Gm-Message-State: AKaTC03yAywaJz4tS99fGdlN/NfQ7PkVwclYPyedmuh7VIjNV7d0Jp2WGWU7rbQwJo/+A3ASIhGoL4n43E7Vvg==
X-Received: by 10.37.53.197 with SMTP id c188mr19616526yba.57.1480704265705;
 Fri, 02 Dec 2016 10:44:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.118.87 with HTTP; Fri, 2 Dec 2016 10:44:05 -0800 (PST)
In-Reply-To: <20161202183622.GB117792@google.com>
References: <1480555714-186183-1-git-send-email-bmwill@google.com>
 <1480555714-186183-2-git-send-email-bmwill@google.com> <20161201042926.mr2qdta7hviizcya@sigill.intra.peff.net>
 <xmqqwpfja3nk.fsf@gitster.mtv.corp.google.com> <20161201190925.xi2z7vauxyf3yxyc@sigill.intra.peff.net>
 <20161201191603.GB54082@google.com> <20161201205444.GG54082@google.com>
 <20161201205944.2py2ijranq4g2wap@sigill.intra.peff.net> <CAGZ79kaqzssfN_bRQYpqC9HsKmyQZNCQcs+T5ke95Sf-C5PaRQ@mail.gmail.com>
 <20161201215934.g7dt5ioekmx6ssii@sigill.intra.peff.net> <20161202183622.GB117792@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 2 Dec 2016 10:44:05 -0800
Message-ID: <CA+P7+xpoO=ieRyQb8r8Xz12nN10f53LKeVMgAO8XPdSwvG7fuA@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] submodules: add helper functions to determine
 presence of submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 2, 2016 at 10:36 AM, Brandon Williams <bmwill@google.com> wrote:
> On 12/01, Jeff King wrote:
>> On Thu, Dec 01, 2016 at 01:56:32PM -0800, Stefan Beller wrote:
>>
>> > > Bleh. Looks like it happens as part of the recently-added
>> > > get_common_dir(). I'm not sure if that is ever relevant for submodules,
>> > > but I guess in theory you could have a submodule clone that is part of a
>> > > worktree?
>> >
>> > Sure we can, for a test that we don't have that, see the embedgitdirs series. ;)
>> >
>> > For now each submodule has its own complete git dir, but the vision
>> > would be to have a common git dir for submodules in the common
>> > superprojects git dir as well, such that objects are shared actually. :)
>>
>> Fair enough. Given that it seems to behave OK even in error cases, the
>> simple stat() test may be the best option, then. I do think we should
>> consider adding a few test cases to make sure it continues to behave in
>> the error cases (just because we are relying partially on what git's
>> setup code happens to do currently, and we'd want to protect ourselves
>> against regressions).
>
> For the naive (ie me), is there a reason why real_path() couldn't be
> re-implemented to avoid using chdir?  I tried looking into the history of
> the function but couldn't find anything explaining why it was done that
> way.  I assume it has to do with symlinks, but I thought there was a
> syscall (readlink?) that could do the resolution.
>
> --
> Brandon Williams

The reason as far as I understand it, is that it uses chdir() to
guarantee that it follows symlinks correctly and then looks up the
resulting path after the chdir(). I do not think there is a syscall
that actually correctly works like real_path() does. You *could*
re-write real_path() to do the symlink lookups itself, but as Jeff
recently pointed out, that way lies madness.

Thanks,
Jake
