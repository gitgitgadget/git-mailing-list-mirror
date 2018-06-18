Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 721481F403
	for <e@80x24.org>; Mon, 18 Jun 2018 19:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936283AbeFRTkr (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 15:40:47 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41043 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936042AbeFRTkq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 15:40:46 -0400
Received: by mail-qt0-f195.google.com with SMTP id y20-v6so1253911qto.8
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 12:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=armc8XVMXBs9utRZp7NKD3/7MlKqi+rV6Ig5NUWgo1c=;
        b=l4txPVIRjjveqcawNNoXddIi05VQFRXz/n2otTpxGIXg2lwyxuObWGW7H7VSpIRiPi
         NlPYl5aj2YPIujUOYOiooN7EbL2vmqRUq+SXG5XlpvVKPcBezryTdPriDCMEWTKXt4m7
         cUbwBgabP5NwpaLxzI0UqFWKSDeUioBTmMDDI/cPYDlMTvLTM6KrNwqcsu4/Em0789KU
         2AFasKLL5AG+4HnqNCxl2/GDqF4pX4hNucx4/2xmhrlE9ug5oTI4DzBW56NUdyWaK/e8
         9dv9m8dXPGkRO7SPbe8U97VzYeUwaCRyKeJCtk1+D5PIJ5GMe15p35fmvJ9VKknG2ci8
         uygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=armc8XVMXBs9utRZp7NKD3/7MlKqi+rV6Ig5NUWgo1c=;
        b=qSmqvDL0IPqvR8AA+2Uj6fdHaftvkKj0PfZTn7xvP2VDptXGdalTFU9g1g1KOzUiHv
         7YEZli8l1BaGJyA8TIIstDGxAJCfs6r10SqP2cbVif+nIWXVqSDdO4hNLW/kM8EGCMjy
         SiWidwwjTJ4TYZbmw1liwTtTDsB0Gsv8CUm9FCE1RdjkJMSObH4QxIBJ2FQFA+domGhN
         tyU38CdNwCiCd4Z+C3JM5ue+SK0Ww6ud1EVhd1U8nlY4v77Y9ij0J6raKF3qB0669xI2
         /b7lAYH0fh9E5cer6C5xeGP8JQqABSAFKd0RX/NK7XXAyV/LU06bOJQBOGnZgMbOvdma
         lj8g==
X-Gm-Message-State: APt69E0A6TXd/FtQraTB+d5tAmgXm+6IqnduAj/XzPjeTR4hFgtr7T1k
        nOQCWiQt9Brdvtrib+uCbm8=
X-Google-Smtp-Source: ADUXVKJqj/GXYHjzKEytlvWh3LTi9jcqJl7y+Ai7jkGf91Sblb7QH/s/htMFg/FtveZPR/0vzlL1aQ==
X-Received: by 2002:ac8:16d6:: with SMTP id y22-v6mr12471296qtk.352.1529350845682;
        Mon, 18 Jun 2018 12:40:45 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d807:51c7:6f48:91e4? ([2001:4898:8010:0:c13d:51c7:6f48:91e4])
        by smtp.gmail.com with ESMTPSA id p50-v6sm13171785qtf.48.2018.06.18.12.40.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 12:40:45 -0700 (PDT)
Subject: Re: [PATCH 03/23] midx: add midx builtin
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180607140338.32440-4-dstolee@microsoft.com>
 <CAGZ79kaH7XzbtPZqVwGgP774GJNxF7ZsHqLzWEmb2NLSxG3Njg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <160f10c8-3016-8466-22dd-14cbd1a2c2f6@gmail.com>
Date:   Mon, 18 Jun 2018 15:40:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kaH7XzbtPZqVwGgP774GJNxF7ZsHqLzWEmb2NLSxG3Njg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/11/2018 5:02 PM, Stefan Beller wrote:
> Hi Derrick,
> On Thu, Jun 7, 2018 at 7:03 AM Derrick Stolee <stolee@gmail.com> wrote:
>> This new 'git midx' builtin will be the plumbing access for writing,
>> reading, and checking multi-pack-index (MIDX) files. The initial
>> implementation is a no-op.
> Let's talk about the name for a second:
>
> .idx files are written by git-index-pack or as part of
> git-pack-objects (which just calls write_idx_file as part
> of finish_tmp_packfile), and the name actually suggests
> it writes the index files. I have a hard time understanding
> what the git-midx command does[1].
>
> With both commit graph as well as multi index we introduce
> a command that is centered around that concept (similar to
> git-remote or git-config that are centered around a concept,
> that is closely resembled by a file), but for indexes for packs
> it was integrated differently into Git. So I am not sure if I want
> to suggest to integrate it into the packfile commands as that
> doesn't really fit. But maybe we can have a name that is human
> readable instead of the file suffix? Maybe
>
>    git multi-pack-index ?
>
> I suppose that eventually this command is not really used by
> users as it will be used by other porcelain commands in the
> background or even as part of repack/gc so I am not worried
> about a long name, but I'd be more worried about understandability.

I'll use "git multi-pack-index" in v2. I'll keep "midx.c" in the root, 
though, if that is OK.

> [1] While these names are not perfect for the layman, it is okay?
>    I am sure you are aware of https://git-man-page-generator.lokaltog.net/

I was not, and enjoyed that quite a bit.

Thanks,
-Stolee

>
>
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
> The reading is done as part of all other commands.

I like to think the 'read' verb is a subset of "verify" because we are 
checking for information about the MIDX, and mostly for tests or debugging.

>
>> +
>> +
>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'git midx' [--object-dir <dir>]
>> +
>> +DESCRIPTION
>> +-----------
>> +Write or verify a MIDX file.
>> +
>> +OPTIONS
>> +-------
>> +
>> +--object-dir <dir>::
>> +       Use given directory for the location of Git objects. We check
>> +       <dir>/packs/multi-pack-index for the current MIDX file, and
>> +       <dir>/packs for the pack-files to index.
>> +
>> +
> Maybe we could have a SEE ALSO section that points at
> the explanation of multi index files?
> (c.f. man git-submodule that has a  SEE ALSO
> gitsubmodules(7), gitmodules(5) explaining concepts(7)
> and the file(5))
>
> But as this is plumbing and users should not need to worry about it
> this is optional, I would think.

The design document is also in 'Documentation/technical' instead of just 
'Documentation/'. Do we have a pattern of linking to the technical 
documents?

Thanks,
-Stolee
