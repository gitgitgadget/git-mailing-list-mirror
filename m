Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D51DA202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbdGMRbB (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:31:01 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33408 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdGMRbA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:31:00 -0400
Received: by mail-pf0-f177.google.com with SMTP id e7so32702488pfk.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2LdS2mj+wkjLdw/kkSLNzzQROvDzV7MXz8IsIoMmT8Y=;
        b=M3q+9Q6K54LYYmgnZCZaa908vjt/oWRiY+20ZXmyjKw+1Mb0WCT8NPdyI0Rde3Pjqf
         Rsz9PHwA4R5PRXLkuY+lO+eh2zYVRcer8r1nohtINMiwbe8c0cNK849VTtg8eXIt9e0O
         mcYS78UMFFkcaDGxQKzT3su6S2ZWCBSVQqNciYtsy9RWIQqzSQqe19p3gJIXlOGst2PW
         7Z6uQggitvM1S39GDz0HoTrvPWcj+vU3xIuiPULOBm3lrz2j3ZgTB6fZGNe9lazSSkMr
         NOzGVOk9LgGKIqzXNsNQNsOkABadltff2RKeb21GK4vQ1zqBYbEjE30/cr1viG0Ke3Nc
         9oRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2LdS2mj+wkjLdw/kkSLNzzQROvDzV7MXz8IsIoMmT8Y=;
        b=FYQoCm5mp7+tMNox6SmUpyB7dwJzgXDYiBCWN0xKsEorT3XbYzFn8F5IufngC9sq71
         qu5v/71EwM3j/F/lXr85fbShGB3+RAs2GnK0T+G1j4dByMiWMoAodQnlonygZNfFYyhl
         EkMN3fHDXgYsH6bjsv1JO9Hxr14W+Vx2ibf5ITn5yQz3rtgFKHucg2yCUeR+/v1QDvgn
         ZO1T6+rIAfNsYAG+sf4RtimvL2YJFUZFuSARJ+pZLuv4Iwqvk0StFehLTH2zc8GKzhJM
         ICIs1Ii7FfS+VM8tAoD5fZcAHEgwNO5VCkLw17Nc2aWs96iwIoTVzfhcLPrjkTIkD9Jo
         sCOg==
X-Gm-Message-State: AIVw112ppflrm9G4GGYvfE1HDsqKSQWAHkzqWeGtGelBk6swPNhQUQkt
        8j+1RE2LvB6gWolZrLJf4IOJOMqrn6sy
X-Received: by 10.98.224.11 with SMTP id f11mr742165pfh.118.1499967060006;
 Thu, 13 Jul 2017 10:31:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Thu, 13 Jul 2017 10:30:59 -0700 (PDT)
In-Reply-To: <20170713155923.a2nissoyczvewoh3@sigill.intra.peff.net>
References: <20170711233827.23486-1-sbeller@google.com> <xmqqinix1j29.fsf@gitster.mtv.corp.google.com>
 <20170712205734.h77fgbbkavwpkr4h@sigill.intra.peff.net> <CAGZ79kYYg6-UMrKRPeJTbHdGR0juZ2OwFZmkuYgeYe5X+cm_sQ@mail.gmail.com>
 <20170713155923.a2nissoyczvewoh3@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Jul 2017 10:30:59 -0700
Message-ID: <CAGZ79kbgypimtWE32SnDrG-QWT6gF3WGxR5mi785F_rwvRPOuA@mail.gmail.com>
Subject: Re: [PATCH] RFC: Introduce '.gitorderfile'
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 8:59 AM, Jeff King <peff@peff.net> wrote:
>> This triggers two reactions for me:
>>
>> (a) We should totally do that.
>
>> (b) It's a rabbit hole to go down.
>
> And yes, I had both of those reactions, too. We've had the
> "project-level .gitconfig" discussion many times over the years. And it
> generally comes back to "you can ship a snippet of config and then give
> people a script which adds it to their repo".

I see this "project-level .gitconfig" via the .gitmodules file.
See GITMODULES(5), anything except submodule.<name>.path is
just project-level .gitconfig, so in that sense we already threw out the
baby with the bathwater. I think we want to be extra careful to not add
more possible options into the .gitmodules file, now that we established
a strong stance on not shipping a project-level .gitconfig.

Thanks,
Stefan
