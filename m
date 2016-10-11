Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFB291F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 18:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753668AbcJKS2J (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 14:28:09 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35351 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753178AbcJKS2J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 14:28:09 -0400
Received: by mail-qk0-f176.google.com with SMTP id z190so3408431qkc.2
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wllI8K3DqTFYgRxNzCG9HFH+Hs+6DvRbqlbPr/1yu0Y=;
        b=j5Qb/ZG0OYbX8rhwomZmNw7S3Ut6lJiYKGNujbmisSc+GF055Lnhixl6jwfKiVs0sr
         CfHTaiDHZ5p9k2zbOn2C+QjJv2R1PgDffZmkf6zKSDg30HbMumkB3lmSSOSTvq4D6B1y
         xmazNh1CoomHFMAW32w8oN9wu2VWM05vf5CpfgnMNOi8MyLv67shzhxGZQUXRDb37mD/
         ZR/sFas0+c106a3shzzu6X6gX83O+Umt4hg1VkEI9/xVx2Lo8s5GWgIxizec0R3FF9tm
         Qxp3bU74NcDBVU8woYtO8tczmRl8ZO5NWZsPcb3Jb9zcN4CKlR2S7I5UXo7PJWFEX263
         nJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wllI8K3DqTFYgRxNzCG9HFH+Hs+6DvRbqlbPr/1yu0Y=;
        b=Z4bR4xGoNAWYJTb55d0Hj+A7bsXjPUCiDlJHyBsl8B73q/XK04NIzFX22easIXEnYi
         ayLVKEto9NZVq0TzABO9y6Yx1yBU0VrJ1xnkJaFa0O2Uyves5IAPjowa1ZTMA+DZBlzb
         ThZcOb+hm/f9wKe8ov8AjFyBpEyZcSOTTnRNQVg6LBEMwzDzDSF9aMFxM9aLoI4H7rBS
         SG3ThdITVm3IXDKCn1CmfwzH2vjPgldSB65NoQsVGtGOb/kZTTc0RyL3vwUc657PqXIU
         6SqKJ9YQ+QfNr5giWCt/8+nr1mqMtpVSwIfMFVL3n04clldua0ifwkZhqB7rMhK2jinm
         cbKw==
X-Gm-Message-State: AA6/9RnsDyQSGuryVYzAjPyblbjo25zjT3kgoEPspu4E/kBcA0aDmo8NHLL8PTDOJ0LW+ywqmP8O6ROWH5zqnh1K
X-Received: by 10.55.64.80 with SMTP id n77mr5231892qka.173.1476210487933;
 Tue, 11 Oct 2016 11:28:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 11 Oct 2016 11:28:07 -0700 (PDT)
In-Reply-To: <20161011172805.GB9085@google.com>
References: <20161011002115.23312-1-sbeller@google.com> <20161011002115.23312-18-sbeller@google.com>
 <20161011172805.GB9085@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Oct 2016 11:28:07 -0700
Message-ID: <CAGZ79kbqikTtUGxXFB3W9k1nL6ST2iwRRi5zEuL9BOpHxZWc8A@mail.gmail.com>
Subject: Re: [PATCH 17/28] attr: expose validity check for attribute names
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 10:28 AM, Brandon Williams <bmwill@google.com> wrote:
> On 10/10, Stefan Beller wrote:
>> From: Junio C Hamano <gitster@pobox.com>
>> -static int invalid_attr_name(const char *name, int namelen)
>> +int attr_name_valid(const char *name, size_t namelen)
>>  {
>>       /*
>>        * Attribute name cannot begin with '-' and must consist of
>>        * characters from [-A-Za-z0-9_.].
>>        */
>>       if (namelen <= 0 || *name == '-')
>> -             return -1;
>> +             return 0;
>>       while (namelen--) {
>>               char ch = *name++;
>>               if (! (ch == '-' || ch == '.' || ch == '_' ||
>>                      ('0' <= ch && ch <= '9') ||
>>                      ('a' <= ch && ch <= 'z') ||
>>                      ('A' <= ch && ch <= 'Z')) )
>> -                     return -1;
>> +                     return 0;
>>       }
>> -     return 0;
>> +     return -1;
>> +}
>
> Whats the reason behind returning -1 for a valid attr name vs 1?
>

Usually we prefer negative values for errors, whereas 0,1,2...
is used for actual return values.

If you're not really interested in the value, but rather "does it work at all?"
you can use it via

    if (function() < 0)
        die_errno("function has error");

Otherwise you'd do a

    int value = function();
    if (value < 0)
        die(...);

    switch(value) {
    default:
    case 0:
        doZeroThing(); break;
    case 1:
        doOtherThing();
    }

At first I thought the two different return path for -1 are different
error classes (one being just a minor error compared to the other),
but they are not, so having the same code there makes sense.

So I think we could change it to +1 in this instance, as a non zero
value would just indicate the attr name is not valid, but not necessarily
an error.
