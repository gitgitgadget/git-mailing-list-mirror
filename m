Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60CEE20756
	for <e@80x24.org>; Fri, 13 Jan 2017 23:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbdAMXwY (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 18:52:24 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:37741 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751573AbdAMXwW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 18:52:22 -0500
Received: by mail-it0-f42.google.com with SMTP id r185so49121268ita.0
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 15:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oPLSm/uOF28UVmAJHlQEAHWAvxZmbgrRv54WDtT0f3Y=;
        b=SPecKPrfK/JKfxhhj0lHUsctaU6O0wpWdHdepKH2oRQ7/JXzJv6VF2U9bHQo9mjsOJ
         IF8Chk6ckcM78aSjiHByMHqeHVvfsjD46t+yUvg5i9jPTo2Ck8LSDUIiEcnyMQ2SXZMh
         VreOnBRVfqat35aZd2qckX3FWVlRvgVWeE5YawjGR+H3AiWzq/sDNm8qZZGYGOU2W1Hx
         a31uvs3iFvPcvN6hGOpIJ21kqRummZAbgrQmnMUpG0Q6eZImABUdDPE+jdqGy7nT2vUM
         IDeufdIDehVJYvb//g4n0WYG5QL4kR7b82ehm/7AuGbnSL7/Q3qU3XeiQbuKSHHc7vJk
         iTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oPLSm/uOF28UVmAJHlQEAHWAvxZmbgrRv54WDtT0f3Y=;
        b=HOYU7mSvYgr/PaDrJlRojFdy6OjAyWRpZ++VHa+j7DY7PD/DWr1T0yljX5JjAznM03
         kRAczl3oxxLybAewAtGY1KMzlN3Ulq1gm1lCqYxpytfFd35SNeHsEKfmJvIHB6KnWc5T
         jNWzRSUf9RBsYNdtVVLzzkc4OBO8Vqz++0Dwkwd6zritqJIyqvfNI518p+wsclSeoqiz
         PwEnuwQx/eiA//sLrqqlLEtQGEddFQZ1O0QDIq2y4b6nMT14pBFqPgOpbygaKFhKVFJe
         ZkraCSscSFBfGNLXP9gFfWrKaBu75Jl/r3gYXeDS8VZMyN2iiMxV2bUBp5nL/uDIRkbd
         UEmw==
X-Gm-Message-State: AIkVDXJ7XM7K9E+1zhTpjhRNfpTcBsOIbgnifb8jY/TcDEn4SgxiYKhO+G4xTs8TVOINrR+4LGjg8sF5KfbawI4O
X-Received: by 10.36.65.161 with SMTP id b33mr5173376itd.114.1484351541971;
 Fri, 13 Jan 2017 15:52:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Fri, 13 Jan 2017 15:52:21 -0800 (PST)
In-Reply-To: <xmqqfukmedca.fsf@gitster.mtv.corp.google.com>
References: <20170113194326.13950-1-sbeller@google.com> <xmqqfukmedca.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 13 Jan 2017 15:52:21 -0800
Message-ID: <CAGZ79kYg=nJ8EqBEhoiWm2XRh3_3AuL7Qw-dCSKZqPO6CjFFwg@mail.gmail.com>
Subject: Re: [PATCH] submodule update: run custom update script for initial
 populating as well
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Chris Packham <judge.packham@gmail.com>,
        Spencer Olson <olsonse@umich.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2017 at 3:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> In 1b4735d9f3 (submodule: no [--merge|--rebase] when newly cloned,
>> 2011-02-17), all actions were defaulted to checkout for populating
>> a submodule initially, because merging or rebasing makes no sense
>> in that situation.
>>
>> Other commands however do make sense, such as the custom command
>> that was added later (6cb5728c43, submodule update: allow custom
>> command to update submodule working tree, 2013-07-03).
>
> Makes sense.
>
>> I am unsure about the "none" command, as I can see an initial
>> checkout there as a useful thing. On the other hand going strictly
>> by our own documentation, we should do nothing in case of "none"
>> as well, because the user asked for it.
>
> I think "none" is "I'll decide which revision of the submodule
> should be there---do not decide it for me".  If the user is
> explicitly saying with "git submodule init" to have "some" version,
> and if the user did not have any (because the user didn't show
> interest in any checkout of the submodule before), then I think it
> probably makes more sense to checkout the version bound to the
> superproject, than leaving the directory empty.
>
>> Reported-by: Han-Wen Nienhuys <hanwen@google.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  git-submodule.sh            |  7 ++++++-
>>  t/t7406-submodule-update.sh | 15 +++++++++++++++
>>  2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 554bd1c494..aeb721ab7e 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -606,7 +606,12 @@ cmd_update()
>>               if test $just_cloned -eq 1
>>               then
>>                       subsha1=
>> -                     update_module=checkout
>> +                     if test "$update_module" = "merge" ||
>> +                        test "$update_module" = "rebase" ||
>> +                        test "$update_module" = "none"
>> +                     then
>> +                             update_module=checkout
>> +                     fi
>
> ... which seems to be what you did.  Do we need a documentation
> update, or does this just make the behaviour of this corner case
> consistent with what is already documented?

I think we do not need to update the documentation, because the
documentation doesn't call out the first/initial call to update to be special.
So for a non existing submodule we can do:

    git submodule update --init --[rebase|merge]

and that falls back to checkout, which *looks* like it was a rebase/merge.
The original bug report was that

    $ git config submodule.<name>.update !echo-script.sh
    $ git submodule update <submodule>
    Submodule path '<submodule>': 'echo-script.sh'
    $ rm -rf <submodule>
    $ git submodule update <submodule>
    .. checked out ..

So while I usually think more verbose documentation is a good idea,
this time it's different, as it merely aligns current documented
behavior with reality.

Thanks,
Stefan
