Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 362BE1F859
	for <e@80x24.org>; Mon, 15 Aug 2016 06:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbcHOGtt (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 02:49:49 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:36645 "EHLO
	mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbcHOGtt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 02:49:49 -0400
Received: by mail-it0-f42.google.com with SMTP id e63so1118998ith.1
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 23:49:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RXwEifSm+cyDi9rgJCylSnX+PFCDyVzdZ/ED2A4RJQk=;
        b=oKz/5VDqQOlYWsipzEwBpG4eBThSr0BBS19CVoFr8Kb7OQ22kT6fk+Fhpc3/5CAMIM
         OpKfrvLZjRuqdPQiygcxjbAKsyT8+nBt0HmXf0HfiO/WM7jZ4bSD9Cj0Gd6ZfhyTxSWK
         TC1PNAOxxY+HLzfGY0G8OANrHDAUx1g3siEw0G2Tjw8uteOFZU6fF3aMWw29y+PMxOaZ
         647TzAsP/pQmk9i3UL7g9EChXP0yItgJvmzCLLlF8XRW8OQC2B5FojwHFQBTRuKgdpRs
         /N8Hoi5Th1sDrQjmi+IMWN0kTN5ToOXrEJKMrjzdxuBB5pbM6cBsyKrq6DkM098w1mYx
         SrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RXwEifSm+cyDi9rgJCylSnX+PFCDyVzdZ/ED2A4RJQk=;
        b=YSITh1Aw+pST0HHto+Vz3jvY2SVE/9Kbps7PQvfsCGpzjljDPpIPE7STRK/+HAM9Yt
         3mJBssrYFfT9ig97bJyrcVUccyHW8FDUfngxikZi4AiiPiAE8/4n7RpNIBpMMrwgPpnD
         cheWeY7qIO0UnzzvxZysLw5I8jfJ3j+IHZWg1wEbP3idTPtmlRV9yOyiT/G4+2X0ZDjb
         y/ynfLjBMqSK+l3gHhqP0dUFCWDMfBEphLsNohGS2TLtCBIain+svx0EgF2z2lmmNpiz
         SeBFrHDgSrQlIfu5aeZev9VPKATWJXRvBADtoFJnxJb+pFqW8QAoNSu/Y481CXeBiOKa
         kELg==
X-Gm-Message-State: AEkoout0AD9BxFzSKIeK3dF+bsgKfBDbeT8kxMBlSJodxNyZxf3m9xg/3G+T7a1dlgJ+X2n92hY4b3U0tKEJ0mH9
X-Received: by 10.36.227.130 with SMTP id d124mr11555272ith.97.1471243788153;
 Sun, 14 Aug 2016 23:49:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Sun, 14 Aug 2016 23:49:47 -0700 (PDT)
In-Reply-To: <CA+P7+xpgzRGiNtWrzjebP4EJr1kCed4w5JX412FhSHoZZrkNRA@mail.gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
 <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com>
 <CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com>
 <CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com> <CA+P7+xpgzRGiNtWrzjebP4EJr1kCed4w5JX412FhSHoZZrkNRA@mail.gmail.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Sun, 14 Aug 2016 23:49:47 -0700
Message-ID: <CAGZ79kZG2H8P13ivDJWYM7snmw3EqrGr=FaaHkXJotzhRfa00A@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
To:	Jacob Keller <jacob.keller@gmail.com>
Cc:	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Aug 14, 2016 at 11:38 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Sun, Aug 14, 2016 at 11:28 PM, Stefan Beller <sbeller@google.com> wrote:
>> I would imagine this is similar to the pull requests on the linux
>> mailing list, i.e.
>> how it is with merges. Back in the time we did not open the editor for you to
>> talk about the merge you just did, and then we started doing that.
>>
>> So what to do when the description already exists?
>>
>> We could amend the description separated by a
>>
>>      # comment, below was added:
>>
>> line or such and then open the editor asked for user input.
>>
>> Thanks,
>> Stefan
>>
>
> This is why my gut feeling is that we should instead have a separate
> way to store a cover letter, as it doesn't necessarily have to apply
> to a branch

Well in our workflow each series has at least one merge commit.
(You *could* have different descriptions for the different branches,
e.g. for maint: "fixes a segfault so let's get this in, but it needs to be
redone properly" and for pu: "TODO: revert this partially
when branch $proper-fix is merged")

> or a merge commit, but could just be annotation against a
> series of commits (maybe stored as base + tip, since most series would
> be linear in nature?)

We could suggest to use a merge always strategy for this, i.e. as soon as
you send a cover-letter, we'll make a merge for you whose parents are the
old HEAD and the new series?

If the user strictly wants to have a linear history, then we could try some
empty commit magic before or after the series, but I doubt this is proper.

If users insist on linear history, they deny the benefits of a DAG that
represents how the source code evolved. (Also see the eternal rebase
vs merge discussion ;)

>
> However, opening an editor and amending seems quite reasonable to me
> if we're just editing branch description, and then storing that as
> part of merge commit would be reasonable?
>
> I really think we want some alternative way to store it for other use
> cases besides the description, though.

"besides the description"?

What do you mean by that?

Thanks,
Stefan

>
> Regards,
> Jake
