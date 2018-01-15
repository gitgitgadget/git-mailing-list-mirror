Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8B8D1F406
	for <e@80x24.org>; Mon, 15 Jan 2018 14:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934300AbeAOOrg (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 09:47:36 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:45642 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754240AbeAOOrg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 09:47:36 -0500
Received: by mail-it0-f65.google.com with SMTP id x42so1115858ita.4
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 06:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kj8dP8uRWvjo054IBA9LpKhNwb4vumfHn0GyCvRY/RE=;
        b=N1f9Cz3wD7NZnL5XrRqVfSKrFy64go0D0dFu6ZlE2RFh59g1wW5o+TBq9ViiaDayJF
         Bal7RsO1EWQWGiqbvle2Ql59ujlfTtlNXfME08ZmYPRhDXItcuUXKXKANZiNsheUmCRy
         6w3Gmid0zAFcKR6vbbaF58CEh9tmuk0FDSzE1SOgkrfNqzb68kcJ/xUTOQ4vrC8yaBYd
         lT2iL1VNxXEUogolHnEo7vxxCxjMCOXomEDqrxhEweqvmaWp4smwKW9GHUkjagp9Cf/h
         wm3hNLmMaVk3mNK6ZvUVHpvUeVFbAjv+UJPD4BHdEbW57ooJOM4k93oVEFyIvZvfndLP
         t4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kj8dP8uRWvjo054IBA9LpKhNwb4vumfHn0GyCvRY/RE=;
        b=JfmADA64RRg9oq6L1aAZi8PkaK2EQCyOsDfPCwl38zfgtXpM3vjMHvH1RY+TkexKYi
         fJL9+GXVe0gW/gGGHGCn9zpWBvAviaxiCH7t3O5Y7hl6qjtufGnNMP7G38VpwWFm7gAe
         JH/hUKyPsUZaevu/BLTlKJEitFGOlnLPfCJdB8iviZS1Wdbm9+eAbs9JdId1sFbuI5p+
         GfzlRRb5URbFfnug47pyds8IaqGPuJ2dvDSAPr3+8Y2Eq/iu+krFGvze9M1FvCSgfuEC
         qNKZwfradVFVMi1OO6t2tIM+sMf6P5ImiSlt2q96QZDvXkrivOryHJ/k/kGQrbHPSdZo
         EJiA==
X-Gm-Message-State: AKwxytcCoJWN7U55GLxEv6Njlxqu+Cw2B8VcDX/ocs9HLMd4kN+yzVq2
        VdJpp6kkWhSlI/mgYilpnZV7bzPqMurnKWzJxGI=
X-Google-Smtp-Source: ACJfBov1uTumNFXAr60idVtHnwuDYkEcop5jAOYCOEEZ9ZfggZWXzPUGO+IIsDI2abOVYqM+ss5oPtgrKRetgLallAA=
X-Received: by 10.36.101.2 with SMTP id u2mr6884174itb.55.1516027655242; Mon,
 15 Jan 2018 06:47:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.79.141 with HTTP; Mon, 15 Jan 2018 06:47:34 -0800 (PST)
In-Reply-To: <4ce872c0-8f4b-602a-9ee3-cf429cc6a146@jeffhostetler.com>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
 <20180103163403.11303-11-chriscool@tuxfamily.org> <4ce872c0-8f4b-602a-9ee3-cf429cc6a146@jeffhostetler.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 15 Jan 2018 15:47:34 +0100
Message-ID: <CAP8UFD2MR_VCgFKVmLEaO989uM_AvX8_134PdoT=4MyJVPD1nA@mail.gmail.com>
Subject: Re: [PATCH 10/40] external-odb: implement external_odb_get_direct
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
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

On Thu, Jan 4, 2018 at 6:44 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
> On 1/3/2018 11:33 AM, Christian Couder wrote:
>>
>> This is implemented only in the promisor remote mode
>> for now by calling fetch_object().
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>   external-odb.c | 15 +++++++++++++++
>>   external-odb.h |  1 +
>>   odb-helper.c   | 13 +++++++++++++
>>   odb-helper.h   |  3 ++-
>>   4 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/external-odb.c b/external-odb.c
>> index d26e63d8b1..5d0afb9762 100644
>> --- a/external-odb.c
>> +++ b/external-odb.c
>> @@ -76,3 +76,18 @@ int external_odb_has_object(const unsigned char *sha1)
>>                         return 1;
>>         return 0;
>>   }
>> +
>> +int external_odb_get_direct(const unsigned char *sha1)
>> +{
>> +       struct odb_helper *o;
>> +
>> +       external_odb_init();
>> +
>> +       for (o = helpers; o; o = o->next) {
>> +               if (odb_helper_get_direct(o, sha1) < 0)
>> +                       continue;
>> +               return 0;
>
>> +     }
>
> Would this be simpler said as:
>         for (o = ...)
>                 if (!odb_helper_get_direct(...))
>                         return 0;

At then end of the series the content of the loop is:

        if (!(o->supported_capabilities & ODB_HELPER_CAP_GET_DIRECT))
            continue;
        if (odb_helper_get_direct(o, sha1) < 0)
            continue;
        return 0;

And I think it is fine like that, so I don't think changing this
commit is a good idea.

>> +       return -1;
>> +}
>> diff --git a/external-odb.h b/external-odb.h
>> index 9a3c2f01b3..fd6708163e 100644
>> --- a/external-odb.h
>> +++ b/external-odb.h
>> @@ -4,5 +4,6 @@
>>   extern int has_external_odb(void);
>>   extern const char *external_odb_root(void);
>>   extern int external_odb_has_object(const unsigned char *sha1);
>> +extern int external_odb_get_direct(const unsigned char *sha1);
>>     #endif /* EXTERNAL_ODB_H */
>> diff --git a/odb-helper.c b/odb-helper.c
>> index 1404393807..4b70b287af 100644
>> --- a/odb-helper.c
>> +++ b/odb-helper.c
>> @@ -4,6 +4,7 @@
>>   #include "odb-helper.h"
>>   #include "run-command.h"
>>   #include "sha1-lookup.h"
>> +#include "fetch-object.h"
>>     struct odb_helper *odb_helper_new(const char *name, int namelen)
>>   {
>> @@ -52,3 +53,15 @@ int odb_helper_has_object(struct odb_helper *o, const
>> unsigned char *sha1)
>>         return !!odb_helper_lookup(o, sha1);
>>   }
>>   +int odb_helper_get_direct(struct odb_helper *o,
>> +                         const unsigned char *sha1)
>> +{
>> +       int res = 0;
>> +       uint64_t start = getnanotime();
>> +
>> +       fetch_object(o->dealer, sha1);
>> +
>> +       trace_performance_since(start, "odb_helper_get_direct");
>> +
>> +       return res;
>
>
> 'res' will always be 0, so the external_odb_get_direct() will
> only do the first helper.  i haven't looked at the rest of the
> series yet, so maybe you've already addressed this.

That's why I previously suggested in one of your or Jonathan's patch
that fetch_object() should return an int that tells the caller if the
object has been fetched instead of void.

If we make it possible at one point to have the objects fetched
fetch_object() in different remotes (and I think that's a
straightforward goal), this will actually fail but callers will have
no simple way to know that.

> Also, I put a TODO comment in the fetch_object() header to
> consider returning an error/success, so maybe that could help
> here too.

Yeah, indeed.
