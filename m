Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DA441F404
	for <e@80x24.org>; Fri, 16 Mar 2018 18:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeCPSd6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 14:33:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33381 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeCPSd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 14:33:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id s206so3875902wme.0
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 11:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=UUzSzoE+DtQSQPfeWT625m+gKgRjdP//EflPFbC1hpk=;
        b=c20lOOCuWE+J332/4ecRCc/mQlbp7Eh5e3NqmRcz0kSd874zu52ziJQDvsoHDMy5+V
         YjWpTqx3vGFWml2o/z7KWqjl9KvyoGocReMJXu5N137vOflmFrZSVGbGQ9ySFu+QcwCe
         0Hc82daYOYFyskQt+nhMXq4QPVCECu/4ZZuj2Z9PEw/mGfDdY624pYMjePaP1cVBFTVJ
         IadfR9X1JD9cllZX1xGxhSNI5C1VkYvVFLu5uvJPpb74wJNgopDW0I1DtNdy1NpAmv5q
         401nBzjtOFpMvMBrvL472mvFqKbYOEwgThK3N8crruo2zTU8DGxCDqDk/C0mOFliV99Y
         1hEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=UUzSzoE+DtQSQPfeWT625m+gKgRjdP//EflPFbC1hpk=;
        b=ev7eExAX69pbs7iVpLpGjZ6jfLP5NRhhnkQ74+AUuYQQSQWyW8vCiCSvJJqQnPguRv
         vpvvRI6JgwwRxsSP0XkG3a8v83GjsGkkwZkFy49CecgKJDwTlW9Pb67YByrABsC5FWEr
         bvzEM0/poXn6jUoHYHndEvvpnWihfrcdXivqQ0qr081er/rHJ2XNKmmEFFSNIZKQFcrR
         Z+GpNiZwnMOwlwWpnvdbmhRZ7fDHwfnxVBN/1GjEL2YU5kh7qDZ08CkQgmy3a6mzEefr
         u3U0a2p+aEezSXsbGzguL/l9J2FwUuApuBp302BycsMaDqtVDHbmSkCu+niyjPZVWdmp
         7tHw==
X-Gm-Message-State: AElRT7GLkftvvNT619Qiez+gGXjIi/wXROtpvrODduiuk2ESX6Bqv58P
        Ii6UJhJw2AieZo2W0Xmmg70=
X-Google-Smtp-Source: AG47ELu+RYAPO2HMxTmN1fQAsuddho9NUSH6V1kWxRBtwPUal60ZM3EHY1ZjMa0LTIQ+4MwFMr5i7w==
X-Received: by 10.223.191.11 with SMTP id p11mr333810wrh.160.1521225236059;
        Fri, 16 Mar 2018 11:33:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l8sm5816526wmf.39.2018.03.16.11.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 11:33:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
        <20180314192736.70602-1-dstolee@microsoft.com>
        <878tasdpqo.fsf@evledraar.gmail.com>
        <CAM0VKjknPZj-qHzf5nVr_RdHtB+pq2+APc1tesexP-eFSP9n_A@mail.gmail.com>
Date:   Fri, 16 Mar 2018 11:33:55 -0700
In-Reply-To: <CAM0VKjknPZj-qHzf5nVr_RdHtB+pq2+APc1tesexP-eFSP9n_A@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Fri, 16 Mar 2018 17:38:37
 +0100")
Message-ID: <xmqq370z3m5o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> You should forget '--stdin-packs' and use '--stdin-commits' to generate
> the initial graph, it's much faster even without '--additive'[1].  See
>
>   https://public-inbox.org/git/CAM0VKj=wmkBNH=psCRztXFrC13RiG1EaSw89Q6LJaNsdJDEFHg@mail.gmail.com/
>
> I still think that the default behaviour for 'git commit-graph write'
> should simply walk history from all refs instead of enumerating all
> objects in all packfiles.

Somehow I missed that one.  Thanks for the link to it.

It is not so surprising that history walking runs rings around
enumerating objects in packfiles, if packfiles are built well.

A well-built packfile tends to has newer objects in base form and
has delta that goes in backward direction (older objects are
represented as delta against newer ones).  This helps warlking from
the tips of the history quite a bit, because your delta base cache
will tend to have the base object (i.e. objects in the newer part of
the history you just walked) that will be required to access the
"next" older part of the history more often than not.

Trying to read the objects in the pack in their object name order
would essentially mean reading them in a cryptgraphically random
order.  Half the time you will end up wanting to access an object
that is near the tip of a very deep delta chain even before you've
accessed any of the base objects in the delta chain.

> [1] - Please excuse the bikeshed: '--additive' is such a strange
>       sounding option name, at least for me.  '--append', perhaps?

Yeah, I think "fetch --append" is probably a precedence.
