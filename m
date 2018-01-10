Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA9BB1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 19:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbeAJTjU (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 14:39:20 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34092 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753447AbeAJTjP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 14:39:15 -0500
Received: by mail-qk0-f172.google.com with SMTP id b76so389107qkc.1
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 11:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZJ3HKAyx3KkhSYXJZnFReePTJ/057StddG1zlumxYIY=;
        b=mdyWYCp2V8JUtbykw+NNjbRrNZlsACYIuBnFlv2eQxePL3BrKssgXjtyz/bbXZxAFc
         dtlgs5plWxkOqkjVaNzppxtpaC7cic5vzegwAhBlAv17EYDVgbziYywdztq2Ne8XzLzq
         oP59e3GhUIyJnCM9tQNmjWLhv80GrVqx8QYKPeqlMBs6BSOnmViGuFUMjHYJzp/MLhsI
         VLbBuAr5DoFA/DGnoodTQvAkgEsaZdA5phbA8p8edVItsa884O0dtfIokvTDUhRTMxLs
         QX476lzGqGmSP5DQWPBfuC6rcSpZc2o+DG2En9rFU8609SXprhpuL+MIg0HzxQ4X0lHL
         Y1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZJ3HKAyx3KkhSYXJZnFReePTJ/057StddG1zlumxYIY=;
        b=gClnWNMjPHFcqYvvZXNGW56rmcTZ18A6fyKfwYXjJ6mbqbQODsHG26oeCSt1UJV4x7
         upgt/y3LmaW1E5MGKIGEq+Hd8dgxSz4RUBxyIAMQk8qQWObIuHludo2GQEsAZpq0wiY4
         hWNHRj4IgVmCzEaxL2MacwG0ESN/oBfB2kgQz2fgvu0VokcKwLzRdLbUV4L7eYITMctA
         hn3RUwZSGeCvFqi78kXqht0/XFaJOX0k6sbIK1uKUxDFUcinsBM5N1CrY+9MUjJ32YJc
         mP44vN/zFgYpXzRNda0jzXuG4Iok39oNNV8O6vVShT243jVoC1APZ9IhtcIEJqQFolkY
         7ncw==
X-Gm-Message-State: AKwxytcTkOQiZVgWHCpq4qPjsro7NmfprZriOrSBxM18QnfWnuOlFVov
        fK3hO5TTALKL7VuE5gDSxr0=
X-Google-Smtp-Source: ACJfBovV/1dsptCAvInQ2pZhX4pQuY2ZcVTrh3iziQygWDF6f3h6oFuXm+CSnVOpiWcXrCIRg5QDaQ==
X-Received: by 10.200.51.3 with SMTP id t3mr28812691qta.33.1515613154904;
        Wed, 10 Jan 2018 11:39:14 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id o57sm11417647qtf.53.2018.01.10.11.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jan 2018 11:39:14 -0800 (PST)
Subject: Re: [RFC PATCH 00/18] Multi-pack index (MIDX)
To:     Martin Fick <mfick@codeaurora.org>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, gitster@pobox.com, Johannes.Shindelin@gmx.de,
        jrnieder@gmail.com
References: <20180107181459.222909-1-dstolee@microsoft.com>
 <2648064.NJaMxHkljU@mfick-lnx>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7b3df316-8a35-0dcf-da17-64202f600821@gmail.com>
Date:   Wed, 10 Jan 2018 14:39:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <2648064.NJaMxHkljU@mfick-lnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/10/2018 1:25 PM, Martin Fick wrote:
> On Sunday, January 07, 2018 01:14:41 PM Derrick Stolee
> wrote:
>> This RFC includes a new way to index the objects in
>> multiple packs using one file, called the multi-pack
>> index (MIDX).
> ...
>> The main goals of this RFC are:
>>
>> * Determine interest in this feature.
>>
>> * Find other use cases for the MIDX feature.
> My interest in this feature would be to speed up fetches
> when there is more than one large pack-file with many of the
> same objects that are in other pack-files.   What does your
> MIDX design do when it encounters multiple copies of the
> same object in different pack files?  Does it index them all,
> or does it keep a single copy?

The MIDX currently keeps only one reference to each object. Duplicates 
are dropped during writing. (See the care taken in commit 04/18 to avoid 
duplicates.) Since midx_sha1_compare() does not use anything other than 
the OID to order the objects, there is no decision being made about 
which pack is "better". The MIDX writes the first copy it finds and 
discards the others.

It would not be difficult to include a check in midx_sha1_compare() to 
favor one packfile over another based on some measurement (size? 
mtime?). Since this would be a heuristic at best, I left it out of the 
current patch.

> In our Gerrit instance (Gerrit uses jgit), we have multiple
> copies of the linux kernel repos linked together via the
> alternatives file mechanism.

GVFS also uses alternates for sharing packfiles across multiple copies 
of the repo. The MIDX is designed to cover all packfiles in the same 
directory, but is not designed to cover packfiles in multiple 
alternates; currently, each alternate would need its own MIDX file. Does 
that cause issues with your setup?

>    These repos have many different
> references (mostly Gerrit change references), but they share
> most of the common objects from the mainline.  I have found
> that during a large fetch such as a clone, jgit spends a
> significant amount of extra time by having the extra large
> pack-files from the other repos visible to it, usually around
> an extra minute per instance of these (without them, the
> clone takes around 7mins).  This adds up easily with a few
> repos extra repos, it can almost double the time.
>
> My investigations have shown that this is due to jgit
> searching each of these pack files to decide which version of
> each object to send.  I don't fully understand its selection
> criteria, however if I shortcut it to just pick the first
> copy of an object that it finds, I regain my lost time.  I
> don't know if git suffers from a similar problem?  If git
> doesn't suffer from this then it likely just uses the first
> copy of an object it finds (which may not be the best object
> to send?)
>
> It would be nice if this use case could be improved with
> MIDX.  To do so, it seems that it would either require that
> MIDX either only put "the best" version of an object (i.e.
> pre-select which one to use), or include the extra
> information to help make the selection process of which copy
> to use (perhaps based on the operation being performed)
> fast.

I'm not sure if there is sufficient value in storing multiple references 
to the same object stored in multiple packfiles. There could be value in 
carefully deciding which copy is "best" during the MIDX write, but 
during read is not a good time to make such a decision. It also 
increases the size of the file to store multiple copies.

> This also leads me to ask, what other additional information
> (bitmaps?) for other operations, besides object location,
> might suddenly be valuable in an index that potentially
> points to multiple copies of objects?  Would such
> information be appropriate in MIDX, or would it be better in
> another index?

For applications to bitmaps, it is probably best that we only include 
one copy of each object. Otherwise, we need to include extra bits in the 
bitmaps for those copies (when asking "is this object in the bitmap?").

Thanks for the context with Gerrit's duplicate object problem. I'll try 
to incorporate it in to the design document (commit 01/18) for the v1 patch.

Thanks,
-Stolee

