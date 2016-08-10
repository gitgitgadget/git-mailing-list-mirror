Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D01F1FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 22:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933418AbcHJWp7 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 18:45:59 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34835 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129AbcHJWp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 18:45:58 -0400
Received: by mail-yw0-f196.google.com with SMTP id r9so2602573ywg.2
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 15:45:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9HCtn9S6lhE1hRuYtoLWUnZdKOFB07TMHV9OOJgVGTI=;
        b=I0sAYGnqL0myvsuwkYSKFZSEjcVA5lAtKe7L7upRbHSi1ArT6gDr7H0Kcn4+Yy+2xV
         bp92w/cEPYSxLpRkN7s5nEB30doT+MEdEoSvS1NIFgiLXT4U1ZEDnAp5ey/QbvRFzGH4
         49zXB54AiHQEij0iRPt3atL3bE/KP/EKJrbVuc3eE6Io605XakqX/K8JD2eLul0XJyWs
         eDihKqCuCy3FpYkR2Q1FsrdSCOYQ5cuZuBa+7kBqsRClh6DSJTEKXARhKGh9QwXBJI4X
         F1B4soQK6SMOx9RebDpaVPXkmEKqJsDfjZERr9ByrxviaUN71IxqMx1jeEAdtfAUrS6c
         Mblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9HCtn9S6lhE1hRuYtoLWUnZdKOFB07TMHV9OOJgVGTI=;
        b=OoAqIPrT2xxYEgPFUuzGtEKB2ySVnKItOAXSA6bzBIg8c+DiyqyWuBYQq4i62tNX1u
         gv0AsnAtziIDQNoYk5g/s7BN3+zhGSWGdcBq6uh1I2gvT0iq+9A7+FONpeIlLfTnkgNj
         7JBsZ8U187j3aFeZdvosEc5xZeFE7HMSzKAi9Z1qegFPpeTalpFdmT3jbeTJBvnJlWcv
         wguBQzzn+dx6Sd20qIXhscLAm0RfuQACN2ohs2wPhRDWRWpzt+o+yh5hSYc2o/RXFl9q
         mmv6ZkLFdykP1KEfp0e7uFx9T8Iq73TDDvYUwtZFXimQlPINuPXsDLEQTq37GD4kpyJx
         qLhw==
X-Gm-Message-State: AEkoouvOaIUtuYnRqAQ61Xnj1YIEMitk6PkK/w1UcgfYKRbJJRXmCxOp2I6QBhjlW2vR3eNTItMoX5seVDQ6Qw==
X-Received: by 10.13.197.195 with SMTP id h186mr4396917ywd.54.1470869157681;
 Wed, 10 Aug 2016 15:45:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Wed, 10 Aug 2016 15:45:37 -0700 (PDT)
In-Reply-To: <xmqqziok2sbg.fsf@gitster.mtv.corp.google.com>
References: <20160810211710.23173-1-jacob.e.keller@intel.com>
 <20160810211710.23173-2-jacob.e.keller@intel.com> <xmqqziok2sbg.fsf@gitster.mtv.corp.google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Wed, 10 Aug 2016 15:45:37 -0700
Message-ID: <CA+P7+xrcCDP4NZFb+hvV3yFE7VAbNcScL6S8ezBsjhRdcG4Xdw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] diff: add SUBMODULE_DIFF format to display
 submodule diff
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 3:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> @@ -2305,6 +2311,15 @@ static void builtin_diff(const char *name_a,
>>       struct strbuf header = STRBUF_INIT;
>>       const char *line_prefix = diff_line_prefix(o);
>>
>> +     diff_set_mnemonic_prefix(o, "a/", "b/");
>> +     if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
>> +             a_prefix = o->b_prefix;
>> +             b_prefix = o->a_prefix;
>> +     } else {
>> +             a_prefix = o->a_prefix;
>> +             b_prefix = o->b_prefix;
>> +     }
>> +
>
> Hmph, is it safe to raise this when SUBMODULE_DIFF is not in effect?
> Not objecting, just asking.

The only other code was SUBMODULE_LOG which doesn't get passed the
a_prefix and b_prefix so it shouldn't make a difference.

>
>>       if (DIFF_OPT_TST(o, SUBMODULE_LOG) &&
>> ...
>> +     } else if (DIFF_OPT_TST(o, SUBMODULE_DIFF) &&
>
> This makes clear that SUBMODULE_LOG and SUBMODULE_DIFF should not be
> independent bits in the diff-opt flag word.  We used to run
> something like "log --oneline --left-right A...B" and your new code
> runs "diff A B", but the next month somebody else would want to do
> "log -p --left-right A...B" or something else, and they are clearly
> mutually exclusive.

They are independent bits, but the set and clear make them mutually
exclusive. How would you implement this instead? Maybe as a separate
field of the diff_options?

>
>> diff --git a/diff.h b/diff.h
>> index 6a91a1139686..65df44b1fcba 100644
>> --- a/diff.h
>> +++ b/diff.h
>> @@ -69,7 +69,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
>>  #define DIFF_OPT_FIND_COPIES_HARDER  (1 <<  6)
>>  #define DIFF_OPT_FOLLOW_RENAMES      (1 <<  7)
>>  #define DIFF_OPT_RENAME_EMPTY        (1 <<  8)
>> -/* (1 <<  9) unused */
>> +#define DIFF_OPT_SUBMODULE_DIFF      (1 <<  9)
>
> So I'd really prefer not to see this change; instead, we should move
> in the direction where we _REMOVE_ DIFF_OPT_SUBMODULE_LOG from these,
> and introduce an enum to hold "how would we show submodule changes"
> in the diff_options structure.

Yes, I agree. I will rework that.

Thanks,
Jake
