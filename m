Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE9891F404
	for <e@80x24.org>; Tue,  6 Feb 2018 17:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeBFRx3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 12:53:29 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34989 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbeBFRx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 12:53:27 -0500
Received: by mail-yw0-f195.google.com with SMTP id u21so1940245ywc.2
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 09:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=ePkmUKCu0nZHJmVb77jvJyt7Ib6n5zA3/VMirmcw4EE=;
        b=qaDzSgnZvaVojKIBZMLBCtiMpPybPMKfaORfFuwN5zSQDhgQO1kIBzeHFQ6gDgJe+2
         /5XgEj70sZH2XW2gkgPFhazVnii9+f2i3M+avlZKFLq6z6dZhjNKbSFphUejcT7h9YGU
         3n8ELvK6ndTkOpGFmo64OMV1M99CfHjGOjXuxsyxC07SHeYdcqlgsTDn2u3i1x6ufZJp
         99wEu0BjrcoZMl675BO+ZwS4yqGFMT0PxsUjHgC4ootLPp7TIoZE7lTOMXKY8dQETdsZ
         LbHI2gPJCrDDCF+EL0wsN9jJDMGCA4iSJx1wmo9T5B43tyQDoQG6ch2HLAw9c2qwq2G/
         a/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=ePkmUKCu0nZHJmVb77jvJyt7Ib6n5zA3/VMirmcw4EE=;
        b=NC76dgqbbxCFdC9uRaFQDxboQ1lFCAFy5zdY7h++UM7EbR3oQzaCSXzD6mAa4JMAmg
         MILYz9AVoUnH3LyB4ICsxR9LeONG7BiIeAvV48NXwsCESUcTBOwtiRjw+8BGERv8p5NE
         khZC9txTOe80V9Bh43LZg6Z+CxyeqUhdcZvBxnwe8Cl0ymyKuekA5mYPmPx/7gLebNI+
         U61eBNh0iemAuTHsIBkpkpAFfP2SI6V8uK4S86U29fZqU3gpZs+DpBqPr2lGy600Pwu6
         gbIxyUcArj00X63ZKUe72PMqfGXu0FmZmz/wsdKN8YeN8DIbtw4PdzrZ+JVOBUZcafwf
         WtBA==
X-Gm-Message-State: APf1xPBxWM/ukD9E4cxY86wjk6U4+cj9o4kg/K5HbBNAara4X+2Y9usY
        6tvJCN8E82Gr8ItZWIno8rdcRo4x39oM546UJSbUoqbC
X-Google-Smtp-Source: AH8x22578OyJsJOVjX4fSuSUchubuETn4JWbXMmFNN0ZMAxgiXAGXJkd5jaCSH4cjzUUrKp2Xkqv6oVguuS4UHKWpTA=
X-Received: by 10.129.119.131 with SMTP id s125mr1936973ywc.166.1517939606402;
 Tue, 06 Feb 2018 09:53:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 6 Feb 2018 09:53:25 -0800 (PST)
In-Reply-To: <20180206014457.GE7904@genre.crustytoothpaste.net>
References: <20180205235508.216277-1-sbeller@google.com> <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-22-sbeller@google.com> <20180206014457.GE7904@genre.crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Feb 2018 09:53:25 -0800
Message-ID: <CAGZ79kbycmoA1DUVEoMAzvmyT3zMtTPFBOV6AGm_-xACDePETA@mail.gmail.com>
Subject: Re: [PATCH 042/194] object-store: move alternates API to new alternates.h
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 5:44 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Feb 05, 2018 at 03:55:03PM -0800, Stefan Beller wrote:
>> From: Jonathan Nieder <jrnieder@gmail.com>
>>
>> This should make these functions easier to find and object-store.h
>> less overwhelming to read.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>>  alternates.h                | 68 +++++++++++++++++++++++++++++++++++++++++++++
>>  builtin/clone.c             |  1 +
>>  builtin/count-objects.c     |  1 +
>>  builtin/fsck.c              |  3 +-
>>  builtin/grep.c              |  1 +
>>  builtin/submodule--helper.c |  1 +
>>  cache.h                     | 52 ----------------------------------
>>  object-store.h              | 16 +++++------
>>  packfile.c                  |  3 +-
>>  sha1_file.c                 | 23 +++++++--------
>>  sha1_name.c                 |  3 +-
>>  submodule.c                 |  1 +
>>  t/helper/test-ref-store.c   |  1 +
>>  tmp-objdir.c                |  1 +
>>  transport.c                 |  1 +
>>  15 files changed, 102 insertions(+), 74 deletions(-)
>>  create mode 100644 alternates.h
>>
>> diff --git a/alternates.h b/alternates.h
>> new file mode 100644
>> index 0000000000..df5dc67e2e
>> --- /dev/null
>> +++ b/alternates.h
>> @@ -0,0 +1,68 @@
>> +#ifndef ALTERNATES_H
>> +#define ALTERNATES_H
>> +
>> +#include "strbuf.h"
>> +#include "sha1-array.h"
>> +
>> +struct alternates {
>> +     struct alternate_object_database *list;
>> +     struct alternate_object_database **tail;
>> +};
>> +#define ALTERNATES_INIT { NULL, NULL }
>
> I was surprised to find that this patch not only moves the alternates
> API to a new location, but introduces this struct.  I certainly think
> the struct is a good idea, but it should probably go in a separate
> patch, or at least get a mention in the commit message.

ok, I'll fix the commit message.

Thanks,
Stefan
