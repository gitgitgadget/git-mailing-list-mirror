Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FD7220193
	for <e@80x24.org>; Thu, 27 Oct 2016 17:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936338AbcJ0RBF (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 13:01:05 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36771 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933213AbcJ0RBD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 13:01:03 -0400
Received: by mail-qk0-f182.google.com with SMTP id o68so54546910qkf.3
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 10:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VM3XcfxYrLnx+Hqo7IKRwyP9OAHUoTn2NHKGw40fhK8=;
        b=EJJu4Z9MQ/IusuBminRNwYIMzOizt5yk6mC+s3YQI0XKmFwpbvuuWWYB9cWKhyV7nH
         OzTPCBekMVciF8gLNE71S7wC5KGFV8cmBwpvsyoz+/kagF/DRc2LKbX9aUZtB7AAaZCi
         jJEGtRK+i2hFw6+NVsjqeH4jKNGfMKdtgXXnjVLs9p45XBxk/Dy6hmxjotEU+k7pUTuk
         R0FLJ25Ih9XWJwmfU+nl6Ehngn4N2ND1RS4JqQ6U8yg1RXvYUFJf6ioO4qysVIaQbqdX
         tINNW512EyrX1ijYD8emSywzGy/Zbyd9BMHcDru9/qDbXp4uYzKaSF9fXO50P65j7eL7
         5yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VM3XcfxYrLnx+Hqo7IKRwyP9OAHUoTn2NHKGw40fhK8=;
        b=K3dtYiH9IUrXIJo05CabtaLGDqSfoWwAC7vM79M9PgD3Cxi1FiDWPZXxyaCBUsMmKd
         ugAfQrq+9MOjbdujd+hz4c8AdbepA2m9wvNx0moZFw4roaRaoDip4vn0UDqGgGWaKfuK
         nGCqI45E+6f/wH2582FBRTty1WJmKMM/SXbuhbIQfTN97QlTwOJo4GGIGrE/sZPaz5HO
         lhDRoGwFyi3QkLUpJ5nkbGTrKAmMyw4CPg4IrPICWM5uG8juBUUr+k0/iC3/Ycf6/sTt
         5YADzmurpxasT/e4tz9OOu0hvLxvTioroBNpgb4AM3lsXktAAf1TLLvdr1DPH5L2wjr1
         jL6w==
X-Gm-Message-State: ABUngvd2dqigRstrYNkw9s/uR7uhcYsZ1PXlMszkHg+V6yTv88Rc3TvvtzGGgBk0gOzEnfs8F68qxmV4IGKjLfYs
X-Received: by 10.55.142.130 with SMTP id q124mr6039892qkd.220.1477587662568;
 Thu, 27 Oct 2016 10:01:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 27 Oct 2016 10:01:02 -0700 (PDT)
In-Reply-To: <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com>
References: <20161026215732.16411-1-sbeller@google.com> <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
 <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com> <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
 <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com> <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Oct 2016 10:01:02 -0700
Message-ID: <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com>
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Johannes Sixt <j6t@kdbg.org> writes:
> This is the pessimization that I am talking about. I would not mind at all if
> it were only for the attribute subsystem, but the proposed patch would
> pessimize *all* uses of pthread_mutex_lock.

It would only pessimize *uninitialized* mutexes? For initialized mutexes
the added burden is super cheap (one additional condition).

The positive aspect of this way the patch proposes would be that any
future contributor not knowing the details of how to do mutexes right
on Windows, would not totally break the whole system, i.e. this seems
to be more maintainable in the future as it reduces the friction between
pthreads mutexes and the way we can do things in Git in a platform
independent way

On Wed, Oct 26, 2016 at 11:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Lazy on-demand initialization as needed, perhaps?  The on-demand
>> initialization mechanism may become no-op on some platforms that can
>> do static initialization.
>
> Ah, I think I misunderstood your "please rewrite".  Did you mean to
> add "void attr_start(void)" helper function to attr.c that does
> series of pthread_mutex_init() calls as needed?

Well one init for now.

>  That function can
> be called from main() of platforms that cannot statically initialize
> mutices,

By main you mean the main() in common-main.c or cmd_main in git.c ?

Those both look like the wrong place. Of course it would work adding it
there, but it smells like a maintenance nightmare.

And then we would modify the attr_start command depending on the
platform, i.e.

#ifdef WIN32
void attr_start(void)
{
    pthread_mutex_init(..);
}
#else
void attr_start(void)
{
    /* nothing as it is statically init'd */
}
#endif

> while on other platforms it can be a no-op as long as the
> variables are statically initialized?  If so, that would not pessimize
> any platform, I would think.

I would think this pessimizes ALL platforms from a maintenance perspective
(but what do I know about maintaining stuff as an eager young contributor ;)

So I am willing to go that route, though I do not quite understand where exactly
you'd expect me to put the initializer as all places I can think of
are not the right
place.

Thanks,
Stefan
