Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E811F404
	for <e@80x24.org>; Mon,  8 Jan 2018 00:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754834AbeAHAI7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Jan 2018 19:08:59 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:40549 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754726AbeAHAI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jan 2018 19:08:59 -0500
Received: by mail-qk0-f180.google.com with SMTP id d18so1884041qke.7
        for <git@vger.kernel.org>; Sun, 07 Jan 2018 16:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qfb2g+LLMV1HX2HgKxQEImsNRyNWKv5vD4OTpg0mTQo=;
        b=aRkdHCv5cR3UnzT3r64BM/GgioGMRkqlPMBGoBvIaRPwVnIVoIs6kaAx+M45azhF42
         W6z3qi34ZzzeoOtCFkEjOzBwk6TJOr3Ut2UiMSd5fZeAijcuv2iKeWy/8dk6xWgiP+hx
         e5ByIycGIQku3DERCJiC3qcXQy2SllBLCOrznBEo4pskjvBWwu1j35xYM+QIDIzG/Jmw
         G1COSULoLN8T6ibyMZLZOuo9dzXhTbS47lhBBoYiyWYzBlZq7DOLfUTs3dF0y2ooS242
         YxWEMI4Ge+EUwzaUDzCaclgnm/cYdLD7GFTuKhnKqN0pM69hiaSke+4HII5z54r/1RQy
         TLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qfb2g+LLMV1HX2HgKxQEImsNRyNWKv5vD4OTpg0mTQo=;
        b=UlRZrsSlOEGRHRCjYxUgWtT99VRAqCQEKeV7uy4xydWE7yohMR+4nNYX8XVjX911/d
         Jz9Lff4JxKT1q1YouIHhBN3FuiLXieGWMJEsHHt5DwREs9QTD+F+O3HQssOMy5Jg8GM/
         ulPhFy/1ac2oue26OwjXlRR/gkxc4Bx4qo7ETqusWaKC/fPPqYGQHDw7cd2a0jrlhKXV
         ReMiCsg4n9tdhOLJdhw6cbeFdMEWoXUaZ3GOXpgkulaCZ1uEYW/jbzBFiGsBkSwz2QVv
         23NEF50oZz+/sNNkugaPrKUBNoy65cbVPgijhMod+a7jwmhjzuCqMBLcX78c1BjwxicS
         V86w==
X-Gm-Message-State: AKwxytcGACJzpIPkjBdj3jgYdfIkVQfw8cMaFUV3SZRQPzudOYHW9cWt
        bLNCgK3CWdrEIEsTMC9K4kDs+JEpt+o=
X-Google-Smtp-Source: ACJfBosgRXXkAixjXFqHl/x/1S7H8pYGemYeFc9DbyAx4ve5V2mxtoNwyiS+tj8R0kT0WiOZl/CVAQ==
X-Received: by 10.55.156.19 with SMTP id f19mr3729702qke.89.1515370138127;
        Sun, 07 Jan 2018 16:08:58 -0800 (PST)
Received: from [10.0.1.24] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id e16sm6857969qtk.64.2018.01.07.16.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jan 2018 16:08:57 -0800 (PST)
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, johannes.schindelin@gmx.de,
        jrnieder@gmail.com
References: <20180107181459.222909-1-dstolee@microsoft.com>
 <87k1wtb8a4.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c08416f1-bbec-2037-34a6-f454d85de439@gmail.com>
Date:   Sun, 7 Jan 2018 19:08:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <87k1wtb8a4.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/7/2018 5:42 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Jan 07 2018, Derrick Stolee jotted:
> 
>>      git log --oneline --raw --parents
>>
>> Num Packs | Before MIDX | After MIDX |  Rel % | 1 pack %
>> ----------+-------------+------------+--------+----------
>>          1 |     35.64 s |    35.28 s |  -1.0% |   -1.0%
>>         24 |     90.81 s |    40.06 s | -55.9% |  +12.4%
>>        127 |    257.97 s |    42.25 s | -83.6% |  +18.6%
>>
>> The last column is the relative difference between the MIDX-enabled repo
>> and the single-pack repo. The goal of the MIDX feature is to present the
>> ODB as if it was fully repacked, so there is still room for improvement.
>>
>> Changing the command to
>>
>>      git log --oneline --raw --parents --abbrev=40
>>
>> has no observable difference (sub 1% change in all cases). This is likely
>> due to the repack I used putting commits and trees in a small number of
>> packfiles so the MRU cache workes very well. On more naturally-created
>> lists of packfiles, there can be up to 20% improvement on this command.
>>
>> We are using a version of this patch with an upcoming release of GVFS.
>> This feature is particularly important in that space since GVFS performs
>> a "prefetch" step that downloads a pack of commits and trees on a daily
>> basis. These packfiles are placed in an alternate that is shared by all
>> enlistments. Some users have 150+ packfiles and the MRU misses and
>> abbreviation computations are significant. Now, GVFS manages the MIDX file
>> after adding new prefetch packfiles using the following command:
>>
>>      git midx --write --update-head --delete-expired --pack-dir=<alt>
> 
> (Not a critique of this, just a (stupid) question)
> 
> What's the practical use-case for this feature? Since it doesn't help
> with --abbrev=40 the speedup is all in the part that ensures we don't
> show an ambiguous SHA-1.

The point of including the --abbrev=40 is to point out that object 
lookups do not get slower with the MIDX feature. Using these "git log" 
options is a good way to balance object lookups and abbreviations with 
object parsing and diff machinery. And while the public data shape I 
shared did not show a difference, our private testing of the Windows 
repository did show a valuable improvement when isolating to object 
lookups and ignoring abbreviation calculations.

> The reason we do that at all is because it makes for a prettier UI.

We tried setting core.abbrev=40 on GVFS enlistments to speed up 
performance and the users rebelled against the hideous output. They 
would rather have slower speeds than long hashes.

> Are there things that both want the pretty SHA-1 and also care about the
> throughput? I'd have expected machine parsing to just use
> --no-abbrev-commit.

The --raw flag outputs blob hashes, so the --abbrev=40 covers all hashes.

> If something cares about both throughput and e.g. is saving the
> abbreviated SHA-1s isn't it better off picking some arbitrary size
> (e.g. --abbrev=20), after all the default abbreviation is going to show
> something as small as possible, which may soon become ambigous after the
> next commit.

Unfortunately, with the way the abbreviation algorithms work, using 
--abbrev=20 will have similar performance problems because you still 
need to inspect all packfiles to ensure there isn't a collision in the 
first 20 hex characters.

Thanks,
-Stolee


