Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 082CF20958
	for <e@80x24.org>; Thu, 23 Mar 2017 18:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753509AbdCWSBS (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 14:01:18 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36467 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753305AbdCWSBR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 14:01:17 -0400
Received: by mail-pf0-f169.google.com with SMTP id o126so109002159pfb.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 11:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CTont/4bwH2RCZi8UKYr2+iqei+v5iymaQ+7U/Q/gN4=;
        b=gqIC+wSEWCMg0KXkRzFw4h9WlTsP4x4NJvcPj+a6qDZUGskLXd67xxDJV1tZ20Va0l
         aeTOWriLoCrSUit3y5zLm8E3RNgSInYDtvNyYIoi9wbkMqiJxR9sID7dyIX1RlZzpX7O
         qf+7Fx+FI8MwZNgSugtP5WOTsQ316gUw65quptgGm7mekLCAgJ8nZZCziFOMafnDmqac
         jH6+hTqEg+JlXa5Wizq9XhxcQ2/Zn9bUu3sXXAgHvV9ww8JzbwpEy1eAigZXBaRp+0Vc
         LKu9cQiJF/COrbeoldoXDrFveBo2h/eKW6ha4Gglpb4LsJaGU5pfDdZJomGsxqhbd81c
         py0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CTont/4bwH2RCZi8UKYr2+iqei+v5iymaQ+7U/Q/gN4=;
        b=mMX6FYJpb8FSvr+Q8/tdUMAu6xxjTTKPf+hN49kpI9jlrrSwS+g51gTvxQ5/0yIdBM
         Het6hD0ge6PZ6HY96X2Z0QwXFmT2GYwWPGcC0Pytlx2btc4O9vfhTqLEBrUY/z21M65V
         7DkvSAqBCflHrqArrIpNxwAb+eJxrwqswKY2wvbTMt5O/1H/m30AVfMLDTqevanYNZDn
         9BeKqjEaaAGl9RSHM20NBWUmR/2fu2A587rB767kEk11sydkvydN6nSzISzBLA1w721M
         kn4rYszBhgwTBTDzH3TlOSg1Qm2ffpeM1A6wNRnYbgcPjy/2KKDidLVEozg5kz4Z9g8K
         5MuA==
X-Gm-Message-State: AFeK/H3B3n7f/kLQ4oPog9J/yZm0yYudUCnWub7euzRqunWcD0/96b53E2N3/t2atPPPPgbqi7OwEDNDTZQZ+OAq
X-Received: by 10.98.48.196 with SMTP id w187mr4557866pfw.179.1490292076258;
 Thu, 23 Mar 2017 11:01:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Thu, 23 Mar 2017 11:01:15 -0700 (PDT)
In-Reply-To: <1490266989.10080.6.camel@kaarsemaker.net>
References: <CAOc6etYTDyyRud9D3jubh7tC9MeyGZXONWM+=Kb+uwx0voSLpw@mail.gmail.com>
 <1490266989.10080.6.camel@kaarsemaker.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 23 Mar 2017 11:01:15 -0700
Message-ID: <CAGZ79kY0D6z=4=3QVkiQSqmVV9bvZpi9OUcpm+fe--q4prPC+g@mail.gmail.com>
Subject: Re: blame --line-porcelain is providing me with funny output
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 4:03 AM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On Wed, 2017-03-22 at 18:32 -0600, Edmundo Carmona Antoranz wrote:
>>
>> $ git blame --no-progress -w --line-porcelain -L 72,72
>> author-mail <somemail@gmail.com>
>>
>> $ git cat-file -p 3290fe6dd2a7e2bb35ac760443335dec58802ff1
>> author Stefan Beller <somemail@google.com> 1484160452 -0800
>>
>> Committer mails are matching, however author mail does not match
>> between line-porcelain and cat-file. Is there a reason for that?
>
> The commit object has Stefan's Google address, but git.git's  mailmap
> maps that to his gmail address.
>
> git blame actually does this mapping, where git cat-file does not.

Yes, I think the plumbing tools in general want to ignore the .mailmap file=
.

The committer (Junio) does use the email address, which is recorded as
his primary address in .mailmap as well, so no matter if the .mailmap file
is taken into account, it is the same email address.

Currently I contribute patches via the @google address, but the @gmail
address is marked as the primary address in the .mailmap file, such that
it depends whether the .mailmap file is taken into account which email
address is displayed.

So doesn't depend on the author or committer fields, but instead it
depends on the underlying data (.mailmap and recorded person for
author/committer).

For the exact mechanism of .mailmap look at "man git shortlog"
that has a section MAPPING AUTHORS), which states its effect,
but not the purpose of mapping persons:

    The .mailmap feature is used to coalesce together commits
    by the same person in the shortlog, where their name and/or
    email address was spelled differently.

One purpose could be to just fix data (i.e. misspelled name,
unconfigured repo; back then there were quite a few name=3D""
email=3D"root@localhost" commits).

Another aspect is to keep track of the same person at different
stages of life, e.g. when switching employers (or just email providers),
you may contribute from different email addresses and want to appear
as the same person in porcelain-viewed commits.
There are quite a few examples in the .mailmap file for different
email addresses.

One notable example is found in 94b410bba8 (.mailmap: Map
email addresses to names, 2013-07-12):

    While the most changes happen at the email addresses, we also have a
    name change in here. Karl Hasselstr=C3=B6m is now known as Karl Wiberg
    due to marriage. Congratulations!

Thanks,
Stefan
