Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6D5C1FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 18:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbcGSS6b (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 14:58:31 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:38464 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbcGSS63 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 14:58:29 -0400
Received: by mail-it0-f48.google.com with SMTP id j124so29030982ith.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 11:58:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nQ0N8cxiCDj3H/S2iF2kDMHhfuBC0U1zU9Kydh8sqC8=;
        b=dNG0PG6BkDSSLYH9zchOU+JwTJ3nFLEY9c5Whgk//YPYiRFPW8c84ArtKICVaSx5n3
         9avrhHiNHo3LIioX9dlE5DHUTzKpjA9jMJXL6/NQ/MKdH/mqVf++bZm4V3jNdE9pzmQ7
         dIRIh25CkTo19iToLYj6w3269MO9Hy/Stgj+wEEwGo01cba19gb3yws3QmgCIt4eKgK8
         uWw/7KAEGm4dQBr1f94kp2/WqAXg3S9po3aqxQDUk8fXNW/APUNZt09+en0H+BhvGAUe
         jqKf4O1Q2tnxot64uqhAC9nlWOOVEs+x2pMCRWYdB+pLwDKbnPTOctOA15SaSwhV8p3F
         obAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nQ0N8cxiCDj3H/S2iF2kDMHhfuBC0U1zU9Kydh8sqC8=;
        b=DWszZbjooW+TQitIqW23am75cOcLbLh4YUHtvK8OkitbgeMUEoDQZ/hnt1FzpK3Jp6
         bKNmHbDem1XuR9guG1wkK4PTZoBRL19rgawf6wRe4vCVvQqjYAOMyEX+oiuCd5CmpRy2
         L8rcLQihkc1RJYnKTUNfkae4Fwr+dHNNgIQzxNsIIdVx10RzhQe9kbzBWnMBQH0i2Y8j
         3c3lBr29AlZTHREeUAMPG+RB8Kh2qzrzQSQtC3kRKT4v3gndxSwnUi/5iwEP0Ss7DLs+
         y5wwe/bVQqfqcLdJRxxC+8b/P/eMIeesyaXVMAXf5m9ROle2xcraQx2X3u+2KQTfK1hs
         oO+A==
X-Gm-Message-State: ALyK8tIxVGXjs9/vOavSAnTi3Q5rGyQq9dQTgk28SNQsxHMi0kKijnd0EzVJWLy59ElHGKdpKCNBjnudXv1s0w==
X-Received: by 10.36.115.200 with SMTP id y191mr5901342itb.3.1468954695764;
 Tue, 19 Jul 2016 11:58:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.83.4 with HTTP; Tue, 19 Jul 2016 11:58:14 -0700 (PDT)
In-Reply-To: <CACsJy8D1RtwVF4ZtRHV2Z=huTqRBp8Du5GMZq9qxwXDZezBF2g@mail.gmail.com>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net> <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
 <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org>
 <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <1468804249.2037.0@smtp.gmail.com>
 <alpine.DEB.2.20.1607180905320.28832@virtualbox> <CAPp-Vran2GZFTyJHb2qxgh3uRpM0ar7K2+VbbLcBK74_7aaxVw@mail.gmail.com>
 <alpine.DEB.2.20.1607181750470.3472@virtualbox> <CACsJy8Ba=c+-WV2TsY768_fTDO2KesS1b6BK7kdykNY6gkh=UQ@mail.gmail.com>
 <alpine.DEB.2.20.1607190910370.3472@virtualbox> <CACsJy8CSUu=AemQ-7uxth_2M=ko_KDGsdObwYdiE=L4OMKcVZw@mail.gmail.com>
 <alpine.DEB.2.02.1607191032270.25425@nftneq.ynat.uz> <CACsJy8Bvqt9r2dRtRfx1C-3Fp16z3SJ=hp0i7-itwFwfEfZwTw@mail.gmail.com>
 <alpine.DEB.2.02.1607191057170.25425@nftneq.ynat.uz> <CACsJy8D1RtwVF4ZtRHV2Z=huTqRBp8Du5GMZq9qxwXDZezBF2g@mail.gmail.com>
From:	Herczeg Zsolt <zsolt94@gmail.com>
Date:	Tue, 19 Jul 2016 20:58:14 +0200
Message-ID: <CAPp-VrZ1YjUyPYwgH2CD1fohU1R+uSizyVE6QwMXHcztvcQqSQ@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	David Lang <david@lang.hm>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

2016-07-19 20:04 GMT+02:00 Duy Nguyen <pclouds@gmail.com>:
> On Tue, Jul 19, 2016 at 7:59 PM, David Lang <david@lang.hm> wrote:
>> On Tue, 19 Jul 2016, Duy Nguyen wrote:
>>
>>> On Tue, Jul 19, 2016 at 7:34 PM, David Lang <david@lang.hm> wrote:
>>>>
>>>> On Tue, 19 Jul 2016, Duy Nguyen wrote:
>>>>
>>>>> On Tue, Jul 19, 2016 at 9:18 AM, Johannes Schindelin
>>>>> <Johannes.Schindelin@gmx.de> wrote:
>>>>>>>
>>>>>>>
>>>>>>> But we can recreate SHA-1 from the same content and verify GPG, right?
>>>>>>> I know it's super expensive, but it feels safer to not carry SHA-1
>>>>>>> around when it's not secure anymore (I recall something about
>>>>>>> exploiting the weakest link when you have both sha1 and sha256 in the
>>>>>>> object content). Rehashing would be done locally and is better
>>>>>>> controlled.
>>>>>>
>>>>>>
>>>>>>
>>>>>> You could. But how would you determine whether to recreate the commit
>>>>>> object from a SHA-1-ified version of the commit buffer? Fall back if
>>>>>> the
>>>>>> original did not match the signature?
>>>>>
>>>>>
>>>>>
>>>>> Any repo would have a cut point when they move to sha256 (or whatever
>>>>> new hash), if we can record this somewhere (e.g. as a tag or a bunch
>>>>> of tags, or some dummy commits to mark the heads of the repo) then we
>>>>> only verify gpg signatures _in_ the repository before this point.
>>>>
>>>>
>>>>
>>>> remember that a repo doesn't have a single 'now', each branch has it's
>>>> own
>>>> head, and you can easily go back to prior points and branch off from
>>>> there.
>>>>
>>>> Since timestamps in repos can't be trusted (different people's clocks may
>>>> not be in sync), how would you define this cutoff point?
>>>
>>>
>>> The set of all heads at the time the conversion happens (maybe plus
>>> all the real tags). We can make an octopus merge commit to cover all
>>> the heads, then it can be the reference point.
>>
>>
>> so to make sure I'm understanding this, anything not reachable from that
>> merge must be the new hash, correct? Including forks, merges, etc that
>> happen from earlier points in the history.
>
> Yes everything except that merge and everything reachable from it, the
> whole old clone, basically.

It could work, but does it worth it?

1) If you use multihash, you should assume that anything with SHA1
could be manipulated. That means you can "inject" something later to
that "old clone" anyway.
2) Even if the content is re-hashed, it's hard to understand for a
user where the trust comes from. The user should decide weather he
trust (or not) the person who signed that octopus breakpoint.

Even without git you can achieve this security: Get the complete old
repository, make a signed tarball of it. If anytime later you want to
check that signatures, you can just use that tarball. I don't think
it's worth the trouble to create a native method for something which
is rare, and can be worked around easily. It's actually easier for a
user to understand the "trust relation" when using this workaround.

Referring to that signed-tarball approach, you may just as well drop
all signature data on conversion... As long as you can look up the
references to old hashes easily, I think it's usable enough.
