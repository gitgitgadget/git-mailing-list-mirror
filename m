Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C86C1F576
	for <e@80x24.org>; Fri, 19 Jan 2018 08:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754918AbeASI2z (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 03:28:55 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33315 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754777AbeASI2o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 03:28:44 -0500
Received: by mail-qt0-f194.google.com with SMTP id e2so2046734qti.0
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 00:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=u44vWvCq2ipyygyVONweGIRwyjg/L+/dCKimNG4Oclk=;
        b=W2ZpBVFjYlvcVFnDS7/uBM0VqwirhKFAi/wkv+4oxOuMXzTCyOt8PNRXc6D05nzonm
         DpnmWDkbhmKKMSBPSwWpE2QdsxYBayJ6hZnn6bVuYUtOJuhrMPqTo3hjORTJQOb7Wjzh
         BAtl0WLVJihnAdQoqr49KNz/CcEutSNP9aysb3pfN9zX+SdqrZMhpkkFZRWxyYdKrBrA
         JYa1EjLlgTX+kj8kTgl9oFhwgxr41EHTKksN/VGMOfrQWA9OV9/+jFFnRyKq1YZgIZ6v
         EJOHkqMDxmpQhvBh5Cr3IprIh0yAexZHjSqeRI+qxs5VovE2A2lDevgUCTd+tywMOk/O
         kzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=u44vWvCq2ipyygyVONweGIRwyjg/L+/dCKimNG4Oclk=;
        b=CdfJSUcz7pC6Aw0HUi3Km8UjeNG4dD5rrAb8UNgwEUHwkpcRhEk6isnsrcD7nCn/rL
         2+AhWbaGQVu+exqz82bK58zgGnihZlgmLLXqwaMZx5U6ISAfpykaG86Qh/aBs8MivXYp
         uRSDEIRQfBhBM52ycYmwQgwWkUQISKd95WUg4vw+BQS5rU10HO06z0GmznukU0c22UFs
         bxVnxtO8YT1o9BYyutzz72iIAGZPXyVNd+ODipjDf5NNzKM4CYV8KFH0GnAMHG+z2jVE
         eUQ99U2HgwMhDPP/6cvbxAI0E11T9fkUernI+1NOHdrmhcMDaPc9qG+GvjcEsPPYGYae
         3dqw==
X-Gm-Message-State: AKwxytc3+rXxB7HxAi+hgHkcYSVLABqlFO54YLaWJqPeLFX3uL9xk+O9
        eUGhKXbFcFyQ6/hcY+hoqWM86PgD/viJkh9dUdw=
X-Google-Smtp-Source: ACJfBotQqwWjrmFMe3cJiB6ZBux6s86mW4lGfeXZYI2JekDDCLFybcJGvmyWy+Hs2GtvmxVytOpGWQFq66ry+TQugDk=
X-Received: by 10.200.47.130 with SMTP id l2mr39086166qta.277.1516350523136;
 Fri, 19 Jan 2018 00:28:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 19 Jan 2018 00:28:42 -0800 (PST)
In-Reply-To: <CACsJy8AOPDNTbAWzDHd+Oa5PSc1v2qdfcaq60P7X5wznM4VTug@mail.gmail.com>
References: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com>
 <CAPig+cTkBEGyoS93GYCtoDgccTF_UixqBkVTExg7Zf0M1J7KRQ@mail.gmail.com>
 <20180119024738.GA222163@genre.crustytoothpaste.net> <CAPig+cSbbzKV0GttLjHCyY3CNcJO0bdP3Mp4pT+3waUTMAQ8kg@mail.gmail.com>
 <20180119034025.GB222163@genre.crustytoothpaste.net> <CACsJy8BTFm_0sv=roL1OKKW=1DyU3vqD50NKyHg3KQ7G+mAepQ@mail.gmail.com>
 <20180119074001.GA55929@flurp.local> <CACsJy8AOPDNTbAWzDHd+Oa5PSc1v2qdfcaq60P7X5wznM4VTug@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Jan 2018 03:28:42 -0500
X-Google-Sender-Auth: BHvqZn0i7Lu583q-wsPizVg0jPc
Message-ID: <CAPig+cQmCeEHZNkYSRPUTZHyRP-Tkiobx6ghSktYiT9CCBV6FA@mail.gmail.com>
Subject: Re: git 2.16.0 segfaults on clone of specific repo
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 3:22 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Jan 19, 2018 at 2:40 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Fri, Jan 19, 2018 at 12:31:58PM +0700, Duy Nguyen wrote:
>>> On Linux, after I hacked all over the place to force ce_match_stat()
>>> to eventually call index_fd() which in turns must use one of the
>>> hashing function, I got a crash.
>>
>> Nice detective work.
>
> And not stepping back to think for a bit. I realized now that if I
> just mounted a vfat filesystem, I could have verified it much quicker.
> It does crash on linux with similar stack trace.
> [...]
>> This particular manifestation is caught by the
>> following test which fails without brian's patch on MacOS (and
>> presumably Windows) and succeeds with it. On Linux and BSD, it will of
>> course succeed always, so I'm not sure how much practical value it
>> has.
>
> There's a travis job running "on windows" (I don't what it really
> means) so it might help actually. This vim-colorschemes repository has
> shown up in git mailing list before, I think. We probably should just
> add it as part of our regression tests ;-)

And, Dscho does run the test suite on Windows regularly, so perhaps
this test does have some practical value.
