Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B42D81F516
	for <e@80x24.org>; Sat, 23 Jun 2018 12:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeFWMPM (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Jun 2018 08:15:12 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39271 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbeFWMPK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jun 2018 08:15:10 -0400
Received: by mail-io0-f195.google.com with SMTP id f1-v6so8434393ioh.6
        for <git@vger.kernel.org>; Sat, 23 Jun 2018 05:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NYJfK8oVaixtVLVu+tfGrBXrsyvsz9s+dJ7+evg8P3c=;
        b=LbyeRWi5zvurGpKrJD+IiwCVFcRTScJ/1ijfWoHQmUzVycYqGmu6wAZOwbYkI5loK5
         4CIUIMXkmrOJtqNXokw7YJoJAJmmrAn90EIgmG5Xz9tFbWkQUBbJI7TfMoryLeQg4gGl
         sQwFbtROfFZwz6qHRXhKJZKPnG/YGbmhQinBrRd7aDy8UwZb5cdaYHtcDNQnOFErxLFS
         0heuA6qZgGMQEwXh9NNAJ2Ps+7sk5s6CNpEKVmbxvs9ZFG2XGLlpFAxbsJBEzeEs4p5D
         JQAU3czjo8raCxblPZU43rQFYmJGGnJKKPkAzH4ON6w1vOhY3dHOJdz4r2UwaGwuBX5+
         ZnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NYJfK8oVaixtVLVu+tfGrBXrsyvsz9s+dJ7+evg8P3c=;
        b=ICALhOw+AgaFffoPYf3iLabhMjHC0AJgdRPIdsFUFjdZCqqnd2fLDMdl02lksOVqEd
         tHeZ+/AdkR4s3ry1d+Bv7ZfFygXVonOV7/EurQgZhYB/dL1o5ktQ2m5Gw3ARiqLuAQOa
         qYMNNysLw1y0CBsDNdZ0gg84AUZU5W9R53/u0qyhUjtYuX6B5h/jPv8Q7QfUg2HxLSlq
         CbQMQtO3t1HYp9jKnNPhiKHDIj2hjLdFKlg7jZ21z49WU34KJ5Msq+JEzXNuawljIq7E
         GxHAMm1ms387xk0h8hVDszWKcAzlKgPYrXDGOWe5w+LCeN/2e6stEAygWag93m0YBc6m
         zgfQ==
X-Gm-Message-State: APt69E0rvKfbvxzLDUyQNZl/e6dBRaUgqNYS53dxDOMIWT8jTCVH5Hh6
        QkybMQmxOJCFgKv7W+4kaQCh+x9eSShBeJpD1DM=
X-Google-Smtp-Source: AAOMgpftQEX1yxCDmQYYzeWW24sg7siNmgbMwjFEjtsORhIWyIr8x3tXthKPe94mFRyGqEIyXKSG6TyVqRvM658vlL0=
X-Received: by 2002:a6b:d00c:: with SMTP id x12-v6mr4397406ioa.5.1529756110150;
 Sat, 23 Jun 2018 05:15:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22d0:0:0:0:0:0 with HTTP; Sat, 23 Jun 2018 05:15:09
 -0700 (PDT)
In-Reply-To: <xmqqh8n9ae17.fsf@gitster-ct.c.googlers.com>
References: <20180513103232.17514-1-chriscool@tuxfamily.org>
 <20180513103232.17514-3-chriscool@tuxfamily.org> <xmqqh8n9ae17.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 23 Jun 2018 14:15:09 +0200
Message-ID: <CAP8UFD3kMQxiViL4sUPMjmJHxVkobmTdpJ+=G827hVhPwaxarg@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] Add initial odb remote support
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 15, 2018 at 3:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:

>> --- /dev/null
>> +++ b/odb-helper.h
>> @@ -0,0 +1,13 @@
>> +#ifndef ODB_HELPER_H
>> +#define ODB_HELPER_H
>
> Here is a good space to write a comment on what this structure and
> its fields are about.  Who are the dealers of helpers anyway?

Ok I added a few comments and renamed "dealer" to "remote".

>> +static struct odb_helper *helpers;
>> +static struct odb_helper **helpers_tail = &helpers;
>> +
>> +static struct odb_helper *find_or_create_helper(const char *name, int len)
>> +{
>> +     struct odb_helper *o;
>> +
>> +     for (o = helpers; o; o = o->next)
>> +             if (!strncmp(o->name, name, len) && !o->name[len])
>> +                     return o;
>> +
>> +     o = odb_helper_new(name, len);
>> +     *helpers_tail = o;
>> +     helpers_tail = &o->next;
>> +
>> +     return o;
>> +}
>
> This is a tangent, but I wonder if we can do better than
> hand-rolling these singly-linked list of custom structure types
> every time we add new code.  I am just guessing (because it is not
> described in the log message) that the expectation is to have only
> just a handful of helpers so looking for a helper by name is OK at
> O(n), as long as we very infrequently look up a helper by name.

Yeah, I think there will be very few helpers. I added a comment in the
version I will send really soon now.

>> +     if (!strcmp(subkey, "promisorremote"))
>> +             return git_config_string(&o->dealer, var, value);
>
> If the field is meant to record the name of the promisor remote,
> then it is better to name it as such, no?

Yeah, it is renamed "remote" now.

>> +     for (o = helpers; o; o = o->next)
>> +             if (!strcmp(o->dealer, dealer))
>> +                     return o;
>
> The code to create a new helper tried to avoid creating a helper
> with duplicated name, but nobody tries to create more than one
> helpers that point at the same promisor remote.  Yet here we try to
> grab the first one that happens to point at the given promisor.
>
> That somehow smells wrong.

For each promisor remote I think it makes no sense to have more than
one remote odb pointing to it. So I am not sure what to do here.
