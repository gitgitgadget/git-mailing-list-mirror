Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 372E020A04
	for <e@80x24.org>; Fri, 26 May 2017 09:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163777AbdEZJsH (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 05:48:07 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:32924 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755213AbdEZJsF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 05:48:05 -0400
Received: by mail-io0-f195.google.com with SMTP id m4so908926ioe.0
        for <git@vger.kernel.org>; Fri, 26 May 2017 02:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8TB2B3MT09vNOpXX2kNqVxWpMvHAuYgWZlBNOl5EiVY=;
        b=t4Pu4FcHZi+dwZlPqJ+TY2XyxWU8U4JNZHjrKvNtHpGru7KjexrbAejdqzhxlx+KCz
         lZiWhaHftquotPNCKRwyuLTyNP801W14B9zBX/+mSOSK0rPc0VcajiSwqy4yONZzEdqB
         tut3Tn+I091529AykTGEvk6OxfzvOqmVQ4bakOgPuP2aoYcC7yv4Bn4tXtXo49XGm75B
         zvdmds3uVn9PHO1j4aqR+Crplu1YKrhMrMlqtdB6uJ4aB0HFq59Ng4W9ECC2ULUhNpbH
         SkCXiDSYMAg4zQZeRDl5/3bwlybGqkiIOm8f4HB2xIV9buQOTK1KIefssWqhui+r5Lp+
         iufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8TB2B3MT09vNOpXX2kNqVxWpMvHAuYgWZlBNOl5EiVY=;
        b=oAuZCAxaACNSgR5Fi6MxUiUS2j32ciEtTfRoqz8sT6q2/TNtn7+8Ak0ztwdhmTFC5k
         WupRLVTZeabicuQ6r9EUrM6stGaRhKj/HW4/UPbKwXEIOYIUtWqYsQ6+wKdxn6nj17ED
         2gJOOzUKYc2eE2jkrHcLv5XptpXL8SiXyS48wxSYbDFHeCp+RnftLCt/GNadGADA0sHP
         iZDTHus1iJ4nbN0fzVUDCk9dtDaeKQq29a/J7SnUAims9ybmkW26GWvZevKoeOqEAgVx
         zXiD2mBDnU4CrKuuSI57OwvmF+wAJOij/WxvBSnzwPAOgEiNPZJ5kM2y6fMjWdfOc8l6
         TtXw==
X-Gm-Message-State: AODbwcAGstzSKmbjBZ5PLkESg4l49Eww+ML4ALYfkXnASPQYiB7dhZr3
        Rzp8lpBRpr4YrA+X/JnfrNz3E7ETeg==
X-Received: by 10.107.138.21 with SMTP id m21mr823574iod.80.1495792084093;
 Fri, 26 May 2017 02:48:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 26 May 2017 02:47:43 -0700 (PDT)
In-Reply-To: <CAP8UFD340yndvkT8=F9zdzX9QtbuPspn8rfiK8q7f8c=kGeWQg@mail.gmail.com>
References: <20170518201333.13088-1-benpeart@microsoft.com>
 <20170518201333.13088-7-benpeart@microsoft.com> <CAP8UFD340yndvkT8=F9zdzX9QtbuPspn8rfiK8q7f8c=kGeWQg@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 26 May 2017 11:47:43 +0200
Message-ID: <CACBZZX4X9v5S6EQaX0tX71sK6c5kriaCTMoXqUx0Fg6WO9Wmiw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] fsmonitor: add a sample query-fsmonitor hook
 script for Watchman
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2017 at 3:12 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, May 18, 2017 at 10:13 PM, Ben Peart <peartben@gmail.com> wrote:
>> This hook script integrates the new fsmonitor capabilities of git with
>> the cross platform Watchman file watching service. To use the script:
>>
>> Download and install Watchman from https://facebook.github.io/watchman/
>> and instruct Watchman to watch your working directory for changes
>> ('watchman watch-project /usr/src/git').
>>
>> Rename the sample integration hook from query-fsmonitor.sample to
>> query-fsmonitor.
>>
>> Configure git to use the extension ('git config core.fsmonitor true')
>> and optionally turn on the untracked cache for optimal performance
>> ('git config core.untrackedcache true').
>
> Ok, it looks like the untracked cache can be used, but it could work without it.
>
>> Signed-off-by: Ben Peart <benpeart@microsoft.com>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  templates/hooks--query-fsmonitor.sample | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>  create mode 100644 templates/hooks--query-fsmonitor.sample
>>
>> diff --git a/templates/hooks--query-fsmonitor.sample b/templates/hooks--query-fsmonitor.sample
>> new file mode 100644
>> index 0000000000..4bd22f21d8
>> --- /dev/null
>> +++ b/templates/hooks--query-fsmonitor.sample
>> @@ -0,0 +1,27 @@
>> +#!/bin/sh
>> +#
>> +# An example hook script to integrate Watchman
>> +# (https://facebook.github.io/watchman/) with git to provide fast
>> +# git status.
>> +#
>> +# The hook is passed a time_t formatted as a string and outputs to
>> +# stdout all files that have been modified since the given time.
>> +# Paths must be relative to the root of the working tree and
>> +# separated by a single NUL.
>> +#
>> +# To enable this hook, rename this file to "query-fsmonitor"
>> +
>> +# Convert unix style paths to escaped Windows style paths
>> +case "$(uname -s)" in
>> +MINGW*|MSYS_NT*)
>> +  GIT_WORK_TREE="$(cygpath -aw "$PWD" | sed 's,\\,\\\\,g')"
>> +  ;;
>> +*)
>> +  GIT_WORK_TREE="$PWD"
>> +  ;;
>> +esac
>> +
>> +# Query Watchman for all the changes since the requested time
>> +echo "[\"query\", \"$GIT_WORK_TREE\", {\"since\": $1, \"fields\":[\"name\"]}]" | \
>> +watchman -j | \
>> +perl -e 'use JSON::PP; my $o = JSON::PP->new->utf8->decode(join("", <>)); die "Watchman: $o->{'error'}.\nFalling back to scanning...\n" if defined($o->{"error"}); print(join("\0", @{$o->{"files"}}));'
>
> Maybe put the above small perl script on multiple lines for improved
> readability.
>
> Is JSON::PP always available in Perl >= 5.8?

No, it's shipped with perl as of 5.14.0, which came out in May 2011.

I think depending on that is fine. FWIW we bumped the required core
dependency (but you might still need to install modules) in 2010 in my
d48b284183 ("perl: bump the required Perl version to 5.8 from
5.6.[21]", 2010-09-24). Maybe we should be bumping that again...

> What happens if watchman is not installed or not in the PATH?
> It seems to me that the git process will not die, and will just work
> as if the hook does not exist, except that it will call the hook which
> will probably output error messages.

I think a good solution to this is to just add "set -euo pipefail" to
that script.

Then we'll print out on stderr that we couldn't find the watchman
command. Right now (with my patch) it'll make its way to the perl
program and get empty input.
