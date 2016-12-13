Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AF85203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 17:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933932AbcLMRzk (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 12:55:40 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33809 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933299AbcLMRzj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 12:55:39 -0500
Received: by mail-qk0-f177.google.com with SMTP id q130so124319055qke.1
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 09:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sgAquOx5oolO5vvJO4vWIC0/gmt1Z4RrsJ2OUo2f/2Q=;
        b=mJzjYUfbyMm+Uia5uMJr1YxuecOP2tsho7uVEybq/MuxhIzR81GR1n3aTs0dtFK4h/
         wbUoIFEnIzj57KEWGalq780lSLKq8/+Xil7eFiEeTsm2ll2ZbBx28HOFBM3fQgysh4/z
         sC8gsawrLUs5Ag617FElCkYoq45dDZXs7jOF7YfDkYxuLcUUcVSbjJtZmTDRIaxWUGJL
         p1fg4mxe70V4MHejxxBTykI1E0CWJ9096BVyE7Q85w1UP4T4tp9vYOvhA858ntTr4eCp
         cMNKNTDAtrJ4D9ibUoiEiepPdsNL5vx/HwMFhwmf+tVphwpqLC16/CzCyAZgSIxxRMDa
         2eKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sgAquOx5oolO5vvJO4vWIC0/gmt1Z4RrsJ2OUo2f/2Q=;
        b=U0ppgrCbJ8su/LKnumUJKgJGBq8lB1bI/CAzU72D3SWwrQmOTCLzaFclZV2MEZwhrp
         Zrc7aEGgLP91Jn1JkNGb9vtXh3X1me23yXmBDncSBOhrvq/kLCGQ2V6VFAcuKN6Tmr4E
         GCI+WJxgdBzIUqtssOBu66ACDhMQKsZdQEZ66XgDMBfQEr8yB1qNl23gViIr30SobrqB
         qi8H0gJMgnVTmCjlGyXVJdsIv5oG9U08OBMc3ec8mNwXZhjjO8W4wufQhyYViTQMQIY8
         4NdHDE2htTwzUTxeY8hri0y1UqdM49VETcedRn9th9xcLK4yTmq523NczkTOrl5ypD7L
         i1EA==
X-Gm-Message-State: AKaTC03WBqKXIIRWkoJxgqOvSPWypljdOGxNrhlhoZFPP9JKD+hIxK5eVMFudSfWqRHpC9cRaXPDS+44FgXzOEtT
X-Received: by 10.55.16.147 with SMTP id 19mr83682198qkq.255.1481651737976;
 Tue, 13 Dec 2016 09:55:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 13 Dec 2016 09:55:37 -0800 (PST)
In-Reply-To: <xmqqr35c5luq.fsf@gitster.mtv.corp.google.com>
References: <20161213014055.14268-1-sbeller@google.com> <xmqqr35c5luq.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Dec 2016 09:55:37 -0800
Message-ID: <CAGZ79kbmtYzFmEKrxHKx-_WY=0NDJM=QZYJziim-eh-w4WzDKw@mail.gmail.com>
Subject: Re: [PATCH 0/6] git-rm absorbs submodule git directory before deletion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <David.Turner@twosigma.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2016 at 11:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The "checkout --recurse-submodules" series got too large to comfortably send
>> it out for review, so I had to break it up into smaller series'; this is the
>> first subseries, but it makes sense on its own.
>>
>> This series teaches git-rm to absorb the git directory of a submodule instead
>> of failing and complaining about the git directory preventing deletion.
>>
>> It applies on origin/sb/submodule-embed-gitdir.
>
> Thanks.  I probably should rename the topic again with s/embed/absorb/;

I mostly renamed it in the hope to settle our dispute what embedding means. ;)
So in case we want to further discuss on the name of the function, we should
do that before doing actual work such as renaming.

Note that sb/t3600-cleanup is part of this series now,
(The first commit of that series is in patch 6/6 of this series, and patch 5 is
the modernization effort.)

Thanks,
Stefan
