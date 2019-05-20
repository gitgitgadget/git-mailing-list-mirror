Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9969D1F461
	for <e@80x24.org>; Mon, 20 May 2019 13:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbfETNm2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 09:42:28 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:41292 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731005AbfETNm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 09:42:28 -0400
Received: by mail-wr1-f43.google.com with SMTP id g12so14388713wro.8
        for <git@vger.kernel.org>; Mon, 20 May 2019 06:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Pt4QrLtiyx8iKPmeIwLRlIWqn24kWnTxoNS57TCoYCI=;
        b=LcfdWG74oMcIfkEP55BRnlzruz9wzRLYYZrF8SmRnTc+zHlk3tBRB3V1XCUhNQzpaF
         84tLO7Yo4baq8k70VrN3b0NuLxhB80v/6fpffC5vQ2u3PrYCuhogj7YKgdKMXyht6F6w
         N9BD7yDv3k65UrE/24OhOTK6LWDakO+IaJa8IfuiEmmYGcm1RquK9xTzggC29nuyFeXI
         JY7vKT92KJNcgd9i3XN+uPGfVqXTMkl4Rr2PTok+s4r2BpPpceh2cEkeDSxeuKjjlAhb
         NxS0apuc92Kfdnky9ZwGWvC1i+sYLzOESbIOCqvL7J6A6uT1voc0vtYWcR9A8aKGzAvH
         YliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Pt4QrLtiyx8iKPmeIwLRlIWqn24kWnTxoNS57TCoYCI=;
        b=L7I4EtyuGhn8RAkpUZH8HJGQf+tw7GlQbYB4dCh5bDxHDsZLV9+0B0/UusypMyMotz
         ZagYsRylTWEb+p8MSuRWw/yF0fDpSTvHR7IPhaVEEtas1o2iGmh/nPykkS2CYbzXN8z/
         w8Qu8VzwM7Aohcl3+N5yBzjQdCXuRDs6+G+qVa4QMAb5xnhLDsVEOEdK37Xol8lrWzvY
         VGyrU4BTgoVut3R14HcFukI7gIIbfjxFJgnfkl3UvWOSzclsKpSY+ODsZ0Onz6KiAchV
         rvxGI8y/nf7NHMX/ZUJWKx5aQu4ayJvl49a/5p483XnFh8bMriHch2Z4amSw9Kw8U+0C
         Er5A==
X-Gm-Message-State: APjAAAWVnMIrlPPH1j0qiqSPO8CH3RyckRDsKRUo9jAA7XgOUBUg5NAL
        6zprM0ahC0ACIQIRh2JMRfzy2M3JcHk=
X-Google-Smtp-Source: APXvYqzcbvlLJ79ALVIgOEc78CemCOA3wPmbaUxNS069eJyKYKoZ7Z+jAvqq5h9QbnJ6/laUmaqaeA==
X-Received: by 2002:adf:ab45:: with SMTP id r5mr19664857wrc.100.1558359745435;
        Mon, 20 May 2019 06:42:25 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egp40.neoplus.adsl.tpnet.pl. [83.21.79.40])
        by smtp.gmail.com with ESMTPSA id j82sm27217996wmj.40.2019.05.20.06.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 06:42:24 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: Revision walking, commit dates, slop
References: <20190518005412.n45pj5p2rrtm2bfj@glandium.org>
        <20190518015005.GA951@szeder.dev>
        <20190518035828.pjaqfrkkvldhri6v@glandium.org>
        <20190518041706.ct6ie5trvxgdhjar@glandium.org>
        <f14799c3-e343-eb41-3536-65de7e38fbd9@gmail.com>
        <86mujhpewj.fsf@gmail.com>
        <cfa2c367-5cd7-add5-0293-caa75b103f34@gmail.com>
Date:   Mon, 20 May 2019 15:42:23 +0200
In-Reply-To: <cfa2c367-5cd7-add5-0293-caa75b103f34@gmail.com> (Derrick
        Stolee's message of "Mon, 20 May 2019 07:20:01 -0400")
Message-ID: <86ftp9p7i8.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:
> On 5/20/2019 7:02 AM, Jakub Narebski wrote:
>>
>> Are there any blockers that prevent the switch to this
>> "generation number v2"?
>>=20
>> - Is it a problem with insufficient data to choose the correct numbering
>>   as "generation number v2' (there can be only one)?
>> - Is it a problem with selected "generation number v2" being
>>   incompatibile with gen v2, and Git failing when new version of
>>   commit-graph is used instead of softly just not using commit-graph?
>> - Or is it something else?

Thanks for the explanation.

> The switch becomes a bit complicated.
>
> First, the plan was to version the commit-graph file to v2, and that would
> include a byte in the header for the "reachability index version" [1]. Si=
nce
> older clients fail hard on a newer file version, we are switching to inst=
ead
> including the reachability index version as a value in a more flexible=20
> "metadata chunk" [2].

Ugh, that is bad.  The version number inn the commit-graph file format
was supposed to make it possible to easily change the format; now it
looks like we are stuck with workarounds until the released version that
dies on never commit-graph file format version innstead of softly not
utilizing the commit-graph file dies off.

How this issue got missed in review...

If we cannot change the format, all that is left is ading new chunks,
and changes that conform to commit-graph file version 1.=20=20

>                      Using the generation number column for the corrected
> commit-date offsets (assuming we also guarantee the offset is strictly
> increasing from parent to child), these new values will be backwards-
> compatible _except_ for 'git commit-graph verify'.

O.K., so the "generation number v2 (legacy)" would be incremental and
backward-compatibile in use (though not in generation and validation).

Do I understand it correctly how it is calculated:

  corrected_date(C) =3D max(committer_date(C),
                          max_{P =E2=88=88 parents(C)}(corrected_date(P)) +=
 1)
  offset(C) =3D corrected_date(C) - committer_date(C)
  gen_v2(C) =3D max(offset(C), max_{P =E2=88=88 parents(C)}(gen_v2(P)) + 1)=
=20

Do you have benchmark for this "monotonically offset corrected commit
date" generation number in https://github.com/derrickstolee/git/commits/rea=
ch-perf
and https://github.com/derrickstolee/gen-test ?


Also, what would happen if different versions of Git tried to add to
commit-graph in interleaved way, either with rewrite or incremental?

> Second, we need to pull the reachability index value into a commit slab.

Is commit slab documented somewhere in Documentation/technical/, or just
in comments in commit-slab.h?

As I understand it, commit slab is Git-specific implementition of
inside-out object storage for commit data (i.e. struct of arrays instead
of array of structs), isn't it?  I wonder if using commit slab improves
cache utilization...

> The generation value is currently 32 bits, but we will expand that to
> 64 as it stores a timestamp. The commit struct is a bit bloated already,
> so this will reduce the required memory space even when not using the
> commit-graph. But, it requires some refactoring, including every place
> where we pass a "min_generation" needs to change type and name.

Could this be done with Coccinelle's spatch, similar to
e.g. contrib/coccinelle/commit.cocci?

>
> Third and finally, we need to calculate the new values and change the
> read logic to sum the offset and commit-date (when the metadata chunk
> says we are using corrected commit date).

Right.

> While none of this is _incredibly_ hard to do, it does require a bit
> of care. It's on my list to get to at some point, but making the file
> incremental is higher priority to me.

All right, I can understand that.

> [1] https://public-inbox.org/git/pull.112.git.gitgitgadget@gmail.com/
> [2] https://public-inbox.org/git/87h8acivkh.fsf@evledraar.gmail.com/

Best,
--
Jakub Nar=C4=99bski
