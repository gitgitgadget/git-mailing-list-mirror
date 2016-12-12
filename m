Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1686A206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 23:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752707AbcLLXux (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 18:50:53 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:54288 "EHLO mx1.2b3w.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752497AbcLLXuw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 18:50:52 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
        by mx1.2b3w.ch (Postfix) with ESMTP id 1BCF3C3442;
        Tue, 13 Dec 2016 00:50:48 +0100 (CET)
Received: from mcmini.bolli (21-244-153-5.dyn.cable.fcom.ch [5.153.244.21])
        by mx1.2b3w.ch (Postfix) with ESMTPSA id E6717C343E;
        Tue, 13 Dec 2016 00:50:47 +0100 (CET)
Subject: Re: [PATCH 1/3] update_unicode.sh: update the uniset repo if it
 exists
To:     git@vger.kernel.org
References: <1481499265-18361-1-git-send-email-dev+git@drbeat.li>
 <64bc846c-0304-dd7b-73bf-a6c3a4135381@web.de>
 <c96d013c38df7737cfd551a0fce87314@drbeat.li>
 <ca10a51a-0fab-e4a4-8d7d-035673af4c06@web.de>
 <xmqqr35dm203.fsf@gitster.mtv.corp.google.com>
Cc:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <954eed6b-c899-4f4c-eb3d-2b6d2ff4385d@drbeat.li>
Date:   Tue, 13 Dec 2016 00:50:47 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqr35dm203.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12.12.16 19:33, Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
> 
>> If I run ./update_unicode.sh on the latest master of
>> https://github.com/depp/uniset.git , commit
>> a5fac4a091857dd5429cc2d, I get a diff in unicode_width.h like
>> this:
>>
>> -{ 0x0300, 0x036F },
>>
>> +{ 768, 879 },
>>
>> IOW, all hex values are printed as decimal values.
>> Not a problem for the compiler, but for the human
>> to check the unicode tables.
>>
>> So I think we should "pin" the version of uniset.
> 
> Sure, and I'd rather see the update-unicode.sh script moved
> somewhere in contrib/ while at it.  Those who are interested in
> keeping up with the unicode standard are tiny minority of the
> developer population, and most of us would treat the built width
> table as the source (after all, that is what we ship).
> 
> To be bluntly honest, I'd rather not to see "update-unicode.sh"
> download and build uniset at all.  It's as if po/ hierarchy shipping
> with its own script to download and build msgmerge--that's madness.
> Needless to say, shipping the sources for uniset embedded in our
> project tree (either as a snapshot-fork or as a submodule) is even
> worse.  Those who want to muck with po/ are expected to have
> msgmerge and friends.  Why not expect the same for those who want to
> update the unicode width table?
> 
> I'd rather see a written instruction telling which snapshot to get
> and from where to build and place on their $PATH in the README file,
> sitting next to the update-unicode.sh script in contrib/uniwidth/
> directory, for those who are interested in building the width table
> "from the source", and the update-unicode.sh script to assume that
> uniset is available.
> 

OK. So please don't merge bb/unicode-9.0 to next yet; I'll prepare a
reroll following your description.

Torsten, is this alright with you?

Cheers, Beat
