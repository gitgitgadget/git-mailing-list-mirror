Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 089562082E
	for <e@80x24.org>; Fri, 23 Jun 2017 05:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754360AbdFWF2K (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 01:28:10 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:32983 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754225AbdFWF2J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 01:28:09 -0400
Received: by mail-pf0-f181.google.com with SMTP id e7so19017829pfk.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 22:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=TfiHMYmxW63fnt5nCwc0HvBaUmFfV/T6eOUdmjmbNVg=;
        b=IQYDMhxt0AGa1ikvBSc3V/wHUoqzN8jp79HPCXlJoL2PE6c/dj9QHFM/zYxxcDbqRQ
         TFWOiaM2beQg2nYwMYR8YFGySLw6w7DK8v1F5lVCNU59zzhDaejp6Qsz7tRNLjjX17QG
         kKPyeKomFvLN5Xt+Xd/9kfCXz3liB+Vz+6sCiUHGaCfYey0gGamcPE8Zo+2sUepSdKeV
         4lCOIqbvx63IDgQVZ8PwpoUGzP3UheKHhlIAvsYBdhVU1NFMmjJWbHfknoRh+B1rDVuT
         heK2G+PFgU3zBxsmpdMbOfy7Gpd3ocfDnsgeD9keXlxK33t4dxQslcHU11laevTJzlKz
         Sf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=TfiHMYmxW63fnt5nCwc0HvBaUmFfV/T6eOUdmjmbNVg=;
        b=T3W5AiYBF2M07t1PoWpM2c+MeYY5BCH9idA/n00DDAk6DM2ibkGuFPDxEehgMY00Wx
         1wWcG6j1nRdeQDMYPiyYcAPtamcqQyuSl1Cf6bdCfXpXWnPxw6S+o6esNAxYZMH1NYIL
         bdai73bnAPX8OLdfoIXcifKXdwXpyQZYwpPfLVo87Rm63V8MeaU/SRXkhdbQmPp6iREB
         PRVoPgE0HFzAQfh+TTKbmTFgXUAgplAajtBkLQc7FKcYHTP6ZCoT4lp8yCIYA6VcjkeR
         GRAqqHXkXPwemQjYCu8CAJuKWQF1qHwFSh19q8FL4kG/lLFV9NBsx5KUCDn5NFEmsIES
         CIcQ==
X-Gm-Message-State: AKS2vOwQhjJ+3owGPB6a1Uya0oS0v9U0Ze3WNIk7gu3dZEQP7EoZSnJA
        pHsadhd6ZwSPMg==
X-Received: by 10.84.224.78 with SMTP id a14mr6920704plt.64.1498195689189;
        Thu, 22 Jun 2017 22:28:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id p23sm7609671pfk.67.2017.06.22.22.28.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 22:28:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Ben Peart <peartben@gmail.com>,
        xiaoqiang zhao <zxq_yx_007@163.com>
Subject: Re: What's cooking in git.git (Jun 2017, #06; Thu, 22)
References: <xmqqinjnhcr8.fsf@gitster.mtv.corp.google.com>
        <877f03k4tp.fsf@gmail.com>
Date:   Thu, 22 Jun 2017 22:28:07 -0700
In-Reply-To: <877f03k4tp.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Fri, 23 Jun 2017 00:58:26 +0200")
Message-ID: <xmqqo9tfff2w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Jun 22 2017, Junio C. Hamano jotted:
>
>> * sd/branch-copy (2017-06-18) 3 commits
>>  - branch: add a --copy (-c) option to go with --move (-m)
>>  - branch: add test for -m renaming multiple config sections
>>  - config: create a function to format section headers
>>
>>  "git branch" learned "-c/-C" to create and switch to a new branch
>>  by copying an existing one.
>>
>>  Has a bit of interaction with two other topics, so perhaps needs to
>>  wait for them to stabilize a bit more.
>
> What topics are those? Didn't see any outright conflicts, but might have
> missed something. Anything Sahil & I can help with?

Sorry, I write these and then forget the details because I have to
tend to many other topics all the time X-<.  Perhaps attempting the
merge to 'pu' yourself will tell you more?

>> * ab/sha1dc (2017-06-07) 2 commits
>> ...
>>  Will keep in 'pu'.
>>  Impact to the various build and release infrastructure of using
>>  submodule is not yet fully known, but this lets us dip our toes.
> ...
> But it's been 1 month kicking around in pu now. What are we gaining from
> keeping it there even longer at this point?

Keeping as many things outside 'next' means I have less things I
have to worry about ;-)

I am sort of waiting for a success from Windows box at Travis.  It
hasn't passed for other reasons for a while, though.

>> * xz/send-email-batch-size (2017-05-23) 1 commit
>>  - send-email: --batch-size to work around some SMTP server limit
>>
>>  "git send-email" learned to overcome some SMTP server limitation
>>  that does not allow many pieces of e-mails to be sent over a single
>>  session.
>>
>>  Waiting for response.
>>  cf. <CACBZZX5GYV50rjg9X602JHqFPaoofH9TwDf_-r_MDu8-rmNV6Q@mail.gmail.com>
>
> I think between <7993e188.d18d.15c3560bcaf.Coremail.zxq_yx_007@163.com>
> & <20170523103050.1f7ab7e0@jvn> we have sufficient info about what bug
> this solves to try an alternate approach at some other time.

I thought your wish (which I found reasonable) was to record
whatever information that would help us in the future in the log
message?  I was waiting for that to happen.

