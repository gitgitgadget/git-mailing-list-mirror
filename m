Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B4262036B
	for <e@80x24.org>; Tue,  3 Oct 2017 23:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbdJCXmD (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 19:42:03 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:47734 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdJCXmC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 19:42:02 -0400
Received: by mail-io0-f177.google.com with SMTP id m201so3785635iom.4
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 16:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f3JburqW1L0UtNHirHBrphRvfIinI/KOEWAbsZkZSp8=;
        b=rYcUWnPa7tG9Y72jhA6hv4GcFdqnH38YIZKnDMCxVp1MbrEBm1FgOe5lWwK2VUZJ3g
         /JJRijn0Hlxfg55Z9zn8lIlD5X/WEWA2/wT7WmM8ZS+5h/L7+djePpi1Z+mHa86BvFFA
         OnGNjphj+/W85U7UwLRNLF+TQtJ3BsFrMU1I/5fNGtdX8uQy47N24G8VD3LLOA6dZn5k
         z0SJ7yasnFj+9YtwIpgjLdpoghMiWu0ZhQQVYu7AvNpKEIHZY3eQyvFxYyDVfa/6MOAv
         k4RHaIc5ArwMH0hESgZnDT+BEaqj5Tmr5nqgYrZiSSyW/k1XiPM3fsxxN7MXKtlCmRIU
         a0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f3JburqW1L0UtNHirHBrphRvfIinI/KOEWAbsZkZSp8=;
        b=g7SfZP3Vag6/XrXD8KkTHhe2LD72Mez8P8e2KtvqYNVmWXQoH0b5+pd6+YG9nVMy4V
         1QpghbTBLhkyUtqyOjVRCkaL6Jz1iM4mKC4DN9SQZ8GySl22OfHDyEMkLHUoehFswLq8
         0d7X/4EpxGPGgZ8/grPW3JbuttQL5GIBGOzuuLnla7JeFuVp8hSaeGZkTuPEavTOUVXw
         Ck8IU9e0m3YXVuwgXyjAk28bLnTRRMXBpSBvUWIc5RGNfCbooogGegTvfOdEZqVOvxny
         m3R0Wj951M8t2YMRn9v6vsEQVIlWt0DRx6R6hPFK+sLBXBWwiAU2nwwKEEWlN7dRQY6q
         jg4g==
X-Gm-Message-State: AMCzsaUsGLIhfrvxZOpiw4vKwmLnhRKFgdhp6Zr8ZC9TBOviCBGHHf5d
        0W9OPDY2Mi105s9ObguYffJp5iPi9qGo30xVvFLdRg==
X-Google-Smtp-Source: AOwi7QA92iQRAUsm4u8g3jS8zow6GPCLAMV/JBID+bi68uj3lJaF2Cq0JlP+ropRtmVFxeeE9RhvDWJVvzMkd3Q5D94=
X-Received: by 10.107.198.67 with SMTP id w64mr653868iof.74.1507074121299;
 Tue, 03 Oct 2017 16:42:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.129.66 with HTTP; Tue, 3 Oct 2017 16:42:00 -0700 (PDT)
In-Reply-To: <cb818dcf-beab-10ac-5e58-f56377af4f6a@jeffhostetler.com>
References: <cover.1506714999.git.jonathantanmy@google.com>
 <CAP8UFD1WiceKDX9s0hszXXKy+TOxAOvHZyr002HMYkkgbFgD7w@mail.gmail.com>
 <xmqq8tgsipi5.fsf@gitster.mtv.corp.google.com> <cb818dcf-beab-10ac-5e58-f56377af4f6a@jeffhostetler.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 3 Oct 2017 16:42:00 -0700
Message-ID: <CAGf8dgLu-TeK8KbHv-U+18O+L2TxKcGv5vFFHy38J6a_YXRfew@mail.gmail.com>
Subject: Re: [PATCH 00/18] Partial clone (from clone to lazy fetch in 18 patches)
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Ben Peart <peartben@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 3, 2017 at 7:39 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>
> As I see it there are the following major parts to partial clone:
> 1. How to let git-clone (and later git-fetch) specify the desired
>    subset of objects that it wants?  (A ref-relative request.)
> 2. How to let the server and git-pack-objects build that incomplete
>    packfile?
> 3. How to remember in the local config that a partial clone (or
>    fetch) was used and that missing object should be expected?
> 4. How to dynamically fetch individual missing objects individually?
>     (Not a ref-relative request.)
> 5. How to augment the local ODB with partial clone information and
>    let git-fsck (and friends) perform limited consistency checking?
> 6. Methods to bulk fetching missing objects (whether in a pre-verb
>    hook or in unpack-tree)
> 7. Miscellaneous issues (e.g. fixing places that accidentally cause
>    a missing object to be fetched that don't really need it).

Thanks for the enumeration.

> As was suggested above, I think we should merge our efforts:
> using my filtering for 1 and 2 and Jonathan's code for 3, 4, and 5.
> I would need to eliminate the "relax" options in favor of his
> is_promised() functionality for index-pack and similar.  And omit
> his blob-max-bytes changes from pack-objects, the protocol and
> related commands.
>
> That should be a good first step.

This sounds good to me. Jeff Hostetler's filtering (all blobs, blobs
by size, blobs by sparse checkout specification) is more comprehensive
than mine, so removing blob-max-bytes from my code is not a problem.

> We both have thoughts on bulk fetching (mine in pre-verb hooks and
> his in unpack-tree).  We don't need this immediately, but can wait
> until the above is working to revisit.

Agreed.
