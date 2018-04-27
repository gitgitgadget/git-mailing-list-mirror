Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E06FE1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 00:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753646AbeD0AyW (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 20:54:22 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37766 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbeD0AyV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 20:54:21 -0400
Received: by mail-qk0-f194.google.com with SMTP id d74so172436qkg.4
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 17:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z4eqC17Fw1M2XUQSOf+rYc/457YedUn1FZRMYyYzBkw=;
        b=CoWY/pX/xWwHPJE67NvsPlojHYZBsirY3ACWlWUGtA0nQh6GJt6oMCuZBBa2YUcZBh
         DD57ekt0jTXtC6n+Ey9+wCqdT0EH2WkQZ9IM5+y95vpnHUQ08vubPcbb55v6hpDx6pT7
         ji0IOWKBmLEPpcB5R/RkVvMPOMeFqLGwZXAFaveCSTbybc9m21VQF5i8L7JRvhnrUIYM
         wA49pDwRrcLT0Otvu1iek+zNusxMtKrPyDbBWFgqE+MyXcnxHDe8bGanhAygbvu0kPlv
         AVLA6BfUkg4gnxrYpAXJbBEZysRTQ+d1FS59im4uYuYyQkfLPWuKFkF1eYNQX51mZlNN
         lWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z4eqC17Fw1M2XUQSOf+rYc/457YedUn1FZRMYyYzBkw=;
        b=NSmwOP3WGUTlnbuYxmROnWkQAUzavaaXvf8nQ8yEqhIByIXZXgK/3DjAKcZqO6/Ahs
         cv6ToOr/GiqEbx9BWAiLLIvHzdXsyDcO8b8g863GO3rQ/rywcouGqc4DWApOLxZAT6gc
         phhDOie1KtVa6CahOEk+lyM7OjO9dmRGXZkaejReh4+rBWxW/YdGZM6zMRsP8C5PWrbx
         AxTmR60xCDmgTj+YtM5/FEsdhaO8mt+g9SBQK5C2Achp0M4b7bbA/KyUo/FBw53FiKGx
         Wj3iREbwrj0ZPDbjg13JrzKtHdS3mauTZi4OsSTBLz3DIdc47Yx6jtxJ9PcILBKZGLev
         FjNg==
X-Gm-Message-State: ALQs6tBHspp2qzoHEri587wr93CyYBcAjKj/IgFHMdQSB9yNKY8SnBiR
        tWc2t0Ei6lHBJfWuPjfanP4=
X-Google-Smtp-Source: AB8JxZq60m+r5ufS9xBpIQs4QadKYoajK54KJY0/QImPu/xjcUc1pfbDTc143nKs+fJtb8gkG7/GpQ==
X-Received: by 10.55.53.7 with SMTP id c7mr247849qka.58.1524790460369;
        Thu, 26 Apr 2018 17:54:20 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id d1-v6sm124124qtk.57.2018.04.26.17.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Apr 2018 17:54:19 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] merge: Add merge.renames config setting
To:     Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180426205202.23056-1-benpeart@microsoft.com>
 <20180426205202.23056-3-benpeart@microsoft.com>
 <CABPp-BE29rwZCDqFHH-nzrDub6MMdtoiorj0jv3K6B6cmfcaLA@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <7de8f144-8a37-e471-48e8-0b6f17a7bf29@gmail.com>
Date:   Thu, 26 Apr 2018 20:54:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BE29rwZCDqFHH-nzrDub6MMdtoiorj0jv3K6B6cmfcaLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/26/2018 6:52 PM, Elijah Newren wrote:
> On Thu, Apr 26, 2018 at 1:52 PM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> 
>> +merge.renames::
>> +       Whether and how Git detects renames.  If set to "false",
>> +       rename detection is disabled. If set to "true", basic rename
>> +       detection is enabled.  If set to "copies" or "copy", Git will
>> +       detect copies, as well.  Defaults to the value of diff.renames.
>> +
> 
> We shouldn't allow users to force copy detection on for merges  The
> diff side of the code will detect them correctly but the code in
> merge-recursive will mishandle the copy pairs.  I think fixing it is
> somewhere between big can of worms and
> it's-a-configuration-that-doesn't-even-make-sense, but it's been a
> while since I thought about it.

Color me puzzled. :)  The consensus was that the default value for 
merge.renames come from diff.renames.  diff.renames supports copy 
detection which means that merge.renames will inherit that value.  My 
assumption was that is what was intended so when I reimplemented it, I 
fully implemented it that way.

Are you now requesting to only use diff.renames as the default if the 
value is true or false but not if it is copy?  What should happen if 
diff.renames is actually set to copy?  Should merge silently change that 
to true, display a warning, error out, or something else?  Do you have 
some other behavior for how to handle copy being inherited from 
diff.renames you'd like to see?

Can you write the documentation that clearly explains the exact behavior 
you want?  That would kill two birds with one stone... :)

> 
>> diff --git a/merge-recursive.h b/merge-recursive.h
>> index 80d69d1401..0c5f7eff98 100644
>> --- a/merge-recursive.h
>> +++ b/merge-recursive.h
>> @@ -17,7 +17,8 @@ struct merge_options {
>>          unsigned renormalize : 1;
>>          long xdl_opts;
>>          int verbosity;
>> -       int detect_rename;
>> +       int diff_detect_rename;
>> +       int merge_detect_rename;
>>          int diff_rename_limit;
>>          int merge_rename_limit;
>>          int rename_score;
>> @@ -28,6 +29,11 @@ struct merge_options {
>>          struct hashmap current_file_dir_set;
>>          struct string_list df_conflict_file_set;
>>   };
>> +inline int merge_detect_rename(struct merge_options *o)
>> +{
>> +       return o->merge_detect_rename >= 0 ? o->merge_detect_rename :
>> +               o->diff_detect_rename >= 0 ? o->diff_detect_rename : 1;
>> +}
> 
> Why did you split o->detect_rename into two fields?  You then
> recombine them in merge_detect_rename(), and after initial setup only
> ever access them through that function.  Having two fields worries me
> that people will accidentally introduce bugs by using one of them
> instead of the merge_detect_rename() function.  Is there a reason you
> decided against having the initial setup just set a single value and
> then use it directly?
> 

The setup of this value is split into 3 places that may or may not all 
get called.  The initial values, the values that come from the config 
settings and then any values passed on the command line.

Because the merge value can now inherit from the diff value, you only 
know the final value after you have received all possible inputs.  That 
makes it necessary to be a calculated value.

If you look at diff_rename_limit/merge_rename_limit, detect_rename 
follow the same pattern for the same reasons.  It turns out 
detect_rename was a little more complex because it is used in 3 
different locations (vs just one) which is why I wrapped the inheritance 
logic into the helper function merge_detect_rename().
