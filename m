Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A0E8201A7
	for <e@80x24.org>; Mon, 15 May 2017 20:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966629AbdEOUKk (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 16:10:40 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36075 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966591AbdEOUKi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 16:10:38 -0400
Received: by mail-qt0-f195.google.com with SMTP id j13so17620428qta.3
        for <git@vger.kernel.org>; Mon, 15 May 2017 13:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=tefmCRieEe7wuPDHguItOgmMFab8ps7vphtonJrfISQ=;
        b=FW3mjC2b0rj3c9mVe8/5YDSXu2KBfIkU1KELSFA7xRegcmmfePJ/LgR2PDq7RpQ9Aa
         U2V2YBZjMyVXt2SaJv1Jmb6PmqYakpksYJO+rkzQkCp0xjbje/xjxFz02h9OQD9sQuwR
         JZaaoZHKzbXJxif0Y6/mxqBAjvB9dmzReVgVASNJ7j2QlWJfqlFipG85QcswCdviyE/9
         TARERJylTXZjNTIFwew1bdqEw6x04nuszPiRM4dgGgF92iNT8CeKH+7kgFLTvfC/Vgyi
         shslxpxVmKiBQuTvRYElCwQQwaDyKpjhU4A+PGSfn2wAsJc5sP55M1J6In+mCJ+V+zqY
         Rk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=tefmCRieEe7wuPDHguItOgmMFab8ps7vphtonJrfISQ=;
        b=LjZnlh+SZTHkU5CYq7mKPAgO3FBmDdFhjskkJMfDzEIvCciXzYcYMK/U+8yh7h6sgw
         1ilZo8oIj+RUaIqrR4GEWXlIXc5Vw+lPGjUFEzhalXZJLvFmY9WolFJb6g9yZcdz11Da
         KZhLgfi/jqgpF8eNw72qrdxSPAeOhGu0piUFlfy7L/9uQMHErmo31vrVHOwGcyFyj7Jc
         P0SbzZWe7HRfnTTK3IrQAETB64Y/LYzV1gM4q/QGCqxU6NaIYgNe8FLLwzTsyNu+JHmK
         c95ppzu6Xthde18AvO//6z6+mFdMV1gfhFx7e1qXoiXGCAnCOL8MNi+A4ppJvcgjmv44
         MsAw==
X-Gm-Message-State: AODbwcDx8JF18sOYJB2SuQx9MK2lR4qRg/Z6CpCyJ0Ckf2sGp3LAbr0Z
        a/+fxyemWP19Ew==
X-Received: by 10.200.37.56 with SMTP id 53mr7061105qtm.216.1494879032847;
        Mon, 15 May 2017 13:10:32 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id s21sm9015498qtc.58.2017.05.15.13.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 May 2017 13:10:32 -0700 (PDT)
Subject: Re: [PATCH v1 5/5] Add a sample query-fsmonitor hook script that
 integrates with the cross platform Watchman file watching service.
To:     David Turner <David.Turner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20170515191347.1892-1-benpeart@microsoft.com>
 <20170515191347.1892-6-benpeart@microsoft.com>
 <fb609e259c714469b5528888e14c2e3a@exmbdft7.ad.twosigma.com>
Cc:     "gitster@pobox.com" <gitster@pobox.com>,
        "benpeart@microsoft.com" <benpeart@microsoft.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "peff@peff.net" <peff@peff.net>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <268acc85-8fc7-7779-8cb8-f0e88e7d50a5@gmail.com>
Date:   Mon, 15 May 2017 16:10:31 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <fb609e259c714469b5528888e14c2e3a@exmbdft7.ad.twosigma.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/15/2017 3:50 PM, David Turner wrote:
>
>> -----Original Message-----
>> From: Ben Peart [mailto:peartben@gmail.com]
>> Sent: Monday, May 15, 2017 3:14 PM
>> To: git@vger.kernel.org
>> Cc: gitster@pobox.com; benpeart@microsoft.com; pclouds@gmail.com;
>> johannes.schindelin@gmx.de; David Turner <David.Turner@twosigma.com>;
>> peff@peff.net
>> Subject: [PATCH v1 5/5] Add a sample query-fsmonitor hook script that
>> integrates with the cross platform Watchman file watching service.
>>
>> To use the script:
>>
>> Download and install Watchman from https://facebook.github.io/watchman/
>> and instruct Watchman to watch your working directory for changes
>> ('watchman watch-project /usr/src/git').
>>
>> Rename the sample integration hook from query-fsmonitor.sample to query-
>> fsmonitor.
>>
>> Configure git to use the extension ('git config core.fsmonitor true') and
>> optionally turn on the untracked cache for optimal performance ('git config
>> core.untrackedcache true').
>>
>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>   templates/hooks--query-fsmonitor.sample | 27
>> +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>   create mode 100644 templates/hooks--query-fsmonitor.sample
>>
>> diff --git a/templates/hooks--query-fsmonitor.sample b/templates/hooks--
>> query-fsmonitor.sample
>> new file mode 100644
>> index 0000000000..4bd22f21d8
>> --- /dev/null
>> +++ b/templates/hooks--query-fsmonitor.sample
>> @@ -0,0 +1,27 @@
>> +#!/bin/sh
>> +#
>> +# An example hook script to integrate Watchman #
>> +(https://facebook.github.io/watchman/) with git to provide fast # git
>> +status.
>> +#
>> +# The hook is passed a time_t formatted as a string and outputs to #
>> +stdout all files that have been modified since the given time.
>> +# Paths must be relative to the root of the working tree and #
>> +separated by a single NUL.
>> +#
>> +# To enable this hook, rename this file to "query-fsmonitor"
>> +
>> +# Convert unix style paths to escaped Windows style paths case "$(uname
>> +-s)" in
>> +MINGW*|MSYS_NT*)
>> +  GIT_WORK_TREE="$(cygpath -aw "$PWD" | sed 's,\\,\\\\,g')"
>> +  ;;
>> +*)
>> +  GIT_WORK_TREE="$PWD"
>> +  ;;
>> +esac
>> +
>> +# Query Watchman for all the changes since the requested time echo
>> +"[\"query\", \"$GIT_WORK_TREE\", {\"since\": $1,
>> +\"fields\":[\"name\"]}]" | \ watchman -j | \ perl -e 'use JSON::PP; my
>> +$o = JSON::PP->new->utf8->decode(join("", <>)); die "Watchman: $o-
>>> {'error'}.\nFalling back to scanning...\n" if defined($o->{"error"});
>> print(join("\0", @{$o->{"files"}}));'
> Last time I checked, the argument to 'since' was not a time_t -- it was a
> watchman clock spec.  Have you tested this?  Does it work?
>

Watchman also accepts a Unix time value for "since" as documented here 
(https://facebook.github.io/watchman/docs/expr/since.html).

Yes, this has been tested and works correctly as long as you have a 
recent version that contains the patch 
(https://github.com/facebook/watchman/commit/67b26a8938336f08918fc7187129b6c1a571f35b) 
that made sure it was greedy when using the Unix time.

