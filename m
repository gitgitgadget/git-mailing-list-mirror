Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A56C1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 22:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755112AbcHWWpB (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 18:45:01 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36574 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753456AbcHWWpA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 18:45:00 -0400
Received: by mail-yw0-f195.google.com with SMTP id u134so5778805ywg.3
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 15:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5UDXgL6qXa9IGue2SSQtuSWZOxF8arQa9FaVU5BWtlM=;
        b=Xpd0DCgJGQwx+QpL2VHNPNWrlGHvrzBkBLwjvjBTSYpcEyBtTZK+HBzk9e2/EUDyhU
         NRO9CzGEsT9mKlqMzgvXgfRGq1LPQn249VFD06aGj2z/Qqchq1IkWX0OFaENA5HVjFfh
         YRKDCnsc0lS0HIXf6va0UipGm73nX70BVnwJ7aL7Ivwtzkndlyskyk2KUcHjhEdzSAQJ
         1K/1VOm7nJ9WhYFSKqDvRk3qKoeFtyjM0HgE01VGyaPg7vTdlZyvN71DcV4jOEf3ogeQ
         R4qLUEIkitXTC2DbVYZp3+oz65cRFmxNR/YzTCJyJZ22nb7KCzxtqSC09OHBTwGd3vtK
         AjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5UDXgL6qXa9IGue2SSQtuSWZOxF8arQa9FaVU5BWtlM=;
        b=E/ppz5/G0LTYe352k1LyC8yBJ4ufmB4Cl6vRe3YW5Q/Vj19WYwgCNfBv7pg2BSm5WJ
         7RP6xOZ8VB5wdSNdHeHSp04t7r9twrioQ6Xy8Pc5YrdvcLrQY6hTM2NJzhs8rGwPYdTt
         edbLqtTrFP0dC7oEqaVmq/RuREK23mfLHYSWSRX0tMKdH1KNTscXdJs8avZwOwthLFQy
         dw6Wa19OWReCWC7EC0WoAIfiCl85GFcy/cPJCkT9Kxcc9H9wGHwZaSbHdYgyUwUGzN0W
         H2c1X5jKnjDhHOfUdp2kx5HwgKOC/jlx4aTE8jnjp5vHIbya0O4vdMC4XHIbeFEYCSqS
         52SQ==
X-Gm-Message-State: AEkoouu9jB6xEzWUPzy739rwfR+dcwfYJFyEfVTseWyjpRSAnbkCEe3G5+STD4wrIq5/vxLN8ozgi+TQkczFcg==
X-Received: by 10.129.135.2 with SMTP id x2mr23860495ywf.310.1471992272485;
 Tue, 23 Aug 2016 15:44:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Tue, 23 Aug 2016 15:44:12 -0700 (PDT)
In-Reply-To: <xmqqk2f7t8ra.fsf@gitster.mtv.corp.google.com>
References: <20160823214620.28624-1-jacob.e.keller@intel.com> <xmqqk2f7t8ra.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 23 Aug 2016 15:44:12 -0700
Message-ID: <CA+P7+xrUnwxa9GqutKGcirrOLKysCn=RLaeMUpgtKF173VxHpA@mail.gmail.com>
Subject: Re: [PATCH v2] format-patch: show 0/1 and 1/1 for singleton patch
 with cover letter
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 3:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> diff --git a/builtin/log.c b/builtin/log.c
>> index 92dc34dcb0cc..49aa534f4a01 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -1676,16 +1676,16 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>>               /* nothing to do */
>>               return 0;
>>       total = nr;
>> -     if (!keep_subject && auto_number && total > 1)
>> -             numbered = 1;
>> -     if (numbered)
>> -             rev.total = total + start_number - 1;
>>       if (cover_letter == -1) {
>>               if (config_cover_letter == COVER_AUTO)
>>                       cover_letter = (total > 1);
>>               else
>>                       cover_letter = (config_cover_letter == COVER_ON);
>>       }
>> +     if (!keep_subject && auto_number && (total > 1 || cover_letter))
>> +             numbered = 1;
>> +     if (numbered)
>> +             rev.total = total + start_number - 1;
>>
>>       if (!signature) {
>>               ; /* --no-signature inhibits all signatures */
>
> That sounds sensible.
>
>> diff --git a/t/t4021-format-patch-numbered.sh b/t/t4021-format-patch-numbered.sh
>> index 886494b58f67..ea0a388f0191 100755
>> --- a/t/t4021-format-patch-numbered.sh
>> +++ b/t/t4021-format-patch-numbered.sh
>> @@ -36,6 +36,11 @@ test_no_numbered() {
>>       test_num_no_numbered $1 2
>>  }
>>
>> +test_single_cover_letter_numbered() {
>> +     grep "^Subject: \[PATCH 0/1\]" $1 &&
>> +     grep "^Subject: \[PATCH 1/1\]" $1
>> +}
>> +
>>  test_single_numbered() {
>>       grep "^Subject: \[PATCH 1/1\]" $1
>>  }
>> @@ -50,6 +55,11 @@ test_expect_success 'single patch defaults to no numbers' '
>>       test_single_no_numbered patch0.single
>>  '
>>
>> +test_expect_success 'single patch with cover-letter defaults to numbers' '
>> +     git format-patch --cover-letter --stdout HEAD~1 >patch0.single &&
>> +     test_single_cover_letter_numbered patch0.single
>> +'
>
> The remaining and existing tests seems to expect that the result of
> each test is stored in a distinct file so that the output can be
> inspected after seeing a test failure without running the script
> with the "-i" option.  Perhaps rename this to patch0.single-cover or
> something?  The same for the overwriting of patch1 we can see below.
>

Hmm, ya. I'll rework that.

Thanks,
Jake
