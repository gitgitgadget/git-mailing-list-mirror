Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3F2C2D0DB
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 19:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8477524655
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 19:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="T6OEr9Cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgAVTn1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:43:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62339 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVTn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 14:43:27 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1674F3A1CE;
        Wed, 22 Jan 2020 14:43:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k4Kc5J/m6A04yQNMQrf9jkCmQ8c=; b=T6OEr9
        CsduplAeRpm412A+u1yjj8GdjT5HO32Y9PBmb0CpuveBsKFHYDsat6DUBAZ4Sj95
        62yLtDI5nuOkX5Eh6h3F4DDvISUp5A2aP/Xt7Y01p7It3duDASfb7omTJ9BTObmu
        TleTUIcdVNqNMUhW7O4mqSOVQ48Xk80rtKo5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LEe7YG1KLWtlm/x/bVvHArTMhhrs8okq
        dqbc7mHj4iXAVfeVUTXS0ed1c48svoUDoOsHzwj2uSLOClhBQHBtl/ZyKD83D5Vl
        IsjcDjy3CaU353CnHobPU0zh30YkVNscZKYPrjRGvvKdYrmRBXakIxsSw30f/Zvg
        3d8lvMCqkno=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D6003A1CC;
        Wed, 22 Jan 2020 14:43:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7883B3A1CA;
        Wed, 22 Jan 2020 14:43:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/7] pull --rebase/remote rename: document and honor single-letter abbreviations rebase types
References: <cover.1579598053.git.bert.wesarg@googlemail.com>
        <f9da9aac7edf6f682592592fe8f450a5801fb012.1579598053.git.bert.wesarg@googlemail.com>
        <xmqqv9p475ns.fsf@gitster-ct.c.googlers.com>
        <CAKPyHN0_AVOo_6bdHvy_J9ebnBpSD2NECBiLZ7g=4TcMvfZgYw@mail.gmail.com>
Date:   Wed, 22 Jan 2020 11:43:22 -0800
In-Reply-To: <CAKPyHN0_AVOo_6bdHvy_J9ebnBpSD2NECBiLZ7g=4TcMvfZgYw@mail.gmail.com>
        (Bert Wesarg's message of "Wed, 22 Jan 2020 08:34:46 +0100")
Message-ID: <xmqqh80n6zvp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7357EEC8-3D4F-11EA-9A24-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> Dear Junio,
>
> On Wed, Jan 22, 2020 at 12:26 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>>
>> > When 46af44b07d (pull --rebase=<type>: allow single-letter abbreviations
>> > for the type, 2018-08-04) landed in Git, it had the side effect that
>> > not only 'pull --rebase=<type>' accepted the single-letter abbreviations
>> > but also the 'pull.rebase' and 'branch.<name>.rebase' configurations.
>> >
>> > Secondly, 'git remote rename' did not honor these single-letter
>> > abbreviations when reading the 'branch.*.rebase' configurations.
>>
>> Hmph, do you mean s/Secondly/However/ instead?
>
> thanks, that now reads smoothly.
>
>> > @@ -305,17 +304,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
>> >                               space = strchr(value, ' ');
>> >                       }
>> >                       string_list_append(&info->merge, xstrdup(value));
>> > -             } else {
>> > -                     int v = git_parse_maybe_bool(value);
>> > -                     if (v >= 0)
>> > -                             info->rebase = v;
>> > -                     else if (!strcmp(value, "preserve"))
>> > -                             info->rebase = NORMAL_REBASE;
>> > -                     else if (!strcmp(value, "merges"))
>> > -                             info->rebase = REBASE_MERGES;
>> > -                     else if (!strcmp(value, "interactive"))
>> > -                             info->rebase = INTERACTIVE_REBASE;
>> > -             }
>> > +             } else
>> > +                     info->rebase = rebase_parse_value(value);
>>
>> Here, we never had info->rebase == REBASE_INVALID.  The field was
>> left intact when the configuration file had a rebase type that is
>> not known to this version of git.  Now it has become possible that
>> info->rebase to be REBASE_INVALID.  Would the code after this part
>> returns be prepared to handle it, and if so how?  At least I think
>> it deserves a comment here, or in rebase_parse_value(), to say (1)
>> that unknown rebase value is treated as false for most of the code
>> that do not need to differentiate between false and unknown, and (2)
>> that assigning a negative value to REBASE_INVALID and always
>> checking if the value is the same or greater than REBASE_TRUE helps
>> to maintain the convention.
>
> Its true that we never had 'info->rebase == REBASE_INVALID', but the
> previous code also considered unknown values as false. 'info' is
> allocated with 'xcalloc', thus 'info->rebase' defaults to false. Thus
> it remains false.

Yes, that is why I was not opposed to the new code.  It was just
that it was not clear, without some comments I suggested in the
latter half of my paragraph you responded above, why it is correct
to unconditionally assign to info->rebase and the code the control
reaches after this part gets executed does not need any adjustment
and simply "works".

Thinking about it again, I think the two points I thought need
highlighting in the above belong to the in-code comment for the new
helper rebase_parse_value().

    *** in rebase.h ***
    enum rebase_type {
            REBASE_INVALID = -1,
            REBASE_FALSE = 0,
            REBASE_TRUE,
            REBASE_PRESERVE,
            REBASE_MERGES,
            REBASE_INTERACTIVE
    };

    /*
     * Parses textual value for pull.rebase, branch.<name>.rebase, etc.
     * Unrecognised value yields REBASE_INVALID, which traditionally is
     * treated the same way as REBASE_FALSE.
     *
     * The callers that care if (any) rebase is requested should say
     *   if (REBASE_TRUE <= rebase_parse_value(string))
     *
     * The callers that want to differenciate an unrecognised value and
     * false can do so by treating _INVALID and _FALSE differently.
     */
    enum rebase_type rebase_parse_value(const char *value);

or something like that, perhaps.
