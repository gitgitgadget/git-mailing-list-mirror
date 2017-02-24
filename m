Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 104BC201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 20:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbdBXUGT (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 15:06:19 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:33857 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbdBXUGR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 15:06:17 -0500
Received: by mail-qt0-f173.google.com with SMTP id n21so25621784qta.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 12:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=afZXDOpVbUrEcxmNNCBEVa+Rv9F5psPCSBEWpbS9AuU=;
        b=SEO+g74t/hibCQT8XtgQHogS9yhzSPcgEJhgWpK5xhvWrOhia4dD8EsZ2PHN/o4ve0
         uheqp0yX1UDhVHvFqFtwa8u7cbNbqWGrKfmFj2JfE4IXNcQrUZYjNfKt3dQDvRybFHpH
         QTVZZlx40wWRm/Y+kSaXTvoLOr5phS+lCOrMw+pddLdmk5Wq4GU9LmhWiypm6srKl8kV
         3op/Bpl8qMxOWP214jU3bKUJeWmpgXTtrcXCXiofz+y+OC4aQUliYYJVYpMaBs6R6K1o
         8bEfehgCaBaBkLXRda+yqtn+K0azU8/ZECYuT7XI6Sr9yLv2y6vAdYm1xVEzGqZJ5BaE
         O6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=afZXDOpVbUrEcxmNNCBEVa+Rv9F5psPCSBEWpbS9AuU=;
        b=plNk0ls6kDQtaQlPXlI9BhtPKpFh4Crypsgcm28pmDnu2zAm/YuLBSomUbDOAD5nZ2
         kix0chdGSlMxwsD31iwRcCibRZhonWOM9QCX1Hgu2qjZR8fxTZ8qzf6WyZD7PazGo8nu
         133w3aDCUsyt+yjUbvYN+FdcfTtoBLWEcFyWxeEGCWMutMWFOdbLJNxnJVSvwqawE+Cn
         wyBxxDQjW3jcjfifnZlAOwbjVno0cdUz1NSU4LSOnlh07fWHHEiY0wzqEB8mSCJpj8AX
         fjrEoANqi/39BpIGnzNJrVVZRTSiz/ItZBuMHmbCkgjgpny5o4ndi4ZY4vMRnRDQ7uGz
         AR0g==
X-Gm-Message-State: AMke39lrKx1BOT9lXd3idX5180ib6o8NOnEU+l1z+qgfHPSPAhn6jVXmMVzz6dkhNf/5VliFRa9Sph9cqSwYig==
X-Received: by 10.237.57.164 with SMTP id m33mr3486773qte.293.1487966770962;
 Fri, 24 Feb 2017 12:06:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.218 with HTTP; Fri, 24 Feb 2017 12:05:40 -0800 (PST)
In-Reply-To: <xmqq7f4f4cqg.fsf@gitster.mtv.corp.google.com>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <nycvar.QRO.7.75.62.1702240943540.6590@qynat-yncgbc>
 <xmqqk28f4fti.fsf@gitster.mtv.corp.google.com> <CAGZ79kaZWe-8pMZnQv7uZtr8wXWawFeJjUa68-b0oa4yFo-HcA@mail.gmail.com>
 <xmqq7f4f4cqg.fsf@gitster.mtv.corp.google.com>
From:   ankostis <ankostis@gmail.com>
Date:   Fri, 24 Feb 2017 21:05:40 +0100
Message-ID: <CA+dhYEVOyACM9ARP2deKVLm1hHOVsTah1WfGoNzGGKO6CGrQpw@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, David Lang <david@lang.hm>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24 February 2017 at 20:20, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Fri, Feb 24, 2017 at 10:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> you are inviting people to start using
>>>
>>>     md5,54ddf8d47340e048166c45f439ce65fd
>>>
>>> as object names.
>>
>> which might even be okay for specific subsets of operations.
>> (e.g. all local work including staging things, making local "fixup" commits)
>>
>> The addressing scheme should not be too hardcoded, we should rather
>> treat it similar to the cipher schemes in pgp. The additional complexity that
>> we have is the longevity of existence of things, though.
>
> The not-so-well-hidden agenda was exactly that we _SHOULD_ not
> mimick PGP.  They do not have a requirement to encourage everybody
> to use the same thing because each message is encrypted/signed
> independently, i.e. they do not have to chain things like we do.

But there is a scenario where supporting more hashes, in parallel, is
beneficial:

Let's assume that git is retroffited to always support the "default"
SHA-3, but support additionally more hash-funcs.
If in the future SHA-3 also gets defeated, it would be highly unlikely
that the same math would also break e.g. Blake.
So certain high-profile repos might choose for extra security 2 or more hashes.

Apologies if I'm misusing the list,
  Kostis
