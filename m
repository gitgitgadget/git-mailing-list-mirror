Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA1DC1F454
	for <e@80x24.org>; Tue, 25 Sep 2018 08:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeIYONk (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 10:13:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36375 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbeIYONk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 10:13:40 -0400
Received: by mail-io1-f65.google.com with SMTP id q5-v6so19759225iop.3
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 01:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H0lbTztgX3VdLA63Q3KLzWoSsOcRg7JY7EZD6OMxJg0=;
        b=Dys7lhMO15W2UiII89gpavVMERzKdaIM+o6Yab/1jgfKRa1Z7hdP0Joyz6vVVVIpJZ
         jRmOaNngkuZKC3gRCAEE30yJSm71lzglospc5INUKsIsWbUSLEi6eBr+jvlBWyo0cQg5
         DMRXJ2IPzn4wXOoIc4+7z9Ubqcpv6qMAT7Ewl/zgaGttVJmjkF+yN+Ywz7qGObClzr25
         FVqFyUsyoDzU6Gwj5JdI/G43xZaDirYx8iQB7f0wVvBUkN1XDYope9gLuUke29Ck2i2T
         6zw1KbvlCGowcOIO7vsCJGKuVk80zHWz9FO0ymD0nehvFU0s7B8y6Y6vkISFnMga/cx/
         S7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H0lbTztgX3VdLA63Q3KLzWoSsOcRg7JY7EZD6OMxJg0=;
        b=DU823JYDQ6n8ZI1O6kQo+TKkGTtmpDeCLvQMu/ISUV0ZsMuKVnlN5nmvFriRrvQtUw
         5igCRFdt+9AQxQGUSRrfFcMOyjowNUu/TtHUqGjDjPW4h9wiDX5Oghx7j3LxIg1erO4E
         Im/PF7gOjX2HVrl9BHFkp9bqmvpoY/bNk51maHTPPdjJhThkDIkx0U20uXLKOy7TAJhc
         6LUOvKDuwy52V1/K4+49pboKe5tR0CY4hF7fIou7PSJdWClZRFZ0xGFYdBmlRsj/0ORn
         CglPRZ30r83EnTlcd+nePdWaxNeff09IGD0awQQlj8HAgcqZT/zQ2oPBbzITHReOvUOj
         FHCg==
X-Gm-Message-State: ABuFfohgidOZd1PNH0UK9HpAmR5ULhhlooPjnm3eix12bnTbsHpYTo6w
        daBkFTj+M9glEwV9blAkr9rgtM2SoJh9RVjm094=
X-Google-Smtp-Source: ACcGV617OCVEF89h0pDG4UvlQcNpw3e/+Ek8lb6pqbKoCLGkiLQoQQE3HNz7JhlvOAj8d0whMYiwB3TtzDNa5AMfNto=
X-Received: by 2002:a6b:b80a:: with SMTP id i10-v6mr2036941iof.5.1537862838887;
 Tue, 25 Sep 2018 01:07:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22d2:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 01:07:18
 -0700 (PDT)
In-Reply-To: <CAGZ79kYPik87zvLUPPKFzcATFUdBFcXrAkTYxpxvAQy6w1CcUw@mail.gmail.com>
References: <20180802061505.2983-1-chriscool@tuxfamily.org>
 <20180802061505.2983-10-chriscool@tuxfamily.org> <CAGZ79kYPik87zvLUPPKFzcATFUdBFcXrAkTYxpxvAQy6w1CcUw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 25 Sep 2018 10:07:18 +0200
Message-ID: <CAP8UFD1ia1xWk9pjfTUQ3zD7=dP=8UjKzf=G0ptsz=qRH8_X+Q@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] Documentation/config: add odb.<name>.promisorRemote
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>, Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 3, 2018 at 12:55 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Aug 1, 2018 at 11:16 PM Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> From: Christian Couder <christian.couder@gmail.com>
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  Documentation/config.txt | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 43b2de7b5f..2d048d47f2 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -2513,6 +2513,11 @@ This setting can be overridden with the `GIT_NOTES_REWRITE_REF`
>>  environment variable, which must be a colon separated list of refs or
>>  globs.
>>
>> +odb.<name>.promisorRemote::
>> +       The name of a promisor remote. For now promisor remotes are
>> +       the only kind of remote object database (odb) that is
>> +       supported.
>> +
>
> Can you explain the end goal for this? (I did not find it in the cover letter,
> nor do I make sense of this documentation)

First thank you for (re)opening this discussion, as I think it may
help resolve the issues related to my work.

In the cover letter there is a "Discussion" section which is about
this, but I agree that it might not be very clear.

The main issue that this patch series tries to solve is that
extensions.partialclone config option limits the partial clone and
promisor features to only one remote. One related issue is that it
also prevents to have other kind of promisor/partial clone/odb
remotes. By other kind I mean remotes that would not necessarily be
git repos, but that could store objects (that's where ODB, for Object
DataBase, comes from) and could provide those objects to Git through a
helper (or driver) script or program.

For reference I tried to raise these issues (especially the first one)
at least twice before extensions.partialclone was merged:

https://public-inbox.org/git/CAP8UFD3Jt+0Lq9Yx_7x3sJD+jG+A25bAgDg7zp+dZV43+1-vow@mail.gmail.com/
https://public-inbox.org/git/CAP8UFD0P7kVo2NP4Wq7OaSV4H1+sqHapuzW5AQef+enNS0S5hw@mail.gmail.com/

but it was still merged as is.

(So of course now it's not surprising that my work on this patch
series keeps conflicting with work that is still going on promisors
and partial clone, and unfortunately the result is that my work keeps
being ejected from pu when it can reach it.)

> So from what I understand, this series relates to partialClone, which
> has the remote name of the "promisor" in extensions.partialclone.
> That is the remote to contact for any needs w.r.t. partial clone and
> fetching on demand.

Yes.

> This key "odb.<name1>.promisorRemote = <name2>" introduces
> 2 new names, where do each of these two names hook in?
> name2 is a remote, such as "origin" from what I can tell, but
> which naming scheme does name1 follow here?

There is just one new name. Instead of:

  extensions.partialclone = <remote name>

there is:

  odb.<remote odb name>.promisorRemote = <remote name>

So it is now like:

  remote.<remote name>.url = <remote url>

which we use for remote repositories.

And it enables us to:

  - have more than one promisor remote
  - specify different parameters for each promisor remote
  - make it possible later to have other kind of promisor/odb remotes

It also restores the distributed nature of Git which was kind of
broken for promisor remotes.

> What makes the odb key different, in that the partial clone
> feature only handles objects as well?

I am not sure I understand this question. Anyway if we want more than
one promisor remote, we need to be able to specify different
parameters for each promisor remote. For example now
core.partialclonefilter is used to specify some filters for the
promisor remote, but how can we nicely specify different partial clone
filters if we have more than one promisor remote?

With the changes in this patch series core.partialclonefilter is
replaced with odb.<remote odb name>.partialclonefilter, so that
parameters for a remote odb are properly grouped together in the
section where the remote odb is defined.

One alternative scheme could be for example to have:

  remote.<remote name>.promisor = (true|false)

or maybe:

  remote.<remote name>.partialclone = (true|false)

instead of:

  extensions.partialclone = <remote name>

And then we could also have:

  remote.<remote name>.partialclonefilter = <partial clone filter>

The issue with this scheme is that it kind of overloads the
"remote.<remote name>.*" namespace for something that can be seen as
different especially if, as I want to do it later, we are going to
have other kind of promisor/odb remotes.

I plan to send a V5 of this patch series really soon now, where I will
try to explain better the end goal.
