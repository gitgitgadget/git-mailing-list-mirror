Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C0CB20401
	for <e@80x24.org>; Thu, 15 Jun 2017 23:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbdFOXgf (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 19:36:35 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:37458 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbdFOXgf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 19:36:35 -0400
Received: by mail-it0-f48.google.com with SMTP id m47so19072685iti.0
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 16:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=R7wqMBpMXqwMURhgHiy3thwtniyuZ81oD7u30LucEpI=;
        b=jIjuzbsQsAKTIb7JJN7/O7YrUmWP1h2HhA1NUhR/uhYlGE4g9bquY3xl5OtDwE01ay
         OkE6+EHMXRYj99RjVQTZZoiWe+C1uj6Fi5FSNDFyH9Jn5F5mVWyCOuW6MWbIaENKV2HU
         6ErCLe8HJv3lclEzViDcJF/3VzfIRs5B/NkOyAovKmcoWaMFRs7Mdm3/ebcfhpxDXfmY
         +bb6XI5tHbczMY2wXw4aBCAy+eyYVjtYUP883dXNL3kRS8z7IBN9uqZLpoRufYL4d27l
         1Rjs1kaCXBiPgOAlji2tNdlnGD7xl4yzJXlEyMhcnJ/zz45Juzs8s9fWzLf+AgKHC4jw
         xyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=R7wqMBpMXqwMURhgHiy3thwtniyuZ81oD7u30LucEpI=;
        b=Uwmb0JH0FtgdfliA+YHAcah0ozbwbnAm9WLpaGxZD7k3/gMH/dVL1GMUPoIdBkw+Fk
         Iw7sEteOfFQMQ8y+uMsn6nh/BkROaUWJGMpUWMHWGMFc+RbHmIDitFibVKR04pPtj4sM
         MLyEnDgkcEZMLyhzC5ewQmMG+yFH2Ya2EQgr5tN1DdgE5uqmjPCfxnt/3jfYH23rb9N5
         8um/rELTZ+ANDLdwVUYiQtbIiTQLpNcXk7dvdnSD7F9re7i70i/Q6jdTfFZTSzny1HZq
         nci6rxzIQbcrRwHrwQugG9twrO3CBdWY4nJBLoeQ8LCZHpL4edWmUuN3700Yb6CHwxB5
         UeiA==
X-Gm-Message-State: AKS2vOyvXNEf88kREfdmgujsmIulkdDXTarbUwaSaT32qj50XShcjUB9
        yueQZRtfc5T8Fg0apekGxIr66ahHGA==
X-Received: by 10.36.181.8 with SMTP id v8mr7730394ite.71.1497569794275; Thu,
 15 Jun 2017 16:36:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Thu, 15 Jun 2017 16:36:13 -0700 (PDT)
In-Reply-To: <20170615224110.kvrjs3lmwxcoqfaw@genre.crustytoothpaste.net>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net>
 <20170306182423.GB183239@google.com> <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
 <20170615110518.ordr43idf2jluips@glandium.org> <20170615130145.stwbtict7q6oel7e@sigill.intra.peff.net>
 <87shj1ciy8.fsf@gmail.com> <alpine.DEB.2.21.1.1706152123060.4200@virtualbox>
 <CAL9PXLzhPyE+geUdcLmd=pidT5P8eFEBbSgX_dS88knz2q_LSw@mail.gmail.com> <20170615224110.kvrjs3lmwxcoqfaw@genre.crustytoothpaste.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 16 Jun 2017 01:36:13 +0200
Message-ID: <CACBZZX5Z3kQHe_5TgOeuJSgzuvpQdaLo6RrgX_EvuZfdz856sA@mail.gmail.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash
 function transition plan
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Adam Langley <agl@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2017 at 12:41 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Thu, Jun 15, 2017 at 02:59:57PM -0700, Adam Langley wrote:
>> (I was asked to comment a few points in public by Jonathan.)
>>
>> I think this group can safely assume that SHA-256, SHA-512, BLAKE2,
>> K12, etc are all secure to the extent that I don't believe that making
>> comparisons between them on that axis is meaningful. Thus I think the
>> question is primarily concerned with performance and implementation
>> availability.
>>
>> I think any of the above would be reasonable choices. I don't believe
>> that length-extension is a concern here.
>>
>> SHA-512/256 will be faster than SHA-256 on 64-bit systems in software.
>> The graph at https://blake2.net/ suggests a 50% speedup on Skylake. On
>> my Ivy Bridge system, it's about 20%.
>>
>> (SHA-512/256 does not enjoy the same availability in common libraries however.)
>>
>> Both Intel and ARM have SHA-256 instructions defined. I've not seen
>> good benchmarks of them yet, but they will make SHA-256 faster than
>> SHA-512 when available. However, it's very possible that something
>> like BLAKE2bp will still be faster. Of course, BLAKE2bp does not enjoy
>> the ubiquity of SHA-256, but nor do you have to wait years for the CPU
>> population to advance for high performance.
>
> SHA-256 acceleration exists for some existing Intel platforms already.
> However, they're not practically present on anything but servers at the
> moment, and so I don't think the acceleration of SHA-256 is a
> something we should consider.

Whatever next-gen hash Git ends up with is going to be in use for
decades, so what hardware acceleration exists in consumer products
right now is practically irrelevant, but what acceleration is likely
to exist for the lifetime of the hash existing *is* relevant.

So I don't follow the argument that we shouldn't weigh future HW
acceleration highly just because you can't easily buy a laptop today
with these features.

Aside from that I think you've got this backwards, it's AMD that's
adding SHA acceleration to their high-end Ryzen chips[1] but Intel is
starting at the lower end this year with Goldmont which'll be in
lower-end consumer devices[2]. If you read the github issue I linked
to upthread[3] you can see that the cryptopp devs already tested their
SHA accelerated code on a consumer Celeron[4] recently.

I don't think Intel has announced the SHA extensions for future Xeon
releases, but it seems given that they're going to have it there as
well. Have there every been x86 extensions that aren't eventually
portable across the entire line, or that they've ended up removing
from x86 once introduced?

In any case, I think by the time we're ready to follow-up the current
hash refactoring efforts with actually changing the hash
implementation many of us are likely to have laptops with these
extensions, making this easy to test.

1. https://en.wikipedia.org/wiki/Intel_SHA_extensions
2. https://en.wikipedia.org/wiki/Goldmont
3. https://github.com/weidai11/cryptopp/issues/139#issuecomment-264283385
4. https://ark.intel.com/products/95594/Intel-Celeron-Processor-J3455-2M-Cache-up-to-2_3-GHz
