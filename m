Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59F431F404
	for <e@80x24.org>; Wed, 24 Jan 2018 21:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932497AbeAXVRP (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 16:17:15 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43473 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932238AbeAXVRO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 16:17:14 -0500
Received: by mail-wr0-f195.google.com with SMTP id t16so5476791wrc.10
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 13:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lN5ye3cHS8gkhZbPQN9rS6ruIr7hq9UCiU3ZQpQlXZk=;
        b=QZYpld2ez/4gQ2ZkxURqqQuY12T+xia7bG87MSA04yzzOt6Zmzulbkkc7HaVMkr01/
         XIWHkD716qWCctDx12cCOGx3UMwa6l2LfUeNhjT/dvs5f7ldZM4plh2GJ2tAqXjShHeP
         EJNKlFv5HcnQyqfFuoz6uVZ49t2010VBUd6yWnnkrZsyH7hBYh4pzgkxhQ1D35yqZ4Mb
         FCkyA6S38tSnrhgNneT1CNAIonm5z5wtM7OuuvDhqz3ufj5HaG743KHNpcVLiMYca/tF
         SvGox/0RVjm1js1ep6LHSZyMQBXzOJFqasyjAz7JCSIiTYIEKUhwu9qvc/aa+dsb6A5m
         gpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lN5ye3cHS8gkhZbPQN9rS6ruIr7hq9UCiU3ZQpQlXZk=;
        b=RNfHAbiEchsoT+ERBk4wh6NIqab6Eu86Pp8pmaM9fQfgON16kiAXabFf3OIYt2Yzy6
         DRdd7xi2p5WBJ/U16Tn38IMuiHskHg1vvcqIJHZmIT8xYCmx5MWKVc15ueAz6+YGFx8W
         fcvPYqOVdSEL6ufFVssVpZyd9vc1bvWLx/ZdB2MgTZN7/NhgA9DJiqbOg2VXIa50/05T
         s40afyymp774xKSS9R5i0Zl0QcoPUHIPEQ7LwKo9Tzs+8EcCpr3S+0Hgxjh7Wpp9ee4U
         6wYFemY+LfRKggdWby36AqcxO0Qf4hVCpGgkgzaThTYTyoOmbKLOe2r0lIhFTCQ83rSi
         cSDA==
X-Gm-Message-State: AKwxytfueVA4lN9p+Xb0nPvvvEB3PILLk++OKDIPPbQiryquio9q9i6o
        4N9IdlrwrSyECiRTfGYE4glQJ7Xu6qvm6u/d0LeUhfg2
X-Google-Smtp-Source: AH8x2267KK95FMnUQKWF+6g6XRUn/SgpDdghHEhXL9bU38K+i5nQrE4uBDISwuHyMfQmlQ3NTm0ZWdrzUU7bp5ZjJq4=
X-Received: by 10.223.195.49 with SMTP id n46mr586978wrf.191.1516828633463;
 Wed, 24 Jan 2018 13:17:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.166.115 with HTTP; Wed, 24 Jan 2018 13:17:12 -0800 (PST)
In-Reply-To: <ee5185b1-7820-b2ac-1bde-da1c761fa594@jeffhostetler.com>
References: <20180123001648.24260-1-isaachier@gmail.com> <675fa58d-bff3-d7e4-5fac-ecf1401932f4@jeffhostetler.com>
 <CAG6xkCbe+pLwTCButZGdPucHoRCq-a8mWfifd6z2bzGZNseE9A@mail.gmail.com> <ee5185b1-7820-b2ac-1bde-da1c761fa594@jeffhostetler.com>
From:   Isaac Hier <isaachier@gmail.com>
Date:   Wed, 24 Jan 2018 16:17:12 -0500
Message-ID: <CAG6xkCbT1t1X71FhHvbsX_gzx2a0hpP5Hsg59g9PMMoGJy=9CQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Implement CMake build
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CMake is very portable (see
https://open.cdash.org/index.php?project=CMake for details). About the
whole autoconf history in Git, I came across this post by Linus while
researching if anyone had done something with CMake in the git project
before:

> NO! At least the Makefile is debuggable and understandable.
>
> If we need a better build system, I'd much rather use something
> higher-level that can generate VC++ project files etc.
>
> In other words, I'd much rather see us using CMake or something like that,
> which actually adds real value-add.
>
> (And no, I've never used cmake, so maybe it has horrors waiting for us
> too, but autoconf is just worthless).
>
> Linus

https://marc.info/?l=git&m=115032515024816&w=2

On Wed, Jan 24, 2018 at 4:00 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
> On 1/24/2018 2:59 PM, Isaac Hier wrote:
>>
>> Jeff, no worries, fair enough. I know https://github.com/grpc/grpc
>> uses a shared file to generate code for several build systems instead
>> of maintaining them individually. I plan on doing the work anyway just
>> because I have my own reasons to use CMake in Git (for packaging in
>> https://github.com/ruslo/hunter is my main motive here). Whether or
>> not it is maintained upstream is not a real concern for me at the
>> moment.
>
> [...]
>>
>> I'll see how the Windows build currently works and if that makes
>> sense, maybe I'll try using that build generator here too.
>>
>> Thanks for the feedback,
>>
>> Isaac
>
>
> Look at the "vcxproj:" target in config.mak.uname (in the GfW repo).
>
> Jeff
