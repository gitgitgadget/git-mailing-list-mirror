Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38B4520193
	for <e@80x24.org>; Thu, 11 Aug 2016 18:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbcHKSfE (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 14:35:04 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:33351 "EHLO
	mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbcHKSfC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 14:35:02 -0400
Received: by mail-yb0-f195.google.com with SMTP id v8so33942ybe.0
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 11:35:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w5ZUkDQuKjbkvFA4AkEfzjdSCpnHuZrwoO+tOWaMywQ=;
        b=KUDbiFv3H6IZIclFXNj88hY9D3W2uTwEiPn8VYcdo46se/B4oURGrbqmg+m72NDKrz
         pZQFaWkJ0htucr6eLsEOmHRxrRyijTgJIborqJkwudPQVfn6WhaGJbJh4BKy27OoSNdy
         j8LedBC0SnVu+rdCeL/E2o6s96oDV2t0rWgIg/Y3YWSNSwV/D+dgA9xM/pfiGwN/oOfX
         b7XncKMq/suixPz4CZQIcc9eSvOYKLo0EwBpl9kQcfA1D9P2jJ0kMIelf0VcIwTyV4cV
         BaFnW8W52WB5+GfsvWSxmpOQom6E5GlLNMHdJCTpC/etTdfDQ0FE5/AhlcOt5dFPYe6w
         c8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w5ZUkDQuKjbkvFA4AkEfzjdSCpnHuZrwoO+tOWaMywQ=;
        b=XfaZup3EucnLQ2785Hw8RmYYZl6bH8B/iCHoi9BinS/L0K36RInzmd2ZP6MAWCDypn
         7BYMbUrlTi1LoZluQxRze71b5U/7FQB5tok7Nqe/wV0azjI7wgkrkcvPOspwfcnrX3J2
         ONskhuL5X3BIKUmH1GazFY04e8j5QEWuDh7wgi0jM+FUENA7hVFhHxiMocs4ssCl94Ch
         kLdadq3rBiXWrdolRcqHKLhv9x8HlEG0H5QGQMBCYgItpmymaYaj2uuJ5INFaY/Tgykl
         McoOqdTm30YbXqTFPQORGTtNcH/i3e6D/YCBQv7X+PMVLlmjmDjJ0gFy4XQrofN/UEZT
         goGg==
X-Gm-Message-State: AEkoouupK4XrbLRDRmRkt6hJZ/saZz4v5Z0zpUcpOxCv2TPd/Aea5muwx0L8ffWYQ5Rzde5XoNfF7NRjCDdUng==
X-Received: by 10.37.97.149 with SMTP id v143mr7470293ybb.164.1470940501429;
 Thu, 11 Aug 2016 11:35:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Thu, 11 Aug 2016 11:34:38 -0700 (PDT)
In-Reply-To: <xmqqd1lf2nvj.fsf@gitster.mtv.corp.google.com>
References: <20160810231908.26330-1-jacob.e.keller@intel.com>
 <20160810231908.26330-2-jacob.e.keller@intel.com> <xmqqd1lf2nvj.fsf@gitster.mtv.corp.google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Thu, 11 Aug 2016 11:34:38 -0700
Message-ID: <CA+P7+xpYrEa4Ocsny0Ca6zsRDJxax9FwiRtuxDGArgDiPbk9Cg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] diff: add SUBMODULE_DIFF format to display
 submodule diff
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 11, 2016 at 10:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Teach git-diff and friends a new format for displaying the difference of
>> a submodule using git-diff inside the submodule project. This allows
>> users to easily see exactly what source changed in a given commit that
>> updates the submodule pointer. To do this, remove DIFF_SUBMODULE_LOG bit
>> from the diff options, and instead add a new enum type for these
>> formats.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> ---
>>  Documentation/diff-config.txt  |  3 +-
>>  Documentation/diff-options.txt |  6 ++--
>>  diff.c                         | 41 ++++++++++++++++----------
>>  diff.h                         |  9 +++++-
>>  submodule.c                    | 67 ++++++++++++++++++++++++++++++++++++++++++
>>  submodule.h                    |  6 ++++
>>  6 files changed, 113 insertions(+), 19 deletions(-)
>
> This looks good.
>
> You'd want some tests to make sure that the "--submodule" and the
> "--submodule=<format>" command line options and the diff.submodule
> configuration variables are parsed correctly (and when combined, the
> command line option overrides the configured default), and of course
> the machinery does the right thing, with and without "--graph" when
> used in "git log".

Yes, I am adding tests now, but I ran into some interesting corner
cases for this, that still need some work.

There's a bunch of issues with cases involving adding a submodule that
isn't stored in .git/modules/etc, which the current tests for
--submodule=log do.

There's also the case of empty trees, which I believe I have resolved
now. Hopefully I can sort these cases correctly.

>
>> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
>> index e7b729f3644f..988068225463 100644
>> --- a/Documentation/diff-options.txt
>> +++ b/Documentation/diff-options.txt
>> @@ -215,8 +215,10 @@ any of those replacements occurred.
>>       the commits in the range like linkgit:git-submodule[1] `summary` does.
>>       Omitting the `--submodule` option or specifying `--submodule=short`,
>>       uses the 'short' format. This format just shows the names of the commits
>> -     at the beginning and end of the range.  Can be tweaked via the
>> -     `diff.submodule` configuration variable.
>> +     at the beginning and end of the range. When `--submodule=diff` is
>> +     given, the 'diff' format is used. This format shows the diff between
>> +     the old and new submodule commmit from the perspective of the
>> +     submodule.  Can be tweaked via the `diff.submodule` configuration variable.
>
> This is carried over from the existing text, but "Can be tweaked
> via" sounds a bit wasteful (and strange); "Defaults to" (or "The
> default is taken from") is the phrase we seem to use more often.

Probably worth fixing here. WIll do.

Thanks,
Jake

>
> Thanks.
