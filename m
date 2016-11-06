Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CCB62022A
	for <e@80x24.org>; Sun,  6 Nov 2016 07:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751427AbcKFHmt (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 02:42:49 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33358 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbcKFHms (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 02:42:48 -0500
Received: by mail-yw0-f194.google.com with SMTP id s68so4102300ywg.0
        for <git@vger.kernel.org>; Sun, 06 Nov 2016 00:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oy+iMduvrZ35NiciW9QhIFgKRZ9MvAvKCB4iBNfFVR4=;
        b=bwCXIxsfGKa7XxFilx4JLFVsyQCJLKun+pN4E9LzTk4EGA7USw57rhVt01+XnOneOH
         nfXHk6F6tgt0Dcm31VhbkthAZvCWU733g8EPC9qYa+gcycVK1IoO38Y4YfT51oiaakDe
         Wimhh4ckggf/EaDCPP9U68vCwgDC97iVRZgTtZ8HSbRTU44bhLfEoV3QTHA2kFZcM0kV
         6lOCGMSrgnOsAU40N7Rzjg4gpL4RYO8jMSP/4yznv88bEknVxlBacIVLNpAGB47ON9vB
         MsgiCHEaAsiboFg1yEEzZEAcjrqlVlJ9irEwR/lXPfIyLe16H8iq/lxT864pJfBIJW1T
         9Txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oy+iMduvrZ35NiciW9QhIFgKRZ9MvAvKCB4iBNfFVR4=;
        b=J1OXh/7k/M2iHqJ7qQ0TRrL2ix//qadiPn+68vrp835M85VZ2vYDp0GPSmN257WorQ
         FqNsnKZDcG6/zN+YQk2mjOjyS6EEN5RHlTpBFtOMakJe5tEjyN9Z/pCc5422Y6dCkVwe
         WVlKXh5taj4fj0qZBR5xUOzCM+LL5vxKTVZKMJLPhFK33ORVPiBw/IudpDJ08kO+zitG
         HOPfB3YCNo15kC2cS47EvTW4qSM0RA1d3LojHOYfADYhHFjF07v5KxPFdPDG4L2nqxRP
         F6P3Yd34d0MeoXuNlXygITWqH4TXXu8XIxo5VCPl404IpF0UzaOqHpQWYV2r3DL3wlgT
         nBPQ==
X-Gm-Message-State: ABUngvdxj8cofbIqkXPlGXLnoJJqSV7Q9ODJDG+tidTvb+xbhUdzEQzf7dET0Q6Fu5xanRqiQ47XKIFXTqPAnQ==
X-Received: by 10.13.231.131 with SMTP id q125mr891147ywe.122.1478418167518;
 Sun, 06 Nov 2016 00:42:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Sun, 6 Nov 2016 00:42:27 -0700 (PDT)
In-Reply-To: <CAGZ79kYcs0FiXdP6UZGgSmUpn_3vpnKo2RwTRJCvksP7+1o_wQ@mail.gmail.com>
References: <20161027223834.35312-1-bmwill@google.com> <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1477953496-103596-2-git-send-email-bmwill@google.com> <CAGZ79kamzSPyM65k9ugS0dAJCfGnGvk3m2p+XtCEozCvoZ5+OA@mail.gmail.com>
 <xmqq7f8nqfqc.fsf@gitster.mtv.corp.google.com> <CAGZ79kYcs0FiXdP6UZGgSmUpn_3vpnKo2RwTRJCvksP7+1o_wQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 6 Nov 2016 00:42:27 -0700
Message-ID: <CA+P7+xoLUCR1fJ0kZ9F4bKgbez35oah6tKU7L+A7r5iAGv29+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] submodules: add helper functions to determine
 presence of submodules
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 1, 2016 at 10:31 AM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Nov 1, 2016 at 10:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>>
>> Maybe I am old fashioned, but I'd feel better to see these with
>> explicit "extern" in front (check the older header files like
>> cache.h when you are in doubt what the project convention has been).
>
> I did check the other files and saw them, so I was very unsure what to
> suggest here. I only saw the extern keyword used in headers that were
> there when Git was really young, so I assumed it's a style nit by kernel
> developers. Thanks for clarifying!
>
> I think we'll want to have some consistency though, so we
> maybe want to coordinate a cleanup of submodule.h as well as
> submodule-config.h to mark all the functions extern.
>
> This doesn't need to be a all-at-once thing, but we'd keep it in mind
> for future declarations in the header.
>
> Thanks,
> Stefan

Extern is generally used when you want to declare a header for a
function that's in a different object file. I'm not sure if we
actually need it or not though.

Thanks,
Jake
