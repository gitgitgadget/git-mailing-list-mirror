Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3E851F403
	for <e@80x24.org>; Mon, 18 Jun 2018 19:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936092AbeFRTXQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 15:23:16 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42168 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935743AbeFRTXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 15:23:16 -0400
Received: by mail-qt0-f196.google.com with SMTP id y31-v6so16208836qty.9
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 12:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=I/lb9bw90PQkPorVxXhwTXv4JaX2ZgFVdbRCP7pULdk=;
        b=syj6T77e0B4b1AwzQVpYhWNyY/qkIJkseyWF8nzAo92ZEegwJNbiBg8Pn3WzVVOPlF
         f0DwJk8jeD4iQjAbMp/IeOsLHWrBjxM1y06Tag1rzQvJ/dd+e5tcOWsSe4IWMUAvXGcV
         VitNRiUJ5DVIzN4WtVorhxUKISKDHafkM6u27FKXmVzW1y9XrCmzIG5/8cXB65n+Z522
         UPvKinPLbwGTEQ7SJSUo/uC1hEU1xxSNwYG1D1QWd1M4kWPXVL35J8y1bbXE6Ge6ShiY
         7cOL/nfeByq2mpnr9LR+Kj+ucUYzWaPY7+U0Ogfj7kvEdptqGjh1d5ddvqwvSbHTnQ/u
         zdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=I/lb9bw90PQkPorVxXhwTXv4JaX2ZgFVdbRCP7pULdk=;
        b=RcZGJTp3w/gLzbT6mAzx1i0N/tzXMet59OnJ7WmIQl3MfzzgPhmnh6l37LMElP5FkY
         m0Yt7oBTtdHZX9NwQ7dOwZT26qU0liNTZDcJytBzdtD9wtsBakk8Vw18/eLFbg9pvfWd
         tJl484/eem7zdk4bhR7k3Z8x/amrefGlFvwRpht/EnwlXd6XZmgD5LIb6CtyRPv5eenT
         JZXX0BxmYsnPFJD7Rwl5AHy/VenLRnJaXzF6tNJVdp/bqNQf9cbeY3PWDKsA8NR85HH3
         JJ7mk+FycR/WkqBkcFFg2sSQjPjW52Ha4FKD1PbzfJNx9RdLhrAG93wSGYJ6xfUBi5nu
         GW0Q==
X-Gm-Message-State: APt69E3K3dPbAB2lGmVisnQsZmz7URtBUHqCgXOmH05pJPNC2T4J4NIC
        NrEE708+v9W/+8L/4smd6K6SKCQLHlA=
X-Google-Smtp-Source: ADUXVKKLLZ9O6gNCgvdmL4U8IuvJT1dLHaxwerW2pWuEbKyB7XWkmmkUURr44FThwr3YzS+CX2amhg==
X-Received: by 2002:ac8:6705:: with SMTP id e5-v6mr12189732qtp.79.1529349794983;
        Mon, 18 Jun 2018 12:23:14 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d807:51c7:6f48:91e4? ([2001:4898:8010:0:c13d:51c7:6f48:91e4])
        by smtp.gmail.com with ESMTPSA id o64-v6sm13392508qko.74.2018.06.18.12.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 12:23:14 -0700 (PDT)
Subject: Re: [PATCH 03/23] midx: add midx builtin
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-4-dstolee@microsoft.com>
 <CACsJy8Ca4B_xjpuTU=sFS+fOEin5fFiSmH+Z7JKjoUA6ZMnv4A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b0484a3f-95ab-f0c1-0dc5-3c75c766ff6e@gmail.com>
Date:   Mon, 18 Jun 2018 15:23:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8Ca4B_xjpuTU=sFS+fOEin5fFiSmH+Z7JKjoUA6ZMnv4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2018 1:20 PM, Duy Nguyen wrote:
> On Thu, Jun 7, 2018 at 4:03 PM, Derrick Stolee <stolee@gmail.com> wrote:
>> diff --git a/Documentation/git-midx.txt b/Documentation/git-midx.txt
>> new file mode 100644
>> index 0000000000..2bd886f1a2
>> --- /dev/null
>> +++ b/Documentation/git-midx.txt
>> @@ -0,0 +1,29 @@
>> +git-midx(1)
>> +============
>> +
>> +NAME
>> +----
>> +git-midx - Write and verify multi-pack-indexes (MIDX files).
> No full stop. This head line is collected automatically with others
> and its having a full stop while the rest does not looks strange/
>
>> diff --git a/builtin/midx.c b/builtin/midx.c
>> new file mode 100644
>> index 0000000000..59ea92178f
>> --- /dev/null
>> +++ b/builtin/midx.c
>> @@ -0,0 +1,38 @@
>> +#include "builtin.h"
>> +#include "cache.h"
>> +#include "config.h"
>> +#include "git-compat-util.h"
> You only need either cache.h or git-compat-util.h. If cache.h is here,
> git-compat-util can be removed.
>
>> +#include "parse-options.h"
>> +
>> +static char const * const builtin_midx_usage[] ={
>> +       N_("git midx [--object-dir <dir>]"),
>> +       NULL
>> +};
>> +
>> +static struct opts_midx {
>> +       const char *object_dir;
>> +} opts;
>> +
>> +int cmd_midx(int argc, const char **argv, const char *prefix)
>> +{
>> +       static struct option builtin_midx_options[] = {
>> +               { OPTION_STRING, 0, "object-dir", &opts.object_dir,
> For paths (including dir), OPTION_FILENAME may be a better option to
> handle correctly when the command is run in a subdir. See df217ed643
> (parse-opts: add OPT_FILENAME and transition builtins - 2009-05-23)
> for more info.
Thanks for the pointer!

>
>> +                 N_("dir"),
>> +                 N_("The object directory containing set of packfile and pack-index pairs.") },
> Other help strings do not have full stop either (I only checked a
> couple commands though)
>
> Also, doesn't OPT_STRING() work here too (if you avoid OPTION_FILENAME
> for some reason)?
>
>> +               OPT_END(),
>> +       };
>> +
>> +       if (argc == 2 && !strcmp(argv[1], "-h"))
>> +               usage_with_options(builtin_midx_usage, builtin_midx_options);
>> +
>> +       git_config(git_default_config, NULL);
>> +
>> +       argc = parse_options(argc, argv, prefix,
>> +                            builtin_midx_options,
>> +                            builtin_midx_usage, 0);
>> +
>> +       if (!opts.object_dir)
>> +               opts.object_dir = get_object_directory();
>> +
>> +       return 0;
>> +}
>> diff --git a/git.c b/git.c
>> index c2f48d53dd..400fadd677 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -503,6 +503,7 @@ static struct cmd_struct commands[] = {
>>          { "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>>          { "merge-subtree", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
>>          { "merge-tree", cmd_merge_tree, RUN_SETUP | NO_PARSEOPT },
>> +       { "midx", cmd_midx, RUN_SETUP },
> If it's a plumbing and can take an --object-dir, then I don't think
> you should require it to run in a repo (with RUN_SETUP).
> RUN_SETUP_GENTLY may be better. You could even leave it empty here and
> only call setup_git_directory() only when --object-dir is not set.

I agree. Good point. This could be run to maintain an alternate without 
any .git folder.

>
>>          { "mktag", cmd_mktag, RUN_SETUP | NO_PARSEOPT },
>>          { "mktree", cmd_mktree, RUN_SETUP },
>>          { "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },

