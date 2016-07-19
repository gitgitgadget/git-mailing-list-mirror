Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 324681FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 18:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbcGSSFR (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 14:05:17 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:36279 "EHLO
	mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520AbcGSSFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 14:05:16 -0400
Received: by mail-it0-f50.google.com with SMTP id f6so97519652ith.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 11:05:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dePlzmSqTFKa4AxV3lH4VdRXKFoyJCEISGcQtDaWAuo=;
        b=D2S/ySleLrN8bpgJ6uV4Gh2nHKND6uM6CFVUX2FPfTdrpwj5sj3NwMpG1YQIBEwSwE
         7rE+lrtzi6n+neCNicKqKDhold7EQrjGJoIen6tJNNXAdqnNJ904vsXd9Gy3uWZrPsoj
         1canPTpsjq01tl8thKbQzTvEPd2MKa7Jf7+QMi3z2sX0N2ik6pUiSmllhTP5LfJ2FhYL
         rQ7XbgLI/cH7F9yMYcvZwXZpXnzD98DZkCNH/4fcilwN+9XCXqiDx4tI/10n03soN7yc
         QJhny7yZ+WNyTniOI2chZqu1oOB8xsKwSWopKGe6sx9VdfYi990GKW+vbFfwcupXyvWV
         7XiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dePlzmSqTFKa4AxV3lH4VdRXKFoyJCEISGcQtDaWAuo=;
        b=Ar22/aKBdsvc/cOP6Awi+sRNHKjOQ2WQFWgmaFFL5x38KwhuUvGAoG+Nb8jtCUNozI
         DG6kIpbiV1xq/Kpp++SvkDktPRv0lZwNWQ261c6VWEPWW4IYFlMVbhm8qxonYC5q+rCY
         uykmRxc+uqorYwmFNtnMlLAn6g+dw12ZAORLMkJMHkNLNm6w/pAsYZgLZxyPuaro7xK7
         VnKnaZdMfB122RE7TNj5wEi2ig9gx39YfjxJXvTz/h00cK2PSF9i24DiT4P650xf6+0+
         kYjyf8M39pbSbdpCaeuqhRJJkuyZTOEId8jsF+PQayIZHrToBCugCucXqp4sDzDcPINA
         /5Ag==
X-Gm-Message-State: ALyK8tKJ8lZiQmiMKjLpzS7GWKyST0Sp+OnHZDRtYAjh7yFO5PUmUhE6FkqwPXFrNUiTpqj5PpGE2HIJBEKhDw==
X-Received: by 10.36.115.5 with SMTP id y5mr15916585itb.63.1468951514811; Tue,
 19 Jul 2016 11:05:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 19 Jul 2016 11:04:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1607191057170.25425@nftneq.ynat.uz>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
 <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox>
 <20160717142157.GA6644@vauxhall.crustytoothpaste.net> <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com>
 <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org>
 <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <1468804249.2037.0@smtp.gmail.com>
 <alpine.DEB.2.20.1607180905320.28832@virtualbox> <CAPp-Vran2GZFTyJHb2qxgh3uRpM0ar7K2+VbbLcBK74_7aaxVw@mail.gmail.com>
 <alpine.DEB.2.20.1607181750470.3472@virtualbox> <CACsJy8Ba=c+-WV2TsY768_fTDO2KesS1b6BK7kdykNY6gkh=UQ@mail.gmail.com>
 <alpine.DEB.2.20.1607190910370.3472@virtualbox> <CACsJy8CSUu=AemQ-7uxth_2M=ko_KDGsdObwYdiE=L4OMKcVZw@mail.gmail.com>
 <alpine.DEB.2.02.1607191032270.25425@nftneq.ynat.uz> <CACsJy8Bvqt9r2dRtRfx1C-3Fp16z3SJ=hp0i7-itwFwfEfZwTw@mail.gmail.com>
 <alpine.DEB.2.02.1607191057170.25425@nftneq.ynat.uz>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 19 Jul 2016 20:04:45 +0200
Message-ID: <CACsJy8D1RtwVF4ZtRHV2Z=huTqRBp8Du5GMZq9qxwXDZezBF2g@mail.gmail.com>
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

On Tue, Jul 19, 2016 at 7:59 PM, David Lang <david@lang.hm> wrote:
> On Tue, 19 Jul 2016, Duy Nguyen wrote:
>
>> On Tue, Jul 19, 2016 at 7:34 PM, David Lang <david@lang.hm> wrote:
>>>
>>> On Tue, 19 Jul 2016, Duy Nguyen wrote:
>>>
>>>> On Tue, Jul 19, 2016 at 9:18 AM, Johannes Schindelin
>>>> <Johannes.Schindelin@gmx.de> wrote:
>>>>>>
>>>>>>
>>>>>> But we can recreate SHA-1 from the same content and verify GPG, right?
>>>>>> I know it's super expensive, but it feels safer to not carry SHA-1
>>>>>> around when it's not secure anymore (I recall something about
>>>>>> exploiting the weakest link when you have both sha1 and sha256 in the
>>>>>> object content). Rehashing would be done locally and is better
>>>>>> controlled.
>>>>>
>>>>>
>>>>>
>>>>> You could. But how would you determine whether to recreate the commit
>>>>> object from a SHA-1-ified version of the commit buffer? Fall back if
>>>>> the
>>>>> original did not match the signature?
>>>>
>>>>
>>>>
>>>> Any repo would have a cut point when they move to sha256 (or whatever
>>>> new hash), if we can record this somewhere (e.g. as a tag or a bunch
>>>> of tags, or some dummy commits to mark the heads of the repo) then we
>>>> only verify gpg signatures _in_ the repository before this point.
>>>
>>>
>>>
>>> remember that a repo doesn't have a single 'now', each branch has it's
>>> own
>>> head, and you can easily go back to prior points and branch off from
>>> there.
>>>
>>> Since timestamps in repos can't be trusted (different people's clocks may
>>> not be in sync), how would you define this cutoff point?
>>
>>
>> The set of all heads at the time the conversion happens (maybe plus
>> all the real tags). We can make an octopus merge commit to cover all
>> the heads, then it can be the reference point.
>
>
> so to make sure I'm understanding this, anything not reachable from that
> merge must be the new hash, correct? Including forks, merges, etc that
> happen from earlier points in the history.

Yes everything except that merge and everything reachable from it, the
whole old clone, basically.
-- 
Duy
