Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D194F1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 14:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751344AbeDBOJY (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 10:09:24 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35004 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbeDBOJX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 10:09:23 -0400
Received: by mail-wm0-f42.google.com with SMTP id r82so27585219wme.0
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 07:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3wjVgLrr3Gk8uGHsOA1IQ1Sq0ranTQEpazUDIDh4dWk=;
        b=XKV5lpa0NNrh9V+6Eoo2c7MVqk+UyEpjWpS622Uq8hgQzxPvyJZIztrUmkabLjkMj2
         qzt/YQUYbkhI3QvKhMMMTs+j8sR/vw7tc6CwEFKHhkXnzjsBGVVS8LElVrxbW5EPeIVn
         1cuGYWl3p4BxWdg369MavZJM2hEfzJz4nI8BeOctf3F4IIgRyEILIMyc2SEdVDH9dQ8J
         2xPvbl0VgQN9wzNEz3ZliorMHlvsmxMQ1N8xpwaDTRKlZVIa+nJbkoR5qLptOSUmRBz5
         nS9OaDbZDos1ZwdXWh7ii/Xrm75t1F7znO2YGFmHfTXTSV0JQx6qS6K+liMwTpT7JoqC
         j0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=3wjVgLrr3Gk8uGHsOA1IQ1Sq0ranTQEpazUDIDh4dWk=;
        b=TSEJ9tkVkhSKDpudj0UdwFrUO0bb8LC6uImMNPzU09f0cLrYAXg8YPr3DS+Ti6nt7I
         iIHNQaskw/UFTmVGIeYitcpHs+NoJpLRiVQPh4q4Cko9crP20E/zQUENkvgxPdV67Xz0
         Kti8/ESA5LrmcBjR/8Uo0f8+vpdL0REcnakAGi6vyxI2sKaaKLn9SD46UPqeBZ1Zfj53
         cCKrsRsgBg/Vg1fTka0ASuJy/SWfYFzshH1nM1SGkpmk3/1q0/YZRMraGIx6tUXdTEBn
         ACM9kHm9eFP4/bZru8AIb7ZLSUPQCwfCQBgZu1n/9RlgxqlXPqYDylqNZXmKpMGUoFiT
         uceQ==
X-Gm-Message-State: ALQs6tAntfqyWe9SqQzr/PKMTiO3n6iicVywsFPhb5wr+zojx/yTS2Lr
        +YmYmn/qQgUE3v9ml3XkLy3BFPdm
X-Google-Smtp-Source: AIpwx49t/F81FN9znOj/i++ir2L7its1TGaDIpHyF9ihzoJNnx+jBq4YcnEWAaWSVrpllCPQLzbIuQ==
X-Received: by 10.28.66.148 with SMTP id k20mr936754wmi.1.1522678162165;
        Mon, 02 Apr 2018 07:09:22 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (afx247.neoplus.adsl.tpnet.pl. [83.25.153.247])
        by smtp.gmail.com with ESMTPSA id p187sm1321596wme.8.2018.04.02.07.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 07:09:20 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 01/13] commit-graph: add format document
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <1519066406-81663-2-git-send-email-dstolee@microsoft.com>
        <86370hk84x.fsf@gmail.com>
        <433a2523-d04a-08bb-d128-6c8e578916fa@gmail.com>
Date:   Mon, 02 Apr 2018 16:09:11 +0200
In-Reply-To: <433a2523-d04a-08bb-d128-6c8e578916fa@gmail.com> (Derrick
        Stolee's message of "Mon, 2 Apr 2018 09:09:29 -0400")
Message-ID: <866059em48.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 3/30/2018 9:25 AM, Jakub Narebski wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>> +=3D=3D graph-*.graph files have the following format:
>> What is this '*' here?
>
> No longer necessary. It used to be a placeholder for a hash value, but
> now the graph is stored in objects/info/commit-graph.

All right.

Excuse me replying to v4 instead of v6 of the patch series, where it
would be answered or rather made moot already.

>>
>> [...]
>>> +  The remaining data in the body is described one chunk at a time, and
>>> +  these chunks may be given in any order. Chunks are required unless
>>> +  otherwise specified.
>> Does Git need to understand all chunks, or could there be optional
>> chunks that can be safely ignored (like in PNG format)?  Though this may
>> be overkill, and could be left for later revision of the format if
>> deemed necessary.
>
> In v6, the format and design documents are edited to make clear the
> use of optional chunks, specifically for future extension without
> increasing the version number.

That's good.

>>> +CHUNK DATA:
>>> +
>>> +  OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
>>> +      The ith entry, F[i], stores the number of OIDs with first
>>> +      byte at most i. Thus F[255] stores the total
>>> +      number of commits (N).
>> All right, it is small enough that can be required even for a very small
>> number of commits.
>>
>>> +
>>> +  OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
>>> +      The OIDs for all commits in the graph, sorted in ascending order.
>>> +
>>> +  Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)
>> Do commits need to be put here in the ascending order of OIDs?
>
> Yes.
>
>> If so, this would mean that it is not possible to add information about
>> new commits by only appending data and maybe overwriting some fields, I
>> think.  You would need to do full rewrite to insert new commit in
>> appropriate place.
>
> That is the idea. This file is not updated with every new commit, but
> instead will be updated on some scheduled cleanup events. The
> commit-graph file is designed in a way to be non-critical, and not
> tied to the packfile layout. This allows flexibility for when to do
> the write.
>
> For example, in GVFS, we will write a new commit-graph when there are
> new daily prefetch packs.
>
> This could also integrate with 'gc' and 'repack' so whenever they are
> triggered the commit-graph is written as well.

I wonder if it would be possible to use existing hooks...

> Commits that do not exist in the commit-graph file will load from the
> object database as normal (after a failed lookup in the commit-graph
> file).

Ah. I thought wrongly that it would (or at least could) be something
that can be kept up to date, and extended when adding any new commit.

>>> +    * The first H bytes are for the OID of the root tree.
>>> +    * The next 8 bytes are for the int-ids of the first two parents
>>> +      of the ith commit. Stores value 0xffffffff if no parent in that
>>> +      position. If there are more than two parents, the second value
>>> +      has its most-significant bit on and the other bits store an array
>>> +      position into the Large Edge List chunk.
>>> +    * The next 8 bytes store the generation number of the commit and
>>> +      the commit time in seconds since EPOCH. The generation number
>>> +      uses the higher 30 bits of the first 4 bytes, while the commit
>>> +      time uses the 32 bits of the second 4 bytes, along with the lowe=
st
>>> +      2 bits of the lowest byte, storing the 33rd and 34th bit of the
>>> +      commit time.
>>> +
>>> +  Large Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
>>> +      This list of 4-byte values store the second through nth parents =
for
>>> +      all octopus merges. The second parent value in the commit data s=
tores
>>> +      an array position within this list along with the most-significa=
nt bit
>>> +      on. Starting at that array position, iterate through this list o=
f int-ids
>>> +      for the parents until reaching a value with the most-significant=
 bit on.
>>> +      The other bits correspond to the int-id of the last parent.
>>
>> All right, that is one chunk that cannot use fixed-length records; this
>> shouldn't matter much, as we iterate only up to the number of parents
>> less two.
>
> Less one: the second "parent" column of the commit data chunk is used
> to point into this list, so (P-1) parents are in this chunk for a
> commit with P parents.

Right.

>> A question: what happens to the last list of parents?  Is there a
>> guardian value of 0xffffffff at last place?
>
> The termination condition is in the position of the last parent, since
> the most-significant bit is on. The other 31 bits contain the int-id
> of the parent.

Ah. I have misunderstood the format: I thought that first entry is
marked with most-significant bit set to 1, and all the rest to 0, while
it is last entry (last parent) has most-significant bit set, while all
others (if any) do not. So there is no need for guardian value.

Best regards,
--=20
Jakub Nar=C4=99bski
