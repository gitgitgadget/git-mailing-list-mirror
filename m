Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 942191F40E
	for <e@80x24.org>; Sat, 12 Nov 2016 09:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755944AbcKLJ5J (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 04:57:09 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34483 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753684AbcKLJ5I (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2016 04:57:08 -0500
Received: by mail-yw0-f176.google.com with SMTP id t125so32066786ywc.1
        for <git@vger.kernel.org>; Sat, 12 Nov 2016 01:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MimsQvW5h6zYUSn4tVTvIcqjWjwiDgyUNnn2rB/j0l4=;
        b=HqlvxBBGpYNK3Wj47HcWlLBR2Hn2BjJo2STfZBSg0NUsilT1zeS5+VYCpnbmODA3gA
         UGcrSyl/5mXQ9DajUq1GSiWgR1B7T5+rQveu2rtl/e0rcZeGG7JeQkh1B6KJ8N6WUdRp
         ffXN18G0GtDTqffND2TVlfeLJM031cQey20V+HG/2yn41TzwbzKvLj6H7gz6Lj2kjumK
         MaXR4DqGuPl6xq/iC79AbVQSW3ROLau9wkdlOW4vR2jFm73HibqPbrTgn2WgYEDwd3iz
         mNMJBCVMSYZE1LMqOumBaBcyDVRnPb3J72Nfa2fTOI107ma77WIMdl5FA8QYn4JFAFWR
         LxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MimsQvW5h6zYUSn4tVTvIcqjWjwiDgyUNnn2rB/j0l4=;
        b=bLQesP31c0NCQWTt2Ao2jYxx6a7hLzdYNHzvaGa9XjX/NwSVC4ZZn5FAmn7k76I/un
         CnZ8rFG3ZQcNS0+cI4i57dkFhGqqeoFh38NqeoztcloP0pFTTTRE9uTGmmOicGg5PdGv
         ni5y8J3cxB701awM+8M9kD07cXiG5akPQjZll5HyEMMzsbKHmwskuETpHQ3g7ac02j8x
         i0dA0TeSz9du3w3RSVFN4RN83kAWEUM/hKJO92bkdGtQhtqiItjUtl+PN697tM4TSzqH
         0Ji9IjUe9oUbVuZZfDhl7R2yjVLqTezJ406Z0Oyq75pP8LtHpdnB0D9lUQ2wCYz6Qn99
         X1iA==
X-Gm-Message-State: ABUngvdZyYSoU/rieCholuDjnlMFSp4DZ75UqSb+6sYn9fAKo+5wIA4VAwCVrZjTHGbfx8DBxagtYFy2VM1waw==
X-Received: by 10.13.200.134 with SMTP id k128mr6704182ywd.72.1478944617536;
 Sat, 12 Nov 2016 01:56:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Sat, 12 Nov 2016 01:56:27 -0800 (PST)
In-Reply-To: <CA+P7+xqXY6XvUm8Kna_GwY4XOSSGPM=-ezZECgkGcbnX_Penmg@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-5-Karthik.188@gmail.com>
 <CA+P7+xqG5ACT2ZB=M8gLmDaYgSgX202+afJmZJKat6NzbFzL=g@mail.gmail.com>
 <CAOLa=ZRDNGGc-OA+d+T1=9JvoVe2eBZt0DYQEHmeNKhDpxQbdg@mail.gmail.com> <CA+P7+xqXY6XvUm8Kna_GwY4XOSSGPM=-ezZECgkGcbnX_Penmg@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sat, 12 Nov 2016 15:26:27 +0530
Message-ID: <CAOLa=ZQ1L2-yGH_1E6p0-UdbXpyujEzF6V-znyw3H0ZLbbjW+w@mail.gmail.com>
Subject: Re: [PATCH v7 04/17] ref-filter: modify "%(objectname:short)" to take length
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Fri, Nov 11, 2016 at 10:59 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Thu, Nov 10, 2016 at 9:36 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Wed, Nov 9, 2016 at 4:57 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>
>> That does make sense, It would also not error out when we use
>> %(objectname:short=) and
>> not specify the length. Idk, if that's desirable or not. But it does
>> make the code a little more
>> confusing to read at the same time.
>>
>
> I am not sure that would be the case. If you see "objectname:short"
> you trreat this as if they had passed "objectname:short=<default
> abbrev>" but if you see "objectname:short=" you die, no?
>

Sorry, my bad.



On Fri, Nov 11, 2016 at 5:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>       else if (!strcmp(arg, "short"))
>> -             atom->u.objectname = O_SHORT;
>> -     else
>> +             atom->u.objectname.option = O_SHORT;
>> +     else if (skip_prefix(arg, "short=", &arg)) {
>> +             atom->u.objectname.option = O_LENGTH;
>> +             if (strtoul_ui(arg, 10, &atom->u.objectname.length) ||
>> +                 atom->u.objectname.length == 0)
>> +                     die(_("positive value expected objectname:short=%s"), arg);
>> +             if (atom->u.objectname.length < MINIMUM_ABBREV)
>> +                     atom->u.objectname.length = MINIMUM_ABBREV;
>> +     } else
>>               die(_("unrecognized %%(objectname) argument: %s"), arg);
>>  }
>
> Users who want to use the default-abbrev, i.e. the autoscaling one
> introduced recently, must use "short", not "short=-1", with this
> code (especially with the "must be at least MINIMUM_ABBREV" logic),
> but I do not think it is a problem, so I think this is good.
>

I think I'll leave this as it is. If that's okay

-- 
Regards,
Karthik Nayak
