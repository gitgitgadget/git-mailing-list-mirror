Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16EB21F89C
	for <e@80x24.org>; Fri, 20 Jan 2017 10:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbdATKqB (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 05:46:01 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:35623 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751686AbdATKqA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 05:46:00 -0500
Received: by mail-it0-f49.google.com with SMTP id 203so16414479ith.0
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 02:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iI1lONw8o8m1jIdgi6xF2m6dE2yoeDEn054y3dK5NEk=;
        b=S8kFrIlRV1old3dDD5cMg5tpyqGZcAUsxMpQmB2JfeEaUXeVV6NeHXKsPJeHsxjH0b
         K54sFl73uOowRCUOwZHZQr3/M+kmt7gBynIGk+OFtMgLgkdQsv3jwPnUzE858SdeIEf5
         6JOUfA1XCqwAIyXPEgFIw8S2odMWNX9nAqQtSM6k8wh2dAmae8CjqJ+CPLskPe8PSu9V
         iJjElpyl1pTliFO563fBOI2pElgw18UwHR4kkbOx9eNtCBqSQT33k/yKCKuxuuHP0YWO
         d6Mr3/zsefptkrvYK4RXOzj+n2d55xt7JSy6xXI+q0jXSUR5H06biRdFhDphJoI4cJ2J
         9QyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iI1lONw8o8m1jIdgi6xF2m6dE2yoeDEn054y3dK5NEk=;
        b=GYAguXanM615A+uSJNAecTNxYqM1+y3vCh9PFLKnwx/QQ/wqPn+89a+2sKuyz1WANj
         z5NvX5zW5+oj2xZ6eerXc1LWt90ooS19iujadPTyyMHoTgd6SaqPqJyznn3nr/+m2GY+
         yhhfJc+nTFtZEH35/UxYx7VZN/IvpYy9YGLYd7BzCJVjMijy2sI0IHe+WufZ3B4hWzj8
         CmjOIxlKTwuTkDjXpw4gs6ForgZkNB9aI309mJGl0HwVJjjXdAtjpIRQ2xC7qX3oJGj6
         Fgy0XGobNudN2lykfAgre6OEVfY3rqACyjfakI3JT5ALjfxSwN0h2Gtjx+UO3hMSFmHY
         9Qzw==
X-Gm-Message-State: AIkVDXKPVXt/RsRo5ERcF51+R93+hP9Z1hRG8telpch8Fpku1Q1m1C/Ku4NZpOUsaBx2EWOxY34oxP2bQpzE5Q==
X-Received: by 10.36.122.131 with SMTP id a125mr2755994itc.3.1484909112114;
 Fri, 20 Jan 2017 02:45:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Fri, 20 Jan 2017 02:44:41 -0800 (PST)
In-Reply-To: <xmqqlgu627uj.fsf@gitster.mtv.corp.google.com>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
 <20161226102222.17150-15-chriscool@tuxfamily.org> <xmqqa8bhb32x.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD1EgOxcPi=tpiosKkYMcCZe+b6gwW0CKt2sE1NZ7gQv=A@mail.gmail.com>
 <xmqqo9zi35n6.fsf@gitster.mtv.corp.google.com> <CACsJy8AR6yNr0y+_JZDkW-HO_yHPkUx_6zbLGoviKQBOVcSg5A@mail.gmail.com>
 <xmqqvatouwsh.fsf@gitster.mtv.corp.google.com> <CACsJy8B_xe6RtszPrncvDdSYosNUQxvhcEQ3DO_WO0sepXqvvQ@mail.gmail.com>
 <xmqqlgu627uj.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 20 Jan 2017 17:44:41 +0700
Message-ID: <CACsJy8DEZ1eOe5WXbS8WcTSdghadwHS4X7VDL97XvkVrfDrayQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/21] read-cache: touch shared index files when used
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 2:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Mon, Jan 9, 2017 at 9:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Duy Nguyen <pclouds@gmail.com> writes:
>>>
>>>> On Sun, Jan 8, 2017 at 4:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>> Christian Couder <christian.couder@gmail.com> writes:
>>>>>
>>>>>> So what should we do if freshen_file() returns 0 which means that the
>>>>>> freshening failed?
>>>>>
>>>>> You tell me ;-)  as you are the one who is proposing this feature.
>>>>
>>>> My answer is, we are not worse than freshening loose objects case
>>>> (especially since I took the idea from there).
>>>
>>> I do not think so, unfortunately.  Loose object files with stale
>>> timestamps are not removed as long as objects are still reachable.
>>
>> But there are plenty of unreachable loose objects, added in index,
>> then got replaced with new versions. cache-tree can create loose trees
>> too and it's been run more often, behind user's back, to take
>> advantage of the shortcut in unpack-trees.
>
> I am not sure if I follow.  Aren't objects reachable from the
> cache-tree in the index protected from gc?

I think the problem is loose objects created then gc run just before
they are referenced (e.g. index written down). But I think I may be
following a wrong road. If mtime is in fact to deal with race
conditions, applying the same idea here is wrong because we have a
different problem here.

> Not that I think freshening would actually fail in a repository
> where you can actually write into to update the index or its refs to
> make a difference (iow, even if we make it die() loudly when shared
> index cannot be "touched" because we are paranoid, no real life
> usage will trigger that die(), and if a repository does trigger the
> die(), I think you would really want to know about it).
-- 
Duy
