Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55A81FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 17:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbcGSRoV (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 13:44:21 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:35174 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbcGSRoT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 13:44:19 -0400
Received: by mail-io0-f176.google.com with SMTP id m101so25661024ioi.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 10:44:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EDLLI1lobek39LJBOKl2L4ORetbA7Ve+ciFsX22xbxM=;
        b=oPOuCv56Tj/MQD6XOpEqICImRNCEf8fHOd8gvIGixhg31eIjV9tAm6uo8UkTZb3xn6
         F6DUk/60bkNrKE34BPBlUM7MyfIbF/gJ8iKgGtInKbowO40VtCH4NJwhkqAHsUJfEDws
         tc7nMYWSWJqzJEVuZztcKWe9h9Fhqcay49y8qZfGC2M+lc6+LNIhAQxdvmWZ4z/u/B9W
         2j11Cju0aV9Eh5LbCNt4gwlsI6L+lP9uXqmUtF7kqeuT9RZjQqX+7F8iCQb9B6s6NO+h
         Q8UhMgzlbO8fIyOIXXtoqVMD2j16hRRKlc+gYAhCfz69XdavU8EfcNAzljaIvX6XufCa
         RSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EDLLI1lobek39LJBOKl2L4ORetbA7Ve+ciFsX22xbxM=;
        b=VZtKwXMaX0KBlcRsGeTwxQmq8mF4ZW69SdpWLCRW9cdMmeNMyblgNSYKhFa3A3FCsJ
         B0/09Aos27ROTGwgda9xgDH43P0Uu8+XnnURjS7dAy6UH5rHfv4KuygFmG/akE1GJvkx
         qmt/l2v8OkI7d9bPIN+6uC2Z47ycL/SNL0MSx+4ShBQaGpqTk+iarGQ/wJB59wtdhDGp
         TJo5ypFhID6QMvG1VdqToQcSvfmOxKBEOerptrbruHBZIXwK0QFqisFZp9vzPoitoL4Y
         TxrHFP6tvWZ78wHTbPCa7ElWs2AvPt/AuSUwVXi4IeGu1r3gNivJ4NEqZFqd8MrE/nC+
         9e7g==
X-Gm-Message-State: ALyK8tL55zzounnqf37uIjdw4bvUGrvi4iXn5pZn0GbuKNpyz9uK9usUALP+psWK1qMm210P5OhKIgb3CWLRKA==
X-Received: by 10.107.2.78 with SMTP id 75mr3545779ioc.128.1468950258866; Tue,
 19 Jul 2016 10:44:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 19 Jul 2016 10:43:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1607191032270.25425@nftneq.ynat.uz>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net> <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
 <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org>
 <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <1468804249.2037.0@smtp.gmail.com>
 <alpine.DEB.2.20.1607180905320.28832@virtualbox> <CAPp-Vran2GZFTyJHb2qxgh3uRpM0ar7K2+VbbLcBK74_7aaxVw@mail.gmail.com>
 <alpine.DEB.2.20.1607181750470.3472@virtualbox> <CACsJy8Ba=c+-WV2TsY768_fTDO2KesS1b6BK7kdykNY6gkh=UQ@mail.gmail.com>
 <alpine.DEB.2.20.1607190910370.3472@virtualbox> <CACsJy8CSUu=AemQ-7uxth_2M=ko_KDGsdObwYdiE=L4OMKcVZw@mail.gmail.com>
 <alpine.DEB.2.02.1607191032270.25425@nftneq.ynat.uz>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 19 Jul 2016 19:43:49 +0200
Message-ID: <CACsJy8Bvqt9r2dRtRfx1C-3Fp16z3SJ=hp0i7-itwFwfEfZwTw@mail.gmail.com>
Subject: Re: Git and SHA-1 security (again)
To:	David Lang <david@lang.hm>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Herczeg Zsolt <zsolt94@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 7:34 PM, David Lang <david@lang.hm> wrote:
> On Tue, 19 Jul 2016, Duy Nguyen wrote:
>
>> On Tue, Jul 19, 2016 at 9:18 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>>>
>>>> But we can recreate SHA-1 from the same content and verify GPG, right?
>>>> I know it's super expensive, but it feels safer to not carry SHA-1
>>>> around when it's not secure anymore (I recall something about
>>>> exploiting the weakest link when you have both sha1 and sha256 in the
>>>> object content). Rehashing would be done locally and is better
>>>> controlled.
>>>
>>>
>>> You could. But how would you determine whether to recreate the commit
>>> object from a SHA-1-ified version of the commit buffer? Fall back if the
>>> original did not match the signature?
>>
>>
>> Any repo would have a cut point when they move to sha256 (or whatever
>> new hash), if we can record this somewhere (e.g. as a tag or a bunch
>> of tags, or some dummy commits to mark the heads of the repo) then we
>> only verify gpg signatures _in_ the repository before this point.
>
>
> remember that a repo doesn't have a single 'now', each branch has it's own
> head, and you can easily go back to prior points and branch off from there.
>
> Since timestamps in repos can't be trusted (different people's clocks may
> not be in sync), how would you define this cutoff point?

The set of all heads at the time the conversion happens (maybe plus
all the real tags). We can make an octopus merge commit to cover all
the heads, then it can be the reference point.
-- 
Duy
