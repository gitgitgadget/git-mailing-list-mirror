Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AECD20286
	for <e@80x24.org>; Wed, 13 Sep 2017 15:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbdIMPS6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 11:18:58 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:47887 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdIMPS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 11:18:57 -0400
Received: by mail-it0-f45.google.com with SMTP id o200so3669215itg.0
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 08:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R4NpLEKg0oAIL7jHAQrOmr3eIfj7EENCjfdN4kLIh4Q=;
        b=Gqu+30tFlr96TxCR5o52CLCOtHG8+DOqyqDH/IUUgx2y4mfb2BBZ/H64vPymSdVpIE
         w/72dSFZ8DPWdNJGMucus3Om57pCdOvFeBgvYQDdMJYIIlxy+rBkSxS3HvN+iZdnZmsa
         Fqj6Ixfl03xcIQHv4CYmqdWwyoKNhYcA9pHNqjV0zRlp7dSqnqug6FDRGIw8JdSOhWK7
         OdSoCiNyT0QfUNpWN3lh0dlQfXokFeb97W4HLv60ovOrJKM37ndijpEIc2KXwMxeQL6+
         L87wuHcEfllE6XSp8ikCKNSdh8tTsubMzIj6BiYaTyGah+i1z5AFBNIvhQSg2GmQ6/u+
         04Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R4NpLEKg0oAIL7jHAQrOmr3eIfj7EENCjfdN4kLIh4Q=;
        b=Z9ZwqCZkdawPpGm1Boq7jg0xL55vDmn99ZcStQIMco5x+8bDUUWUQWDu441ZLcL+JM
         jp1yD6PgAqcC+MHAVeGVeHgrHukdmEwlGzJMWfebSKfNV2OzHhPmUybYRTjSND7tq8y9
         IlI5D2zkULRgkGGSFq129AsSRCulvb4lEqq1IAf7TmR8LKLtuDqTCj8aVY3A3f35XNKy
         3Ne4KK41axENLMh4mYMcnj22g8FFeGbyI3wQUftctIxI3dt+X3OL1bwosefJrbFktCvq
         vZd2kExXGAvBaoZEcx0jxpLU6e05Fku0tnG6XhB7xYPXZdPdWs/lwT19t1bh9zoua9sU
         gYfw==
X-Gm-Message-State: AHPjjUjuw/Vn2RehEi42DEM/YVeo8CGqad/WHY+a8ZpJlJfq4/MlVSH+
        xXYS4tLhH9lg522SbGFRBu6KvfbYVT1NFZlog0+15V3n
X-Google-Smtp-Source: AOwi7QDjIjAhMs8cM9T9lHQIoHXWnfCWf5U/REdJB5/kfU2HzjTsagycGw3EtKlQ+LYfzIulB4qtGhJGHPBi40Hy8GY=
X-Received: by 10.36.140.77 with SMTP id j74mr4645858itd.95.1505315936599;
 Wed, 13 Sep 2017 08:18:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.164.4 with HTTP; Wed, 13 Sep 2017 08:18:56 -0700 (PDT)
In-Reply-To: <20170913145154.423zqe6antzccclk@sigill.intra.peff.net>
References: <CANgJU+Wj_sN8Px6rweHMw_iAX8UA3mW9x4NVCctpUCs8_3ytLw@mail.gmail.com>
 <20170913123420.die3thfcpaweakce@sigill.intra.peff.net> <CANgJU+U3Vzmmag9fpFGf7sx4Sq4S9qjLc5bnR4e+U0C3aaQXJA@mail.gmail.com>
 <20170913141739.mkmiaud2eemgnbbh@sigill.intra.peff.net> <CANgJU+WHr2-FjAUUKQ8pUkniczcxrr11dTo_zBeXdTi_su2oUA@mail.gmail.com>
 <20170913145154.423zqe6antzccclk@sigill.intra.peff.net>
From:   demerphq <demerphq@gmail.com>
Date:   Wed, 13 Sep 2017 17:18:56 +0200
Message-ID: <CANgJU+XvJA2LYgFgmJZw7BR4-7qobvOh5zOSAVzGFOTsJ=Z8ug@mail.gmail.com>
Subject: Re: Bug: git branch --unset-upstream command can nuke config when
 disk is full.
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 September 2017 at 16:51, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 13, 2017 at 04:49:45PM +0200, demerphq wrote:
>
>> On 13 September 2017 at 16:17, Jeff King <peff@peff.net> wrote:
>> > You're welcome to read over the function to double-check, but I just
>> > looked it over and couldn't find any unchecked writes.
>>
>> I can look, but I doubt I would notice something you did not.
>>
>> On the other hand the strace output does show that this is a case
>> where the writes failed, but we still renamed the empty config.lock
>> file into place:
>>
>>
>> write(3, "[core]\n\tsharedRepository = true\n"..., 288) = -1 ENOSPC
>> (No space left on device)
>> write(3, "        merge = refs/heads/yves/"..., 51) = -1 ENOSPC (No
>> space left on device)
>> munmap(0x7f48d9b8c000, 363)             = 0
>> close(3)                                = 0
>> rename("/usr/local/git_tree/main/.git/config.lock",
>> "/usr/local/git_tree/main/.git/config") = 0
>
> Hmph. That is very disturbing. But with that information I should be
> able to track down the culprit. Thanks for digging.

FWIW, I see that git_config_set_multivar_in_file_gently() uses
write_in_full() which in turn uses xwrite(), but the latter has the
following comment on it:

/*
 * xwrite() is the same a write(), but it automatically restarts write()
 * operations with a recoverable error (EAGAIN and EINTR). xwrite() DOES NOT
 * GUARANTEE that "len" bytes is written even if the operation is successful.
 */

I suspect that at this point I am not adding much value here, so I
will leave it at this.

>> I freed up space and things worked, so I somehow doubt the filesystem
>> is at fault. When I then filled up the disk and retried the error was
>> repeatable.
>
> Yeah, agreed. This really does look like a bug.

FWIW, where it bit me turned out to be harmless. So while no doubt
this could be a real PITA for someone it wasn't for me.

Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
