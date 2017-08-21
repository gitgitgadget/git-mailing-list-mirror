Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBE48208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 17:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754154AbdHURYJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 13:24:09 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34201 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753961AbdHURYI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 13:24:08 -0400
Received: by mail-io0-f195.google.com with SMTP id p141so3615387iop.1
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 10:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TwK1IAGNOZFplsFThOJ5dvIl/gERz1dvMsf9QeF3bNU=;
        b=bwb2z7cKFH1pJ/I+D2yi3sVsMJjjhs/TLPn+eSbvEJyQxWeMErbBWcNiskat80K0/r
         xSINaVWxeO7Gxk98KECdTbF15mgOOZgAeRGc6DASZbqG+jYHpGPlg50/St+0xJ/+7EM5
         T+dDhRtxKmshM7oasZYdM6ijKDrkanCJFVas9H+PVScyGrKPiT1iocRtuCGYmD2iYd1J
         gNF81YX3hjZyl1dUXtsDAeJXvKWMkSU9cgbz/JmWcXnislNu2SIXhh945ILdvepagQxu
         O3Nu1RDYyAQGK2M19wSRcinTJz2a5QZjrR4G3EkMWG9G++neY0kmho9ieNbTyyitmpXV
         +91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TwK1IAGNOZFplsFThOJ5dvIl/gERz1dvMsf9QeF3bNU=;
        b=V0yJLu0RyhB5veQ4JSdIOtZLhp6o5XcZREJfOehNQzgHOZxQppS0jNXYzq8WAtwwv4
         MFZldM9DctLivgBC82N2vPs49pNgpM4AqTfmmYCWlFunJA57DMk/1DA2zRAyKk1w9/lH
         Tv4BO/SX0LXnkTwxs/OxPsSGNPYG0xDniOgnZ09B1hQBpxHRwJDNRd+z2Smu34WfQBmo
         Wsp/9CjePEZ5EodNZ2T2OKyC14faH2jI5iPLTBls39wZGDWfZpQtd9Txagy6T83Jf6NJ
         bOnsKn8H+9LvTWx3LMzcELj/IkM9IJjUanxjB4rvwv6CArh9EVKxKRd8ye7U+TrOCWvq
         TULQ==
X-Gm-Message-State: AHYfb5hEGvCICalOh4KE/w88vmzcmTRkiYNgnSTiBleYoyNQjK7E5qTt
        Ri2tKK4c14WjbDtxjK3asAUfNbM5Fg==
X-Received: by 10.107.39.71 with SMTP id n68mr19048856ion.71.1503336247420;
 Mon, 21 Aug 2017 10:24:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.149.134 with HTTP; Mon, 21 Aug 2017 10:24:06 -0700 (PDT)
In-Reply-To: <20170821164730.GC1618@book.hvoigt.net>
References: <20170821161515.23775-1-pc44800@gmail.com> <20170821161515.23775-3-pc44800@gmail.com>
 <20170821164730.GC1618@book.hvoigt.net>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Mon, 21 Aug 2017 22:54:06 +0530
Message-ID: <CAME+mvWTNSUkK5zKTTAEU2SGxM9TgjjBywJ_FTLW_wLHRT=iAw@mail.gmail.com>
Subject: Re: [GSoC][PATCH 3/4] submodule: port set_name_rev() from shell to C
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2017 at 10:17 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Mon, Aug 21, 2017 at 09:45:14PM +0530, Prathamesh Chavan wrote:
>> Function set_name_rev() is ported from git-submodule to the
>> submodule--helper builtin. The function get_name_rev() generates the
>> value of the revision name as required, and the function
>> print_name_rev() handles the formating and printing of the obtained
>> revision name.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
>> ---
>>  builtin/submodule--helper.c | 63 +++++++++++++++++++++++++++++++++++++++++++++
>>  git-submodule.sh            | 16 ++----------
>>  2 files changed, 65 insertions(+), 14 deletions(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 7803457ba..a4bff3f38 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>
> [...]
>
>> @@ -1242,6 +1304,7 @@ static struct cmd_struct commands[] = {
>>       {"relative-path", resolve_relative_path, 0},
>>       {"resolve-relative-url", resolve_relative_url, 0},
>>       {"resolve-relative-url-test", resolve_relative_url_test, 0},
>> +     {"print-name-rev", print_name_rev, 0},
>
> I see the function in git-submodule.sh was named kind of reverse. How
> about we do it more naturally here and call this 'rev-name' instead?
> That makes is more clear to me and is also similar to the used variable
> name 'revname'.

The functions 'print_name_rev()' and 'get_name_rev()' are the ported
C functions of the function 'set_name_rev()'
Their names were assigned so due to the existing function's name,
and hence to faithfully port the functions.

But, thanks for the above suggestion, and also for reviewing
the patch. I will update the names as print_rev_name() and
get_rev_name() respectively.
>
> I would also prefix it differently like 'get' or 'calculate' instead of
> 'print' since it tries to find a name and is not just a simple lookup.

The former function from the shell script, 'set_name_rev()' is split
into two functions, namely: 'print_name_rev()' and 'get_name_rev()'
The function print_name_rev() is just the front_end of the function,
and exists to printf the return value of the get_name_rev() function
is the required format.
Calculation of the value is actually done by the function
get_name_rev().
Hence, I named the functions the way they are.

Thanks,
Prathamesh Chavan
