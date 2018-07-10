Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46D421F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388632AbeGJScb (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:32:31 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:40467 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387739AbeGJSca (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:32:30 -0400
Received: by mail-ua0-f193.google.com with SMTP id p22-v6so4031480uao.7
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AQKNA2emNWi8Jx1hwdd3RB3Zw0W1KIfIGMvlaCpY9S0=;
        b=iUnLDTRGFFx0k4Brgf1210jJuhwu8692y1d4onAhfNRrPbpL/Ounxgg8YsZC9MTdqv
         CYhtyBFFU1A/SFGahGB/QP7QxMhq47v1RlRxcdTRTyKZpPXWy6TzFtHrQ7fDezt2nfq4
         T9N6EnlcV2OkeKHAL2hq8W4VeQBBnSYVueBy3D6gYPlRazvYd0z+MyhVp6VEO2Sj2NP8
         VqMmsUeSNtMOjhI+xA6fKNTR+yj5e6wQAa1SFMmWguPmum+6WuOhupn5ONsFyLFPo44E
         zo1jNBvqv3yl9Kdk+iRZMjP6YMuujsaevD3feCllC6Xml1SH9PIUGG9khnjpvRDRwlmz
         27/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AQKNA2emNWi8Jx1hwdd3RB3Zw0W1KIfIGMvlaCpY9S0=;
        b=HRq7+sHTzOJoxJ1kHs/9zeCctWAzGNuGczTmE+1SBVXrpjPT2Lqf2Dxx1Z4p48MbHY
         Up1MTH3MCTqmnhpe9bp7ty+rpRTJ37t5SHdcHD57UhyNcl9/6judN9LUsOXM/cDFwDd3
         UzKDdltw7nNc61xfE1klmiyUvaV/2K1zxA+8cOJOecpaBdnZFMg7AiaqKilIDpu5PA/Y
         V2aK1VyzDjGU6/MMp1FY/0M90Qwbg29WJKv7o0J1Vmx62ZjZBBwppMk3DZKDuWmIQug7
         Bv96Xoz/ENTkv5vtIGSmup+BLkfqXeSHpyhp5yJj4Q6M+3z1am5Idya9F3dxzBOzsa/C
         BKVQ==
X-Gm-Message-State: APt69E1sL+EPESBV4Jlv7L5nlLEKbXm+QG3o24ifnvexVCQ5gL0kDFDD
        1vkDS1qfeVK2BnVYjBLIfW8QfvN01nqisIgXRUE=
X-Google-Smtp-Source: AAOMgpfUv+3OHQ2+hk1RcK4+Vv1SiomxgxwDlGWpB6vuMvOyE+m+LEmj0uziPSC+KgxCqCDB/3bw81TKO8RGURYh7ps=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr15919682uaf.199.1531243814311;
 Tue, 10 Jul 2018 10:30:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 10:30:13
 -0700 (PDT)
In-Reply-To: <CAGZ79kYK4uwUeDECoabrXJesVzgFBKNejV3reJOXhMyYxUjXyw@mail.gmail.com>
References: <20180707204404.7208-1-newren@gmail.com> <20180707204404.7208-2-newren@gmail.com>
 <CAGZ79kZ0xyHMT8SngGCUSAEf31NXdPvzkvdaPb8Khm27xRjgTg@mail.gmail.com>
 <CABPp-BFjZZZ9uGXYe0gAA_VvcFmTsnurAknVrr-CytP2hT6wLg@mail.gmail.com> <CAGZ79kYK4uwUeDECoabrXJesVzgFBKNejV3reJOXhMyYxUjXyw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 10 Jul 2018 10:30:13 -0700
Message-ID: <CABPp-BE1kqjiGPqJfrsj8AiFnWg0CUZErUnDb8dAvXWkt7cDMA@mail.gmail.com>
Subject: Re: [PATCH 1/3] t7405: add a file/submodule conflict
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 8:53 AM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jul 10, 2018 at 8:28 AM Elijah Newren <newren@gmail.com> wrote:

>> 2) I didn't just check what was currently failing but other things
>> that should be true for this test.
>>
>> For item 2, I've had multiple cases in the past where I created a
>> minimal test, only to find that if I had more carefully checked the
>> expected results that it would have prevented a future bug.  Also, it
>> was harder in the future to figure out, because I no longer remembered
>> the context for the test setup.  So, in this test I check the contents
>> of the index, make sure that the submodule is still present, and then
>> I finally check for the thing that currently fails:
>>
>> commit B added a file called 'path'; its contents should appear
>> somewhere in the directory for the user to use when trying to resolve
>> the failed merge.  It cannot appear at 'path' (there's a submodule in
>> the way from commit A), but it should be present somewhere, and in
>> particular I'd expect it in the same directory.  So, I simply grep all
>> files in the current directory for the string (and ignore errors about
>> 'grep: path is a directory').
>>
>> Does that help?  If so, I'll submit a reroll with the changes and a
>> few extra comments.
>
> That does help; yes, I thought
> * we want to check for the file content of the file to be somewhere
>   (maybe path.file?)

Yes.  I wanted to avoid nailing down the expected pathname until the
code was in place that handled this case.  merge-recursive currently
elsewhere uses path~$BRANCH to workaround conflicting paths, but I had
a (half-baked-so-far) idea for changing some of the path-conflict
stuff which would involve different names.  So, I just left it
undecided until implemented.

> * equally we'd want to have the submodule somewhere; you seem
>   to expect it at path (we could have moved it to path.sub or path.git,
>   but that involves extra work as we have to update the .gitmodules
>   file to have the correct path <->name mapping)

Yes I wanted it at path for a specific reason: git can detect renames
of files, and now of directories, but not of submodules, so it seems
more important to keep the submodule where it is when possible.
(merge_file_1() has code running counter to this, but that pre-dates
submodules and should be updated, IMO.)

> * good call with the index, I skimmed over the ls-files calls not thinking
>   what they'd check.
>
> So for now only the "file content is missing" part is failing the test,
> whereas the rest is successful.
>
> Thanks for the explanation!
> Stefan

:-)
