Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B47D1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 16:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754655AbeDQQZO (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 12:25:14 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:40191 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754471AbeDQQZM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 12:25:12 -0400
Received: by mail-oi0-f48.google.com with SMTP id x9-v6so18545171oig.7
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 09:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zJ7vQQrwf9AOqLwqVXTBLcot6zVz7rWNH/ER+wWMFXQ=;
        b=rdLy4ZoXvLKIa6pxNFXHRceFXa+3ISt0NH7a4XYgBZcUhZWm++0TqjUBV3bEmgbM3n
         P6Q+2PMvMCRMY7GqrR8bDWyWj2Aq9fhSjNRLtrEVTyItpfw0vEL3O12e7O2jsD2nm6EJ
         0Mys2OzzkUvXCevsY3UTGUpzoDjjKJIJMYykt6BEExHXAHHtHlU8Qb7x6OU2ZD2hMPcU
         4PHlBGoDv7KLPa1iIKlrZU6lW7l3wUZPjtr01k/CfSSK/dO1PKRgRCrLXhkfhk5jhHif
         8KpkBAGOi6E23qO1SSnfFISofjtqPsgHu4PzKjTVLV2PmpSiGcZtgE2Ft1Ukd02KT6+K
         qfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zJ7vQQrwf9AOqLwqVXTBLcot6zVz7rWNH/ER+wWMFXQ=;
        b=NHONj87UF0v+ao+Vo1lBBYQNu+HCXXN8MGwy/AmkXJZFpMhIO70nUUE9fq5SomWsVm
         kmFoy0gZbDsGJxxVpqW7CaKx9P3CIBPkenKAhNQqTW2iJtDqmJsowJbG7YGYwpENG8mj
         PW6ER90kp9+uiAmvKkjI1BJ1btdJPmGjZp2AoBOtXudsvBAFsQlzZ/+m7o61Y8mP51mH
         0cRWe2u2sVNNL2hw4mrDXzsIEUz2X8RmywgrizYiIYMn4OLqB+09x2dfw0krA+/sGMbf
         hWlnrc5zvVqq7Nerq1VoPz3ysCf0Ve+F+zML/qDx8SSzvt8Zk18on0VDb3DYsh0etQUe
         R4bg==
X-Gm-Message-State: ALQs6tACKUcvqM6A/y3oQKW5J26BXu3DluCS7LCZ0dbtG/1tB2vvDd3k
        prkXxsGbd62125oiI0F4tgxPTyB4mSvtG8eZS8rsVA==
X-Google-Smtp-Source: AIpwx4885aHiaL1tQ0BfLEgaTv3UoLozM+ioQfdsWBsQg0qwmGmmrvZ4o7XgMwPD0sI/YmxX9OFssIbkTb408l5+528=
X-Received: by 2002:aca:51ce:: with SMTP id f197-v6mr1224899oib.32.1523982311839;
 Tue, 17 Apr 2018 09:25:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Tue, 17 Apr 2018 09:24:41 -0700 (PDT)
In-Reply-To: <A9B6B3A17C4844C69F8865C01BCFC51A@PhilipOakley>
References: <20180326165520.802-1-pclouds@gmail.com> <CAPig+cTW7KRzXXY7vP-GZ23effYd5jLhiL15KqdRam4rNELCWw@mail.gmail.com>
 <FBB059C530054EEAB2E989D86CBE3BD5@PhilipOakley> <CACsJy8BqoW_YWBiMoOks+WM5XY7Mmadkd0LUBoUWLDXehx1GZQ@mail.gmail.com>
 <A9B6B3A17C4844C69F8865C01BCFC51A@PhilipOakley>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 17 Apr 2018 18:24:41 +0200
Message-ID: <CACsJy8BTX=6FsH7-Dc86ExQRfBSNVn9yxD5JrNZyLT9VDQOPEg@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/5] Keep all info in command-list.txt in git binary
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 15, 2018 at 11:21 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Duy Nguyen" <pclouds@gmail.com> : Saturday, April 14, 2018 4:44 PM
>
>> On Thu, Apr 12, 2018 at 12:06 AM, Philip Oakley <philipoakley@iee.org>
>> wrote:
>>>
>>> I'm only just catching up, but does/can this series also capture the
>>> non-command guides that are available in git so that the 'git help -g'
>>> can
>>> begin to list them all?
>>
>>
>> It currently does not. But I don't see why it should not. This should
>> allow git.txt to list all the guides too, for people who skip "git
>> help" and go hard core mode with "man git". Thanks for bringing this
>> up.
>> --
>> Duy
>>
> Is that something I should add to my todo to add a 'guide' category etc.?

I added it too [1]. Not sure if you want anything more on top though.

[1] https://public-inbox.org/git/20180415164238.9107-7-pclouds@gmail.com/T/#u
-- 
Duy
