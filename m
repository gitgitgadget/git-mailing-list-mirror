Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B42051F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 21:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbdARVWd (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 16:22:33 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33850 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbdARVWd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 16:22:33 -0500
Received: by mail-lf0-f54.google.com with SMTP id v186so22410818lfa.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 13:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D5Oh4D82Rd/FjxJmROnTcVyQKklnPKexbOdoCJjWLgQ=;
        b=gbLFJ1A/yZts8sLjmJwtJ6xAYIKturCTUKT5cW7OHMkdvmeX5mB4p4zmF3lgXCBEnS
         7KEJQuLke0j7xb83krSfbwN4DlYSn84t2pBoLzPGmTiFMV3fhRE9NOB0zArHAQm2MSCP
         8yCCOuT4XDuStDrr0xfHAlZ04Vyzmgy9jpnQdG8CgYzjdh2jkLHpLAeRz28qADeB6NeM
         beTfAXpva6I4+rJRPdFWZujQ+XyaxwPzd+rfVm3rfPitowH46duI241LQEyDyVc0Vki9
         i/bf4vN218+Ipg/zYQ4mLAAreRog2wuR8SybkkU+x4drmwCx436O1FKW4U6EndZ6Me2K
         vqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D5Oh4D82Rd/FjxJmROnTcVyQKklnPKexbOdoCJjWLgQ=;
        b=jAxMJDsfDPgWECwJbhUyc4qlm7gN6lRaWkx4MvlWyBxayvxWxHdWfQjxpBa6QCK2Oe
         nWECvBPYpW4uMCC/JXVTRDGkPY2iE3BLWb/YFa//pFDK4+Xc5qRj5pQS1RWq/sjcMF4m
         H3e4YPyzj1IYnIlWWJd6XESvsF7dI5S4CPllAdX7Vgj2W9Y/vpXqTFWtI5ZuOL4Z4qiz
         MzYdJ8DYHtX4S8hzP2DT2vASuJNOadA+OKP5h8aqDgOnrOjMT+t1MwUq2C1P3iLHG0TU
         eUZXcIoMAEYlwqoY41EwzMTUhL9FAyi8kD8RCe2PrZVOrFvvsJkQ8YkHDa71r9fAiT/i
         FVTA==
X-Gm-Message-State: AIkVDXKPUi+Jc2XsjFwPlfHHmrlrBGrkKYyC96vQ7AI0hzJpXN/dEObzKAC7bVUp7z77F2D03LgshC92JjHx5Q==
X-Received: by 10.25.74.72 with SMTP id x69mr1974367lfa.66.1484773977630; Wed,
 18 Jan 2017 13:12:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Wed, 18 Jan 2017 13:12:37 -0800 (PST)
In-Reply-To: <xmqqy3y8878k.fsf@gitster.mtv.corp.google.com>
References: <20170118000930.5431-1-jacob.e.keller@intel.com>
 <20170118000930.5431-3-jacob.e.keller@intel.com> <xmqqy3y8878k.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 18 Jan 2017 13:12:37 -0800
Message-ID: <CA+P7+xpMAVq8K41cDZy5FTiRTHoWWd3yOSmLoj4ucAvCPoNa0g@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] name-rev: extend --refs to accept multiple patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 12:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Teach git name-rev to take a string list of patterns from --refs instead
>> of only a single pattern. The list of patterns will be matched
>> inclusively, such that a ref only needs to match one pattern to be
>> included. If a ref will only be excluded if it does not match any of the
>> patterns.
>
> I think "If a" in the last sentence should be "A".

You are correct, that is a typo.

>
>>  --refs=<pattern>::
>>       Only use refs whose names match a given shell pattern.  The pattern
>> -     can be one of branch name, tag name or fully qualified ref name.
>> +     can be one of branch name, tag name or fully qualified ref name. If
>> +     given multiple times, use refs whose names match any of the given shell
>> +     patterns. Use `--no-refs` to clear any previous ref patterns given.
>
> Unlike 1/5, this is facing the end-users, and the last sentence is
> very appropriate.

Yes.

>
>> +     if (data->ref_filters.nr) {
>> +             struct string_list_item *item;
>> +             int matched = 0;
>> +
>> +             /* See if any of the patterns match. */
>> +             for_each_string_list_item(item, &data->ref_filters) {
>> +                     /*
>> +                      * We want to check every pattern even if we already
>> +                      * found a match, just in case one of the later
>> +                      * patterns could abbreviate the output.
>> +                      */
>> +                     switch (subpath_matches(path, item->string)) {
>> +                     case -1: /* did not match */
>> +                             break;
>> +                     case 0: /* matched fully */
>> +                             matched = 1;
>> +                             break;
>> +                     default: /* matched subpath */
>> +                             matched = 1;
>> +                             can_abbreviate_output = 1;
>> +                             break;
>> +                     }
>>               }
>
> I agree that we cannot short-cut on the first match to make sure
> that the outcome is stable, but I wondered what should be shown when
> we do have multiple matches.  Say I gave
>
>     --refs="v*" --refs="refs/tags/v1.*"
>
> and refs/tags/v1.0 matched.  The above code would say we can
> abbreviate.
>
> What is the reason behind this design decision?  Is it because it is
> clear that the user shows her willingness to accept more compact
> form by having --refs="v*" that would allow shortening?  If that is
> the case, I think I agree with the reasoning.  But we probably want
> to write it down somewhere, because another reasoning, which may
> also be valid, would call for an opposite behaviour (i.e. the more
> specific --refs="refs/tags/v1.*" also matched, so let's show that
> fact by not shortening).
>

I'm not sure which reasoning makes most sense. Any other opinions?

Thanks,
Jake
