Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD1782047F
	for <e@80x24.org>; Wed,  2 Aug 2017 00:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbdHBAtw (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 20:49:52 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51993 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751029AbdHBAtv (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Aug 2017 20:49:51 -0400
X-AuditID: 1207440f-32bff70000000b50-36-598121aed741
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id B5.94.02896.EA121895; Tue,  1 Aug 2017 20:49:50 -0400 (EDT)
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com [209.85.223.170])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v720nn7F004582
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Tue, 1 Aug 2017 20:49:50 -0400
Received: by mail-io0-f170.google.com with SMTP id c74so14551447iod.4
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 17:49:49 -0700 (PDT)
X-Gm-Message-State: AIVw110HbJS8UvKWY+B0jQPUcC6/sU1+fUDYzygktgeipXTHLrYtoS6Z
        CH5IaRNx4pPjqCL5jOZo5NvOJDMc9w==
X-Received: by 10.107.187.129 with SMTP id l123mr23393909iof.122.1501634988951;
 Tue, 01 Aug 2017 17:49:48 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 10.107.129.91 with HTTP; Tue, 1 Aug 2017 17:49:47 -0700 (PDT)
In-Reply-To: <CAJo=hJtrdCOF-RxzXfyLx7R-1f2-7pZVO_UOg28J=wUDNdf3yw@mail.gmail.com>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <CAMy9T_HCnyc1g8XWOOWhe7nN0aEFyyBskV2aOMb_fe+wGvEJ7A@mail.gmail.com> <CAJo=hJtrdCOF-RxzXfyLx7R-1f2-7pZVO_UOg28J=wUDNdf3yw@mail.gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Tue, 1 Aug 2017 17:49:47 -0700
X-Gmail-Original-Message-ID: <CAMy9T_FA1RV+NFxaXR65gw7G6OxL7Z8Ve3VNLrF4oyCdqtdahg@mail.gmail.com>
Message-ID: <CAMy9T_FA1RV+NFxaXR65gw7G6OxL7Z8Ve3VNLrF4oyCdqtdahg@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1F2n2Bhp0PZK0aLrSjeTA6PH501y
        AYxRXDYpqTmZZalF+nYJXBn/jl5gKXgiUbH06z+WBsYDwl2MnBwSAiYSU0++Zu9i5OIQEtjB
        JPFvfj8jhPOESeLX/YUsEE4/o8TOnplsEC35Euefv2aFsMslPn1+zAhi8woISpyc+YQFxBYS
        kJN4teEGI4TtJbFm4yQmEJtTIFDi0tFPUEPvMEosPPCAGSTBJqArsainGayIRUBFYtXvHVDL
        EiWaTv0AGsQBtCBAYsELV5CwsICRRMeFfWCtIgJqEtsv9LCCzGQWmMoocWzGMbBeZgFNidbt
        v9knMArPQnLfLCSpBYxMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfRyM0v0UlNKNzFCApl/
        B2PXeplDjAIcjEo8vBztDZFCrIllxZW5hxglOZiURHkVe+ojhfiS8lMqMxKLM+KLSnNSiw8x
        SnAwK4nwLpVujBTiTUmsrEotyodJSXOwKInzqi9R9xMSSE8sSc1OTS1ILYLJynBwKEnwuigA
        NQoWpaanVqRl5pQgpJk4OEGG8wANtwGp4S0uSMwtzkyHyJ9iNOa4cmXdFyaOKQe2f2ESYsnL
        z0uVEucNBSkVACnNKM2DmwZLRq8YxYGeE+Y9C1LFA0xkcPNeAa1iAlolWVoLsqokESEl1cAo
        eLBX54H8PWklttpYsThhxSrhm5/X7Tx1Zb989pF/P+zff4jX0xJY9aExkW/GWZ/Yu+W6zvwn
        Hzuncz0PWe34wLV94lYhzvLwtDeHt9b1Lugu+r2y9PwE/r8RH9sswk5KZAiu3//8rwV/sfDy
        +iusvaZhSW+qbp6xChRkbe0QS2bc8FayRUSJpTgj0VCLuag4EQCSEXaiIQMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 1, 2017 at 1:23 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Mon, Jul 31, 2017 at 11:41 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On Sun, Jul 30, 2017 at 8:51 PM, Shawn Pearce <spearce@spearce.org> wrote:
>>> 4th iteration of the reftable storage format.
>>> [...]
>>
>> Before we commit to Shawn's reftable proposal, I wanted to explore
>> what a contrasting design that is not block based would look like. So
>> I threw together a sketch of such a design. It is not as refined as
>> Shawn's, and I haven't had time to program an implementation or
>> collect statistics, but maybe it is interesting anyway.
>
> Thanks for taking the time to write this out. Its constructive to see
> other possible approaches.
>
> I roughly implemented your proposed design in JGit for references
> only. I skipped the object lookup and log handling for the sake of
> studying the basics of this approach.

Wow, that's awesome, thanks!

>        | size   | seek_cold | seek_hot  |
> mh     | 28.3 M | 24.5 usec | 14.5 usec |
> sp  4k | 29.2 M | 63.0 usec |  5.8 usec |
> sp 64k | 27.7 M | 35.6 usec | 23.3 usec |

OK, so it's at least in the right ballpark.

>> * Multiple related chunks can be stored in a 64 kiB block (interesting
>>   for people who prefer to read files in 64k segments). By storing
>>   related chunks near each other, the number of seeks will probably
>>   typically be smaller than the number of chunks that have to be
>>   accessed.
>
> This is difficult. The most related chunks are actually index chunks
> in the multi-level index. You want the next step(s) near the current
> step to avoid an actual disk seek. But that is hard to do when the
> index is several levels deep.

Given the 64k read size that you prefer, it seems to me that it would
probably be possible to keep pairs of index layers (i.e., one index
node and all of its direct children) in the same 64k range, though
this might require adjusting their sizes somewhat. And possibly to
keep the lowest index layer close to the reference chunks that it
describes (analogous to your format, where the restart records form
something like an index that is located close to the references). So I
would think that it is plausible to arrange things so that a reference
can be read within two 64k reads even if the index has three levels.

>> * The file can be written in two possible ways: with cross-references
>>   between chunks always pointing to later parts of the file (probably
>>   preferable if the data will be read from a local hard disk) or
>>   always pointing to earlier parts of the file (to accomodate writers
>>   who need to write their data in order). See the `offsets_negative`
>>   field in the header. (I'm not sure that the former variant is
>>   actually needed.)
>
> This seems like unnecessary complexity. I'd prefer to just say the
> offsets are negative, and reference backwards.

Maybe. I just wasn't sure whether a hard disk would perform
significantly worse when reading backwards rather than forwards
(because of pre-fetch of blocks). It could very well be unnecessary.

Michael
