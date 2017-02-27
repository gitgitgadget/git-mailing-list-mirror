Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1502A1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751587AbdB0Szg (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:55:36 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:34831 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbdB0Sze (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:55:34 -0500
Received: by mail-io0-f193.google.com with SMTP id v13so6944536iov.2
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dzfiMnOXvTIGtobpn2BpJhLkxTWBqYo96JqyGpLOz/o=;
        b=SjqAEouF3ZRaraU6ug2cDN89u2aMu55VnFROT4yE5rc2lhL4RiCG0GrhAck0bj1f6S
         zJExnAYXzEHPlpg1bfvXFbfbWu2fBGhZ4AbzQeKdCZT3o7oNhkco4MT65mm8ZxhlbnnR
         KqKxVGIt6zWn8rjKXN7WeJbzATIPXXhfukIQ4oKfZqmK1Wsuafwk7boKgY/rywWtAY4G
         3i/7B4bpOl45ZpNXaS+f4HR7gLpSySVZgM82biwTiOuddLPo1kpdOA7VfiIu+oVHMM1h
         zfVmdvLSeE6lYJmdTTTks21tUvWGj/iKEMbPy3/8TSSf5e7OGV1HB7FeQa5L2/hNujza
         2Ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dzfiMnOXvTIGtobpn2BpJhLkxTWBqYo96JqyGpLOz/o=;
        b=c6zmZbOHKqSNVnY8XsH/TgEBv6NyfBKBWzlk6AheJwzbldldI1wlHmzQxbstdmlgiu
         yW2lWlaaFmi2VzuUx8eBHdXKYBg/0jrky1ruFnlKnb2nppEi3YU90Xli8WMKkKOBaqn1
         lETLIWsuwNwWcFqwHpBaKFQzRHewJUP7zVjQdCeR2xDymBCgQ85MV3jb8zqeQvxERljd
         ujt34AQQtdXI8Ga25NqI+tTNL65NtPjH39wC7PrsP9CSUwwBiOKlVqrrMPmyuF1c7lZ/
         m8+VYmJo/849NIBBHkKV1PSiAODn5+ZGWDLC5uKKkdBRvmHlKe7HKtbPFy0KjAPkNEqX
         zu7Q==
X-Gm-Message-State: AMke39l6u/2WokWXj8RQLpO57JLBkBeKp/UyFioYpXJ1jnBK+QEKXucODgq7p/amBCPxfsxBFScTgzWjoDbODw==
X-Received: by 10.107.200.139 with SMTP id y133mr361058iof.147.1488219972403;
 Mon, 27 Feb 2017 10:26:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Mon, 27 Feb 2017 10:25:51 -0800 (PST)
In-Reply-To: <4b34e3a0-3da7-d821-2a7f-9a420ac1d3f6@gmail.com>
References: <20170227123720.8493-1-avarab@gmail.com> <4b34e3a0-3da7-d821-2a7f-9a420ac1d3f6@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 27 Feb 2017 19:25:51 +0100
Message-ID: <CACBZZX6gz8rs-Tf3DvG=J1WA5X+=ObfU-kGoDqVeeW0_ALQYXw@mail.gmail.com>
Subject: Re: [PATCH] gitweb tests: Skip tests when we don't have Time::HiRes
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 6:48 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> W dniu 27.02.2017 o 13:37, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason pisze:
>> Change the gitweb tests to skip when we can't load the Time::HiRes
>> module.
>
> Could you tell us in the commit message why this module is needed?
> Is it because gitweb loads it unconditionally, or does that at least
> in the default configuration, or is it used in tests, or...?
>
> [I see it is somewhat addressed below]
>
>>
>> This module has bee in perl core since v5.8, which is the oldest
>
> s/bee/been/

I'll clarify that in a re-roll & fix the typo, pending any other
comments. Thanks!

>> version we support, however CentOS (and perhaps some other
>> distributions) carve it into its own non-core-perl package that's not
>> installed along with /usr/bin/perl by default. Without this we'll hard
>> fail the gitweb tests when trying to load the module.
>
> I see that it because gitweb.perl as the following at line 20:
>
>         use Time::HiRes qw(gettimeofday tv_interval);
>
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> Good catch (if a strange one...).

This and the associated cvs tests failing as root patch I submitted
were discovered when trying to build git in the standard mock build
environment on CentOS. It creates a chroot and rpm installs just the
packages you declare, so issues like these crop up.

>> ---
>>  t/gitweb-lib.sh | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
>> index d5dab5a94f..116c3890e6 100644
>> --- a/t/gitweb-lib.sh
>> +++ b/t/gitweb-lib.sh
>> @@ -114,4 +114,9 @@ perl -MCGI -MCGI::Util -MCGI::Carp -e 0 >/dev/null 2=
>&1 || {
>>       test_done
>>  }
>>
>> +perl -mTime::HiRes -e 0  >/dev/null 2>&1 || {
>> +     skip_all=3D'skipping gitweb tests, Time::HiRes module unusable'
>
> Is "unusable" a good description, instead of "not found"?

Yeah it's odd, but I just copied the several lines above that use that phra=
sing.

>> +     test_done
>> +}
>> +
>>  gitweb_init
>>
>
